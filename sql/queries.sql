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