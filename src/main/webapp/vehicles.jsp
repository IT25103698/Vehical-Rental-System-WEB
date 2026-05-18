<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
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

        .vehicle-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 25px; }

        .card { background: white; border-radius: 15px; overflow: hidden; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05); border: 1px solid #e2e8f0; position: relative; transition: 0.3s;}
        .card:hover { transform: translateY(-8px); box-shadow: 0 15px 25px -5px rgba(0,0,0,0.1); }

        .card-img-wrapper { width: 100%; height: 190px; overflow: hidden; position: relative; background: #f1f5f9; }
        .card-img-wrapper img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.5s ease; }
        .card:hover .card-img-wrapper img { transform: scale(1.08); }

        .card-body { padding: 25px; }

        .badge { position: absolute; top: 15px; right: 15px; z-index: 10; font-size: 0.75rem; padding: 6px 12px; border-radius: 8px; font-weight: 700; text-transform: uppercase; letter-spacing: 1px; box-shadow: 0 4px 6px rgba(0,0,0,0.1);}
        .badge.Car { background: #dcfce7; color: #166534; }
        .badge.Van { background: #e0e7ff; color: #3730a3; }
        .badge.SUV { background: #ffedd5; color: #9a3412; }

        h3 { margin: 0 0 5px 0; color: #1e293b; font-size: 1.25rem; }
        .plate { font-size: 0.85rem; color: #64748b; font-family: monospace; background: #f1f5f9; padding: 4px 8px; border-radius: 6px; display: inline-block; margin-bottom: 15px; border: 1px solid #e2e8f0;}

        .price { font-size: 1.15rem; font-weight: 700; color: #0f172a; margin-top: 15px; padding-top: 15px; border-top: 1px solid #f1f5f9;}
        .price span { font-size: 0.85rem; color: #64748b; font-weight: 500;}
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
                            String vehicleType = v.getClass().getSimpleName();

                            // Get both brand and model, convert to lowercase for easy matching
                            String brandName = (v.getBrand() != null) ? v.getBrand().toLowerCase() : "";
                            String modelName = (v.getModel() != null) ? v.getModel().toLowerCase() : "";

                            String photoUrl;

                            // 1. SPECIFIC MODEL MATCHING (Most Accurate)
                            if (modelName.contains("corolla")) {
                                photoUrl = "https://images.unsplash.com/photo-1590362891991-f776e747a588?q=80&w=800";
                            } else if (modelName.contains("civic")) {
                                photoUrl = "https://images.unsplash.com/photo-1605816988069-b590f2cb2d2f?q=80&w=800";
                            } else if (modelName.contains("mustang")) {
                                photoUrl = "https://images.unsplash.com/photo-1584345604476-8ec5e12e42a5?q=80&w=800";
                            } else if (brandName.contains("tesla") || modelName.contains("model 3")) {
                                photoUrl = "https://images.unsplash.com/photo-1560958089-b8a1929cea89?q=80&w=800";
                            }

                            // 2. LUXURY / SPECIFIC BRANDS
                            else if (brandName.contains("bmw")) {
                                photoUrl = "https://images.unsplash.com/photo-1555215695-3004980ad54e?q=80&w=800";
                            } else if (brandName.contains("mercedes") || brandName.contains("benz")) {
                                photoUrl = "https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?q=80&w=800";
                            }

                            // 3. VEHICLE TYPE MATCHING (SUVs and Vans)
                            else if (vehicleType.equals("SUV") || modelName.contains("jeep") || modelName.contains("cruiser")) {
                                photoUrl = "https://images.unsplash.com/photo-1519641471654-76ce0107ad1b?q=80&w=800";
                            } else if (vehicleType.equals("Van") || modelName.contains("hiace")) {
                                photoUrl = "https://images.unsplash.com/photo-1527786356703-4b100091cd2c?q=80&w=800";
                            }

                            // 4. GENERAL BRAND MATCHING
                            else if (brandName.contains("toyota")) {
                                photoUrl = "https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?q=80&w=800";
                            } else if (brandName.contains("honda")) {
                                photoUrl = "https://images.unsplash.com/photo-1599912027806-cfec9f5944b6?q=80&w=800";
                            }

                            // 5. ULTIMATE FALLBACK (Random consistently assigned car)
                            else {
                                String[] randomCars = {
                                    "https://images.unsplash.com/photo-1552519507-da3b142c6e3d?q=80&w=800",
                                    "https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?q=80&w=800",
                                    "https://images.unsplash.com/photo-1583121274602-3e2820c69888?q=80&w=800",
                                    "https://images.unsplash.com/photo-1503376260956-6c127441584c?q=80&w=800"
                                };
                                int index = Math.abs(v.getVehicleId().hashCode()) % randomCars.length;
                                photoUrl = randomCars[index];
                            }
            %>
            <div class="card">
                <div class="card-img-wrapper">
                    <span class="badge <%= vehicleType %>"><%= vehicleType %></span>
                    <img src="<%= photoUrl %>" alt="<%= v.getBrand() %> <%= v.getModel() %>">
                </div>

                <div class="card-body">
                    <h3><%= v.getBrand() %> <%= v.getModel() %></h3>
                    <div class="plate"><%= v.getLicensePlate() %></div>

                    <div style="font-size:0.9rem; color:#475569;">
                        <b>Vehicle ID:</b> <%= v.getVehicleId() %>
                    </div>

                    <div class="price">
                        LKR <%= String.format("%.2f", v.getDailyRate()) %> <span>/ day</span>
                    </div>
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
            <a href="index.jsp" style="text-decoration: none; color: #64748b; font-weight: 600; transition: color 0.2s;">← Return to Dashboard</a>
        </div>
    </div>
</body>
</html>