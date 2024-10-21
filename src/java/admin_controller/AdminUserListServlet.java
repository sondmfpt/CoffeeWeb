/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package admin_controller;

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
import java.util.Collections;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import models.User;
import models.UserResponse;
import org.json.JSONObject;

/**
 *
 * @author Son Duong
 */
@WebServlet(name = "AdminUserListServlet", urlPatterns = {"/admin-user-list"})
public class AdminUserListServlet extends HttpServlet {

    //set default numbers of students in the list: 2
    private int ROWS_PER_PAGE = 2;

    // Method to count the number of users belonging to a specific role
    private int getTotalUserInRole(List<User> users, String role) {
         // Stream through the list of users, filter by role, and count the total
        return (int) users.stream()
                .filter(user -> user.getRole().equals(role)).count();
    }

    // Method to filter users based on their role (case-insensitive)
    private List<User> filterUserByRole(List<User> users, String role) {
        // Stream through the list of users and filter them based on their role
        return users.stream()
                .filter(user -> user.getRole().toLowerCase().equals(role.toLowerCase()))
                .collect(Collectors.toList());
    }

    // Method to search for users by their username (case-insensitive)
    private List<User> searchUser(List<User> users, String search) {
         // Stream through the list of users, filter by username, and return the matching results
        return users.stream()
                .filter(user -> user.getUsername().toLowerCase().contains(search.toLowerCase()))
                .collect(Collectors.toList());
    }

    // Method to paginate the list of users
    private List<User> filterUserByPagination(List<User> users, int page) {
        // Skip users based on the current page and limit the result to a predefined number of rows
        return users.stream()
                .skip((page - 1) * ROWS_PER_PAGE)
                .limit(ROWS_PER_PAGE)
                .collect(Collectors.toList());
    }

    // Method to order users based on different attributes (username, name, role, date, status)
    private List<User> orderUser(List<User> users, String type, String value) {
        if (value.equals("default")) {
            return users;
        } else {
            // Sort based on the type of attribute (username, name, role, date, status)
            if (type.equals("username")) {
                users = users.stream()
                        .sorted((p1, p2) -> p1.getUsername().compareTo(p2.getUsername()))
                        .collect(Collectors.toList());
            } else if (type.equals("name")) {
                users = users.stream()
                        .sorted((p1, p2) -> p1.getFirstName().compareTo(p2.getFirstName()))
                        .collect(Collectors.toList());
            } else if (type.equals("role")) {
                users = users.stream()
                        .sorted((p1, p2) -> p1.getRole().compareTo(p2.getRole()))
                        .collect(Collectors.toList());
            } else if (type.equals("date")) {
                users = users.stream()
                        .sorted((p1, p2) -> p1.getDate().compareTo(p2.getDate()))
                        .collect(Collectors.toList());
            } else if (type.equals("status")) {
                users = users.stream()
                        .sorted((p1, p2) -> Boolean.valueOf(p1.isActive()).compareTo(Boolean.valueOf(p2.isActive())))
                        .collect(Collectors.toList());
            }

            // If the ordering value is 'desc', reverse the sorted list
            if (value.equals("desc")) {
                users = users.stream()
                        .collect(Collectors.collectingAndThen(Collectors.toList(), lst -> {
                            Collections.reverse(lst);
                            return lst;
                        }));
            }
            return users;
        }

    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        //get order options chosen by users
        String order = request.getParameter("order");
        String role = request.getParameter("roleUser");
        String search = request.getParameter("searchValue");
        int numPage = Integer.parseInt(request.getParameter("numPage"));
        ROWS_PER_PAGE = Integer.parseInt(request.getParameter("numPerPage"));

        JSONObject orderJson = new JSONObject(order);   //convert order object to json
        //get key and value in json
        String typeOrder = orderJson.getString("type"); 
        String valueOrder = orderJson.getString("value");
        UserDAO uDao = new UserDAO();
        List<User> allUsers = uDao.getAllUser();

        //search user
        if (search.length() != 0) {
            allUsers = searchUser(allUsers, search);
        }
        if (!role.equals("all")) {
            allUsers = filterUserByRole(allUsers, role);
        }
        int totalUser = allUsers.size();

        //pagination
        allUsers = filterUserByPagination(allUsers, numPage);
        //order user
        allUsers = orderUser(allUsers, typeOrder, valueOrder);

        //calculate total page by total user and numbers user in page
        int totalPage = totalUser % ROWS_PER_PAGE == 0 ? totalUser / ROWS_PER_PAGE : (totalUser / ROWS_PER_PAGE) + 1;

        //response information to view
        PrintWriter out = response.getWriter();
        UserResponse userResponse = new UserResponse(allUsers, totalPage, totalUser);
        String jsonResponse = new Gson().toJson(userResponse);
        out.write(jsonResponse);
        out.flush();
    }

    //set up information to display user list
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            //get user by default
            UserDAO uDao = new UserDAO();
            List<User> allUsers = uDao.getAllUser();
            List<User> allUsersInPage = uDao.getAllUserPagination(1, ROWS_PER_PAGE);

            int totalAdmin = getTotalUserInRole(allUsers, "ADMIN");
            int totalCustomer = getTotalUserInRole(allUsers, "CUSTOMER");
            int totalUser = allUsers.size();
            //calculate total page by total user and numbers user in page
            int totalPage = totalUser % ROWS_PER_PAGE == 0 ? totalUser / ROWS_PER_PAGE : (totalUser / ROWS_PER_PAGE) + 1;

            //set attribute to redirect to view
            request.setAttribute("ALLUSERS", allUsersInPage);
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
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AdminUserListServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(AdminUserListServlet.class.getName()).log(Level.SEVERE, null, ex);
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
