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
        <title>User List</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
        <link href="./output.css" rel="stylesheet">
    </head>
    <body>
        <c:set var="allUsers" value="${ALLUSERS}"/>
        <div class="bg-gray-100 min-h-screen">
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
                            <a href="./admin-add-user" class="px-4 py-3 rounded bg-gray-300 cursor-pointer">Thêm người dùng</a>
                        </div>
                        <div class="flex items-center gap-4">
                            <div class="relative">
                                <div class="relative group cursor-pointer">
                                    <i onclick="informationOptionShow()" class="fa-solid fa-circle-info"></i>
                                    <div class="hidden absolute group-hover:block bg-gray-200 w-36 -top-10 right-0 transition-all animate-[fadeIn_.25s_ease-out] duration-200 ease-in-out rounded">
                                        <p class="p-2">Hiển thị thông tin</p>
                                    </div>
                                </div>
                                <div id="informationOption" class="hidden absolute p-5 bg-white w-64 right-0 rounded shadow-md overflow-hidden">
                                    <p class="text-xl font-bold">Hiển thị thông tin:</p>
                                    <hr class="border-gray-300 py-1">
                                    <div class="flex flex-col gap-2">
                                        <label>
                                            <input type="checkbox" name="informationShow" onchange="informationChange()" value="username" checked>
                                            Tên người dùng
                                        </label>
                                        <label>
                                            <input type="checkbox" name="informationShow" onchange="informationChange()" value="firstname" checked>
                                            Tên
                                        </label>
                                        <label>
                                            <input type="checkbox" name="informationShow" onchange="informationChange()" value="lastname" checked>
                                            Họ
                                        </label>
                                        <label>
                                            <input type="checkbox" name="informationShow" onchange="informationChange()" value="email" checked>
                                            Email
                                        </label>
                                        <label>
                                            <input type="checkbox" name="informationShow" onchange="informationChange()" value="phone" checked>
                                            Số điện thoại
                                        </label>
                                        <label>
                                            <input type="checkbox" name="informationShow" onchange="informationChange()" value="role" checked>
                                            Vai trò
                                        </label>
                                        <label>
                                            <input type="checkbox" name="informationShow" onchange="informationChange()" value="date" checked>
                                            Ngày tạo
                                        </label>
                                        <label>
                                            <input type="checkbox" name="informationShow" onchange="informationChange()" value="status" checked>
                                            Trạng thái
                                        </label>
                                    </div>
                                    <hr class="border-gray-300 py-1">
                                    <div class="font-medium">
                                        Số lượng người dùng trong 1 trang: 
                                        <input class="w-8 border border-gray-300 rounded" onchange="numPerPageChange()" type="number" name="numPerPage" value="2" min="1">
                                    </div>
                                </div>
                            </div>
                            <div class="flex gap-1">
                                <button onclick="changePage('start')" class="flex justify-center items-center w-9 h-9 bg-gray-100 border border-gray-300 rounded"><i class="text-xs fa-solid fa-angles-left"></i></button>
                                <button onclick="changePage('pre')" class="flex justify-center items-center w-9 h-9 bg-gray-100 border border-gray-300 rounded"><i class="text-xs fa-solid fa-chevron-left"></i></button>
                                <input onchange="numPageChange()" id="numPage" name="numPage" type="number" class="text-center w-14 rounded border border-gray-300 no-spinner" value="1" max="5">
                                <div class="h-9 flex gap-1 items-center">
                                    trên 
                                    <span id="totalPage">${TOTALPAGE}</span>
                                </div>
                                <button onclick="changePage('next')" class="flex justify-center items-center w-9 h-9 bg-gray-100 border border-gray-300 rounded"><i class="text-xs fa-solid fa-chevron-right"></i></button>
                                <button onclick="changePage('end')" class="flex justify-center items-center w-9 h-9 bg-gray-100 border border-gray-300 rounded"><i class="text-xs fa-solid fa-angles-right"></i></button>
                            </div>
                        </div>
                    </div>
                    <div class="overflow-x-auto">
                        <table id='tableUser' class="min-w-full border-collapse border border-gray-300 text-left">
                            <thead class="bg-gray-200">
                                <tr>
                                    <th id="header-username" onclick="orderEvent('username')" class="py-2 px-4 border-b hover:bg-coffee-300 cursor-pointer">
                                        Tên người dùng
                                        <span class="hidden arrow-up">
                                            <i class="fa-solid fa-caret-up"></i>
                                        </span>
                                        <span class="hidden arrow-down">
                                            <i class="fa-solid fa-caret-down"></i>
                                        </span>
                                    </th>
                                    <th id="header-firstname" onclick="orderEvent('firstname')" class="py-2 px-4 border-b hover:bg-coffee-300 cursor-pointer">
                                        Tên
                                        <span class="hidden arrow-up">
                                            <i class="fa-solid fa-caret-up"></i>
                                        </span>
                                        <span class="hidden arrow-down">
                                            <i class="fa-solid fa-caret-down"></i>
                                        </span>
                                    </th>
                                    <th id="header-lastname" onclick="orderEvent('lastname')" class="py-2 px-4 border-b hover:bg-coffee-300 cursor-pointer">
                                        Họ
                                        <span class="hidden arrow-up">
                                            <i class="fa-solid fa-caret-up"></i>
                                        </span>
                                        <span class="hidden arrow-down">
                                            <i class="fa-solid fa-caret-down"></i>
                                        </span>
                                    </th>
                                    <th id="header-email" onclick="" class="py-2 px-4 border-b">Email</th>
                                    <th id="header-phone" onclick="" class="py-2 px-4 border-b">Số điện thoại</th>
                                    <th id="header-role" onclick="orderEvent('role')" class="py-2 px-4 border-b hover:bg-coffee-300 cursor-pointer">
                                        Vai trò
                                        <span class="hidden arrow-up">
                                            <i class="fa-solid fa-caret-up"></i>
                                        </span>
                                        <span class="hidden arrow-down">
                                            <i class="fa-solid fa-caret-down"></i>
                                        </span>
                                    </th>
                                    <th id="header-date" onclick="orderEvent('date')" class="py-2 px-4 border-b hover:bg-coffee-300 cursor-pointer">
                                        Ngày tạo
                                        <span class="hidden arrow-up">
                                            <i class="fa-solid fa-caret-up"></i>
                                        </span>
                                        <span class="hidden arrow-down">
                                            <i class="fa-solid fa-caret-down"></i>
                                        </span>
                                    </th>
                                    <th id="header-status" onclick="orderEvent('status')" class="py-2 px-4 border-b hover:bg-coffee-300 cursor-pointer">
                                        Trạng thái
                                        <span class="hidden arrow-up">
                                            <i class="fa-solid fa-caret-up"></i>
                                        </span>
                                        <span class="hidden arrow-down">
                                            <i class="fa-solid fa-caret-down"></i>
                                        </span>
                                    </th>
                                </tr>
                            </thead>
                            <tbody id="listUsers">
                                <c:forEach var="user" items="${allUsers}">
                                    <tr onclick="userItemClick(${user.getId()})" class="odd:bg-white even:bg-gray-100 cursor-pointer hover:bg-coffee-300">
                                        <td id="username" class="py-2 px-4 border-b">${user.getUsername()}</td>
                                        <td id="firstname" class="py-2 px-4 border-b">${user.getFirstName()}</td>
                                        <td id="lastname" class="py-2 px-4 border-b">${user.getLastName()}</td>
                                        <td id="email" class="py-2 px-4 border-b">${user.getEmail()}</td>
                                        <td id="phone" class="py-2 px-4 border-b">${user.getPhone()}</td>
                                        <td id="role" class="py-2 px-4 border-b">${user.getRole()}</td>
                                        <td id="date" class="py-2 px-4 border-b">${user.getCreatedAt()}</td>
                                        <td id="status" class="py-2 px-4 border-b">${user.isActive() ? 'Active' : 'Deactive'}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <script>
            // order by user's information
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

            //redirec to user detail
            function userItemClick(userId) {
                window.location.href = "admin-user-detail?userId=" + userId;
            }

            function informationOptionShow() {
                document.getElementById('informationOption').classList.toggle('hidden');
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
            var numPerPage = 2;

            // change type of order in user's information
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
                    event.target.querySelector('.arrow-up').classList.remove('hidden');
                    event.target.querySelector('.arrow-down').classList.add('hidden');
                }
                else if (order.value == 'desc') {
                    event.target.querySelector('.arrow-down').classList.remove('hidden');
                    event.target.querySelector('.arrow-up').classList.add('hidden');
                }else{
                    event.target.querySelector('.arrow-up').classList.add('hidden');
                    event.target.querySelector('.arrow-down').classList.add('hidden');
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

            function numPerPageChange() {
                numPerPage = document.querySelector('input[name="numPerPage"]').value;
                searchValue = document.querySelector('input[name="searchUser"]').value;
                numPage = document.querySelector('input[name="numPage"]').value;
                callUserList();
            }

            function informationChange() {
                var listInformation = document.querySelectorAll('input[name="informationShow"]');
                var leastOneInfoChosen = false;
                listInformation.forEach(function (info) {
                    var headerTable = document.getElementById('header-' + info.value);
                    var rowTable = document.querySelectorAll('#' + info.value);
                    if (info.checked) {
                        leastOneInfoChosen = true;
                        rowTable.forEach(function (row) {
                            row.classList.remove('hidden');
                        })
                        headerTable.classList.remove('hidden');
                    } else {
                        rowTable.forEach(function (row) {
                            row.classList.add('hidden');
                        })
                        headerTable.classList.add('hidden');
                    }
                })
                if (!leastOneInfoChosen) {
                    document.querySelectorAll('#tableUser td').forEach(function (row) {
                        row.classList.remove('hidden');
                    })
                    document.querySelectorAll('#tableUser th').forEach(function (row) {
                        row.classList.remove('hidden');
                    })
                }
            }


            function callUserList() {
                const xhr = new XMLHttpRequest();

                xhr.open('POST', '/SWP_Project/admin-user-list?order=' + encodeURIComponent(JSON.stringify(order))
                        + '&roleUser=' + encodeURIComponent(roleUserSelected)
                        + '&searchValue=' + encodeURIComponent(searchValue)
                        + '&numPage=' + encodeURIComponent(numPage)
                        + '&numPerPage=' + encodeURI(numPerPage)
                        , true);

                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        const response = JSON.parse(xhr.responseText);
                        var listUserResponse = response.users;
                        var totalPage = response.totalPage;
                        var totalProduct = response.totalProduct;

                        document.getElementById('totalPage').textContent = totalPage;
                        document.getElementById('numPage').value = numPage;
                        document.querySelector('input[name="numPerPage"]').setAttribute("max", totalProduct);
                        if (document.querySelector('input[name="numPerPage"]').value > totalProduct) {
                            document.querySelector('input[name="numPerPage"]').value = totalProduct;
                        }

                        var listUser = document.getElementById('listUsers');
                        listUser.innerHTML = '';
                        listUserResponse.forEach(function (user) {
                            var userElement = document.createElement('tr');
                            userElement.classList.add("odd:bg-white", "even:bg-gray-100", "cursor-pointer", "hover:bg-coffee-300");
                            userElement.setAttribute('onclick', 'userItemClick(' + user.id + ')');
                            var statusUser = user.active ? 'Active' : 'Deactive';
                            userElement.innerHTML =
                                    '<td id="username" class="py-2 px-4 border-b">' + user.username + '</td>' +
                                    '<td id="firstname" class="py-2 px-4 border-b">' + user.firstName + '</td>' +
                                    '<td id="lastname" class="py-2 px-4 border-b">' + user.lastName + '</td>' +
                                    '<td id="email" class="py-2 px-4 border-b">' + user.email + '</td>' +
                                    '<td id="phone" class="py-2 px-4 border-b">' + user.phone + '</td>' +
                                    '<td id="role" class="py-2 px-4 border-b">' + user.role + '</td>' +
                                    '<td id="date" class="py-2 px-4 border-b">' + user.createdAt + '</td>' +
                                    '<td id="status" class="py-2 px-4 border-b">' + statusUser + '</td>';
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
