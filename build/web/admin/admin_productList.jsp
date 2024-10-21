<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product List</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
        <link href="../output.css" rel="stylesheet">
        <link href="../css/mystyle.css" rel="stylesheet">
    </head>
    <body>
        <c:set var="u" value="${USER}"/>
        <c:if test="${u != null && u.getRole().equals(\"ADMIN\")}">
            <c:set var="pl" value="${product_list}"/>
            <c:set var="cl" value="${category_list}"/>
            <div class="bg-gray-100 h-screen">
                <div class="flex">
                    <!--Navigation-->
                    <%@ include file="../include/admin-navigation.jsp" %>

                    <!-- Main Content -->
                    <!-- Product List here -->
                    <div id="product-list" class="flex-1 flex-row p-5">
                        <div class="p-5">
                            <div class="inline-block">
                                <h1 class="text-4xl font-semibold">Product List</h1>
                            </div>
                            <div class="inline-block" style="float:right;">
                                <button type="button" class=" text-1xl font-semibold border-4 border-black p-2" onclick="addNewProduct()">Add new product</button>
                            </div>
                        </div>
                        <div class="flex">
                            <div class="flex flex-col w-64 h-screen bg-gray-800/[0.1] shadow-md">
                                <div class="flex flex-row justify-around items-center">
                                    <h2 class="text-3xl font-semibold p-2">Sort by:</h2>
                                    <select id="sort" title="hello" onchange="sortList()">
                                        <option value="id" selected>ID</option>
                                        <option value="name">Product's Name</option>
                                    </select>
                                </div>
                                <h2 class="text-3xl font-semibold p-2">Filter:</h2>
                                <form class="px-3">
                                    <h3 class="text-2xl font-semibold mb-2">Category:</h3>
                                    <c:forEach var="category" items="${cl}">
                                        <input id="${category.getName().toLowerCase()}" class="mx-3" type="checkbox" value="${category.getName()}" checked onchange="changeProductList('${category.getName().toLowerCase()}')"/><label for="${category.getName().toLowerCase()}">${category.getName()}</label><br>
                                    </c:forEach>
                                </form>
                            </div>
                            <div class="flex-1 px-3">
                                <table class="table-auto border-4 border-black w-full">
                                    <thead>
                                        <tr>
                                            <th class="border-2 border-black" >ID</th>
                                            <th class="border-2 border-black">Thumbnail</th>
                                            <th class="border-2 border-black">Name</th>
                                            <th class="border-2 border-black">Category</th>
                                            <th class="border-2 border-black">Price</th>
                                            <th class="border-2 border-black"></th>
                                        </tr>
                                    </thead>
                                    <tbody id="productList">

                                    </tbody>
                                </table>
                                <div>
                                    <button onlick=''>Previous</button><button onlick=''>Next</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Add new Product here -->
                    <div id="add-product" style="display:none" class="flex-1 flex-row p-5">
                        <div class="p-5">
                            <h1 class="text-4xl font-semibold">Add new Product</h1>
                        </div>
                        <form action="addproduct" method="POST" enctype="multipart/form-data">
                            <div class="flex">
                                <div class="w-[60%] px-3">
                                    <div class="flex justify-between my-2">
                                        <label class="text-2xl font-semibold" for="name">Product's name:</label>
                                        <input id="name" name="name" class="input-box" type="text" required/>
                                    </div>
                                    <div class="flex justify-between my-2">
                                        <label class="text-2xl font-semibold" for="category">Product's category:</label>
                                        <select id="category" class="input-box" name="category">
                                            <c:forEach var="category" items="${cl}">
                                                <option value="${category.getName()}">${category.getName()}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="flex justify-between my-2">
                                        <label class="text-2xl font-semibold" for="price">Product's price:</label>
                                        <input id="price" name="price" class="input-box" type="number" required/>
                                    </div>
                                    <div class="flex justify-between my-2">
                                        <label class="text-2xl font-semibold" for="description">Description:</label><br>
                                        <textarea id="description" name="description" class="input-box" style="height:150px" type="text" required></textarea>
                                    </div>
                                </div>
                                <div class="w-[40%] px-3">
                                    <div class="flex justify-between">
                                        <label class="text-2xl font-semibold">Thumbnail Image:</label><label class="text-1xl font-semibold border-2 border-black px-2" for="thumbnail">Upload</label><input id="thumbnail" name="thumbnail" type="file" style="display: none" accept="image/*" required onchange="previewImage(event)"/><br>
                                    </div>
                                    <div class="flex justify-center pt-10">
                                        <img id="preview" style="width:50%" src="" alt="Image Preview">
                                    </div>
                                </div>
                            </div>
                            <button type="submit" class="text-1xl font-semibold border-4 border-black p-2" value="Add">Add</button>
                            <button type="button" class=" text-1xl font-semibold border-4 border-black p-2" onclick="productList()">Cancel</button>
                        </form>
                    </div>
                </div>
            </div>
            <script>
                function addNewProduct() {
                    document.getElementById('product-list').style.display = "none";
                    document.getElementById('add-product').style.display = "block";
                };

                function productList() {
                    document.getElementById('add-product').style.display = "none";
                    document.getElementById('product-list').style.display = "block";
                };

                let string, i, j, attributeType, dataType, exit, swap, attributeid, item1, item2, tproduct;
                let pl = [];
                
                //add all products in display list with form of id-name-category
                <c:forEach var="product" items="${pl}">
                    pl.push("${product.getId()}|<c:choose><c:when test="${empty product.getThumbnailUrl()}">invalid-image.png</c:when><c:otherwise>${product.getThumbnailUrl()}</c:otherwise></c:choose>|${product.getName().replace(" ", "_")}|${product.getCategory()}");
                </c:forEach>
                const products = pl.slice(0, pl.length);
               
                displayList();
                
                
                function displayList() {
                    string = "";
                    for (i = 0; i < pl.length; i++) {
                        item1=pl[i].split("|");
                        string += "<tr id=" + pl[i] + ">\n"
                                         + "<td class=\"border-2 border-gray-300 p-2\">" + item1[0] + "</td>\n"
                                         + "<td class=\"border-2 border-gray-300 p-2\"><img style=\"width:30px;\" src=\"../img/thumbnail/" + item1[1] + "\" alt=\"" + item1[2] + "\"/></td>\n"
                                         + "<td class=\"border-2 border-gray-300 p-2\">" + item1[2].replace("_", " ") + "</td>\n"
                                         + "<td class=\"border-2 border-gray-300 p-2\">" + item1[3] + "</td>\n"
                                         + "<td class=\"border-2 border-gray-300 p-2\"><a class=\"hyperlink\" href=\"product?id=" + item1[0] + "\">view</a></td>\n"
                                         + "</tr>\n"
                    }
                    document.getElementById('productList').innerHTML = string;
                }

                function changeProductList(type) {
                        switch (type) {
                <c:forEach var="category" items="${cl}">
                            case '${category.getName().toLowerCase()}':
                                if (document.getElementById('${category.getName().toLowerCase()}').checked) {
                                    for (i = 0; i < products.length; i++) {
                                        if (products[i].endsWith('${category.getName()}')) {
                                            pl.push(products[i]);
                                        }
                                    }
                                sortList();
                                }  else {
                                    for (i = 0; i < pl.length; i++) {
                                        if (pl[i].endsWith('${category.getName()}')) {
                                            pl.splice(i, 1);
                                            i--;
                                        }
                                    }
                                    displayList();
                                }
                                break;
                </c:forEach>
                        }
                };
                
                function sortList() {
                attributeType = document.getElementById('sort').value;
                    switch (attributeType) {
                        case "id":
                            attributeid = 0;
                            dataType = "number";
                            break;
                        case "name":
                            attributeid = 2;
                            dataType="string";
                            break;
                    }
                    for (i = 0; i < pl.length - 1; i++) {
                        exit = true;
                        for (j = 0; j < pl.length - i - 1; j++) {
                            swap = false;
                            item1 = pl[j].split("|");
                            item2 = pl[j + 1].split("|");
                            if (dataType === "number") {
                                if (Number(item1[attributeid]) > Number(item2[attributeid])) {
                                    swap = true;
                                }
                            } else if (dataType === "string") {
                                if (item1[attributeid].localeCompare(item2[attributeid]) > 0) {
                                    swap = true;
                                }
                            }
                            if (swap) {
                                tproduct = pl[j];
                                pl[j] = pl[j + 1];
                                pl[j + 1] = tproduct;
                                exit = false;
                            }
                        }
                        if (exit) {
                            break;
                        }
                    }
                    displayList();
                };
                
                function createPageButtons() {
                    
                };
                
                function getPage(page) {
                    
                };

                //for Preview Image
                function previewImage(event) {
                    // Get the file input and preview image elements
                    var image = document.getElementById('thumbnail').files[0];
                    var preview = document.getElementById('preview');
                    // Use FileReader to read the image file
                    var reader = new FileReader();
                    reader.onload = function () {
                        // Set the src of the image preview to the file data
                        preview.src = reader.result;
                        preview.style.display = 'block'; // Show the preview
                    };
                    if (image) {
                        reader.readAsDataURL(image); // Read the image file as a data URL
                    } else {
                        preview.src = ""; // Clear preview if no image is selected
                        preview.style.display = 'none';
                    }
                };
                
            </script>
        </c:if>
        <c:if test="${u == null || !u.getRole().equals(\"ADMIN\")}">
            <%@ include file="no-permission.html" %>
        </c:if>
    </body>
</html>
