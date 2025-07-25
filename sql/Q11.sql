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

