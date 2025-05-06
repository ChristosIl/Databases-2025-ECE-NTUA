/*Hash join implementation for Queries 4 and 6*/

--         -- 
-- Query 4 --
--         -- 

SET profiling = 1;

-- Hash table for artists 
CREATE TEMPORARY TABLE TempArtist
SELECT artist_id, name
FROM Artist
WHERE artist_id = 2;


SELECT
    ta.name AS Performer_Name,
    AVG(r.interpretation_rating) AS Avg_Interpretation_Rating,
    AVG(r.overall_impression) AS Avg_Overall_Impression
FROM Rating r
JOIN Performance p ON r.performance_id = p.performance_id
JOIN Performs pf ON p.performs_id = pf.performs_id
JOIN TempArtist ta ON pf.artist_id = ta.artist_id
GROUP BY ta.name;

-- Starting query plan 
SELECT
    a.name AS Performer_Name,
    AVG(r.interpretation_rating) AS Avg_Interpretation_Rating,
    AVG(r.overall_impression) AS Avg_Overall_Impression
FROM Rating r
JOIN Performance p ON r.performance_id = p.performance_id
JOIN Performs pf ON p.performs_id = pf.performs_id
JOIN Artist a ON pf.artist_id = a.artist_id
WHERE a.artist_id = 2
GROUP BY a.name;
SHOW PROFILES;


--         -- 
-- Query 6 --
--         -- 

SET profiling = 1;

CREATE TEMPORARY TABLE TempVisitor
SELECT visitor_id, name, surname
FROM Visitor
WHERE visitor_id = 1;


SELECT
    tv.name AS Visitor_Name,
    tv.surname AS Visitor_Surname,
    e.event_name AS Event_Name,
    p.performance_id,
    p.type_of_performance,
    AVG((r.interpretation_rating + r.sound_and_lighting_rating + r.stage_presence_rating + r.organization_rating + r.overall_impression) / 5.0)
        AS Avg_Visitor_Total_Rating_Per_Performance
FROM Rating r
JOIN Ticket t ON r.ticket_id = t.ticket_id
JOIN TempVisitor tv ON t.visitor_id = tv.visitor_id
JOIN Performance p ON r.performance_id = p.performance_id
JOIN Event e ON p.event_id = e.event_id
WHERE t.used = TRUE
GROUP BY
    tv.visitor_id, tv.name, tv.surname,
    e.event_id, e.event_name,
    p.performance_id, p.type_of_performance, p.start_time 
ORDER BY e.event_name, p.start_time;


-- Starting query plan
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



SHOW PROFILES;