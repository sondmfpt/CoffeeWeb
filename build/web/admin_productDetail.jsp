<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product Detail</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
        <link href="./output.css" rel="stylesheet">
        <link href="./css/mystyle.css" rel="stylesheet">
    </head>
    <body>
        <c:set var="u" value="${USER}"/>
        <c:choose>
            <c:when test="${u != null && u.getRole().equals(\"ADMIN\")}">
                <c:set var="p" value="${product}"/>
                <c:set var="vl" value="${variant_list}"/>
                <c:set var="cl" value="${category_list}"/>
                <c:set var="al" value="${attribute_list}"/>
                <div class="bg-gray-100 h-screen">
                    <div class="flex">
                        <!--Navigation-->
                        <%@ include file="./include/admin-navigation.jsp" %>

                        <!-- Main Content -->
                        <!-- Product Details here -->
                        <div id="product-details" class="flex-1 flex-row p-5">
                            <div class="p-5">
                                <div class="inline-block">
                                    <h1 class="text-4xl font-semibold">${p.getName()}</h1>
                                </div>
                                <div class="relative inline-block" style="left:20%">
                                    <span class="text-2xl font-semibold">Status: </span><span class="text-2xl" style="color:${(p.isPublic() ? "green" : "red")}">${(p.isPublic() ? "public" : "hidden")}</span>
                                </div>
                                <div class="inline-block" style="float:right;">
                                    <button type="button" class=" text-1xl font-semibold border-4 border-black p-2" onclick="editProduct()">Edit product</button>
                                </div>
                            </div>
                            <div class="flex">
                                <div class="w-[60%] px-3">
                                    <div class="flex justify-between my-2">
                                        <p class="text-2xl font-semibold">Product's name:</p>
                                        <p class="text-2xl font-sans display-box">${p.getName()}</p>
                                    </div>
                                    <div class="flex justify-between my-2">
                                        <p class="text-2xl font-semibold">Product's category:</p>
                                        <p class="text-2xl font-sans display-box">${p.getCategory()}</p>
                                    </div>
                                    <div class="flex justify-between my-2">
                                        <label class="text-2xl font-semibold">Product's variants:</label>
                                    </div>
                                    <table class="table-auto border-2 border-black w-full mb-5">
                                        <thead>
                                            <tr>
                                                <c:forEach var="attribute" items="${al}">
                                                    <th class="border border-black" >${attribute.getName()}</th>
                                                    </c:forEach>
                                                <th class="border border-black">Origin Price</th>
                                                <th class="border border-black">Sell Price</th>
                                                <th class="border border-black">Status</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var='variant' items='${vl}'>
                                                <tr>
                                                    <c:forEach var="attribute" items="${al}">
                                                        <td class="border border-gray-300" >${(variant.getAttribute().has(attribute.getName()) ? variant.getAttribute().get(attribute.getName()) : "None")}</td>
                                                    </c:forEach>
                                                    <td class="border border-gray-300">${variant.getOriginPrice()}</td>
                                                    <td class="border border-gray-300">${variant.getSalePrice()}</td>
                                                    <td class="border border-gray-300" style="color:${(variant.isPublic() ? "green" : "red")}">${(variant.isPublic() ? "public" : "hidden")}</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                    <div class="flex justify-between my-2">
                                        <p class="text-2xl font-semibold" >Description:</p>
                                        <p class="text-1xl font-sans display-box">${p.getDescription()}</p>
                                    </div>
                                </div>
                                <div class="w-[40%] px-3">
                                    <div class="flex justify-center">
                                        <p class="text-2xl font-semibold">Thumbnail Image:</p>
                                    </div>
                                    <div class="flex justify-center pt-10">
                                        <img style="width:30%" src="./img/thumbnail/${p.getThumbnailUrl()}" alt="Image Preview">
                                    </div>
                                    <div class="flex justify-between mt-10">
                                        <label class="text-2xl font-semibold">Details Images:</label>
                                    </div>
                                    <div id='detail-img-list-1' class="flex justify-center pt-10">
                                    </div>
                                    <div class="flex flex-row justify-center mt-4">
                                        <button class="mx-2  border-black border-4" style="width:30px;height:30px" type="button" title="pages" onclick="previousImg1()"><i class='fas fa-angle-left' style='font-size:15px'></i></button>
                                        <span class="mx-2 px-2 text-2xl" style="height:36px"><span id="img-page-1">0</span>/<span id="total-img-1">0</span></span>
                                        <button class="mx-2  border-black border-4" style="width:30px;height:30px" type="button" title="pages" onclick="nextImg1()"><i class='fas fa-angle-right' style='font-size:15px'></i></button>
                                    </div>
                                </div>
                            </div>
                            <a class=" text-1xl font-semibold border-4 border-black p-2" href="admin-products">Back</a>
                        </div>
                        <!-- Edit Product here -->
                        <div id="edit-product" style="display:none" class="flex-1 flex-row p-5">
                            <form action="admin-edit-product?id=${p.getId()}" method="POST" enctype="multipart/form-data">
                                <div class="p-5" >
                                    <span class="text-4xl font-semibold">Edit Product</span>
                                    <div style="position: relative; left:10%;display:inline-block">
                                        <span class="text-2xl font-semibold">Status: </span>
                                        <input id="status-public"name="status" type="radio" value="public" ${(p.isPublic() ? "checked" : "")} /><label for="status-public" style="color:green">public</label>
                                        <input id="status-hidden" name="status" type="radio" value="hidden" style="margin-left: 20px" ${(!p.isPublic() ? "checked" : "")} /><label for="status-hidden" style="color:red">hidden</label>
                                    </div>
                                </div>
                                <div class="flex">
                                    <div class="w-[60%] px-3">
                                        <div class="flex justify-between my-2">
                                            <label class="text-2xl font-semibold" for="name">Product's name:</label>
                                            <input id="name" name="name" class="input-box" type="text" value="${p.getName()}" required/>
                                        </div>
                                        <div class="flex justify-between my-2">
                                            <label class="text-2xl font-semibold" for="category">Product's category:</label>
                                            <select id="category" class="input-box" name="category">
                                                <c:forEach var="category" items="${cl}">
                                                    <option value="${category.getName()}" ${(p.getCategory().equals(category.getName()) ? "selected" : "")}>${category.getName()}</option>
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
                                                    <th class="border border-black">Status</th>
                                                    <th class="border border-black"></th>
                                                </tr>
                                            </thead>
                                            <tbody id="variantList">
                                                <c:forEach var='variant' items='${vl}'>
                                                    <tr>
                                                        <c:forEach var="attribute" items="${al}">
                                                            <td class="border border-gray-300" >${(variant.getAttribute().has(attribute.getName()) ? variant.getAttribute().get(attribute.getName()) : "None")}</td>
                                                        </c:forEach>
                                                        <td class="border border-gray-300"><input name="${variant.getId()}-origin-price" type="number" value="${variant.getOriginPrice()}" /></td>
                                                        <td class="border border-gray-300"><input name="${variant.getId()}-sale-price" type="number" value="${variant.getSalePrice()}" /></td>
                                                        <td class="border border-gray-300">
                                                            <select name="${variant.getId()}-status" style="color:${(variant.isPublic() ? "green" : "red")}">
                                                                <option value="public" ${(variant.isPublic() ? "checked" : "")}>public</option>
                                                                <option value="hidden" ${(!variant.isPublic() ? "checked" : "")}>hidden</option>
                                                            </select>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                        <div class="flex justify-between my-2">
                                            <label class="text-2xl font-semibold" for="description">Description:</label><br>
                                            <textarea id="description" name="description" class="input-box" style="height:150px" type="text" required>${p.getDescription()}</textarea>
                                        </div>
                                    </div>
                                    <div class="w-[40%] px-3">
                                        <div class="flex justify-between">
                                            <label class="text-2xl font-semibold">Thumbnail Image:</label><label class="text-1xl font-semibold border-2 border-black px-2" for="thumbnail">Upload</label><input id="thumbnail" name="thumbnail" type="file" style="display: none" accept="image/*" onchange="previewImage()"/><input id="thumbnailURL" type="text" name="thumbnailURL" value="${p.getThumbnailUrl()}" style="display:none"/><br>
                                        </div>
                                        <div class="flex justify-center pt-10">
                                            <img id="preview" style="width:30%" src="./img/thumbnail/${p.getThumbnailUrl()}" alt="Image Preview">
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

                                <button type="submit" class="text-1xl font-semibold border-4 border-black p-2" value="Update">Update</button>
                                <button type="button" class=" text-1xl font-semibold border-4 border-black p-2" onclick="productDetails()">Cancel</button>
                            </form>
                        </div>
                    </div>
                </div>
                <script>
                    function editProduct() {
                        document.getElementById('product-details').style.display = "none";
                        document.getElementById('edit-product').style.display = "block";
                    }

                    function productDetails() {
                        document.getElementById('edit-product').style.display = "none";
                        document.getElementById('product-details').style.display = "block";
                    }

                    //For product details
                    //Details images
                    let i;
                    let imgList2 = []; //imgList2 is using for update product, just create first to create imgList 1 for product details
                    <c:forEach var="img" items="${p.getListImage()}">
                    imgList2.push('${img}');
                    </c:forEach>

                    const imgList1 = imgList2.slice(0, imgList2.length);
                    const detailImgList1 = document.getElementById("detail-img-list-1");
                    const imgPage1 = document.getElementById("img-page-1");
                    const totalImg1 = document.getElementById("total-img-1");

                    loadImg1();

                    function loadImg1() {
                        if (imgList1.length > 0) {
                            totalImg1.innerHTML = ${p.getListImage().size()};
                            for (i = 1; i <= imgList1.length; i++) {
                                detailImgList1.insertAdjacentHTML("beforeend", "<img style='width:30%; display:none' src='./img/detail/" + imgList1[i - 1] + "' alt='image " + i + "'>");
                            }
                            toPage1(1);
                        }
                    }

                    function toPage1(page) {
                        imgPage1.innerHTML = page;
                        hideOtherImg1(page);
                    }

                    function hideOtherImg1(page) {
                        let imgs = detailImgList1.getElementsByTagName('img');
                        for (i = 0; i < imgs.length; i++) {
                            if (i != page - 1) {
                                imgs[i].style.display = "none";
                            } else {
                                imgs[i].style.display = "";
                            }
                        }
                    }

                    function previousImg1() {
                        if (Number(imgPage1.innerHTML) > 1) {
                            toPage1(Number(imgPage1.innerHTML) - 1)
                        }
                    }

                    function nextImg1() {
                        if (Number(imgPage1.innerHTML) < Number(totalImg1.innerHTML)) {
                            toPage1(Number(imgPage1.innerHTML) + 1)
                        }
                    }

                    function previewImage(event) {
                        // Get the file input and preview image elementsthumbnail
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
                            document.getElementById("thumbnailURL").value = "";
                        } else {
                            preview.src = ""; // Clear preview if no image is selected
                            preview.style.display = 'none';
                        }
                    }
                    //Update Product

                    //Add  variants
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
                        let imgs = [], imgCount = 0, input, img, secretInput;
                        const detailInputList = document.getElementById("detail-input-list");
                        const detailImgList = document.getElementById("detail-img-list");
                        const imgPage = document.getElementById("img-page");
                        const totalImg = document.getElementById("total-img");
                        
                        loadImg();

                        function loadImg() {
                            imgCount = imgList2.length;
                            if (imgList2.length > 0) {
                                totalImg.innerHTML = ${p.getListImage().size()};
                                for (i = 1; i <= imgList1.length; i++) {
                                    detailImgList.insertAdjacentHTML("beforeend", "<img id='img" + i + "' style='width:30%; display:none' src='./img/detail/" + imgList1[i - 1] + "' alt='image " + i + "'>");
                                    detailInputList.insertAdjacentHTML("beforeend", "<label id='label" + i + "' class='text-1xl font-semibold border-2 border-black px-2' for='input" + i + "' style='display:none'>Upload</label><input id='input" + i + "' name='img" + i + "' type='file' style='display: none' accept='image/*' onchange='addImage()'/>");
                                    detailInputList.insertAdjacentHTML("beforeend", "<input id='secretdetail" + i + "' name='secretdetail" + i + "' type='input' style='display:none' value='" + imgList1[i - 1] + "'/>");
                                }
                                toPage(1);
                            }
                        }

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
                            secretInput = document.getElementById('secretdetail' + page);
                            if (secretInput != null) {
                                secretInput.remove();
                            }
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
                            if (Number(imgPage.innerHTML) > 1) {
                                toPage(Number(imgPage.innerHTML) - 1)
                            }
                        }

                        function nextImg() {
                            if (Number(imgPage.innerHTML) < imgCount) {
                                toPage(Number(imgPage.innerHTML) + 1)
                            }
                        }
                </script>
            </c:when>
            <c:otherwise>
                <%@ include file="include/no-permission.html" %>
            </c:otherwise>
        </c:choose>
    </body>
</html>
