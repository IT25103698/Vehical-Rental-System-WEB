package com.rental.vehiclerentalsystem_v2.customer;

public class LocalCustomer extends Customer {
    private String nationalIdNumber;

    public LocalCustomer(String customerId, String name, String email, String phone, String nationalIdNumber) {
        super(customerId, name, email, phone); // Calls the parent constructor
        this.nationalIdNumber = nationalIdNumber;
    }

    public String getNationalIdNumber() {
        return nationalIdNumber;
    }
    public void setNationalIdNumber(String nationalIdNumber) {
        this.nationalIdNumber = nationalIdNumber;
    }

    // POLYMORPHISM: Locals pay
    @Override
    public double calculateRequiredDeposit() {
        return 5000.00; // 5000 LKR deposit
    }

    @Override
    public String toFileString() {
        return super.toFileString() + ",Local," + nationalIdNumber;
    }
}
