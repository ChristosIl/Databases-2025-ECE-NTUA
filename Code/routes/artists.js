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

// δειχνει στο add_artist.ejs
router.get('/add', async (req, res)=>{
    res.render('add_artist'); 
})

router.post('/add', async (req, res)=>{
    let conn;

    const { id, name, birthdate, photo_url, photo_descr } = req.body;
    const is_solo = req.body.is_solo ? 1 : 0;  // μετατροπή σε 1 ή 0
    
    try{
        conn = await pool.getConnection();

        const queryString = `INSERT INTO Artist (artist_id, name, birth_date, is_solo, photo_url, photo_description) VALUES (?, ?, ?, ?, ?, ?)`
        await conn.query(queryString, [id, name, birthdate, is_solo, photo_url, photo_descr]);
        res.redirect('/artists');

    }
    catch(err){
        console.log(err);
        res.status(500).send('Error inserting Artist');
    } 
    finally {
    if (conn) conn.release();
    }
})

module.exports = router;