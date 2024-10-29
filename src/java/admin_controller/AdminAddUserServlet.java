/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package admin_controller;

import api.EmailSender_ChangeUserInformation;   //class call API to send email when change user information
import dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.time.LocalDate;  // Java's local date library for handling date-related operations.
import java.util.Calendar;  // Utility for handling date and time operations.
import java.util.logging.Level;
import java.util.logging.Logger;
import models.User;

/**
 * @author Son Duong This servlet is responsible for adding a new user to the
 * system.
 */
@WebServlet(name = "AdminAddUserServlet", urlPatterns = {"/admin-add-user"})
// Defines the servlet and maps it to the URL pattern "/admin-add-user".
public class AdminAddUserServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        // Extracts form data sent from the user interface.
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String gender = request.getParameter("gender");
        int roleId = Integer.parseInt(request.getParameter("roleId"));
        String status = request.getParameter("status");
        int day = Integer.parseInt(request.getParameter("date-day"));
        int month = Integer.parseInt(request.getParameter("date-month"));
        int year = Integer.parseInt(request.getParameter("date-year"));

        // Creates a LocalDate object for the user's birthdate.
        LocalDate date = LocalDate.of(year, month, day);
        boolean isActive = status.equals("active");

        UserDAO uDao = new UserDAO();
        try {
            // Adds the user to the database using the DAO and returns the newly created user object.
            User user = uDao.addUser(username, password, firstname, lastname, email, phone, gender, roleId, isActive, date);

            // Sends an email to the new user if the "sendForUser" parameter is provided.
            if (request.getParameter("sendForUser") != null) {
                EmailSender_ChangeUserInformation.addNewUser(user);
            }

        } finally {
            String url = "./admin-add-user?status=success";
            response.sendRedirect(url);
        }

    }

    /**
     * Handles the HTTP GET method. It displays the form for adding a new user.
     *
     * @param request Servlet request.
     * @param response Servlet response.
     * @throws ServletException If a servlet-specific error occurs.
     * @throws IOException If an I/O error occurs.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Gets the current year to be used in the form.
        int currentYear = Calendar.getInstance().get(Calendar.YEAR);
        request.setAttribute("currentYear", currentYear);

        // Retrieves the status parameter from the request and sets it for display in the JSP page.
        String status = request.getParameter("status");
        request.setAttribute("STATUS", status);

        request.getRequestDispatcher("admin_addUser.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AdminAddUserServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(AdminAddUserServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
