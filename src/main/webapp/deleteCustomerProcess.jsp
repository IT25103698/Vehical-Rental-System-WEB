<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- UPDATED IMPORT FOR THE NEW SPRING BOOT PROJECT STRUCTURE --%>
<%@ page import="com.rental.vehiclerentalsystem_v2.customer.CustomerFileManager" %>

<%
    // 1. Grab the ID from the URL (e.g., ?id=C001)
    String idToDelete = request.getParameter("id");

    // 2. If the ID exists, wake up the File Manager and delete them
    if (idToDelete != null && !idToDelete.isEmpty()) {
        CustomerFileManager fileManager = new CustomerFileManager();
        fileManager.deleteCustomer(idToDelete);
    }

    // 3. Instantly redirect the user back to the updated table
    // Note: If you renamed your customer grid dashboard page to managecustomer.jsp, make sure this matches!
    response.sendRedirect("viewCustomers.jsp");
%>