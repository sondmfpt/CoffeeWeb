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
import models.Product;
import models.Category;
/**
/**
 *
 * @author MyPC
 */
@WebServlet(name = "ProductDetailServlet", urlPatterns = {"/admin/product"})
public class ProductDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            ProductDAO pd = new ProductDAO();
            Product p = pd.getProduct(id);
            List<Category> cl = pd.getAllCategories();
            request.setAttribute("product", p);
            request.setAttribute("category_list", cl);
            request.getRequestDispatcher("admin_productDetail.jsp").forward(request, response);
        } catch (ClassNotFoundException | SQLException | NumberFormatException e) {
            e.printStackTrace();
        }
    }
}
