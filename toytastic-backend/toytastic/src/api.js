import axios from 'axios';

const api = axios.create({
    baseURL: 'http://localhost:1521/api/products',
});

export const getProducts = () => api.get('/products');
export const getProductById = (id) => api.get(`/products/${id}`);
export const registerUser = (userData) => api.post('/register', userData);
export const loginUser = (credentials) => api.post('/login', credentials);
const db = require('./db'); // Import your  connection

app.get('/api/products', (req, res) => {
    const query = 'SELECT * FROM products'; // Query to fetch data
    db.query(query, (err, results) => {
        if (err) {
            console.error('Error fetching products:', err);
            res.status(500).json({ message: 'Error fetching products' });
        } else {
            res.json(results); // Send results as JSON
        }
    });
});
