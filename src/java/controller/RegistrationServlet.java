/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import api.EmailSender_Link;   // class call API to send email a link to confirm
import dao.LoginDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;  // catch exception
import java.time.LocalDate;  // declare local date variable
import java.util.Calendar;  // get current calendar (year)
import java.util.UUID;      // create a random UUID
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Pattern;
import models.RegisErrors;

/**
 *
 * @author Son Duong
 * This program register for new user's account
 */
@WebServlet(name = "RegistrationServlet", urlPatterns = {"/registration"})
public class RegistrationServlet extends HttpServlet {

    //get current year
    int currentYear = Calendar.getInstance().get(Calendar.YEAR);

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        LoginDAO lDao = new LoginDAO();
        RegisErrors errors = new RegisErrors();
        boolean isError = false;

        //get information that user filled
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");

        Pattern patternPw = Pattern.compile("^(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&_])[A-Za-z\\d@$!%*?&_]{6,}$");
        Pattern patternUn = Pattern.compile("^(?=.*[A-Za-z])[A-Za-z0-9_]{6,}$");

        //check username is dupplicated
        if (lDao.isDupplicatedUsername(username)) {
            errors.setDupplicatedUsername("Username have been used!");
            isError = true;
        }
        //validate password
        if (!patternPw.matcher(password).matches()) {
            errors.getNotFormatPassword().add("Password must have least 6 characters");
            errors.getNotFormatPassword().add("Least 1 upper case");
            errors.getNotFormatPassword().add("Least 1 number");
            errors.getNotFormatPassword().add("Least 1 special character");
            isError = true;
        }
        //validate username
        if (!patternUn.matcher(username).matches()) {
            errors.setNotFormatUsername("Username must have least 6 characters");
            isError = true;
        }
        //check email dupplicated
        if (lDao.isDupplicatedEmail(email)) {
            errors.setDupplicatedEmail("This email is used!");
            isError = true;
        }
        //if there is any error, allow user fill again
        if (isError) {
            request.setAttribute("REGIS_ERRORS", errors);
            request.setAttribute("currentYear", currentYear);
            RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
            rd.forward(request, response);
        } else {

            //get information to registration
            String firstname = request.getParameter("firstname");
            String lastname = request.getParameter("lastname");
            String gender = request.getParameter("gender");
            int day = Integer.parseInt(request.getParameter("date-day"));
            int month = Integer.parseInt(request.getParameter("date-month"));
            int year = Integer.parseInt(request.getParameter("date-year"));
            LocalDate date = LocalDate.of(year, month, day);

            //send announcement for user know to check email
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Verify</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Vui lòng kiểm tra email để xác nhận đăng ký.</h1>");
            out.println("</body>");
            out.println("</html>");

            try {

                //set up token to create confirm link
                String token = UUID.randomUUID().toString();
                lDao.saveToken(email, token, 3);

                String confirmationLink = generateConfirmationLink(username, password, firstname, lastname, gender, email, date, token);
                EmailSender_Link.sendEmail(email, confirmationLink); //send confirm link to user's email

            } finally {

            }

            try {

                String token = UUID.randomUUID().toString();
                lDao.saveToken(email, token, 3);

                String confirmationLink = generateConfirmationLink(username, password, firstname, lastname, gender, email, date, token);
                EmailSender_Link.sendEmail(email, confirmationLink);

            } finally {

            }
        }
    }

    //create a confirm link
    private String generateConfirmationLink(String username, String password, String firstname, String lastname, String gender, String email, LocalDate date, String token) {
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
