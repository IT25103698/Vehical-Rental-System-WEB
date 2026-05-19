package com.rental.vehiclerentalsystem_v2.rentalpackages;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/AddPackageServlet")
public class AddPackageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("packageId");
        String name = request.getParameter("packageName");
        String duration = request.getParameter("duration");
        double price = Double.parseDouble(request.getParameter("price"));

        RentalPackage pkg = new RentalPackage(id, name, duration, price);
        PackageManager manager = new PackageManager();
        manager.savePackage(pkg);

        response.sendRedirect("managePackages.jsp");
    }
}