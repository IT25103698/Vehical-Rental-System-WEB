package com.rental.vehiclerentalsystem_v2.payment;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/UpdatePaymentServlet")
public class UpdatePaymentServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Grab payment transaction data directly from the URL link query parameters
            String paymentId = request.getParameter("id");
            String newStatus = request.getParameter("status"); // Expected to pass dynamic states like "Paid" or "Refunded"

            if (paymentId != null && newStatus != null) {
                PaymentFileManager pfm = new PaymentFileManager();
                pfm.updatePaymentStatus(paymentId, newStatus);
            }

            // Redirect back to refresh the dashboard table view securely
            response.sendRedirect("viewPayments.jsp");

        } catch (Exception e) {
            System.out.println("Error processing status update: " + e.getMessage());
            response.sendRedirect("viewPayments.jsp?error=1");
        }
    }
}