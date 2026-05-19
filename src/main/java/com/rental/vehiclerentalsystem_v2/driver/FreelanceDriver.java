package com.rental.vehiclerentalsystem_v2.driver;

public class FreelanceDriver extends Driver {
    private int tripsCompleted;
    private double commissionPerTrip;

    public FreelanceDriver(String driverId, String name, String nic, String licenseNumber,
                           String phone, String address, boolean available,
                           String assignedVehicleId, int tripsCompleted, double commissionPerTrip) {
        super(driverId, name, nic, licenseNumber, phone, address, available, assignedVehicleId);
        this.tripsCompleted = tripsCompleted;
        this.commissionPerTrip = commissionPerTrip;
    }

    public int getTripsCompleted() {
        return tripsCompleted;
    }

    public void setTripsCompleted(int tripsCompleted) {
        this.tripsCompleted = tripsCompleted;
    }

    public double getCommissionPerTrip() {
        return commissionPerTrip;
    }

    public void setCommissionPerTrip(double commissionPerTrip) {
        this.commissionPerTrip = commissionPerTrip;
    }
// override from abstract method
    public double calculatePayment() {
        return tripsCompleted * commissionPerTrip;
    }

    public String getDriverType() {
        return "Freelance";
    }

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
                tripsCompleted + "," +
                commissionPerTrip;
    }

    public String toString() {
        return super.toString() +
                "\nTrips Completed: " + tripsCompleted +
                "\nCommission Per Trip: " + commissionPerTrip +
                "\nPayment: " + calculatePayment();
    }
}
