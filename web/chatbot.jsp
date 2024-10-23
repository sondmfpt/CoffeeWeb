<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chatbot</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                display: flex;
                flex-direction: column;
                height: 100vh;
                justify-content: center;
                align-items: center;
                background-color: #f4f4f9;
            }
            .chat-container {
                width: 400px;
                background-color: white;
                padding: 20px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
            }
            .messages {
                height: 300px;
                overflow-y: auto;
                border-bottom: 1px solid #ddd;
                margin-bottom: 10px;
            }
            .message {
                margin: 10px 0;
            }
            .bot {
                color: blue;
            }
            .user {
                color: green;
            }
            input {
                width: calc(100% - 20px);
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 5px;
            }
            button {
                padding: 10px 20px;
                background-color: #007bff;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
        </style>
    </head>
    <body>
        <div class="chat-container">
            <div style="white-space: pre-line;" class="messages" id="messages"></div>
            <input type="text" id="user-input" placeholder="Ask something..." />
            <button onclick="sendMessage()">Send</button>
        </div>

        <script>
            async function sendMessage() {
                const userInput = document.getElementById('user-input').value;
                if (!userInput)
                    return;

                const messagesDiv = document.getElementById('messages');
                const userMessageDiv = document.createElement('div');
                userMessageDiv.className = 'message user';
                userMessageDiv.textContent = 'You: ' + userInput;
                messagesDiv.appendChild(userMessageDiv);

                const response = await fetch('/SWP_Project/chat', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                    body: new URLSearchParams({message: userInput})
                });

                const data = await response.json();
                const message = data.choices[0].message.content;
                console.log(message);
                
                const botMessageDiv = document.createElement('div');
                botMessageDiv.className = 'message bot';
                botMessageDiv.textContent = 'Bot: ' + message; // Thay đổi tùy theo cấu trúc phản hồi của API
                messagesDiv.appendChild(botMessageDiv);

                document.getElementById('user-input').value = '';
                messagesDiv.scrollTop = messagesDiv.scrollHeight;
            }
        </script>
    </body>
</html>
