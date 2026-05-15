package com.rental.vehiclerentalsystem_v2.VehicleInventoryManagement;

public class Van extends Vehicle {
    private double loadCapacity; // in kilograms (kg)

    public Van(String vehicleId, String brand, String model, String licensePlate, double dailyRate, double loadCapacity) {
        super(vehicleId, brand, model, licensePlate, dailyRate);
        this.loadCapacity = loadCapacity;
    }

    public double getLoadCapacity() { return loadCapacity; }

    @Override
    public String toFileString() {
        // We add "Van" as the type identifier for our text file
        return super.toFileString() + ",Van," + loadCapacity;
    }
}
