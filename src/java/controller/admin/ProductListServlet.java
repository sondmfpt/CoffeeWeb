/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dao.ProductDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import models.Attribute;
import models.Product;
import models.Category;
/**
 *
 * @author MyPC
 */
@WebServlet(name = "ProductListServlet", urlPatterns = {"/admin/products"})
public class ProductListServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            ProductDAO pd = new ProductDAO();
            List<Product> pl = pd.getAllProduct();
            List<Category> cl = pd.getAllCategories();
            List<Attribute> al = pd.getAllAttributes();
            request.setAttribute("product_list", pl);
            request.setAttribute("category_list", cl);
            request.setAttribute("attribute_list", al);
            request.getRequestDispatcher("admin_productList.jsp").forward(request, response);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

}
