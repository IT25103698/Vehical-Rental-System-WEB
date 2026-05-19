package com.rental.vehiclerentalsystem_v2.payment;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Grab data from the form
            String paymentId = request.getParameter("paymentId");
            String bookingId = request.getParameter("bookingId");
            double amount = Double.parseDouble(request.getParameter("amount"));
            String method = request.getParameter("paymentMethod");
            String status = request.getParameter("status");

            // Create the object and save it
            Payment newPayment = new Payment(paymentId, bookingId, amount, method, status);
            PaymentFileManager pfm = new PaymentFileManager();
            pfm.savePayment(newPayment);

            // Send them to the table to see the success!
            response.sendRedirect("viewPayments.jsp");

        } catch (Exception e) {
            // Safety catch: If parsing the double fails or data is missing, redirect safely
            System.out.println("Payment Save Error: " + e.getMessage());
            // Assuming your form is called addPayment.jsp or similar
            response.sendRedirect("viewPayments.jsp?error=1");
        }
    }
}