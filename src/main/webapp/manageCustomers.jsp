<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- UPDATED IMPORTS FOR THE NEW PROJECT STRUCTURE --%>
<%@ page import="com.rental.vehiclerentalsystem_v2.customer.Customer, com.rental.vehiclerentalsystem_v2.customer.CustomerFileManager, com.rental.vehiclerentalsystem_v2.utils.CustomerList" %>

<html>
<head>
    <title>Manage Customers | RentalDrive</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        * { margin:0; padding:0; box-sizing:border-box; }
        body {
            font-family:'Plus Jakarta Sans', sans-serif;
            background:#f8fafc;
            min-height:100vh;
            overflow-x:hidden;
            padding:35px;
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
        .orb-1 { width:500px; height:500px; background:rgba(139,92,246,0.18); top:-10%; left:-5%; }
        .orb-2 { width:550px; height:550px; background:rgba(56,189,248,0.18); bottom:-15%; right:-5%; animation-delay:-7s; }
        @keyframes float { 0% { transform:translate(0,0) scale(1); } 100% { transform:translate(40px,-40px) scale(1.1); } }
        .page-header { text-align:center; margin-bottom:28px; }
        .badge {
            display:inline-block; padding:5px 14px; background:rgba(124,58,237,0.1);
            color:#7c3aed; border-radius:20px; font-size:10px; font-weight:800;
            letter-spacing:1px; text-transform:uppercase; margin-bottom:10px;
        }
        h1 { font-size:34px; font-weight:800; letter-spacing:-1px; margin-bottom:8px; }
        .subtitle { color:#64748b; font-size:14px; }
        .table-card {
            max-width:1200px; margin:auto; background:rgba(255,255,255,0.65);
            backdrop-filter:blur(24px) saturate(150%); -webkit-backdrop-filter:blur(24px) saturate(150%);
            border-radius:24px; border:1px solid rgba(255,255,255,0.8);
            box-shadow: 0 20px 45px rgba(0,0,0,0.05), inset 0 1px 2px rgba(255,255,255,0.9);
            overflow:hidden; animation:popup 0.7s cubic-bezier(0.16,1,0.3,1);
        }
        @keyframes popup { 0% { opacity:0; transform:translateY(30px) scale(0.96); } 100% { opacity:1; transform:translateY(0) scale(1); } }
        table { width:100%; border-collapse:collapse; }
        thead { background:rgba(79,70,229,0.95); }
        th { padding:18px; text-align:left; color:white; font-size:13px; font-weight:700; letter-spacing:0.5px; }
        td { padding:18px; font-size:14px; font-weight:500; color:#334155; border-bottom:1px solid rgba(226,232,240,0.7); transition:0.3s ease; }
        tr { transition:0.3s ease; }
        tbody tr:hover { background:rgba(255,255,255,0.45); transform:scale(1.005); }
        .action-group { display:flex; gap:10px; }
        .btn { padding:8px 14px; border-radius:12px; text-decoration:none; font-size:13px; font-weight:700; transition:0.3s ease; }
        .btn-edit { background:#10b981; color:white; }
        .btn-edit:hover { background:#059669; transform:translateY(-2px); }
        .btn-delete { background:#ef4444; color:white; }
        .btn-delete:hover { background:#dc2626; transform:translateY(-2px); }
        .back-wrapper { max-width:1200px; margin:auto; }
        .back-btn { display:inline-flex; align-items:center; gap:8px; margin-top:28px; text-decoration:none; color:#7c3aed; font-weight:700; font-size:14px; transition:0.3s ease; }
        .back-btn:hover { transform:translateX(-4px); }
        @media(max-width:900px){ body{ padding:20px; } .table-card{ overflow-x:auto; } table{ min-width:750px; } }
    </style>
</head>

<body>
<div class="bg-container">
    <div class="bg-orb orb-1"></div>
    <div class="bg-orb orb-2"></div>
</div>

<div class="page-header">
    <span class="badge">Customer Management</span>
    <h1>Customer Dashboard</h1>
    <p class="subtitle">Manage all customer records in one place.</p>
</div>

<div class="table-card">
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>

        <%
            try {
                // Instantiating the class using the top import
                CustomerFileManager manager = new CustomerFileManager();
                CustomerList list = manager.getAllCustomers();

                for (int i = 0; i < list.size(); i++) {
                    // UPDATED INLINE REFERENCE TYPE FOR THE NEW PACKAGE STRUCTURE
                    com.rental.vehiclerentalsystem_v2.customer.Customer c = list.get(i);
        %>
        <tr>
            <td><%= c.getCustomerId() %></td>
            <td><%= c.getName() %></td>
            <td><%= c.getEmail() %></td>
            <td><%= c.getPhone() %></td>
            <td>
                <div class="action-group">
                    <a href="editCustomer.jsp?id=<%= c.getCustomerId() %>" class="btn btn-edit">Edit</a>
                    <a href="deleteCustomerProcess.jsp?id=<%= c.getCustomerId() %>" class="btn btn-delete" onclick="return confirm('Delete this customer?')">Delete</a>
                </div>
            </td>
        </tr>
        <%
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='5' style='color:red; padding:20px;'>Error: " + e.getMessage() + "</td></tr>");
            }
        %>

        </tbody>
    </table>
</div>

<div class="back-wrapper">
    <a href="index.jsp" class="back-btn">← Back to Dashboard</a>
</div>
</body>
</html>