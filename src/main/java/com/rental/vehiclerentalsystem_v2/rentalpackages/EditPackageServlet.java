package com.rental.vehiclerentalsystem_v2.rentalpackages;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/EditPackageServlet")
public class EditPackageServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");

        RentalPackageFileManager manager = new RentalPackageFileManager();
        List<RentalPackage> packages = manager.getAllPackages();

        RentalPackage foundPackage = null;
        for (RentalPackage p : packages) {
            if (p.getPackageId().equals(id)) {
                foundPackage = p;
                break;
            }
        }

        if (foundPackage != null) {
            // Send the package object to the JSP
            request.setAttribute("pkg", foundPackage);
            request.getRequestDispatcher("editPackage.jsp").forward(request, response);
        } else {
            response.sendRedirect("viewPackages.jsp");
        }
    }
}