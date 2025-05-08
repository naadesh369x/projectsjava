package com.example.demo;


import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import com.example.demo.service.PropertyManager;

@WebServlet("/comment")
public class CommentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String propertyId = request.getParameter("propertyId");
        String commentText = request.getParameter("commentText");

        if (propertyId != null && commentText != null && !commentText.trim().isEmpty()) {
            PropertyManager manager = new PropertyManager();
            manager.addCommentToProperty(propertyId, commentText);
        }

        response.sendRedirect("user-property-details.jsp?id=" + propertyId);
    }
}
