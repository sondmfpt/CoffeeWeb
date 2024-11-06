<%-- 
    Document   : resetPassword
    Created on : Sep 17, 2024, 2:22:18 PM
    Author     : Son Duong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
        <c:set var="firstname" value="${USER_FIRSTNAME}"/>
        <c:set var="lastname" value="${USER_LASTNAME}"/>
        <c:set var="phone" value="${USER_PHONE}"/>
        <c:set var="email" value="${USER_EMAIL}"/>
        <div class="fixed top-0 bottom-0 right-0 left-0 bg-slate-600/40 z-20 flex justify-center items-center">
            <div class="bg-white rounded w-[30%]">
                <c:if test="${status.equals('enterAccount')}">
                    <form action="./reset-password?statusPost=checkUsername" class="p-5 flex items-center flex-col" method='POST'>
                        <h1 class="text-center text-xl font-bold text-slate-800">Enter your account need to reset</h1>
                        <input class="border border-gray-300 rounded text-md p-2 my-3 w-full" type="text" name="username" placeholder="Username">
                        <input class="py-2 px-3 w-full bg-green-500 rounded cursor-pointer text-white" type="submit"
                               value="Submit"/>
                    </form>
                </c:if>

                <c:if test="${status.equals('notFoundAccount')}">
                    <div class="p-5 flex items-center flex-col">
                        <h1 class="text-center text-xl font-bold text-slate-800">Can't found your account</h1>
                        <a href="./reset-password?status=enterAccount">Return</a>
                    </div>
                </c:if>

                <c:if test="${status.equals('chooseOption')}">
                    <div class="p-5 flex items-center flex-col">
                        <h1>Your account: <span class="font-bold">${firstname} ${lastname}</span></h1>
                        <h1 class="my-3 text-center text-xl font-bold text-slate-800">Choose option to reset</h1>
                        <form class="grid grid-cols-12 my-3" action="./reset-password?statusPost=sendCode" method="POST">
                            <c:if test="${phone != null}">
                                <div class="col-span-12">
                                    <input id="phone_option" name="optionReset" value="phone" type="radio">
                                    <label for="phone_option">Send OTP to phone number: <strong>${phone}</strong></label>
                                </div>
                            </c:if>
                            <c:if test="${email != null}">
                                <div class="col-span-12">
                                    <input id="email_option" name="optionReset" value="email" type="radio">
                                    <label for="email_option">Send code to email: <strong>${email}</strong></label>
                                </div>
                            </c:if>
                            <c:if test="${phone == null && email == null}">
                                <div class="col-span-12">
                                    <p>No option anymore!</p>
                                </div>
                            </c:if>
                            <div class="text-center col-span-12">
                                <input class="mt-3 col-span-3 py-2 px-3 bg-green-500 rounded cursor-pointer text-white col-span-4 w-full" type="submit"
                                       value="Submit"/>
                            </div>
                        </form>
                    </div>
                </c:if>

                <c:if test="${fn:contains(status, 'enterCode')}">
                    <form class="p-5 flex items-center flex-col" action="./reset-password?statusPost=enterCode_${fn:contains(status, 'email') ? "email" : "phone"}" method="POST">
                        <h1 class="my-3 text-center text-xl font-bold text-slate-800">
                            Check your 
                            <c:choose>
                                <c:when test="${fn:contains(status, 'email')}">
                                    gmail <span class="text-green-700">${email}</span>
                                </c:when>
                                <c:when test="${fn:contains(status, 'phone')}">
                                    phone number <span class="text-green-700">${phone}</span>
                                </c:when>
                            </c:choose>
                            and enter code
                        </h1>
                        <c:if test="${fn:contains(status, 'again')}">
                            <div>
                                <i class="text-red-500 p-3 bg-slate-300 inline-block rounded my-2 w-full">Code is wrong. Again Please!</i>
                            </div>
                        </c:if>
                        <input class="border border-gray-300 rounded text-md p-2 my-3 w-full" type="text" name="enterCode" placeholder="Enter Code">
                        <input class="mt-3 w-full py-2 px-3 bg-green-500 rounded cursor-pointer text-white col-span-4" type="submit"
                               value="Submit"/>
                    </form>
                </c:if>

                <c:if test="${fn:contains(status, 'resetPassword')}">
                    <div class="p-5 flex items-center flex-col">
                        <h1 class="my-3 text-center text-xl font-bold text-slate-800">Reset Password</h1>
                        <form class="" action="./reset-password?statusPost=newPassword" method="POST">
                            <c:if test="${fn:contains(status, 'errorFormat')}">
                                <div>
                                    <i class="text-green-600 p-3 bg-slate-300 inline-block rounded my-2 w-full">Error Format Password</i>
                                </div>
                            </c:if>
                            <input class="border border-gray-300 rounded text-md p-2 my-3 w-full" type="password" name="newPassword" placeholder="Enter new password">

                            <c:if test="${fn:contains(status, 'errorConfirm')}">
                                <div>
                                    <i class="text-green-600 p-3 bg-slate-300 inline-block rounded my-2 w-full">Confirm Password is not match!</i>
                                </div>
                            </c:if>
                            <input class="border border-gray-300 rounded text-md p-2 my-3 w-full" type="password" name="confirmPassword" placeholder="Confirm password">
                            <input class="mt-3 w-full py-2 px-3 bg-green-500 rounded cursor-pointer text-white col-span-4" type="submit"
                                   value="Submit"/>
                        </form>
                    </div>
                </c:if>


            </div>
        </div>
    </body>
</html>
