import React from 'react';

// Categories Component
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

export default Categories;
