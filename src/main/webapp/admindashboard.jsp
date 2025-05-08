<%@ page import="java.util.List" %>
<%@ page import="com.example.demo.models.User" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="css/admin-dashboard.css">
</head>
<body>
<div class="container">
    <header>
        <h1>Admin Dashboard</h1>
        <nav>
            <ul>
                <li><a href="admin-dashboard">Dashboard</a></li>
                <li><a href="login.jsp">Logout</a></li>
            </ul>
        </nav>
    </header>

    <section>
        <h2>All Users</h2>
        <table border="1">
            <thead>
            <tr>
                <th>Email</th>
                <th>Role</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <%
                List<User> users = (List<User>) request.getAttribute("users");
                if (users != null && !users.isEmpty()) {
                    for (User user : users) {
            %>
            <tr>
                <td><%= user.getEmail() %></td>
                <td><%= user.getRole() %></td>
                <td>
                    <form action="delete-user" method="post" onsubmit="return confirm('Are you sure you want to delete this user?');">
                        <input type="hidden" name="email" value="<%= user.getEmail() %>">
                        <input type="hidden" name="role" value="<%= user.getRole() %>">
                        <input type="submit" value="Delete" class="delete-btn">
                    </form>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="3">No users found.</td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </section>
</div>
</body>
</html>
