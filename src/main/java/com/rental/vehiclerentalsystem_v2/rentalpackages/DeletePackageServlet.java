package com.rental.vehiclerentalsystem_v2.rentalpackages;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/DeletePackageServlet")
public class DeletePackageServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");

        RentalPackageFileManager manager = new RentalPackageFileManager();
        manager.deletePackage(id);

        response.sendRedirect("viewPackages.jsp");
    }
}