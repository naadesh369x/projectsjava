package com.example.demo;

import com.example.demo.service.UserManager;
import com.example.demo.models.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin-dashboard")
public class AdminDashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if the user is an admin
        String role = (String) request.getSession().getAttribute("role");
        if (role == null || !role.equals("admin")) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Initialize UserManager for admin role
        UserManager userManager = new UserManager("admin");

        // Fetch all users
        List<User> users = userManager.getAllUsers();

        // Set the user list as an attribute to forward to the JSP
        request.setAttribute("users", users);

        // Forward the request to the admin dashboard JSP
        request.getRequestDispatcher("admindashboard.jsp").forward(request, response);
    }
}
