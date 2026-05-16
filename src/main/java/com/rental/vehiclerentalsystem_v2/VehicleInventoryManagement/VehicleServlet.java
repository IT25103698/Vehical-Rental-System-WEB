package com.rental.vehiclerentalsystem_v2.VehicleInventoryManagement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

// This line is the most important! It connects your JSP form to this code.
@WebServlet("/VehicleServlet")
public class VehicleServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // 1. Extract the shared data from the form
            String id = request.getParameter("vehicleId");
            String brand = request.getParameter("brand");
            String model = request.getParameter("model");
            String plate = request.getParameter("plate");
            double rate = Double.parseDouble(request.getParameter("rate"));
            String type = request.getParameter("vehicleType");

            VehicleFileManager fileManager = new VehicleFileManager();
            Vehicle newVehicle = null;

            // 2. Polymorphic Logic: Create the right object based on the "Type" dropdown
            if ("Car".equals(type)) {
                String fuel = request.getParameter("fuelType");
                newVehicle = new Car(id, brand, model, plate, rate, fuel);
            }
            else if ("Van".equals(type)) {
                double capacity = Double.parseDouble(request.getParameter("loadCapacity"));
                newVehicle = new Van(id, brand, model, plate, rate, capacity);
            }
            else if ("SUV".equals(type)) {
                boolean awd = request.getParameter("isAWD") != null;
                newVehicle = new SUV(id, brand, model, plate, rate, awd);
            }

            // 3. Save the vehicle and send the user to the inventory table
            if (newVehicle != null) {
                fileManager.saveVehicle(newVehicle);
                response.sendRedirect("manageVehicles.jsp");
            }
        } catch (Exception e) {
            // If something goes wrong, send them back to the form with an error
            response.sendRedirect("registerVehicle.jsp?error=1");
        }
    }
}