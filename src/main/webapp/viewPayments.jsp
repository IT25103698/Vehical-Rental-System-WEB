<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- EXPLICIT IMPORTS: Targets your new package path structure to prevent runtime engine compile issues --%>
<%@ page import="java.util.List" %>
<%@ page import="com.rental.vehiclerentalsystem_v2.payment.Payment" %>
<%@ page import="com.rental.vehiclerentalsystem_v2.payment.PaymentFileManager" %>

<html>
<head>
    <title>Payment Ledger | Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; background: #f3f4f6; padding: 40px; color: #1f2937; }
        .card { background: white; padding: 30px; border-radius: 15px; box-shadow: 0 10px 15px rgba(0,0,0,0.05); max-width: 1200px; margin: auto; }

        .header-flex { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; border-bottom: 2px solid #10b981; padding-bottom: 15px; }
        .header-flex h2 { margin: 0; color: #065f46; font-weight: 700; }

        .btn-process { background: #10b981; color: white; padding: 10px 20px; border-radius: 8px; text-decoration: none; font-weight: 600; transition: background 0.3s; }
        .btn-process:hover { background: #059669; }

        table { width: 100%; border-collapse: collapse; margin-top: 20px; background: white; border-radius: 8px; overflow: hidden; }
        th { background: #065f46; color: white; padding: 14px; text-align: left; font-size: 0.9rem; font-weight: 600; }
        td { padding: 14px; border-bottom: 1px solid #e5e7eb; font-size: 0.95rem; }
        tr:hover { background: #f9fafb; }

        /* Dynamic Visual Badges for Status fields */
        .status-badge { padding: 5px 10px; border-radius: 6px; font-size: 0.8rem; font-weight: 700; text-transform: uppercase; display: inline-block; }
        .status-paid { background: #dcfce7; color: #166534; }
        .status-pending { background: #fef3c7; color: #92400e; }

        .actions-cell { display: flex; gap: 15px; align-items: center; }
        .btn-update { color: #2563eb; text-decoration: none; font-weight: 600; font-size: 0.9rem; transition: color 0.2s; }
        .btn-update:hover { color: #1d4ed8; text-decoration: underline; }

        .btn-delete { color: #dc2626; text-decoration: none; font-weight: 600; font-size: 0.9rem; transition: color 0.2s; }
        .btn-delete:hover { color: #b91c1c; text-decoration: underline; }

        .error-banner { background: #fee2e2; color: #b91c1c; padding: 12px; border-radius: 8px; margin-bottom: 20px; font-weight: 600; text-align: center; border: 1px solid #f87171; }
    </style>
</head>
<body>

    <div class="card">
        <div class="header-flex">
            <h2>💰 Financial Ledger</h2>
            <%-- Simple button forwarding inside navigation scope --%>
            <a href="processPayment.jsp" class="btn-process">+ Process New Payment</a>
        </div>

        <%-- Notification panel catches validation exceptions passed by underlying Servlets --%>
        <% if ("1".equals(request.getParameter("error"))) { %>
            <div class="error-banner">⚠️ System Exception: Failed to modify data constraints. Check context logs for details.</div>
        <% } %>

        <table>
            <thead>
                <tr>
                    <th>Payment ID</th>
                    <th>Booking ID</th>
                    <th>Amount</th>
                    <th>Method</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        PaymentFileManager pfm = new PaymentFileManager();
                        List<Payment> payments = pfm.getAllPayments();

                        if (payments != null && !payments.isEmpty()) {
                            for(Payment p : payments) {
                                boolean isPaid = "Paid".equalsIgnoreCase(p.getStatus());
                %>
                <tr>
                    <td><b><%= p.getPaymentId() %></b></td>
                    <td><code style="background:#f1f5f9; padding:2px 5px; border-radius:4px;"><%= p.getBookingId() %></code></td>
                    <td style="font-weight: 600; color: #111827;">LKR <%= String.format("%.2f", p.getAmount()) %></td>
                    <td><%= p.getPaymentMethod() %></td>
                    <td>
                        <span class="status-badge <%= isPaid ? "status-paid" : "status-pending" %>">
                            <%= p.getStatus() %>
                        </span>
                    </td>
                    <td>
                        <div class="actions-cell">
                            <% if(!isPaid) { %>
                                <a href="UpdatePaymentServlet?id=<%= p.getPaymentId() %>&status=Paid" class="btn-update">Mark Paid</a>
                            <% } %>
                            <a href="DeletePaymentServlet?id=<%= p.getPaymentId() %>"
                               class="btn-delete"
                               onclick="return confirm('Are you sure you want to void this transaction and issue a refund?')">Refund</a>
                        </div>
                    </td>
                </tr>
                <%
                            }
                        } else {
                %>
                <tr><td colspan="6" style="text-align:center; padding: 40px; color: #9ca3af;">No payment transactions currently recorded in system memory.</td></tr>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='6' style='color:red; font-weight:bold; padding:20px;'>Parsing Exception: " + e.getMessage() + "</td></tr>");
                    }
                %>
            </tbody>
        </table>

        <br>
        <p style="margin-top:20px;"><a href="index.jsp" style="color:#6b7280; text-decoration:none; font-weight:500;">← Back to Dashboard</a></p>
    </div>

</body>
</html>