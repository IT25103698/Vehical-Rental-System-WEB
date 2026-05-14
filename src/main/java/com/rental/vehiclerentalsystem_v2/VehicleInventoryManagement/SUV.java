package com.rental.vehiclerentalsystem_v2.VehicleInventoryManagement;

public class SUV extends Vehicle {
    private boolean isAWD;

    public SUV(String vehicleId, String brand, String model, String licensePlate, double dailyRate, boolean isAWD) {
        super(vehicleId, brand, model, licensePlate, dailyRate);
        this.isAWD = isAWD;
    }

    public boolean isAWD() { return isAWD; }

    @Override
    public String toFileString() {
        return super.toFileString() + ",SUV," + isAWD;
    }
}

