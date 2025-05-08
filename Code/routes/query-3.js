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
                WHERE type_of_performance = 2 /* Set for warm up */
                GROUP BY a.artist_id, f.festival_id
                HAVING COUNT(*) > 2;
            `
        const query3 = await conn.query(queryString);
        if(!query3 || query3.length === 0)
        {
            return res.render('query-3', {
                query3: [],
                message: 'No results found'
            });
        }

        res.render('query-3', { query3, queryString });
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
