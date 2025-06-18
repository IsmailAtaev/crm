const socketIo = require('socket.io');
const ChatService = require('./serviceChat');
const { CLIENT_URL } = require('../config');

const chatServer = (server) => {
    const io = socketIo(server,
        {
            cors: {
                origin: "http://localhost:5173", // Замените на ваш URL клиента
                // origin: "http://localhost:3000", // Замените на ваш URL клиента
                // origin: "http://192.168.1.46",
                // origin: "http://192.168.1.46:5022",
                // origin: CLIENT_URL, // Замените на ваш URL клиента
                // origin: "http://localhost:5022",
                methods: ["GET", "POST"],
                // credentials: true
            }
        }
    );

    // Хранение соединений пользователей
    const userConnections = {};

    io.on('connection', (socket) => {
        console.log('A user connected:', socket.id);

        // Сохранение соединения пользователя
        socket.on('register', (userId) => {
            userConnections[userId] = socket.id;
        });

        // создание чата
        socket.on('createchat', (data) => {
            const { senderId, receiverId } = data;
            console.log('23 createchat: ', data);
            ChatService.createChat(senderId, receiverId)

            // Отправляем сообщение только получателю и отправителю
            // const recipientSocketId = userConnections[recipientId];
            // if (recipientSocketId) {
            //     io.to(recipientSocketId).emit('message', { userId, message });
            // }
            // io.to(userConnections[userId]).emit('message', { userId, message });
        });


        // polucheniya chatow
        socket.on('getMyChats', async (data) => {
            const { senderId } = data
            console.log("senderId ", senderId)
            const chatList = await ChatService.getHaveChat(senderId)
            console.log(chatList)
            const recipientSocketId = userConnections[senderId];
            if (recipientSocketId) {
                io.to(recipientSocketId).emit('getMyChats', { chatList });
            }

        });

        // // Обработка сообщений
        // socket.on('message', (data) => {
        //     const { userId, recipientId, message } = data;
        //     console.log('Message received from', userId, 'to', recipientId, ':', message);

        //     // Отправляем сообщение только получателю и отправителю
        //     const recipientSocketId = userConnections[recipientId];
        //     if (recipientSocketId) {
        //         io.to(recipientSocketId).emit('message', { userId, message });
        //     }
        //     io.to(userConnections[userId]).emit('message', { userId, message });
        // });

        socket.on('message', async (data) => {
            const { senderId, recipientId, message, chatId, oppositeChatId, oppositeSenderId, oppositeReceiverId } = data;
            console.log('Message ', senderId, 'to', recipientId, ':', message, "chatId: ", chatId);
            console.log('oppositeChatId ', oppositeSenderId, 'to', oppositeReceiverId, ':', message, "chatId: ", oppositeChatId);

            const db = await ChatService.saveMessagge(senderId, recipientId, message, chatId, oppositeChatId, oppositeSenderId, oppositeReceiverId)

            // Отправляем сообщение только получателю и отправителю
            const recipientSocketId = userConnections[recipientId];
            if (recipientSocketId) {
                //io.to(recipientSocketId).emit('message', { senderId, message });
                io.to(recipientSocketId).emit('message', { senderId, receiverId: recipientId, text: message });

            }
            //io.to(userConnections[senderId]).emit('message', { senderId, message });
            io.to(userConnections[senderId]).emit('message', { senderId, receiverId: recipientId, text: message });
        });

        /**  get one chat history*/
        socket.on('getchat', async (data) => {
            const { chatId, senderId } = data;
            // console.log('Message ', chatId, senderId, receiverId);
            const db = await ChatService.getChatHistory(chatId, Number(senderId))
            //    console.log('DB ', db);
            io.to(userConnections[senderId]).emit('getchat', { chatHistory: db });
            // Отправляем сообщение только получателю и отправителю
            //const recipientSocketId = userConnections[recipientId];
            // if (recipientSocketId) {
            //     io.to(recipientSocketId).emit('getchat', { senderId, message });
            // }
            //  io.to(userConnections[senderId]).emit('getchat', { senderId, message });
        });

        socket.on('disconnect', () => {
            console.log('User disconnected:', socket.id);
            // Удаление соединения пользователя
            for (const [userId, socketId] of Object.entries(userConnections)) {
                if (socketId === socket.id) {
                    delete userConnections[userId];
                    break;
                }
            }
        });
    });
};

module.exports = chatServer;