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
        <c:choose>
            <c:when test="${u != null && u.getRole().equals(\"ADMIN\")}">
                <c:set var="pl" value="${product_list}"/>
                <c:set var="cl" value="${category_list}"/>
                <c:set var="al" value="${attribute_list}"/>
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
                                <div class="flex flex-col w-64 h-[80%] bg-gray-800/[0.1] shadow-md">
                                    <h2 class="text-3xl font-semibold p-2">Search:</h2>
                                    <input id="key" class="mx-2 px-2" placeholder="Input id or name here" onkeyup="filter()"/>
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
                                            <input id="${category.getName().toLowerCase()}" class="mx-3" type="checkbox" value="${category.getName()}" checked onchange="filter()"/><label for="${category.getName().toLowerCase()}">${category.getName()}</label><br>
                                        </c:forEach>
                                    </form>
                                    <form class="px-3">
                                        <h3 class="text-2xl font-semibold mb-2">Status:</h3>
                                            <input id="public" class="mx-3" type="checkbox" checked onchange="filter()"/><label for="public" style="color:green">Public</label><br>
                                            <input id="hidden" class="mx-3" type="checkbox" checked onchange="filter()"/><label for="hidden" style="color:red">Hidden</label><br>
                                            
                                    </form>
                                </div>
                                <div id="table" class="flex-1 px-3">
                                    <table class="table-auto border-4 border-black w-full">
                                        <thead>
                                            <tr>
                                                <th class="border-2 border-black" >ID</th>
                                                <th class="border-2 border-black">Thumbnail</th>
                                                <th class="border-2 border-black">Name</th>
                                                <th class="border-2 border-black">Category</th>
                                                <th class="border-2 border-black">Status</th>
                                                <th class="border-2 border-black"></th>
                                            </tr>
                                        </thead>
                                        <tbody id="productList">
                                        </tbody>
                                    </table>
                                    <div class="flex flex-row justify-center mt-4">
                                        <button  class="mx-2 border-black border-4" style="width:36px;height:36px" type="button" title="pages" onclick="firstPage()"><i class='fas fa-angle-double-left' style='font-size:30px'></i></button>
                                        <button class="mx-2  border-black border-4" style="width:36px;height:36px" type="button" title="pages" onclick="previousPage()"><i class='fas fa-angle-left' style='font-size:30px'></i></button>
                                        <span class="mx-2 px-2 text-2xl" style="height:36px"><span id="page">1</span>/<span id="total-page">10</span></span>
                                        <button class="mx-2  border-black border-4" style="width:36px;height:36px" type="button" title="pages" onclick="nextPage()"><i class='fas fa-angle-right' style='font-size:30px'></i></button>
                                        <button class="mx-2  border-black border-4" style="width:36px;height:36px" type="button" title="pages" onclick="lastPage()"><i class='fas fa-angle-double-right' style='font-size:30px'></i></button>
                                    </div>
                                </div>
                                <div id="empty-notification" style="display:none">
                                    <h2 class="text-3xl font-semibold p-2">No available product.</h2>
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
                                            <label class="text-2xl font-semibold" for="price">Product's variants:</label>
                                            <input id="vamount" name="vamount" type="number" style="display:none" value="0"/> <!-- for storing number of variant -->
                                            <button class="border-black border-2 text-1xl font-semibold px-2" type="button" title="addVariant" onclick="addVariant()">Add new variant</button>
                                        </div>
                                        <table class="table-auto border-2 border-black w-full mb-5">
                                            <thead>
                                                <tr>
                                                    <c:forEach var="attribute" items="${al}">
                                                        <th class="border border-black" >${attribute.getName()}</th>
                                                        </c:forEach>
                                                    <th class="border border-black">Origin Price</th>
                                                    <th class="border border-black">Sell Price</th>
                                                    <th class="border border-black"></th>
                                                </tr>
                                            </thead>
                                            <tbody id="variantList">
                                            </tbody>
                                        </table>
                                        <div class="flex justify-between my-2">
                                            <label class="text-2xl font-semibold" for="description">Description:</label><br>
                                            <textarea id="description" name="description" class="input-box" style="height:150px" type="text" required></textarea>
                                        </div>
                                    </div>
                                    <div class="w-[40%] px-3">
                                        <div class="flex justify-between">
                                            <label class="text-2xl font-semibold">Thumbnail Image:</label><label class="text-1xl font-semibold border-2 border-black px-2" for="thumbnail">Upload</label><input id="thumbnail" name="thumbnail" type="file" style="display: none" accept="image/*" required onchange="previewImage()"/><br>
                                        </div>
                                        <div class="flex justify-center pt-10">
                                            <img id="preview" style="width:30%; display:none" src="" alt="Image Preview">
                                        </div>
                                        <div class="flex justify-between mt-10">
                                            <label class="text-2xl font-semibold">Details Images:</label><div id='detail-input-list'></div><br>
                                        </div>
                                        <input id='imgAmount' name='imgAmount' type='number'  value='0' style="display:none"/>
                                        <div id='detail-img-list' class="flex justify-center pt-10">
                                        </div>
                                        <div class="flex flex-row justify-center mt-4">
                                            <button class="mx-2  border-black border-4" style="width:30px;height:30px" type="button" title="pages" onclick="previousImg()"><i class='fas fa-angle-left' style='font-size:15px'></i></button>
                                            <span class="mx-2 px-2 text-2xl" style="height:36px"><span id="img-page">0</span>/<span id="total-img">0</span></span>
                                            <button class="mx-2  border-black border-4" style="width:30px;height:30px" type="button" title="pages" onclick="nextImg()"><i class='fas fa-angle-right' style='font-size:15px'></i></button>
                                            <button class="mx-2  border-black border-4" style="width:30px;height:30px" type="button" title="pages" onclick="deleteImg()"><i class='fas fa-trash-alt' style='font-size:15px;color:red'></i></button>
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
                    //For display page
                    function addNewProduct() {
                        document.getElementById('product-list').style.display = "none";
                        document.getElementById('add-product').style.display = "block";
                    }

                    //For add product
                    function productList() {
                        document.getElementById('add-product').style.display = "none";
                        document.getElementById('product-list').style.display = "block";
                    }

                    //For List
                    let string, i, j, key, attributeType, dataType, exit, swap, attributeid, item1, item2, tproduct, pageIndex, totalPage, from, to;
                    let pl = [];

                    //add all products in display list with form of id-name-category
                    <c:forEach var="product" items="${pl}">
                    pl.push("${product.getId()}|${product.getThumbnailUrl() == null || product.getThumbnailUrl().isEmpty() ? "invalid-image.png" : product.getThumbnailUrl()}|${product.getName().replace(" ", "_")}|${product.getCategory()}|${(product.isPublic() ? "public" : "hidden")}");
                    </c:forEach>
                        const products = pl.slice(0, pl.length);

                        sortList();
                        identifyPage();
                        
                        function filter() {
                            pl = [];
                            //Filter with key
                            key = document.getElementById('key').value.toLowerCase();
                            if (key == '') {
                                pl = products.slice(0, products.length);
                            } else {
                                    for (i = 0; i < products.length; i++) {
                                    item1 = products[i].split("|");
                                    if (item1[0].includes(key) || item1[2].replace("_", " ").toLowerCase().includes(key)) {
                                        pl.push(products[i]);
                                    }
                                }
                            }
                            //Filter with checkbox
                            for (i = 0; i < pl.length; i++) {
                                item1 = pl[i].split("|");
                                <c:forEach var="category" items="${cl}">
                                if (!document.getElementById('${category.getName().toLowerCase()}').checked) {
                                    if (item1[3] == '${category.getName()}') {
                                        pl.splice(i, 1);
                                        i--;
                                        continue;
                                    }
                                }
                                </c:forEach>
                                if (!document.getElementById('public').checked) {
                                    if (item1[4] == 'public') {
                                        pl.splice(i, 1);
                                        i--;
                                        continue;
                                    }
                                }
                                if (!document.getElementById('hidden').checked) {
                                    if (item1[4] == 'hidden') {
                                        pl.splice(i, 1);
                                        i--;
                                        continue;
                                    }
                                }
                            }
                            sortList();
                        }

                        function sortList() {
                            attributeType = document.getElementById('sort').value;
                            switch (attributeType) {
                                case "id":
                                    attributeid = 0;
                                    dataType = "number";
                                    break;
                                case "name":
                                    attributeid = 2;
                                    dataType = "string";
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
                            identifyPage();
                        }

                        function identifyPage() {
                            pageIndex = 1;
                            totalPage = Math.ceil(pl.length / 10);
                            displayList();
                        }

                        function firstPage() {
                            pageIndex = 1;
                            displayList();
                        }

                        function previousPage() {
                            if (pageIndex > 1) {
                                pageIndex--;
                                displayList();
                            }
                        }

                        function nextPage() {
                            if (pageIndex < totalPage) {
                                pageIndex++;
                                displayList();
                            }
                        }

                        function lastPage() {
                            pageIndex = totalPage;
                            displayList();
                        }

                        function displayList() {
                            if (pl.length == 0) {
                                document.getElementById('table').style.display = "none";
                                document.getElementById('empty-notification').style.display = "";
                                return;
                            }
                            document.getElementById('empty-notification').style.display = "none";
                            document.getElementById('table').style.display = "";
                            string = "";
                            from = (pageIndex - 1) * 10;
                            if (pageIndex == totalPage) {
                                to = pl.length;
                            } else {
                                to = pageIndex * 10;
                            }
                            for (i = from; i < to; i++) {
                                item1 = pl[i].split("|");
                                string += "<tr id=" + pl[i] + ">\n"
                                        + "<td class=\"border-2 border-gray-300 p-2\">" + item1[0] + "</td>"
                                        + "<td class=\"border-2 border-gray-300 p-2\"><img style=\"width:30px;\" src=\"../img/thumbnail/" + item1[1] + "\" alt=\"" + item1[2] + "\"/></td>"
                                        + "<td class=\"border-2 border-gray-300 p-2\">" + item1[2].replace("_", " ") + "</td>"
                                        + "<td class=\"border-2 border-gray-300 p-2\">" + item1[3] + "</td>"
                                        + "<td class=\"border-2 border-gray-300 p-2\" style='color:" + (item1[4] == 'public' ? 'green' : 'red') + "'>" + item1[4] + "</td>"
                                        + "<td class=\"border-2 border-gray-300 p-2\"><a class=\"hyperlink\" href=\"product?id=" + item1[0] + "\">view</a></td>"
                                        + "</tr>"
                            }
                            document.getElementById('productList').innerHTML = string;
                            document.getElementById('page').innerHTML = pageIndex;
                            document.getElementById('total-page').innerHTML = totalPage;
                        }

                        //for Preview Image
                        function previewImage() {
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
                        }

                        //For add product variant
                        let vcount = 0;
                        let vlist = document.getElementById('variantList');
                        let variants, row, button;
                        function addVariant() {
                            vcount++;
                            document.getElementById("vamount").value = vcount;
                            vlist.insertAdjacentHTML("beforeend",
                                    "<tr id=\"v" + vcount + "\">"
                    <c:forEach var="attribute" items="${al}">
                            +"<td class=\"border border-gray-300 p-1\" style=\"text-align:center\">"
                                    + "<select class=\"border border-black mx-2 px-2\" name=\"${attribute.getName().toLowerCase()}" + vcount + "\" title=\"${attribute.getName().toLowerCase()}" + vcount + "\">"
                        <c:forEach var="value" items="${attribute.getValues()}">
                            + "<option value=\"${value}\">${value}</option>"
                        </c:forEach>
                            + "</select>"
                                    + "</td>"
                    </c:forEach>
                            + "<td class=\"border border-gray-300 p-1\" style=\"text-align:center\">"
                                    + "<input name=\"oprice" + vcount + "\" class=\"border border-black mx-2 px-2\" type=\"number\" style=\"max-width:6rem\"/>"
                                    + "</td>"
                                    + "<td class=\"border border-gray-300 p-1\" style=\"text-align:center\">"
                                    + "<input name=\"sprice" + vcount + "\" class=\"border border-black mx-2 px-2\" type=\"number\" style=\"max-width:6rem\"/>"
                                    + "</td>"
                                    + "<td class=\"border border-gray-300 p-1\" style=\"text-align:center\">"
                                    + "<button id=\"bv" + vcount + "\" type='button' style=\"width:30px;height:30px; position: relative; z-index: 10;\" onclick=\"deleteVariant(" + vcount + ")\"><i class='fas fas fa-trash-alt mx-2' style='font-size:15px;color:red'></i></button>"
                                    + "</td>"
                                    + "</tr>"
                            );

                        }

                        function deleteVariant(id) {
                            document.getElementById("v" + id).remove();
                            for (i = id + 1; i <= vcount; i++) {
                                row = document.getElementById("v" + i);
                                button = document.getElementById("bv" + i);
                                button.setAttribute("onclick", "deleteVariant(" + (i - 1) + ")");
                                button.id = "bv" + (i - 1);
                                row.id = "v" + (i - 1);
                            }
                            vcount--;
                            document.getElementById("vamount").value = vcount;
                        }

                        //For details images
                        let imgs = [], imgCount = 0, input, img;
                        const detailInputList = document.getElementById("detail-input-list");
                        const detailImgList = document.getElementById("detail-img-list");
                        const imgPage = document.getElementById("img-page");
                        const totalImg = document.getElementById("total-img");

                        printImageInput();

                        function printImageInput() {
                            detailInputList.insertAdjacentHTML("beforeend", "<label id='label" + (imgCount + 1) + "' class='text-1xl font-semibold border-2 border-black px-2' for='input" + (imgCount + 1) + "'>Upload</label><input id='input" + (imgCount + 1) + "' name='img" + (imgCount + 1) + "' type='file' style='display: none' accept='image/*' onchange='addImage()'/>");
                            if (imgCount > 0) {
                                var inputs = detailInputList.getElementsByTagName('label');
                                for (i = 0; i < inputs.length - 1; i++) {
                                    inputs[i].style.display = "none";
                                }
                            }
                        }

                        function printImageSlot() {
                            detailImgList.insertAdjacentHTML("beforeend", "<img id='img" + imgCount + "'style='width:30%' src='' alt='image " + imgCount + "'>");
                        }

                        function addImage() {
                            imgCount++;
                            printImageSlot();
                            // Get the file input and preview image elements
                            input = document.getElementById('input' + imgCount).files[0];
                            img = document.getElementById('img' + imgCount);
                            // Use FileReader to read the image file
                            let reader = new FileReader();
                            reader.onload = function () {
                                // Set the src of the image preview to the file data
                                img.src = reader.result;
                                img.style.display = 'block'; // Show the preview
                            };
                            if (input) {
                                reader.readAsDataURL(input); // Read the image file as a data URL
                            } else {
                                img.src = ""; // Clear preview if no image is selected
                                img.style.display = 'none';
                            }
                            printImageInput();
                            toPage(imgCount);
                        }

                        function deleteImg() {
                            if (imgCount == 0) {
                                return;
                            }
                            let page = Number(imgPage.innerHTML);
                            document.getElementById('label' + page).remove();
                            document.getElementById('input' + page).remove();
                            document.getElementById('img' + page).remove();
                            for (i = page + 1; i <= imgCount; i++) {
                                document.getElementById('label' + i).setAttribute("for", "input" + (i - 1));
                                document.getElementById('label' + i).id = "label" + (i - 1);
                                document.getElementById('input' + i).id = "input" + (i - 1);
                                document.getElementById('img' + i).id = "img" + (i - 1);
                            }
                            document.getElementById('label' + (imgCount + 1)).setAttribute("for", "input" + imgCount);
                            document.getElementById('label' + (imgCount + 1)).id = "label" + imgCount;
                            document.getElementById('input' + (imgCount + 1)).id = "input" + imgCount;
                            imgCount--;
                            if (page > imgCount) {
                                toPage(page - 1);
                                printImageInput();
                            } else {
                                toPage(page);
                            }
                        }

                        function toPage(page) {
                            imgPage.innerHTML = page;
                            document.getElementById('imgAmount').value = page;
                            totalImg.innerHTML = imgCount;
                            hideOtherImg(page);
                        }

                        function hideOtherImg(page) {
                            let imgs = detailImgList.getElementsByTagName('img');
                            for (i = 0; i < imgs.length; i++) {
                                if (i != page - 1) {
                                    imgs[i].style.display = "none";
                                } else {
                                    imgs[i].style.display = "";
                                }
                            }
                        }

                        function previousImg() {
                            console.log("work1");
                            if (Number(imgPage.innerHTML) > 1) {
                                toPage(Number(imgPage.innerHTML) - 1)
                            }
                        }

                        function nextImg() {
                            console.log("work2");
                            if (Number(imgPage.innerHTML) < imgCount) {
                                toPage(Number(imgPage.innerHTML) + 1)
                            }
                        }
                </script>
            </c:when>
            <c:otherwise>
                <%@ include file="no-permission.html" %>
            </c:otherwise>
        </c:choose>
    </body>
</html>
