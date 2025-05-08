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
            ;
            `
   
        const query5 = await conn.query(queryString); 

        if(!query5 || query5.length === 0)
        {
            return res.render('query-5', {
                query5: [],
                message: 'No results found'
            });
        }

        res.render('query-5', { query5, queryString });
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
