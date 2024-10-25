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
import java.util.Date;
import java.util.List;
import models.Category;
import models.Product;
import models.ProductVariant;
import models.Trend;
import models.Attribute;
import org.json.JSONObject;

public class ProductDAO {

    public List<Product> getAllPublicProducts() throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<Product> products = new ArrayList<>();
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT p.*, c.category_name FROM products p "
                        + "JOIN categories c ON p.category_id = c.id "
                        + "WHERE p.status = 1";
                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String productName = rs.getString("product_name");
                    String categoryName = rs.getString("category_name");
                    String thumbnailUrl = rs.getString("thumbnail_url");
                    int price = rs.getInt("price");
                    int totalSold = rs.getInt("total_sold");
                    String description = rs.getString("description");
                    Date createdAt = rs.getDate("created_at");
                    products.add(new Product(id, productName, categoryName, thumbnailUrl, price, totalSold, description, createdAt));
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
    
        public List<Product> getAllProducts() throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<Product> products = new ArrayList<>();
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT p.*, c.category_name FROM products p "
                        + "JOIN categories c ON p.category_id = c.id ";
                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String productName = rs.getString("product_name");
                    String categoryName = rs.getString("category_name");
                    String thumbnailUrl = rs.getString("thumbnail_url");
                    int price = rs.getInt("price");
                    int totalSold = rs.getInt("total_sold");
                    String description = rs.getString("description");
                    boolean isPublic = (rs.getBoolean("status"));
                    Date createdAt = rs.getDate("created_at");
                    products.add(new Product(id, productName, categoryName, thumbnailUrl, price, totalSold, description, isPublic, createdAt));
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

    public List<Category> getAllCategories() throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<Category> categories = new ArrayList<>();
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT * FROM categories";
                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String name = rs.getString("category_name");
                    categories.add(new Category(id, name));
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
            return categories;
        }
    }

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
                    int price = rs.getInt("price");
                    int totalSold = rs.getInt("total_sold");
                    String description = rs.getString("description");
                    boolean isPublic = rs.getBoolean("status");
                    Date createdAt = rs.getDate("created_at");
                    product = new Product(id, productName, categoryName, thumbnailUrl, price, totalSold, description, isPublic, createdAt);
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
                        + "WHERE c.id = ? AND p.status = 1";
                stm = con.prepareStatement(sql);
                stm.setInt(1, categoryId);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String productName = rs.getString("product_name");
                    String categoryName = rs.getString("category_name");
                    String thumbnailUrl = rs.getString("thumbnail_url");
                    int price = rs.getInt("price");
                    int totalSold = rs.getInt("total_sold");
                    String description = rs.getString("description");
                    Date createdAt = rs.getDate("created_at");
                    products.add(new Product(id, productName, categoryName, thumbnailUrl, price, totalSold, description, createdAt));
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

    public List<Product> getProductWithPagination(int page) throws ClassNotFoundException {
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Connection con = null;
        List<Product> products = new ArrayList<>();
        int ROWS_PER_PAGE = 5;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                // Tính toán OFFSET để lấy số lượng sinh viên cho trang hiện tại
                int offset = (page - 1) * ROWS_PER_PAGE;

                String sql = "SELECT p.*, c.category_name FROM products p "
                        + "JOIN categories c ON p.category_id = c.id "
                        + "LIMIT ?, ?";
                pstmt = con.prepareStatement(sql);
                pstmt.setInt(1, offset);
                pstmt.setInt(2, ROWS_PER_PAGE);
                rs = pstmt.executeQuery();

                while (rs.next()) {
                    int id = rs.getInt("id");
                    String productName = rs.getString("product_name");
                    String categoryName = rs.getString("category_name");
                    String thumbnailUrl = rs.getString("thumbnail_url");
                    int price = rs.getInt("price");
                    int totalSold = rs.getInt("total_sold");
                    String description = rs.getString("description");
                    Date createdAt = rs.getDate("created_at");

                    products.add(new Product(id, productName, categoryName, thumbnailUrl, price, totalSold, description, createdAt));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (pstmt != null) {
                    pstmt.close();
                }

            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return products;
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
                        + "WHERE product_id = ? AND status = 1";
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

    public void editProduct(String productName, int categoryId, String thumbnailUrl, int price, String description, int id) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "UPDATE products "
                        + "SET product_name = ?, "
                        + "category_id = ?, "
                        + "thumbnail_url = ?, "
                        + "price = ?, "
                        + "description = ? "
                        + "WHERE id = ?;";
                stm = con.prepareStatement(sql);
                stm.setString(1, productName);
                stm.setInt(2, categoryId);
                stm.setString(3, thumbnailUrl);
                stm.setInt(4, price);
                stm.setString(5, description);
                stm.setInt(6, id);
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
                String sql = "SELECT * FROM products WHERE status = 1 ORDER BY total_sold DESC LIMIT 4";
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

    public List<Attribute> getAllAttributes() throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<Attribute> attributes = new ArrayList<>();
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT * FROM product_attributes";
                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();
                Attribute attribute;
                while (rs.next()) {
                    attribute = new Attribute();
                    attribute.setName(rs.getString("product_attributes_name"));
                    attributes.add(attribute);
                }
                for (Attribute a : attributes) {
                    sql = "SELECT * FROM product_attributes pa JOIN attribute_values av ON pa.id = av.attribute_id WHERE product_attributes_name = ?";
                    stm = con.prepareStatement(sql);
                    stm.setString(1, a.getName());
                    rs = stm.executeQuery();
                    List<String> values = new ArrayList();
                    while (rs.next()) {
                        values.add(rs.getString("attribute_value"));
                    }
                    a.setValues(values);
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
            return attributes;
        }
    }

    public Product getLastProduct() throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        Product product = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT p.id as product_id, p.*, c.category_name FROM products p "
                        + "JOIN categories c ON p.category_id = c.id "
                        + "ORDER BY p.id DESC "
                        + "LIMIT 1";
                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();
                if (rs.next()) {
                    int id = rs.getInt("product_id");
                    String productName = rs.getString("product_name");
                    String categoryName = rs.getString("category_name");
                    String thumbnailUrl = rs.getString("thumbnail_url");
                    int price = rs.getInt("price");
                    int totalSold = rs.getInt("total_sold");
                    String description = rs.getString("description");
                    Date createdAt = rs.getDate("created_at");
                    product = new Product(id, productName, categoryName, thumbnailUrl, price, totalSold, description, createdAt);
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

    public void addImgList(List<String> imgs, int id) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                for (String img : imgs) {
                    String sql = "INSERT INTO list_product_img (product_id, img_url) "
                            + "VALUES (?, ?)";
                    stm = con.prepareStatement(sql);
                    stm.setInt(1, id);
                    stm.setString(2, img);
                    stm.executeUpdate();
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
    
    public List<ProductVariant> getAllVariantsByProductId(int productId) throws ClassNotFoundException, SQLException {
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
                    boolean isPublic = rs.getBoolean("status");
                    variants.add(new ProductVariant(id, productId, attribute, originPrice, salePrice, isPublic));
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
    
    public List<String> getAllImgsWithProductId(int productId) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<String> imgs = new ArrayList<>();
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT img_url FROM list_product_img "
                        + "WHERE product_id = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, productId);
                rs = stm.executeQuery();
                while (rs.next()) {
                    imgs.add(rs.getString("img_url"));
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
            return imgs;
        }
    }
    
}
