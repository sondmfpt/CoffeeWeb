/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package api;

import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;

/**
 *
 * @author Son Duong
 */
public class VideoSaver {

    public static void saveVideo(Part filePart, String path, String fileName) throws IOException {
        File saveFile = new File(path, fileName);
        filePart.write(saveFile.getAbsolutePath());
    }
}
