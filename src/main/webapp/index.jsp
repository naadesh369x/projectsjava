<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Login Redirect</title>
</head>
<body>

<%
  // Immediately redirect to user dashboard
  response.sendRedirect("login.jsp");
%>

</body>
</html>
