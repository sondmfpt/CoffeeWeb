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
public class ProductResponse {
    private List<Product> products;
    private int totalPage;
    private int prePage;

    public ProductResponse() {
        products = new ArrayList<>();
    }

    public ProductResponse(List<Product> products, int prePage, int totalPage) {
        this.products = products;
        this.totalPage = totalPage;
        this.prePage = prePage;
    }

    public List<Product> getProducts() {
        return products;
    }

    public void setProducts(List<Product> products) {
        this.products = products;
    }

    public int getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }

    public int getPrePage() {
        return prePage;
    }

    public void setPrePage(int prePage) {
        this.prePage = prePage;
    }
    
    
}
