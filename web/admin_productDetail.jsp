<%-- 
    Document   : admin_productDetail
    Created on : Oct 8, 2024, 8:34:09 PM
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
        <c:set var="allUsers" value="${ALLUSERS}"/>
        <div class="bg-gray-100 h-screen">
            <div class="flex">
                <!--Navigation-->
                <%@ include file="./include/admin-navigation.jsp" %>

                <!-- Main Content -->
                <div class="flex-1 p-10">
                    <div class="">
                        <h1 class="text-3xl font-semibold">Thành viên</h1>
                        <p class="my-4">This is your main dashboard content.</p>
                        <div class="flex">
                            <p>Tất cả <span>(${TOTALUSER})</span></p>
                            <div class="border-r-2 border-black mx-4"></div>
                            <p>Quản lý <span>(${TOTALADMIN})</span></p>
                            <div class="border-r-2 border-black mx-4"></div>
                            <p>Khách hàng <span>(${TOTALCUSTOMER})</span></p>
                        </div>
                    </div>
                    <div class="my-5 flex justify-between items-center">
                        <input name="searchUser" class="rounded px-3 py-2 w-48 border border-gray-300" type="text" placeholder="Tìm kiếm người dùng">
                        <div class="flex gap-1">
                            <button onclick="changePage('start')" class="flex justify-center items-center w-9 h-9 bg-gray-100 border border-gray-300 rounded"><i class="text-xs fa-solid fa-angles-left"></i></button>
                            <button onclick="changePage('pre')" class="flex justify-center items-center w-9 h-9 bg-gray-100 border border-gray-300 rounded"><i class="text-xs fa-solid fa-chevron-left"></i></button>
                            <input onchange="numPageChange()" id="numPage" type="number" class="text-center w-14 rounded border border-gray-300 no-spinner" value="1" max="5">
                            <div class="h-9 flex gap-1 items-center">
                                trên 
                                <span id="totalPage">${TOTALPAGE}</span>
                            </div>
                            <button onclick="changePage('next')" class="flex justify-center items-center w-9 h-9 bg-gray-100 border border-gray-300 rounded"><i class="text-xs fa-solid fa-chevron-right"></i></button>
                            <button onclick="changePage('end')" class="flex justify-center items-center w-9 h-9 bg-gray-100 border border-gray-300 rounded"><i class="text-xs fa-solid fa-angles-right"></i></button>
                        </div>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="min-w-full border-collapse border border-gray-300 text-left">
                            <thead class="bg-gray-200">
                                <tr>
                                    <th class="py-2 px-4 border-b">Tên người dùng</th>
                                    <th class="py-2 px-4 border-b">Tên</th>
                                    <th class="py-2 px-4 border-b">Email</th>
                                    <th class="py-2 px-4 border-b">Số điện thoại</th>
                                    <th class="py-2 px-4 border-b">Vai trò</th>
                                    <th class="py-2 px-4 border-b">Ngày tạo</th>
                                    <th class="py-2 px-4 border-b">Trạng thái</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="user" items="${allUsers}">
                                    <tr class="odd:bg-white even:bg-gray-100 cursor-pointer hover:bg-coffee-300">
                                        <td class="py-2 px-4 border-b">${user.getUsername()}</td>
                                        <td class="py-2 px-4 border-b">${user.getLastName()} ${user.getFirstName()}</td>
                                        <td class="py-2 px-4 border-b">${user.getEmail()}</td>
                                        <td class="py-2 px-4 border-b">${user.getPhone()}</td>
                                        <td class="py-2 px-4 border-b">${user.getRole()}</td>
                                        <td class="py-2 px-4 border-b">${user.getCreatedAt()}</td>
                                        <td class="py-2 px-4 border-b">${user.isActive() ? 'Active' : 'Deactive'}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <script>
            var numPage = document.getElementById('numPage');
            var totalPage = +document.getElementById('totalPage').textContent;
            function changePage(type) {
                switch (type) {
                    case 'start':
                        numPage.value = 1;
                        break;
                    case 'pre':
                        numPage.value = +numPage.value - 1;
                        break;
                    case 'next':
                        numPage.value = +numPage.value + 1;
                        break;
                    case 'end':
                        numPage.value = totalPage;
                        break;
                }
            }
        </script>
    </body>
</html>
