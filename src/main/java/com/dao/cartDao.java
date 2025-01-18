package com.dao;

import com.db.DatabaseConnection;
import com.model.Cart;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class cartDao {

    public static void save(Cart cart) {
        String sql = "INSERT INTO cart ( prodId, userId) VALUES ( ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, cart.getProdId());
            stmt.setInt(2, cart.getUserId());
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace(); // Handle potential database errors
        }
    }
    public void delete(int cartId) {
        Connection con = null;
        PreparedStatement stmt = null;
        try {
            con = DatabaseConnection.getConnection();
            String query = "DELETE FROM cart WHERE ID = ?";
            stmt = con.prepareStatement(query);
            stmt.setInt(1, cartId);
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
