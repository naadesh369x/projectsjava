package com.example.demo;

import com.example.demo.models.User;
import com.example.demo.service.UserManager;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "RegisterServlet", value = "/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        // Create user manager for the given role
        UserManager userManager = new UserManager(role);

        // Check if user already exists
        if (userManager.findUserByEmail(email) != null) {
            response.sendRedirect("register.jsp?error=Email already exists");
            return;
        }

        // Create and add new user
        User newUser = new User(email, password, role);
        userManager.addUser(newUser);

        // Redirect to login page
        response.sendRedirect("login.jsp");
    }
}
