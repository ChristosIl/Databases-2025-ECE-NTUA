const mariadb = require('mariadb');
const pool = mariadb.createPool({
     host: 'localhost', 
     user:'root', 
     password: 'root',
     connectionLimit: 15,
     database: 'festival_database'
});

module.exports = pool;
