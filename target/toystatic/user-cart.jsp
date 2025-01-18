<!doctype html>
<html>
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
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Toy Static</title>
  <link href="inc/style.css" rel="stylesheet" type="text/css">
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
<main>
    <div class="cart-container">
        <h1 style="text-align: center;">Shopping Cart</h1>
        <br><br>
        <table class="cart-table">
            <thead>
                <tr>
                    <th>Item</th>
                    <th>Title</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
<%
    // Queries to fetch cart items
    String query1 = "SELECT t.*, c.id AS CartID, COUNT(c.prodId) AS quantity " +
                    "FROM cart c " +
                    "JOIN toy t ON c.prodId = t.id " +
                    "WHERE c.userId = ? " +
                    "GROUP BY t.id";

    String query2 = "SELECT c.prodId " +
                    "FROM cart c " +
                    "WHERE c.userId = ?";

    Connection con = null;
    PreparedStatement stmt1 = null, stmt2 = null;
    ResultSet rs1 = null, rs2 = null;
    double total = 0.0;
    List<Integer> productIDs = new ArrayList<>();

    try {
        // Establish database connection
        con = DatabaseConnection.getConnection();

        // Fetch product IDs
        stmt2 = con.prepareStatement(query2);
        stmt2.setInt(1, userID);
        rs2 = stmt2.executeQuery();
        while (rs2.next()) {
            productIDs.add(rs2.getInt("prodId"));
        }

        // Fetch cart items
        stmt1 = con.prepareStatement(query1);
        stmt1.setInt(1, userID);
        rs1 = stmt1.executeQuery();

        while (rs1.next()) {
            byte[] imageBytes = rs1.getBytes("image");
            String imageData = imageBytes != null ? Base64.getEncoder().encodeToString(imageBytes) : null;
            double price = rs1.getDouble("price");
            int quantity = rs1.getInt("quantity");
            total += price * quantity;
%>
                <tr>
                    <td>
                        <% if (imageData != null) { %>
                            <img src="data:image/jpeg;base64,<%= imageData %>" alt="Product Image" class="w-20 h-20 object-cover" />
                        <% } else { %>
                            No Image
                        <% } %>
                    </td>
                    <td><%= rs1.getString("name") %></td>
                    <td>RM <%= String.format("%.2f", price) %></td>
                    <td><%= quantity %></td>
                    <td>
                        <form action="cartController" method="post">
                             <input type="hidden" name="action" value="deleteprod">
                             <input type="hidden" name="id" value="<%= rs1.getInt("CartID") %>">
                            <button type="submit" class="remove-btn btndel">Remove</button>
                        </form>


                    </td>
                </tr>
<%
        }
    } catch (Exception e) {
        e.printStackTrace(new PrintWriter(out));
    } finally {
        if (rs1 != null) try { rs1.close(); } catch (Exception ignored) {}
        if (rs2 != null) try { rs2.close(); } catch (Exception ignored) {}
        if (stmt1 != null) try { stmt1.close(); } catch (Exception ignored) {}
        if (stmt2 != null) try { stmt2.close(); } catch (Exception ignored) {}
        if (con != null) try { con.close(); } catch (Exception ignored) {}
    }
%>
            </tbody>
        </table>
        <br>
        <div class="cart-summary">
            <p>Total: RM <%= String.format("%.2f", total) %></p>
            <form action="orderController" method="post" onsubmit="return validateCheckout();">
                <input type="hidden" name="productId" value="<%= productIDs.stream().map(String::valueOf).collect(Collectors.joining(",")) %>">
                <input type="hidden" name="totalPrice" value="<%= String.format("%.2f", total) %>">
                <input type="hidden" name="userid" value="<%=user.getId()%>">
                <input type="hidden" name="address" value="<%=user.getAddress()%>">
                <input type="hidden" name="action" value="addorder">
                <button type="submit" class="remove-btn checkout-btn">Proceed to Checkout</button>
            </form>

        </div>
    </div>
</main>




<script>
  function validateCheckout() {
      const productCount = document.querySelectorAll('.cart-table tbody tr').length;

      if (productCount === 0) {
          alert('No products in your cart. Please add products before proceeding to checkout.');
          return false;
      }

      const confirmCheckout = confirm('Would you like to proceed with your order?');
      return confirmCheckout;
  }
</script>

</body>

</html>
