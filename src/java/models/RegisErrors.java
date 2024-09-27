/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Son Duong
 */
public class RegisErrors {
    String dupplicatedUsername;
    String notFormatUsername;
    List<String> notFormatPassword;
    String dupplicatedEmail;

    public RegisErrors() {
        notFormatPassword = new ArrayList<>();
    }

    public RegisErrors(String dupplicatedUsername, String notFormatUsername, List<String> notFormatPassword) {
        this.dupplicatedUsername = dupplicatedUsername;
        this.notFormatUsername = notFormatUsername;
        this.notFormatPassword = notFormatPassword;
    }

    public String getDupplicatedEmail() {
        return dupplicatedEmail;
    }

    public void setDupplicatedEmail(String dupplicatedEmail) {
        this.dupplicatedEmail = dupplicatedEmail;
    }
    

    public String getDupplicatedUsername() {
        return dupplicatedUsername;
    }

    public void setDupplicatedUsername(String dupplicatedUsername) {
        this.dupplicatedUsername = dupplicatedUsername;
    }

    public String getNotFormatUsername() {
        return notFormatUsername;
    }

    public void setNotFormatUsername(String notFormatUsername) {
        this.notFormatUsername = notFormatUsername;
    }

    public List<String> getNotFormatPassword() {
        return notFormatPassword;
    }

    public void setNotFormatPassword(List<String> notFormatPassword) {
        this.notFormatPassword = notFormatPassword;
    }

    
    
}
