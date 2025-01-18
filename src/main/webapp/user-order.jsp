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
    <h1 style="text-align: center;">Shopping Order</h1>
    <br><br>
    <table class="cart-table">
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Status</th>
                        <th>Price</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                <%
                  Connection con = null;
                  PreparedStatement stmt = null;
                  ResultSet rs = null;

                  try {
                       // Database connection
                         con = DatabaseConnection.getConnection();
                       String query = "SELECT *" +
                                      "FROM orders  ";

                       stmt = con.prepareStatement(query);
                       rs = stmt.executeQuery();

                       while (rs.next()) {
                      %>
                      <tr>
                          <td ><%= rs.getString("date") %></td>
                          <td ><%= rs.getString("status") %></td>
                          <td ><%= rs.getString("totalPrice") %></td>
                     <td class="px-6 py-4 whitespace-nowrap">
                        <a href="user-orderdetail.jsp?id=<%= rs.getString("id") %>" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2.5 px-4 rounded mr-2">View</a>
                    </td>

                         </tr>
                           <%
                             }
                                } catch (Exception e) {
                                   e.printStackTrace();
                                 } finally {
                                 if (rs != null) rs.close();
                                 if (stmt != null) stmt.close();
                                 if (con != null) con.close();
                                 }
                            %>
                </tbody>
            </table>



  </div>
</main>
<script>
  function validateCheckout() {
      // Get the number of products in the cart
      const productCount = document.querySelectorAll('.cart-table tbody tr').length;

      // Check if there are no products
      if (productCount === 0) {
          alert('No products in your cart. Please add products before proceeding to checkout.');
          return false; // Prevent form submission
      }

      // Ask for confirmation
      const confirmCheckout = confirm('Would you like to proceed with your order?');
      return confirmCheckout; // Only submit if the user confirms
  }
</script>
        <script>
            document.addEventListener("DOMContentLoaded", function() {
                var deleteButtons = document.querySelectorAll(".btndel");

                if (deleteButtons) {
                    deleteButtons.forEach(function(button) {
                        button.addEventListener("click", function() {
                            // Get the T_ID from the value attribute of the button
                            var deleteID = this.value;

                            // Confirm deletion
                            var confirmDelete = confirm("Are you sure you want to remove this item?");

                            // If the user confirms, proceed with the deletion
                            if (confirmDelete) {
                                try {
                                    // Redirect to delprocess.php with the deleteID parameter
                                    window.location.href = "proc/Cart.php?fid=" + deleteID + "&removefromcart=true";
                                } catch (error) {
                                    console.error("Error in JavaScript: ", error);
                                }
                            }
                        });
                    });
                }
            });
</script>
</body>

</html>
