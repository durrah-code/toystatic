<%@ page import="java.sql.*" %>
<%
    String url = "jdbc:mysql://localhost:3306/toystatic";
    String username = "root";
    String password = "";

    Connection connection = null;
    String message = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");

        connection = DriverManager.getConnection(url, username, password);

        message = "Database connection successful!";
    } catch (ClassNotFoundException e) {
        message = "JDBC Driver not found: " + e.getMessage();
    } catch (SQLException e) {
        message = "SQL Exception: " + e.getMessage();
    } finally {
        if (connection != null) {
            try {
                connection.close(); // Close connection
            } catch (SQLException e) {
                message += "<br>Failed to close connection: " + e.getMessage();
            }
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Database Connection Test</title>
</head>
<body>
    <h1>Database Connection Test</h1>
    <p><%= message %></p>
</body>
</html>
