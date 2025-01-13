import React from 'react';

// FeaturedProducts Component
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

export default FeaturedProducts;
