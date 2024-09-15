/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.Date;
import models.Accounts;
import models.User;
import utils.DBHelper;

/**
 *
 * @author Son Duong
 */
public class LoginDAO {

    public User checkAccount(String username, String password) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        User user = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT u.*, r.role_name "
                        + "FROM accounts a "
                        + "JOIN users u ON a.user_id = u.id "
                        + "JOIN role r ON r.id = u.role_id "
                        + "WHERE username = ? "
                        + "AND password = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, username);
                stm.setString(2, password);
                rs = stm.executeQuery();
                if (rs.next()) {
                    int id = rs.getInt("id");
                    String firstName = rs.getString("first_name");
                    String lastName = rs.getString("last_name");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");
                    String gender = rs.getString("gender");
                    Date date = rs.getDate("date_of_birth");
                    String address = rs.getString("address");
                    String role = rs.getString("role_name");
                    user = new User(id, firstName, lastName, gender, phone, date, email, address, role);
                }

            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
            return user;
        }
    }
    
    public void registration(String username, String password, String firstname, String lastname, String gender, String email, LocalDate date) throws SQLException, ClassNotFoundException{
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "INSERT INTO users(first_name, last_name, gender, email, date_of_birth) "
                        + "VALUE (?, ?, ?, ?, ?) ";
                stm = con.prepareStatement(sql);
                stm.setString(1, firstname);
                stm.setString(2, lastname);
                stm.setString(3, gender);
                stm.setString(4, email);
                stm.setDate(5, java.sql.Date.valueOf(date));
                stm.executeUpdate();
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }

}
