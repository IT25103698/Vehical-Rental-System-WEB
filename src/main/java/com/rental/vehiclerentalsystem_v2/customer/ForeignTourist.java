package com.rental.vehiclerentalsystem_v2.customer;

public class ForeignTourist extends Customer {
    private String passportNumber;


    public ForeignTourist(String customerID, String name, String email, String phone, String passportNumber){
        super(customerID, name, email, phone);
        this.passportNumber = passportNumber;
    }

    public String getPassportNumber() {
        return passportNumber;
    }

    public void setPassportNumber(String passportNumber) {
        this.passportNumber = passportNumber;
    }

    @Override
    public double calculateRequiredDeposit() {
        return 2500.00;
    }
    @Override
    public String toFileString(){
        return super.toFileString() + ",Local," + passportNumber;
    }
}
