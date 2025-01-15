import React, { useState } from "react";
import { FoodBeverages } from "./categories/FoodBeverages.js";
import { TouristSpots } from "./categories/TouristSpots.js";
import { CultureHeritage } from "./categories/CultureHeritage.js";
import { Hotels } from "./categories/Hotels.js";
import { AboutUs } from "./categories/AboutUs.js";
import "./App.css";

const App = () => {
  // Define the categories
  const categories = {
    "about-us": { title: "About Us", content: <AboutUs /> },
    "food-beverages": { title: "Food & Beverages", content: <FoodBeverages /> },
    "tourist-spots": { title: "Tourist Spots", content: <TouristSpots /> },
    "culture-heritage": { title: "Culture & Heritage", content: <CultureHeritage /> },
    "hotels": { title: "Hotels", content: <Hotels /> },
  };

  // State to manage the current category
  const [currentCategory, setCurrentCategory] = useState("about-us");

  // Function to handle navigation
  const loadCategory = (categoryId) => {
    if (categories[categoryId]) {
      setCurrentCategory(categoryId);
    } else {
      setCurrentCategory(null); // Handle invalid category
    }
  };

  return (
      <div>
        {/* Top Navigation Bar */}
        <nav className="nav-blocks">
          {Object.keys(categories).map((key) => (
              <button
                  key={key}
                  className={`nav-block ${currentCategory === key ? "active" : ""}`}
                  onClick={() => loadCategory(key)}
              >
                {categories[key].title}
              </button>
          ))}
        </nav>

        {/* Render the current category's content */}
        <main>
          {categories[currentCategory]?.content || <p>Category not found.</p>}
        </main>
      </div>
  );
};

export default App;



