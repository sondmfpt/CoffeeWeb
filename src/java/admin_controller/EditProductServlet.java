package admin_controller;

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
import models.ProductVariant;
import org.json.JSONObject;

@WebServlet(name = "EditProductServlet", urlPatterns = {"/admin-edit-product"})
@MultipartConfig // Needed for handling file uploads

public class EditProductServlet extends HttpServlet {

    private static final String THUMBNAIL_DIR = "img/thumbnail";
    private static final String DETAIL_DIR = "img/detail";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String idStr = request.getParameter("id");
            int id = Integer.parseInt(idStr);
            String name = getFormField(request.getPart("name"));
            String category = getFormField(request.getPart("category"));
            String description = getFormField(request.getPart("description"));
            boolean isPublic = getFormField(request.getPart("status")).equals("public");
            // Handle file upload
            String applicationPath = request.getServletContext().getRealPath("");
            String fileName;
            Part filePart;
            if (!getFormField(request.getPart("thumbnailURL")).isBlank()) {
                fileName = getFormField(request.getPart("thumbnailURL"));
            } else {
                String thumbnailFilePath = applicationPath + File.separator + THUMBNAIL_DIR;
                filePart = request.getPart("thumbnail");
                fileName = UUID.randomUUID().toString() + "_" + extractFileName(filePart);
                String path = thumbnailFilePath + File.separator + fileName;
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
            pd.editProduct(name, categoryID, fileName, description, isPublic, id);
            //Update variants
            int originPrice, salePrice;
            boolean isVariantPublic;
            List<ProductVariant>vl = pd.getAllVariantsByProductId(id);
            for (ProductVariant v : vl) {
                originPrice = Integer.parseInt(getFormField(request.getPart(v.getId() + "-origin-price")));
                salePrice = Integer.parseInt(getFormField(request.getPart(v.getId() + "-sale-price")));
                isVariantPublic = getFormField(request.getPart(v.getId() + "-status")).equals("public");
                pd.updateVariant(originPrice, salePrice, isVariantPublic, v.getId());
            }
            //Add new variants
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
                pd.addProductVariant(id, jso, oprice, sprice);
            }
           //For detail images
           //Delete all old one
           List<String> imgList = pd.getAllImgsWithProductId(id);
           for (String img : imgList) {
               File oldImg = new File("img/detail/" + img);
               oldImg.deleteOnExit();
           }
           pd.deleteDetailImgWithId(id);    //Delete in database
           //Add new one
           String detailFilePath = applicationPath + File.separator + DETAIL_DIR;
           int imgAmount = Integer.parseInt(getFormField(request.getPart("imgAmount")));
            List<String> imgs = new ArrayList<>();
            for (int i = 1; i <= imgAmount; i++) {
                if (request.getPart("detail" + i) != null) {
                    fileName = getFormField(request.getPart("detail" + i));
                } else {
                    filePart = request.getPart("img" + i); 
                    fileName = UUID.randomUUID().toString() + "_" + extractFileName(filePart);
                    filePart.write(detailFilePath + File.separator + fileName);
                }
                imgs.add(fileName);
                
            }
            pd.addImgList(imgs, id);
           // Redirect to product listing
            response.sendRedirect("admin-product?id=" + id);
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
