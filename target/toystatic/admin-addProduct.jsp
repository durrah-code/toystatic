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
    <body class=" font-family-karla flex">

        <aside class="relative bg-sidebar h-screen w-64 hidden sm:block shadow-xl">

            <nav class="text-white text-base font-semibold pt-3">
                <a href="admin-dashboard.jsp" class="flex items-center active-nav-link text-white py-4 pl-6 nav-item">
                    <i class="fas fa-tachometer-alt mr-3"></i>
                    Toy List
                </a>
                <a href="admin-order.jsp" class="flex items-center text-white opacity-75 hover:opacity-100 py-4 pl-6 nav-item">
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
                <div class="container mx-auto">
                 <h1 class="text-3xl font-semibold mb-4 text-center">Add New Toy</h1>

         <form action="toyController" method="POST" class="max-w-sm mx-auto"  enctype="multipart/form-data">
          <div class="mb-4">
            <label class="block text-gray-700 text-sm font-bold mb-2">Name:</label>
            <input class="appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="name" name="name" type="text" required>
          </div>

            <div class="mb-4">
                <label class="block text-gray-700 text-sm font-bold mb-2">Price: RM</label>
                <input
                    class="appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                    id="price"
                    name="price"
                    type="text"
                    pattern="^\d+(\.\d{1,2})?$"
                    title="Enter a valid price, e.g. 10.99"
                    required>
            </div>

            <div class="form-group row col-lg-8 offset-lg-2 col-md-8 offset-md-2 col-sm-12">
                <label class="block text-gray-700 text-sm font-bold mb-2">Toy Pictures:</label>
                <div class="file-upload-wrapper col-sm-8">
                    <input type="file" name="image" accept="image/*" required id="imageInput" >
                </div>
            </div>
            <br>

          <input type="hidden" name="action" value="addtoy">

          <div class="flex items-center justify-center">
            <button type="submit" value="Submit" class="group relative w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white add-btn focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
              Add Product
            </button>

          </div>
         <a class="w-full text-md  font-semibold hover:underline" href="admin-dashboard.jsp">Back</a>

        </form>



             </div>
            </main>

                        </div>

        </div>


        <script src="https://cdn.jsdelivr.net/gh/alpinejs/alpine@v2.x.x/dist/alpine.min.js" defer></script>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/js/all.min.js" integrity="sha256-KzZiKy0DWYsnwMF+X1DvQngQ2/FxF7MF3Ff72XcpuPs=" crossorigin="anonymous"></script>

    </body>
</html>