-- Query 9 --
WITH count_of_valid_visits_per_visitor_for_specific_year
AS (
SELECT 
    v.visitor_id, v.name, 
    COUNT(*) AS Number_of_valid_visits_per_year
FROM Visitor v 
JOIN Ticket t ON t.visitor_id = v.visitor_id
JOIN Event e ON e.event_id = t.event_id
WHERE t.used = TRUE and YEAR(e.event_date) = 2025 
GROUP BY v.visitor_id, v.name  
ORDER BY Number_of_valid_visits_per_year
)

SELECT 
    GROUP_CONCAT(name ORDER BY name SEPARATOR ', ') AS Visitors,
    Number_of_valid_visits_per_year
FROM count_of_valid_visits_per_visitor_for_specific_year
WHERE Number_of_valid_visits_per_year > 3
GROUP BY Number_of_valid_visits_per_year
ORDER BY Number_of_valid_visits_per_year DESC ;
