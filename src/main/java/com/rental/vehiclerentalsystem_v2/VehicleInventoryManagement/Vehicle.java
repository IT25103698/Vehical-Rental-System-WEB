package com.rental.vehiclerentalsystem_v2.VehicleInventoryManagement;

public abstract class Vehicle {
    private String vehicleId;
    private String brand;
    private String model;
    private String licensePlate;
    private double dailyRate;

    public Vehicle(String vehicleId, String brand, String model, String licensePlate, double dailyRate) {
        this.vehicleId = vehicleId;
        this.brand = brand;
        this.model = model;
        this.licensePlate = licensePlate;
        this.dailyRate = dailyRate;
    }

    // Getters and Setters
    public String getVehicleId() { return vehicleId; }
    public String getBrand() { return brand; }
    public String getModel() { return model; }
    public String getLicensePlate() { return licensePlate; }
    public double getDailyRate() { return dailyRate; }

    // This is the common 'Save' format for our text file
    public String toFileString() {
        return vehicleId + "," + brand + "," + model + "," + licensePlate + "," + dailyRate;
    }
}
