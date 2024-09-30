/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.google.gson.Gson;
import dao.ProductDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import models.Category;
import models.Product;
import models.ProductResponse;
import org.json.JSONObject;

/**
 *
 * @author Son Duong
 */
@WebServlet(name = "MenuServlet", urlPatterns = {"/menu"})
public class MenuServlet extends HttpServlet {

    private final int ROWS_PER_PAGE = 5;
    private int totalPage = 0;

    private List<Product> sortProductByPrice(List<Product> products, boolean isIncrease) {
        if (!isIncrease) {
            return products.stream()
                    .sorted((p1, p2) -> Integer.compare(p2.getPrice(), p1.getPrice()))
                    .collect(Collectors.toList());
        } else {
            return products.stream()
                    .sorted((p1, p2) -> Integer.compare(p1.getPrice(), p2.getPrice()))
                    .collect(Collectors.toList());
        }
    }

    private List<Product> sortProductByTotalSold(List<Product> products) {
        return products.stream()
                .sorted((p1, p2) -> Integer.compare(p2.getTotalSold(), p1.getTotalSold()))
                .collect(Collectors.toList());
    }

    private List<Product> sortProductByCreatedAt(List<Product> products) {
        return products.stream()
                .sorted((p1, p2) -> p2.getCreatedAt().compareTo(p1.getCreatedAt()))
                .collect(Collectors.toList());
    }

    private List<Product> getProductFollowingPage(List<Product> products, int page) {
        return products.stream()
                .skip((page - 1) * ROWS_PER_PAGE) // Bỏ qua 2 phần tử đầu
                .limit(ROWS_PER_PAGE) // Lấy 5 phần tử tiếp theo
                .collect(Collectors.toList());
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        ProductDAO pDao = new ProductDAO();
        String categoryId = request.getParameter("categoryId");
        String orderValue = request.getParameter("orderValue");
        int pageNum = Integer.parseInt(request.getParameter("pageNum"));
        List<Product> products = new ArrayList<>();
        ProductResponse productResponse = null;

        try {
            if (categoryId == "") {
                products = pDao.getAllProduct();
            } else {
                String[] listCategoryId = categoryId.split(",");
                for (String id : listCategoryId) {
                    products.addAll(pDao.getListProductByCategoryId(Integer.parseInt(id)));
                }
            }

            if (orderValue.equals("new")) {
                products = sortProductByCreatedAt(products);
            }
            if (orderValue.equals("sold")) {
                products = sortProductByTotalSold(products);
            }
            if (orderValue.equals("ASC")) {
                products = sortProductByPrice(products, true);
            }
            if (orderValue.equals("DESC")) {
                products = sortProductByPrice(products, false);
            }
            
            totalPage = (products.size()) % ROWS_PER_PAGE == 0 ? products.size() / ROWS_PER_PAGE : products.size() / ROWS_PER_PAGE + 1;

            products = getProductFollowingPage(products, pageNum);
            productResponse = new ProductResponse(products, pageNum, totalPage);

        } finally {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            PrintWriter out = response.getWriter();
            String jsonResponse = new Gson().toJson(productResponse);
            out.write(jsonResponse);
            out.flush();
        }

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.setAttribute("ORDERTYPE", "");

        ProductDAO pDao = new ProductDAO();
        List<Product> products = null;
        List<Category> categories = null;

        try {
            products = pDao.getAllProduct();
            totalPage = (products.size()) % ROWS_PER_PAGE == 0 ? products.size() / ROWS_PER_PAGE : products.size() / ROWS_PER_PAGE + 1;
            request.setAttribute("TOTALPAGE", totalPage);
            products = getProductFollowingPage(products, 1);
            request.setAttribute("PRODUCTS", products);

            categories = pDao.getAllCategories();
            request.setAttribute("CATEGORIES", categories);

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(MenuServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(MenuServlet.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            RequestDispatcher rq = request.getRequestDispatcher("menu.jsp");
            rq.forward(request, response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(MenuServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(MenuServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
