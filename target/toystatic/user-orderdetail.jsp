<%@page import="com.db.DatabaseConnection"%>
<%@page import="com.model.User"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.stream.Collectors" %>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>

<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
        User user = (User) session.getAttribute("user");
        int userID = user.getId();

%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Toy Static</title>
    <link rel="stylesheet" href="inc/style.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

</head>
<div class="header">
    <a href="user-dashboard.jsp">Toy Static</a>
        <div class="act-wrap">
            <%
            if (session.getAttribute("user") != null) {

                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;
                int itemCount = 0;

                try {
                    // Database connection
                    conn = DatabaseConnection.getConnection();
                    String query = "SELECT COUNT(*) AS itemCount FROM cart WHERE userId = ?";
                    stmt = conn.prepareStatement(query);
                    stmt.setInt(1, userID);
                    rs = stmt.executeQuery();

                    if (rs.next()) {
                        itemCount = rs.getInt("itemCount");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
                <a href="user-dashboard.jsp" class="cart-btn act-btn">
                    <i class="fas fa-home" title="user-action-cart"></i>
                </a>
                <a href="user-cart.jsp" class="cart-btn act-btn">
                    <i class="fas fa-shopping-cart" title="user-action-cart"></i>
                    <% if (itemCount > 0) { %>
                        <span class="cart-count"><%= itemCount %></span>
                    <% } %>
                </a>
                <a href="user-order.jsp" class="cart-btn act-btn">
                    <i class="fas fa-shipping-fast" title="user-action-cart"></i>
                </a>
                <a href="user-profile.jsp" class="cart-btn act-btn">
                    <i class="fas fa-user" title="user-action-cart"></i>
                </a>
                <form action="userController" method="post" onsubmit="return confirmLogout();">
                    <input type="hidden" name="action" value="logout">
                    <button type="submit" class="log-btn">Log Out</button>
                </form>

                <script>
                    function confirmLogout() {
                        return confirm("Are you sure you want to log out?");
                    }
                </script>

            <% } %>
        </div>
    </div>
<body>
<%
    int orderID = Integer.parseInt(request.getParameter("id"));

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        conn = DatabaseConnection.getConnection();

        String query = "SELECT o.date, o.status, u.address, COUNT(c.prodId) AS quantity " +
                       "FROM orders o " +
                       "JOIN order_product c ON o.id = c.orderId " +
                       "JOIN toy t ON c.prodId = t.id " +
                       "JOIN user u ON o.custId = u.id " +
                       "WHERE o.id = ? AND o.custId = ?";

        stmt = conn.prepareStatement(query);
        stmt.setInt(1, orderID);
        stmt.setInt(2, user.getId());
        rs = stmt.executeQuery();

        if (!rs.next()) {
            out.println("<p>No details found for this order.</p>");
            return;
        }

        // Extracting order details
        String date = rs.getString("date");
        String status = rs.getString("status");
        String address = rs.getString("address");
%>

        <h1 style="text-align: center;">Order Details</h1>
        <br><br>
        <div class="cart-container">
            <p><strong>Order Date:</strong> <%= date %></p>
            <p><strong>Status:</strong> <%= status %></p>
            <p><strong>Shipping Address:</strong> <%= address %></p>

            <table class="cart-table">
                <thead>
                    <tr>
                        <th>Product</th>
                        <th>Image</th>
                        <th>Quantity</th>
                        <th>Price</th>
                        <th>Subtotal</th>
                    </tr>
                </thead>
                <tbody>
<%
        // Query for product details
        String productQuery = "SELECT t.name, t.price, t.image, " +
                              "o.totalprice, COUNT(c.prodID) AS quantity " +
                              "FROM orders o " +
                              "JOIN order_product c ON o.id = c.orderId " +
                              "LEFT JOIN toy t ON c.prodId = t.id " +
                              "WHERE o.id = ? " +
                              "GROUP BY t.name, t.price, o.totalPrice";

        stmt = conn.prepareStatement(productQuery);
        stmt.setInt(1, orderID);
        rs = stmt.executeQuery();

        double grandTotal = 0;

        while (rs.next()) {
            String productName = rs.getString("name");
            double price = rs.getDouble("price");
            String image = rs.getString("image");
            int quantity = rs.getInt("quantity");
            double subTotal = price * quantity;
            grandTotal = rs.getDouble("totalPrice");
%>
                    <tr>
                        <td><%= productName %></td>
                        <td>
                            <%
                                if (image != null && !image.isEmpty()) {
                                    String base64Image = Base64.getEncoder().encodeToString(rs.getBytes("image"));
                                } else {
                                    out.println("Product Deleted");
                                }
                            %>
                        </td>
                        <td><%= quantity %></td>
                        <td>RM <%= String.format("%.2f", price) %></td>
                        <td>RM <%= String.format("%.2f", subTotal) %></td>
                    </tr>
<%
        }
%>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="4" style="text-align: right;"><strong>Grand Total:</strong></td>
                        <td>RM <%= String.format("%.2f", grandTotal) %></td>
                    </tr>
                </tfoot>
            </table>

            <a href="user-order.jsp" class="back-btn">Back</a>
        </div>
<%
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<p>Error occurred: " + e.getMessage() + "</p>");
    } finally {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
</body>
</html>