<%-- 
    Document   : header
    Created on : Oct 8, 2024, 4:38:07 PM
    Author     : Son Duong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Header Static</title>
    </head>
    <body>
        <div id="header-static" class="w-full border-2 my-4 z-50">
            <div class="flex justify-between m-3 items-center">
                <a href="./home" class="text-4xl font-bold cursor-pointer">Caffeine</a>
                <div class="">
                    <ul class="flex flex-row">
                        <li class="mx-4 cursor-pointer hover:text-coffee-700 transition ease-in-out duration-200">
                            <a href="./home">Home</a>
                        </li>
                        <li class="mx-4 cursor-pointer hover:text-coffee-700 transition ease-in-out duration-200">
                            <a href="./menu">Menu</a>
                        </li>
                        <li class="mx-4 cursor-pointer hover:text-coffee-700 transition ease-in-out duration-200">
                            <a href="./about-us">About Us</a>
                        </li>
                        <li class="mx-4 cursor-pointer hover:text-coffee-700 transition ease-in-out duration-200">
                            <a href="./blog">Blog</a>
                        </li>
                    </ul>
                </div>
                <div class="flex flex-row">
                    <c:choose>
                        <c:when test="${user == null}">
                            <a href="./login" class="cursor-pointer hover:text-coffee-700 transition ease-in-out duration-200">Sign
                                in
                            </a>
                        </c:when>
                        <c:otherwise>
                            <div class="relative group">
                                <a href="./profile" class="w-8 h-8 rounded-full bg-white flex justify-center items-center cursor-pointer">
                                    <i class="fa-solid fa-user text-black"></i>
                                </a>
                                <div class="absolute min-w-40 bg-white right-0 z-20 rounded hidden group-hover:block animate-showDown
                                     ">
                                    <div class="text-black">
                                        <div class="text-xl bg-coffee-500 rounded-t">
                                            <h1 class="p-2"> ${user.getLastName()} ${user.getFirstName()}</h1>
                                        </div>
                                        <div class="p-2 hover:bg-coffee-200 rounded-b">
                                            <a href="./login" class="block w-full h-full">Logout</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                    <div id="hr" class="border-r-2 mx-4"></div>
                    <div class="cursor-pointer flex items-center hover:text-coffee-700 transition ease-in-out duration-200">
                        <i class="fa-solid fa-cart-shopping"></i>
                    </div>
                </div>
            </div>
        </div>
        <script>
            var pathName = window.location.pathname;
            if (pathName.includes("home")) {
                document.getElementById('header-static').classList.add('border-white', 'text-white');
                document.getElementById('hr').classList.add('border-white');
            } else {
                document.getElementById('header-static').classList.add('border-black', 'text-black');
                document.getElementById('hr').classList.add('border-black');
            }
        </script>
    </body>
</html>
