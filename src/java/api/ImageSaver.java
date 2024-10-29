/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package api;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Base64;

/**
 *
 * @author Son Duong
 * This program save upload image
 */
public class ImageSaver {
    public static void saveImage(String base64Image, String path) throws IOException{
        
        if (base64Image != null && base64Image.startsWith("data:image/png;base64,")) {
            // Xóa phần tiền tố "data:image/png;base64,"
            base64Image = base64Image.replace("data:image/png;base64,", "");

            // Giải mã dữ liệu base64 thành mảng byte
            byte[] imageBytes = Base64.getDecoder().decode(base64Image);

            // Ghi dữ liệu byte vào tệp ảnh
            try (OutputStream outputStream = new FileOutputStream(new File(path))) {
                outputStream.write(imageBytes);
            }
        }
    }
    
}
