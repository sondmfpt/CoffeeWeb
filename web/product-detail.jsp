<%-- 
    Document   : product-detail
    Created on : Oct 1, 2024, 3:41:52 PM
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
        <c:set var="user" value="${USER}"/>
        <div class="flex flex-col">
            <!-- NAVBAR -->
            <div class="flex flex-col bg-coffee-200">
                <!-- NAVBAR SCROLL-->
                <div id="navbar" class="bg-black w-full h-[12%] fixed z-50 text-white hidden animate-moveInDownFull">
                    <div class="flex justify-around items-center h-full">
                        <a href="./home" class="text-4xl text-white font-bold cursor-pointer">Caffeine</a>
                        <div class="">
                            <ul class="flex flex-row">
                                <li class="mx-4 cursor-pointer hover:text-coffee-700">Home</li>
                                <li class="mx-4 cursor-pointer hover:text-coffee-700">Menu</li>
                                <li class="mx-4 cursor-pointer hover:text-coffee-700">About Us</li>
                                <li class="mx-4 cursor-pointer hover:text-coffee-700">Facilities</li>
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
                                        <div class="w-8 h-8 rounded-full bg-white flex justify-center items-center cursor-pointer">
                                            <i class="fa-solid fa-user text-black"></i>
                                        </div>
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
                            <div class="cursor-pointer hover:text-coffee-700"><i class="fa-solid fa-magnifying-glass"></i></div>
                        </div>
                    </div>
                </div>

                <!--HEADER-->
                <div class="container mx-auto">
                    <!-- NAVBAR STATIC-->
                    <div class="w-full border-2 border-black my-4 z-50 text-black">
                        <div class="flex justify-between m-3 items-center">
                            <a href="./home" class="text-4xl text-black font-bold cursor-pointer">Caffeine</a>
                            <div class="">
                                <ul class="flex flex-row">
                                    <li class="mx-4 cursor-pointer hover:text-coffee-700 transition ease-in-out duration-200">
                                        Home
                                    </li>
                                    <li class="mx-4 cursor-pointer hover:text-coffee-700 transition ease-in-out duration-200">
                                        Menu
                                    </li>
                                    <li class="mx-4 cursor-pointer hover:text-coffee-700 transition ease-in-out duration-200">
                                        About Us
                                    </li>
                                    <li class="mx-4 cursor-pointer hover:text-coffee-700 transition ease-in-out duration-200">
                                        Facilities
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
                                            <div class="w-8 h-8 rounded-full bg-white flex justify-center items-center cursor-pointer">
                                                <i class="fa-solid fa-user text-black"></i>
                                            </div>
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
                                <div class="border-r-2 border-black mx-4"></div>
                                <div class="cursor-pointer flex items-center hover:text-coffee-700 transition ease-in-out duration-200"><i
                                        class="fa-solid fa-magnifying-glass"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!--FOOTER-->
                <section class="">
                    <!-- EMAIL -->
                    <div class="bg-coffee-500 py-20">
                        <div class="container mx-auto">
                            <div class="flex justify-between gap-20">
                                <div class="flex items-center">
                                    <h1 class="text-4xl font-bold capitalize">Stay Up To Date On All New And Offers.</h1>
                                </div>
                                <div>
                                    <p class="text-coffee-700 capitalize">be the first to know about new collections, special
                                        events, and what's going on at kitchen</p>
                                    <div class="w-full mt-10 flex">
                                        <input class="py-3 px-2 w-full bg-[#bc9d7e] text-black placeholder:text-coffee-700"
                                               type="text" placeholder="Enter Your Email Address">
                                        <button class="bg-black text-white px-6 text-xl"><i
                                                class="fa-solid fa-arrow-right"></i></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- CONTACT -->
                    <div class="bg-black text-white">
                        <div class="grid grid-cols-11 border-b-2 border-b-coffee-500">
                            <div class="col-span-1"></div>
                            <div class="col-span-3 py-20 border-x-2 border-x-coffee-500">
                                <div class="w-11/12 mx-auto border-4 border-white">
                                    <img src="./img/z2839028153583_6b6b7b8184035519bb88526078a17cfd-2048x1366.jpg" alt="">
                                </div>
                                <div class="m-4 text-xl">
                                    <div>Enjoy Better And Better</div>
                                    <div>Quality Coffee With Caffeine</div>
                                </div>
                            </div>
                            <div class="col-span-3 py-20">
                                <div class="mx-4">
                                    <h1 class="text-4xl font-bold">Contact Us</h1>
                                    <div class="text-2xl my-2">Caffeine@Gmail.com</div>
                                    <div class="text-2xl my-2">
                                        <div>Call Us: <span class="text-coffee-500">+84 123 456 789</span></div>
                                        <div>Text Us: <span class="text-coffee-500">+84 123 456 789</span></div>
                                    </div>
                                    <div class="text-2xl my-2 text-coffee-500">
                                        <div>Showroom 01: 21 ngõ 30 Mai Anh Tuấn, phường Ô chợ Dừa, quận Đống Đa, Hà Nội
                                        </div>
                                        <div>Showroom 02: 92 Phan Kế Bính, Đống Đa, Hà Nội</div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-span-3 py-20 border-x-2 border-x-coffee-500">
                                <div>
                                    <div class="w-11/12 h-[200px] mx-auto border-4 border-white">Video</div>
                                </div>
                                <div class="mx-4 my-8">
                                    <h1 class="text-2xl font-bold">Follow Us</h1>
                                    <div class="text-3xl flex gap-6 text-coffee-500 my-3 h-10">
                                        <a class="w-8 cursor-pointer hover:text-4xl transition ease-in-out duration-200"><i
                                                class="fa-brands fa-pinterest"></i></a>
                                        <a class="w-8 cursor-pointer hover:text-4xl transition ease-in-out duration-200"><i
                                                class="fa-brands fa-instagram"></i></a>
                                        <a class="w-8 cursor-pointer hover:text-4xl transition ease-in-out duration-200"><i
                                                class="fa-brands fa-twitter"></i></a>
                                        <a class="w-8 cursor-pointer hover:text-4xl transition ease-in-out duration-200"><i
                                                class="fa-brands fa-facebook"></i></a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-span-1"></div>
                        </div>
                        <!--  -->
                        <div class="py-10 flex justify-center">
                            <a class="hover:text-coffee-500 transition ease-in-out duration-200" href="">Chính sách bảo mật</a>
                            <div class="border-r-2 border-r-coffee-500 h-6 mx-3"></div>
                            <a class="hover:text-coffee-500 transition ease-in-out duration-200" href="">Chính sách vận chuyển</a>
                            <div class="border-r-2 border-r-coffee-500 h-6 mx-3"></div>

                            <a class="hover:text-coffee-500 transition ease-in-out duration-200" href="">Chính sách bảo hành</a>
                            <div class="border-r-2 border-r-coffee-500 h-6 mx-3"></div>
                            <a class="hover:text-coffee-500 transition ease-in-out duration-200" href="">Hướng dẫn mua hàng và thanh
                                toán</a>
                            <div class="border-r-2 border-r-coffee-500 h-6 mx-3"></div>
                            <a class="hover:text-coffee-500 transition ease-in-out duration-200" href="">Câu hỏi thường gặp</a>
                        </div>
                    </div>
                    <!--  -->
                    <div class="bg-black text-white">
                        <div class="border-t-2 border-t-coffee-500">
                            <div class="py-5 text-center text-xl">© 3C ROASTERY - SPECIALTY COFFEE FROM VIETNAM</div>
                        </div>
                    </div>
                </section>

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
