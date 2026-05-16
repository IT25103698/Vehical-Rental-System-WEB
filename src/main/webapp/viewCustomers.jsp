<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- UPDATED IMPORTS TO INCLUDE CHILD TYPE SCHEMAS FOR INSTANCE CHECKING --%>
<%@ page import="com.rental.vehiclerentalsystem_v2.customer.Customer" %>
<%@ page import="com.rental.vehiclerentalsystem_v2.customer.LocalCustomer" %>
<%@ page import="com.rental.vehiclerentalsystem_v2.customer.ForeignTourist" %>
<%@ page import="com.rental.vehiclerentalsystem_v2.customer.CustomerFileManager" %>
<%@ page import="com.rental.vehiclerentalsystem_v2.utils.CustomerList" %>

<html>
<head>
    <title>Customer Directory | RentalDrive</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        * { margin:0; padding:0; box-sizing:border-box; }
        body {
            font-family:'Plus Jakarta Sans', sans-serif;
            background:#f8fafc;
            min-height:100vh;
            overflow-x:hidden;
            padding:40px;
            position:relative;
            color:#0f172a;
        }
        .bg-container { position:fixed; inset:0; z-index:-2; overflow:hidden; }
        .bg-container::before {
            content:''; position:absolute; inset:0;
            background-image:
                    linear-gradient(to right, rgba(148,163,184,0.08) 1px, transparent 1px),
                    linear-gradient(to bottom, rgba(148,163,184,0.08) 1px, transparent 1px);
            background-size:40px 40px;
            mask-image:radial-gradient(circle at center, black 40%, transparent 100%);
            -webkit-mask-image:radial-gradient(circle at center, black 40%, transparent 100%);
        }
        .bg-orb {
            position:absolute; border-radius:50%; filter:blur(90px);
            animation:float 18s infinite alternate cubic-bezier(0.45,0.05,0.55,0.95);
        }
        .orb-1 { width:550px; height:550px; background:rgba(139,92,246,0.22); top:-10%; left:-5%; }
        .orb-2 { width:650px; height:650px; background:rgba(56,189,248,0.22); bottom:-15%; right:-5%; animation-delay:-7s; }
        @keyframes float { 0% { transform:translate(0,0) scale(1); } 100% { transform:translate(40px,-40px) scale(1.1); } }
        .page-header { text-align:center; margin-bottom:40px; }
        .badge {
            display:inline-block; padding:5px 14px; background:rgba(124,58,237,0.1);
            color:#7c3aed; border-radius:20px; font-size:11px; font-weight:800;
            letter-spacing:1px; text-transform:uppercase; margin-bottom:12px;
        }
        h1 { font-size:38px; font-weight:800; letter-spacing:-1px; margin-bottom:10px; }
        .subtitle { color:#64748b; font-size:15px; }
        .customer-grid { display:grid; grid-template-columns: repeat(auto-fill, minmax(280px,1fr)); gap:24px; max-width:1400px; margin:auto; }
        .card {
            background:rgba(255,255,255,0.65); backdrop-filter:blur(30px) saturate(150%); -webkit-backdrop-filter:blur(30px) saturate(150%);
            padding:24px; border-radius:24px; border:1px solid rgba(255,255,255,0.8);
            box-shadow: 0 25px 50px rgba(0,0,0,0.05), inset 0 1px 2px rgba(255,255,255,0.9), inset 0 -1px 2px rgba(0,0,0,0.02);
            transition: transform 0.45s cubic-bezier(0.16,1,0.3,1), box-shadow 0.45s cubic-bezier(0.16,1,0.3,1), border-color 0.45s ease;
            animation:cardPopup 0.8s cubic-bezier(0.16,1,0.3,1) forwards; transform:translateY(40px) scale(0.92); opacity:0; position:relative; overflow:hidden;
        }
        .card:hover { transform: translateY(-12px) scale(1.02); border-color:rgba(124,58,237,0.25); box-shadow: 0 35px 70px rgba(124,58,237,0.12), 0 20px 40px rgba(0,0,0,0.08); }
        .card::before { content:''; position:absolute; top:0; left:-100%; width:50%; height:100%; background:linear-gradient(90deg, transparent, rgba(255,255,255,0.35), transparent); transform:skewX(-20deg); transition:0.8s; }
        .card:hover::before { left:150%; }
        @keyframes cardPopup { 0% { opacity:0; transform:translateY(40px) scale(0.92); } 60% { opacity:1; transform:translateY(-8px) scale(1.02); } 100% { opacity:1; transform:translateY(0) scale(1); } }

        /* UPDATED AVATAR WRAPPER TO FIT GRAPHIC IMAGE COMPONENT PERFECTLY */
        .avatar { width:60px; height:60px; border-radius:18px; background:#e0e7ff; overflow:hidden; margin-bottom:18px; box-shadow: 0 10px 20px rgba(79,70,229,0.12); }
        .avatar img { width:100%; height:100%; object-fit:cover; }

        .card h3 { font-size:22px; font-weight:800; margin-bottom:8px; letter-spacing:-0.5px; }
        .customer-id { font-size:13px; color:#64748b; margin-bottom:6px; font-weight:600; }

        /* ADDED INLINE CUSTOMER TYPE META STYLE */
        .customer-type { font-size:12px; font-weight:700; text-transform:uppercase; letter-spacing:0.5px; color:#4f46e5; margin-bottom:16px; display:flex; align-items:center; gap:4px; }

        .info { font-size:14px; color:#334155; line-height:1.8; font-weight:500; }
        .back-wrapper { max-width:1400px; margin:auto; }
        .back-btn { display:inline-flex; align-items:center; gap:8px; margin-top:35px; text-decoration:none; color:#7c3aed; font-weight:700; font-size:14px; transition:0.3s ease; }
        .back-btn:hover { transform:translateX(-4px); }
    </style>
</head>

<body>
<div class="bg-container">
    <div class="bg-orb orb-1"></div>
    <div class="bg-orb orb-2"></div>
</div>

<div class="page-header">
    <span class="badge">Customer Management</span>
    <h1>Customer Directory</h1>
    <p class="subtitle">View and manage all registered customers.</p>
</div>

<div class="customer-grid">

    <%
        try {
            CustomerFileManager manager = new CustomerFileManager();
            CustomerList list = manager.getAllCustomers();

            for (int i = 0; i < list.size(); i++) {
                Customer c = list.get(i);

                String name = (c.getName() != null) ? c.getName() : "Unknown";

                // EVALUATE OBJECT BLUEPRINT RELATION FOR USER CATEGORY STRING
                String customerType = "Foreign Tourist";
                if (c instanceof LocalCustomer) {
                    customerType = "Local Customer";
                }

                // DYNAMIC PHOTO URL GENERATED PER CUSTOMER ID
                String photoUrl = "https://i.pravatar.cc/150?u=" + c.getCustomerId();
    %>

    <div class="card">
        <div class="avatar">
            <img src="<%= photoUrl %>" alt="<%= name %>">
        </div>
        <h3>
            <%= name %>
        </h3>
        <div class="customer-id">
            ID: <%= c.getCustomerId() %>
        </div>
        <div class="customer-type">
            👥 <%= customerType %>
        </div>
        <div class="info">
            📧 <%= c.getEmail() %>
            <br>
            📱 <%= c.getPhone() %>
        </div>
    </div>

    <%
            }
        } catch (Exception e) {
            out.println("<p style='color:red;'>Error loading directory data: " + e.getMessage() + "</p>");
        }
    %>

</div>

<div class="back-wrapper">
    <a href="index.jsp" class="back-btn">← Back to Dashboard</a>
</div>
</body>
</html>