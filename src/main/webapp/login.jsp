<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Login</title>
  <link rel="stylesheet" type="text/css" href="css/login.css">
  <style>
    .error {
      color: red;
      margin-bottom: 10px;
    }
  </style>
</head>
<body>
<div class="form-container">
  <h1>Login</h1>

  <!-- Show error if exists -->
  <%
    String error = request.getParameter("error");
    if (error != null && !error.isEmpty()) {
  %>
  <div class="error"><%= error %></div>
  <%
    }
  %>

  <form action="login" method="post">
    <label>Email:</label>
    <input type="email" name="email" required>

    <label>Password:</label>
    <input type="password" name="password" required>

    <label>Login As:</label>
    <select name="role" required>
      <option value="user">User</option>
      <option value="seller">Seller</option>
      <option value="admin">Admin</option>
    </select>

    <input type="submit" value="Login">
  </form>

  <form action="register.jsp" method="get" class="register-form">
    <input type="submit" value="Register" class="register-btn">
  </form>
</div>
</body>
</html>
