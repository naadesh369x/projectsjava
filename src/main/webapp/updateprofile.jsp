<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.demo.models.Property" %>

<%
    // Get the logged-in user's email from the session
    String email = (String) session.getAttribute("email");

    if (email == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Property property = (Property) request.getAttribute("property");
    String errorMessage = (String) request.getAttribute("errorMessage");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Property</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .container {
            width: 500px;
            background: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #4CAF50;
        }

        .error-message {
            color: #f44336;
            background-color: #ffe6e6;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
        }

        label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
        }

        input[type="text"],
        select,
        textarea {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border-radius: 5px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        input[type="file"] {
            margin-top: 10px;
        }

        .submit-btn {
            margin-top: 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 12px;
            width: 100%;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1rem;
        }

        .submit-btn:hover {
            background-color: #45a049;
        }

        .existing-image {
            margin-top: 10px;
        }

        .existing-image img {
            width: 100px;
            border-radius: 4px;
        }

        .top-bar {
            text-align: right;
            margin-bottom: 15px;
        }

        .logout-btn {
            padding: 6px 10px;
            background-color: #f44336;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .logout-btn:hover {
            background-color: #d32f2f;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="top-bar">
        <form action="login.jsp" method="post">
            <input type="submit" value="Logout" class="logout-btn">
        </form>
    </div>

    <h2>Edit Property</h2>

    <% if (errorMessage != null) { %>
    <div class="error-message"><%= errorMessage %></div>
    <% } %>

    <form action="update-property" method="POST" enctype="multipart/form-data">
        <input type="hidden" name="id" value="<%= property.getId() %>">

        <label for="title">Property Title:</label>
        <input type="text" name="title" id="title" value="<%= property.getTitle() %>" required>

        <label for="location">Location:</label>
        <input type="text" name="location" id="location" value="<%= property.getLocation() %>" required>

        <label for="type">Property Type:</label>
        <select name="type" id="type" required>
            <option value="House" <%= "House".equals(property.getType()) ? "selected" : "" %>>House</option>
            <option value="Apartment" <%= "Apartment".equals(property.getType()) ? "selected" : "" %>>Apartment</option>
            <option value="Villa" <%= "Villa".equals(property.getType()) ? "selected" : "" %>>Villa</option>
            <option value="Bungalow" <%= "Bungalow".equals(property.getType()) ? "selected" : "" %>>Bungalow</option>
        </select>

        <label for="description">Description:</label>
        <textarea name="description" id="description" required><%= property.getDescription() %></textarea>

        <label for="image">Update Image:</label>
        <input type="file" name="image" accept="image/*">

        <% if (property.getImageFileName() != null && !property.getImageFileName().isEmpty()) { %>
        <div class="existing-image">
            <p>Current Image:</p>
            <img src="images/<%= property.getImageFileName() %>" alt="Property Image">
        </div>
        <% } %>

        <label for="phoneNumber">Seller's Phone Number:</label>
        <input type="text" name="phoneNumber" id="phoneNumber" value="<%= property.getSellerPhone() %>" required>

        <input type="submit" value="Update Property" class="submit-btn">
    </form>
</div>

</body>
</html>
