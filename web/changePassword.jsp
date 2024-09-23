<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "models.User" %>
<!DOCTYPE html>
<html>
    <%
        User u = (User) session.getAttribute("USER");
    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Change Password</title>
        <link href="css/mystyle.css" rel="stylesheet">
    </head>
    <body>
        <% if (u != null) { %>
        <form action="changePassword" method="POST">
            <h1>Change Password:</h1>
            <label for="oldPassword">Old Password:</label><br>
            <input id="oldPassword" name="oldPassword" type="password" value="" /><br>
            <label for="newPassword">New Password:</label><br>
            <input id="newPassword" name="newPassword" type="password" value="" /><br>
            <label for="confirmedPassword">Confirm Password:</label><br>
            <input id="confirmedPassword" name="confirmedPassword" type="password" value="" /><br>
            <input id="showPassword" type ="checkbox" onclick="displayPassword()"/><label for="showPassword">Show Password:</label><br>
            <p style="color:red;"><%=request.getAttribute("note")%></p><br>
            <input type="submit" name="type" value ="Change"/>
            <input type="submit" name="type" value ="Cancel"/>
            
        </form>
        <%} else {%>
        <h1>User not found, please login</h1>
        <a href="login"><div class="btn btn-cyan">Login</div></a>
        <%}%>
    </body>
    <script>
        function displayPassword() {
            var oldPassword = document.getElementById("oldPassword");
            var newPassword = document.getElementById("newPassword");
            var confirmedPassword = document.getElementById("confirmedPassword");
            if (oldPassword.type === "password") {
                oldPassword.type = "text";
                newPassword.type = "text";
                confirmedPassword.type = "text";
            } else {
                oldPassword.type = "password";
                newPassword.type = "password";
                confirmedPassword.type = "password";
            }
        }
    </script>
</html>



