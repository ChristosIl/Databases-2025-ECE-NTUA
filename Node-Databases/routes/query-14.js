const express = require('express');
const router = express.Router();
const pool = require('../db');



router.get('/', async (req, res)=> {

    let conn ;

    try
    {   
        // conn = await pool.getConnection();
        // const query14 = await conn.query(
        //     `
            
        //     `
        // );

        // if(!query14 || query14.length === 0)
        // {
        //     return res.render('query-14', {
        //         query14: [],
        //         message: 'No results found'
        //     });
        // }
        // res.render('query-14', { query14 });
        res.render('query-14');
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
