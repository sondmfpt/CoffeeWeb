/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import api.EmailSender_Code;
import dao.LoginDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Pattern;
import models.User;

/**
 *
 * @author Son Duong
 */
@WebServlet(name = "ResetPasswordServlet", urlPatterns = {"/reset-password"})
public class ResetPasswordServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        String username = request.getParameter("username");
        LoginDAO lDao = new LoginDAO();
        User user = null;
        String status = request.getParameter("statusPost");
        HttpSession session = request.getSession();

        if (status.equals("checkUsername")) {
            try {
                user = lDao.getUser(username);
                if (user == null) {
                    request.setAttribute("RESET_STATUS", "notFoundAccount");
                } else {
                    request.setAttribute("RESET_STATUS", "chooseOption");
                    session.setAttribute("USER_ID", user.getId());
                    session.setAttribute("USER_EMAIL_REAL", user.getEmail());
                    session.setAttribute("USER_PHONE_REAL", user.getPhone());
                    session.setAttribute("USER_FIRSTNAME", user.getFirstName());
                    session.setAttribute("USER_LASTNAME", user.getLastName());

                    session.setAttribute("USER_EMAIL", encodeEmail(user.getEmail()));
                    session.setAttribute("USER_PHONE", encodePhone(user.getPhone()));
                }
            } finally {
                RequestDispatcher rd = request.getRequestDispatcher("resetPassword.jsp");
                rd.forward(request, response);

            }
        }
        if (status.equals("sendCode")) {
            String optionReset = request.getParameter("optionReset");
            if (optionReset.equals("email")) {
                String email = (String) session.getAttribute("USER_EMAIL_REAL");
                String code = randomCode();
                session.setAttribute("CODERESET", code);
                EmailSender_Code.sendEmail(email, code);
                response.sendRedirect("./reset-password?status=enterCode_email");
            }
            if (optionReset.equals("phone")) {
                //
            }
        }
        if (status.contains("enterCode")) {
            String enterCode = request.getParameter("enterCode");
            String code = (String) session.getAttribute("CODERESET");
            if (enterCode.equals(code)) {
                response.sendRedirect("./reset-password?status=resetPassword");
                session.removeAttribute("CODERESET");
            } else {
                response.sendRedirect("./reset-password?status=enterCode_again" + (status.contains("email") ? "_email" : "_phone"));
            }
        }

        if (status.equals("newPassword")) {
            String newPw = request.getParameter("newPassword");
            String confirmPw = request.getParameter("confirmPassword");
            String error = "";
            boolean check = false;
            Pattern patternPw = Pattern.compile("^(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&_])[A-Za-z\\d@$!%*?&_]{6,}$");
            if (!patternPw.matcher(newPw).matches()) {
                error += "_errorFormat";
                check = true;
            }

            if (!newPw.equals(confirmPw)) {
                error += "_errorConfirm";
                check = true;
            }
            if (check) {
                response.sendRedirect("./reset-password?status=resetPassword" + error);
            }
            int id = (int) session.getAttribute("USER_ID");
            lDao.resetPassword(id, newPw);
            session.removeAttribute("USER_ID");
            session.removeAttribute("USER_EMAIL");
            session.removeAttribute("USER_PHONE");
            session.removeAttribute("USER_FIRSTNAME");
            session.removeAttribute("USER_LASTNAME");
            response.sendRedirect("./login?status=resetSuccess");

        }

    }

    public String randomCode() {
        String s = "0123456789";
        String code = "";
        while (code.length() < 6) {
            Random rand = new Random();
            code += (s.charAt(rand.nextInt(10)) + "");
        }
        return code;
    }

    public String encodeEmail(String email) {
        String result = "";
        int foot = email.indexOf("@");
        for (int i = 0; i < email.length(); i++) {
            if (i <= 1 || i >= foot) {
                result += email.charAt(i) + "";
                continue;
            }
            result += "*";
        }
        return result;
    }

    public String encodePhone(String phone) {
        String result = "";
        for (int i = 0; i < phone.length(); i++) {
            if (i <= 1 || i >= phone.length() - 3) {
                result += phone.charAt(i) + "";
                continue;
            }
            result += "*";
        }
        return result;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String status = request.getParameter("status");
        request.setAttribute("RESET_STATUS", status);
        RequestDispatcher rd = request.getRequestDispatcher("resetPassword.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ResetPasswordServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(ResetPasswordServlet.class.getName()).log(Level.SEVERE, null, ex);
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
