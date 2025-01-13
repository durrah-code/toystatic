const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');
require('dotenv').config();

const app = express();
app.use(cors());
app.use(express.json());

const db = mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME
});

db.connect((err) => {
    if (err) {
        console.error('Database connection failed: ', err);
        process.exit(1);
    }
    console.log('Connected to the database.');
});

// Routes for products
app.get('/products', (req, res) => {
    db.query('SELECT * FROM Products', (err, results) => {
        if (err) {
            return res.status(500).send(err);
        }
        res.json(results);
    });
});

// Routes for user authentication
app.post('/login', (req, res) => {
    const { username, password } = req.body;
    db.query('SELECT * FROM Users WHERE username = ? AND password = ?', [username, password], (err, results) => {
        if (err) {
            return res.status(500).send(err);
        }
        if (results.length > 0) {
            res.json(results[0]);
        } else {
            res.status(404).send('User not found or incorrect password');
        }
    });
});

// Routes for placing orders
app.post('/orders', (req, res) => {
    const { user_id, total_amount, products } = req.body;
    db.query('INSERT INTO Orders (user_id, total_amount) VALUES (?, ?)', [user_id, total_amount], (err, result) => {
        if (err) {
            return res.status(500).send(err);
        }
        const order_id = result.insertId;
        const orderDetails = products.map(product => [
            order_id,
            product.product_id,
            product.quantity,
            product.price
        ]);
        db.query('INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES ?', [orderDetails], (err, result) => {
            if (err) {
                return res.status(500).send(err);
            }
            res.status(201).send('Order placed successfully');
        });
    });
});

// Start the server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
