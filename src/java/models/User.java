/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.util.Date;

/**
 *
 * @author Son Duong
 */
public class User {
    private int id;
    private String firstName;
    private String lastName;
    private String gender;
    private String phone;
    private Date date;
    private String email;
    private String role;

    public User() {
    }

    public User(int id, String firstName, String lastName, String gender, String phone, Date date, String email, String role) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.gender = gender;
        this.phone = phone;
        this.date = date;
        this.email = email;
        this.role = role;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }


    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    
    
    
}