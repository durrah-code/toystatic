// App.js
import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import ProductList from './ProductList';

const App = () => {
  return (
      <Router>
          <Routes>
              <Route path="/" element={<ProductList />} />
              {/* You can add more routes like this for individual product pages */}
          </Routes>
      </Router>
  );
};

export default App;

