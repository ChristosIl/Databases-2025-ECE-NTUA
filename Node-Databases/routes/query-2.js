const express = require('express');
const router = express.Router();
const pool = require('../db');



router.get('/', async (req, res)=> {

    let conn ;

    try
    {   
        conn = await pool.getConnection();
        const query2 = await conn.query(
            `
            SELECT
                a.artist_id,
                a.name AS Artist,
                mg.name AS Music_Genre,
                f.year AS Year_of_participation,
                f.name AS FESTIVAL,
                CASE 
                    WHEN f.year IS NOT NULL THEN 'Yes'
                    ELSE 'No'
                END AS participated
            FROM Artist a 
            JOIN Artist_music_genres amg ON a.artist_id = amg.artist_id
            JOIN Music_genres mg ON amg.music_genre_id = mg.music_genre_id
            LEFT JOIN Performs p ON p.artist_id = a.artist_id
            LEFT JOIN Performance perf ON perf.performs_id = p.performs_id
            LEFT JOIN Event e ON e.event_id = perf.event_id
            LEFT JOIN Festival f ON f.festival_id = e.festival_id AND f.year = 2025 -- We choose the year here --
            WHERE amg.music_genre_id = 1 -- We choose the music genre here based on id -- 
            GROUP BY a.artist_id, f.year;
            `
        );

        if(!query2 || query2.length === 0)
        {
            return res.render('query-2', {
                query2: [],
                message: 'No results found'
            });
        }

        res.render('query-2', { query2 });
    }
    catch (err)
    {
        console.log(err);
        res.status(500).send('Database error');
    }
    finally
    {
        if (conn) conn.release();
    }
})

module.exports = router;
