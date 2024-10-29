<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "models.User" %>
<%@page import = "java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
    <%
        User u = (User) session.getAttribute("USER");
    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update - <%if (u != null) {%><%=u.getLastName()%><%}else{%>None<%}%></title>
        <link href="css/mystyle.css" rel="stylesheet">
    </head>
    <body>
        <% if (u != null) { %>
        <form action="updateProfile" method="POST">
            <h1>Update Profile:</h1>
            <label for="firstName">First Name:</label><br>
            <input id="firstName" name="firstName" type="text" value="<%=u.getFirstName()%>" /><br>
            <label for="lastName">Last Name:</label><br>
            <input id="lastName" name="lastName" type="text" value="<%=u.getLastName()%>" /><br>
            <label>Gender:</label><br>
            <input id="maleChoice" name="gender" type="radio" value="Male" <%if (u.getGender().equals("Male")) {%> checked <%}%>/><label for="maleChoice" >Male</label><br>
            <input id="femaleChoice" name="gender" type="radio" value="Female" <%if (u.getGender().equals("Female")) {%> checked <%}%>/><label for="femaleChoice" >Female</label><br>
            <input id="otherChoice" name="gender" type="radio" value="Other" <%if (u.getGender().equals("Other")) {%> checked <%}%>/><label for="otherChoice" >Other</label><br>
            <label for="phone">Phone number:</label><br>
            <input id="phone" name="phone" type="tel" <%if (u.getPhone() !=  null && !u.getPhone().isBlank()) {%> value="<%=u.getPhone()%>" readonly <%}%>/><br>
            <%
                String dob = "";
                if (u.getDate() != null) {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    dob = sdf.format(u.getDate());
                }
            %>
            <label for="dob">Date of birth:</label><br>
            <input id="dob" name="dob" type="date" <%if (u.getDate() != null) {%> value="<%=dob%>" <%}%>/><br>
            <label for="email">Email:</label><br>
            <input id="email" name="email" type="email" <%if (u.getEmail() !=  null && !u.getEmail().isBlank()) {%> value="<%=u.getEmail()%>" readonly <%}%>/><br>
            <input type="submit" name="type" value ="Update"/>
            <input type="submit" name="type" value ="Cancel"/>
        </form>
        <%} else {%>
        <h1>User not found, please login</h1>
        <a href="login"><div class="btn btn-cyan">Login</div></a>
        <%}%>
    </body>
    
</html>
    
    
    
