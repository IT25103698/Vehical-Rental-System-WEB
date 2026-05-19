package com.rental.vehiclerentalsystem_v2.driver;

public class DriverFileHandler {
    private static final String FILE_NAME = "drivers.txt";
    private static final int MAX_DRIVERS = 100;

    public DriverFileHandler() {
        createFileIfNotExists();
    }
// Automatically creates a text file
    private void createFileIfNotExists() {
        try {
            java.io.File file = new java.io.File(FILE_NAME);
            if (!file.exists()) {
                file.createNewFile();
            }
        } catch (Exception e) {
            System.out.println("Error creating file.");
        }
    }

    public void addDriver(Driver driver) {
        try {
            java.io.FileWriter writer = new java.io.FileWriter(FILE_NAME, true);
            writer.write(driver.toFileString() + "\n");
            writer.close();
        } catch (Exception e) {
            System.out.println("Error saving driver.");
        }
    }

    public Driver[] getAllDrivers() {
        Driver[] drivers = new Driver[MAX_DRIVERS];
        int index = 0;

        try {
            java.io.BufferedReader reader = new java.io.BufferedReader(
                    new java.io.FileReader(FILE_NAME)
            );

            String line;

            while ((line = reader.readLine()) != null && index < MAX_DRIVERS) {
                if (line.trim().equals("")) {
                    continue;
                }

                String[] data = line.split(",");

                if (data.length < 11) {
                    continue;
                }

                String driverId = data[0];
                String name = data[1];
                String nic = data[2];
                String licenseNumber = data[3];
                String phone = data[4];
                String address = data[5];
                boolean available = Boolean.parseBoolean(data[6]);
                String assignedVehicleId = data[7];
                String type = data[8];

// creating an array according to the object type
                if (type.equalsIgnoreCase("FullTime")) {
                    double monthlySalary = Double.parseDouble(data[9]);

                    drivers[index] = new FullTimeDriver(
                            driverId, name, nic, licenseNumber,
                            phone, address, available, assignedVehicleId, monthlySalary
                    );
                } else if (type.equalsIgnoreCase("Freelance")) {
                    int tripsCompleted = Integer.parseInt(data[9]);
                    double commissionPerTrip = Double.parseDouble(data[10]);

                    drivers[index] = new FreelanceDriver(
                            driverId, name, nic, licenseNumber,
                            phone, address, available, assignedVehicleId,
                            tripsCompleted, commissionPerTrip
                    );
                }

                index++;
            }

            reader.close();
        } catch (Exception e) {
            System.out.println("Error reading drivers.");
        }

        return drivers;
    }
// Driver count
    public int getDriverCount() {
        int count = 0;

        try {
            java.io.BufferedReader reader = new java.io.BufferedReader(
                    new java.io.FileReader(FILE_NAME)
            );

            String line;

            while ((line = reader.readLine()) != null) {
                if (!line.trim().equals("")) {
                    count++;
                }
            }

            reader.close();
        } catch (Exception e) {
            System.out.println("Error counting drivers.");
        }

        return count;
    }
// Searching a driver using License Number
    public Driver searchByLicense(String licenseNumber) {
        Driver[] drivers = getAllDrivers();
        int count = getDriverCount();

        for (int i = 0; i < count; i++) {
            if (drivers[i] != null &&
                    drivers[i].getLicenseNumber().equalsIgnoreCase(licenseNumber)) {
                return drivers[i];
            }
        }

        return null;
    }

    public boolean updateDriver(Driver updatedDriver) {
        Driver[] drivers = getAllDrivers();
        int count = getDriverCount();
        boolean found = false;

        for (int i = 0; i < count; i++) {
            if (drivers[i] != null &&
                    drivers[i].getLicenseNumber().equalsIgnoreCase(updatedDriver.getLicenseNumber())) {
                drivers[i] = updatedDriver;
                found = true;
                break;
            }
        }

        if (found) {
            writeAllDrivers(drivers, count);
        }

        return found;
    }
// find the driver, left shift , reduce the count , rewrite
    public boolean deleteDriver(String licenseNumber) {
        Driver[] drivers = getAllDrivers();
        // calling getDriverCount
        int count = getDriverCount();
        boolean found = false;

        for (int i = 0; i < count; i++) {
            if (drivers[i] != null &&
                    drivers[i].getLicenseNumber().equalsIgnoreCase(licenseNumber)) {

                for (int j = i; j < count - 1; j++) {
                    drivers[j] = drivers[j + 1];
                }

                drivers[count - 1] = null;
                count--;
                found = true;
                break;
            }
        }

        if (found) {
            writeAllDrivers(drivers, count);
        }

        return found;
    }
//  Rewrite the file after deleting and updating
    public void writeAllDrivers(Driver[] drivers, int count) {
        try {
            java.io.FileWriter writer = new java.io.FileWriter(FILE_NAME);

            for (int i = 0; i < count; i++) {
                if (drivers[i] != null) {
                    writer.write(drivers[i].toFileString() + "\n");
                }
            }

            writer.close();
        } catch (Exception e) {
            System.out.println("Error writing drivers.");
        }
    }
}

