-- Query 2 --
SELECT
                a.artist_id,
                a.name AS Artist,
                mg.name AS Music_Genre,
                '2025' AS Year_of_participation,
                CASE 
                    WHEN COUNT(DISTINCT CASE WHEN f.year = 2025 THEN f.festival_id END) > 0 THEN 'Yes'
                    ELSE 'No'
                END AS participated,
                GROUP_CONCAT(DISTINCT CASE WHEN f.year = 2025 THEN f.name END ORDER BY f.name SEPARATOR ', ') AS FESTIVAL
            FROM Artist a 
            JOIN Artist_music_genres amg ON a.artist_id = amg.artist_id
            JOIN Music_genres mg ON amg.music_genre_id = mg.music_genre_id
            LEFT JOIN Performs p ON p.artist_id = a.artist_id
            LEFT JOIN Performance perf ON perf.performs_id = p.performs_id
            LEFT JOIN Event e ON e.event_id = perf.event_id
            LEFT JOIN Festival f ON f.festival_id = e.festival_id
            WHERE amg.music_genre_id = 1
            GROUP BY a.artist_id, a.name, mg.name
            ORDER BY a.artist_id;