/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package api;

import java.time.LocalDate;
import java.util.Date;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import models.User;

/**
 *
 * @author Son Duong
 */
public class EmailSender_ChangeUserInformation {

    public static void changeProfile(User before, User after) {

        final String from = "duongminhson1601@gmail.com";
        final String passwordEmail = "govc qfcq hsbl igjc";
        final String recipient = before.getEmail();

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
                return new PasswordAuthentication(from, passwordEmail);
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
                    + "<h1>Chúng tôi đã thay đổi một số thông tin tài khoản của bạn</h1>"
                    + "<h2>Đây là thông tin hiện tại của bạn:</h2>"
                    + "<p>ID: " + before.getId() + "</p>"
                    + "<p>Tên đăng nhập: " + before.getUsername() + "</p>"
                    + (before.getPassword().equals(after.getPassword()) ? "" : ("<p>Mật khẩu: " + before.getPassword() + " -> " + after.getPassword() + "</p>"))
                    + (before.getFirstName().equals(after.getFirstName()) ? "" : ("<p>Tên: " + before.getFirstName() + " -> " + after.getFirstName() + "</p>"))
                    + (before.getLastName().equals(after.getLastName()) ? "" : ("<p>Họ: " + before.getLastName() + " -> " + after.getLastName() + "</p>"))
                    + (before.getEmail().equals(after.getEmail()) ? "" : ("<p>Email: " + before.getEmail() + " -> " + after.getEmail() + "</p>"))
                    + (before.getPhone().equals(after.getPhone()) ? "" : ("<p>Số điện thoại: " + before.getPhone() + " -> " + after.getPhone() + "</p>"))
                    + (before.getGender().equals(after.getGender()) ? "" : ("<p>Giới tính: " + before.getGender() + " -> " + after.getGender() + "</p>"))
                    + (before.getDate().equals(after.getDate()) ? "" : ("<p>Ngày sinh: " + before.getDate() + " -> " + after.getDate() + "</p>"))
                    + (before.getRole().equals(after.getRole()) ? "" : ("<p>Vai trò: " + before.getRole() + " -> " + after.getRole() + "</p>"))
                    + (before.isActive() == after.isActive() ? "" : ("<p>Trạng thái: " + (before.isActive() ? "Active" : "Deactive") + " -> " + (after.isActive() ? "Active" : "Deactive") + "</p>"))
                    + "<body>"
                    + "<html>", "text/html;charset=UTF-8");
            Transport.send(msg);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
