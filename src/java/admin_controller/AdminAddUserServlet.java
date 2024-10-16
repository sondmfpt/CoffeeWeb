/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package admin_controller;

import api.EmailSender_ChangeUserInformation;
import com.google.gson.Gson;
import dao.UserDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.User;

/**
 *
 * @author Son Duong
 */
@WebServlet(name = "AdminAddUserServlet", urlPatterns = {"/admin-add-user"})
public class AdminAddUserServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
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
        LocalDate date = LocalDate.of(year, month, day);
        boolean isActive = status.equals("active");

        UserDAO uDao = new UserDAO();
        try {
                User user = uDao.addUser(username, password, firstname, lastname, email, phone, gender, roleId, isActive, date);

            if (request.getParameter("sendForUser") != null) {
                EmailSender_ChangeUserInformation.addNewUser(user);
            }

        } finally {
            String url = "./admin-add-user?status=success";
            response.sendRedirect(url);
        }

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int currentYear = Calendar.getInstance().get(Calendar.YEAR);
        request.setAttribute("currentYear", currentYear);

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
