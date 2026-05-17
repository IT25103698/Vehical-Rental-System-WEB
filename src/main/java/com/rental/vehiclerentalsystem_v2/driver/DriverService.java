package com.rental.vehiclerentalsystem_v2.driver;

public class DriverService {
    private DriverFileHandler fileHandler;
    private static final int MAX_DRIVERS = 100;

    public DriverService() {
        fileHandler = new DriverFileHandler();
    }

    public boolean addDriver(Driver driver) {

        if (!validateDriver(driver)) {
            return false;
        }


        // Check duplicate License Number
        if (isLicenseExists(driver.getLicenseNumber())) {
            System.out.println("License number already exists.");
            return false;
        }

        if (fileHandler.getDriverCount() >= MAX_DRIVERS) {
            System.out.println("Driver list is full.");
            return false;
        }

        fileHandler.addDriver(driver);
        return true;
    }

    public boolean validateDriver(Driver driver) {
        if (driver.getDriverId() == null || driver.getDriverId().trim().equals("")) {
            System.out.println("Driver ID cannot be empty.");
            return false;
        }

        if (driver.getName() == null || driver.getName().trim().equals("")) {
            System.out.println("Name cannot be empty.");
            return false;
        }

        if (driver.getNic() == null || driver.getNic().trim().equals("")) {
            System.out.println("NIC cannot be empty.");
            return false;
        }

        if (driver.getLicenseNumber() == null || driver.getLicenseNumber().trim().equals("")) {
            System.out.println("License cannot be empty.");
            return false;
        }

        if (driver.getPhone() == null || driver.getPhone().trim().equals("")) {
            System.out.println("Phone cannot be empty.");
            return false;
        }

// Check if phone contains only digits
        if (!driver.getPhone().matches("\\d+")) {
            System.out.println("Phone number must contain only integers.");
            return false;
        }

// Check if phone number has exactly 10 digits
        if (driver.getPhone().length() != 10) {
            System.out.println("Phone number must be exactly 10 digits.");
            return false;
        }

        if (driver.getAddress() == null || driver.getAddress().trim().equals("")) {
            System.out.println("Address cannot be empty.");
            return false;
        }

        if (driver instanceof FullTimeDriver) {
            FullTimeDriver d = (FullTimeDriver) driver;
            if (d.getMonthlySalary() < 0) {
                System.out.println("Salary cannot be negative.");
                return false;
            }
        }

        if (driver instanceof FreelanceDriver) {
            FreelanceDriver d = (FreelanceDriver) driver;
            if (d.getTripsCompleted() < 0) {
                System.out.println("Trips cannot be negative.");
                return false;
            }
            if (d.getCommissionPerTrip() < 0) {
                System.out.println("Commission cannot be negative.");
                return false;
            }
        }

        return true;
    }

    public boolean isLicenseExists(String licenseNumber) {
        Driver driver = fileHandler.searchByLicense(licenseNumber);
        return driver != null;
    }

    public Driver searchDriverByLicense(String licenseNumber) {
        return fileHandler.searchByLicense(licenseNumber);
    }

    public Driver[] getAllDrivers() {
        return fileHandler.getAllDrivers();
    }

    public int getAllDriverCount() {
        return fileHandler.getDriverCount();
    }

    public Driver[] getAvailableDrivers() {
        Driver[] allDrivers = fileHandler.getAllDrivers();
        int totalCount = fileHandler.getDriverCount();

        Driver[] availableDrivers = new Driver[MAX_DRIVERS];
        int index = 0;

        for (int i = 0; i < totalCount; i++) {
            if (allDrivers[i] != null && allDrivers[i].isAvailable()) {
                availableDrivers[index] = allDrivers[i];
                index++;
            }
        }

        return availableDrivers;
    }

    public int getAvailableDriverCount() {
        Driver[] allDrivers = fileHandler.getAllDrivers();
        int totalCount = fileHandler.getDriverCount();
        int count = 0;

        for (int i = 0; i < totalCount; i++) {
            if (allDrivers[i] != null && allDrivers[i].isAvailable()) {
                count++;
            }
        }

        return count;
    }

    public boolean updateDriverAvailability(String licenseNumber, boolean availability) {
        Driver driver = fileHandler.searchByLicense(licenseNumber);

        if (driver == null) {
            return false;
        }

        driver.setAvailable(availability);

        if (availability) {
            driver.setAssignedVehicleId("none");
        }

        return fileHandler.updateDriver(driver);
    }

    public boolean deleteDriver(String licenseNumber) {
        Driver driver = fileHandler.searchByLicense(licenseNumber);

        if (driver == null) {
            return false;
        }

        if (!driver.isAvailable()) {
            System.out.println("Cannot delete assigned driver.");
            return false;
        }

        return fileHandler.deleteDriver(licenseNumber);
    }

    public boolean assignDriverToVehicle(String licenseNumber, String vehicleId) {
        Driver driver = fileHandler.searchByLicense(licenseNumber);

        if (driver == null) {
            System.out.println("Driver not found.");
            return false;
        }

        if (!driver.isAvailable()) {
            System.out.println("Driver is not available.");
            return false;
        }

        driver.setAssignedVehicleId(vehicleId);
        driver.setAvailable(false);

        return fileHandler.updateDriver(driver);
    }

    public boolean releaseDriverFromVehicle(String licenseNumber) {
        Driver driver = fileHandler.searchByLicense(licenseNumber);

        if (driver == null) {
            System.out.println("Driver not found.");
            return false;
        }

        driver.setAssignedVehicleId("none");
        driver.setAvailable(true);

        return fileHandler.updateDriver(driver);
    }

    public boolean updateFreelancePayment(
            String licenseNumber,
            int tripsCompleted,
            double commissionPerTrip
    ) {

        Driver[] drivers = fileHandler.getAllDrivers();

        int driverCount = fileHandler.getDriverCount();

        for (int i = 0; i < driverCount; i++) {

            if (drivers[i] != null &&
                    drivers[i].getLicenseNumber().equals(licenseNumber)) {

                if (drivers[i] instanceof FreelanceDriver) {

                    FreelanceDriver freelanceDriver =
                            (FreelanceDriver) drivers[i];

                    freelanceDriver.setTripsCompleted(tripsCompleted);

                    freelanceDriver.setCommissionPerTrip(commissionPerTrip);

                    return fileHandler.updateDriver(freelanceDriver);
                }
            }
        }

        return false;
    }




}