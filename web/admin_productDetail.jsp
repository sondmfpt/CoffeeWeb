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
                            <div>
                                <label class="hover:text-coffee-700 cursor-pointer font-semibold" for='allUser'>Tất cả <span>(${TOTALUSER})</span></label>
                                <input onchange="roleUserEvent()" id='allUser' value="all" type='radio' name='roleUserSelect' class="hidden" checked>
                            </div>
                            <div class="border-r-2 border-black mx-4"></div>
                            <div>
                                <label class="hover:text-coffee-700 cursor-pointer" for='adminUser'>Quản lý <span>(${TOTALADMIN})</span></label>
                                <input onchange="roleUserEvent()" id='adminUser' value="admin" type='radio' name='roleUserSelect' class="hidden">
                            </div>
                            <div class="border-r-2 border-black mx-4"></div>
                            <div>
                                <label class="hover:text-coffee-700 cursor-pointer" for='customerUser'>Khách hàng <span>(${TOTALCUSTOMER})</span></label>
                                <input onchange="roleUserEvent()" id='customerUser' value="customer" type='radio' name='roleUserSelect' class="hidden">
                            </div>
                        </div>
                    </div>
                    <div class="my-5 flex justify-between items-center">
                        <div>
                            <input name="searchUser" oninput="searchUser()" class="rounded px-3 py-2 w-48 border border-gray-300" type="text" placeholder="Tìm kiếm người dùng">
                            <a class="px-4 py-3 rounded bg-gray-300 cursor-pointer">Thêm người dùng</a>
                        </div>
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
                        <table id='tableUser' class="min-w-full border-collapse border border-gray-300 text-left">
                            <thead class="bg-gray-200">
                                <tr>
                                    <th onclick="orderEvent('username')" class="py-2 px-4 border-b hover:bg-coffee-300 cursor-pointer">
                                        Tên người dùng
                                        <i class="fa-solid fa-caret-up hidden"></i>
                                        <i class="fa-solid fa-caret-down hidden"></i>
                                    </th>
                                    <th onclick="orderEvent('name')" class="py-2 px-4 border-b hover:bg-coffee-300 cursor-pointer">
                                        Tên
                                        <i class="fa-solid fa-caret-up hidden"></i>
                                        <i class="fa-solid fa-caret-down hidden"></i>
                                    </th>
                                    <th onclick="" class="py-2 px-4 border-b">Email</th>
                                    <th onclick="" class="py-2 px-4 border-b">Số điện thoại</th>
                                    <th onclick="orderEvent('role')" class="py-2 px-4 border-b hover:bg-coffee-300 cursor-pointer">
                                        Vai trò
                                        <i class="fa-solid fa-caret-up hidden"></i>
                                        <i class="fa-solid fa-caret-down hidden"></i>
                                    </th>
                                    <th onclick="orderEvent('date')" class="py-2 px-4 border-b hover:bg-coffee-300 cursor-pointer">
                                        Ngày tạo
                                        <i class="fa-solid fa-caret-up hidden"></i>
                                        <i class="fa-solid fa-caret-down hidden"></i>
                                    </th>
                                    <th onclick="orderEvent('status')" class="py-2 px-4 border-b hover:bg-coffee-300 cursor-pointer">
                                        Trạng thái
                                        <i class="fa-solid fa-caret-up hidden"></i>
                                        <i class="fa-solid fa-caret-down hidden"></i>
                                    </th>
                                </tr>
                            </thead>
                            <tbody id="listUsers">
                                <c:forEach var="user" items="${allUsers}">
                                    <tr onclick="userItemClick(${user.getId()})" class="odd:bg-white even:bg-gray-100 cursor-pointer hover:bg-coffee-300">
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
            function changePage(type) {
                var numPageElement = document.getElementById('numPage');
                var totalPage = +document.getElementById('totalPage').textContent;
                switch (type) {
                    case 'start':
                        numPageElement.value = 1;
                        break;
                    case 'pre':
                        numPageElement.value = +numPageElement.value > 1 ? +numPageElement.value - 1 : +numPageElement.value;
                        break;
                    case 'next':
                        numPageElement.value = +numPageElement.value < totalPage ? +numPageElement.value + 1 : +numPageElement.value;
                        break;
                    case 'end':
                        numPageElement.value = totalPage;
                        break;
                }
                numPageChange();
            }

            function userItemClick(userId) {
                window.location.href = "http://localhost:9999/SWP_Project/admin-user-detail?userId=" + userId;
            }
        </script>

        <script>
            var order = {
                'type': 'none',
                'value': 'default'
            };
            var roleUserSelected = "all";
            var searchValue = "";
            var numPage = 1;

            function orderEvent(typeOrder) {
                if (typeOrder == order.type) {
                    order.value = toggleOrder(order.value);
                } else {
                    order.type = typeOrder;
                    order.value = 'asc';
                }

                var icons = document.querySelectorAll('#tableUser th i');
                icons.forEach(function (icon) {
                    icon.classList.add('hidden');
                })

                if (order.value == 'asc') {
                    event.target.querySelector('.fa-caret-up').classList.remove('hidden');
                }
                if (order.value == 'desc') {
                    event.target.querySelector('.fa-caret-down').classList.remove('hidden');
                }

                callUserList();
            }

            function toggleOrder(typeOrder) {
                switch (typeOrder) {
                    case 'default':
                        return 'asc';
                    case 'asc':
                        return 'desc';
                    case 'desc':
                        return 'default';
                }
            }

            function roleUserEvent() {
                var roleUsers = document.querySelectorAll('input[name="roleUserSelect"]');
                roleUsers.forEach(function (role) {
                    if (role.checked) {
                        role.previousElementSibling.classList.add('font-semibold');
                        roleUserSelected = role.value;
                    } else {
                        role.previousElementSibling.classList.remove('font-semibold');
                    }
                });
                order.value = 'default';
                var icons = document.querySelectorAll('#tableUser th i');
                icons.forEach(function (icon) {
                    icon.classList.add('hidden');
                })
                numPage = 1;
                callUserList();
            }

            function searchUser() {
                searchValue = event.target.value;
                numPage = 1;
                callUserList();
            }

            function numPageChange() {
                numPage = document.getElementById('numPage').value;
                callUserList();
            }


            function callUserList() {
                const xhr = new XMLHttpRequest();

                xhr.open('POST', '/SWP_Project/admin-user-list?order=' + encodeURIComponent(JSON.stringify(order))
                        + '&roleUser=' + encodeURIComponent(roleUserSelected)
                        + '&searchValue=' + encodeURIComponent(searchValue)
                        + '&numPage=' + encodeURIComponent(numPage)
                        , true);

                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        const response = JSON.parse(xhr.responseText);
                        var listUserResponse = response.users;

                        document.getElementById('totalPage').textContent = response.totalPage
                        document.getElementById('numPage').value = numPage;

                        var listUser = document.getElementById('listUsers');
                        listUser.innerHTML = '';
                        listUserResponse.forEach(function (user) {
                            var userElement = document.createElement('tr');
                            userElement.classList.add("odd:bg-white", "even:bg-gray-100", "cursor-pointer", "hover:bg-coffee-300");
                            userElement.setAttribute('onclick', 'userItemClick(' + user.id + ')');
                            var statusUser = user.active ? 'Active' : 'Deactive';
                            userElement.innerHTML =
                                    '<td class="py-2 px-4 border-b">' + user.username + '</td>' +
                                    '<td class="py-2 px-4 border-b">' + user.lastName + ' ' + user.firstName + '</td>' +
                                    '<td class="py-2 px-4 border-b">' + user.email + '</td>' +
                                    '<td class="py-2 px-4 border-b">' + user.phone + '</td>' +
                                    '<td class="py-2 px-4 border-b">' + user.role + '</td>' +
                                    '<td class="py-2 px-4 border-b">' + user.createdAt + '</td>' +
                                    '<td class="py-2 px-4 border-b">' + statusUser + '</td>';
                            listUser.appendChild(userElement);
                        });
                    }
                };

                // Send the request
                xhr.send();
            }
        </script>
    </body>
</html>
