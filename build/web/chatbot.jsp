<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        <div class="w-full max-w-md bg-white p-5 rounded-lg shadow-lg">
            <div id="messages" class="h-72 overflow-y-auto border-b border-gray-300 mb-4 space-y-3 no-scrollbar">

            </div>
            <input id="user-input" onkeydown="handleKeyDown(event)" type ="text" placeholder="Ask something..." class="w-full p-2 border border-gray-300 rounded-lg mb-3 focus:outline-none focus:ring-2 focus:ring-blue-500" />
            <button onclick="sendMessage()" class="w-full py-2 bg-blue-500 text-white border border-gray-500 rounded-lg hover:bg-blue-600 transition-colors">
                Send
            </button>
        </div>

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

                const messagesDiv = document.getElementById('messages');
                const userMessageDiv = document.createElement('div');
                userMessageDiv.classList.add('flex', 'justify-end')
                userMessageDiv.innerHTML =
                        '<div class="flex gap-1">' +
                        '<p>' + userInput + '</p>' +
                        '<i class="fa-solid fa-robot"></i>' 
                        '</div>';
                messagesDiv.appendChild(userMessageDiv);

                const response = await fetch('/SWP_Project/chat', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                    body: new URLSearchParams({message: userInput})
                });

                const data = await response.json();
                const message = JSON.parse(data.choices[0].message.content);
                console.log(data.choices[0].message.content)

                //message1
                const botMessageDiv1 = document.createElement('div');
                botMessageDiv1.innerHTML =
                        '<div class="flex gap-1"><i class="fa-solid fa-robot"></i>' +
                        '<p>' + message.message1 + '</p>' +
                        '</div>';
                messagesDiv.appendChild(botMessageDiv1);

                //products
                var products = getProducts(message.products);
                products.then(productList => {
                    const botMessageProduct = document.createElement('div');
                    botMessageProduct.classList.add('flex', 'gap-3', 'overflow-x-auto');

                    productList.forEach((product) => {
                        var innerProduct = document.createElement('a');
                        innerProduct.href = ('./product-detail?productId=' + product.id);
                        innerProduct.classList.add('flex', 'flex-col', 'gap-2', 'p-2', 'min-w-[45%]', 'border', 'border-gray-300', 'rounded-lg', 'hover:-translate-y-1', 'transition-transform', 'duration-200', 'cursor-pointer');
                        innerProduct.innerHTML =
                                '<img class="w-full" src="./img/' + product.thumbnailUrl + '" alt="Cappuchino">' +
                                '<p>' + product.name + '</p>';
                        botMessageProduct.appendChild(innerProduct);
                    })
                    messagesDiv.appendChild(botMessageProduct);

                }).catch(error => {
                    console.error(error); // xử lý lỗi nếu Promise bị reject
                });

                //message2
                const botMessageDiv2 = document.createElement('div');
                botMessageDiv2.textContent = message.message2;
                messagesDiv.appendChild(botMessageDiv2);


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
