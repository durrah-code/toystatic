package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.db.DatabaseConnection;
import com.model.Admin;
import com.model.User;

public class userDao {

    public boolean update(User user) {
        Connection con = null;
        PreparedStatement stmt = null;
        boolean updated = false;

        try {
            con = DatabaseConnection.getConnection();
            String query = "UPDATE user SET name = ?, password = ?, address = ? WHERE id = ?";
            stmt = con.prepareStatement(query);
            stmt.setString(1, user.getName());
            stmt.setString(2, user.getPassword());
            stmt.setString(3, user.getAddress());
            stmt.setInt(4, user.getId());

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                updated = true;
            }
        }catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return updated;
    }


    public boolean isEmailExists(String email) {
        boolean exists = false;
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement("SELECT COUNT(*) FROM USER WHERE EMAIL = ?")) {
            preparedStatement.setString(1, email);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                exists = resultSet.getInt(1) > 0; // Check if the count is greater than 0
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return exists;
    }



    // Method to save admin data to database
    public void save(User user) {
        String sql = "INSERT INTO user ( name, email, password, address) VALUES ( ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword());
            stmt.setString(4, user.getAddress());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace(); // Handle potential database errors
        }
    }

    public User authenticate(String email, String password) {
        String sql = "SELECT * FROM user WHERE email = ? AND password = ?";
        User user = null;

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            stmt.setString(2, password);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    user = new User(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("email"),
                            rs.getString("password"),
                            rs.getString("address")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle potential database errors
        }

        return user;
    }
    public Admin adminAuthenticate(String email, String password) {
        String sql = "SELECT * FROM admin WHERE email = ? AND password = ?";
        Admin admin = null;

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            stmt.setString(2, password);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    admin = new Admin(
                            rs.getString("id"),
                            rs.getString("email"),
                            rs.getString("password")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle potential database errors
        }

        return admin;
    }

}
