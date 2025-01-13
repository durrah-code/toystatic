import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';

// Get the root element where the app will be rendered
const rootElement = document.getElementById('root');

// Create the root and render the App component
const root = ReactDOM.createRoot(rootElement);
root.render(
    <React.StrictMode>
        <App />
    </React.StrictMode>
);
