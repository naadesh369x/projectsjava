package com.example.demo;

import com.example.demo.models.Property;
import com.example.demo.service.PropertyManager;
import com.example.demo.utils.FileHandler;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@WebServlet("/add-property")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1,    // 1MB
        maxFileSize = 1024 * 1024 * 10,                  // 10MB
        maxRequestSize = 1024 * 1024 * 15)               // 15MB
public class AddPropertyServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form data
        String id = request.getParameter("id");
        String title = request.getParameter("title");
        String location = request.getParameter("location");
        String type = request.getParameter("type");
        String priceStr = request.getParameter("price");
        String radiusStr = request.getParameter("radius");
        String description = request.getParameter("description");
        String sellerPhone = request.getParameter("sellerPhone");

        // Parse price and radius values
        double price = 0.0;
        double radius = 0.0;
        try {
            price = Double.parseDouble(priceStr);
            radius = Double.parseDouble(radiusStr);
        } catch (NumberFormatException e) {
            e.printStackTrace(); // Optionally handle invalid input
        }

        // Handle image file upload
        Part filePart = request.getPart("image");
        String imageFileName = null;
        if (filePart != null && filePart.getSize() > 0) {
            imageFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadDir = getServletContext().getRealPath("/images/");
            File uploadFolder = new File(uploadDir);
            if (!uploadFolder.exists()) {
                uploadFolder.mkdirs();
            }

            String filePath = uploadDir + File.separator + imageFileName;
            filePart.write(filePath);
        }

        // Get seller's email from session
        HttpSession session = request.getSession();
        String userEmail = (String) session.getAttribute("email");

        // Create a new Property object with all fields
        Property property = new Property(id, title, location, type, price, radius, description,
                imageFileName, null, userEmail, sellerPhone);

        // Save using PropertyManager
        PropertyManager manager = new PropertyManager();
        manager.addProperty(property);

        // Write to file
        FileHandler.writeToFile("properties.txt", true, property.toFileString());

        // Redirect
        response.sendRedirect("seller-dashboard");
    }
}
