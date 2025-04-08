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
-- ============================================================================

DELIMITER $$

CREATE PROCEDURE buy_specific_ticket(   
    IN in_buyer_id INT,
    IN in_resale_id INT
)
BEGIN

    DECLARE ticket_id_var INT;
    DECLARE current_visitor_id INT;

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

INSERT INTO Buys_specific_ticket(buyer_id, resale_id, interest_date, status)
VALUES 
(in_buyer_id, in_resale_id, NOW(), 'completed');

/*Delete the item from the resale queue*/
DELETE FROM Resale_Queue
WHERE resale_id = in_resale_id;



END$$

DELIMITER ;