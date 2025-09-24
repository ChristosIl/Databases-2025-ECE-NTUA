-- Query 3 -- 
SELECT 
    a.artist_id, a.name AS Artist_Name,
    f.name AS FESTIVAL,
    f.festival_id,
    e.event_name,
     /*    GROUP_CONCAT(DISTINCT e.event_name ORDER BY e.event_name SEPARATOR ', ') AS Events, */
    /* Δεν υπάρχει περιορισμός στο έτος άρα βρίσκει και μελλοντικές συμμετοχές */
    COUNT(*) AS Warm_Up_Count
FROM Artist a 
JOIN Performs p ON p.artist_id = a.artist_id
JOIN Performance perf ON perf.performs_id = p.performs_id
JOIN Event e ON e.event_id = perf.event_id
JOIN Festival f ON e.festival_id = f.festival_id
WHERE type_of_performance = 2 /* Set for warm up */
GROUP BY a.artist_id, f.festival_id
HAVING COUNT(*) > 2;
