<%-- 
    Document   : menu
    Created on : Sep 27, 2024, 1:47:15 PM
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
        <c:set var="products" value="${PRODUCTS}"/>
        <c:set var="categories" value="${CATEGORIES}"/>
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

                <div id="content" class="text-black">
                    <div class="py-10 text-center">
                        <h1 class="text-8xl font-bold">Cửa hàng</h1>
                    </div>
                    <div class="grid grid-cols-12 gap-6">
                        <!-- LEFT -->
                        <div class="col-span-3">
                            <div class="mb-7">
                                <div class="flex gap-4 items-center">
                                    <i class="fa-solid fa-bars"></i>
                                    <h2 class="text-2xl font-bold">Tất cả danh mục</h2>
                                </div>
                                <hr class="my-3 mx-2 border-t-[1px] border-t-black">
                                <div class="">
                                    <div class="flex flex-col gap-2">
                                        <c:forEach var="category" items="${categories}">
                                            <div class="ml-4">
                                                <input class="cursor-pointer" id="category${category.getId()}" type="checkbox" value="${category.getId()}" name="category">
                                                <label class="cursor-pointer hover:text-coffee-500" for="category${category.getId()}">${category.getName()}</label>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                            <c:set var="information" value="${INFORMATION}"/>
                            <div>
                                <div class="flex gap-4 items-center">
                                    <i class="fa-solid fa-circle-info"></i>
                                    <h2 class="text-2xl font-bold">Thông tin sản phẩm</h2>
                                </div>
                                <hr class="my-3 mx-2 border-t-[1px] border-t-black">
                                <div class="">
                                    <div class="flex flex-col gap-2">
                                        <c:forEach var="information" items="${information}">
                                            <div class="ml-4">
                                                <input class="cursor-pointer" id="${information}" type="checkbox" value="${information}" name="information" onchange="informationEvent()">
                                                <label class="cursor-pointer hover:text-coffee-500" for="${information}">${information}</label>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- RIGHT -->
                        <div class="col-span-9">
                            <!-- ORDER LIST -->
                            <div class="bg-coffee-300 rounded">
                                <div class="flex justify-between items-center px-7 py-4">
                                    <div class="flex gap-3 items-center">
                                        <h3>Sắp xếp theo</h3>
                                        <div class="">
                                            <label for="oderType_relative" class="h-8 w-30 bg-white px-3 py-2 rounded cursor-pointer active--order hover:bg-coffee-200">Liên quan</label>
                                            <input id="oderType_relative" type="radio" name="orderType" value="" class="hidden">
                                        </div>
                                        <div class="">
                                            <label for="oderType_new" class="h-8 w-30 bg-white px-3 py-2 rounded cursor-pointer hover:bg-coffee-200">Mới nhất</label>
                                            <input id="oderType_new" type="radio" name="orderType" value="new" class="hidden">
                                        </div>
                                        <div class="">
                                            <label for="oderType_bestSell" class="h-8 w-30 bg-white px-3 py-2 rounded cursor-pointer hover:bg-coffee-200">Bán chạy</label>
                                            <input id="oderType_bestSell" type="radio" name="orderType" value="sold" class="hidden">
                                        </div>
                                        <select class="h-8 px-3 py-1 rounded" name="orderType">
                                            <option value="" disabled selected hidden>Giá</option>
                                            <option value="ASC" class="bg-white">Giá: Thấp đến cao</option>
                                            <option value="DESC" class="bg-white">Giá: Cao đến thấp</option>
                                        </select>
                                    </div>
                                    <div>
                                        <div>
                                            <input type="number" name="numPerPage" class="w-12 text-right" value="5" min="1">
                                            <span>/ Page</span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- PRODUCT LIST -->
                            <div class="my-5 font-sans">
                                <div id="product-list" class="grid grid-cols-4 gap-3">
                                    <c:forEach var="product" items="${products}">
                                        <a href="./product-detail?productId=${product.getId()}"
                                           class="col-span-1 bg-white rounded hover:-translate-y-1 transition ease-in-out duration-200 cursor-pointer">
                                            <div id="product-Image">
                                                <c:choose>
                                                    <c:when test="${empty product.getThumbnailUrl()}">
                                                        <img class="rounded-t" src="./img/invalid-image.png" alt="">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img class="rounded-t" src="./img/${product.getThumbnailUrl()}" alt="">
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="p-2">
                                                <div id="product-Name" class="text-xl">
                                                    <p class="line-clamp-2">${product.getName()}</p>
                                                </div>
                                                <div id="product-Price" class="text-lg text-coffee-700">
                                                    <p>${product.getPrice()}</p>
                                                </div>
                                                <div id="product-Description" class="mb-2">
                                                    <p class="line-clamp-2">${product.getDescription()}</p>
                                                </div>
                                                <div class="flex justify-between text-sm text-slate-400">
                                                    <p id="product-Sold">
                                                        Đã bán: <span>${product.getTotalSold()}</span>
                                                    </p>
                                                    <p id="product-Date">
                                                        ${product.getCreatedAt()}
                                                    </p>
                                                </div>
                                            </div>
                                        </a>
                                    </c:forEach>
                                </div>
                                <div id="page-button" class="flex items-center justify-center my-3">
                                    <c:forEach begin="1" end="${TOTALPAGE}" step="${1}" var="i">
                                        <div>
                                            <label class="h-9 w-9 mx-3 flex items-center justify-center cursor-pointer rounded hover:bg-slate-100 ${i == 1 ? "bg-white" : ""}" for="page-button-${i}">${i}</label>
                                            <input type="radio" id="page-button-${i}" name="page" value="${i}" onchange="pageButtonClick()" class="hidden">
                                        </div>
                                    </c:forEach>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


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
                        <a class="hover:text-coffee-500 transition ease-in-out duration-200" href="">Chính sách vận
                            chuyển</a>
                        <div class="border-r-2 border-r-coffee-500 h-6 mx-3"></div>

                        <a class="hover:text-coffee-500 transition ease-in-out duration-200" href="">Chính sách bảo hành</a>
                        <div class="border-r-2 border-r-coffee-500 h-6 mx-3"></div>
                        <a class="hover:text-coffee-500 transition ease-in-out duration-200" href="">Hướng dẫn mua hàng và
                            thanh toán</a>
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

        </script>
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

        <script>
            const informations = document.querySelectorAll('input[name="information"]');
            function informationEvent() {
                var hasChecked = false;
                const productListItems = document.querySelectorAll('#product-list>a');
                informations.forEach(function (inf) {
                    var checkedInfor = "#product-" + inf.value;
                    productListItems.forEach(function (pro) {
                        if (inf.checked == true) {
                            hasChecked = true;
                            pro.querySelector(checkedInfor).classList.remove("hidden");
                        } else {
                            pro.querySelector(checkedInfor).classList.add("hidden");
                        }
                    });
                })
                if (!hasChecked) {
                    productListItems.forEach(function (pro) {
                        pro.querySelector(checkedInfor).classList.remove("hidden");
                    });
                }
            }
        </script>


        <!--AJAX-->
        <script>
            const radios = document.querySelectorAll('input[name="category"]');
            const orderType = document.querySelectorAll('input[name="orderType"]');
            const orderByPrice = document.querySelector('select[name="orderType"]');
            const numberPerPage = document.querySelector('input[name="numPerPage"]');
            var pages = document.querySelectorAll('input[name="page"]');

            radios.forEach(function (radio) {
                radio.addEventListener('change', function () {
                    var selectedAddress = [];
                    var orderValue = "";
                    var pageNum = 1;
                    var numPerPage = 5;
                    radios.forEach(function (radio) {
                        if (radio.checked == true)
                            selectedAddress.push(radio.value);
                    });

                    if (orderByPrice.value == '') {
                        orderType.forEach(function (ot) {
                            if (ot.checked == true) {
                                orderValue = ot.value;
                            }
                        });
                    } else {
                        orderValue = orderByPrice.value;
                    }

                    for (var i = 0; i < pages.length; i++) {
                        if (i == 0) {
                            pages[i].checked = true;
                            pages[i].previousElementSibling.classList.add('bg-white');
                        } else {
                            pages[i].checked = false;
                            pages[i].previousElementSibling.classList.remove('bg-white');
                        }
                    }

                    numPerPage = numberPerPage.value;
                    callMenu(selectedAddress, orderValue, pageNum, numPerPage);
                });
            });

            orderType.forEach(function (ot) {
                ot.addEventListener('change', function () {
                    var selectedAddress = [];
                    var orderValue = "";
                    var pageNum = 1;
                    var numPerPage = 5;
                    radios.forEach(function (radio) {
                        if (radio.checked == true)
                            selectedAddress.push(radio.value);
                    });

                    orderType.forEach(function (ot) {
                        if (ot.checked == true) {
                            orderValue = ot.value;
                            ot.previousElementSibling.classList.add('active--order');
                        } else {
                            ot.previousElementSibling.classList.remove('active--order');
                        }
                    });

                    for (var i = 0; i < pages.length; i++) {
                        if (i == 0) {
                            pages[i].checked = true;
                            pages[i].previousElementSibling.classList.add('bg-white');
                        } else {
                            pages[i].checked = false;
                            pages[i].previousElementSibling.classList.remove('bg-white');
                        }
                    }

                    orderByPrice.value = '';
                    orderByPrice.classList.remove('bg-coffee-500');

                    numPerPage = numberPerPage.value;

                    callMenu(selectedAddress, orderValue, pageNum, numPerPage);
                });
            });

            orderByPrice.addEventListener('change', function () {
                var selectedAddress = [];
                var orderValue = "";
                var pageNum = 1;
                var numPerPage = 5;
                radios.forEach(function (radio) {
                    if (radio.checked == true)
                        selectedAddress.push(radio.value);
                });


                orderType.forEach(function (ot) {
                    ot.checked = false;
                    ot.previousElementSibling.classList.remove('active--order');
                });

                for (var i = 0; i < pages.length; i++) {
                    if (i == 0) {
                        pages[i].checked = true;
                        pages[i].previousElementSibling.classList.add('bg-white');
                    } else {
                        pages[i].checked = false;
                        pages[i].previousElementSibling.classList.remove('bg-white');
                    }
                }

                orderValue = orderByPrice.value;
                orderByPrice.classList.add('bg-coffee-500');

                numPerPage = numberPerPage.value;

                callMenu(selectedAddress, orderValue, pageNum, numPerPage);
            });

            numberPerPage.addEventListener('change', function () {
                var selectedAddress = [];
                var orderValue = "";
                var pageNum = 1;
                var numPerPage = 5;
                radios.forEach(function (radio) {
                    if (radio.checked == true)
                        selectedAddress.push(radio.value);
                });

                if (orderByPrice.value == '') {
                    orderType.forEach(function (ot) {
                        if (ot.checked == true) {
                            orderValue = ot.value;
                        }
                    });
                } else {
                    orderValue = orderByPrice.value;
                }

                for (var i = 0; i < pages.length; i++) {
                    if (i == 0) {
                        pages[i].checked = true;
                        pages[i].previousElementSibling.classList.add('bg-white');
                    } else {
                        pages[i].checked = false;
                        pages[i].previousElementSibling.classList.remove('bg-white');
                    }
                }

                numPerPage = numberPerPage.value;
                callMenu(selectedAddress, orderValue, pageNum, numPerPage);
            });

            function pageButtonClick() {
                pages = document.querySelectorAll('input[name="page"]');
                var selectedAddress = [];
                var orderValue = "";
                var pageNum = 1;
                radios.forEach(function (radio) {
                    if (radio.checked == true)
                        selectedAddress.push(radio.value);
                });

                if (orderByPrice.value == '') {
                    orderType.forEach(function (ot) {
                        if (ot.checked == true) {
                            orderValue = ot.value;
                        }
                    });
                } else {
                    orderValue = orderByPrice.value;
                }

                pages.forEach(function (page) {
                    if (page.checked == true) {
                        pageNum = page.value;
                        page.previousElementSibling.classList.add('bg-white');
                    } else {
                        page.previousElementSibling.classList.remove('bg-white');
                    }
                });

                numPerPage = numberPerPage.value;

                callMenu(selectedAddress, orderValue, pageNum, numPerPage);
            }

            function callMenu(selectedAddress, orderValue, pageNum, numPerPage) {
                const xhr = new XMLHttpRequest();

                xhr.open('POST', '/SWP_Project/menu?categoryId=' + encodeURIComponent(selectedAddress)
                        + '&orderValue=' + encodeURIComponent(orderValue)
                        + '&pageNum=' + encodeURIComponent(pageNum)
                        + '&numPerPage=' + encodeURIComponent(numPerPage)
                        , true);

                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        const productResponse = JSON.parse(xhr.responseText);
                        var products = productResponse.products;
                        const productList = document.getElementById('product-list');
                        productList.innerHTML = '';
                        var totalPage = productResponse.totalPage;
                        var prePage = productResponse.prePage;
                        var totalNumProduct = productResponse.totalNumberProduct;

                        //Set max and value of number product per page
                        numberPerPage.setAttribute("max", totalNumProduct);
                        if (totalNumProduct < 5) {
                            numberPerPage.setAttribute("value", totalNumProduct);
                        } else {
                            numberPerPage.setAttribute("value", 5);
                        }
                        //Show product list
                        if (products.length == 0) {
                            const announcement = document.createElement('h1');
                            announcement.classList.add('col-span-4', 'text-center', 'text-3xl', 'font-bold');
                            announcement.innerHTML = "Không có sản phẩm nào!";
                            productList.appendChild(announcement);

                        } else {
                            products.forEach(function (product) {
                                const productItem = document.createElement('a');
                                var thumbnailUrl = "";
                                if (product.thumbnailUrl == null) {
                                    thumbnailUrl = "invalid-image.png";
                                } else {
                                    thumbnailUrl = product.thumbnailUrl;
                                }
                                productItem.href = ('./product-detail?productId=' + product.id);
                                productItem.classList.add('col-span-1', 'bg-white', 'rounded', 'hover:-translate-y-1', 'transition', 'ease-in-out', 'duration-200', 'cursor-pointer');
                                productItem.innerHTML =
                                        '<div id="product-Image">' +
                                        '<img class="rounded-t" src="./img/' + thumbnailUrl + '" alt="">' +
                                        '</div>' +
                                        '<div class="p-2">' +
                                        '<div id="product-Name" class="text-xl">' +
                                        '<p class="line-clamp-2">' + product.name + '</p>' +
                                        '</div>' +
                                        '<div id="product-Price" class="text-lg text-coffee-700">' +
                                        '<p>' + product.price + '</p>' +
                                        '</div>' +
                                        '<div id="product-Description" class="mb-2">' +
                                        '<p class="line-clamp-2">' + product.description + '</p>' +
                                        '</div>' +
                                        '<div class="flex justify-between text-sm text-slate-400">' +
                                        '<p id="product-Sold">Đã bán: <span>' + product.totalSold + '</span></p>' +
                                        '<p id="product-Date">' + product.createdAt + '</p>' +
                                        '</div>' +
                                        '</div>';
                                productList.appendChild(productItem);
                            });
                        }

                        //Change number of page
                        const pageButtons = document.getElementById('page-button');
                        pageButtons.innerHTML = '';
                        for (var i = 1; i <= totalPage; i++) {
                            var pageButton = document.createElement('div');
                            if (i == prePage) {
                                pageButton.innerHTML =
                                        '<label class="h-9 w-9 mx-3 flex items-center justify-center cursor-pointer rounded bg-white hover:bg-slate-100" for="page-button-' + i + '">' + i + '</label>' +
                                        '<input type="radio" id="page-button-' + i + '" name="page" value="' + i + '" onchange="pageButtonClick()" checked class="hidden">'
                            } else {
                                pageButton.innerHTML =
                                        '<label class="h-9 w-9 mx-3 flex items-center justify-center cursor-pointer rounded hover:bg-slate-100" for="page-button-' + i + '">' + i + '</label>' +
                                        '<input type="radio" id="page-button-' + i + '" name="page" value="' + i + '" onchange="pageButtonClick()" class="hidden">'
                            }
                            pageButtons.appendChild(pageButton);
                        }

                        informationEvent();
                    }
                };

                // Send the request
                xhr.send();
            }
        </script>
    </body>
</html>
