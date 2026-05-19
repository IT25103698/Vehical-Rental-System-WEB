<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Process Payment | Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f3f4f6; padding: 40px; color: #1f2937; }
        .form-container { background: white; padding: 35px; border-radius: 15px; box-shadow: 0 10px 25px rgba(0,0,0,0.05); max-width: 450px; margin: auto; }

        /* Modern Green Header for Payments */
        h2 { text-align: center; color: #16a34a; margin-top: 0; margin-bottom: 25px; font-weight: 700; border-bottom: 2px solid #22c55e; padding-bottom: 15px; }

        .form-group { margin-bottom: 18px; }
        label { font-weight: 600; display: block; margin-bottom: 8px; color: #374151; font-size: 0.95rem; }
        input[type="text"], input[type="number"], select {
            width: 100%; padding: 12px 15px; border: 1px solid #d1d5db;
            border-radius: 8px; box-sizing: border-box; font-size: 15px;
            transition: border-color 0.3s, box-shadow 0.3s;
        }
        input[type="text"]:focus, input[type="number"]:focus, select:focus {
            border-color: #22c55e; outline: none; box-shadow: 0 0 0 3px rgba(34, 197, 94, 0.2);
        }

        .submit-btn { width: 100%; padding: 14px; background-color: #16a34a; color: white; border: none; border-radius: 8px; font-size: 16px; font-weight: 700; cursor: pointer; margin-top: 10px; transition: background 0.3s; }
        .submit-btn:hover { background-color: #15803d; }

        .back-link { display: block; text-align: center; margin-top: 20px; text-decoration: none; color: #6b7280; font-size: 0.95rem; transition: color 0.3s; }
        .back-link:hover { color: #1f2937; }

        /* Error Alert Styling */
        .error-msg { background: #fee2e2; color: #b91c1c; padding: 14px; border-radius: 8px; margin-bottom: 20px; text-align: center; font-weight: 600; font-size: 0.95rem; border: 1px solid #f87171; }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>💳 Process Payment</h2>

        <%-- Listens for the failure trigger from PaymentServlet --%>
        <% if ("1".equals(request.getParameter("error"))) { %>
            <div class="error-msg">⚠️ Failed to process payment. Please verify the amount and details.</div>
        <% } %>

        <form action="PaymentServlet" method="post">
            <div class="form-group">
                <label>Payment ID:</label>
                <input type="text" name="paymentId" placeholder="e.g. P001" required>
            </div>

            <div class="form-group">
                <label>Booking ID:</label>
                <input type="text" name="bookingId" placeholder="e.g. B001" required>
            </div>

            <div class="form-group">
                <label>Amount (LKR):</label>
                <%-- Added step="0.01" to allow decimal amounts safely --%>
                <input type="number" name="amount" step="0.01" placeholder="0.00" required>
            </div>

            <div class="form-group">
                <label>Payment Method:</label>
                <select name="paymentMethod">
                    <option value="Cash">Cash</option>
                    <option value="Credit Card">Credit Card</option>
                    <option value="Bank Transfer">Bank Transfer</option>
                </select>
            </div>

            <div class="form-group">
                <label>Status:</label>
                <select name="status">
                    <option value="Paid">Paid</option>
                    <option value="Pending">Pending</option>
                </select>
            </div>

            <button type="submit" class="submit-btn">Submit Payment</button>
        </form>

        <%-- Updated to go back to the payments table instead of the root index --%>
        <a href="viewPayments.jsp" class="back-link">← Cancel and Go Back</a>
    </div>
</body>
</html>