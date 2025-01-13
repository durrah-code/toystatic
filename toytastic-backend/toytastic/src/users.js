const express = require('express');
const db = require('./db');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const router = express.Router();

// Register a new user
router.post('/register', async (req, res) => {
    const { username, password, is_admin } = req.body;
    const hashedPassword = await bcrypt.hash(password, 10);
    try {
        const result = await db.query(
            'INSERT INTO Users (username, password, is_admin) VALUES (?, ?, ?)',
            [username, hashedPassword, is_admin]
        );
        res.status(201).json({ message: 'User registered', userId: result[0].insertId });
    } catch (error) {
        res.status(500).json({ message: 'Server error' });
    }
});

// Login user
router.post('/login', async (req, res) => {
    const { username, password } = req.body;
    try {
        const [rows] = await db.query('SELECT * FROM Users WHERE username = ?', [username]);
        if (rows.length === 0) return res.status(400).json({ message: 'Invalid credentials' });

        const user = rows[0];
        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) return res.status(400).json({ message: 'Invalid credentials' });

        const token = jwt.sign({ userId: user.user_id, isAdmin: user.is_admin }, 'your_jwt_secret');
        res.json({ message: 'Login successful', token });
    } catch (error) {
        res.status(500).json({ message: 'Server error' });
    }
});

module.exports = router;
