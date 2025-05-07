package com.example.demo;


import com.example.demo.utils.FileHandler;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "RegisterServlet", value = "/register")
public class RegisterServlet extends HttpServlet {
    private static final String USERS_FILE = "users.txt"; // Users file path
    private static final String SELLERS_FILE = "sellers.txt"; // Sellers file path

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        // Select file based on role (User or Seller)
        String file = role.equals("seller") ? SELLERS_FILE : USERS_FILE;

        // Check if email already exists in the corresponding file
        String[] records = FileHandler.readFromFile(file);
        for (String record : records) {
            if (record.startsWith(email + ",")) {
                response.sendRedirect("register.jsp?error=Email already exists");
                return;
            }
        }

        // Create a new record (email,password)
        String newRecord = email + "," + password + "\n";

        // Write the new user/seller information to the corresponding file
        FileHandler.writeToFile(file, true, newRecord);

        // Redirect to login page
        response.sendRedirect("login.jsp");
    }
}
