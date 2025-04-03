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

SELECT COUNT(*) INTO current_count
FROM Ticket 
WHERE event_id = NEW.preferred_event_id;

SELECT s.max_capacity INTO max_capacity
FROM Event e
JOIN Stage s ON e.stage_id = s.stage_id
WHERE e.event_id = NEW.preferred_event_id;

IF current_count < max_capacity THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Resale queue is not available. Event not sold out yet.';
END IF;


END;

//
DELIMITER ;

/* Both look to work */