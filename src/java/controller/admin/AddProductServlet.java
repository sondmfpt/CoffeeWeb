package controller.admin;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import dao.ProductDAO;
import jakarta.servlet.annotation.WebServlet;
import models.Category;

import java.io.File;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "AddProductServlet", urlPatterns = {"/admin/addproduct"})
@MultipartConfig // Needed for handling file uploads

public class AddProductServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "img/thumbnail";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String name = getFormField(request.getPart("name"));
            String category = getFormField(request.getPart("category"));
            String priceStr = getFormField(request.getPart("price"));
            int price = Integer.parseInt(priceStr); 
            String description = getFormField(request.getPart("description"));
            // Handle file upload
            String applicationPath = request.getServletContext().getRealPath("");
            String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadFilePath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            Part filePart = request.getPart("thumbnail"); 
            String fileName = extractFileName(filePart);
            filePart.write(uploadFilePath + File.separator + fileName);

            // Save product
            ProductDAO pd = new ProductDAO();
            List<Category> cl = pd.getAllCategories();
            int categoryID = 1;
            for (Category c : cl) {
                if (c.getName().equals(category))
                    categoryID = c.getId();
            }
            pd.addProduct(name, categoryID, fileName, price, description);

            // Redirect to product listing
            response.sendRedirect("products");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    // Helper method to extract form field values from Part
    private String getFormField(Part part) throws IOException {
        byte[] data = part.getInputStream().readAllBytes();
        return new String(data, "UTF-8");
    }

    private String extractFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] items = contentDisposition.split(";");
        for (String item : items) {
            if (item.trim().startsWith("filename")) {
                return item.substring(item.indexOf('=') + 2, item.length() - 1);
            }
        }
        return "";
    }
}