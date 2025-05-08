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
                    a.name AS Performer_Name,
                    AVG(r.interpretation_rating) AS Avg_Interpretation_Rating,
                    AVG(r.overall_impression) AS Avg_Overall_Impression
                FROM Rating r
                JOIN Performance p ON r.performance_id = p.performance_id
                JOIN Performs pf ON p.performs_id = pf.performs_id
                JOIN Artist a ON pf.artist_id = a.artist_id
                WHERE a.artist_id = 1
                GROUP BY a.name;

            `
        const query4 = await conn.query(queryString);

        if(!query4 || query4.length === 0)
        {
            return res.render('query-4', {
                query4: [],
                message: 'No results found'
            });
        }

        res.render('query-4', { query4, queryString });
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
