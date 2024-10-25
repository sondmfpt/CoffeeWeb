<%-- 
    Document   : failAuthorization
    Created on : Oct 22, 2024, 3:11:42 PM
    Author     : Son Duong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Fail Authorization</title>
        <link href="./output.css" rel="stylesheet">
    </head>
    <body>
        <div class="p-5">
            <h1 class="text-3xl font-bold pb-3">Bạn không có quyền truy cập vào trang web này</h1>
            <div class="flex gap-3">
                <a class="px-3 py-2 bg-coffee-500 hover:bg-coffee-200" href="./login">Login</a>
                <a class="px-3 py-2 bg-coffee-500 hover:bg-coffee-200" href="./home">Home</a>
            </div>
        </div>
    </body>
</html>
