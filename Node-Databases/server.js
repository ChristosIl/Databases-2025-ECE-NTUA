const express = require('express');
const path = require('path');
const app = express();
const PORT = 4000;

// View engine setup
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

// Routes 
const ArtistsRoutes = require('./routes/artists');
app.use('/artists', ArtistsRoutes);

const query1Route = require('./routes/query-1');
app.use('/query-1', query1Route);

const query2Route = require('./routes/query-2');
app.use('/query-2', query2Route)

app.get('/', (req, res) => {
    res.render('index'); //gives back index.ejs
  })

// starting server
app.listen(PORT, () => {
    console.log(`Example app listening on port ${PORT}`)
  })