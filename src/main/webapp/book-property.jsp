<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.demo.service.PropertyManager" %>
<%@ page import="com.example.demo.models.Property" %>

<%
    String propertyId = request.getParameter("propertyId");
    Property property = PropertyManager.findPropertyById(propertyId);

    if (property != null) {
        // Proceed with booking logic
%>
<!DOCTYPE html>
<html>
<head>
    <title>Book Property</title>
    <link rel="stylesheet" href="css/book-property.css" />
</head>
<body>
<h1>Book Property: <%= property.getTitle() %></h1>
<form method="post" action="process-booking.jsp">
    <input type="hidden" name="propertyId" value="<%= property.getId() %>">
    <input type="text" name="userName" placeholder="Your Name" required>
    <input type="email" name="userEmail" placeholder="Your Email" required>
    <input type="submit" value="Confirm Booking">
</form>
</body>
</html>
<% } else { %>
<h2>Property not found.</h2>
<% } %>
