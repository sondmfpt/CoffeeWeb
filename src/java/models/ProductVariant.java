/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import org.json.JSONObject;

/**
 *
 * @author Son Duong
 */
public class ProductVariant {
    private int id;
    private int product_id;
    private JSONObject attribute;
    private int originPrice;
    private int salePrice;
    private boolean isPublic;

    public ProductVariant() {
    }

    public ProductVariant(int id, int product_id, JSONObject attribute, int originPrice, int salePrice) {
        this.id = id;
        this.product_id = product_id;
        this.attribute = attribute;
        this.originPrice = originPrice;
        this.salePrice = salePrice;
    }
    
    public ProductVariant(int id, int product_id, JSONObject attribute, int originPrice, int salePrice, boolean isPublic) {
        this.id = id;
        this.product_id = product_id;
        this.attribute = attribute;
        this.originPrice = originPrice;
        this.salePrice = salePrice;
        this.isPublic = isPublic;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public JSONObject getAttribute() {
        return attribute;
    }

    public void setAttribute(JSONObject attribute) {
        this.attribute = attribute;
    }

    public int getOriginPrice() {
        return originPrice;
    }

    public void setOriginPrice(int originPrice) {
        this.originPrice = originPrice;
    }

    public int getSalePrice() {
        return salePrice;
    }

    public void setSalePrice(int salePrice) {
        this.salePrice = salePrice;
    }

    public boolean isPublic() {
        return isPublic;
    }
    
}
