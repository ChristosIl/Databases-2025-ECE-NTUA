const express = require('express');
const router = express.Router();




router.get('/', async (req, res) => {

    try{
        console.log("Hello");
    }
    catch(err){
        console.log(err);
        res.status(500).send('Data error connection');
    }
    res.render('data', {title: 'Database Data'});
});


module.exports = router;