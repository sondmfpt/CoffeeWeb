/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package admin_controller;

import api.EmailSender_ChangeUserInformation;  // class use API to send email
import dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException; //catch exception
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.time.LocalDate;      //declare local date variable to save date of birth of user
import java.util.logging.Level;  //log error
import java.util.logging.Logger; //log error
import models.Accounts;
import models.User;

/**
 *
 * @author Son Duong
 * This servlet is responsible for update user information in the system.
 */
@WebServlet(name = "AdminUpdateUser", urlPatterns = {"/admin-update-user"})
public class AdminUpdateUser extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        // Extracts form data sent from the user interface.
        int id = Integer.parseInt(request.getParameter("id"));
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

            // Update information for user. If admin click send for user, system will send announment to user's email
            if (request.getParameter("sendForUser") != null) {
                User userBefore = uDao.getUserById(id);
                uDao.updateUser(id, password, firstname, lastname, email, phone, gender, date, roleId, isActive);
                User userAfter = uDao.getUserById(id);
                EmailSender_ChangeUserInformation.changeProfile(userBefore, userAfter);
            } else {
                uDao.updateUser(id, password, firstname, lastname, email, phone, gender, date, roleId, isActive);
            }

        } finally {
            //set success status and redirect to user detail page
            String url = "./admin-user-detail?userId=" + id + "&status=success";
            response.sendRedirect(url);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AdminUpdateUser.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(AdminUpdateUser.class.getName()).log(Level.SEVERE, null, ex);
        }
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
            Logger.getLogger(AdminUpdateUser.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(AdminUpdateUser.class.getName()).log(Level.SEVERE, null, ex);
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
