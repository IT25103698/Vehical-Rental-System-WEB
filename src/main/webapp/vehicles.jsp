<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%-- UPDATED IMPORTS FOR THE NEW SPRING BOOT PROJECT PACKAGE CONVENTION --%>
<%@ page import="com.rental.vehiclerentalsystem_v2.customer.Customer" %>
<%@ page import="com.rental.vehiclerentalsystem_v2.VehicleInventoryManagement.Vehicle" %>
<%@ page import="com.rental.vehiclerentalsystem_v2.VehicleInventoryManagement.VehicleFileManager" %>

<%
    // Security check: ensure user is verified in the HttpSession container
    Customer user = (Customer) session.getAttribute("customerUser");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>RentalDrive | Vehicles</title>
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
        .price-tag { position:absolute; top:14px; right:14px; background:rgba(15,23,42,0.88); color:white; padding:8px 14px; border-radius:12px; font-size:12px; font-weight:700; }
        .card-content { padding:18px; }
        .card-content h3 { font-size:22px; margin-bottom:8px; color:#1e293b; }
        .details { color:#64748b; line-height:1.6; margin-bottom:18px; font-size:14px; }

        /* AVAILABILITY BADGES */
        .status-badge { display: block; padding: 12px 14px; border-radius: 12px; font-size: 14px; font-weight: 700; text-align: center; width: 100%; }
        .status-available { background: #dcfce7; color: #166534; border: 1px solid #bbf7d0; }
        .status-unavailable { background: #fee2e2; color: #991b1b; border: 1px solid #fecaca; }
    </style>
</head>
<body>

<nav class="navbar">
    <div class="nav-container">
        <div class="logo">RentalDrive</div>
        <div class="nav-links">
            <a href="customerHome.jsp">Home</a>
            <a href="vehicles.