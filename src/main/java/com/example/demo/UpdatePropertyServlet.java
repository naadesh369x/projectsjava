package com.example.demo;

import com.example.demo.models.Property;
import com.example.demo.service.PropertyManager;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.*;
import java.nio.file.*;
import java.util.*;
import jakarta.servlet.http.Part;

@WebServlet("/update-property")
public class UpdatePropertyServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get updated values from the form
        String propertyId = request.getParameter("id");
        String title = request.getParameter("title");
        String location = request.getParameter("location");
        String type = request.getParameter("type");
        double price = Double.parseDouble(request.getParameter("price"));
        double radius = Double.parseDouble(request.getParameter("radius"));
        String description = request.getParameter("description");
        String phoneNumber = request.getParameter("phoneNumber");
        Part imagePart = request.getPart("image");

        // Assuming image file processing logic
        String imageFileName = null;
        if (imagePart != null && imagePart.getSize() > 0) {
            // Process and save the image file
            String uploadDir = getServletContext().getRealPath("/images");
            imageFileName = saveFile(imagePart, uploadDir);  // Save image logic
        }

        // Create updated Property object
        Property property = new Property(propertyId, title, location, price, type, description, radius, imageFileName, phoneNumber);

        // Update property in the backend (File or DB)
        boolean isUpdated = PropertyManager.updateProperty(property);

        if (isUpdated) {
            response.sendRedirect("seller-dashboard");  // Redirect back to seller dashboard after successful update
        } else {
            response.sendRedirect("error.jsp");  // Handle error case
        }
    }

    private String saveFile(Part part, String uploadDir) throws IOException {
        String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
        File file = new File(uploadDir, fileName);
        try (InputStream input = part.getInputStream()) {
            Files.copy(input, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
        }
        return fileName;
    }
}
