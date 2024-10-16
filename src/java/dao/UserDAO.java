package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import models.User;
import database.DBHelper;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.sql.Statement;

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
        String query = "UPDATE users "
                + "SET first_name = ?, "
                + "last_name = ?, "
                + "gender = ?, "
                + "phone = ?, "
                + "date_of_birth = ?, "
                + "email = ?, "
                + "WHERE id = ?;";
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
                    if (lastname == null) {
                        lastname = "";
                    }
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

    public List<User> getAllUserPagination(int page, int rowPerPage) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int ROWS_PER_PAGE = rowPerPage;
        int offset = (page - 1) * ROWS_PER_PAGE;
        List<User> users = new ArrayList<>();
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT u.*, a.active, a.username, r.role_name "
                        + "FROM users u "
                        + "JOIN accounts a ON u.id = a.user_id "
                        + "JOIN role r ON u.role_id = r.id "
                        + "LIMIT ?, ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, offset);
                stm.setInt(2, ROWS_PER_PAGE);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String username = rs.getString("username");
                    String firstname = rs.getString("first_name");
                    String lastname = rs.getString("last_name");
                    if (lastname == null) {
                        lastname = "";
                    }
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

    public void addUser(String username, String password, String firstname, String lastname, String email, String phone, String gender, int roleId, boolean isActive, LocalDate date) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        int userId = 0;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "INSERT INTO users (first_name, last_name, gender, phone, date_of_birth, email, role_id) "
                        + "VALUES (?, ?, ?, ?, ?, ?, ?)";
                stm = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                stm.setString(1, firstname);
                stm.setString(2, lastname);
                stm.setString(3, gender);
                stm.setString(4, phone);
                stm.setDate(5, java.sql.Date.valueOf(date));
                stm.setString(6, email);
                stm.setInt(7, roleId);
                stm.executeUpdate();
                ResultSet generatedKeys = stm.getGeneratedKeys();
                if (generatedKeys.next()) {
                    userId = generatedKeys.getInt(1);
                }
            }
        } finally {
            addAccount(username, password, isActive, userId);
        }
    }

    public void addAccount(String username, String password, boolean isActive, int userId) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "INSERT INTO accounts (username, password, active, user_id) "
                        + "VALUES (?, ?, ?, ?)";
                stm = con.prepareStatement(sql);
                stm.setString(1, username);
                stm.setString(2, password);
                stm.setBoolean(3, isActive);
                stm.setInt(4, userId);
                stm.executeUpdate();
            }
        } finally {
            if (con != null) {
                con.close();
            }
            if (stm != null) {
                stm.close();
            }
        }
    }

}
