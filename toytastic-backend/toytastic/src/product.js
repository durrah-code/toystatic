const express = require('express');
const db = require('./db');
const router = express.Router();

// Get all products
router.get('/products', async (req, res) => {
    try {
        const [rows] = await db.query('SELECT * FROM Products');
        res.json(rows);
    } catch (error) {
        res.status(500).json({ message: 'Server error' });
    }
});

// Get a single product
router.get('/products/:id', async (req, res) => {
    const { id } = req.params;
    try {
        const [rows] = await db.query('SELECT * FROM Products WHERE product_id = ?', [id]);
        if (rows.length === 0) return res.status(404).json({ message: 'Product not found' });
        res.json(rows[0]);
    } catch (error) {
        res.status(500).json({ message: 'Server error' });
    }
});

// Add a new product
router.post('/products', async (req, res) => {
    const { name, description, price, stock, category } = req.body;
    try {
        const result = await db.query(
            'INSERT INTO Products (name, description, price, stock, category) VALUES (?, ?, ?, ?, ?)',
            [name, description, price, stock, category]
        );
        res.status(201).json({ message: 'Product added', productId: result[0].insertId });
    } catch (error) {
        res.status(500).json({ message: 'Server error' });
    }
});

module.exports = router;
