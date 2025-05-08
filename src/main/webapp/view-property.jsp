<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.demo.models.Property" %>
<%@ page import="com.example.demo.service.PropertyManager" %>
<%@ page import="java.util.*" %>

<%
    String propertyId = request.getParameter("id");
    PropertyManager propertyManager = new PropertyManager();
    Property selectedProperty = propertyManager.getPropertyById(propertyId);
    List<String> comments = propertyManager.getCommentsByPropertyId(propertyId); // Fetch comments

    if (selectedProperty == null) {
%>

<h2>Property not found.</h2>
<a href="sellerdashboard">Back to Dashboard</a>
<%
        return;
    }
%>

<!DOCTYPE html>

<html>
<head>
    <title>View Property Details</title>
    <link rel="stylesheet" href="css/seller-dashboard.css">
    <style>
        .property-details-container {
            max-width: 800px;
            margin: 40px auto;
            background-color: #f8f8f8;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.2);
        }
        .property-details-container img {
            width: 100%;
            height: auto;
            border-radius: 6px;
        }
        .property-details-container h2 {
            margin-top: 20px;
            color: #333;
        }
        .property-details-container p {
            font-size: 16px;
            color: #555;
            margin: 8px 0;
        }
        .back-btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #555;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .back-btn:hover {
            background-color: #333;
        }
        .small-box {
            background-color: #eee;
            padding: 15px;
            border-radius: 5px;
            margin-top: 20px;
        }
        .comment-box {
            background-color: #fff;
            padding: 10px;
            margin: 8px 0;
            border-left: 4px solid #007BFF;
        }
        .booking-info-btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #007BFF;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            text-align: center;
        }
        .booking-info-btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<div class="property-details-container">
    <img src="images/<%= selectedProperty.getImageFileName() != null ? selectedProperty.getImageFileName() : "default.jpg" %>" alt="Property Image">
    <h2><%= selectedProperty.getTitle() %></h2>
    <p><strong>Location:</strong> <%= selectedProperty.getLocation() %></p>
    <p><strong>Type:</strong> <%= selectedProperty.getType() %></p>
    <p><strong>Price:</strong> $<%= selectedProperty.getPrice() %></p>
    <p><strong>Radius:</strong> <%= selectedProperty.getRadius() %> ft</p>
    <p><strong>Description:</strong> <%= selectedProperty.getDescription() %></p>

    <div class="small-box">
        <p><strong>Seller Phone:</strong> <%= selectedProperty.getSellerPhone() != null ? selectedProperty.getSellerPhone() : "Not provided" %></p>
        <p><strong>Booked By:</strong> <%= selectedProperty.getBookedBy() != null && !selectedProperty.getBookedBy().isEmpty() ? selectedProperty.getBookedBy() : "Not Booked" %></p>
    </div>

    <div class="small-box">
        <h3>User Comments:</h3>
        <%
            if (comments != null && !comments.isEmpty()) {
                for (String comment : comments) {
        %>
        <div class="comment-box"><%= comment %></div>
        <%
            }
        } else {
        %>
        <p>No comments available.</p>
        <%
            }
        %>
    </div>

    <!-- Always show Booking Information Button -->
    <a href="booking-info?id=<%= selectedProperty.getId() %>" class="booking-info-btn">View Booking Information</a>

    <a href="seller-dashboard" class="back-btn">← Back to Dashboard</a>
</div>

</body>
</html>
