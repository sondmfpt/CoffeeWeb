/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.util.ArrayList;
import java.util.Date;
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
    private int price;
    private int totalSold;
    private String description;
    private List<String> listImage;
    private boolean isPublic;
    private Date createdAt;

    public Product() {
        description = "";
        listImage = new ArrayList<>();
    }

    public Product(int id, String name, String category, String thumbnailUrl, int price, int totalSold, String description, Date createdAt) {
        this.id = id;
        this.name = name;
        this.category = category;
        this.thumbnailUrl = thumbnailUrl;
        this.price = price;
        this.totalSold = totalSold;
        this.description = description;
        this.createdAt = createdAt;
        this.listImage = new ArrayList<>();
    }
    
    public Product(int id, String name, String category, String thumbnailUrl, int price, int totalSold, String description, boolean isPublic, Date createdAt) {
        this.id = id;
        this.name = name;
        this.category = category;
        this.thumbnailUrl = thumbnailUrl;
        this.price = price;
        this.totalSold = totalSold;
        this.description = description;
        this.createdAt = createdAt;
        this.listImage = new ArrayList<>();
        this.isPublic = isPublic;
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

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public void addImage(String url){
        this.listImage.add(url);
    }
    
    public boolean isPublic() {
        return this.isPublic;
    }
    
    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Product other = (Product) obj;
        return this.id == other.id;
    }
    
    
}
