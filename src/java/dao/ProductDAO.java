/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import database.DBHelper;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import models.Product;
import models.ProductVariant;
import models.Trend;
import org.json.JSONObject;

public class ProductDAO {

    public Product getProduct(int id) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        Product product = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT p.*, c.category_name FROM products p "
                        + "JOIN categories c ON p.category_id = c.id "
                        + "WHERE p.id = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, id);
                rs = stm.executeQuery();
                if (rs.next()) {
                    String productName = rs.getString("product_name");
                    String categoryName = rs.getString("category_name");
                    String thumbnailUrl = rs.getString("thumbnail_url");
                    int totalSold = rs.getInt("total_sold");
                    String description = rs.getString("description");
                    product = new Product(id, productName, categoryName, thumbnailUrl, totalSold, description);
                }

            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
            return product;
        }
    }

    public void addListImgToProduct(Product product) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT * FROM list_product_img WHERE product_id = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, product.getId());
                rs = stm.executeQuery();
                while (rs.next()) {
                    product.addImage(rs.getString("img_url"));
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }

    public List<Product> getListProductByCategoryId(int categoryId) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<Product> products = new ArrayList<>();
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT p.*, c.category_name FROM products p "
                        + "JOIN categories c ON p.category_id = c.id "
                        + "WHERE c.id = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, categoryId);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String productName = rs.getString("product_name");
                    String categoryName = rs.getString("category_name");
                    String thumbnailUrl = rs.getString("thumbnail_url");
                    int totalSold = rs.getInt("total_sold");
                    String description = rs.getString("description");
                    products.add(new Product(id, productName, categoryName, thumbnailUrl, totalSold, description));
                }

            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
            return products;
        }
    }

    public List<ProductVariant> getListVariantByProductId(int productId) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<ProductVariant> variants = new ArrayList<>();
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT * FROM product_variants "
                        + "WHERE product_id = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, productId);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("id");
                    JSONObject attribute = new JSONObject(rs.getString("attribute"));
                    int originPrice = rs.getInt("origin_price");
                    int salePrice = rs.getInt("sale_price");
                    variants.add(new ProductVariant(id, productId, attribute, originPrice, salePrice));
                }

            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
            return variants;
        }
    }

    public void addProduct(String productName, int categoryId, String thumbnailUrl, String description) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "INSERT INTO products (product_name, category_id, thumbnail_url, description) "
                        + "VALUES (?, ?, ?, ?)";
                stm = con.prepareStatement(sql);
                stm.setString(1, productName);
                stm.setInt(2, categoryId);
                stm.setString(3, thumbnailUrl);
                stm.setString(4, description);
                stm.executeUpdate();

            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }

    public void addProductVariant(int productId, JSONObject attribute, int originPrice, int salePrice) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "INSERT INTO product_variants (product_id, attribute, origin_price, sale_price)"
                        + "VALUES (?, ?, ?, ?)";
                stm = con.prepareStatement(sql);
                stm.setInt(1, productId);
                stm.setString(2, attribute.toString());
                stm.setInt(3, originPrice);
                stm.setInt(4, salePrice);
                stm.executeUpdate();
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }

    public Trend getTrend(int id) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        Trend trend = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT t.*, tp.product_id, tp.brief_information, p.product_name, p.thumbnail_url "
                        + "FROM trends t "
                        + "JOIN trend_product tp ON tp.trend_id = t.id "
                        + "JOIN products p ON p.id = tp.product_id "
                        + "WHERE t.id = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, id);
                rs = stm.executeQuery();
                while (rs.next()) {
                    Product product = new Product();
                    product.setId(rs.getInt("product_id"));
                    product.setName(rs.getString("product_name"));
                    product.setThumbnailUrl(rs.getString("thumbnail_url"));

                    String title = rs.getString("title");
                    String subTitle = rs.getString("sub_title");
                    String brief = rs.getString("brief_information");
                    if (trend == null || id != trend.getId()) {
                        trend = new Trend(id, title, subTitle);
                    }
                    trend.addProduct(product, brief);

                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
            return trend;
        }
    }
    
    public List<Product> getBestSellingProduct() throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<Product> products = new ArrayList<>();
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT * FROM products ORDER BY total_sold DESC LIMIT 4";
                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    Product product = new Product();
                    product.setId(rs.getInt("id"));
                    product.setName(rs.getString("product_name"));
                    product.setThumbnailUrl(rs.getString("thumbnail_url"));
                    products.add(product);
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
            return products;
        }
    }
}