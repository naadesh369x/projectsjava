<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add New Property</title>
    <link rel="stylesheet" type="text/css" href="css/add-property.css">
</head>
<body>

<div class="container">
    <div class="top-bar">
        <form action="login.jsp" method="post">
            <input type="submit" value="Logout" class="logout-btn">
        </form>
    </div>

    <h2>Add New Property</h2>

    <!-- Important: Use enctype="multipart/form-data" -->
    <form action="add-property" method="POST" class="form-box" enctype="multipart/form-data">
        <label for="id">Property ID:</label>
        <input type="text" name="id" id="id" required>

        <label for="title">Property Title:</label>
        <input type="text" name="title" id="title" required>

        <label for="location">Location:</label>
        <input type="text" name="location" id="location" required>

        <label for="type">Property Type:</label>
        <select name="type" id="type" required>
            <option value="House">House</option>
            <option value="Apartment">Apartment</option>
            <option value="Villa">Villa</option>
            <option value="Bungalow">Bungalow</option>
        </select>

        <label for="price">Price:</label>
        <input type="number" name="price" id="price" step="0.01" required>

        <label for="radius">Radius (in ft):</label>
        <input type="number" name="radius" id="radius" step="0.01" required>

        <label for="description">Description:</label>
        <textarea name="description" id="description" required></textarea>

        <label for="sellerPhone">Seller Phone Number:</label>
        <input type="text" name="sellerPhone" id="sellerPhone" required pattern="[0-9]{10}" title="Enter a 10-digit phone number">

        <label for="imageFileName">Image:</label>
        <input type="file" name="image" accept="image/*">

        <input type="submit" value="Add Property" class="submit-btn">
    </form>
</div>

</body>
</html>
