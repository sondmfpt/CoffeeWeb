/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package api;

import java.util.Date;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailSender_Code {
    public static void sendEmail(String recipient, String code) {
        
        final String from = "duongminhson1601@gmail.com";
        final String password = "govc qfcq hsbl igjc";


        // Get properties object
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", 587);
        props.put("mail.smtp.starttls.enable", "true");

        // get Session
        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        };

        Session session = Session.getInstance(props, auth);

        MimeMessage msg = new MimeMessage(session);
        try {
            msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
            msg.setFrom(from);
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipient, false));
            msg.setSubject("Test");
            msg.setSentDate(new Date());
            msg.setContent("<DOCTYPE html>\r\n"
                    + "<html>\r\n"
                    + "<body>\r\n"
                    + "\r\n"
                    + "<h2>Mã của bạn là: " + code + "</h2>"
                    + "<body>"
                    + "<html>", "text/html;charset=UTF-8");
            Transport.send(msg);
        }catch(Exception e){
            e.printStackTrace();
        }
    }
}
