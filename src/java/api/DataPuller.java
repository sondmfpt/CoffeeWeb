/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package api;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import dao.ProductDAO;
import jakarta.servlet.ServletContext;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import models.Product;

/**
 *
 * @author Son Duong
 */
public class DataPuller {

    public static void pullData(ServletContext context) throws ClassNotFoundException, SQLException, IOException {
        ProductDAO pDao = new ProductDAO();
        List<Product> products = pDao.getAllProducts();
        // Chuyển đổi danh sách users thành JSON
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        String json = gson.toJson(products);

        // Ghi JSON vào file
        System.out.println(System.getProperty("user.dir"));
        String relativePath = "/WEB-INF/resources/testProducts2.json";
        String absolutePath = context.getRealPath(relativePath);
        try (FileWriter file = new FileWriter(absolutePath)) {
            file.write(json);
            file.flush();
        }
    }
}
