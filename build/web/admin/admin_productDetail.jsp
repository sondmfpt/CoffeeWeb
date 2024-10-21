<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product Detail</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
        <link href="../output.css" rel="stylesheet">
        <link href="../css/mystyle.css" rel="stylesheet">
    </head>
    <body>
        <c:set var="p" value="${product}"/>
        <c:set var="cl" value="${category_list}"/>
        <div class="bg-gray-100 h-screen">
            <div class="flex">
                <!--Navigation-->
                <%@ include file="../include/admin-navigation.jsp" %>

                <!-- Main Content -->
                <!-- Product Details here -->
                <div id="product-details" class="flex-1 flex-row p-5">
                    <div class="p-5">
                        <div class="inline-block">
                            <h1 class="text-4xl font-semibold">${p.getName()}</h1>
                        </div>
                        <div class="inline-block" style="float:right;">
                            <button type="button" class=" text-1xl font-semibold border-4 border-black p-2" onclick="editProduct()">Edit product</button>
                        </div>
                    </div>
                    <div class="flex">
                        <div class="w-[60%] px-3">
                            <div class="flex justify-between my-2">
                                <p class="text-2xl font-semibold" for="name">Product's name:</p>
                                <p class="text-2xl font-sans display-box" for="name">${p.getName()}</p>
                            </div>
                            <div class="flex justify-between my-2">
                                <p class="text-2xl font-semibold" for="name">Product's category:</p>
                                <p class="text-2xl font-sans display-box" for="name">${p.getCategory()}</p>
                            </div>
                            <div class="flex justify-between my-2">
                                <p class="text-2xl font-semibold" for="name">Product's price:</p>
                                <p class="text-2xl font-sans display-box" for="name">${p.getPrice()}</p>
                            </div>
                            <div class="flex justify-between my-2">
                                <p class="text-2xl font-semibold" for="name">Description:</p>
                                <p class="text-2xl font-sans display-box" for="name">${p.getDescription()}</p>
                            </div>
                        </div>
                        <div class="w-[40%] px-3">
                            <div class="flex justify-center">
                                <p class="text-2xl font-semibold">Thumbnail Image:</p>
                            </div>
                            <div class="flex justify-center pt-10">
                                <img style="width:50%" src="../img/thumbnail/${p.getThumbnailUrl()}" alt="Image Preview">
                            </div>
                        </div>
                    </div>
                    <a class=" text-1xl font-semibold border-4 border-black p-2" href="products">Back</a>
                </div>
                <!-- Edit Product here -->
                <div id="edit-product" style="display:none" class="flex-1 flex-row p-5">
                    <div class="p-5">
                        <h1 class="text-4xl font-semibold">Edit Product</h1>
                    </div>
                    <form action="editproduct?id=${p.getId()}" method="POST" enctype="multipart/form-data">
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
                                            <option value="${category.getName()}" <c:if test="${p.getName().equals(category.getName())}">checked</c:if>>${category.getName()}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="flex justify-between my-2">
                                    <label class="text-2xl font-semibold" for="price">Product's price:</label>
                                    <input id="price" name="price" class="input-box" type="number" value="${p.getPrice()}" required/>
                                </div>
                                <div class="flex justify-between my-2">
                                    <label class="text-2xl font-semibold" for="description">Description:</label><br>
                                    <textarea id="description" name="description" class="input-box" style="height:150px" type="text" required>${p.getDescription()}</textarea>
                                </div>
                            </div>
                            <div class="w-[40%] px-3">
                                <div class="flex justify-between">
                                    <label class="text-2xl font-semibold">Thumbnail Image:</label><label class="text-1xl font-semibold border-2 border-black px-2" for="thumbnail">Upload</label><input id="thumbnail" name="thumbnail" type="file" style="display: none" accept="image/*" onchange="previewImage(event)"/><input id="thumbnailURL" name="thumbnailURL" type="text" style="display: none"  value="${p.getThumbnailUrl()}" /><br>
                                </div>
                                <div class="flex justify-center pt-10">
                                    <img id="preview" style="width:50%" src="../img/thumbnail/${p.getThumbnailUrl()}" alt="Image Preview">
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
            ;

            function productDetails() {
                document.getElementById('edit-product').style.display = "none";
                document.getElementById('product-details').style.display = "block";
            }
            ;

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
                } else {
                    preview.src = ""; // Clear preview if no image is selected
                    preview.style.display = 'none';
                }
            }
        </script>
    </body>
</html>
