-- check festival with location 
SELECT 
    f.festival_id,
    f.name AS festival_name,
    f.year,
    f.duration_days,
    l.city,
    l.country,
    l.address,
    c.name AS continent,
    f.photo_url AS festival_photo,
    f.photo_description AS festival_photo_description
FROM Festival f
JOIN Location l ON f.location_id = l.location_id
JOIN Continent c ON l.continent_id = c.continent_id
ORDER BY f.year, f.festival_id;

/*How many tickets have been sold for each stage*/
SELECT 
    s.stage_id,
    s.name AS stage_name,
    COUNT(t.ticket_id) AS total_tickets
FROM 
    Ticket t
JOIN 
    Event e ON t.event_id = e.event_id
JOIN 
    Stage s ON e.stage_id = s.stage_id
GROUP BY 
    s.stage_id, s.name
ORDER BY 
    total_tickets DESC;

/*print tickets from events 1, 2, 33*/
SELECT 
    t.ticket_id,
    t.event_id,
    e.event_name,
    s.name AS stage_name,
    t.visitor_id,
    v.name AS visitor_name,
    t.ticket_type_id,
    t.price,
    t.used,
    t.purchase_date
FROM Ticket t
JOIN Event e ON t.event_id = e.event_id
JOIN Stage s ON e.stage_id = s.stage_id
JOIN Visitor v ON t.visitor_id = v.visitor_id
WHERE t.event_id IN (1, 2, 33)
ORDER BY t.event_id, t.ticket_id;


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

-- Query 2 --
SELECT
    a.artist_id,
    a.name AS Artist,
    mg.name AS Music_Genre,
    f.year AS Year_of_participation,
    f.name AS FESTIVAL,
    CASE 
        WHEN f.year IS NOT NULL THEN 'Yes'
        ELSE 'No'
    END AS participated
FROM Artist a 
JOIN Artist_music_genres amg ON a.artist_id = amg.artist_id
JOIN Music_genres mg ON amg.music_genre_id = mg.music_genre_id
LEFT JOIN Performs p ON p.artist_id = a.artist_id
LEFT JOIN Performance perf ON perf.performs_id = p.performs_id
LEFT JOIN Event e ON e.event_id = perf.event_id
LEFT JOIN Festival f ON f.festival_id = e.festival_id AND f.year = 2023 -- We choose the year here --
WHERE amg.music_genre_id = 1 -- We choose the music genre here based on id -- 
GROUP BY a.artist_id, f.year;


-- partial implementation of Q-2 / We search for every artist that belogns to Electronic-- 
SELECT 
    a.artist_id, a.name, mg.name AS type_of_music
FROM Artist a 
JOIN Artist_music_genres amg ON amg.artist_id = a.artist_id
JOIN Music_genres mg ON mg.music_genre_id = amg.music_genre_id
WHERE mg.music_genre_id = 1;

-- We search if an artist participated on a Festival at a spesific year -- 
SELECT
    a.artist_id, a.name, f.name AS FESTIVAL
FROM Artist a 
JOIN Performs p ON p.artist_id = a.artist_id
JOIN Performance perf ON perf.performs_id = p.performs_id
JOIN Event e ON e.event_id = perf.event_id
JOIN Festival f ON f.festival_id = e.festival_id AND f.year = 2023;

-- Query 3 -- 
SELECT 
    a.artist_id, a.name AS Artist_Name,
    f.name AS FESTIVAL,
    f.festival_id,
    e.event_name,
    COUNT(*) AS Warm_Up_Count
FROM Artist a 
JOIN Performs p ON p.artist_id = a.artist_id
JOIN Performance perf ON perf.performs_id = p.performs_id
JOIN Event e ON e.event_id = perf.event_id
JOIN Festival f ON e.festival_id = f.festival_id
WHERE LOWER(perf.type_of_performance) = 'warm up'
GROUP BY a.artist_id, f.festival_id
HAVING COUNT(*) > 2;

-- Query 4 -- 
--EXPLAIN FORMAT=JSON

SELECT
    COALESCE(a.name, b.name) AS Performer_Name, 
    CASE WHEN a.artist_id IS NOT NULL THEN 'Artist' ELSE 'Band' END AS Performer_Type, 
    AVG(r.interpretation_rating) AS Avg_Interpretation_Rating,
    AVG(r.overall_impression) AS Avg_Overall_Impression
FROM Rating r
JOIN Performance p ON r.performance_id = p.performance_id
JOIN Performs pf ON p.performs_id = pf.performs_id
LEFT JOIN Artist a ON pf.artist_id = a.artist_id
LEFT JOIN Band b ON pf.band_id = b.band_id   
WHERE
    -- We choose which ever artist we want
    a.artist_id = 1 
    OR
    -- We choose which ever band we want
    b.band_id = 1 
GROUP BY COALESCE(a.name, b.name), CASE WHEN a.artist_id IS NOT NULL THEN 'Artist' ELSE 'Band' END;

-- Query 4 / FORCE INDEXES /Filtering is happening inside the JOINS to take advantage of--
-- Force Indexes --
--EXPLAIN FORMAT=JSON

SELECT
    COALESCE(a.name, b.name) AS Performer_Name, 
    CASE WHEN a.artist_id IS NOT NULL THEN 'Artist' ELSE 'Band' END AS Performer_Type, 
    AVG(r.interpretation_rating) AS Avg_Interpretation_Rating,
    AVG(r.overall_impression) AS Avg_Overall_Impression
FROM Rating r
JOIN Performance p FORCE INDEX (idx_performance_performs_id) 
    ON r.performance_id = p.performance_id
JOIN Performs pf 
    ON p.performs_id = pf.performs_id
LEFT JOIN Artist a 
    ON pf.artist_id = a.artist_id AND a.artist_id = 1 
LEFT JOIN Band b 
    ON pf.band_id = b.band_id AND b.band_id = 5     
GROUP BY Performer_Name, Performer_Type




-- Query 5 --
-- TO DO! Needs more data to be checked --
SELECT 
    a.artist_id, a.name AS Artist_name,
    COUNT(DISTINCT f.festival_id) AS total_festival_participations
FROM Artist a 
JOIN Performs p ON p.artist_id = a.artist_id
JOIN Performance perf ON perf.performs_id = p.performs_id
JOIN Event e ON e.event_id = perf.event_id
JOIN Festival f ON f.festival_id = e.festival_id
WHERE  DATEDIFF(NOW(), Birth_date) < 10957
GROUP BY a.artist_id, a.name
ORDER BY total_festival_participations DESC
LIMIT 10;

-- Query 6 -- 

SELECT
    v.name AS Visitor_Name,
    v.surname AS Visitor_Surname,
    e.event_name AS Event_Name,
    p.performance_id,
    p.type_of_performance,
    AVG((r.interpretation_rating + r.sound_and_lighting_rating + r.stage_presence_rating + r.organization_rating + r.overall_impression) / 5.0)
        AS Avg_Visitor_Total_Rating_Per_Performance
FROM Rating r
JOIN Ticket t ON r.ticket_id = t.ticket_id
JOIN Visitor v ON t.visitor_id = v.visitor_id
JOIN Performance p ON r.performance_id = p.performance_id
JOIN Event e ON p.event_id = e.event_id
/* Define visitor */
WHERE v.visitor_id = 1 
  AND t.used = TRUE
GROUP BY
    v.visitor_id, v.name, v.surname,
    e.event_id, e.event_name,
    p.performance_id, p.type_of_performance, p.start_time 
ORDER BY e.event_name, p.start_time;


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

-- Query 10  I think its done--

-- subquery to find all music genre tuples based on the artists
WITH all_tuples_of_mg 
AS (
    SELECT
        GROUP_CONCAT(mg.name ORDER BY mg.name SEPARATOR ', ') AS Music_genres
    FROM Artist a 
    JOIN Artist_music_genres amg ON amg.artist_id = a.artist_id
    JOIN Music_genres mg ON mg.music_genre_id = amg.music_genre_id
    GROUP BY a.artist_id, a.name
    ORDER BY Music_Genres
)

-- Main query 
SELECT 
    Music_Genres,
    COUNT(*) AS Number_Appeared
FROM all_tuples_of_mg
GROUP BY Music_genres
ORDER BY Number_Appeared DESC
LIMIT 3;

-- Query 11 -- 

-- Subquery that finds the total participations of artists in a specific year in festivals
WITH max_participations_per_artist
AS(
    SELECT
    a.artist_id, a.name,
    COUNT(*) AS Total_performances
FROM Artist a 
JOIN Performs p ON p.artist_id = a.artist_id
JOIN Performance perf ON perf.performs_id = p.performs_id
JOIN Event e ON e.event_id = perf.event_id
JOIN Festival f ON f.festival_id = e.festival_id
WHERE f.year = 2025
GROUP BY a.artist_id, a.name
ORDER BY Total_performances DESC
)

-- Main query that displays the artists with at least 5 participations less --
-- than the first artist with max participations --
SELECT
    mpa.artist_id, mpa.name,
    mpa.Total_performances
FROM max_participations_per_artist mpa
WHERE (SELECT MAX(Total_performances) FROM max_participations_per_artist) - mpa.Total_performances > 4
ORDER BY Total_performances DESC;


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


-- Query 13 Finished but make some inserts so you get back something for 3>--
-- I get back results if i remove the Having >= 3 restriction
Select 
    a.artist_id, a.name,
    COUNT(DISTINCT c.continent_id) AS Continents_participated
FROM Artist a 
JOIN Performs p ON p.artist_id = a.artist_id
JOIN Performance perf ON perf.performs_id = p.performs_id
JOIN Event e ON e.event_id = perf.event_id
JOIN Festival f ON f.festival_id = e.event_id
JOIN Location l ON l.location_id = f.location_id
JOIN Continent c ON c.continent_id = l.continent_id
GROUP BY a.artist_id, a.name 
HAVING COUNT(DISTINCT c.continent_id) >= 3
ORDER BY Continents_participated DESC;


-- Query 14 -- 


-- Query 15 --

WITH VisitorScores AS (
    SELECT
        v.visitor_id,
        v.name AS Visitor_Name,
        v.surname AS Visitor_Surname,
        a.artist_id AS Performer_ID,
        a.name AS Performer_Name,
        'Artist' AS Performer_Type,
        SUM(r.interpretation_rating + r.sound_and_lighting_rating + r.stage_presence_rating + r.organization_rating + r.overall_impression)
            AS Total_Rating_Score
    FROM Rating r
    JOIN Ticket t ON r.ticket_id = t.ticket_id
    JOIN Visitor v ON t.visitor_id = v.visitor_id
    JOIN Performance p ON r.performance_id = p.performance_id
    JOIN Performs pf ON p.performs_id = pf.performs_id
    JOIN Artist a ON pf.artist_id = a.artist_id

    GROUP BY v.visitor_id, v.name, v.surname, a.artist_id, a.name

    UNION ALL

    SELECT
        v.visitor_id,
        v.name AS Visitor_Name,
        v.surname AS Visitor_Surname,
        b.band_id AS Performer_ID,
        b.name AS Performer_Name,
        'Band' AS Performer_Type,
        SUM(r.interpretation_rating + r.sound_and_lighting_rating + r.stage_presence_rating + r.organization_rating + r.overall_impression)
            AS Total_Rating_Score
    FROM Rating r
    JOIN Ticket t ON r.ticket_id = t.ticket_id
    JOIN Visitor v ON t.visitor_id = v.visitor_id
    JOIN Performance p ON r.performance_id = p.performance_id
    JOIN Performs pf ON p.performs_id = pf.performs_id
    JOIN Band b ON pf.band_id = b.band_id
    GROUP BY v.visitor_id, v.name, v.surname, b.band_id, b.name
)

SELECT
    Visitor_Name,
    Visitor_Surname,
    Performer_Name,
    Performer_Type,
    Total_Rating_Score
FROM VisitorScores
WHERE
    Performer_ID = 1 AND Performer_Type = 'Artist' -- Αντικατάσταση με το ID και τον Τύπο ('Artist' ή 'Band') του performer
ORDER BY Total_Rating_Score DESC
LIMIT 5;