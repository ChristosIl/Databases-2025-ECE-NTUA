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

--Question 2
SELECT p.performer_id, p.name AS performer_name, p.music_genres, 
CASE 
    WHEN EXISTS (
        SELECT 1
        FROM Performance perf 
        JOIN Event e ON perf.event_id = e.event_id
        JOIN Festival f ON e.festival_id = f.festival_id
        WHERE perf.performer_id = p.performer_id AND f.year = 2024
    )
    THEN 'YES'
    ELSE 'NO'
END AS participated_in_year
FROM Performer p
WHERE p.music_genres LIKE '%Rock'

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