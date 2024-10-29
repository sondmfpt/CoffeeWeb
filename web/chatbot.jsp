<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chatbot</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
        <link href="./output.css" rel="stylesheet">
    </head>
    <body>
        <input id='avatarUser' type="hidden" value='${user.getAvatar()}'>
        <div onclick="toggleChatBox()" class="fixed bottom-5 right-5 z-50">
            <div class="inline rounded-full p-2 cursor-pointer bg-white text-2xl text-black"><i class="fa-solid fa-headset"></i></div>
        </div>
        <div id="chatBox" class="w-full max-w-md bg-gray-100 p-5 rounded-lg shadow-lg fixed bottom-2 right-16 z-50 font-sans text-black hidden">
            <div id="messages" class="h-72 overflow-y-auto border-b border-gray-300 mb-4 space-y-3 no-scrollbar">
                <!--chat-->
            </div>
            <div class="flex gap-2 items-center">
                <input id="user-input" onkeydown="handleKeyDown(event)" type ="text" placeholder="Ask something..." class="w-full p-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" />
                <button onclick="sendMessage()">
                    <i class="fa-solid fa-paper-plane text-blue-500 text-2xl"></i>
                </button>
            </div>
        </div>

        <!--show chatbot-->
        <script>
            function toggleChatBox() {
                document.getElementById('chatBox').classList.toggle('hidden');
                document.getElementById('user-input').focus();
            }
        </script>

        <script>
            function handleKeyDown(event) {
                if (event.key === 'Enter') {
                    sendMessage();
                }
            }
            async function sendMessage() {
                const userInput = document.getElementById('user-input').value;
                document.getElementById('user-input').value = null;
                if (!userInput)
                    return;

                var avatarUser = document.getElementById('avatarUser').value;
                avatarUser = avatarUser == "" ? "default-image.png" : avatarUser;
                const messagesDiv = document.getElementById('messages');
                const userMessageDiv = document.createElement('div');
                userMessageDiv.classList.add('flex', 'justify-end');
                userMessageDiv.innerHTML =
                        '<div class="flex gap-1">' +
                        '<p class="p-2 bg-blue-100 rounded-lg">' + userInput + '</p>' +
                        '<div class="w-8 h-8 rounded-full overflow-hidden">' +
                        '<img src="./img/avatar/' + avatarUser + '"></img>' +
                        '</div>'
                '</div>';
                messagesDiv.appendChild(userMessageDiv);

                const response = await fetch('/SWP_Project/chat', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                    body: new URLSearchParams({message: userInput})
                });

                const data = await response.json();
                const message = JSON.parse(data.choices[0].message.content);
//                console.log(data.choices[0].message.content);

                //message1
                const botMessageDiv1 = document.createElement('div');
                botMessageDiv1.innerHTML =
                        '<div class="flex gap-1">' +
                        '<div class="flex justify-center items-center w-8 h-8 rounded-full border border-black p-2">' +
                        '<i class="fa-solid fa-robot"></i>' +
                        '</div>' +
                        '<p class="p-2 bg-blue-100 rounded-lg">' + message.message1 + '</p>' +
                        '</div>';
                messagesDiv.appendChild(botMessageDiv1);

                //products
                if (message.products.length != 0 && message.products != null) {
                    var products = getProducts(message.products);
                    products.then(productList => {
                        const botMessageProduct = document.createElement('div');
                        botMessageProduct.classList.add('flex', 'gap-3', 'overflow-x-auto');

                        productList.forEach((product) => {
                            var innerProduct = document.createElement('a');
                            innerProduct.href = ('./product-detail?productId=' + product.id);
                            innerProduct.classList.add('flex', 'flex-col', 'gap-2', 'p-2', 'min-w-[45%]', 'border', 'border-gray-300', 'rounded-lg', 'hover:-translate-y-1', 'transition-transform', 'duration-200', 'cursor-pointer');
                            innerProduct.innerHTML =
                                    '<img class="w-full" src="./img/thumbnail/' + product.thumbnailUrl + '" alt="Cappuchino">' +
                                    '<p>' + product.name + '</p>';
                            botMessageProduct.appendChild(innerProduct);
                        })
                        messagesDiv.appendChild(botMessageProduct);

                    }).catch(error => {
                        console.error(error); // xử lý lỗi nếu Promise bị reject
                    });
                }

                //message2
                if (message.message2 != null && message.message2 !== "") {
                    const botMessageDiv2 = document.createElement('div');
                    botMessageDiv2.innerHTML =
                            '<div class="flex gap-1">' +
                            '<div class="flex justify-center items-center w-8 h-8 rounded-full border border-black p-2">' +
                            '<i class="fa-solid fa-robot"></i>' +
                            '</div>' +
                            '<p class="p-2 bg-blue-100 rounded-lg">' + message.message2 + '</p>' +
                            '</div>';
                    messagesDiv.appendChild(botMessageDiv2);
                }

                document.getElementById('user-input').value = '';
                messagesDiv.scrollTop = messagesDiv.scrollHeight;
            }

            async function getProducts(products) {
                const response = await fetch('/SWP_Project/get-product', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                    body: new URLSearchParams({products: products})
                });
                const data = await response.json();
                return data;
            }
        </script>
    </body>
</html>
