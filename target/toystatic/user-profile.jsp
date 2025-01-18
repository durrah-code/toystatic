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
    <style>
body {

}

.profile-form {
    margin-left: 500px;
    margin-top: 50px;
    margin-bottom: 50px;
    padding: 50px;
    justify-content: center;
    align-items: center;
    width: 100%;
    max-width: 500px;
    border: 1px solid #ddd;
    border-radius: 8px;
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
    padding: 20px;
    box-sizing: border-box;
}

.profile-form h2 {
    text-align: center;
    color: #333;
    font-size: 24px;
    margin-bottom: 20px;
}

.profile-form label {
    display: block;
    margin-bottom: 5px;
    color: #333;
    font-weight: bold;
}

.profile-form input[type="text"],
.profile-form input[type="email"],
.profile-form input[type="password"],
.profile-form textarea {
    width: 100%;
    padding: 10px;
    margin-bottom: 15px;
    border: 1px solid #ccc;
    border-radius: 5px;
    box-sizing: border-box;
    font-size: 16px;
}

.profile-form textarea {
    resize: vertical;
    height: 100px;
}

.profile-form button[type="submit"] {
    width: 100%;
    padding: 10px;
    font-size: 18px;
    background-color: #0073e6;
    color: #fff;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s;
}

.profile-form button[type="submit"]:hover {
    background-color: #005bb5;
}

        .button-container {
    display: flex;
    justify-content: center; /* Centers the button horizontally */
    margin-top: 20px; /* Adds some space above the button */
}
    </style>

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

<div class="profile-form">
    <h2>Profile Information</h2>
    <%

          Connection conn = null;
          PreparedStatement stmt = null;
          ResultSet rs = null;

          try {
              conn = DatabaseConnection.getConnection();
              String query = "SELECT * FROM user WHERE id = ? ";

              stmt = conn.prepareStatement(query);
              stmt.setInt(1, user.getId());
              rs = stmt.executeQuery();

              if (rs.next()) {
      %>
                  <form action="userController" method="POST">
                      <label for="email">Email:</label>
                      <input type="email" id="email" name="email" value="<%= rs.getString("email") %>" >

                      <label for="name">Name:</label>
                      <input type="text" id="name" name="name" value="<%= rs.getString("name") %>">

                      <label for="address">Address:</label>
                      <textarea id="address" name="address" required><%= rs.getString("address") %></textarea>

                      <label for="name">Password:</label>
                      <input type="password" id="password" name="password" value="<%= rs.getString("password") %>">

                      <input type="hidden" name="userid" value="<%= rs.getInt("id") %>">
                      <input type="hidden" name="action" value="update">

                      <div class="button-container">
                          <input type="submit" class="btn-login" name="update" value="Update Profile">
                      </div>
                  </form>
      <%
              } else {
                  out.println("<p>Unable to fetch profile data. Please try again later.</p>");
              }
          } catch (Exception e) {
              out.println("<p>Error: " + e.getMessage() + "</p>");
          } finally {
              try {
                  if (rs != null) rs.close();
                  if (stmt != null) stmt.close();
                  if (conn != null) conn.close();
              } catch (Exception ex) {
                  out.println("<p>Error closing resources: " + ex.getMessage() + "</p>");
              }
          }
      %>
</div>

</body>
</html>