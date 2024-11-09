/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package api;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import org.json.JSONObject;

/**
 *
 * @author Son Duong
 */
public class SmsSender_Code {
    
    /**
     * @param args the command line arguments
     * This program send code to user's phone number
     * Using Infobip API
     */
//    private static final String API_BASE_URL = "https://1gv88d.api.infobip.com/sms/2/text/advanced"; // Infobip base url
//    private static final String API_KEY = "c18eeb86edf5a7b33e4d261a6bb29090-9c023f83-9fb6-469f-9289-956cc9add2db";  // Infobip API key

    private static final String API_BASE_URL = "https://z3v4n6.api.infobip.com/sms/2/text/advanced";
    private static final String API_KEY = "a7330629946a3fc9df06bb0ef75ef30e-fc1bcf20-d9f8-4752-8db5-e0a9216b833b";

    public static void sendSms(String from, String to, String code) {
        try {
            // Create the request body
            JSONObject message = new JSONObject();
            message.put("from", from);
            message.put("destinations", new JSONObject[]{
                new JSONObject().put("to", to)
            });
            String messageText = "Mã của bạn là: " + code;
            message.put("text", messageText);

            JSONObject requestBody = new JSONObject();
            requestBody.put("messages", new JSONObject[]{message});

            // Build the request
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(API_BASE_URL))
                    .header("Authorization", "App " + API_KEY)
                    .header("Content-Type", "application/json")
                    .POST(HttpRequest.BodyPublishers.ofString(requestBody.toString()))
                    .build();

            // Send the request
            HttpClient client = HttpClient.newHttpClient();
            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

            // Print the response
            System.out.println("Response code: " + response.statusCode());
            System.out.println("Response body: " + response.body());

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
