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

    public int id;
    public String firstName;
    public String lastName;
    public String gender;
    public String phone;
    public Date dob;
    public String email;
    public String address;
    public String role;

    public User() {
    }

    public User(int userid, String firstName, String lastName, String email, String phone, String address, String role) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.role = role;
    }

    public User(int id, String firstName, String lastName, String gender, String phone, Date dob, String email, String address, String role) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.gender = gender;
        this.phone = phone;
        this.dob = dob;
        this.email = email;
        this.address = address;
        this.role = role;
    }

    public int getId() {
        return id;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public String getFullName() {
        return firstName + " " + lastName;
    }

    public String getGender() {
        return gender;
    }

    public String getPhone() {
        return phone;
    }

    public Date getDob() {
        return dob;
    }

    public String getEmail() {
        return email;
    }

    public String getAddress() {
        return address;
    }

    public String getRole() {
        return role;
    }

}
