<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.demo.models.Property" %>
<%@ page import="com.example.demo.service.PropertyManager" %>
<%@ page import="java.util.*" %>

<%
    String propertyId = request.getParameter("id");
    PropertyManager propertyManager = new PropertyManager();
    Property selectedProperty = propertyManager.getPropertyById(propertyId);
    List<String> comments = propertyManager.getCommentsByPropertyId(propertyId);

    if (selectedProperty == null) {
%>
<h2>Property not found.</h2>
<a href="userdashboard">Back to Dashboard</a>
<%
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Property Details</title>
    <link rel="stylesheet" href="css/user-dashboard.css">
    <style>
        .property-details-container {
            max-width: 800px;
            margin: 40px auto;
            background-color: #f9f9f9;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 8px rgba(0,0,0,0.1);
        }
        img {
            width: 100%;
            border-radius: 8px;
        }
        h2 { margin-top: 15px; }
        .small-box {
            margin-top: 20px;
            background: #eee;
            padding: 15px;
            border-radius: 6px;
        }
        .comment-box {
            background: #fff;
            padding: 10px;
            margin: 8px 0;
            border-left: 4px solid #007BFF;
        }
        form textarea {
            width: 100%;
            height: 80px;
            padding: 10px;
            margin-top: 10px;
            font-size: 14px;
        }
        form button {
            margin-top: 10px;
            background: #007BFF;
            color: #fff;
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
        }
        .back-btn {
            display: inline-block;
            margin-top: 20px;
            background: #444;
            color: #fff;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 6px;
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
        <p><strong>Booked By:</strong> <%= selectedProperty.getBookedBy() != null && !selectedProperty.getBookedBy().isEmpty() ? selectedProperty.getBookedBy() : "Not Booked" %></p>
    </div>

    <div class="small-box">
        <h3>User Comments:</h3>
        <% if (comments != null && !comments.isEmpty()) {
            for (String comment : comments) { %>
        <div class="comment-box"><%= comment %></div>
        <%  }
        } else { %>
        <p>No comments yet.</p>
        <% } %>
    </div>

    <div class="small-box">
        <h3>Add a Comment:</h3>
        <form method="post" action="comment">
            <input type="hidden" name="propertyId" value="<%= propertyId %>" />
            <textarea name="commentText" required placeholder="Enter your comment here..."></textarea>
            <button type="submit">Submit Comment</button>
        </form>
    </div>

    <a href="user-dashboard" class="back-btn">← Back to Dashboard</a>
</div>

</body>
</html>
