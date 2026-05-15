<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.rental.customer.Customer" %>
<%@ page import="com.rental.VehicleInventoryManagement.Vehicle" %>
<%@ page import="com.rental.VehicleInventoryManagement.VehicleFileManager" %>
<%@ page import="com.rental.rentalpackages.RentalPackage" %>
<%@ page import="com.rental.rentalpackages.PackageManager" %>

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
    <title>RentalDrive | Luxury Fleet</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        * { margin:0; padding:0; box-sizing:border-box; }
        :root { --primary:#c084fc; --secondary:#d8b4fe; --dark:#0f172a; }
        body {
            font-family:'Plus Jakarta Sans',sans-serif;
            background: radial-gradient(circle at top left, #dbeafe 0%, transparent 30%),
            radial-gradient(circle at bottom right, #bfdbfe 0%, transparent 35%),
            linear-gradient(135deg,#dbeafe,#c7d2fe,#93c5fd,#60a5fa);
            background-attachment:fixed; color:var(--dark); overflow-x:hidden; min-height:100vh; position:relative;
        }
        .navbar { position:sticky; top:0; z-index:1000; backdrop-filter:blur(14px); background:rgba(255,255,255,0.28); border-bottom:1px solid rgba(255,255,255,0.25); }
        .nav-container { max-width:1300px; margin:auto; padding:18px 30px; display:flex; justify-content:space-between; align-items:center; }
        .logo { font-size:28px; font-weight:800; letter-spacing:-1px; color:#7c3aed; }
        .nav-links { display:flex; gap:35px; align-items:center; }
        .nav-links a { text-decoration:none; color:#334155; font-weight:600; transition:0.3s; }
        .nav-links a:hover, .nav-links a.active { color:#7c3aed; border-bottom: 2px solid #7c3aed; }
        .welcome { display:flex; align-items:center; gap:15px; font-weight:600; }
        .logout-btn { text-decoration:none; padding:10px 18px; border-radius:14px; background:rgba(255,255,255,0.4); color:#ef4444; font-size:14px; font-weight:700; transition:0.3s; }
        .logout-btn:hover { transform:translateY(-2px); }
        .hero { position:relative; height:88vh; display:flex; align-items:center; justify-content:center; text-align:center; overflow:hidden; padding:20px; }
        .hero img { position:absolute; width:100%; height:100%; object-fit:cover; opacity:0.35; }
        .hero-overlay { position:absolute; inset:0; background:linear-gradient(to bottom, rgba(255,255,255,0.05), rgba(248,250,252,0.6)); }
        .hero-content { position:relative; z-index:10; background:rgba(255,255,255,0.22); backdrop-filter:blur(22px); padding:55px; border-radius:38px; border:1px solid rgba(255,255,255,0.35); box-shadow: 0 20px 45px rgba(0,0,0,0.12); max-width:820px; }
        .hero h1 { font-size:64px; font-weight:800; margin-bottom:20px; color:#1e293b; }
        .hero p { font-size:18px; color:#475569; margin-bottom:35px; line-height:1.8; }
        .search-box { display:flex; gap:15px; justify-content:center; }
        .search-box a { text-decoration:none; background:linear-gradient(90deg, #7735ea, #ac66fa); color:white; padding:15px 35px; border-radius:14px; font-weight:700; transition:0.3s; }
        .search-box a:hover { transform:scale(1.04); }
        footer { text-align:center; padding:40px; color:#475569; font-weight:500; }
    </style>
</head>
<body>

<nav class="navbar">
    <div class="nav-container">
        <div class="logo">RentalDrive</div>
        <div class="nav-links">
            <a href="customerHome.jsp" class="active">Home</a>
            <a href="vehicles.jsp">Vehicles</a>
            <a href="packages.jsp">Packages</a>
        </div>
        <div class="welcome">
            <span>Welcome, <b><%= user.getName() %></b></span>
            <a href="LogoutServlet" class="logout-btn">Logout</a>
        </div>
    </div>
</nav>

<section class="hero">
    <img src="https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?auto=format&fit=crop&w=1600&q=80">
    <div class="hero-overlay"></div>
    <div class="hero-content">
        <h1>Move With Style</h1>
        <p>Premium vehicle rentals and exclusive travel experiences designed for comfort, luxury and unforgettable journeys.</p>
        <div class="search-box">
            <a href="vehicles.jsp">Browse Vehicles</a>
            <a href="packages.jsp" style="background:rgba(255,255,255,0.5); color:#7735ea;">View Packages</a>
        </div>
    </div>
</section>

<footer>©️ 2026 RentalDrive. Luxury journeys begin here.</footer>
</body>
</html>