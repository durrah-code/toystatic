const mysql = require('mysql2');

const pool = mysql.createPool({
    host: 'localhost',
    user: 'your_username',
    password: 'your_password',
    database: 'toytastic_db',
});

module.exports = pool.promise();
