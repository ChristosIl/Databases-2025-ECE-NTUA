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