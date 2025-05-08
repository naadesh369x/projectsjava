package com.example.demo;

import com.example.demo.utils.FileHandler;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(name = "AuthServlet", value = "/login")
public class AuthServlet extends HttpServlet {
    private static final String USERS_FILE = "users.txt"; // All roles stored here

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        String[] records = FileHandler.readFromFile(USERS_FILE);

        for (String record : records) {
            String[] parts = record.split(",");

            // Match email, password, and role
            if (parts.length == 3 && parts[0].equals(email) && parts[1].equals(password) && parts[2].equals(role)) {
                // Set session attributes
                HttpSession session = request.getSession();
                session.setAttribute("email", email);
                session.setAttribute("role", role);

                // Redirect based on role
                switch (role) {
                    case "seller":
                        response.sendRedirect("seller-dashboard");
                        break;
                    case "admin":
                        response.sendRedirect("admin-dashboard");
                        break;
                    default:
                        response.sendRedirect("user-dashboard");
                }
                return;
            }
        }

        // No match found
        response.sendRedirect("login.jsp?error=Invalid email, password, or role");
    }
}
