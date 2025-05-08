package com.example.demo;

import com.example.demo.service.PropertyManager;
import com.example.demo.models.Property;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.util.List;

@WebServlet("/edit-property")
public class EditPropertyServlet extends HttpServlet {

    // Handle GET request to fetch the property and display the edit page
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String propertyId = request.getParameter("id");

        if (propertyId == null || propertyId.isEmpty()) {
            response.sendRedirect("error.jsp");  // Redirect to error page if no ID
            return;
        }

        // Use PropertyManager to get the property by ID
        Property property = PropertyManager.findPropertyById(propertyId);
        if (property == null) {
            response.sendRedirect("error.jsp");  // Redirect to error page if property not found
            return;
        }

        // Set the property as a request attribute and forward to the edit JSP
        request.setAttribute("property", property);
        request.getRequestDispatcher("editproperty.jsp").forward(request, response);
    }

    // Handle POST request to update the property details
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String propertyId = request.getParameter("id");
        String title = request.getParameter("title");
        String location = request.getParameter("location");
        String type = request.getParameter("type");
        double price = Double.parseDouble(request.getParameter("price"));
        double radius = Double.parseDouble(request.getParameter("radius"));
        String description = request.getParameter("description");
        String phoneNumber = request.getParameter("phoneNumber");

        // Handle image upload (if any)
        String imageFileName = null;
        Part imagePart = request.getPart("image");
        if (imagePart != null && imagePart.getSize() > 0) {
            String fileName = getFileName(imagePart);
            String savePath = getServletContext().getRealPath("/") + "images/" + fileName;
            imagePart.write(savePath);
            imageFileName = fileName;
        }

        Property property = new Property(propertyId, title, location, type, price, radius, description, imageFileName, null, null, phoneNumber);

        // Use PropertyManager to update the property
        boolean updated = PropertyManager.updateProperty(property);
        if (updated) {
            response.sendRedirect("seller-dashboard" + propertyId);  // Redirect to updated property details page
        } else {
            response.sendRedirect("error.jsp");  // Redirect to error page if update fails
        }
    }

    // Helper method to get the file name from the uploaded file
    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("Content-Disposition");
        for (String cd : contentDisposition.split(";")) {
            if (cd.trim().startsWith("filename")) {
                String filename = cd.substring(cd.indexOf("=") + 2, cd.length() - 1);
                return filename;
            }
        }
        return "";
    }
}
