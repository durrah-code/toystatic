import React from "react";
import "./Product.css"; // Import a CSS file for styling (optional)

// Sample product data
const products = [
    {
        id: 1,
        name: "Teddy Bear",
        image: "/images/teddy-bear.jpg", // Replace with actual image paths
        price: 29.99,
        description: "A soft and cuddly teddy bear for kids of all ages."
    },
    {
        id: 2,
        name: "Lego Set",
        image: "/images/lego-set.jpg",
        price: 49.99,
        description: "A fun and creative Lego building set for kids."
    },
    {
        id: 3,
        name: "Toy Car",
        image: "/images/toy-car.jpg",
        price: 19.99,
        description: "A miniature toy car for exciting adventures."
    }
];

function Product() {
    return (
        <div className="product-page">
            <h1>Our Products</h1>
            <div className="product-list">
                {products.map((product) => (
                    <div key={product.id} className="product-item">
                        <img src={product.image} alt={product.name} className="product-image" />
                        <h2 className="product-name">{product.name}</h2>
                        <p className="product-price">${product.price.toFixed(2)}</p>
                        <p className="product-description">{product.description}</p>
                        <div className="product-actions">
                            <button className="view-details-btn">
                                <a href={`/product/${product.id}`}>View Details</a>
                            </button>
                            <button className="add-to-cart-btn">Add to Cart</button>
                        </div>
                    </div>
                ))}
            </div>
        </div>
    );
}

export default Product;

  