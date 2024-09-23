/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AccountDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import models.User;


@WebServlet(name = "ChangePasswordServlet", urlPatterns = {"/changePassword"})
public class ChangePasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setAttribute("note", "");
            request.getRequestDispatcher("changePassword.jsp").forward(request, response);
        } catch (ServletException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("USER");
            if (user == null) {
                request.getRequestDispatcher("changePassword.jsp").forward(request, response);
                return;
                
            }
            if (!request.getParameter("type").equals("Change")) {
                response.sendRedirect("profile");
                return;
            }
            String oldPassword = request.getParameter("oldPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmedPassword = request.getParameter("confirmedPassword");
            AccountDAO ad = new AccountDAO();
            boolean isError = false;
            String note = "";
            if (!ad.isCorrectPasswordOfUserId(oldPassword, user.getId())) {
                isError = true;
                note = "Invalid old password";
            } else if (newPassword.compareTo(confirmedPassword) != 0) {
                isError = true;
                note = "Invalid confirm password";
            } else {
                ad.updatePasswordWithUserId(newPassword, user.getId());
            }
            if (isError) {
                request.setAttribute("note", note);
                request.getRequestDispatcher("changePassword.jsp").forward(request, response);
                return;
            }
            response.sendRedirect("profile");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

}
