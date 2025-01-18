<%@page import="com.db.DatabaseConnection"%>
<%@page import="com.model.User"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.stream.Collectors" %>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>

<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    %>

<!DOCTYPE html>
<html lang="en">
   <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin ToyStatic</title>

        <!-- Tailwind -->
       <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.1.1/tailwind.min.css" integrity="sha512-BAK6UB671tmfzrkeH1CacTvgHQ3aLAFnT2KsigdATsc5X7+3u42tb5vjmAoDiqtxphP5dNZ3cDygivTsGEJhGw==" crossorigin="anonymous" />

    <link href="inc/style2.css" rel="stylesheet" type="text/css">
    </head>

<body class="font-family-karla flex">
    <aside class="relative bg-sidebar h-screen w-64 hidden sm:block shadow-xl">
        <div></div>
        <nav class="text-white text-base font-semibold pt-3">
            <a href="admin-dashboard.jsp" class="flex items-center hover:opacity-100 text-white py-4 pl-6 nav-item">
                <i class="fas fa-tachometer-alt mr-3"></i>
                Product List
            </a>
            <a href="AdminOrder.jsp" class="flex items-center text-white opacity-75 active-nav-link py-4 pl-6 nav-item">
                <i class="fas fa-ticket-alt mr-3"></i>
                Order List
            </a>
        </nav>
    </aside>

    <div class="w-full flex flex-col h-screen overflow-y-hidden">
        <header class="w-full items-center py-2 px-6 hidden sm:flex">
            <div class="w-1/2"></div>
            <div class="relative w-1/2 flex justify-end">
                    <form action="userController" method="post">
                         <input type="hidden" name="action" value="logout">
                        <button type="submit" class="log-btn">Log Out</button>
                    </form>
            </div>
        </header>

        <div class="w-full h-screen overflow-x-hidden border-t flex flex-col justify-between">
            <main class="w-full p-6">
                <div>
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
                                String query = "SELECT t.name, t.price, t.image, o.totalPrice, COUNT(c.prodId) AS quantity " +
                                               "FROM orders o " +
                                               "JOIN order_product c ON o.id = c.orderId " +
                                               "LEFT JOIN toy t ON c.prodId = t.id " +
                                               "WHERE o.id = ? " +
                                               "GROUP BY t.name, t.price, o.totalPrice";

                                  int orderID = Integer.parseInt(request.getParameter("orderId"));

                                Connection con = DatabaseConnection.getConnection();
                                PreparedStatement stmt = con.prepareStatement(query);
                                stmt.setInt(1, orderID);
                                ResultSet rs = stmt.executeQuery();

                                double grandTotal = 0.0;
                                while (rs.next()) {
                                    String productName = rs.getString("name");
                                    String imageBase64 = Base64.getEncoder().encodeToString(rs.getBytes("image"));
                                    double price = rs.getDouble("price");
                                    int quantity = rs.getInt("quantity");
                                    double subprice = price * quantity;
                                    grandTotal = rs.getDouble("totalPrice");
                            %>
                            <tr>
                                <td><%= productName %></td>
                                <td><img src="data:image/jpeg;base64,<%= imageBase64 %>" alt="Product Image" width="50"></td>
                                <td><%= quantity %></td>
                                <td>RM <%= String.format("%.2f", price) %></td>
                                <td>RM <%= String.format("%.2f", subprice) %></td>
                            </tr>
                            <%
                                }
                                rs.close();
                                stmt.close();
                            %>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="4" style="text-align: right;"><strong>Grand Total:</strong></td>
                                <td>RM <%= String.format("%.2f", grandTotal) %></td>
                            </tr>
                        </tfoot>
                    </table>

                    <div class="w-full leading-loose">
                        <%
                            String orderQuery = "SELECT o.date, o.status, o.shipAddress, o.id " +
                                                "FROM orders o " +
                                                "WHERE o.id = ?";

                            PreparedStatement orderStmt = con.prepareStatement(orderQuery);
                            orderStmt.setInt(1, orderID);
                            ResultSet orderRs = orderStmt.executeQuery();

                            if (!orderRs.next()) {
                                out.print("No details found for this order.");
                                return;
                            }

                            String orderDate = orderRs.getString("date");
                            String orderStatus = orderRs.getString("status");
                            String shipAddress = orderRs.getString("shipAddress");
                            orderRs.close();
                            orderStmt.close();
                        %>
                            <div class="grid grid-cols-1 mt-5 mx-7">
                                <label class="uppercase md:text-sm text-xs text-gray-500 text-light font-semibold">Order ID</label>
                                <input name="id" class="py-1 px-3 rounded-lg border-2 border-gray-300 bg-gray-200 mt-1" type="text" value="<%= orderID %>" readonly />
                            </div>
                            <div class="grid grid-cols-1 mt-5 mx-7">
                                <label class="uppercase md:text-sm text-xs text-gray-500 text-light font-semibold">Order Date</label>
                                <input name="date" class="py-1 px-3 rounded-lg border-2 border-gray-300 bg-gray-200 mt-1" type="text" value="<%= orderDate %>" readonly />
                            </div>
                            <div class="grid grid-cols-1 mt-5 mx-7">
                                <label class="uppercase md:text-sm text-xs text-gray-500 text-light font-semibold">Address</label>
                                <input name="address" class="py-1 px-3 rounded-lg border-2 border-gray-300 bg-gray-200 mt-1" type="text" value="<%= shipAddress %>" readonly />
                            </div>
                            <form action="orderController" method="POST">
                            <div class="grid grid-cols-1 mt-5 mx-7">
                                <label class="uppercase md:text-sm text-xs text-gray-500 text-light font-semibold">Status</label>
                                <select name="status" class="py-1 px-3 rounded-lg border-2 border-gray-300 mt-1">
                                    <option value="Pending" <%= "Pending".equals(orderStatus) ? "selected" : "" %>>Pending</option>
                                    <option value="Shipped" <%= "Shipped".equals(orderStatus) ? "selected" : "" %>>Shipped</option>
                                    <option value="Delivered" <%= "Delivered".equals(orderStatus) ? "selected" : "" %>>Delivered</option>
                                    <option value="Cancelled" <%= "Cancelled".equals(orderStatus) ? "selected" : "" %>>Cancelled</option>
                                </select>
                            </div>
                            <input type="hidden" name="orderId" value="<%= orderID %>">
                            <input type="hidden" name="action" value="update">
                            <div style="display: flex; justify-content: center; margin-top: 10px;">
                                <button class="px-4 py-1 text-white font-light tracking-wider bg-green-500 rounded hover:bg-green-700" type="submit">
                                    <i class="fas fa-check mr-3"></i>
                                    Done
                                </button>
                            </div>
                        </form>
                        <div>
                            <a class="w-full text-md hover:underline" href="admin-order.jsp">Back</a>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/js/all.min.js" integrity="sha256-KzZiKy0DWYsnwMF+X1DvQngQ2/FxF7MF3Ff72XcpuPs=" crossorigin="anonymous"></script>

</body>

</html>