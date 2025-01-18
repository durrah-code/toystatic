<!doctype html>
<html>
<html>
<%@ page import="java.util.Base64" %>
<%@ page import="com.model.User"%>
<%@page import="com.db.DatabaseConnection"%>
<%@page import="java.sql.*"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    User user = (User) session.getAttribute("user");

%>
<style>

<style>

.card {

    height: 400px; /* Fixed height */

}
}

</style>
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
                int userID = user.getId();

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
        <div class="gallery">

        <%
            Connection con = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
				con = DatabaseConnection.getConnection();

                String query = "SELECT * FROM toy ";
                stmt = con.prepareStatement(query);
                rs = stmt.executeQuery();

                while (rs.next()) {
        %>
            <a>
                <div class="card" style="height:400px">
                    <%
                        String image = rs.getString("image");
                        if (image != null && !image.isEmpty()) {
                            // Encode the image data to Base64
                            String base64Image = Base64.getEncoder().encodeToString(rs.getBytes("image"));
                    %>
                    <img src="data:image/jpeg;base64,<%= base64Image %>" alt="Product Image" class="w-20 h-20 object-cover"
                    style="height:250px;"/>
                    <%
                        } else {
                    %>
                    No Image
                    <%
                        }
                    %>
                    <p class="book-title"><%= rs.getString("name") %></p>
                    <p class="price">RM<%= rs.getString("price") %></p>


                         <form method="POST" action="cartController" class="card-form">
                             <input type="hidden" name="prodid" value="<%= rs.getString("id") %>">
                             <input type="hidden" name="userid" value="<%=user.getId()%>">
                             <input type="hidden" name="action" value="addprod">
                             <button type="submit" name="addtocart" class="addcart">Add to Cart</button>
                         </form>
                </div>
            </a>
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


            </div>
    </main>


</body>

</html>