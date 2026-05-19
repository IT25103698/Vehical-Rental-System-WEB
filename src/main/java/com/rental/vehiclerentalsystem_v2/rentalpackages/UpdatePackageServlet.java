package com.rental.vehiclerentalsystem_v2.rentalpackages;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/UpdatePackageServlet")
public class UpdatePackageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String id = request.getParameter("packageId");
            String name = request.getParameter("packageName");
            String duration = request.getParameter("duration");
            double price = Double.parseDouble(request.getParameter("price"));

            RentalPackage updatedPkg = new RentalPackage(id, name, duration, price);
            new RentalPackageFileManager().updatePackage(updatedPkg);

            // Go back to the list to see the changes
            response.sendRedirect("viewPackages.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("viewPackages.jsp?error=updatefailed");
        }
    }
}