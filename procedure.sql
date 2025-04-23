-- ============================================================================
-- Procedure: buy_specific_ticket
-- Description:
--     Handles the direct purchase of a specific resale ticket by a buyer.
--     The procedure performs the following steps:
--       1. Retrieves the ticket associated with the given resale ID.
--       2. Updates the current ticket owner (Visitor) with the buyer's information.
--       3. Records the purchase in the Buys_specific_ticket log table.
--       4. Deletes the resale entry from the Resale_Queue.
--     This procedure assumes that resale_id exists before calling and that
--     no foreign key is enforced on resale_id in the log table to allow deletion.
-- Parameters:
--     IN in_buyer_id     INT     → The buyer's ID (from Resale_Buyer table).
--     IN in_resale_id    INT     → The resale entry ID (from Resale_Queue table).

--      CALL buy_specific_ticket(<buyer_id>, <resale_id>);
-- ============================================================================

DELIMITER $$

CREATE PROCEDURE buy_specific_ticket(   
    IN in_buyer_id INT,
    IN in_resale_id INT
)
BEGIN

    DECLARE ticket_id_var INT;
    DECLARE current_visitor_id INT;
    DECLARE ticket_count INT;
    DECLARE new_visitor_id INT;
/*Find ticket id from resale queue*/
SELECT ticket_id
INTO ticket_id_var
FROM Resale_Queue
WHERE resale_id = in_resale_id;

/*Find visitor from the ticket*/
SELECT visitor_id
INTO current_visitor_id
FROM Ticket    
WHERE ticket_id = ticket_id_var;

/*Count how many tickets the seller owns*/
SELECT COUNT(*) INTO ticket_count
FROM Ticket
WHERE visitor_id = current_visitor_id;

IF ticket_count > 1 THEN
    /*Create new visitor*/
    
    INSERT INTO Visitor (name, surname, age, email, phone_number, photo_url, photo_description)
    SELECT name, surname, age, email, phone_number, photo_url, photo_description
    FROM Resale_Buyer
    WHERE buyer_id = in_buyer_id;

    SET new_visitor_id = LAST_INSERT_ID();

    UPDATE Ticket
    SET visitor_id = new_visitor_id
    WHERE ticket_id = ticket_id_var;

ELSE
    /*Set the buyer's values to visitor's values (change buyer with visitor)*/
    UPDATE Visitor
    SET
    name = (SELECT name FROM Resale_Buyer WHERE buyer_id = in_buyer_id),
    surname = (SELECT surname FROM Resale_Buyer WHERE buyer_id = in_buyer_id),
    age = (SELECT age FROM Resale_Buyer WHERE buyer_id = in_buyer_id),
    email = (SELECT email FROM Resale_Buyer WHERE buyer_id = in_buyer_id),
    phone_number = (SELECT phone_number FROM Resale_Buyer WHERE buyer_id = in_buyer_id),
    photo_url = (SELECT photo_url FROM Resale_Buyer WHERE buyer_id = in_buyer_id),
    photo_description = (SELECT photo_description FROM Resale_Buyer WHERE buyer_id = in_buyer_id)
    WHERE visitor_id = current_visitor_id;
END IF;

/*Logging the transaction*/
INSERT INTO Buys_specific_ticket(buyer_id, resale_id, interest_date, status)
VALUES 
(in_buyer_id, in_resale_id, NOW(), 'completed');

/*Delete the item from the resale queue*/
DELETE FROM Resale_Queue
WHERE resale_id = in_resale_id;
DELETE FROM Resale_Buyer
WHERE buyer_id = in_buyer_id;


END$$

--============================================
--Procedure to insert data into Works_On Table
--
--============================================
DELIMITER $$

CREATE PROCEDURE Insert_Staff_Assignment (
    IN in_staff_id INT,
    IN in_stage_id INT,
    IN in_event_id INT
)
BEGIN
    -- Check if assignment already exists
    IF EXISTS (
        SELECT 1 FROM Works_on
        WHERE staff_id = in_staff_id AND stage_id = in_stage_id AND event_id = in_event_id
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Η ανάθεση υπάρχει ήδη.';
    ELSE
        INSERT INTO Works_on (staff_id, stage_id, event_id)
        VALUES (in_staff_id, in_stage_id, in_event_id);
    END IF;
END $$

DELIMITER ;