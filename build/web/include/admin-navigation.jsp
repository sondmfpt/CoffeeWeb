<%-- 
    Document   : admin-navigation
    Created on : Oct 8, 2024, 8:59:41 PM
    Author     : Son Duong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="w-64 h-screen bg-gray-800 shadow-md">
            <div class="p-6">
                <h2 class="text-white text-2xl font-bold">Admin Page</h2>
            </div>
            <nav class="mt-10">
                <ul>
                    <li class="mb-6">
                        <a href="products" class="flex items-center text-gray-300 hover:bg-gray-700 hover:text-white py-2 px-4 transition-colors duration-200 rounded-lg">
                            Products
                        </a>
                    </li>
                    <li class="mb-6">
                        <a href="#" class="flex items-center text-gray-300 hover:bg-gray-700 hover:text-white py-2 px-4 transition-colors duration-200 rounded-lg">
                            Users
                        </a>
                    </li>
                    <li class="mb-6">
                        <a href="#" class="flex items-center text-gray-300 hover:bg-gray-700 hover:text-white py-2 px-4 transition-colors duration-200 rounded-lg">
                            Settings
                        </a>
                    </li>
                    <li class="mb-6">
                        <a href="#" class="flex items-center text-gray-300 hover:bg-gray-700 hover:text-white py-2 px-4 transition-colors duration-200 rounded-lg">
                            Analytics
                        </a>
                    </li>
                    <li class="mb-6">
                        <a href="#" class="flex items-center text-gray-300 hover:bg-gray-700 hover:text-white py-2 px-4 transition-colors duration-200 rounded-lg">
                            Logout
                        </a>
                    </li>
                </ul>
            </nav>
        </div>
    </body>
</html>
