import React, { useState, useEffect } from 'react';

const ProductList = () => {
    const [products, setProducts] = useState([]);

    // Fetch products from the backend API
    useEffect(() => {
        fetch('http://localhost:1521/api/products')
            .then(response => response.json())
            .then(data => setProducts(data))
            .catch(error => console.error('Error fetching products:', error));
    }, []);

    return (
        <div>
            {/* Header Section */}
            <header>
                <nav>
                    <div className="logo">
                        <h1><a href="/">Toytastic</a></h1>
                    </div>
                    <ul className="nav-links">
                        <li><a href="/shop">Shop</a></li>
                        <li><a href="/about">About Us</a></li>
                        <li><a href="/contact">Contact</a></li>
                        <li><a href="/login">Login</a></li>
                        <li><a href="/cart">Cart</a></li>
                    </ul>
                </nav>
            </header>

            {/* Hero Section */}
            <section className="hero">
                <div className="hero-content">
                    <h2>Welcome to Toytastic!</h2>
                    <p>Discover the best toys for your little ones.</p>
                    <a href="/shop" className="btn">Shop Now</a>
                </div>
            </section>

            {/* Featured Products Section */}
            <section className="featured-products">
                <h2>Featured Toys</h2>
                <div className="product-grid">
                    {products.length === 0 ? (
                        <p>Loading products...</p>
                    ) : (
                        products.map(product => (
                            <div key={product.product_id} className="product">
                                {/* Dynamically set the product image URL */}
                                <img src={`http://localhost:5000/images/${product.image}`} alt={product.name} />
                                <h3>{product.name}</h3>
                                <p>${product.price}</p>
                                <a href={`/product/${product.product_id}`} className="btn">View Product</a>
                            </div>
                        ))
                    )}
                </div>
            </section>

            {/* Footer Section */}
            <footer>
                <div className="footer-content">
                    <p>&copy; 2025 Toytastic - All Rights Reserved</p>
                    <ul className="social-links">
                        <li><a href="https://facebook.com/Toytastic">Facebook</a></li>
                        <li><a href="https://instagram.com/Toytastic">Instagram</a></li>
                        <li><a href="https://twitter.com/Toytastic">Twitter</a></li>
                    </ul>
                    <p>Contact us: info@toytastic.com</p>
                </div>
            </footer>
        </div>
    );
};

export default ProductList;


