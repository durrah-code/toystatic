package com.dao;

import com.db.DatabaseConnection;
import com.model.Order;

import java.sql.*;

public class orderDao {

    public boolean update(Order order) {
        Connection con = null;
        PreparedStatement stmt = null;
        boolean updated = false;

        try {
            con = DatabaseConnection.getConnection();
            String query = "UPDATE orders SET status = ?  WHERE id = ?";
            stmt = con.prepareStatement(query);
            stmt.setString(1, order.getStatus());
            stmt.setInt(2, order.getId());

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

    public int insertOrder(int userId, String totalPrice, String[] productIds, String address) throws SQLException {
        Connection con = DatabaseConnection.getConnection();
        int orderId = -1;
        String insertOrderQuery = "INSERT INTO orders (CustID, totalPrice, shipAddress) VALUES (?, ?,?)";

        try (PreparedStatement stmt = con.prepareStatement(insertOrderQuery, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, userId);
            stmt.setString(2, totalPrice);
            stmt.setString(3, address);

            int affectedRows = stmt.executeUpdate();

            if (affectedRows > 0) {
                ResultSet generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    orderId = generatedKeys.getInt(1);
                    // Insert order products
                    insertOrderProducts(orderId, productIds);
                    // Delete from cart
                    deleteFromCart(userId);
                }
            }
        }
        return orderId;
    }

    private void insertOrderProducts(int orderId, String[] productIds) throws SQLException {
        Connection con = DatabaseConnection.getConnection();
        String insertItemQuery = "INSERT INTO order_product (orderId, prodId) VALUES (?, ?)";

        try (PreparedStatement stmt = con.prepareStatement(insertItemQuery)) {
            for (String prodId : productIds) {
                stmt.setInt(1, orderId);
                stmt.setInt(2, Integer.parseInt(prodId));
                stmt.addBatch();
            }
            stmt.executeBatch();
        }
    }

    private void deleteFromCart(int userId) throws SQLException {
        Connection con = DatabaseConnection.getConnection();
        String removeCartQuery = "DELETE FROM cart WHERE userId = ?";

        try (PreparedStatement stmt = con.prepareStatement(removeCartQuery)) {
            stmt.setInt(1, userId);
            stmt.executeUpdate();
        }
    }

    public static void delete(String id) {
        Connection con = null;
        PreparedStatement stmt = null;
        try {
            con = DatabaseConnection.getConnection();
            System.out.println("Deleting order last " + id);
            String query = "DELETE FROM orders WHERE id = ?";
            stmt = con.prepareStatement(query);
            stmt.setString(1, id);
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