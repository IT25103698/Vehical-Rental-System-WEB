<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.rental.vehiclerentalsystem_v2.customer.Customer" %>
<%@ page import="com.rental.vehiclerentalsystem_v2.rentalpackages.RentalPackage" %>
<%@ page import="com.rental.vehiclerentalsystem_v2.rentalpackages.PackageManager" %>

<%
    Customer user = (Customer) session.getAttribute("customerUser");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>RentalDrive | Travel Packages</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
    <style>
        * { margin:0; padding:0; box-sizing:border-box; }
        body { font-family:'Plus Jakarta Sans',sans-serif; background: #f8fafc; color:#0f172a; min-height:100vh; }
        .navbar { position:sticky; top:0; z-index:1000; background:white; border-bottom:1px solid #e2e8f0; }
        .nav-container { max-width:1300px; margin:auto; padding:18px 30px; display:flex; justify-content:space-between; align-items:center; }
        .logo { font-size:28px; font-weight:800; color:#7c3aed; }
        .nav-links { display:flex; gap:35px; align-items:center; }
        .nav-links a { text-decoration:none; color:#334155; font-weight:600; transition:0.3s; }
        .nav-links a:hover, .nav-links a.active { color:#7c3aed; border-bottom: 2px solid #7c3aed; }
        .welcome { display:flex; align-items:center; gap:15px; font-weight:600; }
        .logout-btn { text-decoration:none; padding:10px 18px; border-radius:14px; background:#fee2e2; color:#ef4444; font-size:14px; font-weight:700; transition:0.3s; }
        .container { max-width:1300px; margin:auto; padding:40px 25px 100px; }
        .section-title { font-size:34px; font-weight:800; margin-bottom:28px; color:#1e293b; }
        .grid { display:grid; grid-template-columns:repeat(auto-fit,minmax(260px,1fr)); gap:22px; }
        .card { overflow:hidden; border-radius:24px; background:white; border:1px solid #e2e8f0; transition:0.4s; box-shadow: 0 10px 25px rgba(0,0,0,0.05); }
        .card:hover { transform:translateY(-10px); box-shadow: 0 20px 40px rgba(0,0,0,0.1); }
        .card-image { position:relative; height:190px; overflow:hidden; }
        .card-image img { width:100%; height:100%; object-fit:cover; transition:0.5s; }
        .card:hover .card-image img { transform:scale(1.08); }
        .card-content { padding:18px; }
        .card-content h3 { font-size:22px; margin-bottom:8px; color:#1e293b; }
        .details { color:#64748b; line-height:1.6; margin-bottom:18px; font-size:14px; }
        .book-btn { display:block; text-align:center; text-decoration:none; padding:12px; border-radius:14px; background:linear-gradient(90deg, #7735ea, #ac66fa); color:white; font-weight:700; transition:0.3s; font-size:14px; }
        .book-btn:hover { transform:translateY(-2px); box-shadow: 0 10px 15px rgba(119, 53, 234, 0.3); }
    </style>
</head>
<body>

<nav class="navbar">
    <div class="nav-container">
        <div class="logo">RentalDrive</div>
        <div class="nav-links">
            <a href="customerHome.jsp">Home</a>
            <a href="vehicles.jsp">Vehicles</a>
            <a href="packages.jsp" class="active">Packages</a>
        </div>
        <div class="welcome">
            <span>Welcome, <b><%= user.getName() %></b></span>
            <a href="LogoutServlet" class="logout-btn">Logout</a>
        </div>
    </div>
</nav>

<div class="container">
    <div class="section-title">📦 Special Travel Packages</div>
    <div class="grid">
        <%
            try {
                PackageManager pm = new PackageManager();
                for (RentalPackage p : pm.getAllPackages()) {
        %>
        <div class="card" style="border-top: 4px solid #debbfb;">
            <div class="card-image">
                <img src="https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?q=80&w=1000" alt="Travel Package">
            </div>
            <div class="card-content">
                <h3><%= p.getPackageName() %></h3>
                <div class="details">
                    🌍 Luxury Travel Experience <br>
                    ⏳ Duration: <%= p.getDuration() %> <br>
                    💎 Premium Service Included
                </div>
                <h2 style="margin-bottom:18px;color:#7735ea;font-size:24px;">LKR <%= p.getPrice() %></h2>
                <a href="bookPkg.jsp?id=<%= p.getPackageId() %>" class="book-btn">View Package Deal</a>
            </div>
        </div>
        <%
                }
            } catch (Exception e) {
                out.print("<h3>Error loading packages.</h3>");
            }
        %>
    </div>
</div>

</body>
</html>