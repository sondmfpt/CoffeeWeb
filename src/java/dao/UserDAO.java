package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import models.User;
import database.DBHelper;
import java.util.ArrayList;
import java.util.List;
import models.Pair;

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
                                "email = ?, " +
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
    
    
    // Admin Manage User
    
    public List<User> getAllUser() throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<User> users = new ArrayList<>();
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT u.*, a.active, a.username, r.role_name "
                        + "FROM users u "
                        + "JOIN accounts a ON u.id = a.user_id "
                        + "JOIN role r ON u.role_id = r.id";
                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String username = rs.getString("username");
                    String firstname = rs.getString("first_name");
                    String lastname = rs.getString("last_name");
                    if(lastname == null) lastname = "";
                    String gender = rs.getString("gender");
                    String phone = rs.getString("phone");
                    Date dateofbirth = rs.getDate("date_of_birth");
                    String email = rs.getString("email");
                    String role = rs.getString("role_name");
                    Boolean active = rs.getBoolean("active");
                    Date createdAt = rs.getDate("created_at");
                    User user = new User(id, firstname, lastname, gender, phone, dateofbirth, email, role);
                    user.setUsername(username);
                    user.setActive(active);
                    user.setCreatedAt(createdAt);
                    users.add(user);
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
            return users;
        }
    }
}
