<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>

    <title>Add Driver | RentalDrive</title>

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
            display:flex;
            justify-content:center;
            align-items:center;
            overflow-x:hidden;
            overflow-y:auto;
            padding:20px;
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

        /* ================= CONTAINER ================= */

        .container{
            width:100%;
            max-width:520px;
        }

        /* ================= GLASS CARD ================= */

        .card{

            background:rgba(255,255,255,0.65);

            backdrop-filter:blur(30px) saturate(150%);
            -webkit-backdrop-filter:blur(30px) saturate(150%);

            padding:20px 24px;

            border-radius:24px;

            border:1px solid rgba(255,255,255,0.8);

            box-shadow:
                    0 25px 50px rgba(0,0,0,0.05),
                    inset 0 1px 2px rgba(255,255,255,0.9),
                    inset 0 -1px 2px rgba(0,0,0,0.02);

            position:relative;

            animation:formAppear 0.8s cubic-bezier(0.16,1,0.3,1) forwards;
        }

        @keyframes formAppear{

            0%{
                opacity:0;
                transform:translateY(20px) scale(0.98);
            }

            100%{
                opacity:1;
                transform:translateY(0) scale(1);
            }
        }

        /* ================= HEADER ================= */

        .header{
            text-align:center;
            margin-bottom:16px;
        }

        .badge{

            display:inline-block;

            padding:4px 12px;

            background:rgba(124,58,237,0.1);

            color:#7c3aed;

            border-radius:20px;

            font-size:10px;
            font-weight:800;

            letter-spacing:1px;
            text-transform:uppercase;

            margin-bottom:10px;
        }

        h2{
            font-size:22px;
            font-weight:800;
            letter-spacing:-1px;
            margin-bottom:6px;
            color:#0f172a;
        }

        .subtitle{
            color:#64748b;
            font-size:13px;
            line-height:1.5;
        }

        /* ================= FORM ================= */

        form{
            margin-top:8px;
        }

        .input-group{
            margin-bottom:10px;
            position:relative;
        }

        label{
            display:block;

            margin-bottom:6px;

            font-size:11px;
            font-weight:700;

            color:#475569;
        }

        input,
        select{

            width:100%;

            padding:10px 12px;

            border-radius:12px;

            border:1.5px solid #e2e8f0;

            background:rgba(255,255,255,0.8);

            font-size:13px;

            font-family:inherit;

            color:#0f172a;

            transition:all 0.3s cubic-bezier(0.4,0,0.2,1);

            outline:none;
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

        /* ================= BUTTON ================= */

        button{

            width:100%;

            padding:11px;

            margin-top:10px;

            border:none;

            border-radius:14px;

            background:linear-gradient(
                    135deg,
                    #7c3aed 0%,
                    #9333ea 100%
            );

            color:white;

            font-size:14px;
            font-weight:800;

            letter-spacing:0.5px;

            cursor:pointer;

            position:relative;
            overflow:hidden;

            transition:all 0.35s cubic-bezier(0.16,1,0.3,1);

            box-shadow:
                    0 10px 20px rgba(124,58,237,0.25);
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

        button:hover{

            transform:translateY(-3px);

            box-shadow:
                    0 15px 30px rgba(124,58,237,0.35);
        }

        button:hover::after{
            left:150%;
        }

        button:active{
            transform:translateY(0);
        }

        /* ================= BACK BUTTON ================= */

        .back-btn{

            display:inline-flex;
            align-items:center;
            gap:8px;

            margin-top:20px;

            text-decoration:none;

            color:#7c3aed;

            font-weight:700;

            font-size:13px;

            transition:0.3s ease;
        }

        .back-btn:hover{
            transform:translateX(-4px);
        }

    </style>

    <script>

        function toggleFields() {

            let type =
                document.getElementById("driverType").value;

            document.getElementById("salaryField").style.display =
                type === "FullTime" ? "block" : "none";

            document.getElementById("commissionField").style.display =
                type === "Freelance" ? "block" : "none";
        }

    </script>

</head>

<body onload="toggleFields()">

<div class="bg-container">

    <div class="bg-orb orb-1"></div>

    <div class="bg-orb orb-2"></div>

</div>

<div class="container">

    <div class="card">

        <div class="header">

            <span class="badge">
                Driver Portal
            </span>

            <h2>Add Driver</h2>

            <p class="subtitle">
                Register professional drivers for the RentalDrive network.
            </p>

        </div>

        <form action="/driver/add" method="post">

            <div class="input-group">

                <label>Driver ID</label>

                <input type="text"
                       name="driverId"
                       placeholder="Driver ID"
                       required>

            </div>

            <div class="input-group">

                <label>Driver Name</label>

                <input type="text"
                       name="name"
                       placeholder="Driver Name"
                       required>

            </div>

            <div class="input-group">

                <label>NIC Number</label>

                <input type="text"
                       name="nic"
                       placeholder="NIC Number"
                       required>

            </div>

            <div class="input-group">

                <label>License Number</label>

                <input type="text"
                       name="licenseNumber"
                       placeholder="License Number"
                       required>

            </div>

            <div class="input-group">

                <label>Phone Number</label>

                <input type="text"
                       name="phone"
                       placeholder="Phone Number"
                       required>

            </div>

            <div class="input-group">

                <label>Address</label>

                <input type="text"
                       name="address"
                       placeholder="Address"
                       required>

            </div>

            <div class="input-group">

                <label>Availability</label>

                <select name="available">

                    <option value="true">
                        Available
                    </option>

                    <option value="false">
                        Not Available
                    </option>

                </select>

            </div>

            <div class="input-group">

                <label>Driver Type</label>

                <select name="driverType"
                        id="driverType"
                        onchange="toggleFields()">

                    <option value="FullTime">
                        FullTime
                    </option>

                    <option value="Freelance">
                        Freelance
                    </option>

                </select>

            </div>

            <div id="salaryField" class="input-group">

                <label>Monthly Salary</label>

                <input type="number"
                       name="monthlySalary"
                       placeholder="Monthly Salary">

            </div>

            <div id="commissionField"
                 class="input-group"
                 style="display:none;">

                <label>Commission Per Trip</label>

                <input type="number"
                       name="commissionPerTrip"
                       placeholder="Commission Per Trip">

            </div>

            <button type="submit">
                Complete Driver Registration
            </button>

        </form>

    </div>

    <a href="index.jsp" class="back-btn">
        ← Back to Dashboard
    </a>

</div>

</body>
</html>