package com.rental.vehiclerentalsystem_v2.admin;

import com.rental.vehiclerentalsystem_v2.customer.Customer;
import com.rental.vehiclerentalsystem_v2.customer.CustomerFileManager;
import com.rental.vehiclerentalsystem_v2.utils.CustomerList;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get credentials from the login form
        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        HttpSession session = request.getSession();

        // --- 1. ADMIN AUTHENTICATION (Hardcoded for University Project) ---
        if ("admin".equals(user) && "1234".equals(pass)) {
            session.setAttribute("adminLoggedIn", true);
            session.setAttribute("userRole", "ADMIN");
            // Redirect to your admin dashboard/index
            response.sendRedirect("index.jsp");
            return;
        }

        // --- 2. CUSTOMER AUTHENTICATION (Database/File Check) ---
        try {
            CustomerFileManager cfm = new CustomerFileManager();
            CustomerList allCustomers = cfm.getAllCustomers();

            if (allCustomers != null) {
                for (int i = 0; i < allCustomers.size(); i++) {
                    Customer c = allCustomers.get(i);
                    // Check if email matches username and phone matches password
                    if (c.getEmail().equalsIgnoreCase(user) && c.getPhone().equals(pass)) {
                        session.setAttribute("customerUser", c);
                        session.setAttribute("userRole", "CUSTOMER");
                        // Redirect to the beautiful Home Page we just built
                        response.sendRedirect("customerHome.jsp");
                        return;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // --- 3. LOGIN FAILURE ---
        // Redirect back to login page with an error parameter
        response.sendRedirect("login.jsp?error=1");
    }
}