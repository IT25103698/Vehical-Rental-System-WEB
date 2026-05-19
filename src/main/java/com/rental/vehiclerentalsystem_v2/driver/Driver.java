package com.rental.vehiclerentalsystem_v2.driver;

public abstract class Driver {
    private String driverId;
    private String name;
    private String nic;
    private String licenseNumber;
    private String phone;
    private String address;
    private boolean available;
    private String assignedVehicleId;

    public Driver(String driverId, String name, String nic, String licenseNumber,
                  String phone, String address, boolean available, String assignedVehicleId) {
        this.driverId = driverId;
        this.name = name;
        this.nic = nic;
        this.licenseNumber = licenseNumber;
        this.phone = phone;
        this.address = address;
        this.available = available;
        this.assignedVehicleId = assignedVehicleId;
    }
//abstract methods

    public abstract double calculatePayment();
    public abstract String getDriverType();
    public abstract String toFileString();

    public String getDriverId() {
        return driverId;
    }

    public void setDriverId(String driverId) {
        this.driverId = driverId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getNic() {
        return nic;
    }

    public void setNic(String nic) {
        this.nic = nic;
    }

    public String getLicenseNumber() {
        return licenseNumber;
    }

    public void setLicenseNumber(String licenseNumber) {
        this.licenseNumber = licenseNumber;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public boolean isAvailable() {
        return available;
    }

    public void setAvailable(boolean available) {
        this.available = available;
    }

    public String getAssignedVehicleId() {
        return assignedVehicleId;
    }

    public void setAssignedVehicleId(String assignedVehicleId) {
        this.assignedVehicleId = assignedVehicleId;
    }

    public String toString() {
        return "Driver ID: " + driverId +
                "\nName: " + name +
                "\nNIC: " + nic +
                "\nLicense Number: " + licenseNumber +
                "\nPhone: " + phone +
                "\nAddress: " + address +
                "\nAvailable: " + available +
                "\nAssigned Vehicle ID: " + assignedVehicleId +
                "\nDriver Type: " + getDriverType();
    }
}