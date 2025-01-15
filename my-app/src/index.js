// Import necessary libraries
import React from 'react';
import ReactDOM from 'react-dom/client';  // Notice the 'client' import for React 18
import App from './App';  // Import your main app component

// Get the root element where the app will be rendered
const rootElement = document.getElementById('root');

// Create the root and render the App component
const root = ReactDOM.createRoot(rootElement);
root.render(
    <React.StrictMode>
        <App />
    </React.StrictMode>
);

