const express = require('express');
const router = express.Router();
const pool = require('../db');



router.get('/', async (req, res)=> {

    let conn ;

    try
    {   
        conn = await pool.getConnection();
        const query8 = await conn.query(
            `
               SELECT 
                    s.staff_id, 
                    s.name,
                    CASE 
                        WHEN s.staff_id NOT IN (
                            SELECT w.staff_id
                            FROM Works_on w
                            JOIN Event e ON w.event_id = e.event_id
                            WHERE e.event_date = '2025-07-12' /* Required Date*/
                        ) THEN 'YES'
                        ELSE 'NO'
                    END AS available_on_the_Date_we_asked
                FROM Staff s
                WHERE s.staff_role_id = 3;

            `
        );

        if(!query8 || query8.length === 0)
        {
            return res.render('query-8', {
                query8: [],
                message: 'No results found'
            });
        }

        res.render('query-8', { query8 });
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
