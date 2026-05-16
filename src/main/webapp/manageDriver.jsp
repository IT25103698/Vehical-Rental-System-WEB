<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>

    <title>Manage Driver | RentalDrive</title>

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
            width:550px;
            height:550px;
            background:rgba(139,92,246,0.25);
            top:-10%;
            left:-5%;
        }

        .orb-2{
            width:650px;
            height:650px;
            background:rgba(56,189,248,0.25);
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

        /* ================= PAGE HEADER ================= */

        .page-header{
            text-align:center;
            margin-bottom:35px;
        }

        .badge{

            display:inline-block;

            padding:5px 14px;

            background:rgba(124,58,237,0.1);

            color:#7c3aed;

            border-radius:20px;

            font-size:11px;
            font-weight:800;

            letter-spacing:1px;
            text-transform:uppercase;

            margin-bottom:12px;
        }

        h1{
            font-size:34px;
            font-weight:800;
            letter-spacing:-1px;
            margin-bottom:8px;
        }

        .subtitle{
            color:#64748b;
            font-size:14px;
        }

        /* ================= CARD GRID ================= */

        .container{
            display:grid;
            grid-template-columns:repeat(auto-fit,minmax(320px,1fr));
            gap:22px;
            max-width:1200px;
            margin:auto;
        }

        /* ================= GLASS CARDS ================= */

        .card{

            background:rgba(255,255,255,0.65);

            backdrop-filter:blur(30px) saturate(150%);
            -webkit-backdrop-filter:blur(30px) saturate(150%);

            padding:24px;

            border-radius:24px;

            border:1px solid rgba(255,255,255,0.8);

            box-shadow:
                    0 25px 50px rgba(0,0,0,0.05),
                    inset 0 1px 2px rgba(255,255,255,0.9),
                    inset 0 -1px 2px rgba(0,0,0,0.02);

            transition:
                    transform 0.45s cubic-bezier(0.16,1,0.3,1),
                    box-shadow 0.45s cubic-bezier(0.16,1,0.3,1),
                    border-color 0.45s ease;

            animation:cardPopup 0.8s cubic-bezier(0.16,1,0.3,1) forwards;

            transform:translateY(40px) scale(0.92);

            opacity:0;

            position:relative;

            overflow:hidden;
        }

        .card:hover{

            transform:
                    translateY(-12px)
                    scale(1.02);

            border-color:rgba(124,58,237,0.25);

            box-shadow:
                    0 35px 70px rgba(124,58,237,0.12),
                    0 20px 40px rgba(0,0,0,0.08);

        }

        @keyframes cardPopup{

            0%{
                opacity:0;
                transform:translateY(40px) scale(0.92);
            }

            60%{
                opacity:1;
                transform:translateY(-8px) scale(1.02);
            }

            100%{
                opacity:1;
                transform:translateY(0) scale(1);
            }
        }

        /* ================= CARD ICON ================= */

        .card-icon{

            width:55px;
            height:55px;

            border-radius:18px;

            display:flex;
            align-items:center;
            justify-content:center;

            font-size:24px;

            margin-bottom:18px;

            border:1px solid rgba(255,255,255,0.7);

            box-shadow:
                    inset 0 1px 2px rgba(255,255,255,0.8),
                    0 8px 20px rgba(0,0,0,0.05);
        }

        .delete-icon{
            background:#fee2e2;
        }

        .update-icon{
            background:#dcfce7;
        }

        .payment-icon{
            background:#fef3c7;
        }

        /* ================= TITLES ================= */

        .card h2{
            font-size:22px;
            font-weight:800;
            margin-bottom:18px;
            letter-spacing:-0.5px;
        }

        /* ================= INPUTS ================= */

        .input-group{
            margin-bottom:14px;
        }

        input,
        select{

            width:100%;

            padding:12px 14px;

            border-radius:14px;

            border:1.5px solid #e2e8f0;

            background:rgba(255,255,255,0.8);

            font-size:14px;

            font-family:inherit;

            color:#0f172a;

            transition:all 0.3s cubic-bezier(0.4,0,0.2,1);

            outline:none;
        }

        input::placeholder{
            color:#94a3b8;
        }

        input:hover,
        select:hover{
            border-color:#cbd5e1;
        }

        input:focus,
        select:focus{

            background:#ffffff;

            border-color:#7c3aed;

            box-shadow:
                    0 10px 20px -5px rgba(124,58,237,0.15),
                    0 0 0 4px rgba(124,58,237,0.08);

            transform:translateY(-2px);
        }

        /* ================= BUTTONS ================= */

        button{

            width:100%;

            padding:13px;

            border:none;

            border-radius:14px;

            color:white;

            font-size:14px;
            font-weight:800;

            cursor:pointer;

            position:relative;
            overflow:hidden;

            transition:all 0.35s cubic-bezier(0.16,1,0.3,1);
        }

        button::after{

            content:'';

            position:absolute;

            top:0;
            left:-100%;

            width:50%;
            height:100%;

            background:linear-gradient(
                    90deg,
                    transparent,
                    rgba(255,255,255,0.25),
                    transparent
            );

            transform:skewX(-20deg);

            transition:0.7s;
        }

        button:hover::after{
            left:150%;
        }

        button:hover{
            transform:translateY(-3px);
        }

        .delete-btn{
            background:linear-gradient(135deg,#ef4444,#dc2626);
            box-shadow:0 10px 20px rgba(239,68,68,0.25);
        }

        .update-btn{
            background:linear-gradient(135deg,#10b981,#059669);
            box-shadow:0 10px 20px rgba(16,185,129,0.25);
        }

        .paymentBtn{
            background:linear-gradient(135deg,#f59e0b,#d97706);
            box-shadow:0 10px 20px rgba(245,158,11,0.25);
        }

        /* ================= BACK BUTTON ================= */

        .back-btn{

            display:inline-flex;
            align-items:center;
            gap:8px;

            margin-top:35px;

            text-decoration:none;

            color:#7c3aed;

            font-weight:700;

            font-size:14px;

            transition:0.3s ease;
        }

        .back-btn:hover{
            transform:translateX(-4px);
        }

        .back-wrapper{
            max-width:1200px;
            margin:auto;
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
        Driver Control Center
    </span>

    <h1>Manage Drivers</h1>

    <p class="subtitle">
        Update driver operations, availability and payments.
    </p>

</div>

<div class="container">

    <!-- Delete Driver Card -->

    <div class="card">

        <div class="card-icon delete-icon">
            🗑️
        </div>

        <h2>Delete Driver</h2>

        <form action="/driver/delete" method="post">

            <div class="input-group">

                <input type="text"
                       name="licenseNumber"
                       placeholder="License Number"
                       required>

            </div>

            <button type="submit" class="delete-btn">
                Delete Driver
            </button>

        </form>

    </div>

    <!-- Update Availability Card -->

    <div class="card">

        <div class="card-icon update-icon">
            🔄
        </div>

        <h2>Update Availability</h2>

        <form action="/driver/updateAvailability" method="post">

            <div class="input-group">

                <input type="text"
                       name="licenseNumber"
                       placeholder="License Number"
                       required>

            </div>

            <div class="input-group">

                <select name="available">

                    <option value="true">
                        Available
                    </option>

                    <option value="false">
                        Not Available
                    </option>

                </select>

            </div>

            <button type="submit" class="update-btn">
                Update Availability
            </button>

        </form>

    </div>

    <!-- Freelance Payment Card -->

    <div class="card">

        <div class="card-icon payment-icon">
            💰
        </div>

        <h2>Freelance Payment</h2>

        <form action="/driver/updateFreelancePayment" method="post">

            <div class="input-group">

                <input type="text"
                       name="licenseNumber"
                       placeholder="License Number"
                       required>

            </div>

            <div class="input-group">

                <input type="number"
                       name="tripsCompleted"
                       placeholder="Trips Completed"
                       required>

            </div>

            <div class="input-group">

                <input type="number"
                       step="0.01"
                       name="commissionPerTrip"
                       placeholder="Commission Per Trip"
                       required>

            </div>

            <button type="submit" class="paymentBtn">
                Calculate Payment
            </button>

        </form>

    </div>

</div>

<div class="back-wrapper">

    <a href="index.jsp" class="back-btn">
        ← Back to Dashboard
    </a>

</div>

</body>
</html>