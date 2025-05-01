const express = require('express');
const router = express.Router();
const pool = require('../db');



router.get('/', async (req, res)=> {

    let conn ;

    try
    {   
        conn = await pool.getConnection();
        const query6 = await conn.query(
            `
            SELECT
                v.name AS Visitor_Name,
                v.surname AS Visitor_Surname,
                e.event_name AS Event_Name,
                p.performance_id,
                p.type_of_performance,
                AVG((r.interpretation_rating + r.sound_and_lighting_rating + r.stage_presence_rating + r.organization_rating + r.overall_impression) / 5.0)
                    AS Avg_Visitor_Total_Rating_Per_Performance
            FROM Rating r
            JOIN Ticket t ON r.ticket_id = t.ticket_id
            JOIN Visitor v ON t.visitor_id = v.visitor_id
            JOIN Performance p ON r.performance_id = p.performance_id
            JOIN Event e ON p.event_id = e.event_id
            /* Define visitor */
            WHERE v.visitor_id = 1 
            AND t.used = TRUE
            GROUP BY
                v.visitor_id, v.name, v.surname,
                e.event_id, e.event_name,
                p.performance_id, p.type_of_performance, p.start_time 
            ORDER BY e.event_name, p.start_time;
            `
        );

        if(!query6 || query6.length === 0)
        {
            return res.render('query-6', {
                query6: [],
                message: 'No results found'
            });
        }

        res.render('query-6', { query6 });
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
