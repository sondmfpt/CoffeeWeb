package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import models.User;
import database.DBHelper;

public class UserDAO {

    Connection con;
    PreparedStatement ps = null;
    ResultSet rs = null;
    User user = null;

    public UserDAO() throws ClassNotFoundException, SQLException {
        con = DBHelper.makeConnection();
    }

    public User getUserWithId(int id) {
        String query = "SELECT * FROM users JOIN role ON users.role_id = role.id WHERE users.id=?";
        try {
            ps = con.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new User(
                        id,
                        rs.getString("first_name"),
                        rs.getString("last_name"),
                        rs.getString("gender"),
                        rs.getString("phone"),
                        rs.getDate("date_of_birth"),
                        rs.getString("email"),
                        rs.getString("role_name")
                );
            }
        } catch (Exception e) {
            e.printStackTrace(); // Handle exceptions appropriately in your application
        }
        return null;
    }

    public void updateUserWithId(String firstName, String lastName, String gender, String phone, Date dob, String email, int id) {
        String query = "UPDATE users " +
                                "SET first_name = ?, " +
                                "last_name = ?, " +
                                "gender = ?, " +
                                "phone = ?, " +
                                "date_of_birth = ?, " +
                                "email = ?" +
                                "WHERE id = ?;";
        try {
            ps = con.prepareStatement(query);
            ps.setString(1, firstName);
            ps.setString(2, lastName);
            ps.setString(3, gender);
            ps.setString(4, phone);
            if (dob != null) {
                ps.setDate(5, new java.sql.Date(dob.getTime()));
            } else {
                ps.setDate(5, null);
            }
            ps.setString(6, email);
            ps.setInt(7, id);
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
