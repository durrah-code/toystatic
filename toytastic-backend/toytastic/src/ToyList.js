import React, { useEffect, useState } from 'react';

function ToyList() {
    const [toys, setToys] = useState([]);

    useEffect(() => {
        fetch('/api/toys')
            .then((res) => res.json())
            .then((data) => setToys(data));
    }, []);

    return (
        <div>
            <h2>Toy List</h2>
            <ul>
                {toys.map((toy, index) => (
                    <li key={index}>
                        <h3>{toy.name}</h3>
                        <p>{toy.description}</p>
                        <p>${toy.price}</p>
                    </li>
                ))}
            </ul>
        </div>
    );
}

export default ToyList;
