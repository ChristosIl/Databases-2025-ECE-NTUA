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
