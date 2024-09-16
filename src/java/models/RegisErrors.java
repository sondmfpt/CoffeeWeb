/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author Son Duong
 */
public class RegisErrors {
    String dupplicatedUsername;
    String notFormatUsername;
    String notFormatPassword;

    public RegisErrors() {
    }

    public RegisErrors(String dupplicatedUsername, String notFormatUsername, String notFormatPassword) {
        this.dupplicatedUsername = dupplicatedUsername;
        this.notFormatUsername = notFormatUsername;
        this.notFormatPassword = notFormatPassword;
    }

    public void setDupplicatedUsername(String dupplicatedUsername) {
        this.dupplicatedUsername = dupplicatedUsername;
    }

    public void setNotFormatUsername(String notFormatUsername) {
        this.notFormatUsername = notFormatUsername;
    }

    public void setNotFormatPassword(String notFormatPassword) {
        this.notFormatPassword = notFormatPassword;
    }

    public String getDupplicatedUsername() {
        return dupplicatedUsername;
    }

    public String getNotFormatUsername() {
        return notFormatUsername;
    }

    public String getNotFormatPassword() {
        return notFormatPassword;
    }
    
    
}
