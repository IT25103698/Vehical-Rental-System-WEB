package com.rental.vehiclerentalsystem_v2.VehicleInventoryManagement;

import java.io.*;
import java.util.ArrayList; // You can use your custom VehicleList here if you built one!
import java.util.List;

public class VehicleFileManager {
    private static final String FILE_PATH = "vehicles.txt";

    // --- SAVE A VEHICLE ---
    public void saveVehicle(Vehicle vehicle) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            writer.write(vehicle.toFileString());
            writer.newLine();
        } catch (IOException e) {
            System.out.println("Error saving vehicle: " + e.getMessage());
        }
    }

    // --- LOAD ALL VEHICLES (The Polymorphic Part) ---
    public List<Vehicle> getAllVehicles() {
        List<Vehicle> vehicleList = new ArrayList<>();
        File file = new File(FILE_PATH);

        if (!file.exists()) return vehicleList;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");

                // Index 0: ID, 1: Brand, 2: Model, 3: Plate, 4: Rate
                // Index 5: TYPE (Car/Van/SUV)
                // Index 6: Unique Attribute (Fuel/Capacity/AWD)

                String id = data[0];
                String brand = data[1];
                String model = data[2];
                String plate = data[3];
                double rate = Double.parseDouble(data[4]);
                String type = data[5];

                // POLYMORPHISM IN ACTION:
                // We use the 'type' string to choose which specific constructor to call
                if (type.equals("Car")) {
                    vehicleList.add(new Car(id, brand, model, plate, rate, data[6]));
                }
                else if (type.equals("Van")) {
                    vehicleList.add(new Van(id, brand, model, plate, rate, Double.parseDouble(data[6])));
                }
                else if (type.equals("SUV")) {
                    vehicleList.add(new SUV(id, brand, model, plate, rate, Boolean.parseBoolean(data[6])));
                }
            }
        } catch (IOException e) {
            System.out.println("Error loading vehicles: " + e.getMessage());
        }
        return vehicleList;
    }
}