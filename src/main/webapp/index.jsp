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
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #6366f1;
            --secondary: #10b981;
            --accent: #f59e0b;
            --danger: #ef4444;
            --dark: #0f172a;
            --light-bg: #f8fafc;
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: var(--light-bg);
            margin: 0; padding: 0;
            color: var(--dark);
        }

        /* 1. TOP NAVIGATION */
        .navbar {
            background: white;
            padding: 15px 50px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
            position: sticky; top: 0; z-index: 100;
        }

        .logo-area { display: flex; align-items: center; gap: 10px; }
        .logo-dot { width: 12px; height: 12px; background: var(--primary); border-radius: 50%; }
        .logo-text { font-weight: 800; font-size: 1.2rem; color: var(--dark); text-transform: uppercase; letter-spacing: 1px; }

        /* 2. MODERN HERO HEADER (From Screenshot 1) */
        .hero {
            background: linear-gradient(rgba(15, 23, 42, 0.85), rgba(15, 23, 42, 0.85)),
                        url('https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?auto=format&fit=crop&w=1600&q=80');
            background-size: cover;
            background-position: center;
            padding: 90px 20px 120px 20px; /* Extra bottom padding for overlap */
            text-align: center;
            color: white;
            border-radius: 0 0 40px 40px;
        }

        .hero h1 { font-size: 3.2rem; margin: 0; font-weight: 800; letter-spacing: -1.5px; }
        .hero p { opacity: 0.85; font-size: 1.1rem; margin-top: 10px; }

        .container { max-width: 1200px; margin: -80px auto 80px; padding: 0 20px; position: relative; z-index: 10; }

        /* 3. THE 6 CATEGORY GRID */
        .category-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(340px, 1fr));
            gap: 25px;
        }

        /* HYBRID CARD: Photo Backgrounds (Screenshot 2) inside Overlapping Grid (Screenshot 1) */
        .category-card {
            border-radius: 24px;
            box-shadow: 0 10px 25px -5px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            background-size: cover;
            background-position: center;
            border: 1px solid #e2e8f0;
        }

        .category-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 25px 50px -12px rgba(0,0,0,0.15);
            border-color: var(--primary);
        }

        /* Frosted Glass Overlay to make text readable */
        .card-overlay {
            background: linear-gradient(to bottom, rgba(255,255,255,0.65) 0%, rgba(255,255,255,0.95) 35%, rgba(255,255,255,1) 100%);
            backdrop-filter: blur(6px);
            padding: 30px;
            height: 100%;
            box-sizing: border-box;
            display: flex;
            flex-direction: column;
        }

        /* Card Background Images */
        .c1 { background-image: url('https://images.unsplash.com/photo-1557804506-669a67965ba0?auto=format&fit=crop&w=600&q=80'); }
        .c2 { background-image: url('https://images.unsplash.com/photo-1449965408869-eaa3f722e40d?auto=format&fit=crop&w=600&q=80'); }
        .c3 { background-image: url('https://images.unsplash.com/photo-1503376780353-7e6692767b70?auto=format&fit=crop&w=600&q=80'); }
        .c4 { background-image: url('https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?auto=format&fit=crop&w=600&q=80'); }
        .c5 { background-image: url('https://images.unsplash.com/photo-1506784983877-45594efa4cbe?auto=format&fit=crop&w=600&q=80'); }
        .c6 { background-image: url('https://images.unsplash.com/photo-1554224155-6726b3ff858f?auto=format&fit=crop&w=600&q=80'); }

        /* Card Inner Elements */
        .card-header-row { display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 15px; }

        .icon-box {
            width: 50px; height: 50px;
            border-radius: 14px;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.5rem;
            background: white; /* Fallback */
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
        }

        /* Specific Icon Colors */
        .c1 .icon-box { background: #e0e7ff; color: var(--primary); }
        .c2 .icon-box { background: #dcfce7; color: var(--secondary); }
        .c3 .icon-box { background: #ffedd5; color: var(--accent); }
        .c4 .icon-box { background: #fce7f3; color: #db2777; }
        .c5 .icon-box { background: #e0f2fe; color: #0284c7; }
        .c6 .icon-box { background: #f1f5f9; color: var(--dark); }

        .member-id {
            background: rgba(241, 245, 249, 0.9);
            color: #64748b;
            padding: 6px 12px;
            border-radius: 50px;
            font-size: 0.7rem;
            font-weight: 800;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }

        .category-card h2 { margin: 0 0 20px 0; font-size: 1.4rem; font-weight: 800; color: #0f172a; }

        /* ACTION BUTTONS */
        .action-list { display: flex; flex-direction: column; gap: 10px; flex-grow: 1; justify-content: flex-end; }

        .action-btn {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 14px 18px;
            background: rgba(248, 250, 252, 0.8);
            border: 1px solid rgba(226, 232, 240, 0.8);
            border-radius: 12px;
            text-decoration: none;
            color: var(--dark);
            font-size: 0.95rem;
            font-weight: 600;
            transition: 0.2s;
        }

        .action-btn:hover {
            background: white;
            border-color: var(--primary);
            transform: translateX(5px);
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
        }

        .action-btn span:last-child { color: #94a3b8; font-weight: bold; }

        .logout-container { text-align: center; margin-top: 60px; }

        .logout-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: white;
            color: var(--danger);
            padding: 12px 25px;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 700;
            font-size: 0.9rem;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
            transition: 0.3s;
        }

        .logout-link:hover { background: #fee2e2; transform: translateY(-2px); }
    </style>
</head>
<body>

<div class="navbar">
    <div class="logo-area">
        <div class="logo-dot"></div>
        <span class="logo-text">RentalDrive Admin</span>
    </div>
    <div style="font-size: 0.9rem; color: #64748b; font-weight: 600;">
        System Status: <span style="color:var(--secondary)">● Online</span>
    </div>
</div>

<div class="hero">
    <h1>System Command Center</h1>
    <p>Manage fleet, operations, and finances in one smart interface.</p>
</div>

<div class="container">

    <div class="category-grid">

        <div class="category-card c1">
            <div class="card-overlay">
                <div class="card-header-row">
                    <div class="icon-box">👥</div>
                    <span class="member-id">Member 1</span>
                </div>
                <h2>Customer Relations</h2>
                <div class="action-list">
                    <a href="registerCustomer.jsp" class="action-btn"><span>📝 Register New</span> <span>→</span></a>
                    <a href="manageCustomers.jsp" class="action-btn"><span>⚙️ Manage Directory</span> <span>→</span></a>
                    <a href="viewCustomers.jsp" class="action-btn"><span>🔍 View Records</span> <span>→</span></a>
                </div>
            </div>
        </div>

        <div class="category-card c2">
            <div class="card-overlay">
                <div class="card-header-row">
                    <div class="icon-box">👨‍✈️</div>
                    <span class="member-id">Member 2</span>
                </div>
                <h2>Driver Network</h2>
                <div class="action-list">
                    <a href="addDriver.jsp" class="action-btn"><span>➕ Add Driver</span> <span>→</span></a>
                    <a href="manageDriver.jsp" class="action-btn"><span>⚙️ Manage Driver</span> <span>→</span></a>
                    <a href="${pageContext.request.contextPath}/driver" class="action-btn"><span>📋 View Drivers</span> <span>→</span></a>
                </div>
            </div>
        </div>

        <div class="category-card c3">
            <div class="card-overlay">
                <div class="card-header-row">
                    <div class="icon-box">🚗</div>
                    <span class="member-id">Member 3</span>
                </div>
                <h2>Vehicle Inventory</h2>
                <div class="action-list">
                    <a href="registerVehicle.jsp" class="action-btn"><span>➕ Add Asset</span> <span>→</span></a>
                    <a href="manageVehicles.jsp" class="action-btn"><span>⚙️ Fleet Maintenance</span> <span>→</span></a>
                    <a href="viewVehicles.jsp" class="action-btn"><span>🔍 Stock Audit</span> <span>→</span></a>
                </div>
            </div>
        </div>

        <div class="category-card c4">
            <div class="card-overlay">
                <div class="card-header-row">
                    <div class="icon-box">🎁</div>
                    <span class="member-id">Member 4</span>
                </div>
                <h2>Rental Packages</h2>
                <div class="action-list">
                    <a href="addPackage.jsp" class="action-btn"><span>✨ Create Offer</span> <span>→</span></a>
                    <a href="viewPackages.jsp" class="action-btn"><span>📦 View Catalog</span> <span>→</span></a>
                </div>
            </div>
        </div>

        <div class="category-card c5">
            <div class="card-overlay">
                <div class="card-header-row">
                    <div class="icon-box">🗓️</div>
                    <span class="member-id">Member 5</span>
                </div>
                <h2>Booking Engine</h2>
                <div class="action-list">
                    <a href="registerBooking.jsp" class="action-btn"><span>🗓️ New Booking</span> <span>→</span></a>
                    <a href="viewBookings.jsp" class="action-link action-btn"><span>📂 Transaction Log</span> <span>→</span></a>
                </div>
            </div>
        </div>

        <div class="category-card c6">
            <div class="card-overlay">
                <div class="card-header-row">
                    <div class="icon-box">💳</div>
                    <span class="member-id">Member 6</span>
                </div>
                <h2>Financial Ledger</h2>
                <div class="action-list">
                    <a href="makePayment.jsp" class="action-btn"><span>💳 Process Payment</span> <span>→</span></a>
                    <a href="viewPayments.jsp" class="action-btn"><span>📊 Revenue Analytics</span> <span>→</span></a>
                </div>
            </div>
        </div>

    </div>

    <div class="logout-container">
        <a href="login.jsp" class="logout-link">🔒 Terminate Secure Session</a>
    </div>
</div>

</body>
</html>