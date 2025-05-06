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
