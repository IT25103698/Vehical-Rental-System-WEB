package com.rental.vehiclerentalsystem_v2.payment;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class PaymentFileManager {
    private static final String FILE_PATH = "payments.txt";

    public void savePayment(Payment payment) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            writer.write(payment.toFileString());
            writer.newLine();
        } catch (IOException e) {
            System.out.println("Error saving payment: " + e.getMessage());
        }
    }

    public List<Payment> getAllPayments() {
        List<Payment> paymentList = new ArrayList<>();
        File file = new File(FILE_PATH);

        if (!file.exists()) return paymentList;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");
                if (data.length == 5) {
                    Payment p = new Payment(data[0], data[1], Double.parseDouble(data[2]), data[3], data[4]);
                    paymentList.add(p);
                }
            }
        } catch (IOException e) {
            System.out.println("Error loading payments: " + e.getMessage());
        }
        return paymentList;
    }

    // --- UPDATE: CHANGE PAYMENT STATUS ---
    public void updatePaymentStatus(String paymentId, String newStatus) {
        List<Payment> allPayments = getAllPayments();

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, false))) {
            for (Payment p : allPayments) {
                // If this is the payment we want to update, write the new status
                if (p.getPaymentId().equals(paymentId)) {
                    // We manually reconstruct the string with the new status
                    writer.write(p.getPaymentId() + "," + p.getBookingId() + "," +
                            p.getAmount() + "," + p.getPaymentMethod() + "," + newStatus);
                } else {
                    // Otherwise, write the old payment normally
                    writer.write(p.toFileString());
                }
                writer.newLine();
            }
            System.out.println("Payment " + paymentId + " updated successfully.");
        } catch (IOException e) {
            System.out.println("Error updating payment: " + e.getMessage());
        }
    }

    // --- DELETE: REFUND / VOID A PAYMENT ---
    public void deletePayment(String paymentId) {
        List<Payment> allPayments = getAllPayments();

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, false))) {
            for (Payment p : allPayments) {
                // Write everyone back to the file EXCEPT the one we want to delete
                if (!p.getPaymentId().equals(paymentId)) {
                    writer.write(p.toFileString());
                    writer.newLine();
                }
            }
            System.out.println("Payment " + paymentId + " deleted (refunded) successfully.");
        } catch (IOException e) {
            System.out.println("Error deleting payment: " + e.getMessage());
        }
    }
}