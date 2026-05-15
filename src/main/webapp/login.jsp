<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login | Vehicle Rental System</title>
    <style>
        :root {
            --primary: #6366f1;
            --primary-hover: #4f46e5;
            --bg: #f3f4f6;
            --text-dark: #1f2937;
        }

        body {
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
            background-color: var(--bg);
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }

        .login-card {
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 10px 25px -5px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 400px;
        }

        .login-card h2 {
            margin: 0 0 10px 0;
            font-weight: 800;
            color: var(--text-dark);
            text-align: center;
        }

        .login-card p {
            color: #6b7280;
            text-align: center;
            margin-bottom: 30px;
            font-size: 0.9rem;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-size: 0.875rem;
            font-weight: 600;
            color: #374151;
            margin-bottom: 5px;
        }

        .form-group input {
            width: 100%;
            padding: 12px;
            border: 1px solid #d1d5db;
            border-radius: 10px;
            font-size: 1rem;
            outline: none;
            transition: border-color 0.2s;
            box-sizing: border-box;
        }

        .form-group input:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
        }

        .btn-login {
            width: 100%;
            background-color: var(--primary);
            color: white;
            padding: 14px;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 700;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .btn-login:hover {
            background-color: var(--primary-hover);
        }

        /* Error Message Styling */
        .error-msg {
            background-color: #fee2e2;
            color: #b91c1c;
            padding: 12px;
            border-radius: 10px;
            font-size: 0.875rem;
            text-align: center;
            margin-bottom: 20px;
            border: 1px solid #fecaca;
        }

        .info-box {
            margin-top: 25px;
            padding: 15px;
            background: #f9fafb;
            border-radius: 10px;
            font-size: 0.8rem;
            color: #6b7280;
            border: 1px dashed #e5e7eb;
        }
    </style>
</head>
<body>

<div class="login-card">
    <h2>Welcome Back</h2>
    <p>Please enter your details to sign in</p>

    <%-- This block displays the error only if the Servlet redirects back with ?error=1 --%>
    <% if (request.getParameter("error") != null) { %>
        <div class="error-msg">
            Invalid username or password. Please try again.
        </div>
    <% } %>

    <%-- Form action must match your @WebServlet annotation --%>
    <form action="LoginServlet" method="POST">
        <div class="form-group">
            <label for="username">Username / Email</label>
            <input type="text" id="username" name="username" required
                   placeholder="e.g. admin or customer@email.com">
        </div>

        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required
                   placeholder="••••••••">
        </div>

        <button type="submit" class="btn-login">Sign In</button>
    </form>

    <div class="info-box">
        <b>Login Credentials:</b><br>
        • <b>Admin:</b> admin / 1234<br>
        • <b>Customers:</b> Use registered Email as username and Phone Number as password.
    </div>
</div>

</body>
</html>