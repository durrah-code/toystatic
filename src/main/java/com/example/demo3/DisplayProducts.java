package com.example.demo3;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class DisplayProducts {
    public static void main(String[] args) {
        // Database connection details
        String jdbcURL = "jdbc:oracle:thin:@localhost:1521:XE"; // Replace with your database URL
        String username = "system"; // Replace with your DB username
        String password = "durrah"; // Replace with your DB password

        try (Connection connection = DriverManager.getConnection(jdbcURL, username, password)) {
            System.out.println("Connected to the database!");

            // SQL query to fetch product data
            String sql = "SELECT * FROM products";

            // Create a statement and execute the query
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(sql);

            // Display data
            System.out.println("Product List:");
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                double price = resultSet.getDouble("price");

                System.out.printf("ID: %d, Name: %s, Price: %.2f\n", id, name, price);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

