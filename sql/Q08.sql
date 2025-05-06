-- Query 8 -- 
-- We chose to present all the support staff and who are available the required date --

SELECT 
    s.staff_id, 
    s.name,
    CASE 
        WHEN s.staff_id NOT IN (
            SELECT w.staff_id
            FROM Works_on w
            JOIN Event e ON w.event_id = e.event_id
            WHERE e.event_date = '2025-07-12' /* Required Date*/
        ) THEN 'YES'
        ELSE 'NO'
    END AS available_on_the_Date_we_asked
FROM Staff s
WHERE s.staff_role_id = 3;
