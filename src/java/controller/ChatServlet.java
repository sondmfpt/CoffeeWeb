/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.google.gson.Gson;
import com.opencsv.CSVReader;
import com.opencsv.exceptions.CsvValidationException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.JSONObject;

/**
 *
 * @author Son Duong
 */
@WebServlet(name = "ChatServlet", urlPatterns = {"/chat"})
public class ChatServlet extends HttpServlet {

    private static final String API_URL = "https://api.together.xyz/v1/chat/completions";
    private static final String API_KEY = "c7269dfe6f547f56cacebc752f99506b4ab516c2eca30bf93c908a709d8b5f32";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userMessage = request.getParameter("message");

        //information data
        String pathOfInformation = "D:\\Code\\Java\\JavaWeb\\CoffeeWeb\\src\\java\\dataSource\\shop-information.txt"; // Đường dẫn đến tệp của bạn
        String infor = "";
        try (BufferedReader reader = new BufferedReader(new FileReader(pathOfInformation))) {
            String line;
            while ((line = reader.readLine()) != null) {
                infor += line;
            }
        } catch (IOException e) {
            e.printStackTrace(); // Xử lý ngoại lệ
        }

        //product data
        String filePath = "D:\\Code\\Java\\JavaWeb\\CoffeeWeb\\src\\java\\dataSource\\products.csv";
        List<String[]> data = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            boolean hasData = false; // Biến kiểm tra có dữ liệu không
            while ((line = reader.readLine()) != null) {
                data.add(line.split(","));
                hasData = true; // Đã có ít nhất một dòng dữ liệu
            }
            if (!hasData) {
                System.out.println("Tệp không có dữ liệu.");
            }
        } catch (IOException e) {
            System.out.println("Có lỗi xảy ra khi đọc tệp: " + e.getMessage());
        }
        Gson gson = new Gson();
        String json = gson.toJson(data);

        
        // Gửi yêu cầu đến OpenAI API
        try {
            String jsonResponse = callOpenAIAPI(userMessage, infor, json);
            response.setContentType("application/json; charset=UTF-8");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(jsonResponse);
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Something went wrong");
            e.printStackTrace();
        }
    }

    private String callOpenAIAPI(String userMessage, String info, String dataProduct) throws IOException {
        URL url = new URL(API_URL);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Authorization", "Bearer " + API_KEY);
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setDoOutput(true);

        String jsonInputString = "{\"model\": \"meta-llama/Llama-3-8b-chat-hf\", \"messages\": ["
                + "{\"role\": \"system\", \"content\": \"Bạn là một trợ lý ảo bán hàng, hãy trả lời câu hỏi của khách hàng bằng tiếng Việt.\"},"
                + "{\"role\": \"system\", \"content\": \"Đây là dữ liệu các thông tin của shop: " + info + ".\"},"
                + "{\"role\": \"system\", \"content\": \"Khi mà có câu trả lời phải liệt kê ra các ý thì nhớ xuống dòng.\"},"
                + "{\"role\": \"user\", \"content\": \"" + userMessage + "\"}]}";

        try (OutputStream os = conn.getOutputStream()) {
            byte[] input = jsonInputString.getBytes("utf-8");
            os.write(input, 0, input.length);
        } catch (IOException e) {
            System.out.println("Error opening output stream: " + e.getMessage());
            throw e;
        }

        // Check response code to debug potential issues
        int responseCode = conn.getResponseCode();
        if (responseCode != HttpURLConnection.HTTP_OK) {
//            System.out.println("Error: Received HTTP code " + responseCode);
            throw new IOException("Failed to connect to API: " + responseCode);
        }

        // Đọc phản hồi từ API
        BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8));
        StringBuilder response = new StringBuilder();
        String inputLine;

        while ((inputLine = in.readLine()) != null) {
//            System.out.println("Response from API: " + inputLine);
            response.append(inputLine);
        }
        in.close();

        return response.toString();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("chatbot.jsp").forward(request, response);
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
