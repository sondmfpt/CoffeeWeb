/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import api.EmailSender;
import dao.LoginDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.Calendar;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Pattern;
import models.RegisErrors;

/**
 *
 * @author Son Duong
 */
@WebServlet(name = "RegistrationServlet", urlPatterns = {"/registration"})
public class RegistrationServlet extends HttpServlet {
    
    int currentYear = Calendar.getInstance().get(Calendar.YEAR);

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        LoginDAO lDao = new LoginDAO();
        RegisErrors errors = new RegisErrors();
        boolean isError = false;

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Pattern patternPw = Pattern.compile("^(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{6,}$");
        Pattern patternUn = Pattern.compile("^(?=.*[A-Za-z])[A-Za-z0-9_]{6,}$");

        if (lDao.isDupplicatedUsername(username)) {
            errors.setDupplicatedUsername("Username have been used!");
            isError = true;
        }
        if (!patternPw.matcher(password).matches()) {
            errors.setNotFormatPassword("Password must have least 6 characters, least 1 upper case, least 1 number, least 1 special character");
            isError = true;
        }
        if (!patternUn.matcher(username).matches()) {
            errors.setNotFormatUsername("Username must have least 6 characters");
            isError = true;
        }
        
        if(isError){
            request.setAttribute("REGIS_ERRORS", errors);
            request.setAttribute("currentYear", currentYear);
            RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
            rd.forward(request, response);
        }

        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String gender = request.getParameter("gender");
        String email = request.getParameter("email");
        int day = Integer.parseInt(request.getParameter("date-day"));
        int month = Integer.parseInt(request.getParameter("date-month"));
        int year = Integer.parseInt(request.getParameter("date-year"));
        LocalDate date = LocalDate.of(year, month, day);

        response.getWriter().write("Vui lòng kiểm tra email để xác nhận đăng ký.");

        try {

            String token = UUID.randomUUID().toString();
            lDao.saveToken(email, token);

            String confirmationLink = generateConfirmationLink(username, password, firstname, lastname, gender, email, date, token);
            EmailSender.sendEmail(email, confirmationLink);

        } finally {

        }
    }

    private String generateConfirmationLink(String username, String password, String firstname, String lastname, String gender, String email, LocalDate date, String token) {
        // Tạo đường link xác nhận, ví dụ:
        return "http://localhost:9999/SWP_Project/confirm?token=" + token
                + "&username=" + username
                + "&password=" + password
                + "&firstname=" + firstname
                + "&lastname=" + lastname
                + "&gender=" + gender
                + "&email=" + email
                + "&date=" + date;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("currentYear", currentYear);
        RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(RegistrationServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(RegistrationServlet.class.getName()).log(Level.SEVERE, null, ex);
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
