import React, { useState } from 'react';
import FeaturedProducts from './FeaturedProducts';  // Import FeaturedProducts
import Categories from './Categories';  // Import Categories
import "./App.css";

// App Component
function App() {
    const [cart, setCart] = useState([]);

    const products = [
        { id: 1, name: 'Toy 1', description: 'Description of Toy 1', price: 19.99, image: 'images/toy1.jpg' },
        { id: 2, name: 'Toy 2', description: 'Description of Toy 2', price: 24.99, image: 'images/toy2.jpg' },
    ];

    const addToCart = (product) => {
        setCart([...cart, product]);
        alert(`${product.name} has been added to the cart.`);
    };

    return (
        <div>
            <HeroSection />
            <Categories />  {/* Use Categories Component */}
            <FeaturedProducts products={products} addToCart={addToCart} />  {/* Use FeaturedProducts Component */}
            <Footer />
        </div>
    );
}

// Hero Section
function HeroSection() {
    return (
        <section className="hero">
            <h2>Welcome to Toytastic!</h2>
            <p>Find the perfect toy for your child</p>
            <button onClick={() => alert('Shopping Now!')}>Shop Now</button>
        </section>
    );
}

// Footer Section
function Footer() {
    return (
        <footer>
            <p>&copy; 2025 Toytastic - All Rights Reserved</p>
            <ul>
                <li><a href="#">Privacy Policy</a></li>
                <li><a href="#">Terms of Service</a></li>
                <li><a href="#">Contact Us</a></li>
            </ul>
        </footer>
    );
}

export default App;
