const express = require('express');
const router = express.Router();
const pool = require('../db');



router.get('/', async (req, res)=> {

    let conn ;

    try
    {   
        conn = await pool.getConnection();
        const queryString =  
            `
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
            `
        const query10 = await conn.query(queryString);

        if(!query10 || query10.length === 0)
        {
            return res.render('query-10', {
                query10: [],
                message: 'No results found'
            });
        }

        res.render('query-10', { query10, queryString });
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
