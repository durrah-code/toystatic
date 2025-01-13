import React, { useState } from 'react';

function ToyForm() {
    const [name, setName] = useState('');
    const [description, setDescription] = useState('');
    const [price, setPrice] = useState('');

    const handleSubmit = (e) => {
        e.preventDefault();

        const newToy = { name, description, price };

        fetch('/api/toys', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(newToy),
        })
            .then((res) => res.json())
            .then((data) => {
                alert('Toy added successfully!');
                setName('');
                setDescription('');
                setPrice('');
            });
    };

    return (
        <form onSubmit={handleSubmit}>
            <h2>Add a New Toy</h2>
            <label>
                Name:
                <input
                    type="text"
                    value={name}
                    onChange={(e) => setName(e.target.value)}
                    required
                />
            </label>
            <label>
                Description:
                <input
                    type="text"
                    value={description}
                    onChange={(e) => setDescription(e.target.value)}
                    required
                />
            </label>
            <label>
                Price:
                <input
                    type="number"
                    value={price}
                    onChange={(e) => setPrice(e.target.value)}
                    required
                />
            </label>
            <button type="submit">Add Toy</button>
        </form>
    );
}

export default ToyForm;
