<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Login</title>
  <link rel="stylesheet" type="text/css" href="css/login.css">
</head>
<body>
<div class="form-container">
  <h1>Login</h1>
  <form action="login" method="post">
    <label>Email:</label>
    <input type="email" name="email" required>

    <label>Password:</label>
    <input type="password" name="password" required>

    <label>Login As:</label>
    <select name="role" required>
      <option value="user">User</option>
      <option value="seller">Seller</option>
    </select>

    <input type="submit" value="Login">
  </form>

  <!-- Register Button -->
  <form action="register.jsp" method="get" class="register-form">
    <input type="submit" value="Register" class="register-btn">
  </form>
</div>
</body>
</html>
