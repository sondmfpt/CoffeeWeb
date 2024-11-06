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
        <title>Menu</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
        <link href="./output.css" rel="stylesheet">
    </head>
    <body class="scroll-smooth font-serif">
        <c:set var="user" value="${USER}"/>
        <c:set var="products" value="${PRODUCTS}"/>
        <c:set var="categories" value="${CATEGORIES}"/>
        <div class="flex flex-col bg-coffee-200">
            <!-- NAVBAR SCROLL-->
            <%@ include file="./include/header-dynamic.jsp" %>
            <%@ include file="./chatbot.jsp" %>

            <div class="container mx-auto">

                <!-- NAVBAR STATIC-->
                <%@ include file="./include/header-static.jsp" %>


                <div id="content" class="text-black">
                    <div class="py-10 text-center">
                        <h1 class="text-8xl font-bold">Cửa hàng</h1>
                    </div>
                    <div class="grid grid-cols-12 gap-6">
                        <!-- LEFT -->
                        <div class="col-span-3 hidden lg:block">
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
                        <div class="col-span-12 lg:col-span-9">
                            <!-- ORDER LIST -->
                            <div class="bg-coffee-300 rounded">
                                <div class="flex justify-between items-center px-7 py-4">
                                    <div class="flex flex-wrap gap-3 items-center">
                                        <h3 class="">Sắp xếp theo</h3>
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
                                        <div>
                                            <input name="searchProduct" type="text" placeholder="Tìm kiếm" class="rounded px-3 py-1" oninput="SearchEvent()">
                                        </div>
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
                                <div id="product-list" class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-3">
                                    <c:forEach var="product" items="${products}">
                                        <a href="./product-detail?productId=${product.getId()}"
                                           class="col-span-1 bg-white rounded hover:-translate-y-1 transition ease-in-out duration-200 cursor-pointer">
                                            <div id="product-Image">
                                                <c:choose>
                                                    <c:when test="${empty product.getThumbnailUrl()}">
                                                        <img class="rounded-t" src="./img/thumbnail/invalid-image.png" alt="">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img class="rounded-t" src="./img/thumbnail/${product.getThumbnailUrl()}" alt="">
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
                                        <c:choose>
                                            <c:when test="${i <= 3}">
                                                <div>
                                                    <label class="h-9 w-9 mx-3 flex items-center justify-center cursor-pointer rounded hover:bg-slate-100 ${i == 1 ? "bg-white" : ""}" for="page-button-${i}">${i}</label>
                                                    <input type="radio" id="page-button-${i}" name="page" value="${i}" onchange="pageButtonClick()" class="hidden">
                                                </div>
                                            </c:when>
                                            <c:otherwise>

                                                <!-- Hiển thị dấu "..." nếu i == 4 và tổng số trang lớn hơn 5 -->
                                                <c:if test="${i == 4 && TOTALPAGE > 5}">
                                                    <div class="h-9 w-9 mx-3 flex items-center justify-center">...</div>
                                                </c:if>

                                                <!-- Hiển thị hai trang cuối -->
                                                <c:if test="${i > TOTALPAGE - 2}">
                                                    <div>
                                                        <label class="h-9 w-9 mx-3 flex items-center justify-center cursor-pointer rounded hover:bg-slate-100" for="page-button-${i}">${i}</label>
                                                        <input type="radio" id="page-button-${i}" name="page" value="${i}" onchange="pageButtonClick()" class="hidden">
                                                    </div>
                                                </c:if>
                                            </c:otherwise>
                                        </c:choose>

                                    </c:forEach>

                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>


            <!-- FOOTER -->
            <%@ include file="include/footer.jsp" %>
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
                        informations.forEach(function (inf) {
                            var checkedInfor = "#product-" + inf.value;
                            pro.querySelector(checkedInfor).classList.remove("hidden");
                        })
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
                    var searchValue = document.querySelector('input[name="searchProduct"]').value;
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
                    callMenu(selectedAddress, orderValue, pageNum, numPerPage, searchValue);
                });
            });

            orderType.forEach(function (ot) {
                ot.addEventListener('change', function () {
                    var selectedAddress = [];
                    var orderValue = "";
                    var pageNum = 1;
                    var numPerPage = 5;
                    var searchValue = document.querySelector('input[name="searchProduct"]').value;
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

                    callMenu(selectedAddress, orderValue, pageNum, numPerPage, searchValue);
                });
            });

            orderByPrice.addEventListener('change', function () {
                var selectedAddress = [];
                var orderValue = "";
                var pageNum = 1;
                var numPerPage = 5;
                var searchValue = document.querySelector('input[name="searchProduct"]').value;
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

                callMenu(selectedAddress, orderValue, pageNum, numPerPage, searchValue);
            });

            numberPerPage.addEventListener('change', function () {
                var selectedAddress = [];
                var orderValue = "";
                var pageNum = 1;
                var numPerPage = 5;
                var searchValue = document.querySelector('input[name="searchProduct"]').value;
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
                callMenu(selectedAddress, orderValue, pageNum, numPerPage, searchValue);
            });

            function pageButtonClick() {
                pages = document.querySelectorAll('input[name="page"]');
                var selectedAddress = [];
                var orderValue = "";
                var pageNum = 1;
                var searchValue = document.querySelector('input[name="searchProduct"]').value;
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

                callMenu(selectedAddress, orderValue, pageNum, numPerPage, searchValue);
            }

            function SearchEvent() {
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

                var searchValue = document.querySelector('input[name="searchProduct"]').value;

                callMenu(selectedAddress, orderValue, pageNum, numPerPage, searchValue);
            }

            function callMenu(selectedAddress, orderValue, pageNum, numPerPage, searchValue) {
                const xhr = new XMLHttpRequest();


                xhr.open('POST', '/SWP_Project/menu?categoryId=' + encodeURIComponent(selectedAddress)
                        + '&orderValue=' + encodeURIComponent(orderValue)
                        + '&pageNum=' + encodeURIComponent(pageNum)
                        + '&numPerPage=' + encodeURIComponent(numPerPage)
                        + '&searchValue=' + encodeURIComponent(searchValue)
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
                        var rowPerPage = productResponse.rowPerPage;


                        //Set max and value of number product per page
                        numberPerPage.setAttribute("max", totalNumProduct);
                        numberPerPage.value = rowPerPage;
                        //Show product list
                        if (products.length == 0) {
                            const announcement = document.createElement('h1');
                            announcement.classList.add('col-span-4', 'text-center', 'text-3xl', 'font-bold');
                            announcement.innerHTML = "Không có sản phẩm nào!";
                            productList.appendChild(announcement);
                            numberPerPage.value = 1;

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
                                        '<img class="rounded-t" src="./img/thumbnail/' + thumbnailUrl + '" alt="">' +
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
                        var start = 2;
                        if(prePage > 1) start = prePage;
                        for (var i = start - 1; i <= totalPage; i++) {
                            var pageButton = document.createElement('div');
                            if (i <= start + 1) {
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
                            } else {
                                if (i == start + 2 && totalPage > 5) {
                                    var dot = document.createElement('div');
                                    dot.classList.add('h-9', 'w-9', 'mx-3', 'flex', 'items-center', 'justify-center');
                                            dot.innerHTML = '...';
                                    pageButtons.appendChild(dot);
                                }
                                if (i > totalPage - 2) {
                                    pageButton.innerHTML =
                                            '<label class="h-9 w-9 mx-3 flex items-center justify-center cursor-pointer rounded hover:bg-slate-100" for="page-button-' + i + '">' + i + '</label>' +
                                            '<input type="radio" id="page-button-' + i + '" name="page" value="' + i + '" onchange="pageButtonClick()" class="hidden">'
                                    pageButtons.appendChild(pageButton);

                                }
                            }
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
