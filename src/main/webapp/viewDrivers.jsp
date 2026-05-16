<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.rental.driver.Driver" %>

<%
    Driver[] drivers = (Driver[]) request.getAttribute("drivers");

    Integer countObj = (Integer) request.getAttribute("count");

    int count = 0;

    if (countObj != null) {
        count = countObj;
    }
%>

<html>
<head>

    <title>Driver Directory | RentalDrive</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">

    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap"
          rel="stylesheet">

    <style>

        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
        }

        body{
            font-family:'Plus Jakarta Sans', sans-serif;
            background:#f8fafc;
            min-height:100vh;
            overflow-x:hidden;
            padding:30px;
            position:relative;
            color:#0f172a;
        }

        /* ================= BACKGROUND ================= */

        .bg-container{
            position:fixed;
            inset:0;
            z-index:-2;
            overflow:hidden;
        }

        .bg-container::before{
            content:'';
            position:absolute;
            inset:0;

            background-image:
                    linear-gradient(to right, rgba(148,163,184,0.08) 1px, transparent 1px),
                    linear-gradient(to bottom, rgba(148,163,184,0.08) 1px, transparent 1px);

            background-size:40px 40px;

            mask-image:radial-gradient(circle at center, black 40%, transparent 100%);
            -webkit-mask-image:radial-gradient(circle at center, black 40%, transparent 100%);
        }

        .bg-orb{
            position:absolute;
            border-radius:50%;
            filter:blur(90px);
            animation:float 18s infinite alternate cubic-bezier(0.45,0.05,0.55,0.95);
        }

        .orb-1{
            width:500px;
            height:500px;
            background:rgba(139,92,246,0.18);
            top:-10%;
            left:-5%;
        }

        .orb-2{
            width:550px;
            height:550px;
            background:rgba(56,189,248,0.18);
            bottom:-15%;
            right:-5%;
            animation-delay:-7s;
        }

        @keyframes float{

            0%{
                transform:translate(0,0) scale(1);
            }

            100%{
                transform:translate(40px,-40px) scale(1.1);
            }
        }

        /* ================= HEADER ================= */

        .page-header{
            text-align:center;
            margin-bottom:30px;
        }

        .badge{

            display:inline-block;

            padding:5px 14px;

            background:rgba(124,58,237,0.1);

            color:#7c3aed;

            border-radius:20px;

            font-size:10px;
            font-weight:800;

            letter-spacing:1px;
            text-transform:uppercase;

            margin-bottom:10px;
        }

        h1{
            font-size:32px;
            font-weight:800;
            letter-spacing:-1px;
            margin-bottom:8px;
        }

        .subtitle{
            color:#64748b;
            font-size:14px;
        }

        /* ================= GRID ================= */

        .driver-grid{

            display:grid;

            grid-template-columns:
                    repeat(auto-fill,minmax(230px,1fr));

            gap:18px;

            max-width:1250px;

            margin:auto;
        }

        /* ================= DRIVER CARD ================= */

        .driver-card{

            background:rgba(255,255,255,0.65);

            backdrop-filter:blur(24px) saturate(150%);
            -webkit-backdrop-filter:blur(24px) saturate(150%);

            padding:18px;

            border-radius:20px;

            border:1px solid rgba(255,255,255,0.8);

            box-shadow:
                    0 15px 35px rgba(0,0,0,0.05),
                    inset 0 1px 2px rgba(255,255,255,0.9);

            transition:
                    transform 0.4s cubic-bezier(0.16,1,0.3,1),
                    box-shadow 0.4s cubic-bezier(0.16,1,0.3,1),
                    border-color 0.4s ease;

            animation:cardPopup 0.7s cubic-bezier(0.16,1,0.3,1) forwards;

            transform:translateY(30px) scale(0.95);

            opacity:0;

            position:relative;

            overflow:hidden;
        }

        .driver-card:hover{

            transform:
                    translateY(-8px)
                    scale(1.02);

            border-color:rgba(124,58,237,0.25);

            box-shadow:
                    0 20px 40px rgba(124,58,237,0.10),
                    0 12px 25px rgba(0,0,0,0.06);

        }

        .driver-card::before{

            content:'';

            position:absolute;

            top:0;
            left:-100%;

            width:50%;
            height:100%;

            background:linear-gradient(
                    90deg,
                    transparent,
                    rgba(255,255,255,0.35),
                    transparent
            );

            transform:skewX(-20deg);

            transition:0.8s;
        }

        .driver-card:hover::before{
            left:150%;
        }

        @keyframes cardPopup{

            0%{
                opacity:0;
                transform:translateY(30px) scale(0.95);
            }

            100%{
                opacity:1;
                transform:translateY(0) scale(1);
            }
        }

        /* ================= AVATAR ================= */

        .avatar{

            width:50px;
            height:50px;

            border-radius:16px;

            background:#e0e7ff;

            color:#4f46e5;

            display:flex;
            align-items:center;
            justify-content:center;

            font-size:18px;
            font-weight:800;

            margin-bottom:14px;

            box-shadow:
                    inset 0 1px 2px rgba(255,255,255,0.9),
                    0 8px 16px rgba(79,70,229,0.10);
        }

        /* ================= TEXT ================= */

        .driver-name{
            font-size:18px;
            font-weight:800;
            margin-bottom:6px;
            letter-spacing:-0.4px;
        }

        .driver-id{
            color:#64748b;
            margin-bottom:12px;
            font-size:12px;
            font-weight:600;
        }

        .info{
            margin-bottom:8px;
            font-size:13px;
            color:#334155;
            line-height:1.5;
            font-weight:500;
        }

        .payment{
            margin-top:12px;
            font-weight:800;
            color:#0f172a;
            font-size:13px;
        }

        /* ================= STATUS ================= */

        .status{

            display:inline-block;

            margin-top:14px;

            padding:7px 12px;

            border-radius:30px;

            font-size:12px;
            font-weight:800;
        }

        .available{
            background:#dcfce7;
            color:#166534;
        }

        .not-available{
            background:#fee2e2;
            color:#991b1b;
        }

        /* ================= EMPTY ================= */

        .empty{

            text-align:center;

            padding:40px;

            background:rgba(255,255,255,0.7);

            backdrop-filter:blur(20px);

            border-radius:20px;

            color:#64748b;

            font-size:16px;

            font-weight:600;

            border:1px solid rgba(255,255,255,0.8);
        }

        /* ================= BACK BUTTON ================= */

        .back-wrapper{
            max-width:1250px;
            margin:auto;
        }

        .back-btn{

            display:inline-flex;
            align-items:center;
            gap:8px;

            margin-top:30px;

            text-decoration:none;

            color:#7c3aed;

            font-weight:700;

            font-size:14px;

            transition:0.3s ease;
        }

        .back-btn:hover{
            transform:translateX(-4px);
        }

    </style>

</head>

<body>

<div class="bg-container">

    <div class="bg-orb orb-1"></div>

    <div class="bg-orb orb-2"></div>

</div>

<div class="page-header">

    <span class="badge">
        Driver Management
    </span>

    <h1>Driver Directory</h1>

    <p class="subtitle">
        View and manage all registered drivers.
    </p>

</div>

<div class="driver-grid">

    <%
        boolean hasDrivers = false;

        if (drivers != null) {

            for (int i = 0; i < count; i++) {

                if (drivers[i] != null) {

                    hasDrivers = true;

                    String firstLetter =
                            drivers[i].getName()
                                    .substring(0,1)
                                    .toUpperCase();
    %>

    <div class="driver-card">

        <div class="avatar">
            <%= firstLetter %>
        </div>

        <div class="driver-name">
            <%= drivers[i].getName() %>
        </div>

        <div class="driver-id">
            ID: <%= drivers[i].getDriverId() %>
        </div>

        <div class="info">
            🚘 <%= drivers[i].getLicenseNumber() %>
        </div>

        <div class="info">
            👤 <%= drivers[i].getDriverType() %>
        </div>

        <div class="info">
            📞 <%= drivers[i].getPhone() %>
        </div>

        <div class="info">
            🆔 <%= drivers[i].getNic() %>
        </div>

        <div class="payment">
            💰 Rs. <%= drivers[i].calculatePayment() %>
        </div>

        <div class="status <%= drivers[i].isAvailable() ? "available" : "not-available" %>">

            <%= drivers[i].isAvailable()
                    ? "Available"
                    : "Not Available" %>

        </div>

    </div>

    <%
                }
            }
        }

        if (!hasDrivers) {
    %>

    <div class="empty">
        No drivers available
    </div>

    <%
        }
    %>

</div>

<div class="back-wrapper">

    <a href="index.jsp" class="back-btn">
        ← Back to Dashboard
    </a>

</div>

</body>
</html>