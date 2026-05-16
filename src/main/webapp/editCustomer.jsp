<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- UPDATED IMPORTS FOR THE NEW SPRING BOOT PROJECT CONVENTION --%>
<%@ page import="com.rental.vehiclerentalsystem_v2.customer.Customer" %>
<%@ page import="com.rental.vehiclerentalsystem_v2.customer.LocalCustomer" %>
<%@ page import="com.rental.vehiclerentalsystem_v2.customer.ForeignTourist" %>
<%@ page import="com.rental.vehiclerentalsystem_v2.customer.CustomerFileManager" %>

<%
    // 1. Get the ID from the URL query string
    String id = request.getParameter("id");

    // 2. Ask the File Manager to find this specific customer
    CustomerFileManager fm = new CustomerFileManager();
    Customer customerToEdit = fm.getCustomerById(id);

    // If someone messes with the URL and types a fake ID, protect the site and send them back
    if (customerToEdit == null) {
        // Updated to match your main data grid dashboard page
        response.sendRedirect("viewCustomers.jsp");
        return;
    }

    // Figure out if they are Local or Foreign to render the conditional form fields properly
    boolean isLocal = (customerToEdit instanceof LocalCustomer);
%>
<html>
<head>
    <title>Edit Customer</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f9; padding: 40px; }
        .form-container { background: white; padding: 30px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); max-width: 500px; margin: auto; }
        h2 { text-align: center; color: #333; }
        label { font-weight: bold; display: block; margin-top: 15px; }
        input[type="text"], input[type="email"], select { width: 100%; padding: 10px; margin-top: 5px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        .submit-btn { width: 100%; padding: 12px; background-color: #28a745; color: white; border: none; border-radius: 4px; font-size: 16px; margin-top: 20px; cursor: pointer; }
        .submit-btn:hover { background-color: #218838; }
        .back-btn { display: inline-block; margin-bottom: 20px; padding: 10px 15px; background-color: #6c757d; color: white; text-decoration: none; border-radius: 4px; }
    </style>
</head>
<body>

    <div class="form-container">
        <a href="viewCustomers.jsp" class="back-btn">&larr; Cancel Edit</a>

        <h2>Edit Customer: <%= customerToEdit.getCustomerId() %></h2>

        <form action="updateCustomerProcess.jsp" method="post">

            <input type="hidden" name="customerId" value="<%= customerToEdit.getCustomerId() %>">
            <input type="hidden" name="customerType" value="<%= isLocal ? "Local" : "Foreign" %>">

            <label>Full Name:</label>
            <input type="text" name="name" value="<%= customerToEdit.getName() %>" required>

            <label>Email Address:</label>
            <input type="email" name="email" value="<%= customerToEdit.getEmail() %>" required>

            <label>Phone Number:</label>
            <input type="text" name="phone" value="<%= customerToEdit.getPhone() %>" required>

            <% if (isLocal) {
                // Cast utilizing the newly imported package structure configuration
                LocalCustomer lc = (LocalCustomer) customerToEdit;
            %>
                <label>NIC Number:</label>
                <input type="text" name="idNumber" value="<%= lc.getNationalIdNumber() %>" required>
            <% } else {
                // Cast utilizing the newly imported package structure configuration
                ForeignTourist ft = (ForeignTourist) customerToEdit;
            %>
                <label>Passport Number:</label>
                <input type="text" name="idNumber" value="<%= ft.getPassportNumber() %>" required>
            <% } %>

            <button type="submit" class="submit-btn">Save Changes</button>
        </form>
    </div>

</body>
</html>