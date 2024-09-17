<%-- 
    Document   : resetPassword
    Created on : Sep 17, 2024, 2:22:18 PM
    Author     : Son Duong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reset Password</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
        <link href="./output.css" rel="stylesheet">
    </head>
    <body>
        <c:set var="status" value="${RESET_STATUS}"/>
        <div class="fixed top-0 bottom-0 right-0 left-0 bg-slate-600/40 z-20 flex justify-center items-center">
            <div class="bg-white rounded w-1/4">
                <c:if test="${status.equals('enterAccount')}">
                    <form action="./reset-password?statusPost=checkUsername" class="p-5 flex items-center flex-col" method='POST'>
                        <h1 class="text-center text-xl font-bold text-slate-800">Enter your account need to reset</h1>
                        <input class="border border-gray-300 rounded text-md p-2 my-3 w-full" type="text" name="username" placeholder="Username">
                        <input class="py-2 px-3 w-full bg-green-500 rounded cursor-pointer text-white" type="submit"
                               value="Submit"/>
                    </form>
                </c:if>

                <c:if test="${status.equals('notFoundAccount')}">
                    <div class="p-5">
                        <h1 class="text-center text-xl font-bold text-slate-800">Can't found your account</h1>
                        <a href="./reset-password?status=enterAccount">Return</a>
                    </div>
                </c:if>

                <c:if test="${status.equals('chooseOption')}">
                    <c:set var="user" value="${USER}"/>
                    <div class="p-5">
                        <h1>Your account: <span class="font-bold">${user.getFirstName()} ${user.getLastName()}</span></h1>
                        <h1 class="my-3 text-center text-xl font-bold text-slate-800">Choose option to reset</h1>
                        <form class="grid grid-cols-12 my-3" action="./reset-password?statusPost=sendCode" method="POST">
                            <div class="col-span-12">
                                <input name="optionReset" value="phone" type="radio">
                                <label>Send OTP to phone number: ${user.getPhone()}</label>
                            </div>
                            <div class="col-span-12">
                                <input name="optionReset" value="email" type="radio">
                                <label>Send Code to email: ${user.getEmail()}</label>
                            </div>
                            <input class="mt-3 col-span-3 py-2 px-3 bg-green-500 rounded cursor-pointer text-white col-span-4" type="submit"
                                   value="Submit"/>
                        </form>
                    </div>
                </c:if>
            </div>
        </div>
    </body>
</html>
