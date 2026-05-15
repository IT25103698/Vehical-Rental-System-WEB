package com.rental.vehiclerentalsystem_v2.customer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/CustomerServlet")
public class CustomerServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // 1. GRAB THE DATA FROM THE WEB FORM
        String customerId = request.getParameter("customerId");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String customerType = request.getParameter("customerType");
        String idNumber = request.getParameter("idNumber");

        // 2. CREATE THE CORRECT OBJECT (Polymorphism!)
        Customer newCustomer;
        if (customerType.equals("Local")) {
            newCustomer = new LocalCustomer(customerId, name, email, phone, idNumber);
        } else {
            newCustomer = new ForeignTourist(customerId, name, email, phone, idNumber);
        }

        // 3. SAVE TO THE TEXT FILE
        CustomerFileManager fileManager = new CustomerFileManager();
        fileManager.saveCustomer(newCustomer);

        // 4. REFRESH THE PAGE
        System.out.println("Customer saved successfully: " + name);
        response.sendRedirect("registerCustomer.jsp");
    }
}