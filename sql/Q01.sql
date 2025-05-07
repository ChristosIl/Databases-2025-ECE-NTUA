-- Query 1 -- 
SELECT 
    f.name AS festival_name,
    f.year AS festival_year,
    pm.name AS payment_method,
    tt.name AS ticket_type,
    SUM(t.price) AS total_revenue
FROM Ticket t 
JOIN Event e ON t.event_id = e.event_id
JOIN Festival f ON e.festival_id = f.festival_id
LEFT JOIN Payment_method pm ON pm.payment_method_id = t.payment_method_id
LEFT JOIN Ticket_type tt ON tt.ticket_type_id = t.ticket_type_id
GROUP BY f.festival_id, f.name, f.year, pm.name, tt.name
ORDER BY f.year, f.name, pm.name, tt.name