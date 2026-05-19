<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>Add Rental Package</title>
    <style>
        body { font-family: sans-serif; background: #f8f9fa; padding: 40px; }
        .card { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); max-width: 400px; margin: auto; }
        input, select { width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ccc; border-radius: 5px; }
        button { width: 100%; padding: 12px; background: #8e44ad; color: white; border: none; font-weight: bold; cursor: pointer; border-radius: 5px;}
    </style>
</head>
<body>
<div class="card">
    <h2 style="color: #8e44ad; text-align: center;">📦 Add Rental Package</h2>
    <form action="RentalPackageServlet" method="post">
        <input type="text" name="packageId" placeholder="Package ID (e.g. PKG01)" required>
        <input type="text" name="packageName" placeholder="Package Name (e.g. Wedding Special)" required>
        <select name="duration">
            <option value="Daily">Daily</option>
            <option value="Weekend">Weekend</option>
            <option value="Weekly">Weekly</option>
            <option value="Monthly">Monthly</option>
        </select>
        <input type="number" name="price" placeholder="Price (LKR)" required>
        <button type="submit">Save Package</button>
    </form>
    <a href="index.jsp" style="display: block; text-align: center; margin-top: 15px;">Cancel</a>
</div>
</body>
</html>