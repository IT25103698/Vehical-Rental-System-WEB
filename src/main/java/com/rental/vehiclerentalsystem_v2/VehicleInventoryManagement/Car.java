package com.rental.vehiclerentalsystem_v2.VehicleInventoryManagement;

public class Car extends Vehicle {
    private String fuelType; // e.g., Petrol, Diesel, Electric

    public Car(String vehicleId, String brand, String model, String licensePlate, double dailyRate, String fuelType) {
        super(vehicleId, brand, model, licensePlate, dailyRate); // Send common data to Parent
        this.fuelType = fuelType;
    }

    public String getFuelType() { return fuelType; }

    @Override
    public String toFileString() {
        return super.toFileString() + ",Car," + fuelType;
    }
}

