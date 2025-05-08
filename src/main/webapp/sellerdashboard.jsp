<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.demo.models.Property" %>
<%@ page import="java.util.*" %>
<%
    String sellerEmail = (String) session.getAttribute("email");
    if (sellerEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Seller Dashboard</title>
    <link rel="stylesheet" href="css/seller-dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
        }

        .top-bar {
            background-color: #333;
            color: white;
            padding: 10px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .add-property, .profile-update {
            margin: 20px;
        }

        .add-btn, .profile-update-btn {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            font-size: 16px;
            border-radius: 5px;
        }

        .add-btn:hover, .profile-update-btn:hover {
            background-color: #45a049;
        }

        .property-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
        }

        .property-card {
            background-color: white;
            border: 1px solid #ccc;
            border-radius: 10px;
            width: 300px;
            margin: 15px;
            padding: 15px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            transition: all 0.3s ease-in-out; /* Transition effect */
        }

        .property-card:hover {
            transform: scale(1.05); /* Slightly enlarge the card */
            box-shadow: 0 8px 16px rgba(0,0,0,0.2); /* Enhanced shadow */
        }

        .property-image {
            width: 100%;
            height: 180px;
            object-fit: cover;
            border-radius: 8px;
            transition: transform 0.3s ease-in-out; /* Transition effect for image */
        }

        .property-card:hover .property-image {
            transform: scale(1.1); /* Slight zoom-in on hover */
        }

        .property-info {
            margin-top: 10px;
        }

        .actions {
            margin-top: 10px;
        }

        .edit-btn, .delete-btn, .view-btn {
            background-color: #2196F3;
            color: white;
            padding: 8px 12px;
            margin: 3px;
            font-size: 14px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease; /* Transition effect */
        }

        .edit-btn:hover {
            background-color: #1976D2;
        }

        .delete-btn {
            background-color: #f44336;
        }

        .delete-btn:hover {
            background-color: #d32f2f;
        }

        .account-dropdown {
            position: relative;
            display: inline-block;
            margin-right: 20px;
        }

        .account-icon {
            font-size: 24px;
            color: white;
            cursor: pointer;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            left: 0;
            background-color: #f9f9f9;
            min-width: 180px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.2);
            z-index: 1;
            border-radius: 6px;
        }

        .dropdown-content form,
        .dropdown-content a {
            display: block;
            padding: 10px;
            text-decoration: none;
            color: black;
            background: #fff;
            border-bottom: 1px solid #ddd;
        }

        .dropdown-content form:hover,
        .dropdown-content a:hover {
            background-color: #f1f1f1;
        }

        .show-dropdown {
            display: block;
        }

        .logout-btn {
            background-color: #f44336;
            color: white;
            padding: 8px 14px;
            font-size: 14px;
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

<div class="top-bar">
    <h2>Seller Dashboard</h2>
    <div style="display: flex; align-items: center;">
        <div class="account-dropdown">
            <i class="fas fa-user-circle account-icon" onclick="toggleDropdown()"></i>
            <div id="accountMenu" class="dropdown-content">
                <a href="updateprofile.jsp">Update Profile</a>
                <form action="/delete-user" method="post" onsubmit="return confirm('Delete your account?');">
                    <input type="hidden" name="email" value="<%= sellerEmail %>">
                    <input type="hidden" name="role" value="seller">
                    <input type="submit" value="Delete Profile" style="border:none; background:none; padding:0; font: inherit; cursor:pointer; color:#000;">
                </form>
            </div>
        </div>
        <div style="color:white; margin-left:15px;">Logged in as: <%= sellerEmail %></div>
        <form action="login.jsp" method="post" style="margin-left: 15px;">
            <input type="submit" value="Logout" class="logout-btn">
        </form>
    </div>
</div>

<div class="add-property">
    <a href="add-property.jsp" class="add-btn">+ Add New Property</a>
</div>

<div class="property-container">
    <%
        List<Property> properties = (List<Property>) request.getAttribute("properties");
        if (properties != null && !properties.isEmpty()) {
            for (Property property : properties) {
    %>
    <div class="property-card">
        <img src="images/<%= property.getImageFileName() != null ? property.getImageFileName() : "default.jpg" %>" alt="Property Image" class="property-image">
        <div class="property-info">
            <h3><%= property.getTitle() %></h3>
            <p><strong>Location:</strong> <%= property.getLocation() %></p>
            <p><strong>Type:</strong> <%= property.getType() %></p>
            <p><strong>Price:</strong> $<%= property.getPrice() %></p>
            <p><strong>Radius:</strong> <%= property.getRadius() %> ft</p>
            <p><strong>Description:</strong> <%= property.getDescription() %></p>
            <p><strong>Booked By:</strong> <%= property.getBookedBy() != null && !property.getBookedBy().isEmpty() ? property.getBookedBy() : "Not Booked" %></p>

            <div class="actions">
                <form action="view-property.jsp" method="get" style="display:inline;">
                    <input type="hidden" name="id" value="<%= property.getId() %>">
                    <input type="submit" value="View Details" class="view-btn">
                </form>

                <form action="editproperty.jsp" method="get" style="display:inline;">
                    <input type="hidden" name="id" value="<%= property.getId() %>">
                    <input type="submit" value="Edit" class="edit-btn">
                </form>

                <form action="delete-property" method="post" style="display:inline;">
                    <input type="hidden" name="id" value="<%= property.getId() %>">
                    <input type="submit" value="Delete" class="delete-btn"
                           onclick="return confirm('Are you sure you want to delete this property?');">
                </form>
            </div>
        </div>
    </div>
    <%
        }
    } else {
    %>
    <p>No properties found. <a href="add-property.jsp">Add a new property</a>.</p>
    <%
        }
    %>
</div>

<script>
    function toggleDropdown() {
        document.getElementById("accountMenu").classList.toggle("show-dropdown");
    }

    window.onclick = function(event) {
        if (!event.target.matches('.account-icon')) {
            const dropdown = document.getElementById("accountMenu");
            if (dropdown && dropdown.classList.contains('show-dropdown')) {
                dropdown.classList.remove('show-dropdown');
            }
        }
    }
</script>

</body>
</html>
