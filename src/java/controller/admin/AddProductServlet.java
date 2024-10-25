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
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import models.Attribute;
import models.Product;
import org.json.JSONObject;

@WebServlet(name = "AddProductServlet", urlPatterns = {"/admin/addproduct"})
@MultipartConfig // Needed for handling file uploads

public class AddProductServlet extends HttpServlet {

    private static final String THUMBNAIL_DIR = "img/thumbnail";
    private static final String DETAIL_DIR = "img/detail";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String name = getFormField(request.getPart("name"));
            String category = getFormField(request.getPart("category"));
            String description = getFormField(request.getPart("description"));
            // Handle file upload
            String applicationPath = request.getServletContext().getRealPath("");
            String thumbnailFilePath = applicationPath + File.separator + THUMBNAIL_DIR;
            String detailFilePath = applicationPath + File.separator + DETAIL_DIR;
            //For thumbnail
            Part filePart;
            String fileName;
            filePart = request.getPart("thumbnail");
            fileName = UUID.randomUUID().toString() + "_" + extractFileName(filePart);
            filePart.write(thumbnailFilePath + File.separator + fileName);
            // Save product
            ProductDAO pd = new ProductDAO();
            List<Category> cl = pd.getAllCategories();
            int categoryID = 1;
            for (Category c : cl) {
                if (c.getName().equals(category)) {
                    categoryID = c.getId();
                }
            }
            pd.addProduct(name, categoryID, fileName, description);
            Product newp = pd.getLastProduct();   //get last added product
            //Variants
            List<Attribute> al = pd.getAllAttributes();
            JSONObject jso;
            int oprice, sprice;
            int vamount = Integer.parseInt(getFormField(request.getPart("vamount")));
            for (int i = 1; i <= vamount; i++) {
                jso = new JSONObject();
                for (Attribute a : al) {
                    jso.put(a.getName(), getFormField(request.getPart(a.getName().toLowerCase() + i)));
                }
                oprice = Integer.parseInt(getFormField(request.getPart("oprice" + i)));
                sprice = Integer.parseInt(getFormField(request.getPart("sprice" + i)));
                pd.addProductVariant(newp.getId(), jso, oprice, sprice);
            }
            //For detail images
            int imgAmount = Integer.parseInt(getFormField(request.getPart("imgAmount")));
            List<String> imgs = new ArrayList<>();
            for (int i = 1; i <= imgAmount; i++) {
                filePart = request.getPart("img" + i); 
                fileName = UUID.randomUUID().toString() + "_" + extractFileName(filePart);
                imgs.add(fileName);
                filePart.write(detailFilePath + File.separator + fileName);
            }
            pd.addImgList(imgs, newp.getId());
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
