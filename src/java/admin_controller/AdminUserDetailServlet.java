/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package admin_controller;

import dao.UserDAO;
import jakarta.servlet.RequestDispatcher;  
import java.io.IOException;
import jakarta.servlet.ServletException;  //catch exception
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.Calendar; // get current calendar 
import java.util.List;
import java.util.logging.Level;   //log error
import java.util.logging.Logger;  //log error
import models.Order;
import models.User;
import models.UserOrder;

/**
 *
 * @author Son Duong This servlet is responsible display user detail information
 * in the system.
 */
@WebServlet(name = "AdminUserDetailServlet", urlPatterns = {"/admin/admin-user-detail"})
public class AdminUserDetailServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        //get id of user need display
        int userId = Integer.parseInt(request.getParameter("userId"));
        UserDAO uDao = new UserDAO();
        User user = null;
        List<UserOrder> userOrders = null;
        List<Order> orders = null;

        try {
            // Get current year for the user's birthdate.
            int currentYear = Calendar.getInstance().get(Calendar.YEAR);
            request.setAttribute("currentYear", currentYear);

            user = uDao.getUserById(userId); // for user detail information
            userOrders = uDao.getUserOrderByUserId(userId);  // for user's address
            orders = uDao.getOrderByUserId(userId); // for user's orders

            request.setAttribute("USER", user);
            request.setAttribute("USERORDER", userOrders);
            request.setAttribute("ORDERS", orders);

        } finally {
            //set status 
            String statusUpdate = request.getParameter("status");
            if (statusUpdate != null) {
                request.setAttribute("STATUSUPDATE", statusUpdate);
            }
            //set type info
            String typeInfo = request.getParameter("typeInfo");
            if (typeInfo != null) {
                request.setAttribute("TYPEINFO", typeInfo);
            }
            RequestDispatcher rd = request.getRequestDispatcher("admin_userDetail.jsp");
            rd.forward(request, response);
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
            Logger.getLogger(AdminUserDetailServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(AdminUserDetailServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(AdminUserDetailServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(AdminUserDetailServlet.class.getName()).log(Level.SEVERE, null, ex);
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
