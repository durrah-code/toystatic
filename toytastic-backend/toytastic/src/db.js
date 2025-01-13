const mysql = require('mysql2');

const pool = mysql.createPool({
    host: 'localhost',
    user: 'system',
    password: 'durrah',
    database: 'toytastic',
});

module.exports = pool.promise();
