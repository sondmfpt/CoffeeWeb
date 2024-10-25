<%-- 
    Document   : header-dynamic
    Created on : Oct 8, 2024, 4:48:00 PM
    Author     : Son Duong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Header Dynamic</title>
    </head>
    <body>
        <div id="navbar" class="font-serif bg-black w-full h-[12%] fixed z-50 text-white hidden animate-moveInDownFull">
            <div class="flex justify-around items-center h-full">
                <a href="./home" class="text-4xl text-white font-bold cursor-pointer">Caffeine</a>
                <div class="">
                    <ul class="flex flex-row">
                        <li class="mx-4 cursor-pointer hover:text-coffee-700"><a href="./home">Home</a></li>
                        <li class="mx-4 cursor-pointer hover:text-coffee-700"><a href="./menu">Menu</a></li>
                        <li class="mx-4 cursor-pointer hover:text-coffee-700"><a href="./about-us">About Us</a></li>
                        <li class="mx-4 cursor-pointer hover:text-coffee-700"><a href="./blog">Blog</a></li>
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
                                <div class="absolute min-w-40 bg-white right-0 z-20 rounded hidden group-hover:block animate-showDown">
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
                    <div class="border-r-2 border-white mx-4"></div>
                    <div class="cursor-pointer hover:text-coffee-700"><i class="fa-solid fa-cart-shopping"></i></div>
                </div>
            </div>
        </div>
        <script>
            window.onscroll = function () {
                toggleNavbar()
            };

            function toggleNavbar() {
                if (document.body.scrollTop > 50 || document.documentElement.scrollTop > 50) {
                    document.getElementById("navbar").classList.remove("hidden");
                    document.getElementById("navbar").classList.remove("z-[-1]");
                } else {
                    document.getElementById("navbar").classList.add("hidden");
                    document.getElementById("navbar").classList.add("z-[-1]");
                }
            }
        </script>
    </body>
</html>
