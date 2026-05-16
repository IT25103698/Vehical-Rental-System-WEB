<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- UPDATED IMPORTS FOR THE NEW SPRING BOOT PROJECT STRUCTURE --%>
<%@ page import="com.rental.vehiclerentalsystem_v2.customer.Customer" %>
<%@ page import="com.rental.vehiclerentalsystem_v2.customer.LocalCustomer" %>
<%@ page import="com.rental.vehiclerentalsystem_v2.customer.ForeignTourist" %>
<%@ page import="com.rental.vehiclerentalsystem_v2.customer.CustomerFileManager" %>

<%
    // 1. Grab all the typed data from the text boxes
    String id = request.getParameter("customerId");
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String idNumber = request.getParameter("idNumber");
    String type = request.getParameter("customerType");

    // 2. Figure out if we need to build a Local or Foreign customer blueprint
    Customer updatedCustomer;
    if ("Local".equals(type)) {
        // Remember: LocalCustomer takes the NIC as the 5th parameter
        updatedCustomer = new LocalCustomer(id, name, email, phone, idNumber);
    } else {
        // ForeignTourist takes the Passport as the 5th parameter
        updatedCustomer = new ForeignTourist(id, name, email, phone, idNumber);
    }

    // 3. Wake up the File Manager and give it the updated blueprint
    CustomerFileManager fm = new CustomerFileManager();
    fm.updateCustomer(updatedCustomer);

    // 4. Instantly redirect the user back to the updated table
    response.sendRedirect("viewCustomers.jsp");
%>