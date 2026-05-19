<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.rental.vehiclerentalsystem_v2.rentalpackages.*" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <title>Rental Packages</title>
    <style>
        body { font-family: sans-serif; background: #f8f9fa; padding: 40px; }
        table { width: 100%; border-collapse: collapse; background: white; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
        th { background: #8e44ad; color: white; padding: 12px; text-align: left; }
        td { padding: 12px; border-bottom: 1px solid #eee; }
    </style>
</head>
<body>
<h2 style="color: #8e44ad;">📦 Available Rental Packages</h2>
<table>
    <tr>
        <th>Package ID</th>
        <th>Name</th>
        <th>Duration</th>
        <th>Price</th>
        <th>Actions</th> </tr>
    <%
        RentalPackageFileManager manager = new RentalPackageFileManager();
        List<RentalPackage> packages = manager.getAllPackages();
        if (packages != null && !packages.isEmpty()) {
            for(RentalPackage p : packages) {
    %>
    <tr>
        <td><%= p.getPackageId() %></td>
        <td><b><%= p.getPackageName() %></b></td>
        <td><%= p.getDuration() %></td>
        <td>LKR <%= p.getPrice() %>0</td>
        <td>
            <a href="EditPackageServlet?id=<%= p.getPackageId() %>"
               style="color: #2980b9; text-decoration: none; font-weight: bold; margin-right: 15px;">Edit</a>

            <a href="DeletePackageServlet?id=<%= p.getPackageId() %>"
               style="color: #e74c3c; text-decoration: none; font-weight: bold;"
               onclick="return confirm('Are you sure you want to delete this package?')">Delete</a>
        </td>
    </tr>
    <%      }
    } else { %>
    <tr><td colspan="5" style="text-align:center; padding: 20px;">No packages available.</td></tr>
    <% } %>
</table>

<br>
<a href="addPackage.jsp" style="padding: 10px 15px; background: #8e44ad; color: white; text-decoration: none; border-radius: 5px; font-weight: bold;">+ Add New Package</a>
<a href="index.jsp" style="margin-left: 15px; color: #7f8c8d; font-weight: bold; text-decoration: none;">← Back to Dashboard</a>
</body>
</html>