<%
    // Session Security Check
    if (session.getAttribute("adminLoggedIn") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Master Dashboard | Vehicle Rental System</title>

    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <style>

        :root{
            --primary:#8b5cf6;
            --secondary:#06b6d4;
            --dark:#0f172a;
        }

        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
        }

        body{
            font-family:'Plus Jakarta Sans',sans-serif;
            min-height:100vh;
            overflow-x:hidden;

            background:
                    linear-gradient(
                            135deg,
                            #f8fafc 0%,
                            #eef2ff 35%,
                            #f1f5f9 70%,
                            #ffffff 100%
                    );

            color:#0f172a;
            position:relative;
        }

        /* GLOW EFFECTS */

        body::before{
            content:'';

            position:fixed;
            top:-200px;
            right:-150px;

            width:500px;
            height:500px;

            background:rgba(139,92,246,0.15);

            filter:blur(120px);

            border-radius:50%;

            z-index:-1;
        }

        body::after{
            content:'';

            position:fixed;
            bottom:-200px;
            left:-150px;

            width:500px;
            height:500px;

            background:rgba(6,182,212,0.12);

            filter:blur(120px);

            border-radius:50%;

            z-index:-1;
        }

        /* ================= NAVBAR ================= */

        .navbar{
            width:100%;
            padding:18px 60px;

            display:flex;
            justify-content:space-between;
            align-items:center;

            background:rgba(255,255,255,0.45);

            backdrop-filter:blur(18px);
            -webkit-backdrop-filter:blur(18px);

            border-bottom:1px solid rgba(255,255,255,0.3);

            position:sticky;
            top:0;
            z-index:1000;
        }

        .logo-area{
            display:flex;
            align-items:center;
            gap:12px;
        }

        .logo-dot{
            width:14px;
            height:14px;
            border-radius:50%;

            background:linear-gradient(135deg,#8b5cf6,#06b6d4);

            box-shadow:0 0 15px rgba(139,92,246,0.8);
        }

        .logo-text{
            font-size:1.4rem;
            font-weight:800;
            color:#0f172a;
            letter-spacing:1px;
        }

        .status-text{
            color:#475569;
            font-size:0.95rem;
            font-weight:600;
        }

        /* ================= HERO ================= */

        .hero{
            text-align:center;
            padding:100px 20px 120px;
        }

        .hero h1{
            font-size:4rem;
            font-weight:800;
            margin-bottom:18px;

            background:linear-gradient(to right,#0f172a,#8b5cf6);

            -webkit-background-clip:text;
            -webkit-text-fill-color:transparent;
        }

        .hero p{
            max-width:700px;
            margin:auto;

            font-size:1.1rem;
            line-height:1.8;

            color:#475569;
        }

        /* ================= CONTAINER ================= */

        .container{
            max-width:1300px;
            margin:auto;
            padding:0 20px 80px;
        }

        /* ================= GRID ================= */

        .category-grid{
            display:grid;
            grid-template-columns:repeat(auto-fit,minmax(340px,1fr));
            gap:28px;
        }

        /* ================= LIQUID GLASS CARDS ================= */

        .category-card{
            position:relative;
            overflow:hidden;

            border-radius:30px;

            background:rgba(255,255,255,0.45);

            backdrop-filter:blur(25px);
            -webkit-backdrop-filter:blur(25px);

            border:1px solid rgba(255,255,255,0.4);

            box-shadow:
                    0 8px 32px rgba(15,23,42,0.08),
                    inset 0 1px 1px rgba(255,255,255,0.7);

            transition:0.45s ease;
        }

        .category-card::before{
            content:'';

            position:absolute;

            top:-100%;
            left:-50%;

            width:200%;
            height:300%;

            background:linear-gradient(
                    120deg,
                    transparent,
                    rgba(255,255,255,0.45),
                    transparent
            );

            transform:rotate(25deg);

            transition:0.8s;
        }

        .category-card:hover::before{
            top:-40%;
            left:-20%;
        }

        .category-card:hover{
            transform:translateY(-12px) scale(1.02);

            border-color:rgba(255,255,255,0.8);

            box-shadow:
                    0 20px 45px rgba(15,23,42,0.12),
                    0 0 30px rgba(139,92,246,0.15);
        }

        .card-overlay{
            padding:30px;
            position:relative;
            z-index:5;
        }

        /* ================= CARD HEADER ================= */

        .card-header-row{
            display:flex;
            justify-content:space-between;
            align-items:center;

            margin-bottom:25px;
        }

        .icon-box{
            width:62px;
            height:62px;

            display:flex;
            align-items:center;
            justify-content:center;

            border-radius:20px;

            background:rgba(255,255,255,0.5);

            backdrop-filter:blur(12px);

            border:1px solid rgba(255,255,255,0.5);

            font-size:1.7rem;

            box-shadow:
                    inset 0 1px 1px rgba(255,255,255,0.8),
                    0 8px 20px rgba(15,23,42,0.08);
        }

        .member-id{
            padding:8px 14px;

            border-radius:50px;

            background:rgba(255,255,255,0.5);

            border:1px solid rgba(255,255,255,0.4);

            color:#475569;

            font-size:0.75rem;
            font-weight:700;

            backdrop-filter:blur(10px);
        }

        .category-card h2{
            font-size:1.6rem;
            margin-bottom:25px;
            font-weight:800;
            color:#0f172a;
        }

        /* ================= BUTTONS ================= */

        .action-list{
            display:flex;
            flex-direction:column;
            gap:14px;
        }

        .action-btn{
            display:flex;
            align-items:center;
            justify-content:space-between;

            padding:16px 18px;

            border-radius:16px;

            text-decoration:none;
            color:#0f172a;

            font-size:0.95rem;
            font-weight:600;

            background:rgba(255,255,255,0.42);

            border:1px solid rgba(255,255,255,0.45);

            backdrop-filter:blur(10px);

            transition:0.3s ease;
        }

        .action-btn:hover{
            background:rgba(255,255,255,0.7);

            transform:translateX(6px);

            border-color:rgba(139,92,246,0.25);

            box-shadow:0 8px 20px rgba(15,23,42,0.08);
        }

        .action-btn span:last-child{
            font-size:1rem;
            opacity:0.8;
        }

        /* ================= LOGOUT ================= */

        .logout-container{
            margin-top:70px;
            text-align:center;
        }

        .logout-link{
            display:inline-flex;
            align-items:center;
            gap:10px;

            padding:16px 32px;

            border-radius:60px;

            text-decoration:none;
            color:white;
            font-weight:700;

            background:linear-gradient(135deg,#8b5cf6,#06b6d4);

            border:none;

            box-shadow:
                    0 10px 25px rgba(139,92,246,0.25);

            transition:0.3s;
        }

        .logout-link:hover{
            transform:translateY(-5px);

            box-shadow:
                    0 15px 35px rgba(139,92,246,0.35);
        }

        /* ================= RESPONSIVE ================= */

        @media(max-width:768px){

            .navbar{
                padding:18px 25px;
            }

            .hero h1{
                font-size:2.7rem;
            }

            .category-grid{
                grid-template-columns:1fr;
            }

        }

    </style>
</head>

<body>

<div class="navbar">

    <div class="logo-area">
        <div class="logo-dot"></div>
        <span class="logo-text">RentalDrive Admin</span>
    </div>

    <div class="status-text">
        System Status:
        <span style="color:#22c55e;">● Online</span>
    </div>

</div>

<div class="hero">

    <h1>System Command Center</h1>

    <p>
        Manage fleet, operations, customers, bookings,
        and finances in one premium smart interface.
    </p>

</div>

<div class="container">

    <div class="category-grid">

        <!-- CUSTOMER -->

        <div class="category-card">

            <div class="card-overlay">

                <div class="card-header-row">
                    <div class="icon-box">👥</div>
                    <span class="member-id">Member 1</span>
                </div>

                <h2>Customer Relations</h2>

                <div class="action-list">

                    <a href="registerCustomer.jsp" class="action-btn">
                        <span>📝 Register New</span>
                        <span>→</span>
                    </a>

                    <a href="manageCustomers.jsp" class="action-btn">
                        <span>⚙️ Manage Directory</span>
                        <span>→</span>
                    </a>

                    <a href="viewCustomers.jsp" class="action-btn">
                        <span>🔍 View Records</span>
                        <span>→</span>
                    </a>

                </div>

            </div>

        </div>

        <!-- DRIVER -->

        <div class="category-card">

            <div class="card-overlay">

                <div class="card-header-row">
                    <div class="icon-box">👨‍✈️</div>
                    <span class="member-id">Member 2</span>
                </div>

                <h2>Driver Network</h2>

                <div class="action-list">

                    <a href="addDriver.jsp" class="action-btn">
                        <span>➕ Add Driver</span>
                        <span>→</span>
                    </a>

                    <a href="manageDriver.jsp" class="action-btn">
                        <span>⚙️ Manage Driver</span>
                        <span>→</span>
                    </a>

                    <a href="${pageContext.request.contextPath}/driver" class="action-btn">
                        <span>📋 View Drivers</span>
                        <span>→</span>
                    </a>

                </div>

            </div>

        </div>

        <!-- VEHICLE -->

        <div class="category-card">

            <div class="card-overlay">

                <div class="card-header-row">
                    <div class="icon-box">🚗</div>
                    <span class="member-id">Member 3</span>
                </div>

                <h2>Vehicle Inventory</h2>

                <div class="action-list">

                    <a href="registerVehicle.jsp" class="action-btn">
                        <span>➕ Add Asset</span>
                        <span>→</span>
                    </a>

                    <a href="manageVehicles.jsp" class="action-btn">
                        <span>⚙️ Fleet Maintenance</span>
                        <span>→</span>
                    </a>

                    <a href="viewVehicles.jsp" class="action-btn">
                        <span>🔍 Stock Audit</span>
                        <span>→</span>
                    </a>

                </div>

            </div>

        </div>

        <!-- PACKAGE -->

        <div class="category-card">

            <div class="card-overlay">

                <div class="card-header-row">
                    <div class="icon-box">🎁</div>
                    <span class="member-id">Member 4</span>
                </div>

                <h2>Rental Packages</h2>

                <div class="action-list">

                    <a href="addPackage.jsp" class="action-btn">
                        <span>✨ Create Offer</span>
                        <span>→</span>
                    </a>

                    <a href="viewPackages.jsp" class="action-btn">
                        <span>📦 View Catalog</span>
                        <span>→</span>
                    </a>

                </div>

            </div>

        </div>

        <!-- BOOKING -->

        <div class="category-card">

            <div class="card-overlay">

                <div class="card-header-row">
                    <div class="icon-box">🗓️</div>
                    <span class="member-id">Member 5</span>
                </div>

                <h2>Booking Engine</h2>

                <div class="action-list">

                    <a href="registerBooking.jsp" class="action-btn">
                        <span>🗓️ New Booking</span>
                        <span>→</span>
                    </a>

                    <a href="viewBookings.jsp" class="action-btn">
                        <span>📂 Transaction Log</span>
                        <span>→</span>
                    </a>

                </div>

            </div>

        </div>

        <!-- PAYMENT -->

        <div class="category-card">

            <div class="card-overlay">

                <div class="card-header-row">
                    <div class="icon-box">💳</div>
                    <span class="member-id">Member 6</span>
                </div>

                <h2>Financial Ledger</h2>

                <div class="action-list">

                    <a href="makePayment.jsp" class="action-btn">
                        <span>💳 Process Payment</span>
                        <span>→</span>
                    </a>

                    <a href="viewPayments.jsp" class="action-btn">
                        <span>📊 Revenue Analytics</span>
                        <span>→</span>
                    </a>

                </div>

            </div>

        </div>

    </div>

    <div class="logout-container">

        <a href="login.jsp" class="logout-link">
            🔒 Terminate Secure Session
        </a>

    </div>

</div>

</body>
</html>