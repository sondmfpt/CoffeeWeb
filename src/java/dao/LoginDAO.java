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
    
    public boolean isDupplicatedUsername(String username) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT * FROM accounts WHERE username = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, username);
                rs = stm.executeQuery();
                if (rs.next()) {
                    return true;
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
            return false;
        }
    }
    

    public void saveToken(String email, String token) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "INSERT INTO user_verification (email, token) VALUES (?, ?)";
                stm = con.prepareStatement(sql);
                stm.setString(1, email);
                stm.setString(2, token);
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

    public boolean checkToken(String token) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT * FROM user_verification WHERE token = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, token);
                rs = stm.executeQuery();
                if (rs.next()) {
                    return true;
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
        }
        return false;
    }

    public void registration(String username, String password, String firstname, String lastname, String gender, String email, LocalDate date) throws SQLException, ClassNotFoundException {
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
            int maxUserId = getMaxAccountId();
            saveAccount(maxUserId, username, password);
        }
    }

    public int getMaxAccountId() throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int maxId = 0;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT id FROM users ORDER BY id DESC LIMIT 1";
                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();
                if (rs.next()) {
                    maxId = rs.getInt("id");
                }
            }
        } finally {
            return maxId;
        }
    }

    public void saveAccount(int userId, String username, String password) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "INSERT INTO accounts (username, password, user_id) VALUES (?, ?, ?)";
                stm = con.prepareStatement(sql);
                stm.setString(1, username);
                stm.setString(2, password);
                stm.setInt(3, userId);
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
