-- Query 1 -- 
SELECT 
    f.name AS FESTIVAL,
    f.year AS festival_year,
    pm.name AS Payment_method,
    tt.name AS Ticket_type,
    SUM(t.price) AS Total_Revenue
FROM Ticket t 
JOIN Event e ON t.event_id = e.event_id
JOIN Festival f ON e.festival_id = f.festival_id
JOIN Payment_method pm ON pm.payment_method_id = t.payment_method_id
JOIN Ticket_type tt ON tt.ticket_type_id = t.ticket_type_id
GROUP BY f.year, pm.name, tt.name
ORDER BY f.year, pm.name, tt.name;