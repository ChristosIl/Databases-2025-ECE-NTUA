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
                f.festival_id, f.name AS FESTIVAL,
                ROUND(avg(staff.experience_id), 2) AS AVG_working_experience_of_technicians
            FROM Festival f 
            JOIN Event e ON e.festival_id = f.festival_id
            JOIN Stage s ON e.stage_id = s.stage_id
            JOIN Works_on w ON w.stage_id = s.stage_id
            JOIN Staff staff ON staff.staff_id = w.staff_id 
            WHERE staff.staff_role_id = 1
            GROUP BY f.festival_id, f.name
            ORDER BY AVG_working_experience_of_technicians ASC
            LIMIT 1;

            `
        const query7 = await conn.query(queryString);

        if(!query7 || query7.length === 0)
        {
            return res.render('query-7', {
                query7: [],
                message: 'No results found'
            });
        }

        res.render('query-7', { query7, queryString });
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
