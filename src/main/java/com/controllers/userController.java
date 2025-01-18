package com.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.userDao;
import com.model.Admin;
import com.model.User;

@WebServlet("/userController")
public class userController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private userDao userDao;

    public void init() {
        userDao = new userDao();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect("error.jsp"); // Handle unknown actions
            return;
        }

        switch (action) {
            case "signup":
                signup(request, response);
                break;
            case "login":
                login(request, response);
                break;
            case "logout":
                logout(request, response);
                break;
            case "update":
                update(request, response);
                break;
            default:
                response.sendRedirect("error.jsp");
                break;
        }
    }
    private void update(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        String address = request.getParameter("address");
        int userid = Integer.parseInt(request.getParameter("userid"));

        String email = request.getParameter("email");

        if (userDao.isEmailExists(email)) {
            PrintWriter out = response.getWriter();
            out.println("<script type='text/javascript'>");
            out.println("alert('Email is already registered. Please use a different email.');");
            out.println("window.location = 'user-profile.jsp';");
            out.println("</script>");
            return;
        }
        userDao userDao = new userDao();
        User user = new User(userid, name, email, password, address);
        boolean updated = userDao.update(user);

        if (updated) {
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<script type='text/javascript'>");
            out.println("alert(' updated successfully');");
            out.println("window.location = 'user-profile.jsp';");
            out.println("</script>");
        } else {

            response.sendRedirect("error.jsp");
        }
    }

    private void logout(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect("login.jsp");
    }
    private void signup(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        if (!password.equals(confirmPassword)) {
            out.println("<script type='text/javascript'>");
            out.println("alert('Password and confirm password do not match');");
            out.println("window.location = 'register.jsp';");
            out.println("</script>");
            return;
        }

        if (userDao.isEmailExists(email)) {
            out.println("<script type='text/javascript'>");
            out.println("alert('Email is already registered. Please use a different email.');");
            out.println("window.location = 'register.jsp';");
            out.println("</script>");
            return;
        }

        User user = new User( name, email, password, address);

        userDao.save(user);
        out.println("<script type='text/javascript'>");
        out.println("alert('New User Registered');");
        out.println("window.location = 'login.jsp';");
        out.println("</script>");

    }

    private void login(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = userDao.authenticate(email, password);
        Admin admin = userDao.adminAuthenticate(email, password);

        if (user != null) {
            request.getSession().setAttribute("user", user);
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<script type='text/javascript'>");
            out.println("alert('Login Successful');");
            out.println("window.location = 'user-dashboard.jsp';");
            out.println("</script>");
        }else if(admin != null){
            request.getSession().setAttribute("admin", admin);
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<script type='text/javascript'>");
            out.println("alert('Login Successful');");
            out.println("window.location = 'admin-dashboard.jsp';");
            out.println("</script>");
        }else {
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<script type='text/javascript'>");
            out.println("alert('Invalid email or password');");
            out.println("window.location = 'login.jsp';");
            out.println("</script>");
        }
    }

}