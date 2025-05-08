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
                Select 
                    a.artist_id, a.name,
                    COUNT(DISTINCT c.continent_id) AS Continents_participated
                FROM Artist a 
                JOIN Performs p ON p.artist_id = a.artist_id
                JOIN Performance perf ON perf.performs_id = p.performs_id
                JOIN Event e ON e.event_id = perf.event_id
                JOIN Festival f ON f.festival_id = e.event_id
                JOIN Location l ON l.location_id = f.location_id
                JOIN Continent c ON c.continent_id = l.continent_id
                GROUP BY a.artist_id, a.name 
                HAVING COUNT(DISTINCT c.continent_id) >= 3
                ORDER BY Continents_participated DESC;
            `
         

        const query13 = await conn.query(queryString);
        
        if(!query13 || query13.length === 0)
        {
            return res.render('query-13', {
                query13: [],
                message: 'No results found'
            });
        }

        res.render('query-13', { query13, queryString });
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
