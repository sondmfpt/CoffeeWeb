/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.util.List;

/**
 *
 * @author Son Duong
 */
public class UserResponse {
    private List<User> users;
    private int totalPage;

    public UserResponse() {
    }

    public UserResponse(List<User> users, int totalPage) {
        this.users = users;
        this.totalPage = totalPage;
    }
    
    
}
