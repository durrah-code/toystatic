package com.example.demo3;


import javafx.application.Application;
import javafx.geometry.Insets;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.*;
import javafx.stage.Stage;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Toytastic extends Application {

    private List<Product> products = new ArrayList<>();
    private List<CartItem> cart = new ArrayList<>();

    @Override
    public void start(Stage primaryStage) {
        loadProducts();  // Load products from the database

        // Main layout: VBox for vertical stacking
        VBox mainLayout = new VBox(20);
        mainLayout.setPadding(new Insets(20));

        // Title
        Label titleLabel = new Label("Welcome to Toytastic - Children's Toy Store");
        titleLabel.setStyle("-fx-font-size: 24px; -fx-font-weight: bold;");

        // Product List (GridPane)
        GridPane productGrid = createProductGrid();

        // Add to Cart Button
        Button cartButton = new Button("View Cart");
        cartButton.setStyle("-fx-font-size: 16px;");
        cartButton.setOnAction(e -> {
            // Display cart contents (for now just print message)
            System.out.println("Viewing cart...");
        });

        // Add elements to the main layout
        mainLayout.getChildren().addAll(titleLabel, productGrid, cartButton);

        // Scene and Stage setup
        Scene scene = new Scene(mainLayout, 800, 600);
        primaryStage.setTitle("Toytastic - Children's Toy Store");
        primaryStage.setScene(scene);
        primaryStage.show();
    }

    // Method to load products from the database
    private void loadProducts() {
        String query = "SELECT * FROM products"; // Assuming your database has a table named 'products'
        try (Connection connection = DatabaseConnection.getConnection();
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(query)) {

            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                double price = resultSet.getDouble("price");
                String image = resultSet.getString("image");
                products.add(new Product(id, name, price, image));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to create a Grid of Products
    private GridPane createProductGrid() {
        GridPane grid = new GridPane();
        grid.setHgap(20); // Horizontal gap between items
        grid.setVgap(20); // Vertical gap between items
        grid.setPadding(new Insets(20));

        for (int i = 0; i < products.size(); i++) {
            // Create product components
            VBox productBox = new VBox(10);
            productBox.setPadding(new Insets(10));

            // Product Image
            ImageView imageView = new ImageView(new Image("file:" + products.get(i).getImage()));
            imageView.setFitWidth(150);
            imageView.setFitHeight(150);

            // Product Name and Price
            Label nameLabel = new Label(products.get(i).getName());
            nameLabel.setStyle("-fx-font-size: 16px; -fx-font-weight: bold;");
            Label priceLabel = new Label("$" + products.get(i).getPrice());
            priceLabel.setStyle("-fx-font-size: 14px;");

            // Add to Cart Button
            Button addToCartButton = new Button("Add to Cart");
            addToCartButton.setStyle("-fx-font-size: 14px;");
            final int index = i; // Make the index variable effectively final
            addToCartButton.setOnAction(e -> {
                // Add the product to the cart
                Product product = products.get(index);
                cart.add(new CartItem(product, 1));
                System.out.println("Added " + product.getName() + " to cart.");
            });

            // Add components to the product box
            productBox.getChildren().addAll(imageView, nameLabel, priceLabel, addToCartButton);

            // Place the product box in the grid (2 columns, dynamically placed)
            grid.add(productBox, i % 2, i / 2);
        }

        return grid;
    }

    public static void main(String[] args) {
        launch(args);
    }
}
