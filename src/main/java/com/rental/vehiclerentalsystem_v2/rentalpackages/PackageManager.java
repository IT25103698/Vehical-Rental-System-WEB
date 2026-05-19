package com.rental.vehiclerentalsystem_v2.rentalpackages;

import java.io.*;
import java.util.*;

public class PackageManager {
    private static final String FILE_PATH = "packages.txt";

    public void savePackage(RentalPackage pkg) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            writer.write(pkg.toFileString());
            writer.newLine();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public List<RentalPackage> getAllPackages() {
        List<RentalPackage> list = new ArrayList<>();
        File file = new File(FILE_PATH);
        if (!file.exists()) return list;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 4) {
                    list.add(new RentalPackage(parts[0], parts[1], parts[2], Double.parseDouble(parts[3])));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return list;
    }
}