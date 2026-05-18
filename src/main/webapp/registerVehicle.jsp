<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register Vehicle | Admin</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f0f2f5; padding: 40px; }
        .form-container { background: white; padding: 30px; border-radius: 12px; box-shadow: 0 8px 24px rgba(0,0,0,0.1); max-width: 600px; margin: auto; }
        h2 { text-align: center; color: #1a73e8; margin-bottom: 25px; }
        .form-group { margin-bottom: 15px; }
        label { font-weight: 600; display: block; margin-bottom: 5px; color: #444; }
        input[type="text"], input[type="number"], select { width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 6px; box-sizing: border-box; font-size: 14px; }

        /* Dynamic Polymorphic Sections styling */
        .dynamic-section { display: none; background: #f8f9fa; padding: 15px; border-radius: 6px; border-left: 4px solid #1a73e8; margin-top: 10px; }
        .checkbox-group { display: flex; align-items: center; gap: 10px; padding: 5px 0; }
        .checkbox-group input { width: auto; scale: 1.2; }

        .submit-btn { width: 100%; padding: 14px; background-color: #1a73e8; color: white; border: none; border-radius: 6px; font-size: 16px; font-weight: bold; cursor: pointer; margin-top: 20px; transition: background 0.3s; }
        .submit-btn:hover { background-color: #1557b0; }
        .back-link { display: block; text-align: center; margin-top: 20px; text-decoration: none; color: #666; }
        .error-msg { background: #fee2e2; color: #991b1b; padding: 12px; border-radius: 6px; margin-bottom: 15px; text-align: center; font-weight: 600; }
    </style>

    <script>
        function updateFormFields() {
            var type = document.getElementById("vehicleType").value;
            // Hide all dynamic subclass sections first
            document.getElementById("carSection").style.display = "none";
            document.getElementById("vanSection").style.display = "none";
            document.getElementById("suvSection").style.display = "none";

            // Show the polymorphic subsection that matches selection
            if (type === "Car") document.getElementById("carSection").style.display = "block";
            else if (type === "Van") document.getElementById("vanSection").style.display = "block";
            else if (type === "SUV") document.getElementById("suvSection").style.display = "block";
        }
    </script>
</head>
<body>

<div class="form-container">
    <h2>🚗 Add New Vehicle</h2>

    <%-- Error message display check if redirected from a failed instantiation --%>
    <% if ("1".equals(request.getParameter("error"))) { %>
        <div class="error-msg">⚠️ Failed to register vehicle. Please check your data fields and try again.</div>
    <% } %>

    <%-- Submits form attributes to your absolute WebServlet deployment target --%>
    <form action="VehicleServlet" method="post">
        <div class="form-group">
            <label>Vehicle ID:</label>
            <input type="text" name="vehicleId" placeholder="e.g. V001" required>
        </div>

        <div class="form-group">
            <label>Brand:</label>
            <input type="text" name="brand" placeholder="e.g. Toyota" required>
        </div>

        <div class="form-group">
            <label>Model:</label>
            <input type="text" name="model" placeholder="e.g. Corolla" required>
        </div>

        <div class="form-group">
            <label>License Plate:</label>
            <input type="text" name="plate" placeholder="e.g. WP-ABC-1234" required>
        </div>

        <div class="form-group">
            <label>Daily Rental Rate (LKR):</label>
            <input type="number" name="rate" step="0.01" placeholder="0.00" required>
        </div>

        <div class="form-group">
            <label>Vehicle Category:</label>
            <select name="vehicleType" id="vehicleType" onchange="updateFormFields()" required>
                <option value="">-- Select Type --</option>
                <option value="Car">Car</option>
                <option value="Van">Van</option>
                <option value="SUV">SUV</option>
            </select>
        </div>

        <%-- Polymorphic Subclass Attributes section fields --%>
        <div id="carSection" class="dynamic-section">
            <label>Fuel Type:</label>
            <select name="fuelType">
                <option value="Petrol">Petrol</option>
                <option value="Diesel">Diesel</option>
                <option value="Electric">Electric</option>
            </select>
        </div>

        <div id="vanSection" class="dynamic-section">
            <label>Load Capacity (kg):</label>
            <input type="number" name="loadCapacity" placeholder="e.g. 1000">
        </div>

        <div id="suvSection" class="dynamic-section">
            <label>Features Configuration:</label>
            <div class="checkbox-group">
                <input type="checkbox" id="isAWD" name="isAWD" value="true">
                <label for="isAWD" style="display:inline; font-weight:normal; color:#1f2937;">All-Wheel Drive (AWD)</label>
            </div>
        </div>

        <button type="submit" class="submit-btn">Register Vehicle</button>
    </form>

    <a href="manageVehicles.jsp" class="back-link">← Cancel and Go Back</a>
</div>

</body>
</html>