const ChatService = require("../chat/serviceChat");
const ApiError = require("../error/ApiError")


class ChatController {
    async getUsers(req, res) {
        try {
            const userId = req.params.id;
            const chat = await ChatService.getUsersChat(userId)
            return res.json(chat)
        } catch (e) {
            ApiError.badRequest(e)
        }
    }

    async getChats(req, res) {
        try {
            const userId = req.params.id;
            if (!userId) {
                return res.status(400).json("userId not empty")
            }
            const chat = await ChatService.getHaveChat(userId)
            return res.json(chat)
        } catch (e) {
            ApiError.badRequest(e)
        }
    }

    async getChatsHistori(req, res) {
        try {
            const { chatId, senderId } = req.query
            const chat = await ChatService.getChatHistory(chatId, Number(senderId))
            return res.status(200).json(chat)
        } catch (e) {
            ApiError.badRequest(e)
        }
    }


    async createChat(req, res) {
        try {
            const { senderId, receiverId } = req.body
            await ChatService.createChat(senderId, receiverId)
            return res.status(200).json("OK")
        } catch (e) {
            ApiError.badRequest(e)
        }
    }

    async messaggeChat(req, res) {
        try {
            const { senderId, recipientId, message, chatId, oppositeChatId, oppositeSenderId, oppositeReceiverId } = req.body
            await ChatService.saveMessagge(senderId, recipientId, message, chatId, oppositeChatId, oppositeSenderId, oppositeReceiverId)
            return res.status(200).json("OK")
        } catch (e) {
            ApiError.badRequest(e)
        }
    }

}

module.exports = new ChatController()