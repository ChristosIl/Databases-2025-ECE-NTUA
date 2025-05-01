-- Query 7 -- 

SELECT
    f.festival_id, f.name AS FESTIVAL,
    ROUND(avg(staff.experience_id), 2) AS AVG_working_experience_of_technicians
FROM Festival f 
JOIN Event e ON e.festival_id = f.festival_id
JOIN Stage s ON e.stage_id = s.stage_id
JOIN Works_on w ON w.stage_id = s.stage_id
JOIN Staff staff ON staff.staff_id = w.staff_id 
WHERE staff.staff_role_id = 1
GROUP BY f.festival_id, f.name
ORDER BY AVG_working_experience_of_technicians ASC
LIMIT 1;
