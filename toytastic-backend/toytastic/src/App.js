import React, { useState } from "react";
import './App.css'; // Import your CSS file
import toys from './toys'; // Import the toys data from toys.js

const App = () => {
    // Set up state to manage the cart
    const [cart, setCart] = useState([]);

    // Function to add a product to the cart
    const addToCart = (product) => {
        const existingProduct = cart.find(item => item.id === product.id);

        if (existingProduct) {
            setCart(cart.map(item =>
                item.id === product.id
                    ? { ...item, quantity: item.quantity + 1 }
                    : item
            ));
        } else {
            setCart([...cart, { ...product, quantity: 1 }]);
        }
    };

    // Function to calculate the total price of the cart
    const calculateTotal = () => {
        return cart.reduce((total, item) => total + item.price * item.quantity, 0).toFixed(2);
    };

    // Function to remove a product from the cart
    const removeFromCart = (productId) => {
        setCart(cart.filter(item => item.id !== productId));
    };

    return (
        <div className="App">
            <header>
                <h1>Toytastic</h1>
                <div className="cart-info">
                    <button onClick={() => alert(`Total Cart Value: $${calculateTotal()}`)}>
                        View Cart ({cart.length} items)
                    </button>
                </div>
            </header>

            <section className="products">
                <h2>Featured Products</h2>
                <div className="product-list">
                    {toys.map(product => (
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

            <section className="cart">
                <h2>Your Cart</h2>
                {cart.length === 0 ? (
                    <p>Your cart is empty!</p>
                ) : (
                    <div className="cart-items">
                        {cart.map(item => (
                            <div key={item.id} className="cart-item">
                                <p>{item.name} x {item.quantity}</p>
                                <p>${(item.price * item.quantity).toFixed(2)}</p>
                                <button onClick={() => removeFromCart(item.id)}>Remove</button>
                            </div>
                        ))}
                    </div>
                )}
                {cart.length > 0 && (
                    <div className="cart-total">
                        <p>Total: ${calculateTotal()}</p>
                    </div>
                )}
            </section>
        </div>
    );
};

export default App;
