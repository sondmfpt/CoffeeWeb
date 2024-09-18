/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package database;

import java.io.Serializable;
import java.sql.SQLException;
import java.sql.Connection;
import java.sql.DriverManager;

/**
 *
 * @author Son Duong
 */
public class DBHelper implements Serializable {

    public static Connection makeConnection() throws ClassNotFoundException, SQLException {

        String username = "root";  // MySQL username
        String password = "VoidIs0?";  // MySQL password
        String url = "jdbc:mysql://localhost:3306/coffee_shop_iter1";  // MySQL URL

        // Load the MySQL JDBC Driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish the connection
        return DriverManager.getConnection(url, username, password);
    }
}
