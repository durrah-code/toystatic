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

    int orderID = Integer.parseInt(request.getParameter("orderId"));
%>

<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Toy Static</title>
    <link href="inc/style.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
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

    <main id="novels">
        <div class="cart-container">
            <h1 style="text-align: center;">Order Confirmation</h1>

            <p>Thank you for your order!</p>
            <p>Your order ID is: <strong><%= orderID %></strong></p>
            <h2>Order Details</h2>
            <table class="cart-table">
                <thead>
                    <tr>
                        <th>Product</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Total</th>
                    </tr>
                </thead>
                <tbody>
                <%


                    String query = "SELECT t.name, t.price, COUNT(c.prodID) AS quantity, " +
                                    "t.image " +
                                    "FROM orders o " +
                                    "JOIN order_product c ON o.Id = c.orderId " +
                                    "JOIN toy t ON c.prodId = t.Id " +
                                    "WHERE o.Id = ? " +
                                    "GROUP BY t.name, t.price";
                    Connection con = DatabaseConnection.getConnection();
                    PreparedStatement pstmt = con.prepareStatement(query);
                    pstmt.setInt(1, orderID);
                    ResultSet resultSet = pstmt.executeQuery();

                    double total = 0;
                    while (resultSet.next()) {
                        String productName = resultSet.getString("name");
                        double price = resultSet.getDouble("price");
                        int quantity = resultSet.getInt("quantity");
                        byte[] imageData = resultSet.getBytes("image");

                        double lineTotal = price * quantity;
                        total += lineTotal;
                %>
                        <tr>
                            <td><img src="data:image/jpeg;base64,<%= Base64.getEncoder().encodeToString(imageData) %>" alt="Product Image" class="w-20 h-20 object-cover" /></td>
                            <td>RM <%= String.format("%.2f", price) %></td>
                            <td><%= quantity %></td>
                            <td>RM <%= String.format("%.2f", lineTotal) %></td>
                        </tr>
                <%
                    }
                %>
                </tbody>
            </table>
            <h3 class="total-price">Total Price: RM <%= String.format("%.2f", total) %></h3>

            <a href="user-dashboard.jsp" class="remove-btn checkout-btn">Return to Home</a>
        </div>
    </main>
</body>

</html>