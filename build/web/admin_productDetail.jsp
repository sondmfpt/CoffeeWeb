<%-- 
    Document   : admin_productDetail
    Created on : Oct 8, 2024, 8:34:09 PM
    Author     : Son Duong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
        <link href="./output.css" rel="stylesheet">
    </head>
    <body>
        <div class="bg-gray-100 h-screen">
            <div class="flex">
                <!--Navigation-->
                <%@ include file="./include/admin-navigation.jsp" %>

                <!-- Main Content -->
                <div class="flex-1 p-10">
                    <h1 class="text-3xl font-semibold">Welcome to the Dashboard</h1>
                    <p class="mt-4">This is your main dashboard content.</p>
                </div>
            </div>
        </div>
    </body>
</html>
