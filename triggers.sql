DELIMITER //

/*Trigger that checks the limit of VIP tickets for a stage*/
CREATE TRIGGER trg_check_vip_tickets
BEFORE INSERT ON Ticket
FOR EACH ROW
BEGIN
    DECLARE vip_limit INT;
    DECLARE current_vip_tickets INT;
    DECLARE stage_capacity INT;
    DECLARE stage_id INT;

    IF NEW.ticket_type_id = 1 THEN 

        -- Get the stage_id from the event
        SELECT e.stage_id INTO stage_id
        FROM Event e
        WHERE e.event_id = NEW.event_id;

        -- Get the max capacity of the stage
        SELECT s.max_capacity INTO stage_capacity
        FROM Stage s
        WHERE s.stage_id = stage_id;

        -- Count current VIP tickets for that stage
        SELECT COUNT(*) INTO current_vip_tickets
        FROM Ticket t
        JOIN Event e ON t.event_id = e.event_id
        WHERE t.ticket_type_id = 1
        AND e.stage_id = stage_id;

        -- Calculate 10% VIP limit
        SET vip_limit = FLOOR(stage_capacity * 0.10);

        -- If current VIP tickets exceed or hit the limit, block insert
        IF current_vip_tickets >= vip_limit THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'VIP tickets for this stage have reached the 10% limitation';
        END IF;

    END IF;
END;
//


/*Trigger that blocks inserts to Resale queue if the event is not sold out  */
CREATE TRIGGER trg_resale_queue_opens
BEFORE INSERT ON Resale_Queue
FOR EACH ROW
BEGIN 

    DECLARE current_count INT;
    DECLARE max_capacity INT;
    DECLARE event_id_for_ticket INT;

/*Get event id from ticket*/
SELECT event_id INTO event_id_for_ticket
FROM Ticket
WHERE ticket_id = NEW.ticket_id;

/*Count how many tickets have been sold for specific event*/
SELECT COUNT(*) INTO current_count
FROM Ticket 
WHERE event_id = event_id_for_ticket;

/*Load Capacity of stage that is connected to the event*/
SELECT s.max_capacity INTO max_capacity
FROM Event e
JOIN Stage s ON e.stage_id = s.stage_id
WHERE e.event_id = event_id_for_ticket;

/*Check if you can activate resale queue*/
IF current_count < max_capacity THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Resale queue is not available. Event not sold out yet.';
END IF;


END;

//


CREATE TRIGGER trg_after_resale_insert
AFTER INSERT ON Resale_Queue
FOR EACH ROW
BEGIN
    DECLARE v_demand_id INT;
    DECLARE v_buyer_id INT;
    DECLARE ticket_count INT;
    DECLARE new_visitor_id INT;

    /* Βρες matching demand (με βάση event και ticket type)*/
    SELECT dq.demand_id, dq.buyer_id
    INTO v_demand_id, v_buyer_id
    FROM Demand_Queue dq
    JOIN Ticket t ON t.ticket_id = NEW.ticket_id
    WHERE dq.preferred_event_id = t.event_id
      AND dq.preferred_ticket_type = t.ticket_type_id
      AND dq.status = FALSE
    LIMIT 1;

    /*Αν υπάρχει matching demand*/
    IF v_demand_id IS NOT NULL THEN

        /*Count how many tickets the seller owns*/
        SELECT COUNT(*) INTO ticket_count
        FROM Ticket
        WHERE visitor_id = NEW.seller_id;

        IF ticket_count > 1 THEN
             /*Create new visitor from Resale_Buyer info*/
            INSERT INTO Visitor (name, surname, age, email, phone_number, photo_url, photo_description)
            SELECT name, surname, age, email, phone_number, photo_url, photo_description
            FROM Resale_Buyer
            WHERE buyer_id = v_buyer_id;


            /*Get the new visitor_id*/
            SET new_visitor_id = LAST_INSERT_ID();

             /*Reassign ticket to new visitor*/
            UPDATE Ticket
            SET visitor_id = new_visitor_id
            WHERE ticket_id = NEW.ticket_id;
        ELSE
            /* Κάνε update τα στοιχεία του επισκέπτη με του αγοραστή*/
            UPDATE Visitor
            JOIN Resale_Buyer rb ON rb.buyer_id = v_buyer_id
            SET 
                Visitor.name = rb.name,
                Visitor.surname = rb.surname,
                Visitor.age = rb.age,
                Visitor.email = rb.email,
                Visitor.phone_number = rb.phone_number,
                Visitor.photo_url = rb.photo_url,
                Visitor.photo_description = rb.photo_description
            WHERE Visitor.visitor_id = NEW.seller_id;
        END IF;

        /*Καταγραφή στο log*/
        INSERT INTO Resale_Log (ticket_id, old_owner_id, new_owner_id, sale_price)
        VALUES (
            NEW.ticket_id,
            NEW.seller_id,
            IF(ticket_count > 1, new_visitor_id, v_buyer_id),
            NEW.price
        );

        /*Σβήσε τις εγγραφές από queues*/
        /*ΔΕΝ ΜΠΟΡΕΙΣ ΝΑ ΚΑΝΕΙΣ UPDATE ΤΟ TABLE ΠΟΥ ΧΡΗΣΙΜΟΠΟΙΕΙ ΤΟ TRIGGER ΟΤΑΝ ΚΑΛΕΙΤΑΙ*/
        /*UPDATE Resale_Queue SET status = TRUE WHERE resale_id = NEW.resale_id;*/
        UPDATE Demand_Queue SET status = TRUE WHERE demand_id = v_demand_id;
        DELETE FROM Resale_Buyer WHERE buyer_id = v_buyer_id;
    END IF;

END;

//

CREATE TRIGGER trg_after_demand_queue_insert
AFTER INSERT ON Demand_Queue
FOR EACH ROW
BEGIN 
    DECLARE v_resale_id INT;
    DECLARE v_seller_id INT;
    DECLARE ticket_count INT;
    DECLARE new_visitor_id INT;
    DECLARE v_ticket_id INT;
    DECLARE v_event_id INT;
    DECLARE v_ticket_type INT;
    DECLARE resale_price FLOAT;

    /*Matching*/
    SELECT rq.resale_id, rq.seller_id, rq.ticket_id, rq.price
    INTO v_resale_id, v_seller_id, v_ticket_id, resale_price
    FROM Resale_Queue rq
    JOIN Ticket t ON t.ticket_id = rq.ticket_id
    WHERE t.event_id = NEW.preferred_event_id
      AND t.ticket_type_id = NEW.preferred_ticket_type
      AND rq.status = FALSE
    LIMIT 1;

    IF v_resale_id IS NOT NULL THEN 

        /*Count how many tickets the seller owns*/
        SELECT COUNT(*) INTO ticket_count
        FROM Ticket
        WHERE visitor_id = v_seller_id;

        IF ticket_count > 1 THEN 
             /*Create new visitor from Resale_Buyer info*/
            INSERT INTO Visitor (name, surname, age, email, phone_number, photo_url, photo_description)
            SELECT name, surname, age, email, phone_number, photo_url, photo_description
            FROM Resale_Buyer
            WHERE buyer_id = NEW.buyer_id;

            /*Get the latest visitor id to use it on the ticket*/
            SET new_visitor_id = LAST_INSERT_ID();

            UPDATE Ticket
            SET visitor_id = new_visitor_id
            WHERE ticket_id = v_ticket_id;
        
        ELSE  /*Update infos about visitor*/
            UPDATE Visitor
            JOIN Resale_Buyer rb ON rb.buyer_id = NEW.buyer_id
            SET 
                Visitor.name = rb.name,
                Visitor.surname = rb.surname,
                Visitor.age = rb.age,
                Visitor.email = rb.email,
                Visitor.phone_number = rb.phone_number,
                Visitor.photo_url = rb.photo_url,
                Visitor.photo_description = rb.photo_description
            WHERE Visitor.visitor_id = v_seller_id;
        END IF;

        INSERT INTO Resale_Log (ticket_id, old_owner_id, new_owner_id, sale_price)
        VALUES (
            v_ticket_id,
            v_seller_id,
            IF(ticket_count > 1, new_visitor_id, NEW.buyer_id),
            resale_price

        );

        
        /*Σβήσε τις εγγραφές από queues*/
        /*ΔΕΝ ΜΠΟΡΕΙΣ ΝΑ ΚΑΝΕΙΣ UPDATE ΤΟ TABLE ΠΟΥ ΧΡΗΣΙΜΟΠΟΙΕΙ ΤΟ TRIGGER ΟΤΑΝ ΚΑΛΕΙΤΑΙ
        ΘΑ ΔΟΚΙΜΑΣΩ ΜΕ BEFORE ΚΑΙ NEW.status := TRUE
        */
        UPDATE Resale_Queue SET status = TRUE WHERE resale_id = v_resale_id;
        DELETE FROM Resale_Buyer WHERE buyer_id = NEW.buyer_id;

    END IF;


END;

//

DELIMITER ;

/* All seem to work. Check the status in resale and demand queue tables */