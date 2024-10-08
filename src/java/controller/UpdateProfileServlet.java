package controller;

import models.User;
import dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.Date;
import java.text.SimpleDateFormat;

@WebServlet(name = "UpdateProfileServlet", urlPatterns = {"/updateProfile"})
public class UpdateProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.getRequestDispatcher("updateProfile.jsp").forward(request, response);
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
                response.sendRedirect("profile");
                return;
            }
            if (!request.getParameter("type").equals("Update")) {
                response.sendRedirect("profile");
                return;
            }
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String gender = request.getParameter("gender");
            String phone = request.getParameter("phone");
            Date dob = null;
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                String dobString = request.getParameter("dob");
                dob = sdf.parse(dobString);
            } catch (ParseException e) {
                e.printStackTrace();
            }
            String email = request.getParameter("email");
            UserDAO ud = new UserDAO();
            ud.updateUserWithId(firstName, lastName, gender, phone, dob, email, user.getId());
            user = ud.getUserWithId(user.getId());
            session.setAttribute("USER", user);
            response.sendRedirect("profile");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

}
