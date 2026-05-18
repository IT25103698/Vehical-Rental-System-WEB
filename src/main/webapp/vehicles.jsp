<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%-- Exact match to your Java file's package --%>
<%@ page import="com.rental.vehiclerentalsystem_v2.VehicleInventoryManagement.Vehicle" %>
<%@ page import="com.rental.vehiclerentalsystem_v2.VehicleInventoryManagement.VehicleFileManager" %>

<!DOCTYPE html>
<html>
<head>
    <title>Vehicle Inventory</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; background: #f8fafc; padding: 40px; }
        .container { max-width: 1100px; margin: auto; }
        .header-area { margin-bottom: 30px; }

        .vehicle-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 20px; }

        .card { background: white; border-radius: 15px; padding: 25px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05); border: 1px solid #e2e8f0; position: relative; transition: 0.2s;}
        .card:hover { transform: translateY(-5px); box-shadow: 0 10px 15px -3px rgba(0,0,0,0.1); }

        /* Dynamic Badges for Car/Van/SUV */
        .badge { position: absolute; top: 20px; right: 20px; font-size: 0.75rem; padding: 5px 10px; border-radius: 6px; font-weight: 700; text-transform: uppercase; letter-spacing: 1px;}
        .badge.Car { background: #dcfce7; color: #166534; }
        .badge.Van { background: #e0e7ff; color: #3730a3; }
        .badge.SUV { background: #ffedd5; color: #9a3412; }

        .icon-circle { width: 50px; height: 50px; background: #f1f5f9; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 1.5rem; margin-bottom: 15px;}

        h3 { margin: 0 0 5px 0; color: #1e293b; font-size: 1.25rem; }
        .plate { font-size: 0.85rem; color: #64748b; font-family: monospace; background: #f1f5f9; padding: 3px 8px; border-radius: 4px; display: inline-block; margin-bottom: 15px;}

        .price { font-size: 1.1rem; font-weight: 700; color: #0f172a; margin-top: 15px; padding-top: 15px; border-top: 1px solid #f1f5f9;}
        .price span { font-size: 0.85rem; color: #64748b; font-weight: 400;}
    </style>
</head>
<body>
    <div class="container">
        <div class="header-area">
            <h1 style="margin:0; color: #1e293b;">🚙 Fleet Directory</h1>
            <p style="color:#64748b; margin-top:5px;">Available vehicles for rental</p>
        </div>

        <div class="vehicle-grid">
            <%
                try {
                    VehicleFileManager manager = new VehicleFileManager();
                    List<Vehicle> list = manager.getAllVehicles();

                    if (list != null && !list.isEmpty()) {
                        for (Vehicle v : list) {
                            // Automatically detects if it is a Car, Van, or SUV class
                            String vehicleType = v.getClass().getSimpleName();

                            // Choose an icon based on the type
                            String icon = "🚗";
                            if (vehicleType.equals("Van")) icon = "🚐";
                            if (vehicleType.equals("SUV")) icon = "🚙";
            %>
            <div class="card">
                <span class="badge <%= vehicleType %>"><%= vehicleType %></span>
                <div class="icon-circle"><%= icon %></div>

                <h3><%= v.getBrand() %> <%= v.getModel() %></h3>
                <div class="plate"><%= v.getLicensePlate() %></div>

                <div style="font-size:0.9rem; color:#475569;">
                    <b>Vehicle ID:</b> <%= v.getVehicleId() %>
                </div>

                <div class="price">
                    LKR <%= String.format("%.2f", v.getDailyRate()) %> <span>/ day</span>
                </div>
            </div>
            <%
                        }
                    } else {
                        out.println("<div style='grid-column: 1 / -1; text-align: center; padding: 40px; color: #64748b;'>No vehicles found in the fleet.</div>");
                    }
                } catch (Exception e) {
                    out.println("<div style='grid-column: 1 / -1; color: #ef4444; font-weight: bold;'>Java Error: " + e.getMessage() + "</div>");
                }
            %>
        </div>

        <div style="margin-top: 40px; text-align: center;">
            <a href="index.jsp" style="text-decoration: none; color: #64748b; font-weight: 500; transition: color 0.2s;">← Return to Dashboard</a>
        </div>
    </div>
</body>
</html>