package com.dao;

import com.db.DatabaseConnection;
import com.model.Toy;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class toyDao {

    public static void save(Toy toy) {
        String sql = "INSERT INTO toy ( name, price, image) VALUES ( ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, toy.getName());
            stmt.setString(2, toy.getPrice());
            stmt.setBlob(3, toy.getImage());
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace(); // Handle potential database errors
        }
    }
    public void delete(String toyId) {
        Connection con = null;
        PreparedStatement stmt = null;
        try {
            con = DatabaseConnection.getConnection();
            String query = "DELETE FROM TOY WHERE ID = ?";
            stmt = con.prepareStatement(query);
            stmt.setString(1, toyId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {

            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (con != null) {
                    con.close();
                }
            }catch (SQLException e) {
                e.printStackTrace();
            }
        }

    }



}
