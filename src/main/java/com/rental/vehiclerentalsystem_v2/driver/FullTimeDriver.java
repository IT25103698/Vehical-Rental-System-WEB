package com.rental.vehiclerentalsystem_v2.driver;

public class FullTimeDriver extends Driver {
    private double monthlySalary;

    public FullTimeDriver(String driverId, String name, String nic, String licenseNumber,
                          String phone, String address, boolean available,
                          String assignedVehicleId, double monthlySalary) {
        super(driverId, name, nic, licenseNumber, phone, address, available, assignedVehicleId);
        this.monthlySalary = monthlySalary;
    }

    public double getMonthlySalary() {
        return monthlySalary;
    }

    public void setMonthlySalary(double monthlySalary) {
        this.monthlySalary = monthlySalary;
    }
// override from abstract methods
    public double calculatePayment() {
        return monthlySalary;
    }
//Driver type for file handling
    public String getDriverType() {
        return "FullTime";
    }
// converting obj data into csv
    public String toFileString() {
        return getDriverId() + "," +
                getName() + "," +
                getNic() + "," +
                getLicenseNumber() + "," +
                getPhone() + "," +
                getAddress() + "," +
                isAvailable() + "," +
                getAssignedVehicleId() + "," +
                getDriverType() + "," +
                monthlySalary + "," +
                0;
    }

    public String toString() {
        return super.toString() +
                "\nMonthly Salary: " + monthlySalary +
                "\nPayment: " + calculatePayment();
    }
}
