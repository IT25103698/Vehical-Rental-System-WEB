package com.rental.vehiclerentalsystem_v2.rentalpackages;

public class RentalPackage {
    private String packageId;
    private String packageName;
    private String duration; // e.g., "Weekend", "Weekly", "Monthly"
    private double price;

    public RentalPackage(String packageId, String packageName, String duration, double price) {
        this.packageId = packageId;
        this.packageName = packageName;
        this.duration = duration;
        this.price = price;
    }

    public String getPackageId() {
        return packageId;
    }

    public String getPackageName() {
        return packageName;
    }

    public String getDuration() {
        return duration;
    }

    public double getPrice() {
        return price;
    }

    public String toFileString() {
        return packageId + "," + packageName + "," + duration + "," + price;
    }
}