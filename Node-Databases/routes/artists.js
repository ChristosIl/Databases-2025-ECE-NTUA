const express = require('express');
const router = express.Router();
const pool = require('../db');

//GET /artists

router.get('/', async (req, res) => {
    let conn; 
    try{
           
        conn = await pool.getConnection();
        const artists = await conn.query('SELECT * FROM Artist LIMIT 10');
        res.render('artists', { artists }); // ← pass to EJS template
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