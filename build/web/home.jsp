<%-- 
    Document   : home
    Created on : Sep 12, 2024, 12:38:07 PM
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
    <body class="font-serif scroll-smooth">
        <c:set var="user" value="${USER}"/>
        <div class="flex flex-col">
            <!-- NAVBAR -->
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

            <section class="h-screen">
                <div class="absolute bottom-0 top-0 left-0 right-0 bg-gradient-to-r from-black to-[#331c0e] text-white">
                    <div class="container m-auto">
                        <!-- NAVBAR -->
                        <div class="w-full border-2 border-white my-4 z-50 text-white">
                            <div class="flex justify-between m-3 items-center">
                                <a href="./home" class="text-4xl text-white font-bold cursor-pointer">Caffeine</a>
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
                                    <div class="border-r-2 border-white mx-4"></div>
                                    <div class="cursor-pointer flex items-center hover:text-coffee-700 transition ease-in-out duration-200">
                                        <i class="fa-solid fa-cart-shopping"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- CONTENT -->
                        <div class="grid grid-cols-12 gap-2 mt-7">
                            <!-- CONTENT LEFT -->
                            <div class="col-span-5">
                                <div class="mt-5">
                                    <h1 class="text-6xl font-bold leading-relaxed animate-[fadeIn_.25s_ease-out_,_moveInRightFull_.5s_ease-out]">Discover The Art Of Perfect Coffee</h1>
                                </div>
                                <div class="my-8 animate-[fadeIn_.25s_ease-out_,_moveInUpFull_.5s_ease-out]">
                                    <p>Experience The Rich And Bold Flavors Of Our Exquisite Coffees Blends, Crafted To
                                        Awaken
                                        Your Senses And Start Your Day Right</p>
                                </div>
                                <div class="my-8">
                                    <a href="./menu" class="py-3 px-3 border-2 border-white bg-white text-black mr-5 hover:text-white hover:bg-black hover:border-white transition ease-in-out duration-200 animate-[fadeIn_1s_ease-out]">
                                        Order Now <i
                                            class="fa-solid fa-arrow-right ml-2"></i></a>
                                    <a href="./about-us" class="py-3 px-3 border-2 border-white hover:text-black hover:bg-white transition ease-in-out duration-200 animate-[fadeIn_1s_ease-out]">
                                        Explore More
                                    </a>
                                </div>
                                <div class="flex justify-between my-16">
                                    <div class="flex flex-col justify-center items-center gap-2 animate-[fadeIn_.25s_ease-out_,_moveInUpFull_.5s_ease-out_.1s]">
                                        <h3 class="text-3xl font-bold">50+</h3>
                                        <p class="text-sm uppercase">Item of coffee</p>
                                    </div>
                                    <div class="flex flex-col justify-center items-center gap-2 animate-[fadeIn_.25s_ease-out_,_moveInUpFull_.5s_ease-out_.2s]">
                                        <h3 class="text-3xl font-bold">20+</h3>
                                        <p class="text-sm uppercase">Order Running</p>
                                    </div>
                                    <div class="flex flex-col justify-center items-center gap-2 animate-[fadeIn_.25s_ease-out_,_moveInUpFull_.5s_ease-out_.3s]">
                                        <h3 class="text-3xl font-bold">2k+</h3>
                                        <p class="text-sm uppercase">Happy Customer</p>
                                    </div>
                                </div>
                            </div>

                            <!-- CONTENT RIGHT -->
                            <div class="absolute right-0 top-30 z-0">
                                <h1 class="text-[#271d14] text-[180px] font-bold tracking-tighter leading-none py-5 animate-[moveInLeftFull_.75s_ease-out_.1s]">
                                    Caffeine</h1>
                                <h1 class="text-[#271d14] text-[180px] font-bold  tracking-tighter leading-none py-5 animate-[moveInLeftFull_.75s_ease-out_.2s]">
                                    Caffeine</h1>
                            </div>
                            <div class="col-span-7 ml-7 z-10 animate-moveInLeftFull">
                                <img class="" src="./img/—Pngtree—flying%20cup%20of%20coffee%20with_5057949.png"
                                     alt="Coffee Cup">
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <c:set var="trend" value="${TREND}"/>
            <c:set var="productTrend1" value="${trend.getAllProduct().get(0)}"/>
            <c:set var="productTrend2" value="${trend.getAllProduct().get(1)}"/>
            <section class="">
                <div class="bg-coffee-200 text-black">
                    <div class="container mx-auto pt-10 pb-20">
                        <div class="w-full h-20"></div>
                        <!-- CONTENT -->
                        <div class="text-center">
                            <h1 class="text-8xl font-bold">${trend.getTitle()}</h1>
                            <h2 class="text-4xl text-coffee-500">${trend.getSubTitle()}</h2>
                        </div>
                        <!-- CONTENT-TOP -->
                        <div class="grid grid-cols-2 gap-3 mt-16">
                            <div class="col-span-1 ml-10">
                                <div class="absolute w-[400px] h-[400px] border-2 border-black transform skew-x-[20deg]">
                                </div>
                                <div
                                    class="absolute w-[300px] h-[300px] border-2 border-black transform skew-x-[20deg] rotate-45">
                                </div>
                                <div class="w-[400px] h-[400px] overflow-hidden rotate-[-6deg]">
                                    <img class="object-cover w-full h-full object-left-top border-2 border-black" src="./img/${productTrend1.getKey().getThumbnailUrl()}" alt="">
                                </div>
                            </div>
                            <div class="col-span-1 mt-10">
                                <h1 class="text-7xl font-bold">${productTrend1.getKey().getName()}</h1>
                                <p class="my-10 text-coffee-700">${productTrend1.getValue()}</p>
                                <a href="./product-detail?productId=${productTrend1.getKey().getId()}" class="py-3 px-3 bg-black text-white mt-5 hover:text-black hover:bg-white hover:border-white transition ease-in-out duration-200">
                                    View All
                                    <i class="fa-solid fa-arrow-right ml-2"></i>
                                </a>
                            </div>
                        </div>

                        <!-- CONTENT-BOTTOM -->
                        <div class="grid grid-cols-2 gap-3 mt-44">
                            <div class="col-span-1 mt-10 mr-20 text-right">
                                <h1 class="text-7xl font-bold">${productTrend2.getKey().getName()}</h1>
                                <p class="my-10 text-coffee-700">${productTrend2.getValue()}</p>
                                <a href="./product-detail?productId=${productTrend2.getKey().getId()}" class="py-3 px-3 bg-black text-white mt-5 hover:text-black hover:bg-white hover:border-white transition ease-in-out duration-200">
                                    View All
                                    <i class="fa-solid fa-arrow-right ml-2"></i>
                                </a>
                            </div>
                            <div class="col-span-1 flex justify-center">
                                <div
                                    class="absolute w-[400px] h-[400px] border-2 border-black transform skew-x-[10deg] rotate-[-12deg]">
                                </div>
                                <div
                                    class="absolute w-[300px] h-[300px] border-2 border-black transform skew-y-[10deg] rotate-45">
                                </div>
                                <div class="w-[400px] h-[400px] overflow-hidden rotate-[3deg]">
                                    <img class="object-cover w-full h-full object-left-top border-2 border-black" src="./img/${productTrend2.getKey().getThumbnailUrl()}" alt="">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <c:set var="bestSellings" value="${BESTSELLING}"/>
            <section class="h-screen">
                <div class="h-full bg-coffee-500 text-black">
                    <div class="container mx-auto pt-10 pb-20 text-center">
                        <div class="w-2/3 text-center mx-auto mt-10">
                            <h1 class="text-6xl font-bold">Best Selling Item</h1>
                            <p class="my-10 text-[#675547]">Lorem Ipsim Is Simply Dummy Text Of The Printing And
                                Typesetting Industry. Lorem Ipsum
                                Has Been The Industrys Standard Dummy Text Ever Since The 1500s.</p>
                        </div>
                        <div class="grid grid-cols-4 gap-5">
                            <c:forEach var="pro" items="${bestSellings}">
                                <a href="./product-detail?productId=${pro.getId()}" class="col-span-1 border-2 border-black items-center hover:-translate-y-2 transition ease-in-out duration-200 cursor-pointer">
                                    <div class="relative flex flex-col items-center">
                                        <div class="absolute bg-black top-0 left-0 right-0 bottom-1/2"></div>
                                        <div class="w-[250px] h-[250px] p-5 z-10">
                                            <img class="object-cover w-full h-full border-8 border-coffee-500"
                                                 src="./img/${pro.getThumbnailUrl()}" alt="">
                                        </div>
                                        <div class="text-3xl font-bold pb-3">${pro.getName()}</div>
                                    </div>
                                    <div class="bg-[#c7ad8e] border-t-2 border-t-black">
                                        <div class="text-3xl py-3">Order Now</div>
                                    </div>
                                </a>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </section>


            <section class="h-screen">
                <div class="h-full bg-coffee-200 text-black py-20">
                    <div class="container mx-auto">
                        <div class="text-center mb-10">
                            <h1 class="text-6xl font-bold leading-relaxed"> Our Moments</h1>
                        </div>

                        <!-- SLIDER -->
                        <div class="container mx-auto mt-10">
                            <!-- Slider Container -->
                            <div class="relative flex transition overflow-hidden w-full h-[26rem] rounded">
                                <!-- Slide Images -->
                                <div id="slider" class="flex ease-in-out duration-500">
                                    <c:forEach var="galery" items="${GALERIES}">
                                        <div class="slide min-w-full">
                                            <img src="./img/${galery}" alt="Image 1" class="w-full h-full object-cover">
                                        </div>
                                    </c:forEach>
                                </div>

                                <button id="prev" class="absolute top-1/2 left-0 transform -translate-y-1/2 bg-gray-800/[0.1] text-white px-6 h-full">
                                    &#10094;
                                </button>
                                <button id="next" class="absolute top-1/2 right-0 transform -translate-y-1/2 bg-gray-800/[0.1] text-white px-6 h-full">
                                    &#10095;
                                </button>
                            </div>
                        </div>

                        <script>
                            const slider = document.getElementById('slider');
                            const slides = document.querySelectorAll('.slide');
                            const prevButton = document.getElementById('prev');
                            const nextButton = document.getElementById('next');

                            let currentIndex = 0;

                            function showSlide(index) {
                                var transform = "translateX(-" + (index * 100) + "%)";
                                slider.style.transform = (transform);
                            }

                            prevButton.addEventListener('click', () => {
                                currentIndex = currentIndex === 0 ? slides.length - 1 : currentIndex - 1;
                                showSlide(currentIndex);
                            });

                            nextButton.addEventListener('click', () => {
                                currentIndex = currentIndex === slides.length - 1 ? 0 : currentIndex + 1;
                                showSlide(currentIndex);
                            });

                            setInterval(() => {
                                currentIndex = currentIndex === slides.length - 1 ? 0 : currentIndex + 1;
                                showSlide(currentIndex);
                            }, 5000);
                        </script>

                        <div class="text-center mt-10 text-xl">
                            <a class="group inline-block font-bold"
                               href="https://www.instagram.com/3croastery.vn">
                                <i class="fa-brands fa-instagram"></i>
                                https://www.instagram.com/3croastery.vn
                                <span class="block max-w-0 group-hover:max-w-full transition-all duration-500 h-0.5 bg-black"></span>
                            </a>
                        </div>
                    </div>
                </div>
            </section>

            <!-- FOOTER -->
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
        <script src="https://cdn.jsdelivr.net/npm/flowbite@2.5.1/dist/flowbite.min.js"></script>
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
