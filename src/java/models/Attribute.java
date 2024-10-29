/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.util.List;

/**
 *
 * @author MyPC
 */
public class Attribute {
    private String name;
    private List<String> values;
    
    public Attribute() {
        
    }
    
    public Attribute(String name, List<String> values) {
        this.name = name;
        this.values = values;
    }
    
    public String getName() {
        return this.name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public List<String> getValues() {
        return this.values;
    }
    
    public void setValues(List<String> values) {
        this.values = values;
    }
    
}
