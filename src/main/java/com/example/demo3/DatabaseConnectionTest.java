package com.example.demo3;


import java.sql.*;

public class DatabaseConnectionTest {
    public static void main(String[] args) {
        try {
            // Establish the connection
            Connection connection = DatabaseConnection.getConnection();

            if (connection != null) {
                System.out.println("Database connection successful!");
            } else {
                System.out.println("Failed to connect to the database.");
            }

            // Close the connection
            DatabaseConnection.closeConnection(connection);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

