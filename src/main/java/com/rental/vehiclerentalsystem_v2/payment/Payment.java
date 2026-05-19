package com.rental.vehiclerentalsystem_v2.payment;

public class Payment {
    private String paymentId;
    private String bookingId;
    private double amount;
    private String paymentMethod;
    private String status;

    public Payment(String paymentId, String bookingId, double amount, String paymentMethod, String status) {
        this.paymentId = paymentId;
        this.bookingId = bookingId;
        this.amount = amount;
        this.paymentMethod = paymentMethod;
        this.status = status;
    }

    public String getPaymentId() { return paymentId; }
    public String getBookingId() { return bookingId; }
    public double getAmount() { return amount; }
    public String getPaymentMethod() { return paymentMethod; }
    public String getStatus() { return status; }

    public String toFileString() {
        return paymentId + "," + bookingId + "," + amount + "," + paymentMethod + "," + status;
    }
}