<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.demo.models.Property" %>
<%@ page import="com.example.demo.service.PropertyManager" %>
<%@ page import="java.util.*" %>

<%
    String propertyId = request.getParameter("id");
    PropertyManager propertyManager = new PropertyManager();
    Property selectedProperty = propertyManager.getPropertyById(propertyId);

    if (selectedProperty == null && propertyId != null) {
%>
<h2>Property not found.</h2>
<a href="sellerdashboard">Back to Dashboard</a>
<%
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title><%= (propertyId != null) ? "Edit Property" : "Create Property" %></title>
    <link rel="stylesheet" href="css/seller-ashboard.css">
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
            max-width: 300px; /* Smaller image */
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
        .submit-btn {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 12px;
            width: 100%;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1rem;
            margin-top: 20px;
        }
        .submit-btn:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

<div class="property-details-container">
    <h2><%= (propertyId != null) ? "Edit Property" : "Create Property" %></h2>

    <form action="<%= (propertyId != null) ? "update-property" : "create-property" %>" method="POST" enctype="multipart/form-data">
        <% if (propertyId != null) { %>
        <input type="hidden" name="id" value="<%= selectedProperty.getId() %>">
        <% } %>

        <label for="title">Property Title:</label>
        <input type="text" name="title" id="title" value="<%= (propertyId != null) ? selectedProperty.getTitle() : "" %>" required>

        <label for="location">Location:</label>
        <input type="text" name="location" id="location" value="<%= (propertyId != null) ? selectedProperty.getLocation() : "" %>" required>

        <label for="type">Property Type:</label>
        <select name="type" id="type" required>
            <option value="House" <%= (propertyId != null && "House".equals(selectedProperty.getType())) ? "selected" : "" %>>House</option>
            <option value="Apartment" <%= (propertyId != null && "Apartment".equals(selectedProperty.getType())) ? "selected" : "" %>>Apartment</option>
            <option value="Villa" <%= (propertyId != null && "Villa".equals(selectedProperty.getType())) ? "selected" : "" %>>Villa</option>
            <option value="Bungalow" <%= (propertyId != null && "Bungalow".equals(selectedProperty.getType())) ? "selected" : "" %>>Bungalow</option>
        </select>

        <label for="description">Description:</label>
        <textarea name="description" id="description" required><%= (propertyId != null) ? selectedProperty.getDescription() : "" %></textarea>

        <label for="price">Price ($):</label>
        <input type="number" name="price" id="price" value="<%= (propertyId != null) ? selectedProperty.getPrice() : "" %>" required step="0.01">

        <label for="radius">Radius (ft):</label>
        <input type="number" name="radius" id="radius" value="<%= (propertyId != null) ? selectedProperty.getRadius() : "" %>" required step="1">

        <label for="image">Image:</label>
        <input type="file" name="image" accept="image/*">

        <% if (propertyId != null && selectedProperty.getImageFileName() != null) { %>
        <div class="small-box">
            <p>Current Image:</p>
            <img src="images/<%= selectedProperty.getImageFileName() %>" alt="Property Image">
        </div>
        <% } %>

        <label for="phoneNumber">Seller's Phone Number:</label>
        <input type="text" name="phoneNumber" id="phoneNumber" value="<%= (propertyId != null) ? selectedProperty.getSellerPhone() : "" %>" required>

        <input type="submit" value="<%= (propertyId != null) ? "Update Property" : "Create Property" %>" class="submit-btn">
    </form>

    <a href="seller-dashboard" class="back-btn">← Back to Dashboard</a>
</div>

</body>
</html>
