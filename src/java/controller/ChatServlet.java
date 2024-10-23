/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
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
import java.nio.file.Files;
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
        String filePath = "D:\\Code\\Java\\JavaWeb\\CoffeeWeb\\src\\java\\dataSource\\products.json";
        Gson gson = new Gson();
        String jsonString = "";
        try (FileReader reader = new FileReader(filePath)) {
            // Đọc file JSON và chuyển đổi thành JsonObject
            JsonArray jsonArray = gson.fromJson(reader, JsonArray.class);
            for (var jsonObject : jsonArray) {
                jsonString += gson.toJson(jsonObject);;
            }
            jsonString = jsonString.replace("\"", "\\\"");
        } catch (IOException e) {
            e.printStackTrace();
        }

        

        // Gửi yêu cầu đến OpenAI API
        try {
            String jsonResponse = callOpenAIAPI(userMessage, infor, jsonString);
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

        System.out.println(dataProduct);
        String data = "{\"id\":1,\"product_name\":\"Cappuccino\",\"category_id\":1,\"thumbnail_url\":\"licensed-image.jpg\",\"price\":30000,\"description\":\"Cappuccino is an espresso-based coffee drink that is traditionally prepared with steamed milk including a layer of milk foam. Variations of the drink involve the use of cream instead of milk, using non-dairy milk substitutes and flavoring with cocoa powder or cinnamon. \",\"total_sold\":502,\"status\":1,\"created_at\":\"2024-09-25 03:06:45\"}";
        String jsonInputString = "{\"model\": \"meta-llama/Llama-3-8b-chat-hf\", \"messages\": ["
                + "{\"role\": \"system\", \"content\": \"Bạn là một trợ lý ảo bán hàng, hãy trả lời câu hỏi của khách hàng bằng tiếng Việt.\"},"
                + "{\"role\": \"system\", \"content\": \"Đây là dữ liệu các thông tin của shop: " + info + ".\"},"
                + "{\"role\": \"system\", \"content\": \"Đây là dữ liệu các sản phẩm của shop: " + dataProduct + ".\"},"
                + "{\"role\": \"system\", \"content\": \"Khi người dùng hỏi về sản phẩm thì chỉ đưa ra id của sản phẩm đó thôi.\"},"
                + "{\"role\": \"system\", \"content\": \"Khi mà có câu trả lời phải liệt kê ra các ý thì nhớ xuống dòng.\"},"
                + "{\"role\": \"system\", \"content\": \"Trả lời ngắn gọn, súc tích, không trả lời thừa thãi.\"},"
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
