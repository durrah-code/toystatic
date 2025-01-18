package com.controllers;

import com.dao.cartDao;
import com.dao.toyDao;
import com.model.Cart;
import com.model.Toy;

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

@WebServlet("/cartController")
public class cartController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private cartDao cartDao;

    public void init() {
        cartDao = new cartDao();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect("error.jsp"); // Handle unknown actions
            return;
        }

        switch (action) {
            case "addprod":
                add(request, response);
                break;
            case "deleteprod":
                delete(request, response);
                break;
            default:
                response.sendRedirect("error.jsp");
                break;
        }
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        cartDao.delete(id);
        response.sendRedirect("user-cart.jsp");
    }

    private void add(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        int userid = Integer.parseInt(request.getParameter("userid"));
        int prodid = Integer.parseInt(request.getParameter("prodid"));
        Cart cart = new Cart(prodid, userid );

        cartDao.save(cart);

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<script type='text/javascript'>");
        out.println("alert('added to cart');");
        out.println("window.location = 'user-dashboard.jsp';");
        out.println("</script>");

    }

}