/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
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
        String pathOfInformation = "WEB-INF/resources/shop-information.txt"; // Đường dẫn đến tệp của bạn
        String absolutePathInformation = getServletContext().getRealPath(pathOfInformation);
        String infor = "";
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(absolutePathInformation), "UTF-8"))) {
            String line;
            while ((line = reader.readLine()) != null) {
                infor += line;
            }
        } catch (IOException e) {
            e.printStackTrace(); // Xử lý ngoại lệ
        }
//        System.out.println(infor);

        //product data
        String filePathProducts = "WEB-INF/resources/testProducts2.json";
        String absolutePathProducts = getServletContext().getRealPath(filePathProducts);
//        System.out.println(absolutePathProducts);
        Gson gson = new Gson();
        String jsonString = "";
        try (FileReader reader = new FileReader(absolutePathProducts)) {
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

        String jsonInputString = "{\"model\": \"meta-llama/Llama-3-8b-chat-hf\", \"messages\": ["
                + "{\"role\": \"system\", \"content\": \"You are a customer consultant for a website selling drinks.\"},"
                + "{\"role\": \"system\", \"content\": \"Here is some data of shop: " + info + ".\"},"
                + "{\"role\": \"system\", \"content\": \"Here is some data of products " + dataProduct + ".\"},"
                + "{\"role\": \"user\", \"content\": \"Your answer always must be only this format and not other ways (including greetings): {\\\"message1\\\": ..., \\\"products\\\": [productId1, productId2, ...], \\\"message2\\\": ...(if any)}\"},"
                + "{\"role\": \"user\", \"content\": \"message1 is required, products property can be empty and message2 is optional.\"},"
                + "{\"role\": \"user\", \"content\": \"If my question is not required listing product, then products property will be empty.\"},"
                + "{\"role\": \"user\", \"content\": \"If my question is Vietnamese, then answer me by Vietnamese, similar to other languages.\"},"
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
