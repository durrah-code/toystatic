import axios from 'axios';

const api = axios.create({
    baseURL: 'https://durrah-code.github.io/toystatic/',
});

export const getProducts = () => api.get('/products');
export const getProductById = (id) => api.get(`/products/${id}`);
export const registerUser = (userData) => api.post('/register', userData);
export const loginUser = (credentials) => api.post('/login', credentials);