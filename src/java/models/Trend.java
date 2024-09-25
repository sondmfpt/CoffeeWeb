/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Son Duong
 */
public class Trend {

    private int id;
    private String title;
    private String subTitle;
    List<Pair<Product, String>> productTrend;

    public Trend() {
        productTrend = new ArrayList<>();
    }

    public Trend(int id, String title, String subTitle) {
        this.id = id;
        this.title = title;
        this.subTitle = subTitle;
        productTrend = new ArrayList<>();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getSubTitle() {
        return subTitle;
    }

    public void setSubTitle(String subTitle) {
        this.subTitle = subTitle;
    }

    public List<Pair<Product, String>> getProductTrend() {
        return productTrend;
    }

    public void addProduct(Product p, String brief) {
        this.productTrend.add(new Pair<>(p, brief));
    }

    public List<Pair<Product, String>> getAllProduct() {
        return this.productTrend;
    }

}
