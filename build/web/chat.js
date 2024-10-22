/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/ClientSide/javascript.js to edit this template
 */

import express from 'express';
import OpenAI from 'openai';
import dotenv from 'dotenv';
import bodyParser from 'body-parser';
import path from 'path';
import { fileURLToPath } from 'url';

// Cấu hình dotenv để nạp biến môi trường từ file .env
dotenv.config();

// Khởi tạo Express app
const app = express();
const port = 3000;

// Sử dụng body-parser để lấy dữ liệu từ request
app.use(bodyParser.json());
app.use(express.static('public'));

import fs from 'fs';

// Đọc nội dung từ file
const data = fs.readFileSync('products.csv', 'utf8');



const client = new OpenAI({
    apiKey: 'c7269dfe6f547f56cacebc752f99506b4ab516c2eca30bf93c908a709d8b5f32',
    baseURL: 'https://api.together.xyz/v1',
});

// Route chính để nhận câu hỏi từ người dùng
app.post('/chat', async (req, res) => {
    const userMessage = req.body.message;

    try {
        const response = await client.chat.completions.create({
            model: 'meta-llama/Llama-3-8b-chat-hf',
            messages: [
                {role: 'system', content: 'You are a customer consultant for a website selling drinks.'},
                {role: 'user', content: 'Here is some data: ' + data},
                {role: 'user', content: 'Your answer must be only this format and not other ways (including greetings): {\"message1\": ..., \"products\": [productId1, productId2, ...], \"message2\": ...(if any)}'},
                {role: 'user', content: 'message1 is required, products property can be empty and message2 is optional'},
                {role: 'user', content: 'If my question is not required listing product, then products property will be empty'},
                {role: 'user', content: 'If my question is Vietnamese, then answer me by Vietnamese, similar to other languages'},
                {role: 'user', content: userMessage},
            ],
        });

        let answer = response.choices[0].message.content;
        console.log(answer);
        let jsonResponse;
        try {
            jsonResponse = JSON.parse(answer); // Chuyển đổi nội dung thành JSON
        } catch (error) {
            res.json({message1: answer});
        }
        // Trả về câu trả lời cho người dùng
        res.json(jsonResponse);
    } catch (error) {
        res.status(500).json({error: 'Something went wrong'});
    }
});

// Khởi động server
app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});
