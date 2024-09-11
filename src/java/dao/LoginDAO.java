/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import models.Login;
import models.User;
import utils.DBHelper;
/**
 *
 * @author Son Duong
 */
public class LoginDAO {
    
    public User checkAccount(String username, String password) throws ClassNotFoundException, SQLException{
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        User user = null;
        try{
            con = DBHelper.makeConnection();
            if(con != null){
                String sql = "SELECT u.*, r.role_name "
                        + "FROM login l "
                        + "JOIN users u ON l.user_id = u.user_id "
                        + "JOIN role r ON r.role_id = u.role_id "
                        + "WHERE username = ? "
                        + "AND password = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, username);
                stm.setString(2, password);
                rs = stm.executeQuery();
                if(rs.next()){
                    int id = rs.getInt("user_id");
                    String firstName = rs.getString("first_name");
                    String lastName = rs.getString("last_name");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");
                    String address = rs.getString("address");
                    String role = rs.getString("role_name");
                    user = new User(id, firstName, lastName, email, phone, address, role);
                }
                
            }
        }finally{
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
    
}
