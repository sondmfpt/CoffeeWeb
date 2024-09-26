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
public class Product {
    private int id;
    private String name;
    private String category;
    private String thumbnailUrl;
    private String description;
    private int totalSold;
    private List<String> listImage;

    public Product() {
        description = "";
        listImage = new ArrayList<>();
    }

    public Product(int id, String name, String category, String thumbnailUrl, int totalSold, String description) {
        this.id = id;
        this.name = name;
        this.category = category;
        this.thumbnailUrl = thumbnailUrl;
        this.totalSold = totalSold;
        this.description = description;
        this.listImage = new ArrayList<>();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getThumbnailUrl() {
        return thumbnailUrl;
    }

    public void setThumbnailUrl(String thumbnailUrl) {
        this.thumbnailUrl = thumbnailUrl;
    }

    public int getTotalSold() {
        return totalSold;
    }

    public void setTotalSold(int totalSold) {
        this.totalSold = totalSold;
    }

    public List<String> getListImage() {
        return listImage;
    }

    public void setListImage(List<String> listImage) {
        this.listImage = listImage;
    }
    
    

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    
    public void addImage(String url){
        this.listImage.add(url);
    }
    
}