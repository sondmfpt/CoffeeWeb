/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.google.gson.Gson;  // to convert object to json string
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
import java.sql.SQLException;  //catch exception
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;  // to use stream to filter and order product list
import models.Category;
import models.Product;
import models.ProductResponse;  // product that response to front-end

/**
 *
 * @author Son Duong This program will set up and display list items
 */
@WebServlet(name = "MenuServlet", urlPatterns = {"/menu"})
public class MenuServlet extends HttpServlet {

    //set default number of product in a page
    private static int ROWS_PER_PAGE = 12;
    private int totalPage = 0;

    //sort product by price (asc and desc)
    private List<Product> sortProductByPrice(List<Product> products, boolean isIncrease) {
        //if order by decrease -> reverse list
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

    //sort product by total sold (decrease)
    private List<Product> sortProductByTotalSold(List<Product> products) {
        return products.stream()
                .sorted((p1, p2) -> Integer.compare(p2.getTotalSold(), p1.getTotalSold()))
                .collect(Collectors.toList());
    }

    //sort product by date public
    private List<Product> sortProductByCreatedAt(List<Product> products) {
        return products.stream()
                .sorted((p1, p2) -> p2.getCreatedAt().compareTo(p1.getCreatedAt()))
                .collect(Collectors.toList());
    }

    //pagination
    private List<Product> getProductFollowingPage(List<Product> products, int page) {
        return products.stream()
                .skip((page - 1) * ROWS_PER_PAGE) // Bỏ qua 2 phần tử đầu
                .limit(ROWS_PER_PAGE) // Lấy 5 phần tử tiếp theo
                .collect(Collectors.toList());
    }

    //get product by searching
    private List<Product> getProductBySearching(List<Product> products, String searchValue) {
        if (searchValue == null || searchValue.equals("")) {
            return products;
        }

        String lowerCaseSearchValue = searchValue.toLowerCase();

        return products.stream()
                .filter(pro -> pro.getName().toLowerCase().contains(lowerCaseSearchValue))
                .collect(Collectors.toList());
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        ProductDAO pDao = new ProductDAO();
        //get information product and order option, number product in page
        String categoryId = request.getParameter("categoryId");
        String orderValue = request.getParameter("orderValue");
        int pageNum = Integer.parseInt(request.getParameter("pageNum"));
        int numPerPage = Integer.parseInt(request.getParameter("numPerPage"));
        String searchValue = request.getParameter("searchValue");
//        list product would be show
        List<Product> products = new ArrayList<>();
        ProductResponse productResponse = null;
        int totalNumberProduct = 0;
        try {
            if (categoryId == "") {
                products = pDao.getAllPublicProducts(); //get all product
            } else {
                String[] listCategoryId = categoryId.split(",");
                for (String id : listCategoryId) {
                    products.addAll(pDao.getListProductByCategoryId(Integer.parseInt(id))); //get product by category
                }
            }
            products = getProductBySearching(products, searchValue); //get product by searching
            if (products.size() == 0) {
                pageNum = 0;
                totalPage = 0;
            } else {

                //calculate total page by number of products and number product per page
                if (numPerPage != ROWS_PER_PAGE) {
                    ROWS_PER_PAGE = numPerPage;
                } else {
                    if (products.size() < ROWS_PER_PAGE) {
                        ROWS_PER_PAGE = products.size();
                    } else if (products.size() >= 12 && numPerPage < 4) {
                        ROWS_PER_PAGE = 12;
                    }
                }

                totalNumberProduct = products.size();

                //sort by order option
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
            }
//            System.out.println(ROWS_PER_PAGE);
            productResponse = new ProductResponse(products, pageNum, totalPage);
            productResponse.setTotalNumberProduct(totalNumberProduct);
            productResponse.setRowPerPage(ROWS_PER_PAGE);

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

        ROWS_PER_PAGE = 12;

        ProductDAO pDao = new ProductDAO();
        List<Product> products = null;
        List<Category> categories = null;

        //set information product to show
        List<String> information = new ArrayList<>(Arrays.asList("Image", "Name", "Price", "Description", "Sold", "Date"));

        try {
            products = pDao.getAllPublicProducts();

            //calculate total page
            totalPage = (products.size()) % ROWS_PER_PAGE == 0 ? products.size() / ROWS_PER_PAGE : products.size() / ROWS_PER_PAGE + 1;

            //set attribute to view
            request.setAttribute("TOTALPAGE", totalPage);
            products = getProductFollowingPage(products, 1);
            request.setAttribute("PRODUCTS", products);

            categories = pDao.getAllCategories();
            request.setAttribute("CATEGORIES", categories);

            request.setAttribute("INFORMATION", information);

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
