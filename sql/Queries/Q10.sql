-- Query 10  I think its done--

-- subquery to find all music genre tuples based on the artists
WITH all_tuples_of_mg 
AS (
    SELECT
        GROUP_CONCAT(mg.name ORDER BY mg.name SEPARATOR ', ') AS Music_genres
    FROM Artist a 
    JOIN Artist_music_genres amg ON amg.artist_id = a.artist_id
    JOIN Music_genres mg ON mg.music_genre_id = amg.music_genre_id
    GROUP BY a.artist_id, a.name
    ORDER BY Music_Genres
)

-- Main query 
SELECT 
    Music_Genres,
    COUNT(*) AS Number_Appeared
FROM all_tuples_of_mg
GROUP BY Music_genres
ORDER BY Number_Appeared DESC
LIMIT 3;
