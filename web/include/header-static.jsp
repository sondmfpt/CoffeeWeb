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
        <div id="header-static" class="font-serif w-full border-2 my-4 z-50">
            <div class="flex justify-between items-center m-3">
                <!-- Logo -->
                <a href="./home" class="text-4xl font-bold cursor-pointer">Caffeine</a>

                <!-- Hamburger Icon for Mobile -->
                <div class="md:hidden cursor-pointer text-2xl" id="menu-toggle">
                    <i class="fa-solid fa-bars"></i>
                </div>

                <!-- Menu Items (Hidden on mobile) -->
                <div class="hidden md:flex">
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

                <!-- User and Cart Icons (Visible on all devices) -->
                <div class="flex flex-row items-center">
                    <c:choose>
                        <c:when test="${user == null}">
                            <a href="./login" class="cursor-pointer hover:text-coffee-700 transition ease-in-out duration-200">Sign in</a>
                        </c:when>
                        <c:otherwise>
                            <div class="relative group">
                                <a href="./profile" class="w-8 h-8 rounded-full bg-white flex justify-center items-center cursor-pointer">
                                    <i class="fa-solid fa-user text-black"></i>
                                </a>
                                <div class="absolute min-w-40 bg-white right-0 z-20 rounded hidden group-hover:block animate-showDown">
                                    <div class="text-black">
                                        <div class="text-xl bg-coffee-500 rounded-t">
                                            <h1 class="p-2">${user.getLastName()} ${user.getFirstName()}</h1>
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

            <!-- Mobile Menu (Hidden by default) -->
            <div id="mobile-menu" class="lg:hidden hidden flex-col items-center">
                <ul class="flex flex-col mt-3 text-center">
                    <li class="my-2 cursor-pointer hover:text-coffee-700 transition ease-in-out duration-200">
                        <a href="./home">Home</a>
                    </li>
                    <li class="my-2 cursor-pointer hover:text-coffee-700 transition ease-in-out duration-200">
                        <a href="./menu">Menu</a>
                    </li>
                    <li class="my-2 cursor-pointer hover:text-coffee-700 transition ease-in-out duration-200">
                        <a href="./about-us">About Us</a>
                    </li>
                    <li class="my-2 cursor-pointer hover:text-coffee-700 transition ease-in-out duration-200">
                        <a href="./blog">Blog</a>
                    </li>
                </ul>
            </div>
        </div>

        <!-- JavaScript for toggling mobile menu -->
        <script>
            const menuToggle = document.getElementById('menu-toggle');
            const mobileMenu = document.getElementById('mobile-menu');

            menuToggle.addEventListener('click', () => {
                mobileMenu.classList.toggle('hidden');
            });
        </script>

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
