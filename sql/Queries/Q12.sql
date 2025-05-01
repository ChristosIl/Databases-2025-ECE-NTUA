-- Query 12 --

-- Subquery that calculates the required number of staff for each stage and role at every event of the 2025 festival --
-- Based on the stage's capacity and assignment's rule (0.05% for support staff and 0.02% for security) --
WITH Staff_Needs AS (
    SELECT
        e.event_id,
        e.event_date,
        s.stage_id,
        s.name AS stage_name,
        r.staff_role_id,
        r.name AS role_name,
        CASE 
            WHEN r.staff_role_id = 2 THEN ROUND(s.max_capacity * 0.05, 0) 
            WHEN r.staff_role_id = 3 THEN ROUND(s.max_capacity * 0.02, 0) 
            WHEN r.staff_role_id = 1 THEN 0 /*There is no constraint*/
            ELSE 0
        END AS required_staff
    FROM Event e
    JOIN Stage s ON e.stage_id = s.stage_id
    JOIN Festival f ON f.festival_id = e.festival_id
    CROSS JOIN Staff_role r
    WHERE f.festival_id = 1  /*Choose in which festival we operate*/
    AND r.staff_role_id IN (1, 2, 3)
)

-- Main query that groups the required staff per event and role to get a daily staff needs overview --
-- Outputs the total number of required staff for each role and each day of the festival --
SELECT 
    event_id,
    event_date,
    staff_role_id,
    role_name,
    SUM(required_staff) AS total_required_staff
FROM Staff_Needs
GROUP BY event_id, event_date, staff_role_id, role_name
ORDER BY event_date, staff_role_id;
