/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

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
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.User;

/**
 *
 * @author Son Duong
 * This program will login user
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    private final String ERROR_PAGE = "login.jsp";
    private final String HOME = "./home";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        //get username and password that user enter
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        String url = ERROR_PAGE;

        try {
            LoginDAO lDao = new LoginDAO();
            //check username and password is exist in database
            User user = lDao.checkAccount(username, password);
            //if user is exist, change url to home page
            if (user != null) {
                url = HOME;
                HttpSession session = request.getSession();
                session.setAttribute("USER", user);
            }
        } finally {
            if (url == HOME) {
                response.sendRedirect(url);
            } else {
                response.sendRedirect("./login?status=error");
            }
        }

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.removeAttribute("USER");
        
        int currentYear = Calendar.getInstance().get(Calendar.YEAR);
        request.setAttribute("currentYear", currentYear);
        
        String status = request.getParameter("status");
        if(status != null) request.setAttribute("LOGINSTATUS", status);
        RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
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
