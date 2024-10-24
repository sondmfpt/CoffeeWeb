/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package api;

/**
 *
 * @author Son Duong
 */
import java.util.Date;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

/*
*   This program send a confirm link to user's email
*   @param recipient is email of reciver
*   @param confirmationLink is link to confirm
*/
public class EmailSender_Link {
    public static void sendEmail(String recipient, String confirmationLink) {
        
        final String from = "duongminhson1601@gmail.com";  //email of sender
        final String password = "govc qfcq hsbl igjc";  //password


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

        //Set content for email
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
                    + "<h2>Bấm vào <a href="+ confirmationLink + ">link</a> này để xác thực tài khoản</h2>"
                    + "<body>"
                    + "<html>", "text/html;charset=UTF-8");
            Transport.send(msg);
        }catch(Exception e){
            e.printStackTrace();
        }
    }
}

