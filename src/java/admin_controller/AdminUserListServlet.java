/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package admin_controller;

import dao.UserDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import models.Pair;
import models.User;

/**
 *
 * @author Son Duong
 */
@WebServlet(name = "AdminUserListServlet", urlPatterns = {"/admin-user-list"})
public class AdminUserListServlet extends HttpServlet {
    
    private int ROWS_PER_PAGE = 5;

    private int getTotalUserInRole(List<User> users, String role) {
        return (int) users.stream()
                .filter(user -> user.getRole().equals(role)).count();
    }
    
    private List<User> filterUserByPagination(List<User> users, int page){
        return users.stream()
                .skip((page - 1) * ROWS_PER_PAGE) // Bỏ qua 2 phần tử đầu
                .limit(ROWS_PER_PAGE) // Lấy 5 phần tử tiếp theo
                .collect(Collectors.toList());
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            UserDAO uDao = new UserDAO();
            List<User> allUsers = uDao.getAllUser();

            int totalAdmin = getTotalUserInRole(allUsers, "ADMIN");
            int totalCustomer = getTotalUserInRole(allUsers, "CUSTOMER");
            int totalUser = allUsers.size();
            int totalPage = totalUser % ROWS_PER_PAGE == 0 ? totalUser / ROWS_PER_PAGE : (totalUser / ROWS_PER_PAGE) + 1;
            
            
            request.setAttribute("ALLUSERS", allUsers);
            request.setAttribute("TOTALADMIN", totalAdmin);
            request.setAttribute("TOTALCUSTOMER", totalCustomer);
            request.setAttribute("TOTALUSER", totalUser);
            request.setAttribute("TOTALPAGE", totalPage);

            RequestDispatcher rd = request.getRequestDispatcher("admin_productDetail.jsp");
            rd.forward(request, response);

        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(AdminUserListServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
