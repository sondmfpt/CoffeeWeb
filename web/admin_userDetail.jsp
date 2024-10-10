<%-- 
    Document   : admin_userDetail
    Created on : Oct 10, 2024, 3:44:15 PM
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
        <div class="bg-gray-100 h-screen">
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
                            <p class="text-xl">Hồ sơ</p>
                            <p class="text-xl">Hồ sơ</p>
                        </div>
                        <hr class="border-gray-300 my-3">

                        <!--Info-->
                        <div class="bg-white border border-gray-200 rounded">
                            <div class="p-10">
                                <table>
                                    <tr>
                                        <td>Tên đăng nhập</td>
                                        <td>sondm</td>
                                    </tr>
                                    <tr>
                                        <td>Mật khẩu</td>
                                        <td>
                                            <input type="text" value="123" name="password">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Tên</td>
                                        <td>
                                            <input type="text" value="duong minh son" name="firstname">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Họ</td>
                                        <td>
                                            <input type="text" value="duong minh" name="lastname">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Email</td>
                                        <td>
                                            <input type="email" value="abc@abc" name="email">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Số điện thoại</td>
                                        <td>
                                            <input type="text" value="0852187503" name="phone">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Giới tính</td>
                                        <td>
                                            <input type="radio" value="male" name="gender">Nam
                                            <input type="radio" value="female" name="gender">Nữ
                                            <input type="radio" value="other" name="gender">Khác
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Ngày sinh</td>
                                        <td>
                                            <div class="my-2 grid grid-cols-12 gap-3">
                                                <div class="col-span-5">
                                                    <select class="w-full border border-gray-300 rounded-md p-2 focus:outline-none focus:ring-2 focus:ring-blue-500" name="date-month" required>
                                                        <option value="" disabled selected>Month</option>
                                                        <option value="01">January</option>
                                                        <option value="02">February</option>
                                                        <option value="03">March</option>
                                                        <option value="04">April</option>
                                                        <option value="05">May</option>
                                                        <option value="06">June</option>
                                                        <option value="07">July</option>
                                                        <option value="08">August</option>
                                                        <option value="09">September</option>
                                                        <option value="10">October</option>
                                                        <option value="11">November</option>
                                                        <option value="12">December</option>
                                                    </select>
                                                </div>
                                                <!-- Day Dropdown -->
                                                <div class="col-span-3">
                                                    <select class="w-full border border-gray-300 rounded-md p-2 focus:outline-none focus:ring-2 focus:ring-blue-500" name="date-day" required>
                                                        <option value="" disabled selected>Day</option>
                                                        <c:forEach var="day" begin="1" end="31">
                                                            <option value="${day < 10 ? '0' + day : day}">${day}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                                <!-- Year Dropdown -->
                                                <div class="col-span-4">
                                                    <select class="w-full border border-gray-300 rounded-md p-2 focus:outline-none focus:ring-2 focus:ring-blue-500" name="date-year" required>
                                                        <option value="" disabled selected>Year</option>
                                                        <c:forEach var="i" begin="0" end="${currentYear - 1900}">
                                                            <option value="${currentYear - i}">${currentYear - i}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>

                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
