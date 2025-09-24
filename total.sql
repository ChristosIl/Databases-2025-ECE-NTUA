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

-- Query 2 --
SELECT
    a.artist_id,
    a.name AS Artist,
    mg.name AS Music_Genre,
    '2025' AS Year_of_participation,
    CASE 
        WHEN COUNT(DISTINCT CASE WHEN f.year = 2025 THEN f.festival_id END) > 0 THEN 'Yes'
        ELSE 'No'
    END AS participated,
    GROUP_CONCAT(DISTINCT CASE WHEN f.year = 2025 THEN f.name END ORDER BY f.name SEPARATOR ', ') AS Festivals_2025
FROM Artist a 
JOIN Artist_music_genres amg ON a.artist_id = amg.artist_id
JOIN Music_genres mg ON amg.music_genre_id = mg.music_genre_id
LEFT JOIN Performs p ON p.artist_id = a.artist_id
LEFT JOIN Performance perf ON perf.performs_id = p.performs_id
LEFT JOIN Event e ON e.event_id = perf.event_id
LEFT JOIN Festival f ON f.festival_id = e.festival_id
WHERE amg.music_genre_id = 1
GROUP BY a.artist_id, a.name, mg.name
ORDER BY a.artist_id;


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
WHERE type_of_performance = 2 /* Set for warm up */
GROUP BY a.artist_id, f.festival_id
HAVING COUNT(*) > 2;


-- Query 4 -- 


--EXPLAIN FORMAT=JSON
SELECT
    a.name AS Performer_Name,
    AVG(r.interpretation_rating) AS Avg_Interpretation_Rating,
    AVG(r.overall_impression) AS Avg_Overall_Impression
FROM Rating r
JOIN Performance p ON r.performance_id = p.performance_id
JOIN Performs pf ON p.performs_id = pf.performs_id
JOIN Artist a ON pf.artist_id = a.artist_id
WHERE a.artist_id = 1
GROUP BY a.name;


-- ALTERNATIVE QUERY PLANNING USING FORCE INDEXES -- 

--CREATE INDEX idx_rating_performance_id ON Rating(performance_id);
--EXPLAIN FORMAT = JSON
SELECT
    a.name AS Performer_Name,
    AVG(r.interpretation_rating) AS Avg_Interpretation_Rating,
    AVG(r.overall_impression) AS Avg_Overall_Impression
FROM Rating r FORCE INDEX(idx_rating_performance_id)
JOIN Performance p FORCE INDEX(PRIMARY) ON r.performance_id = p.performance_id
JOIN Performs pf FORCE INDEX(PRIMARY) ON p.performs_id = pf.performs_id
JOIN Artist a FORCE INDEX (PRIMARY) ON pf.artist_id = a.artist_id
WHERE a.artist_id = 1
GROUP BY a.name;


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
ORDER BY total_festival_participations DESC;


-- Query 6 -- 

--EXPLAIN FORMAT = JSON
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

-- ALTERNATIVE QUERY PLANNING USING FORCE INDEXES -- 

--EXPLAIN FORMAT = JSON
SELECT
    v.name AS Visitor_Name,
    v.surname AS Visitor_Surname,
    e.event_name AS Event_Name,
    p.performance_id,
    p.type_of_performance,
    AVG(
        (r.interpretation_rating + r.sound_and_lighting_rating + r.stage_presence_rating + r.organization_rating + r.overall_impression) / 5.0
    ) AS Avg_Visitor_Total_Rating_Per_Performance
FROM Rating r FORCE INDEX (idx_rating_ticket_id)
JOIN Ticket t FORCE INDEX (PRIMARY) ON r.ticket_id = t.ticket_id
JOIN Visitor v FORCE INDEX (PRIMARY) ON t.visitor_id = v.visitor_id
JOIN Performance p FORCE INDEX (idx_perf_event_start) ON r.performance_id = p.performance_id
JOIN Event e FORCE INDEX (PRIMARY) ON p.event_id = e.event_id
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


-- Query 13 --
-- I get back more results if i remove the Having >= 3 restriction
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

WITH GenreAppearances AS (
    SELECT
        mg.music_genre_id,
        mg.name AS genre_name,
        f.year,
        COUNT(*) AS appearances
    FROM Performance perf
    JOIN Performs p ON perf.performs_id = p.performs_id
    JOIN Event e ON perf.event_id = e.event_id
    JOIN Festival f ON e.festival_id = f.festival_id
    LEFT JOIN Artist_music_genres amg ON p.artist_id = amg.artist_id
    LEFT JOIN Band_music_genres bmg ON p.band_id = bmg.band_id
    LEFT JOIN Music_genres mg ON mg.music_genre_id = COALESCE(amg.music_genre_id, bmg.music_genre_id)
    WHERE mg.music_genre_id IS NOT NULL
    GROUP BY mg.music_genre_id, mg.name, f.year
    HAVING COUNT(*) >= 3
),
WithLag AS (
    SELECT *,
           LAG(year) OVER (PARTITION BY music_genre_id ORDER BY year) AS prev_year,
           LAG(appearances) OVER (PARTITION BY music_genre_id ORDER BY year) AS prev_appearances
    FROM GenreAppearances
)
SELECT
    genre_name,
    prev_year AS year1,
    year AS year2,
    appearances
FROM WithLag
WHERE year = prev_year + 1 AND appearances = prev_appearances;


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