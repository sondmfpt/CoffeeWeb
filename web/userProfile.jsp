<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "models.User" %>
<!DOCTYPE html>
<html>
    <%
        User u = (User) session.getAttribute("USER");
    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile - <%if (u != null) {%><%=u.getLastName()%><%}else{%>None<%}%></title>
        <link href="css/mystyle.css" rel="stylesheet">
    </head>
    <body>
        <% if (u != null) { %>
        <p>Full name: <%=u.getFirstName()%> <%=u.getLastName()%></p>
        <p>Gender: <%=u.getGender()%></p>
        <p>Phone Number: <%if (u.getPhone() == null) {%>none<%}else{%><%=u.getPhone()%><%}%></p>
        <p>Date of birth: <%if (u.getDate() == null) {%>none<%}else{%><%=u.getDate()%><%}%></p>
        <p>Email: <%if (u.getEmail() == null) {%>none<%}else{%><%=u.getEmail()%><%}%></p>
        <p>Address: <%if (u.getAddress() == null) {%>none<%}else{%><%=u.getAddress()%><%}%></p>
        <p>Role: <%=u.getRole()%></p>
        <a href="updateProfile" class=""><div class="btn btn-orange">Update Profile</div></a>
        <%} else {%>
        <h1>User not found, please login</h1>
        <a href="login"><div class="btn btn-cyan">Login</div></a>
        <%}%>
    </body>
    
</html>
    
    
    
