package com.rental.vehiclerentalsystem_v2.rentalpackages;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class RentalPackageFileManager {
    private static final String FILE_PATH = "packages.txt";

    // CREATE
    public void savePackage(RentalPackage pkg) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            writer.write(pkg.toFileString());
            writer.newLine();
        } catch (IOException e) {
            System.out.println("Error saving package: " + e.getMessage());
        }
    }

    // READ
    public List<RentalPackage> getAllPackages() {
        List<RentalPackage> packageList = new ArrayList<>();
        File file = new File(FILE_PATH);
        if (!file.exists()) return packageList;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");
                if (data.length == 4) {
                    RentalPackage pkg = new RentalPackage(data[0], data[1], data[2], Double.parseDouble(data[3]));
                    packageList.add(pkg);
                }
            }
        } catch (IOException e) {
            System.out.println("Error loading packages: " + e.getMessage());
        }
        return packageList;
    }

    // UPDATE
    public void updatePackage(RentalPackage updatedPkg) {
        List<RentalPackage> allPackages = getAllPackages();
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, false))) {
            for (RentalPackage p : allPackages) {
                // If we find the one we want to update, write the NEW data
                if (p.getPackageId().trim().equalsIgnoreCase(updatedPkg.getPackageId().trim())) {
                    writer.write(updatedPkg.toFileString());
                } else {
                    // Otherwise, write the old data normally
                    writer.write(p.toFileString());
                }
                writer.newLine();
            }
        } catch (IOException e) {
            System.out.println("Error updating package: " + e.getMessage());
        }
    }

    // DELETE
    public void deletePackage(String packageId) {
        List<RentalPackage> allPackages = getAllPackages();
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, false))) {
            for (RentalPackage p : allPackages) {
                if (!p.getPackageId().equals(packageId)) {
                    writer.write(p.toFileString());
                    writer.newLine();
                }
            }
        } catch (IOException e) {
            System.out.println("Error deleting package: " + e.getMessage());
        }
    }
}