package com.rental.vehiclerentalsystem_v2.customer;
import com.rental.vehiclerentalsystem_v2.utils.CustomerList;
import java.io.*;

public class CustomerFileManager {

    private static final String FILE_PATH = "customers.txt";

    // --- SAVE A CUSTOMER TO THE FILE ---
    public void saveCustomer(Customer customer) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            writer.write(customer.toFileString());
            writer.newLine();
        } catch (IOException e) {
            System.out.println("Error saving customer: " + e.getMessage());
        }
    }

    // --- LOAD ALL CUSTOMERS FROM THE FILE INTO CUSTOM LIST ---
    public CustomerList getAllCustomers() {
        CustomerList customerList = new CustomerList(); // Using your custom class!
        File file = new File(FILE_PATH);

        if (!file.exists()) {
            return customerList;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");

                if (data.length == 6) {
                    if (data[4].equals("Local")) {
                        customerList.add(new LocalCustomer(data[0], data[1], data[2], data[3], data[5]));
                    } else if (data[4].equals("Foreign")) {
                        customerList.add(new ForeignTourist(data[0], data[1], data[2], data[3], data[5]));
                    }
                }
            }
        } catch (IOException e) {
            System.out.println("Error reading file: " + e.getMessage());
        }

        return customerList;
    }
    // --- DELETE A CUSTOMER ---
    public void deleteCustomer(String customerId) {
        // 1. Get everyone currently in the file
        CustomerList allCustomers = getAllCustomers();

        // 2. Open the file in "Overwrite" mode (notice we don't use 'true' for append here)
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, false))) {

            // 3. Loop through the list and save everyone EXCEPT the one we want to delete
            for (int i = 0; i < allCustomers.size(); i++) {
                Customer current = allCustomers.get(i);

                if (!current.getCustomerId().equals(customerId)) {
                    writer.write(current.toFileString());
                    writer.newLine();
                }
            }
            System.out.println("Customer " + customerId + " successfully deleted!");

        } catch (IOException e) {
            System.out.println("Error deleting customer: " + e.getMessage());
        }
    }
    // --- FIND A SPECIFIC CUSTOMER BY ID (For pre-filling the Edit Form) ---
    public Customer getCustomerById(String id) {
        CustomerList allCustomers = getAllCustomers();
        for (int i = 0; i < allCustomers.size(); i++) {
            Customer current = allCustomers.get(i);
            if (current.getCustomerId().equals(id)) {
                return current; // Found them!
            }
        }
        return null; // Nobody found with that ID
    }

    // --- UPDATE AN EXISTING CUSTOMER ---
    public void updateCustomer(Customer updatedCustomer) {
        CustomerList allCustomers = getAllCustomers();

        // Open file in Overwrite mode
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, false))) {

            for (int i = 0; i < allCustomers.size(); i++) {
                Customer current = allCustomers.get(i);

                // If this is the guy we want to update, write the NEW data
                if (current.getCustomerId().equals(updatedCustomer.getCustomerId())) {
                    writer.write(updatedCustomer.toFileString());
                } else {
                    // Otherwise, just write the old data back normally
                    writer.write(current.toFileString());
                }
                writer.newLine();
            }
            System.out.println("Customer " + updatedCustomer.getCustomerId() + " successfully updated!");

        } catch (IOException e) {
            System.out.println("Error updating customer: " + e.getMessage());
        }
    }
}