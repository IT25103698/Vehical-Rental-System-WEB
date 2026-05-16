<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>RentalDrive | Exclusive Registration</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #f8fafc;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            /* Changed to allow scrolling on very small screens, but hide horizontal scroll */
            overflow-x: hidden;
            overflow-y: auto;
            padding: 20px;
            position: relative;
        }

        /* --- BACKGROUND CONTAINER (Locks the animations in place) --- */
        .bg-container {
            position: fixed;
            inset: 0;
            z-index: -2;
            overflow: hidden;
        }

        /* --- MODERN GRID PATTERN --- */
        .bg-container::before {
            content: '';
            position: absolute;
            inset: 0;
            background-image:
                linear-gradient(to right, rgba(148, 163, 184, 0.1) 1px, transparent 1px),
                linear-gradient(to bottom, rgba(148, 163, 184, 0.1) 1px, transparent 1px);
            background-size: 40px 40px;
            mask-image: radial-gradient(circle at center, black 40%, transparent 100%);
            -webkit-mask-image: radial-gradient(circle at center, black 40%, transparent 100%);
        }

        /* --- SMOOTH GLOWING ORBS --- */
        .bg-orb {
            position: absolute;
            border-radius: 50%;
            filter: blur(90px);
            animation: float 18s infinite alternate cubic-bezier(0.45, 0.05, 0.55, 0.95);
        }

        .orb-1 {
            width: 550px; height: 550px;
            background: rgba(139, 92, 246, 0.25);
            top: -10%; left: -5%;
        }

        .orb-2 {
            width: 650px; height: 650px;
            background: rgba(56, 189, 248, 0.25);
            bottom: -15%; right: -5%;
            animation-delay: -7s;
        }

        @keyframes float {
            0% { transform: translate(0, 0) scale(1); }
            100% { transform: translate(40px, -40px) scale(1.1); }
        }

        /* --- ULTRA-PREMIUM FORM CONTAINER (COMPACT) --- */
        .form-container {
            background: rgba(255, 255, 255, 0.65);
            backdrop-filter: blur(30px) saturate(150%);
            -webkit-backdrop-filter: blur(30px) saturate(150%);
            /* Tightened the padding here */
            padding: 35px 40px;
            border-radius: 24px;
            box-shadow:
                0 25px 50px rgba(0,0,0,0.05),
                inset 0 1px 2px rgba(255,255,255,0.9),
                inset 0 -1px 2px rgba(0,0,0,0.02);
            width: 100%;
            max-width: 460px;
            border: 1px solid rgba(255,255,255,0.8);
            position: relative;
            z-index: 10;
            animation: formAppear 0.8s cubic-bezier(0.16, 1, 0.3, 1) forwards;
        }

        @keyframes formAppear {
            0% { opacity: 0; transform: translateY(20px) scale(0.98); }
            100% { opacity: 1; transform: translateY(0) scale(1); }
        }

        .header {
            text-align: center;
            /* Tightened the bottom margin */
            margin-bottom: 25px;
        }

        .header-badge {
            display: inline-block;
            padding: 4px 12px;
            background: rgba(124, 58, 237, 0.1);
            color: #7c3aed;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 800;
            letter-spacing: 1px;
            text-transform: uppercase;
            margin-bottom: 10px;
        }

        .header h2 {
            color: #0f172a;
            font-size: 26px; /* Slightly smaller text */
            font-weight: 800;
            letter-spacing: -1px;
            margin-bottom: 6px;
        }

        .header p { color: #64748b; font-size: 14px; font-weight: 500; }

        /* --- STAGGERED ENTRANCE ANIMATIONS --- */
        .animate-item {
            opacity: 0;
            animation: slideUpFade 0.5s cubic-bezier(0.16, 1, 0.3, 1) forwards;
        }

        .delay-1 { animation-delay: 0.1s; }
        .delay-2 { animation-delay: 0.15s; }
        .delay-3 { animation-delay: 0.2s; }
        .delay-4 { animation-delay: 0.25s; }
        .delay-5 { animation-delay: 0.3s; }

        @keyframes slideUpFade {
            0% { opacity: 0; transform: translateY(10px); }
            100% { opacity: 1; transform: translateY(0); }
        }

        /* Tightened spacing between input rows */
        .input-group { margin-bottom: 15px; position: relative; }
        .row { display: flex; gap: 15px; }
        .col { flex: 1; }

        label {
            font-weight: 700;
            font-size: 12px;
            display: block;
            color: #475569;
            margin-bottom: 6px;
            transition: color 0.3s ease;
        }

        /* Smaller padding inside text boxes */
        input, select {
            width: 100%;
            padding: 12px 14px;
            background-color: rgba(255, 255, 255, 0.8);
            border: 1.5px solid #e2e8f0;
            border-radius: 12px;
            font-size: 14px;
            font-family: inherit;
            color: #0f172a;
            font-weight: 500;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        input::placeholder { color: #94a3b8; font-weight: 400; }

        input:hover, select:hover { border-color: #cbd5e1; }

        input:focus, select:focus {
            outline: none;
            background-color: #ffffff;
            border-color: #7c3aed;
            box-shadow: 0 10px 20px -5px rgba(124, 58, 237, 0.15), 0 0 0 4px rgba(124, 58, 237, 0.1);
            transform: translateY(-2px);
        }

        input:focus + label, select:focus + label { color: #7c3aed; }

        /* --- LUMINOUS SWEEP BUTTON --- */
        button {
            width: 100%;
            /* Tighter button padding */
            padding: 14px;
            background: linear-gradient(135deg, #7c3aed 0%, #9333ea 100%);
            color: white;
            border: none;
            border-radius: 14px;
            font-size: 15px;
            font-weight: 800;
            letter-spacing: 0.5px;
            cursor: pointer;
            position: relative;
            overflow: hidden;
            transition: all 0.4s cubic-bezier(0.16, 1, 0.3, 1);
            margin-top: 10px;
            box-shadow: 0 10px 20px rgba(124, 58, 237, 0.25);
        }

        button::after {
            content: '';
            position: absolute;
            top: 0; left: -100%; width: 50%; height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transform: skewX(-20deg);
            transition: all 0.6s ease;
        }

        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 25px rgba(124, 58, 237, 0.35);
        }

        button:hover::after { left: 150%; }
        button:active { transform: translateY(0); box-shadow: 0 5px 15px rgba(124, 58, 237, 0.3); }

    </style>
</head>
<body>

    <div class="bg-container">
        <div class="bg-orb orb-1"></div>
        <div class="bg-orb orb-2"></div>
    </div>

    <div class="form-container">

        <div class="header">
            <span class="header-badge">New Member</span>
            <h2>Join RentalDrive</h2>
            <p>Elevate your journey. Register below.</p>
        </div>

        <form action="CustomerServlet" method="POST">

            <div class="row animate-item delay-1">
                <div class="col input-group">
                    <label>Customer ID</label>
                    <input type="text" name="customerId" required placeholder="e.g. C001">
                </div>
                <div class="col input-group">
                    <label>Customer Type</label>
                    <select name="customerType" required>
                        <option value="Local">Local</option>
                        <option value="Foreign">Foreign</option>
                    </select>
                </div>
            </div>

            <div class="input-group animate-item delay-2">
                <label>Full Name</label>
                <input type="text" name="name" required placeholder="e.g. Kamal Perera">
            </div>

            <div class="input-group animate-item delay-3">
                <label>Email Address</label>
                <input type="email" name="email" required placeholder="e.g. kamal@email.com">
            </div>

            <div class="input-group animate-item delay-4">
                <label>Phone Number</label>
                <input type="text" name="phone" required placeholder="e.g. 071 234 5678">
            </div>

            <div class="input-group animate-item delay-5">
                <label>NIC or Passport</label>
                <input type="text" name="idNumber" required placeholder="e.g. 981234567V">
            </div>

            <div class="animate-item delay-5">
                <button type="submit">Complete Registration</button>
            </div>

        </form>
    </div>

</body>
</html>