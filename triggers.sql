DELIMETER //

CREATE TRIGGER trg_check_vip_tickets
BEFORE INSERT ON Ticket
FOR EACH ROW
BEGIN
    DECLARE vip_limit INT;
    DECLARE current_vip_tickets INT;
    DECLARE stage_capacity INT;

    IF NEW.ticket_type_id = 1 THEN 

        /*getting the stage_id from the event_id of the ticket*/
            SELECT stage_id INTO @stage_id
            FROM Event
            WHERE event_id = NEW.event_id;

        /*getting the max_capacity from the stage*/
            SELECT max_capacity INTO stage_capacity
            FROM Stage
            WHERE stage_id = @stage_id;

        /*Calculate the current vip tickets*/
        SELECT COUNT(*) INTO current_vip_tickets 
        FROM Ticket t
        JOIN Event e ON t.event_id = e.event_id
        WHERE t.ticket_type_id = 1 
        AND e.stage_id = @stage_id;

        /*floor makes the number integer*/
        SET vip_limit = FLOOR(stage_capacity * 0.10);
        

        IF current_vip_tickets >= vip_limit THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'VIP tickets for this stage have reached the 10% limitation'
        END IF;
    END IF;
END;

DELIMETER ;






