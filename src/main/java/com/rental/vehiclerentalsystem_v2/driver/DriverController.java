package com.rental.vehiclerentalsystem_v2.driver;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class DriverController {

    private DriverService driverService = new DriverService();

    // Handles get requests for view drivers
    @GetMapping("/driver")
    public String showDriverPage(Model model) {

        Driver[] drivers = driverService.getAllDrivers();
        int count = driverService.getAllDriverCount();
      //driver array to view page
        model.addAttribute("drivers", drivers);
        model.addAttribute("count", count);


        return "viewDrivers";
    }

    // Handling addDriver form
    @PostMapping("/driver/add")
    public String addDriver(
            @RequestParam String driverId,
            @RequestParam String name,
            @RequestParam String nic,
            @RequestParam String licenseNumber,
            @RequestParam String phone,
            @RequestParam String address,
            @RequestParam boolean available,
            @RequestParam(required = false) String assignedVehicleId,
            @RequestParam String driverType,
            @RequestParam(required = false, defaultValue = "0") double monthlySalary,
            @RequestParam(required = false, defaultValue = "0") int tripsCompleted,
            @RequestParam(required = false, defaultValue = "0") double commissionPerTrip
    ) {

        if (assignedVehicleId == null || assignedVehicleId.trim().isEmpty()) {
            assignedVehicleId = "none";
        }

        Driver driver;

        if (driverType.equals("FullTime")) {
            driver = new FullTimeDriver(
                    driverId, name, nic, licenseNumber,
                    phone, address, available,
                    assignedVehicleId, monthlySalary
            );
        } else {
            driver = new FreelanceDriver(
                    driverId, name, nic, licenseNumber,
                    phone, address, available,
                    assignedVehicleId, tripsCompleted, commissionPerTrip
            );
        }

        driverService.addDriver(driver);

        // ✔ ALWAYS RETURN VIEW LIST AFTER ACTION
        return "redirect:/driver";
    }

    // DELETE DRIVER
    @PostMapping("/driver/delete")
    public String deleteDriver(@RequestParam String licenseNumber) {

        driverService.deleteDriver(licenseNumber);

        return "redirect:/driver";
    }

    // UPDATE AVAILABILITY
    @PostMapping("/driver/updateAvailability")
    public String updateAvailability(
            @RequestParam String licenseNumber,
            @RequestParam boolean available
    ) {

        driverService.updateDriverAvailability(licenseNumber, available);

        return "redirect:/driver";
    }


    @PostMapping("/driver/updateFreelancePayment")
    public String updateFreelancePayment(

            @RequestParam String licenseNumber,

            @RequestParam int tripsCompleted,

            @RequestParam double commissionPerTrip
    ) {

        driverService.updateFreelancePayment(
                licenseNumber,
                tripsCompleted,
                commissionPerTrip
        );

        return "redirect:/driver";
    }
}
