/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.LoginDAO;
import dao.OtherDAO;
import dao.ProductDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Product;
import models.Trend;
import models.User;

/**
 *
 * @author Son Duong
 */
@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        ProductDAO pDao = new ProductDAO();
        OtherDAO oDao = new OtherDAO();
        List<Product> bestSelling = null;
        List<String> galeries = null;
        Trend trend = null;

        try {
            trend = pDao.getTrend(1);
            request.setAttribute("TREND", trend);

            bestSelling = pDao.getBestSellingProduct();
            request.setAttribute("BESTSELLING", bestSelling);

            galeries = oDao.getHomeGalery();
            request.setAttribute("GALERIES", galeries);

            saveUser(request, response);

        } finally {
            RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
            rd.forward(request, response);
        }

    }

    private void saveUser(HttpServletRequest request, HttpServletResponse response) throws SQLException, ClassNotFoundException {
        HttpSession session = request.getSession();
        LoginDAO lDao = new LoginDAO();
        Cookie[] cookies = request.getCookies();
        String trackingId = null;

        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("TrackingID")) {
                    trackingId = cookie.getValue();
                    break;
                }
            }
        }

        if (trackingId == null) {
            trackingId = java.util.UUID.randomUUID().toString();
            Cookie newCookie = new Cookie("TrackingID", trackingId);
            newCookie.setMaxAge(60 * 60 * 24 * 365);
            response.addCookie(newCookie);
            lDao.saveGuestUser(trackingId);
        }

        session.setAttribute("TRACKINGID", trackingId);

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
            Logger.getLogger(HomeServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(HomeServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(HomeServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(HomeServlet.class.getName()).log(Level.SEVERE, null, ex);
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
