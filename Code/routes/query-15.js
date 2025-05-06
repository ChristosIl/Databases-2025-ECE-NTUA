const express = require('express');
const router = express.Router();
const pool = require('../db');



router.get('/', async (req, res)=> {

    let conn ;

    try
    {   
        conn = await pool.getConnection();
        const query15 = await conn.query(
            `
                WITH VisitorScores AS (
                    SELECT
                        v.visitor_id,
                        v.name AS Visitor_Name,
                        v.surname AS Visitor_Surname,
                        a.artist_id AS Performer_ID,
                        a.name AS Performer_Name,
                        'Artist' AS Performer_Type,
                        SUM(r.interpretation_rating + r.sound_and_lighting_rating + r.stage_presence_rating + r.organization_rating + r.overall_impression)
                            AS Total_Rating_Score
                    FROM Rating r
                    JOIN Ticket t ON r.ticket_id = t.ticket_id
                    JOIN Visitor v ON t.visitor_id = v.visitor_id
                    JOIN Performance p ON r.performance_id = p.performance_id
                    JOIN Performs pf ON p.performs_id = pf.performs_id
                    JOIN Artist a ON pf.artist_id = a.artist_id

                    GROUP BY v.visitor_id, v.name, v.surname, a.artist_id, a.name

                    UNION ALL

                    SELECT
                        v.visitor_id,
                        v.name AS Visitor_Name,
                        v.surname AS Visitor_Surname,
                        b.band_id AS Performer_ID,
                        b.name AS Performer_Name,
                        'Band' AS Performer_Type,
                        SUM(r.interpretation_rating + r.sound_and_lighting_rating + r.stage_presence_rating + r.organization_rating + r.overall_impression)
                            AS Total_Rating_Score
                    FROM Rating r
                    JOIN Ticket t ON r.ticket_id = t.ticket_id
                    JOIN Visitor v ON t.visitor_id = v.visitor_id
                    JOIN Performance p ON r.performance_id = p.performance_id
                    JOIN Performs pf ON p.performs_id = pf.performs_id
                    JOIN Band b ON pf.band_id = b.band_id
                    GROUP BY v.visitor_id, v.name, v.surname, b.band_id, b.name
                )

                SELECT
                    Visitor_Name,
                    Visitor_Surname,
                    Performer_Name,
                    Performer_Type,
                    Total_Rating_Score
                FROM VisitorScores
                WHERE
                    Performer_ID = 1 AND Performer_Type = 'Artist' -- Αντικατάσταση με το ID και τον Τύπο ('Artist' ή 'Band') του performer
                ORDER BY Total_Rating_Score DESC
                LIMIT 5;
            `
        );

        if(!query15 || query15.length === 0)
        {
            return res.render('query-15', {
                query15: [],
                message: 'No results found'
            });
        }

        res.render('query-15', { query15 });
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
