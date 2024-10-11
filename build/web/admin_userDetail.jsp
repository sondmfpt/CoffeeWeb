<%-- 
    Document   : admin_userDetail
    Created on : Oct 10, 2024, 3:44:15 PM
    Author     : Son Duong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
        <link href="./output.css" rel="stylesheet">
    </head>
    <body>
        <c:set var="user" value="${USER}"/>
        <c:set var="userOrder" value="${USERORDER}"/>
        <div class="bg-gray-100 relative">
            <div class="flex">
                <!--Navigation-->
                <%@ include file="./include/admin-navigation.jsp" %>

                <!-- Main Content -->
                <div class="flex-1 p-10">
                    <div>
                        <h1 class="text-3xl font-semibold">Chỉnh sửa người dùng</h1>
                        <p class="mt-4">This is your main dashboard content.</p>
                    </div>
                    <div class="mx-auto">
                        <!--NAVIGATION-->
                        <div class="flex gap-5 justify-center items-center">
                            <p class="text-xl font-medium">Hồ sơ</p>
                            <p class="text-xl">Địa chỉ</p>
                            <p class="text-xl">Đơn hàng</p>
                        </div>
                        <hr class="border-gray-300 my-3">

                        <div class="bg-white border border-gray-200 rounded shadow-lg">
                            <div class="p-10">

                                <!--Info-->
                                <form action="./admin-update-user?id=${user.getId()}" method="POST" class="flex flex-col items-center hidden">
                                    <table class="w-2/3">
                                        <tr>
                                            <td class="text-end text-slate-500">Tên đăng nhập</td>
                                            <td class="py-2 px-5">${user.getUsername()}</td>
                                        </tr>
                                        <tr>
                                            <td class="text-end text-slate-500">Mật khẩu</td>
                                            <td class="py-2 px-5">
                                                <input class="px-2 py-2 border border-gray-200 rounded" type="text" value="${user.getPassword()}" name="password">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-end text-slate-500">Tên</td>
                                            <td class="py-2 px-5">
                                                <input class="px-2 py-2 border border-gray-200 rounded" type="text" value="${user.getFirstName()}" name="firstname">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-end text-slate-500">Họ</td>
                                            <td class="py-2 px-5">
                                                <input class="px-2 py-2 border border-gray-200 rounded" type="text" value="${user.getLastName()}" name="lastname">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-end text-slate-500">Email</td>
                                            <td class="py-2 px-5">
                                                <input class="px-2 py-2 border border-gray-200 rounded" type="email" value="${user.getEmail()}" name="email">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-end text-slate-500">Số điện thoại</td>
                                            <td class="py-2 px-5">
                                                <input class="px-2 py-2 border border-gray-200 rounded" type="text" value="${user.getPhone()}" name="phone">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-end text-slate-500">Giới tính</td>
                                            <td class="py-2 px-5 flex gap-5">
                                                <label for="gender-male">
                                                    <input id="gender-male" type="radio" value="male" name="gender" ${user.getGender() == 'Male' ? 'checked' : ''}>
                                                    Nam
                                                </label>
                                                <label for="gender-female">
                                                    <input id="gender-female" type="radio" value="female" name="gender" ${user.getGender() == 'Female' ? 'checked' : ''}>
                                                    Nữ
                                                </label>
                                                <label for="gender-other">
                                                    <input id="gender-other" type="radio" value="other" name="gender" ${user.getGender() == 'Other' ? 'checked' : ''}>
                                                    Khác
                                                </label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-end text-slate-500">Ngày sinh</td>
                                            <td class="py-2 px-5">
                                                <c:set var="date" value="${user.getDate()}" />
                                                <c:set var="year" value="${fn:substring(date, 0, 4)}" />
                                                <c:set var="month" value="${fn:substring(date, 5, 7)}" />
                                                <c:set var="day" value="${fn:substring(date, 8, 10)}" />
                                                <div class="my-2 grid grid-cols-12 gap-3">
                                                    <div class="col-span-5">
                                                        <select class="w-full border border-gray-300 rounded-md p-2 focus:outline-none focus:ring-2 focus:ring-blue-500" name="date-month" required>
                                                            <option value="" disabled>Month</option>
                                                            <option ${month == '01' ? 'selected' : ''} value="01">January</option>
                                                            <option ${month == '02' ? 'selected' : ''} value="02">February</option>
                                                            <option ${month == '03' ? 'selected' : ''} value="03">March</option>
                                                            <option ${month == '04' ? 'selected' : ''} value="04">April</option>
                                                            <option ${month == '05' ? 'selected' : ''} value="05">May</option>
                                                            <option ${month == '06' ? 'selected' : ''} value="06">June</option>
                                                            <option ${month == '07' ? 'selected' : ''} value="07">July</option>
                                                            <option ${month == '08' ? 'selected' : ''} value="08">August</option>
                                                            <option ${month == '09' ? 'selected' : ''} value="09">September</option>
                                                            <option ${month == '10' ? 'selected' : ''} value="10">October</option>
                                                            <option ${month == '11' ? 'selected' : ''} value="11">November</option>
                                                            <option ${month == '12' ? 'selected' : ''} value="12">December</option>
                                                        </select>
                                                    </div>
                                                    <!-- Day Dropdown -->
                                                    <div class="col-span-3">
                                                        <select class="w-full border border-gray-300 rounded-md p-2 focus:outline-none focus:ring-2 focus:ring-blue-500" name="date-day" required>
                                                            <option value="" disabled>Day</option>
                                                            <c:forEach var="dayOption" begin="1" end="31">
                                                                <option value="${dayOption < 10 ? '0' + dayOption : dayOption}" ${day == dayOption ? 'selected' : ''}>${dayOption}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                    <!-- Year Dropdown -->
                                                    <div class="col-span-4">
                                                        <select class="w-full border border-gray-300 rounded-md p-2 focus:outline-none focus:ring-2 focus:ring-blue-500" name="date-year" required>
                                                            <option value="" disabled>Year</option>
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
                                                    <option value="1" ${user.getRole() == 'ADMIN' ? 'selected' : ''}>Quản trị viên</option>
                                                    <option value="2" ${user.getRole() == 'CUSTOMER' ? 'selected' : ''}>Khách hàng</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-end text-slate-500">Trạng thái</td>
                                            <td class="py-2 px-5 flex gap-5">
                                                <label for='status-active'>
                                                    <input id='status-active' name="status" type='radio' value='active' ${user.isActive() == true ? 'checked' : ''}>
                                                    Active
                                                </label>
                                                <label for='status-deactive'>
                                                    <input id='status-deactive' name="status" type='radio' value='deactive' ${user.isActive() == false ? 'checked' : ''}>
                                                    Deactive
                                                </label>
                                            </td>
                                        </tr>
                                    </table>
                                    <div class="flex justify-center">
                                        <div id='saveForm' class="px-4 py-2 w-20 bg-coffee-500 rounded cursor-pointer text-center">Lưu</div>
                                    </div>
                                    <div id='confirmUpdate' class="flex justify-center items-center top-0 right-0 left-0 bottom-0 bg-gray-500/75 z-20 absolute hidden">
                                        <div class="bg-white rounded p-12 flex flex-col gap-10 justify-center items-center animate-[fadeIn_.5s_ease-out_,_moveInDownFull_.5s_ease-out]">
                                            <h1 class="text-3xl text-gray-800 text-center">Xác thực cập nhật!</h1>
                                            <div class="flex gap-5">
                                                <div id='reject' class="py-2 px-3 bg-red-500 rounded w-20 cursor-pointer">Quay lại</div>
                                                <input id='concept' type="submit" value='Đồng ý' class="py-2 px-3 bg-green-500 rounded w-20 cursor-pointer">
                                            </div>
                                        </div>
                                    </div>
                                </form>

                                <!--Address-->
                                <c:set var="userOrders" value="${USERORDER}"/>
                                <div class="flex flex-col gap-5">
                                    <c:forEach var="userOrder" items="${userOrders}">
                                        <div class="flex justify-between">
                                            <div class="flex flex-col gap-1">
                                                <div class="flex mb-2">
                                                    <p>${userOrder.getFullname()}</p>
                                                    <div class="border-r-2 border-gray-300 mx-2"></div>
                                                    <p class="text-gray-600">${userOrder.getPhone()}</p>
                                                </div>
                                                <div class="text-gray-600">
                                                    <p>${userOrder.getAddress()}</p>
                                                    <p>${userOrder.getAddressDetail()}</p>
                                                </div>
                                                <c:if test="${userOrder.isIsDefault()}">
                                                    <div class="border border-red-700 text-red-700 w-[75px] text-center">Mặc định</div>
                                                </c:if>
                                            </div>
                                            <div class="flex flex-col gap-2 text-end">
                                                <p class="text-blue-500">Cập nhật</p>
                                                <c:if test="${!userOrder.isIsDefault()}">
                                                    <p class="text-red-700">Xóa</p>
                                                    <div class="p-1 border border-gray-300 cursor-pointer">Thiết lập mặc định</div>
                                                </c:if>
                                            </div>
                                        </div>
                                        <hr class="border-gray-200">
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            <!--annotation-->
            <c:set var="statusUpdate" value="${STATUSUPDATE}"/>
            <c:if test="${statusUpdate.equals('success')}">
                <div id='updateSuccesfull' class="flex justify-center items-center top-0 right-0 left-0 bottom-0 bg-gray-500/75 z-20 absolute">
                    <div class="bg-white rounded p-12 flex flex-col gap-10 justify-center items-center animate-[fadeIn_.75s_ease-out_,_moveInDownFull_.75s_ease-out]">
                        <h1 class="text-3xl text-gray-800 text-center">Cập nhật tài khoản thành công!</h1>
                        <button id="conceptUpdateBtn" class="py-2 px-3 bg-green-500 rounded">Đồng ý</button>
                    </div>
                </div>
            </c:if>
        </div>

    </body>
    <script>
        var updateSuccessfull = document.getElementById('updateSuccesfull');
        var conceptUpdateBtn = document.getElementById('conceptUpdateBtn');
        if (updateSuccessfull) {
            conceptUpdateBtn.addEventListener('click', () => {
                updateSuccessfull.classList.add('hidden');
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
</html>
