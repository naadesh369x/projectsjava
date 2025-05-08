<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.io.*" %>
<%@ page import="com.example.demo.models.Property" %>
<%@ page import="com.example.demo.service.PropertyManager" %>

<%
    String userEmail = (String) session.getAttribute("email");
    if (userEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<String> favIds = new ArrayList<>();
    File file = new File("favorites.txt");
    if (file.exists()) {
        try (BufferedReader br = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 2 && parts[0].equals(userEmail)) {
                    favIds.add(parts[1]);
                }
            }
        }
    }

    List<Property> allProps = com.example.demo.service.PropertyManager.getProperties();
    List<Property> favProps = new ArrayList<>();
    for (Property p : allProps) {
        if (favIds.contains(p.getId())) {
            favProps.add(p);
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Your Favorite Properties</title>
    <link rel="stylesheet" href="css/user-dashboard.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 20px;
        }

        h2 {
            text-align: center;
            color: #4CAF50;
        }

        .property-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            margin-top: 30px;
        }

        .property-card {
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            width: 320px;
            overflow: hidden;
        }

        .property-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-bottom: 1px solid #ddd;
        }

        .property-info {
            padding: 15px;
        }

        .property-info h3 {
            margin-top: 0;
        }

        .unfavorite-btn {
            background-color: #e53935;
            color: white;
            padding: 8px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .unfavorite-btn:hover {
            background-color: #c62828;
        }

        p {
            color: #333;
        }
    </style>
</head>
<body>

<h2>Your Favorite Properties</h2>

<div class="property-container">
    <% if (favProps.isEmpty()) { %>
    <p>No favorite properties found.</p>
    <% } else {
        for (Property property : favProps) {
    %>
    <div class="property-card">
        <img src="images/<%= property.getImageFileName() != null ? property.getImageFileName() : "default.jpg" %>" class="property-image">
        <div class="property-info">
            <h3><%= property.getTitle() %></h3>
            <p><strong>Location:</strong> <%= property.getLocation() %></p>
            <p><strong>Type:</strong> <%= property.getType() %></p>
            <p><strong>Price:</strong> $<%= property.getPrice() %></p>
            <p><strong>Description:</strong> <%= property.getDescription() %></p>

            <form action="remove-favorite-property" method="post">
                <input type="hidden" name="propertyId" value="<%= property.getId() %>">
                <input type="submit" value="✕ Remove from Favorites" class="unfavorite-btn">
            </form>
        </div>
    </div>
    <% } } %>
</div>

</body>
</html>
