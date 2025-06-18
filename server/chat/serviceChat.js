const { Chat, User, Message } = require("../models/model")
const { Op } = require("sequelize")
const ApiError = require("../error/ApiError")

class ChatService {
    async createChat(senderId, receiverId) {
        try {
            const createOne = await Chat.create({
                participantOne: senderId,
                participantTwo: receiverId
            })

            const createTwo = await Chat.create({
                participantOne: receiverId,
                participantTwo: senderId
            })

            return { createOne, createTwo }
        } catch (e) {
            console.log(e)
        }
    }

    async getHaveChat(senderId) {
        try {
            const haveChat = await Chat.findAll({
                raw: true,
                where: { participantOne: senderId }
            })

            return haveChat
        } catch (e) {
            console.log(e)
        }
    }

    async getUsersChat(senderId) {
        try {
            const users = await User.findAll({ where: { id: { [Op.ne]: senderId } }, raw: true, });
            if (!users) {
                return ApiError.badRequest("Do not have users");
            }

            const chats = await Chat.findAll({ // findOne
                raw: true, where: { participantOne: senderId }
            })

            const participantTwoIds = chats.map(chat => chat.participantTwo);

            const oppositeChats = await Chat.findAll({
                raw: true, where: {
                    participantOne: {
                        [Op.in]: participantTwoIds
                    },
                    participantTwo: senderId
                }
            });

            const usersToRemove = users.filter(user => participantTwoIds.includes(user.id));
            const remainingUsers = users.filter(user => !participantTwoIds.includes(user.id));

            const combinedData = usersToRemove.map(user => {
                const userChat = chats.find(chat => chat.participantTwo === user.id);
                const oppositeChat = userChat ? oppositeChats.find(opChat =>
                    opChat.participantOne === userChat.participantTwo &&
                    opChat.participantTwo === userChat.participantOne
                ) : null;

                return {
                    ...user,
                    senderId: userChat ? userChat.participantOne : null,
                    receiverId: userChat ? userChat.participantTwo : null,
                    chatId: userChat ? userChat.id : null,
                    oppositeSenderId: oppositeChat ? oppositeChat.participantOne : null,
                    oppositeReceiverId: oppositeChat ? oppositeChat.participantTwo : null,
                    oppositeChatId: oppositeChat ? oppositeChat.id : null
                };
            });

            console.error("usersChat ulanyjy:  ", remainingUsers)

            return { users: remainingUsers, chats: combinedData }
        } catch (e) {
            ApiError.forbidden(e)
        }
    }



    async saveMessagge(senderId, recipientId, message, chatId, oppositeChatId, oppositeSenderId, oppositeReceiverId) {
        try {
            const saveMsg = await Message.create({ text: message, senderId, receiverId: recipientId, chatId })
            const saveMsgDublicate = await Message.create({ text: message, senderId, receiverId: recipientId, chatId: oppositeChatId })
        } catch (e) {

        }
    }

    async getChatHistory(chatId, senderId) {
        const chatHistory = await Message.findAll({
            raw: true,
            where: {
                chatId,
                [Op.or]: [{ senderId: senderId }, { receiverId: senderId }],
            }
        })
        return chatHistory
    }

}


module.exports = new ChatService();

