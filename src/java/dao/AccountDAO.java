package dao;

import database.DBHelper;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import models.User;
import database.DBHelper;

public class AccountDAO extends DBHelper {
    
    Connection con;
    PreparedStatement ps = null;
    ResultSet rs = null;
    User user = null;

    public AccountDAO() throws ClassNotFoundException, SQLException {
        con = DBHelper.makeConnection();
    }
    
    public boolean isCorrectPasswordOfUserId(String password, int id) {
        String query = "SELECT password from accounts Where user_id = ?;";
        try {
            ps = con.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("password").equals(password);
            }
        } catch (Exception e) {
            e.printStackTrace(); // Handle exceptions appropriately in your application
        }
        return false;
    }
    
    public void updatePasswordWithUserId(String password, int id) {
        String query = "UPDATE accounts " +
                                "SET password = ? " +
                                "WHERE user_id = ?;";
        try {
            ps = con.prepareStatement(query);
            ps.setString(1, password);
            ps.setInt(2, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace(); // Handle exceptions appropriately in your application
        }
    }
    
    @Override
    public void finalize() {
        try {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
}
