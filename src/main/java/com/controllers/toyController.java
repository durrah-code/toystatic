package com.controllers;

import com.dao.toyDao;
import com.dao.userDao;
import com.model.Toy;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;

@WebServlet("/toyController")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class toyController extends HttpServlet {
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
            case "addtoy":
                add(request, response);
                break;
            case "deletetoy":
                delete(request, response);
                break;
            default:
                response.sendRedirect("error.jsp");
                break;
        }
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String id = request.getParameter("id");
        toyDao toyDao = new toyDao();
        toyDao.delete(id);
        response.sendRedirect("admin-dashboard.jsp");
    }
    private void add(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String price = request.getParameter("price");
        String name = request.getParameter("name");
        Part filePart = request.getPart("image"); // 'image' is the name of the file input field
        InputStream inputStream = null;

        if (filePart != null) {
            inputStream = filePart.getInputStream(); // Get file content
        }

        Toy toy = new Toy(name, price, inputStream );

        toyDao.save(toy);

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<script type='text/javascript'>");
        out.println("alert('New toy registered successfully');");
        out.println("window.location = 'admin-dashboard.jsp';");
        out.println("</script>");
    }

}