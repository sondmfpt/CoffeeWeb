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
import java.util.UUID;

@WebServlet(name = "EditProductServlet", urlPatterns = {"/admin/editproduct"})
@MultipartConfig // Needed for handling file uploads

public class EditProductServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "img/thumbnail";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String idStr = request.getParameter("id");
            int id = Integer.parseInt(idStr);
            String name = getFormField(request.getPart("name"));
            String category = getFormField(request.getPart("category"));
            String priceStr = getFormField(request.getPart("price"));
            int price = Integer.parseInt(priceStr);
            String description = getFormField(request.getPart("description"));
            // Handle file upload
            String fileName;
            if (request.getPart("thumbnail") == null) {
                fileName = request.getParameter("thumbnailURL");
            } else {
                String applicationPath = request.getServletContext().getRealPath("");
                String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;
                File uploadDir = new File(uploadFilePath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                Part filePart = request.getPart("thumbnail");
                fileName = UUID.randomUUID().toString() + "_" + extractFileName(filePart);
                String path = uploadFilePath + File.separator + fileName;
                filePart.write(path);
            }
            ProductDAO pd = new ProductDAO();
            List<Category> cl = pd.getAllCategories();
            int categoryID = 1;
            for (Category c : cl) {
                if (c.getName().equals(category)) {
                    categoryID = c.getId();
                }
            }
            pd.editProduct(name, categoryID, fileName, price, description, id);

            // Redirect to product listing
            response.sendRedirect("product?id=" + id);
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
