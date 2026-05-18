<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- UPDATED IMPORT: Matches your new Spring Boot package structure exactly --%>
<%@ page import="com.rental.vehiclerentalsystem_v2.VehicleInventoryManagement.*, java.util.List" %>

<html>
<head>
    <title>Vehicle Management | Admin</title>
    <style>
        body { font-family: 'Inter', sans-serif; background: #f3f4f6; padding: 40px; color: #1f2937; }
        .card { background: white; padding: 30px; border-radius: 15px; box-shadow: 0 10px 15px rgba(0,0,0,0.1); max-width: 1200px; margin: auto; }

        .header-flex { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; border-bottom: 2px solid #3b82f6; padding-bottom: 15px; }
        .header-flex h2 { margin: 0; color: #1e3a8a; }

        .btn-add { background: #3b82f6; color: white; padding: 10px 20px; border-radius: 8px; text-decoration: none; font-weight: 600; }

        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th { background: #1e40af; color: white; padding: 12px; text-align: left; font-size: 0.9rem; }
        td { padding: 12px; border-bottom: 1px solid #e5e7eb; font-size: 0.95rem; }
        tr:hover { background: #f9fafb; }

        .badge { padding: 4px 8px; border-radius: 4px; font-size: 0.75rem; font-weight: 700; color: white; }
        .bg-car { background: #10b981; }
        .bg-van { background: #6366f1; }
        .bg-suv { background: #f59e0b; }

        .btn-delete { background: #ef4444; color: white; padding: 6px 12px; border-radius: 6px; text-decoration: none; font-size: 0.85rem; }
    </style>
</head>
<body>

    <div class="card">
        <div class="header-flex">
            <h2>🚚 Vehicle Inventory Management</h2>
            <a href="registerVehicle.jsp" class="btn-add">+ Register New</a>
        </div>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Brand & Model</th>
                    <th>Plate</th>
                    <th>Type</th>
                    <th>Extra Details</th>
                    <th>Rate (LKR)</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        VehicleFileManager manager = new VehicleFileManager();
                        List<Vehicle> list = manager.getAllVehicles();

                        if (list != null && !list.isEmpty()) {
                            for (Vehicle v : list) {
                                String type = "";
                                String badge = "";
                                String details = "";

                                // Logic to extract subclass data (Polymorphism in action)
                                if (v instanceof Car) {
                                    type = "Car"; badge = "bg-car";
                                    details = "Fuel: " + ((Car) v).getFuelType();
                                } else if (v instanceof Van) {
                                    type = "Van"; badge = "bg-van";
                                    details = "Cap: " + ((Van) v).getLoadCapacity() + "kg";
                                } else if (v instanceof SUV) {
                                    type = "SUV"; badge = "bg-suv";
                                    details = "AWD: " + (((SUV) v).isAWD() ? "Yes" : "No");
                                }
                %>
                <tr>
                    <td><b><%= v.getVehicleId() %></b></td>
                    <td><%= v.getBrand() %> <%= v.getModel() %></td>
                    <td><code style="background:#f1f5f9; padding:2px 5px;"><%= v.getLicensePlate() %></code></td>
                    <td><span class="badge <%= badge %>"><%= type %></span></td>
                    <td style="font-style: italic; color: #6b7280;"><%= details %></td>
                    <td><%= String.format("%.2f", v.getDailyRate()) %></td>
                    <td>
                        <a href="DeleteVehicleServlet?id=<%= v.getVehicleId() %>"
                           class="btn-delete"
                           onclick="return confirm('Are you sure you want to delete this vehicle from the inventory?')">Delete</a>
                    </td>
                </tr>
                <%
                            }
                        } else {
                %>
                <tr><td colspan="7" style="text-align:center; padding:30px; color:#9ca3af;">No vehicles currently found in inventory.</td></tr>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='7' style='color:red;'>System Error: " + e.getMessage() + "</td></tr>");
                    }
                %>
            </tbody>
        </table>

        <p style="margin-top:20px;"><a href="index.jsp" style="color:#6b7280; text-decoration:none;">← Back to Dashboard</a></p>
    </div>

</body>
</html>