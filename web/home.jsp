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
        <title>Home</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
        <link href="./output.css" rel="stylesheet">
    </head>
    <body class="font-serif scroll-smooth">
        <c:set var="user" value="${USER}"/>
        <div class="flex flex-col">
            <!-- HEADER DYNAMIC -->
            <%@ include file="./include/header-dynamic.jsp" %>
            <%@ include file="./chatbot.jsp" %>

            <section class="h-screen">
                <div class="absolute bottom-0 top-0 left-0 right-0 bg-gradient-to-r from-black to-[#331c0e] text-white">
                    <div class="container m-auto">
                        <!-- HEADER STATIC -->
                        <%@ include file="./include/header-static.jsp" %>
                        
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
                                <img class="" src="./img/page/—Pngtree—flying%20cup%20of%20coffee%20with_5057949.png"
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
                                    <img class="object-cover w-full h-full object-left-top border-2 border-black" src="./img/thumbnail/${productTrend1.getKey().getThumbnailUrl()}" alt="">
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
                                    <img class="object-cover w-full h-full object-left-top border-2 border-black" src="./img/thumbnail/${productTrend2.getKey().getThumbnailUrl()}" alt="">
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
                                                 src="./img/thumbnail/${pro.getThumbnailUrl()}" alt="">
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
                                            <img src="./img/page/${galery}" alt="Image 1" class="w-full h-full object-cover">
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
            <%@ include file="include/footer.jsp" %>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/flowbite@2.5.1/dist/flowbite.min.js"></script>
    </body>
</html>
