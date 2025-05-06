const mariadb = require('mariadb');
const pool = mariadb.createPool({
     host: process.env.DB_HOST || 'localhost',
     user: process.env.DB_USER || 'root',
     password: process.env.DB_PASSWORD || 'root',
     database: process.env.DB_NAME || 'festival_database',
     connectionLimit: 15
   });

module.exports = pool;
