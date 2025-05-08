<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.demo.models.Property" %>
<%@ page import="java.util.*" %>
<%
    String userEmail = (String) session.getAttribute("email");
    if (userEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>User Dashboard</title>
    <link rel="stylesheet" href="css/user-dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>

<div class="top-bar">
    <form action="login.jsp" method="post">
        <input type="submit" value="Logout" class="logout-btn">
    </form>

    <h2>User Dashboard</h2>

    <div class="right">
        <a href="favorites.jsp" class="view-favorites-btn">♡ View Favorites</a>
        <div class="account-dropdown">
            <i class="fas fa-user-circle profile-icon" onclick="toggleDropdown()"></i>
            <div id="accountMenu" class="dropdown-content">
                <a href="updateprofile.jsp">Update Profile</a>
                <form action="/delete-user" method="post" onsubmit="return confirm('Delete your account?');">
                    <input type="hidden" name="email" value="<%= userEmail %>">
                    <input type="hidden" name="role" value="user">
                    <input type="submit" value="Delete Profile" style="border:none; background:none; padding:0; font: inherit; cursor:pointer; color:#000;">
                </form>
            </div>
        </div>
        <div class="logged-in">Logged in as: <%= userEmail %></div>
    </div>
</div>

<!-- Search and Filter Section -->
<div class="search-bar">
    <input type="text" id="searchInput" placeholder="Search by title or description..." onkeyup="filterProperties()">
    <select id="typeFilter" onchange="filterProperties()">
        <option value="">All Types</option>
        <option value="House">House</option>
        <option value="Apartment">Apartment</option>
        <option value="Villa">Villa</option>
        <option value="Bungalow">Bungalow</option>
    </select>
    <select id="priceFilter" onchange="filterProperties()">
        <option value="">All Prices</option>
        <option value="500000">Below 500,000</option>
        <option value="1000000">Below 1,000,000</option>
        <option value="2000000">Below 2,000,000</option>
    </select>
    <select id="radiusFilter" onchange="filterProperties()">
        <option value="">All Radius</option>
        <option value="500">Below 500 ft</option>
        <option value="1000">Below 1000 ft</option>
        <option value="2000">Below 2000 ft</option>
    </select>
</div>

<!-- Property Cards -->
<div class="property-container" id="propertyContainer">
    <%
        List<Property> properties = (List<Property>) request.getAttribute("properties");
        if (properties != null && !properties.isEmpty()) {
            for (Property property : properties) {
    %>
    <div class="property-card" data-title="<%= property.getTitle() %>" data-location="<%= property.getLocation() %>" data-type="<%= property.getType() %>" data-price="<%= property.getPrice() %>" data-radius="<%= property.getRadius() %>">
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
                <form action="user-property-details.jsp" method="get" style="display:inline;">
                    <input type="hidden" name="id" value="<%= property.getId() %>">
                    <input type="submit" value="View Details" class="view-btn">
                </form>

                <form action="book-property" method="post" style="display:inline;">
                    <input type="hidden" name="propertyId" value="<%= property.getId() %>">
                    <input type="submit" value="Book Now" class="book-btn" onclick="return confirm('Are you sure you want to book this property?');">
                </form>

                <form action="favorite-property" method="post" style="display:inline;">
                    <input type="hidden" name="propertyId" value="<%= property.getId() %>">
                    <input type="submit" value="♡ Favorite" class="favorite-btn">
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
        if (!event.target.matches('.profile-icon')) {
            const dropdown = document.getElementById("accountMenu");
            if (dropdown && dropdown.classList.contains('show-dropdown')) {
                dropdown.classList.remove('show-dropdown');
            }
        }
    }

    function filterProperties() {
        let searchInput = document.getElementById("searchInput").value.toLowerCase();
        let typeFilter = document.getElementById("typeFilter").value;
        let priceFilter = document.getElementById("priceFilter").value;
        let radiusFilter = document.getElementById("radiusFilter").value;

        let properties = document.querySelectorAll(".property-card");

        properties.forEach(function(property) {
            let title = property.getAttribute("data-title").toLowerCase();
            let location = property.getAttribute("data-location").toLowerCase();
            let type = property.getAttribute("data-type");
            let price = parseFloat(property.getAttribute("data-price"));
            let radius = parseFloat(property.getAttribute("data-radius"));

            let show = true;

            if (searchInput && !title.includes(searchInput) && !location.includes(searchInput)) {
                show = false;
            }

            if (typeFilter && type !== typeFilter) {
                show = false;
            }

            if (priceFilter && price > parseFloat(priceFilter)) {
                show = false;
            }

            if (radiusFilter && radius > parseFloat(radiusFilter)) {
                show = false;
            }

            property.style.display = show ? "block" : "none";
        });
    }
</script>

</body>
</html>
