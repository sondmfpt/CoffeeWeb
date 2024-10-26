<%-- 
    Document   : admin_addUser
    Created on : Oct 16, 2024, 2:51:15 AM
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
        <link href="../output.css" rel="stylesheet">
    </head>
    <body>
        <div class="bg-gray-100 h-screen">
            <div class="flex">
                <!--Navigation-->
                <%@ include file="../include/admin-navigation.jsp" %>

                <!-- Main Content -->
                <div class="flex-1 p-10">
                    <div>
                        <h1 class="text-3xl font-semibold">Thêm người dùng mới</h1>
                        <p class="mt-4">This is your main dashboard content.</p>
                    </div>

                    <div class="mx-auto">
                        <div class="bg-white border border-gray-200 rounded shadow-lg">
                            <div class="p-10">
                                <form action="./admin-add-user" method="POST" class="flex flex-col items-center">
                                    <table class="w-2/3">
                                        <tr>
                                            <td class="text-end text-slate-500">Tên đăng nhập</td>
                                            <td class="py-2 px-5">
                                                <input class="px-2 py-2 border border-gray-200 rounded" type="text" name="username">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-end text-slate-500">Mật khẩu</td>
                                            <td class="py-2 px-5">
                                                <input class="px-2 py-2 border border-gray-200 rounded" type="text" name="password">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-end text-slate-500">Tên</td>
                                            <td class="py-2 px-5">
                                                <input class="px-2 py-2 border border-gray-200 rounded" type="text" name="firstname">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-end text-slate-500">Họ</td>
                                            <td class="py-2 px-5">
                                                <input class="px-2 py-2 border border-gray-200 rounded" type="text" name="lastname">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-end text-slate-500">Email</td>
                                            <td class="py-2 px-5">
                                                <input class="px-2 py-2 border border-gray-200 rounded" type="email" name="email">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-end text-slate-500">Số điện thoại</td>
                                            <td class="py-2 px-5">
                                                <input class="px-2 py-2 border border-gray-200 rounded" type="text" name="phone">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-end text-slate-500">Giới tính</td>
                                            <td class="py-2 px-5 flex gap-5">
                                                <label for="gender-male">
                                                    <input id="gender-male" type="radio" value="male" name="gender">
                                                    Nam
                                                </label>
                                                <label for="gender-female">
                                                    <input id="gender-female" type="radio" value="female" name="gender">
                                                    Nữ
                                                </label>
                                                <label for="gender-other">
                                                    <input id="gender-other" type="radio" value="other" name="gender">
                                                    Khác
                                                </label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-end text-slate-500">Ngày sinh</td>
                                            <td class="py-2 px-5">
                                                <div class="my-2 flex gap-3 flex-wrap gap-3">
                                                    <!-- Day Dropdown -->
                                                    <div class="">
                                                        <select class="w-full border border-gray-300 rounded-md p-2 focus:outline-none focus:ring-2 focus:ring-blue-500" name="date-day" required>
                                                            <option value="" selected disabled>Ngày</option>
                                                            <c:forEach var="dayOption" begin="1" end="31">
                                                                <option value="${dayOption < 10 ? '0' + dayOption : dayOption}">${dayOption}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                    <!--Month Dropdown-->
                                                    <div class="">
                                                        <select class="w-full border border-gray-300 rounded-md p-2 focus:outline-none focus:ring-2 focus:ring-blue-500" name="date-month" required>
                                                            <option value="" selected disabled>Tháng</option>
                                                            <option value="01">Tháng 1</option>
                                                            <option value="02">Tháng 2</option>
                                                            <option value="03">Tháng 3</option>
                                                            <option value="04">Tháng 4</option>
                                                            <option value="05">Tháng 5</option>
                                                            <option value="06">Tháng 6</option>
                                                            <option value="07">Tháng 7</option>
                                                            <option value="08">Tháng 8</option>
                                                            <option value="09">Tháng 9</option>
                                                            <option value="10">Tháng 10</option>
                                                            <option value="11">Tháng 11</option>
                                                            <option value="12">Tháng 12</option>
                                                        </select>
                                                    </div>
                                                    <!-- Year Dropdown -->
                                                    <div class="">
                                                        <select class="w-full border border-gray-300 rounded-md p-2 focus:outline-none focus:ring-2 focus:ring-blue-500" name="date-year" required>
                                                            <option value="" selected disabled>Năm</option>
                                                            <c:forEach var="i" begin="0" end="${currentYear - 1900}">
                                                                <option value="${currentYear - i}" ${year == currentYear - i ? 'selected' : ''}>${currentYear - i}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-end text-slate-500">Vai trò</td>
                                            <td class="py-2 px-5 flex gap-5">
                                                <select name="roleId" class="px-2 py-2 border border-gray-200 rounded">
                                                    <option value="1">Quản trị viên</option>
                                                    <option value="2">Khách hàng</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-end text-slate-500">Trạng thái</td>
                                            <td class="py-2 px-5 flex gap-5">
                                                <label for='status-active'>
                                                    <input id='status-active' name="status" type='radio' value='active'>
                                                    Active
                                                </label>
                                                <label for='status-deactive'>
                                                    <input id='status-deactive' name="status" type='radio' value='deactive'>
                                                    Deactive
                                                </label>
                                            </td>
                                        </tr>
                                    </table>
                                    <div class="flex justify-center">
                                        <div id='saveForm' class="px-4 py-2 w-20 bg-coffee-500 rounded cursor-pointer text-center">Thêm</div>
                                    </div>
                                    <div id='confirmUpdate' class="flex justify-center items-center top-0 right-0 left-0 bottom-0 bg-gray-500/75 z-20 absolute hidden">
                                        <div class="bg-white rounded p-12 flex flex-col gap-10 justify-center items-center animate-[fadeIn_.5s_ease-out_,_moveInDownFull_.5s_ease-out]">
                                            <h1 class="text-3xl text-gray-800 text-center font-bold">Bạn có chắc chắn thêm người dùng?</h1>
                                            <label class="flex items-center gap-2">
                                                <input type="checkbox" name="sendForUser" value="Yes">
                                                Gửi thông báo đến email người dùng
                                            </label>
                                            <div class="flex gap-5">
                                                <div id='reject' class="py-2 px-3 bg-red-500 rounded w-20 cursor-pointer">Quay lại</div>
                                                <input id='concept' type="submit" value='Đồng ý' class="py-2 px-3 bg-green-500 rounded w-20 cursor-pointer">
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--annotation-->
            <c:set var="statusAdd" value="${STATUS}"/>
            <c:if test="${statusAdd.equals('success')}">
                <div id='addSuccesfull' class="flex justify-center items-center top-0 right-0 left-0 bottom-0 bg-gray-500/75 z-20 absolute">
                    <div class="bg-white rounded p-12 flex flex-col gap-10 justify-center items-center animate-[fadeIn_.75s_ease-out_,_moveInDownFull_.75s_ease-out]">
                        <h1 class="text-3xl text-gray-800 text-center font-bold">Thêm người dùng thành công!</h1>
                        <button id="conceptBtn" class="py-2 px-3 bg-green-500 rounded">Đồng ý</button>
                    </div>
                </div>
            </c:if>
        </div>
        <script>
            var addSuccessfull = document.getElementById('addSuccesfull');
            var conceptBtn = document.getElementById('conceptBtn');
            if (addSuccessfull) {
                conceptBtn.addEventListener('click', () => {
                    addSuccessfull.classList.add('hidden');
                    // Remove url
                    const currentUrl = new URL(window.location.href);
                    const searchParams = currentUrl.searchParams;
                    searchParams.delete('status');
                    const newUrl = currentUrl.pathname;
                    window.history.replaceState({}, '', newUrl);
                })
            }

            var saveForm = document.getElementById('saveForm');
            var confirmUpdate = document.getElementById('confirmUpdate');
            var reject = document.getElementById('reject');

            saveForm.addEventListener('click', () => {
                confirmUpdate.classList.remove('hidden');
            })

            reject.addEventListener('click', () => {
                confirmUpdate.classList.add('hidden');
            })
        </script>
    </body>
</html>
