// App.js
import React from 'react';
import { BrowserRouter as Router, Route, Switch } from 'react-router-dom';
import ProductList from './ProductList';

const App = () => {
  return (
      <Router>
        <Switch>
          <Route exact path="/" component={ProductList} />
          {/* You can add more routes like this for individual product pages */}
        </Switch>
      </Router>
  );
};

export default App;

