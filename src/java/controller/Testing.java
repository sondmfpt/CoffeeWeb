/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package controller;

import dao.UserDAO;
import java.sql.SQLException;
import models.User;
/**
 *
 * @author MyPC
 */
public class Testing {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws ClassNotFoundException, SQLException {
        UserDAO ud = new UserDAO();
        User u = ud.getUserWithId(1);
        System.out.println(u  != null);
    }
    
}
