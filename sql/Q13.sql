-- Query 13 --
-- I get back more results if i remove the Having >= 3 restriction
Select 
    a.artist_id, a.name,
    COUNT(DISTINCT c.continent_id) AS Continents_participated
FROM Artist a 
JOIN Performs p ON p.artist_id = a.artist_id
JOIN Performance perf ON perf.performs_id = p.performs_id
JOIN Event e ON e.event_id = perf.event_id
JOIN Festival f ON f.festival_id = e.festival_id
JOIN Location l ON l.location_id = f.location_id
JOIN Continent c ON c.continent_id = l.continent_id
GROUP BY a.artist_id, a.name 
HAVING COUNT(DISTINCT c.continent_id) >= 3
ORDER BY Continents_participated DESC;

