const { Op } = require('sequelize')
const { Note, User } = require('../models/model')
const UserService = require("./userService")
const userService = require('./userService')
const { ADMIN } = require('../consts')


class NoteService {
    async addNote(userId, authorId, content, project) {
        try {
            const user = await UserService.getItemUser(userId)
            const author = await UserService.getItemUser(authorId)

            const note = await Note.create({ userId: user.id, authorType: author.role, authorId: author.id, content, projectId: project })

            if (!note) throw new Error("Do not create department");

            return note
        } catch (e) {
            throw new Error(e.message)
        }
    }

    // men ozi belliklem
    async getMyNotes(userId) {
        const userNotes = await Note.findAll({ where: { userId, authorId: userId } })

        if (!userNotes) return [];

        return userNotes
    }

    // Mana iberlen bellikler 
    async getReceivedNotes(userId) {
        const userNotes = await Note.findAll({
            where: {
                userId: userId,
                authorId: { [Op.ne]: userId },
            },
            order: [["createdAt", "DESC"]]
        });

        if (userNotes.length === 0) return [];

        return userNotes;
    }

    // Men iberen belliklem
    async getMySentNotes(userId) {
        const userNotes = await Note.findAll({
            where: { userId: { [Op.ne]: userId }, authorId: userId, },
            order: [["createdAt", "DESC"]]
        });

        if (userNotes.length === 0) return [];

        return userNotes;
    }

    async deleteNote(authorId, noteId) {
        const result = await Note.destroy({ where: { id: noteId, authorId } })

        if (result === 0) throw new Error("Deletet note");

        return result;
    }

    async updateNote(authorId, noteId, userId, projectId, content) {
        try {
            const user = await userService.getItemUser(authorId);
            if (user.role === ADMIN) {
                const [updatedCount, updatedNotes] = await Note.update(
                    { userId, content, projectId }, {
                    where: { id: noteId },
                    returning: true
                });

                if (updatedCount === 0) throw new Error("Do not update note");

                return { message: "Successfully", data: updatedNotes[0] };
            }
            else return { message: "Permision dinete", data: [] }

        } catch (e) {
            throw new Error(e.message)
        }
    }
}

module.exports = new NoteService();