package com.example.demo3;


import java.sql.*;

/**
 * Manages the connection to the Oracle database.
 * Provides methods for opening and closing database connections.
 */
public class DatabaseConnection {
    private static final String DB_URL = "jdbc:oracle:thin:@localhost:1521:XE";
    private static final String USER = "system";
    private static final String PASS = "durrah";

    /**
     * Establishes a connection to the database.
     * @return Connection object
     * @throws SQLException If a database access error occurs
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, USER, PASS);
    }

    /**
     * Closes the database connection.
     * @param connection Connection object to be closed
     * @throws SQLException If an error occurs while closing the connection
     */
    public static void closeConnection(Connection connection) throws SQLException {
        if (connection != null && !connection.isClosed()) {
            connection.close();
        }
    }
}




