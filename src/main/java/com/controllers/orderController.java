package com.controllers;

import com.dao.orderDao;
import com.dao.toyDao;
import com.dao.userDao;
import com.model.Order;
import com.model.Toy;
import com.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;

@WebServlet("/orderController")
public class orderController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private toyDao toydao;

    public void init() {
        toydao = new toyDao();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect("error.jsp"); // Handle unknown actions
            return;
        }

        switch (action) {
            case "addorder":
                processOrder(request, response);
                break;
            case "update":
                update(request, response);
                break;
            case "deleteorder":
                deleteOrderAdmin(request, response);
                break;

            default:
                response.sendRedirect("error.jsp");
                break;
        }
    }
    private void deleteOrderAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String orderid = request.getParameter("deleteOrderAdminId");
        System.out.println("Deleting order2 " + orderid);
        orderDao orderDao = new orderDao();
        orderDao.delete(orderid);
        response.sendRedirect("admin-order.jsp");
    }

    protected void processOrder(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productIdsParam = request.getParameter("productId");
        String[] productIds = productIdsParam.split(",");
        String totalPrice = request.getParameter("totalPrice");
        String address = request.getParameter("address");
        int userId = Integer.parseInt(request.getParameter("userid"));

        orderDao orderDAO = new orderDao();
        try {

            int orderId = orderDAO.insertOrder(userId, totalPrice, productIds, address);

            if (orderId > 0) {
                response.sendRedirect("user-orderconfirmation.jsp?orderId=" + orderId);
            } else {
                response.getWriter().write("Error: Could not process order.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error: " + e.getMessage());
        }
    }

    private void update(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String status = request.getParameter("status");
        int orderId = Integer.parseInt(request.getParameter("orderId"));

        orderDao orderDao = new orderDao();
        Order order = new Order(orderId, status);

        boolean updated = orderDao.update(order);

        if (updated) {
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<script type='text/javascript'>");
            out.println("alert(' updated successfully');");
            out.println("window.location = 'admin-orderdetail.jsp?orderId=" + orderId + "';");
            out.println("</script>");
        } else {
            response.sendRedirect("error2.jsp");
        }
    }

}