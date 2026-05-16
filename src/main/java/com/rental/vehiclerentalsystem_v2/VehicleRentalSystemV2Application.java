package com.rental.vehiclerentalsystem_v2;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.server.servlet.context.ServletComponentScan;

@ServletComponentScan
@SpringBootApplication
public class VehicleRentalSystemV2Application {

    public static void main(String[] args) {
        SpringApplication.run(VehicleRentalSystemV2Application.class, args);
    }

}
