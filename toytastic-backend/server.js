const express = require('express');
const fs = require('fs');
const path = require('path');
const app = express();

app.use(express.json());
app.use(express.static(path.join(__dirname, 'client/build')));

// Endpoint to fetch toy products from file-based storage
app.get('/api/toys', (req, res) => {
    fs.readFile('toys.json', (err, data) => {
        if (err) {
            return res.status(500).json({ message: 'Error reading data' });
        }
        res.json(JSON.parse(data));
    });
});

// Endpoint to add a toy to the file-based storage
app.post('/api/toys', (req, res) => {
    const newToy = req.body;
    fs.readFile('toys.json', (err, data) => {
        if (err) {
            return res.status(500).json({ message: 'Error reading data' });
        }
        const toys = JSON.parse(data);
        toys.push(newToy);
        fs.writeFile('toys.json', JSON.stringify(toys, null, 2), (err) => {
            if (err) {
                return res.status(500).json({ message: 'Error saving data' });
            }
            res.status(201).json(newToy);
        });
    });
});

// Serve static files from the React app
app.get('*', (req, res) => {
    res.sendFile(path.join(__dirname, 'client/build', 'index.html'));
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
