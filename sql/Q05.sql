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
