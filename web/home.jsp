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
            <div id="navbar" class="bg-black w-full h-[12%] fixed z-50 text-white hidden">
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
                                <div class="w-8 h-8 rounded-full bg-white flex justify-center items-center cursor-pointer">
                                    <i class="fa-solid fa-user text-black"></i>
                                </div>
                            </c:otherwise>
                        </c:choose>
                        <div class="border-r-2 border-white mx-4"></div>
                        <div class="cursor-pointer hover:text-coffee-700"><i class="fa-solid fa-magnifying-glass"></i></div>
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
                                            <div class="w-8 h-8 rounded-full bg-white flex justify-center items-center cursor-pointer">
                                                <i class="fa-solid fa-user text-black"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="border-r-2 border-white mx-4"></div>
                                    <div class="cursor-pointer flex items-center hover:text-coffee-700 transition ease-in-out duration-200"><i
                                            class="fa-solid fa-magnifying-glass"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- CONTENT -->
                        <div class="grid grid-cols-12 gap-2 mt-7">
                            <!-- CONTENT LEFT -->
                            <div class="col-span-5">
                                <div class="mt-5">
                                    <h1 class="text-6xl font-bold leading-relaxed">Discover The Art Of Perfect Coffee</h1>
                                </div>
                                <div class="my-8">
                                    <p>Experience The Rich And Bold Flavors Of Our Exquisite Coffees Blends, Crafted To
                                        Awaken
                                        Your Senses And Start Your Day Right</p>
                                </div>
                                <div class="my-8">
                                    <button class="py-2 px-3 border-2 border-white bg-white text-black mr-5 hover:text-white hover:bg-black hover:border-white transition ease-in-out duration-200">
                                        Order Now <i
                                            class="fa-solid fa-arrow-right ml-2"></i></button>
                                    <button class="py-2 px-3 border-2 border-white hover:text-black hover:bg-white transition ease-in-out duration-200">
                                        Explore More
                                    </button>
                                </div>
                                <div class="flex justify-between my-16">
                                    <div class="flex flex-col justify-center items-center gap-2">
                                        <h3 class="text-3xl font-bold">50+</h3>
                                        <p class="text-sm uppercase">Item of coffee</p>
                                    </div>
                                    <div class="flex flex-col justify-center items-center gap-2">
                                        <h3 class="text-3xl font-bold">20+</h3>
                                        <p class="text-sm uppercase">Order Running</p>
                                    </div>
                                    <div class="flex flex-col justify-center items-center gap-2">
                                        <h3 class="text-3xl font-bold">2k+</h3>
                                        <p class="text-sm uppercase">Happy Customer</p>
                                    </div>
                                </div>
                            </div>

                            <!-- CONTENT RIGHT -->
                            <div class="absolute right-0 top-30 z-0">
                                <h1 class="text-[#271d14] text-[180px] font-bold tracking-tighter leading-none py-5">
                                    Caffeine</h1>
                                <h1 class="text-[#271d14] text-[180px] font-bold  tracking-tighter leading-none py-5">
                                    Caffeine</h1>
                            </div>
                            <div class="col-span-7 ml-7 z-10">
                                <img class="" src="./img/—Pngtree—flying%20cup%20of%20coffee%20with_5057949.png"
                                     alt="Coffee Cup">
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <section class="">
                <div class="bg-coffee-200 text-black">
                    <div class="container mx-auto pt-10 pb-20">
                        <div class="w-full h-20"></div>
                        <!-- CONTENT -->
                        <!-- CONTENT-TOP -->
                        <div class="grid grid-cols-2 gap-3 mt-16">
                            <div class="col-span-1 ml-10">
                                <div class="absolute w-[400px] h-[400px] border-2 border-black transform skew-x-[20deg]">
                                </div>
                                <div
                                    class="absolute w-[300px] h-[300px] border-2 border-black transform skew-x-[20deg] rotate-45">
                                </div>
                                <div class="w-[400px] h-[400px] overflow-hidden rotate-[-6deg]">
                                    <img class="object-cover w-full h-full object-left-top" src="./img/2.png" alt="">
                                </div>
                            </div>
                            <div class="col-span-1 mt-10">
                                <h1 class="text-7xl font-bold">Coffee Heaven</h1>
                                <p class="my-10 text-coffee-700">Lorem Ipsim Is Simply Dummy Text Of The Printing And
                                    Typesetting Industry. Lorem Ipsum
                                    Has Been The Industrys Standard Dummy Text Ever Since The 1500s.</p>
                                <button class="py-2 px-3 bg-black text-white mt-5 hover:text-black hover:bg-white hover:border-white transition ease-in-out duration-200">
                                    View All
                                    <i class="fa-solid fa-arrow-right ml-2"></i>
                                </button>
                            </div>
                        </div>

                        <!-- CONTENT-BOTTOM -->
                        <div class="grid grid-cols-2 gap-3 mt-44">
                            <div class="col-span-1 mt-10 mr-20 text-right">
                                <h1 class="text-7xl font-bold">Jean's Coffee</h1>
                                <p class="my-10 text-coffee-700">Lorem Ipsim Is Simply Dummy Text Of The Printing And
                                    Typesetting Industry. Lorem Ipsum
                                    Has Been The Industrys Standard Dummy Text Ever Since The 1500s.</p>
                                <button class="py-2 px-3 bg-black text-white mt-5 hover:text-black hover:bg-white hover:border-white transition ease-in-out duration-200">
                                    View All
                                    <i class="fa-solid fa-arrow-right ml-2"></i>
                                </button>
                            </div>
                            <div class="col-span-1 flex justify-center">
                                <div
                                    class="absolute w-[400px] h-[400px] border-2 border-black transform skew-x-[10deg] rotate-[-12deg]">
                                </div>
                                <div
                                    class="absolute w-[300px] h-[300px] border-2 border-black transform skew-y-[10deg] rotate-45">
                                </div>
                                <div class="w-[400px] h-[400px] overflow-hidden rotate-[3deg]">
                                    <img class="object-cover w-full h-full object-left-top" src="./img/3.png" alt="">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

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
                            <div class="col-span-1 border-2 border-black items-center hover:-translate-y-2 transition ease-in-out duration-200 cursor-pointer">
                                <div class="relative flex flex-col items-center">
                                    <div class="absolute bg-black top-0 left-0 right-0 bottom-1/2"></div>
                                    <div class="w-[250px] h-[250px] p-5 z-10">
                                        <img class="object-cover w-full h-full border-8 border-coffee-500"
                                             src="./img/ca-phe-capuchino-1.jpg" alt="">
                                    </div>
                                    <div class="text-3xl font-bold pb-3">Cappuchino</div>
                                </div>
                                <div class="bg-[#c7ad8e] border-t-2 border-t-black">
                                    <div class="text-3xl py-3">Order Now</div>
                                </div>
                            </div>

                            <div class="col-span-1 border-2 border-black items-center hover:-translate-y-2 transition ease-in-out duration-200 cursor-pointer">
                                <div class="relative flex flex-col items-center">
                                    <div class="absolute bg-black top-0 left-0 right-0 bottom-1/2"></div>
                                    <div class="w-[250px] h-[250px] p-5 z-10">
                                        <img class="object-cover w-full h-full border-8 border-coffee-500"
                                             src="./img/ca-phe-capuchino-1.jpg" alt="">
                                    </div>
                                    <div class="text-3xl font-bold pb-3">Cappuchino</div>
                                </div>
                                <div class="bg-[#c7ad8e] border-t-2 border-t-black">
                                    <div class="text-3xl py-3">Order Now</div>
                                </div>
                            </div>

                            <div class="col-span-1 border-2 border-black items-center hover:-translate-y-2 transition ease-in-out duration-200 cursor-pointer">
                                <div class="relative flex flex-col items-center">
                                    <div class="absolute bg-black top-0 left-0 right-0 bottom-1/2"></div>
                                    <div class="w-[250px] h-[250px] p-5 z-10">
                                        <img class="object-cover w-full h-full border-8 border-coffee-500"
                                             src="./img/ca-phe-capuchino-1.jpg" alt="">
                                    </div>
                                    <div class="text-3xl font-bold pb-3">Cappuchino</div>
                                </div>
                                <div class="bg-[#c7ad8e] border-t-2 border-t-black">
                                    <div class="text-3xl py-3">Order Now</div>
                                </div>
                            </div>

                            <div class="col-span-1 border-2 border-black items-center hover:-translate-y-2 transition ease-in-out duration-200 cursor-pointer">
                                <div class="relative flex flex-col items-center">
                                    <div class="absolute bg-black top-0 left-0 right-0 bottom-1/2"></div>
                                    <div class="w-[250px] h-[250px] p-5 z-10">
                                        <img class="object-cover w-full h-full border-8 border-coffee-500"
                                             src="./img/ca-phe-capuchino-1.jpg" alt="">
                                    </div>
                                    <div class="text-3xl font-bold pb-3">Cappuchino</div>
                                </div>
                                <div class="bg-[#c7ad8e] border-t-2 border-t-black">
                                    <div class="text-3xl py-3">Order Now</div>
                                </div>
                            </div>
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
                        <div id="default-carousel" class="relative w-full" data-carousel="slide">
                            <!-- Carousel wrapper -->
                            <div class="relative h-56 overflow-hidden rounded-lg md:h-96">
                                <!-- Item 1 -->
                                <div class="hidden duration-700 ease-in-out" data-carousel-item>
                                    <img src="./img/barista-prepare-coffee-working-order-concept-PBZ6VQ6-768x343-1.jpg"
                                         class="absolute block w-full -translate-x-1/2 -translate-y-1/2 top-1/2 left-1/2"
                                         alt="...">
                                </div>
                                <!-- Item 2 -->
                                <div class="hidden duration-700 ease-in-out" data-carousel-item>
                                    <img src="./img/z2839027460835_06af8c891450c731e6a56e024c1905b4.jpg"
                                         class="absolute block w-full -translate-x-1/2 -translate-y-1/2 top-1/2 left-1/2"
                                         alt="...">
                                </div>
                                <!-- Item 3 -->
                                <div class="hidden duration-700 ease-in-out" data-carousel-item>
                                    <img src="./img/z2414481606361_e0187cf03a309dbfb1afe862d24a116b.jpg"
                                         class="absolute block w-full -translate-x-1/2 -translate-y-1/2 top-1/2 left-1/2"
                                         alt="...">
                                </div>
                                <!-- Item 4 -->
                                <div class="hidden duration-700 ease-in-out" data-carousel-item>
                                    <img src="./img/z2414482145717_2ab282fe361bbfa497d7a4dcb678fee0.jpg"
                                         class="absolute block w-full -translate-x-1/2 -translate-y-1/2 top-1/2 left-1/2"
                                         alt="...">
                                </div>
                                <!-- Item 5 -->
                                <div class="hidden duration-700 ease-in-out" data-carousel-item>
                                    <img src="./img/fresh-coffee-with-cinnamon-QR8W4GN-960x604-1.jpg"
                                         class="absolute block w-full -translate-x-1/2 -translate-y-1/2 top-1/2 left-1/2"
                                         alt="...">
                                </div>
                            </div>
                            <!-- Slider indicators -->
                            <div
                                class="absolute z-30 flex -translate-x-1/2 bottom-5 left-1/2 space-x-3 rtl:space-x-reverse">
                                <button type="button" class="w-3 h-3 rounded-full" aria-current="true" aria-label="Slide 1"
                                        data-carousel-slide-to="0"></button>
                                <button type="button" class="w-3 h-3 rounded-full" aria-current="false" aria-label="Slide 2"
                                        data-carousel-slide-to="1"></button>
                                <button type="button" class="w-3 h-3 rounded-full" aria-current="false" aria-label="Slide 3"
                                        data-carousel-slide-to="2"></button>
                                <button type="button" class="w-3 h-3 rounded-full" aria-current="false" aria-label="Slide 4"
                                        data-carousel-slide-to="3"></button>
                                <button type="button" class="w-3 h-3 rounded-full" aria-current="false" aria-label="Slide 5"
                                        data-carousel-slide-to="4"></button>
                            </div>
                            <!-- Slider controls -->
                            <button type="button"
                                    class="absolute top-0 start-0 z-30 flex items-center justify-center h-full px-4 cursor-pointer group focus:outline-none"
                                    data-carousel-prev>
                                <span
                                    class="inline-flex items-center justify-center w-10 h-10 rounded-full bg-white/30 dark:bg-gray-800/30 group-hover:bg-white/50 dark:group-hover:bg-gray-800/60 group-focus:ring-4 group-focus:ring-white dark:group-focus:ring-gray-800/70 group-focus:outline-none">
                                    <svg class="w-4 h-4 text-white dark:text-gray-800 rtl:rotate-180" aria-hidden="true"
                                         xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 6 10">
                                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"
                                          stroke-width="2" d="M5 1 1 5l4 4"/>
                                    </svg>
                                    <span class="sr-only">Previous</span>
                                </span>
                            </button>
                            <button type="button"
                                    class="absolute top-0 end-0 z-30 flex items-center justify-center h-full px-4 cursor-pointer group focus:outline-none"
                                    data-carousel-next>
                                <span
                                    class="inline-flex items-center justify-center w-10 h-10 rounded-full bg-white/30 dark:bg-gray-800/30 group-hover:bg-white/50 dark:group-hover:bg-gray-800/60 group-focus:ring-4 group-focus:ring-white dark:group-focus:ring-gray-800/70 group-focus:outline-none">
                                    <svg class="w-4 h-4 text-white dark:text-gray-800 rtl:rotate-180" aria-hidden="true"
                                         xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 6 10">
                                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"
                                          stroke-width="2" d="m1 9 4-4-4-4"/>
                                    </svg>
                                    <span class="sr-only">Next</span>
                                </span>
                            </button>
                        </div>

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
