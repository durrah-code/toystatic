const mysql = require('mysql2');

const pool = mysql.createPool({
    host: 'localhost',
    user: 'system',
    password: 'durrah',
    database: 'toytastic',
});
db.getConnection((err) => {
    if (err) {
        console.error('Error connecting to the database:', err);
    } else {
        console.log('Connected to the SQL database');
    }
});
module.exports = pool.promise();
