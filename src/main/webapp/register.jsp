<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Register</title>
  <link rel="stylesheet" type="text/css" href="css/register.css">
</head>
<body>
<div class="form-container">
  <h1>Register</h1>

  <form action="register" method="post">
    <label>Email:</label>
    <input type="email" name="email" required>

    <label>Password:</label>
    <input type="password" name="password" required>

    <label>Register As:</label>
    <select name="role" required>
      <option value="user">User</option>
      <option value="seller">Seller</option>
    </select>

    <input type="submit" value="Register">
  </form>

  <!-- Login Redirect -->
  <form action="login.jsp" method="get" class="register-form">
    <input type="submit" value="Back to Login" class="register-btn">
  </form>
</div>
</body>
</html>
