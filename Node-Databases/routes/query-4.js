const express = require('express');
const router = express.Router();
const pool = require('../db');



router.get('/', async (req, res)=> {

    let conn ;

    try
    {   
        conn = await pool.getConnection();
        const query4 = await conn.query(
            `
                SELECT
                    COALESCE(a.name, b.name) AS Performer_Name, 
                    CASE WHEN a.artist_id IS NOT NULL THEN 'Artist' ELSE 'Band' END AS Performer_Type, 
                    AVG(r.interpretation_rating) AS Avg_Interpretation_Rating,
                    AVG(r.overall_impression) AS Avg_Overall_Impression
                FROM Rating r
                JOIN Performance p ON r.performance_id = p.performance_id
                JOIN Performs pf ON p.performs_id = pf.performs_id
                LEFT JOIN Artist a ON pf.artist_id = a.artist_id
                LEFT JOIN Band b ON pf.band_id = b.band_id   
                WHERE
                    -- We choose which ever artist we want
                    a.artist_id = 1 
                    OR
                    -- We choose which ever band we want
                    b.band_id = 5 
                GROUP BY COALESCE(a.name, b.name), CASE WHEN a.artist_id IS NOT NULL THEN 'Artist' ELSE 'Band' END;
            `
        );

        if(!query4 || query4.length === 0)
        {
            return res.render('query-4', {
                query4: [],
                message: 'No results found'
            });
        }

        res.render('query-4', { query4 });
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
