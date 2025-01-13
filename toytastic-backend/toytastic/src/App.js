import React, { useState } from 'react';
import ReactDOM from 'react-dom';

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
            <Categories />
            <FeaturedProducts products={products} addToCart={addToCart} />
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

// Categories Section
function Categories() {
    return (
        <section className="categories">
            <h2>Shop by Category</h2>
            <div className="category-list">
                <div className="category">
                    <img src="images/dolls.jpg" alt="Dolls" />
                    <h3>Dolls</h3>
                </div>
                <div className="category">
                    <img src="images/action-figures.jpg" alt="Action Figures" />
                    <h3>Action Figures</h3>
                </div>
                <div className="category">
                    <img src="images/educational-toys.jpg" alt="Educational Toys" />
                    <h3>Educational Toys</h3>
                </div>
            </div>
        </section>
    );
}

// Featured Products Section
function FeaturedProducts({ products, addToCart }) {
    return (
        <section className="featured-products">
            <h2>Featured Products</h2>
            <div className="product-list">
                {products.map(product => (
                    <div key={product.id} className="product-item">
                        <img src={product.image} alt={product.name} />
                        <h3>{product.name}</h3>
                        <p>{product.description}</p>
                        <p className="price">${product.price}</p>
                        <button onClick={() => addToCart(product)}>Add to Cart</button>
                    </div>
                ))}
            </div>
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

// Rendering the App to the 'root' div
ReactDOM.render(<App />, document.getElementById('root'));
