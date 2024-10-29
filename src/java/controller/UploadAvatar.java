/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import jakarta.servlet.RequestDispatcher;  
import java.io.IOException;
import jakarta.servlet.ServletException;  //catch exception
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.Base64;

/**
 *
 * @author Son Duong
 */
@WebServlet(name = "UploadAvatar", urlPatterns = {"/upload-avatar"})
public class UploadAvatar extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String base64Image = request.getParameter("croppedImage");
        
        if (base64Image != null && base64Image.startsWith("data:image/png;base64,")) {
            // Xóa phần tiền tố "data:image/png;base64,"
            base64Image = base64Image.replace("data:image/png;base64,", "");

            // Giải mã dữ liệu base64 thành mảng byte
            byte[] imageBytes = Base64.getDecoder().decode(base64Image);

            // Đường dẫn để lưu ảnh
            String path = getServletContext().getRealPath("/") + "img/avatar/avatar.png";

            // Tạo thư mục nếu chưa tồn tại
            File uploadsDir = new File(getServletContext().getRealPath("/") + "img/avatar");
            if (!uploadsDir.exists()) uploadsDir.mkdir();

            // Ghi dữ liệu byte vào tệp ảnh
            try (OutputStream outputStream = new FileOutputStream(new File(path))) {
                outputStream.write(imageBytes);
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
