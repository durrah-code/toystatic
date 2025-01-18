<%@page import="com.db.DatabaseConnection"%>
<%@page import="java.sql.*"%>
<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>



<html lang="en">
    <head>
        <meta charset="UTF-8">

        <title>Admin ToyStatic</title>

       <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.1.1/tailwind.min.css" integrity="sha512-BAK6UB671tmfzrkeH1CacTvgHQ3aLAFnT2KsigdATsc5X7+3u42tb5vjmAoDiqtxphP5dNZ3cDygivTsGEJhGw==" crossorigin="anonymous" />
        <link href="inc/style2.css" rel="stylesheet" type="text/css">
    </head>
    <body class="flex">

        <aside class="relative bg-sidebar h-screen w-64 hidden sm:block shadow-xl">

            <nav class="text-white text-base font-semibold pt-3">
                <a href="admin-dashboard.jsp" class="flex items-center  text-white py-4 pl-6 nav-item">
                    <i class="fas fa-tachometer-alt mr-3"></i>
                    Toy List
                </a>
                <a href="admin-order.jsp" class="flex items-center  active-nav-link text-white  hover:opacity-100 py-4 pl-6 nav-item">
                    <i class="fas fa-ticket-alt mr-3"></i>
                    Order List
                </a>
            </nav>
        </aside>


        <div class="w-full flex flex-col h-screen overflow-y-hidden">
            <header class="w-full items-center  py-2 px-6 hidden sm:flex">
                <div class="w-1/2">

                </div>
                <div x-data="{ isOpen: false }" class="relative w-1/2 flex justify-end">

                    <form action="userController" method="post">
                         <input type="hidden" name="action" value="logout">
                        <button type="submit" class="log-btn">Log Out</button>
                    </form>
                </div>
            </header>


        <div class="w-full h-screen overflow-x-hidden border-t flex flex-col justify-between">
            <main class="px-4 py-8">
                 <h1 class="text-3xl font-semibold mb-4 text-center">List of Order</h1>
                    <div class="container mx-auto">

                        <div class="bg-white shadow-md rounded-md overflow-hidden">

            <table class="cart-table">
              <thead class="bg-gray-50">
                <tr>
                  <th >ID</th>
                  <th >Date</th>
                  <th >Buyer</th>
                  <th >Price</th>
                  <th >Status</th>
                  <th >Action</th>
                </tr>
              </thead>
              <tbody >

				 <%
					Connection con = null;
					PreparedStatement stmt = null;
					ResultSet rs = null;

					try {
						con = DatabaseConnection.getConnection();
						String query = "SELECT * FROM orders o JOIN user u ON o.custId = u.id";
						stmt = con.prepareStatement(query);
						rs = stmt.executeQuery();

						while (rs.next()) {
                            String orderid = rs.getString("id");
				%>
                <tr>
                    <td><%= rs.getString("id") %></td>
                    <td><%= rs.getString("date") %></td>
                    <td><%= rs.getString("name") %></td>
                    <td>RM <%= rs.getDouble("totalprice") %></td>
                    <td><%= rs.getString("status") %></td>

                    <td>
                        <div class="flex">
                        <a href="admin-orderdetail.jsp?orderId=<%= orderid %>"
                           class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded mb-4 mr-2">Update</a>


                        <form action="orderController" method="POST" id>
                            <input type="hidden" name="action" value="deleteorder">
                            <input type="hidden" name="deleteOrderAdminId" value="<%= orderid %>">
                            <button
                                    type="submit"
                                    name="delete"
                                    class="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded ">
                                Delete
                            </button>
                        </form>
                        </div>
                    </td>

                        </tr>

 <%
						                }
						            } catch (SQLException e) {
						                e.printStackTrace();
						            } finally {
						                try {
						                    if (rs != null) rs.close();
						                    if (stmt != null) stmt.close();
						                    if (con != null) con.close();
						                } catch (SQLException e) {
						                    e.printStackTrace();
						                }
						            }
						        %>
              </tbody>
            </table>
                        </div>

                    </div>
                </main>

                        </div>

        </div>

        <!-- AlpineJS -->
        <script src="https://cdn.jsdelivr.net/gh/alpinejs/alpine@v2.x.x/dist/alpine.min.js" defer></script>
        <!-- Font Awesome -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/js/all.min.js" integrity="sha256-KzZiKy0DWYsnwMF+X1DvQngQ2/FxF7MF3Ff72XcpuPs=" crossorigin="anonymous"></script>




    </body>
</html>