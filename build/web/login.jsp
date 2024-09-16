<%-- 
    Document   : login
    Created on : Sep 11, 2024, 9:16:59 PM
    Author     : Son Duong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
        <link href="./output.css" rel="stylesheet">
    </head>
    <body>
        <c:set var="status" value="${LOGINSTATUS}"/>
        <c:set var="regisErrors" value="${REGIS_ERRORS}"/>
        <img class="absolute h-full w-full object-cover"
             src="./img/pexels-n-voitkevich-7852566.jpg" alt="">
        <div class="flex flex-col justify-center items-center h-screen max-w-5xl mx-auto">
            <div class="rounded w-full grid grid-cols-12 bg-white z-10">
                <div class="col-span-5">
                    <img class="w-full h-full object-cover rounded-l"
                         src="./img/pexels-photo-302896.webp"
                         alt="Coffee">
                </div>

                <!-- Login -->
                <div id="loginForm" class="col-span-7 flex flex-col justify-center items-center">
                    <div class="max-w-md">
                        <div class="mb-5 text-center">
                            <h1 class="text-center text-xl font-bold text-slate-800">Welcome Back</h1>
                            <p class="text-gray-500">Enter your account credentials to view your orders</p>
                        </div>
                        <form class="" action="./login" method="POST">

                            <c:if test="${status.equals('error')}">
                                <div>
                                    <i class="text-red-500 p-3 bg-slate-300 inline-block rounded my-2 w-full">Your username or password is wrong</i>
                                </div>
                            </c:if>

                            <c:if test="${status.equals('logout')}">
                                <div>
                                    <i class="text-green-600 p-3 bg-slate-300 inline-block rounded my-2 w-full">You have been logged
                                        out</i>
                                </div>
                            </c:if>
                            
                            <c:if test="${status.equals('regisSuccess')}">
                                <div>
                                    <i class="text-green-600 p-3 bg-green-200 inline-block rounded my-2 w-full">Register successfully!</i>
                                </div>
                            </c:if>
                            <div class="my-2">
                                <label for="username_login">Username</label>
                                <input id="username_login" class="border border-gray-300 rounded text-md p-2 my-1 w-full" type="text"
                                       name="username"
                                       placeholder="Username" required/><br>
                            </div>
                            <div class="my-2">
                                <label for="password_login">Password</label>
                                <input id="password_login" class="border border-gray-300 rounded text-md p-2 my-1 w-full"
                                       type="password"
                                       name="password"
                                       placeholder="Password" required/><br>
                            </div>
                            <a class="block text-end text-blue-500 text-sm" href="#">Forgot your password?</a>
                            <input class="py-2 px-3 my-3 w-full bg-green-500 rounded cursor-pointer text-white" type="submit"
                                   value="Login"/>
                        </form>
                        <p class="text-sm text-center">Don't have an account?
                            <a id="loginToggle" class="text-blue-500 cursor-pointer">Sign Up</a>

                        </p>

                    </div>
                </div>

                <!-- Sign Up -->
                <div id="signUpForm" class="col-span-7 flex flex-col justify-center items-center hidden">
                    <div class="max-w-md">
                        <div class="mb-5 text-center">
                            <h1 class="text-center text-xl font-bold text-slate-800">Registration</h1>
                            <p class="text-gray-500">Complete your profile by filling in this account creation form</p>
                        </div>
                        <form class="" action="./registration" method="POST">

                            <div class="my-2 relative">
                                <c:if test="${regisErrors.getDupplicatedUsername() != null}">
                                    <div class="absolute text-xs bg-yellow-200 rounded p-3 right-0 top-0 translate-x-3/4">${regisErrors.getDupplicatedUsername()}!</div>
                                </c:if>
                                <c:if test="${regisErrors.getNotFormatUsername() != null}">
                                    <div class="absolute text-xs bg-yellow-200 rounded p-3 right-0 top-0 translate-x-3/4">${regisErrors.getNotFormatUsername()}!</div>
                                </c:if>
                                <label for="username_regis">Username</label>
                                <input id="username_regis"
                                       class="border border-gray-300 rounded text-md p-2 my-1 w-full focus:outline-none focus:ring-2 focus:ring-blue-500"
                                       type="text"
                                       name="username"
                                       placeholder="Username" required/><br>
                            </div>
                            <div class="my-2 relative">
                                <c:if test="${regisErrors.getNotFormatPassword() != null}">
                                    <ul class="absolute text-xs bg-yellow-200 rounded p-3 right-0 top-0 translate-x-3/4">
                                        <c:forEach var="error" items="${regisErrors.getNotFormatPassword()}">
                                            <li>${error}</li>
                                        </c:forEach>
                                    </ul>
                                </c:if>
                                <label for="password_regis">Password</label>
                                <input id="password_regis"
                                       class="border border-gray-300 rounded text-md p-2 my-1 w-full focus:outline-none focus:ring-2 focus:ring-blue-500"
                                       type="password"
                                       name="password"
                                       placeholder="Password" required/><br>
                            </div>
                            <div class="my-2">
                                <div class="flex justify-between gap-3">
                                    <div>
                                        <label for="firstName">FirstName</label>
                                        <input id="firstName"
                                               class="w-full border border-gray-300 rounded text-md p-2 my-1 focus:outline-none focus:ring-2 focus:ring-blue-500"
                                               type="text" name="firstname" placeholder="First Name" required/>
                                    </div>
                                    <div>
                                        <label for="lastName">LastName</label>
                                        <input id="lastName"
                                               class="w-full border border-gray-300 rounded text-md p-2 my-1 focus:outline-none focus:ring-2 focus:ring-blue-500"
                                               type="text" name="lastname" placeholder="Last Name" required/>
                                    </div>
                                </div>
                            </div>

                            <div class="my-2 flex gap-5">
                                <p>Gender: </p>
                                <div class="flex gap-4">
                                    <div>
                                        <label for="male">Male</label>
                                        <input id="male" type="radio" name="gender" value="Male" required>
                                    </div>
                                    <div>
                                        <label for="female">Female</label>
                                        <input id="female" type="radio" name="gender" value="Female" required>
                                    </div>
                                    <div>
                                        <label for="other">Other</label>
                                        <input id="other" type="radio" name="gender" value="Other" required>
                                    </div>                        
                                </div>
                            </div>

                            <div class="my-2 relative">
                                <c:if test="${regisErrors.getDupplicatedEmail() != null}">
                                    <div class="absolute text-xs bg-yellow-200 rounded p-3 right-0 top-0 translate-x-3/4">${regisErrors.getDupplicatedEmail()}</div>
                                </c:if>
                                <label for="email">Email</label>
                                <input id="email"
                                       class="border border-gray-300 rounded text-md p-2 my-1 w-full focus:outline-none focus:ring-2 focus:ring-blue-500"
                                       type="email"
                                       name="email"
                                       placeholder="Email" required/><br>
                            </div>

                            <div class="my-2">
                                <p>Date of Birth</p>
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
                            </div>


                            <input class="py-2 px-3 my-3 w-full bg-green-500 rounded cursor-pointer text-white" type="submit"
                                   value="Create Account"/>
                        </form>
                        <p class="text-sm text-center">Do you have account?
                            <a id="signUpToggle" class="text-blue-500 cursor-pointer">Sign In</a>
                        </p>
                    </div>
                </div>

            </div>
        </div>

        <script>
            document.getElementById("loginToggle").addEventListener("click", function () {
                window.location.replace('/SWP_Project/registration');
            });
            document.getElementById("signUpToggle").addEventListener("click", function () {
                window.location.replace('/SWP_Project/login');
            });

            if (window.location.pathname === '/SWP_Project/registration') {
                document.getElementById("loginForm").classList.remove("hidden");
                document.getElementById("signUpForm").classList.add("hidden");

            }
            if (window.location.pathname === '/SWP_Project/registration') {
                document.getElementById("loginForm").classList.add("hidden");
                document.getElementById("signUpForm").classList.remove("hidden");
            }
        </script>
    </body>
</html>