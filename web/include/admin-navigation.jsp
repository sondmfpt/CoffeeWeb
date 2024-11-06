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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="w-64 min-h-screen bg-gray-800 shadow-md relative">
            <div class="p-6">
                <h2 class="text-white text-2xl font-bold">Admin Page</h2>
            </div>
            <nav class="mt-10">
                <ul>
                    <li class="mb-6">
                        <a href="admin-products" class="flex items-center text-gray-300 hover:bg-gray-700 hover:text-white py-2 px-4 transition-colors duration-200 rounded-lg">
                            Products
                        </a>
                    </li>
                    <li class="mb-6">
                        <button onclick="toggleDropdown('usersDropdown')" class="flex items-center w-full text-gray-300 hover:bg-gray-700 hover:text-white py-2 px-4 transition-colors duration-200 rounded-lg">
                            Users
                        </button>
                        <ul id="usersDropdown" class="max-h-0 overflow-hidden transition-all duration-300 ease-in-out ml-6">
                            <li class="mb-2">
                                <a href="./admin-user-list" class="text-gray-400 hover:text-white">Danh sách người dùng</a>
                            </li>
                            <li class="mb-2">
                                <a href="./admin-add-user" class="text-gray-400 hover:text-white">Thêm người dùng mới</a>
                            </li>
                        </ul>
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
                        <a href="./login" class="flex items-center text-gray-300 hover:bg-gray-700 hover:text-white py-2 px-4 transition-colors duration-200 rounded-lg">
                            Logout
                        </a>
                    </li>
                </ul>
            </nav>
            <a href="./home" class="absolute flex justify-center items-center bottom-5 left-5 w-10 h-10 bg-white rounded-full overflow-hidden cursor-pointer hover:bg-coffee-200 transition ease-in-out duration-200">
                <i class="fa-solid fa-house"></i>
            </a>
        </div>
        <script>
            function toggleDropdown(dropdownId) {
                const dropdown = document.getElementById(dropdownId);
                const isVisible = dropdown.style.maxHeight; // Lưu trạng thái hiện tại

                // Nếu đang mở, đóng nó lại
                if (isVisible) {
                    dropdown.style.maxHeight = null; // Đặt lại chiều cao
                } else {
                    dropdown.style.maxHeight = dropdown.scrollHeight + "px"; // Đặt chiều cao bằng chiều cao thực tế của dropdown
                }
            }
        </script>
    </body>
</html>
