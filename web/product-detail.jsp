<%-- 
    Document   : product-detail
    Created on : Nov 7, 2024, 2:01:03 AM
    Author     : Son Duong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
        <link href="./output.css" rel="stylesheet">
        <script src="https://cdn.tiny.cloud/1/z47v9wd05qdjuz0trbntcnu6p9rv3qyozy8s68xlf939i2o3/tinymce/5/tinymce.min.js" referrerpolicy="origin"></script>
    </head>
    <body>
        <c:set var="user" value="${USER}"/>
        <div class="flex flex-col">
            <!-- NAVBAR -->
            <div class="flex flex-col bg-coffee-200">
                <!-- NAVBAR SCROLL-->
                <%@ include file="include/header-dynamic.jsp" %>


                <div class="container mx-auto">

                    <div class="mx-auto">
                        <!-- NAVBAR STATIC-->
                        <%@ include file="include/header-static.jsp" %>

                    </div>

                    <!--CONTENT-->
                    <div id="content" class="mx-[10%] text-black mb-5">

                        <!--PRODUCT-->
                        <div class="flex flex-col md:flex-row items-center justify-center py-10">
                            <div class="md:w-1/2 flex flex-col justify-center gap-2">
                                <img src="https://3croastery.com/wp-content/uploads/2021/12/Thiet-ke-chua-co-ten-4.jpg" alt="Lac Duong Coffee" class="shadow-lg rounded-md">
                                <div class="flex gap-3 item-center overflow-x-scroll">
                                    <img class="w-20 h-20 bg-red-800 rounded">
                                    <img class="w-20 h-20 bg-red-800 rounded">
                                    <img class="w-20 h-20 bg-red-800 rounded">
                                    <img class="w-20 h-20 bg-red-800 rounded">                                    
                                    <img class="w-20 h-20 bg-red-800 rounded">                                    
                                </div>
                            </div>

                            <div class="md:w-2/3 p-6">
                                <h1 class="text-2xl font-bold mb-4">Cà Phê Arabica Lạc Dương</h1>
                                <p class="text-xl font-semibold text-red-500 mb-4">130.000VND - 325.000VND</p>

                                <div class="mb-4 flex gap-4 items-center">
                                    <label for="weight" class="block text-lg font-medium text-gray-700">Khối lượng</label>
                                    <select id="weight" class="w-1/2 px-3 py-2 block mt-1 rounded-md border-gray-300 shadow-sm focus:ring-indigo-500 focus:border-indigo-500">
                                        <option>Chọn một tùy chọn</option>
                                        <option>250g</option>
                                        <option>500g</option>
                                        <option>1kg</option>
                                    </select>
                                </div>

                                <div class="mb-4 flex gap-4 items-center">
                                    <label for="grind" class="block text-lg font-medium text-gray-700">Kích cỡ xay</label>
                                    <select id="grind" class="w-1/2 px-3 py-2 block mt-1 rounded-md border-gray-300 shadow-sm focus:ring-indigo-500 focus:border-indigo-500">
                                        <option>Chọn một tùy chọn</option>
                                        <option>Whole Beans</option>
                                        <option>Espresso</option>
                                        <option>French Press</option>
                                    </select>
                                </div>

                                <div class="flex gap-4 items-center">
                                    <label class="block text-lg font-medium text-gray-700">Số lượng</label>
                                    <div class="flex items-center">
                                        <div class="flex item-center px-3 h-8 bg-white border border-gray-300 cursor-pointer">-</div>
                                        <input type="number" name="numberOption" value="1" class="w-9 h-8 text-center text-lg no-spinner border-y border-gray-300">
                                        <div class="flex item-center px-3 h-8 bg-white border border-gray-300 cursor-pointer">+</div>
                                    </div>
                                </div>

                                <hr class="border-black my-2">
                                <button class="min-w-1/3 px-3 py-3 bg-black border border-black text-white rounded-lg">
                                    Thêm vào giỏ hàng
                                </button>
                                <button class="w-1/3 px-3 py-3 border border-black rounded-lg">
                                    Mua ngay
                                </button>
                                <hr class="border-black my-2">

                                <p class="text-sm text-gray-600 mt-4">
                                    Mã: N/A <br>
                                    Danh mục: Cà phê, Cà phê đặc sản, Cà phê pha cold brew, Cà phê pha espresso
                                </p>
                            </div>
                        </div>

                        <hr class="border-black py-5">

                        <div class="">
                            <div class="flex gap-6 uppercase font-bold text-2xl justify-center">
                                <div>
                                    <h1>Mô tả</h1>
                                </div>
                                <div>
                                    <h1>Đánh giá (0)</h1>
                                </div>
                            </div>
                            <!--DESCRIPTION-->
                            <div class="my-5">
                                <div>

                                </div>
                            </div>

                            <!--FEEDBACK-->
                            <div class="flex flex-col gap-3">
                                <div class="relative flex gap-3">
                                    <div class="rounded-full w-16 h-16 bg-red-800">
                                        <img src="">
                                    </div>
                                    <div>
                                        <div>
                                            <strong>admin</strong>
                                            - 
                                            <span>16/01/2004</span>
                                        </div>
                                        <div>comment</div>
                                        <div class="flex mt-5 gap-5">
                                            <div class="w-48 h-48 bg-red-800"></div>
                                            <div class="w-48 h-48 bg-red-800"></div>
                                        </div>
                                    </div>
                                    <div class="absolute top-0 right-0">
                                        <div class="flex gap-0">
                                            <i class="fa-solid fa-star text-yellow-400"></i>
                                            <i class="fa-solid fa-star text-yellow-400"></i>
                                            <i class="fa-solid fa-star text-yellow-400"></i>
                                            <i class="fa-solid fa-star text-yellow-400"></i>
                                            <i class="fa-regular fa-star text-gray-400"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>

                </div>

                <!--FOOTER-->
                <%@ include file="include/footer.jsp" %>


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
