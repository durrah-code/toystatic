import { RouterProvider, createBrowserRouter } from 'react-router-dom';
import ReactDOM from 'react-dom';
import React from 'react';
import HomePage from './pages/Home'
import Product from './pages/Product';
import AddProduct from './pages/AddProduct';
import Layout from './pages/Layout';
import ProductDetailPage from './pages/ProductDetails';
import Cart from './pages/Cart';
import './index.css';

const router = createBrowserRouter([
  {
    path: '/',
    element: <Layout></Layout>,
    children: [
      {
        path: '/',
        element: <HomePage></HomePage>
      },
      {
        path: '/product',
        element: <Product></Product>
      },
      {
        path: '/product/:id',
        element: <ProductDetailPage></ProductDetailPage>
      },
      {
        path: '/Add-product',
        element: <AddProduct></AddProduct>
      },
      {
        path: '/cart',
        element: <Cart></Cart>
      }
    ]
  }
]);

function App() {
  return <RouterProvider router={router}></RouterProvider>
}

console.log("React is rendering the App component!");
ReactDOM.render(<App />, document.getElementById('root'));


export default App;
