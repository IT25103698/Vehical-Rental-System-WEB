package com.rental.vehiclerentalsystem_v2.payment;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/DeletePaymentServlet")
public class DeletePaymentServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Extract the payment ID parameter directly from the incoming URL query string
            String paymentId = request.getParameter("id");

            if (paymentId != null && !paymentId.trim().isEmpty()) {
                PaymentFileManager pfm = new PaymentFileManager();
                pfm.deletePayment(paymentId);
            }

            // Return back to refresh the records table automatically
            response.sendRedirect("viewPayments.jsp");

        } catch (Exception e) {
            System.out.println("Error processing transaction deletion: " + e.getMessage());
            response.sendRedirect("viewPayments.jsp?error=1");
        }
    }
}