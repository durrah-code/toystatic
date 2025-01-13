import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import ProductList from './ProductList'; // Import your ProductList component

const App = () => {
    return (
        <Router>
            <Routes>
                <Route path="/" element={<ProductList />} />
                {/* You can add more routes like this for individual product pages */}
                {/* Example: <Route path="/product/:id" element={<ProductDetails />} /> */}
            </Routes>
        </Router>
    );
};

export default App;


