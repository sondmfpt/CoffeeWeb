<%-- 
    Document   : admin_userDetail
    Created on : Oct 10, 2024, 3:44:15 PM
    Author     : Son Duong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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
                            <label class="text-xl cursor-pointer border-b-2 border-b-coffee-500">
                                Hồ sơ
                                <input onchange="typeInfoChange()" type="radio" name="typeInfo" value="profile" class="hidden">
                            </label>
                            <label class="text-xl cursor-pointer">
                                Địa chỉ
                                <input onchange="typeInfoChange()" type="radio" name="typeInfo" value="address" class="hidden">
                            </label>
                            <label class="text-xl cursor-pointer">
                                Đơn hàng
                                <input onchange="typeInfoChange()" type="radio" name="typeInfo" value="order" class="hidden">
                            </label>
                            <p></p>
                        </div>
                        <hr class="border-gray-300 my-3">

                        <!--Profile-->
                        <div id="profile" class="bg-white border border-gray-200 rounded shadow-lg">
                            <div class="p-10 flex justify-center gap-10">
                                <form action="./admin-update-user?id=${user.getId()}" method="POST" class="flex flex-col items-center">
                                    <table class="w-full">
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
                                                <div class="my-2 flex gap-3 flex-wrap gap-3">
                                                    <!-- Day Dropdown -->
                                                    <div class="">
                                                        <select class="w-full border border-gray-300 rounded-md p-2 focus:outline-none focus:ring-2 focus:ring-blue-500" name="date-day" required>
                                                            <option value="" disabled>Day</option>
                                                            <c:forEach var="dayOption" begin="1" end="31">
                                                                <option value="${dayOption < 10 ? '0' + dayOption : dayOption}" ${day == dayOption ? 'selected' : ''}>${dayOption}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                    <!--Month Dropdown-->
                                                    <div class="">
                                                        <select class="w-full border border-gray-300 rounded-md p-2 focus:outline-none focus:ring-2 focus:ring-blue-500" name="date-month" required>
                                                            <option value="" disabled>Month</option>
                                                            <option ${month == '01' ? 'selected' : ''} value="01">Tháng 1</option>
                                                            <option ${month == '02' ? 'selected' : ''} value="02">Tháng 2</option>
                                                            <option ${month == '03' ? 'selected' : ''} value="03">Tháng 3</option>
                                                            <option ${month == '04' ? 'selected' : ''} value="04">Tháng 4</option>
                                                            <option ${month == '05' ? 'selected' : ''} value="05">Tháng 5</option>
                                                            <option ${month == '06' ? 'selected' : ''} value="06">Tháng 6</option>
                                                            <option ${month == '07' ? 'selected' : ''} value="07">Tháng 7</option>
                                                            <option ${month == '08' ? 'selected' : ''} value="08">Tháng 8</option>
                                                            <option ${month == '09' ? 'selected' : ''} value="09">Tháng 9</option>
                                                            <option ${month == '10' ? 'selected' : ''} value="10">Tháng 10</option>
                                                            <option ${month == '11' ? 'selected' : ''} value="11">Tháng 11</option>
                                                            <option ${month == '12' ? 'selected' : ''} value="12">Tháng 12</option>
                                                        </select>
                                                    </div>
                                                    <!-- Year Dropdown -->
                                                    <div class="">
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
                                            <h1 class="text-3xl text-gray-800 text-center font-bold">Xác thực cập nhật!</h1>
                                            <label class="flex items-center gap-2">
                                                <input type="checkbox" name="sendForUser" value="Yes">
                                                Gửi thông báo đến email người dùng
                                            </label>
                                            <div class="flex gap-5">
                                                <div id='reject' class="py-2 px-3 bg-red-500 rounded w-24 text-center cursor-pointer">Quay lại</div>
                                                <input id='concept' type="submit" value='Đồng ý' class="py-2 px-3 bg-green-500 rounded w-24 text-center cursor-pointer">
                                            </div>
                                        </div>
                                    </div>
                                </form>

                                <div class="flex flex-col gap-5 justify-center items-center">
                                    <div class="rounded-full overflow-hidden w-32">
                                        <img src="./img/avatar/${user.getAvatar()}">
                                    </div>
                                    <div class="px-3 py-2 border border-gray-200 cursor-pointer">Chọn ảnh</div>
                                    <div class="text-gray-500">
                                        <p>Dung lượng ảnh tối đa 1MB</p>
                                        <p>Định dạng: .JPEG, .PNG</p>
                                    </div>
                                    <div>
                                        <iframe width="320" height="180" src="https://www.youtube.com/embed/sIVt9O-PmKQ" title="Giới Thiệu Khóa Học React TypeScript Pro | Những Kiến Thức Fresher React Cần Biết" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
                                    </div>
                                    <div class="px-3 py-2 border border-gray-200 cursor-pointer">Chọn video</div>
                                </div>
                            </div>
                        </div>

                        <!--Address-->
                        <div id="address" class="bg-white border border-gray-200 rounded shadow-lg hidden">
                            <div class="p-10">
                                <div class="flex flex-col gap-5">
                                    <c:set var="userOrders" value="${USERORDER}"/>
                                    <c:if test="${userOrders.size() == 0}">
                                        <h1 class="text-2xl font-bold text-center">Chưa cập nhật địa chỉ!</h1>
                                    </c:if>
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
                                                <!--<p class="text-blue-500 cursor-pointer">Cập nhật</p>-->
                                                <c:if test="${!userOrder.isIsDefault()}">
                                                    <a href="./remove-user-address?userId=${user.getId()}&addressId=${userOrder.getId()}" class="text-red-700 cursor-pointer">Xóa</a>
                                                    <!--<div class="p-1 border border-gray-300 cursor-pointer">Thiết lập mặc định</div>-->
                                                </c:if>
                                            </div>
                                        </div>
                                        <hr class="border-gray-200">
                                    </c:forEach>
                                </div>
                            </div>
                        </div>

                        <!--Order-->
                        <div id="order" class="hidden">
                            <div class="flex flex-col gap-5">
                                <c:set var="orders" value="${ORDERS}"/>
                                <c:if test="${orders.size() == 0}">
                                    <h1 class="text-2xl font-bold text-center">Chưa có đơn hàng nào!</h1>
                                </c:if>
                                <c:forEach var="order" items="${orders}">
                                    <!--order-->
                                    <div class="flex flex-col bg-white shadow-lg p-8 rounded">
                                        <div>
                                            <c:if test="${order.getStatus() == 'pending'}">
                                                <p class="text-yellow-400 text-end uppercase">
                                                    Đang xử lý
                                                </p>
                                            </c:if>
                                            <c:if test="${order.getStatus() == 'shipping'}">
                                                <p class="text-red-600 text-end uppercase">
                                                    Đang giao hàng
                                                </p>
                                            </c:if>
                                            <c:if test="${order.getStatus() == 'completed'}">
                                                <p class="text-green-600 text-end uppercase">
                                                    Hoàn thành
                                                </p>
                                            </c:if>
                                        </div>
                                        <hr class="border-gray-200">
                                        <div class="flex flex-col">
                                            <!--product-->
                                            <c:forEach var="orderItem" items="${order.getOrderItemList()}">
                                                <a href="./product-detail?productId=${orderItem.getProduct().getId()}" class="flex justify-between cursor-pointer rounded p-2 hover:bg-coffee-200">
                                                    <div class="flex gap-3">
                                                        <div class="w-20 h-20 bg-red-500 rounded overflow-hidden">
                                                            <img src="./img/${orderItem.getProduct().getThumbnailUrl()}">
                                                        </div>
                                                        <div class="flex flex-col gap-1">
                                                            <p class="line-clamp-1">${orderItem.getProduct().getName()}</p>
                                                            <c:set var="attribute" value="${orderItem.getProductVariant().getAttribute()}"/>
                                                            <div class="text-gray-500">
                                                                <c:forEach var="key" items="${attribute.keys()}">
                                                                    <p>${key}: ${attribute.get(key)}</p>
                                                                </c:forEach>
                                                            </div>
                                                            <p>x${orderItem.getQuantity()}</p>
                                                        </div>
                                                    </div>
                                                    <div>
                                                        <p><fmt:formatNumber value="${orderItem.getTotalPrice()}" pattern="#,##0" />đ</p>
                                                    </div>
                                                </a>
                                                <hr class="border-gray-200">
                                            </c:forEach>
                                            <!--product-->
                                        </div>
                                        <div class="flex justify-between mt-2">
                                            <p class="text-gray-500">Ngày đặt hàng: ${order.getDate()}</p>
                                            <p>Tổng tiền: <span class="text-2xl text-coffee-500"><fmt:formatNumber value="${order.getTotalPrice()}" pattern="#,##0"/>đ</span></p>
                                        </div>
                                    </div>
                                </c:forEach>
                                <!--order-->
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
                        <h1 class="text-3xl text-gray-800 text-center font-bold">Cập nhật tài khoản thành công!</h1>
                        <button id="conceptUpdateBtn" class="py-2 px-3 bg-green-500 rounded">Đồng ý</button>
                    </div>
                </div>
            </c:if>
        </div>

    </body>
    <script>
        var typeInfoOptions = document.querySelectorAll('input[name="typeInfo"]');
        function typeInfoChange() {
            typeInfoOptions.forEach(function (type) {
                if (type.checked) {
                    var currentUrl = new URL(window.location.href);
                    var searchParams = currentUrl.searchParams;
                    searchParams.set('typeInfo', type.value);
                    var newUrl = currentUrl.pathname + '?' + searchParams.toString();
                    window.history.replaceState({}, '', newUrl);
                    type.parentElement.classList.add('border-b-2', 'border-b-coffee-500');
                    document.getElementById(type.value).classList.remove('hidden');
                } else {
                    type.parentElement.classList.remove('border-b-2', 'border-b-coffee-500');
                    document.getElementById(type.value).classList.add('hidden');
                }
            })
        }
        var typeInfo = new URL(window.location.href).searchParams.get('typeInfo');
        if (typeInfo == null) {
            var currentUrl = new URL(window.location.href);
            var searchParams = currentUrl.searchParams;
            searchParams.set('typeInfo', 'profile');
            var newUrl = currentUrl.pathname + '?' + searchParams.toString();
            window.location.href = newUrl;
        }
        typeInfoOptions.forEach(function (type) {
            if (type.value == typeInfo) {
                type.parentElement.classList.add('border-b-2', 'border-b-coffee-500');
                document.getElementById(type.value).classList.remove('hidden');
            } else {
                type.parentElement.classList.remove('border-b-2', 'border-b-coffee-500');
                document.getElementById(type.value).classList.add('hidden');
            }
        })

    </script>

    <script>
        var updateSuccessfull = document.getElementById('updateSuccesfull');
        var conceptUpdateBtn = document.getElementById('conceptUpdateBtn');
        if (updateSuccessfull) {
            conceptUpdateBtn.addEventListener('click', () => {
                updateSuccessfull.classList.add('hidden');
                // Remove url
                const currentUrl = new URL(window.location.href);
                const searchParams = currentUrl.searchParams;
                searchParams.delete('status');
                const newUrl = currentUrl.pathname + '?' + searchParams.toString();
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

</html>
