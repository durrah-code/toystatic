const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors'); // For handling CORS issues between frontend and backend
const app = express();

// Middleware for CORS
app.use(cors());

// Your Product model (assuming you use Mongoose)
const Product = require('./models/Product');

// Fetch products from the database
app.get('/api/products', async (req, res) => {
    try {
        const products = await Product.find();  // Fetch all products from the database
        res.json(products);  // Send the products as JSON response
    } catch (error) {
        res.status(500).json({ message: 'Error fetching products' });
    }
});

// Start the server
mongoose.connect('mongodb://localhost:27017/toytastic', { useNewUrlParser: true, useUnifiedTopology: true })
    .then(() => {
        app.listen(5000, () => {
            console.log('Server is running on port 5000');
        });
    })
    .catch(error => console.log(error));
