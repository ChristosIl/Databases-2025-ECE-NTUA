const express = require('express');
const path = require('path');
const app = express();
const PORT = 4000;

app.use(express.urlencoded({ extended: true }));

// View engine setup
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

// Routes 
// const ArtistsRoutes = require('./routes/artists');
// app.use('/artists', ArtistsRoutes);
const query1Route = require('./routes/query-1');
app.use('/query-1', query1Route);
const query2Route = require('./routes/query-2');
app.use('/query-2', query2Route);
const query3Route = require('./routes/query-3');
app.use('/query-3', query3Route);
const query4Route = require('./routes/query-4');
app.use('/query-4', query4Route);
const query5Route = require('./routes/query-5');
app.use('/query-5', query5Route);
const query6Route = require('./routes/query-6');
app.use('/query-6', query6Route);
const query7Route = require('./routes/query-7');
app.use('/query-7', query7Route);
const query8Route = require('./routes/query-8');
app.use('/query-8', query8Route);
const query9Route = require('./routes/query-9');
app.use('/query-9', query9Route);
const query10Route = require('./routes/query-10');
app.use('/query-10', query10Route);
const query11Route = require('./routes/query-11');
app.use('/query-11', query11Route);
const query12Route = require('./routes/query-12');
app.use('/query-12', query12Route);
const query13Route = require('./routes/query-13');
app.use('/query-13', query13Route);
const query14Route = require('./routes/query-14');
app.use('/query-14', query14Route);
const query15Route = require('./routes/query-15');
app.use('/query-15', query15Route);
const index = require('./routes/index');
app.use('/index', index);

// Initial load 
app.get('/', (req, res) => {
  res.render('Login-Screen', { error: null }); 
});

// Take credentials from the Login Screen through POST
app.post('/login', (req, res) => {
    const { username, password } = req.body;

    if (username === 'root' && password === 'root'){
      res.redirect('/index');
    } else 
    {
      res.render('Login-Screen', { error: 'Invalid credentials' });
    }
  });



// starting server
app.listen(PORT, () => {
    console.log(`Example app listening on port ${PORT}`)
  })