const NoteService = require("../service/noteService")



class NoteController {

    async addNote(req, res) {
        try {
            const { userId, authorId, content, project } = req.body
            if (!userId || !authorId || !content) {
                return res.status(500).json({ message: 'Request error NOTE add' })
            }
            const result = await NoteService.addNote(userId, authorId, content, project)
            return res.status(200).json({ message: "OK", data: result })
        } catch (e) {
            return res.status(500).json({ message: e.message })
        }
    }



    async getMyNotes(req, res) {
        try {
            const { userId } = req.query
            const result = await NoteService.getMyNotes(userId)
            return res.status(200).json(result)
        } catch (e) {
            return res.status(500).json({ message: e.message })
        }
    }



    async getReceivedNotes(req, res) {
        try {
            const { userId } = req.query
            const result = await NoteService.getReceivedNotes(userId)
            return res.status(200).json(result)
        } catch (e) {
            return res.status(500).json({ message: e.message })
        }
    }


    async getMySentNotes(req, res) {
        try {
            const { userId } = req.query
            const result = await NoteService.getMySentNotes(userId)
            return res.status(200).json(result)
        } catch (e) {
            return res.status(500).json({ message: e.message })
        }
    }


    async deleteNote(req, res) {
        try {
            const { authorId, noteId } = req.query
            if (!authorId || !noteId) {
                return res.status(500).json({ message: 'Request error' })
            }
            await NoteService.deleteNote(authorId, noteId)
            return res.status(200).json({ message: 'Successfully' })
        } catch (e) {
            return res.status(500).json({ message: e.message })
        }
    }

    async updateNote(req, res) {
        try {
            const { authorId, noteId, userId, projectId, content } = req.body
            if (!authorId || !noteId || !userId || !projectId || !content) {
                return res.status(500).json({ message: 'Request error' })
            }
            const result = await NoteService.updateNote(authorId, noteId, userId, projectId, content)
            return res.status(200).json(result)
        } catch (e) {
            return res.status(500).json({ message: e.message })
        }
    }


}


module.exports = new NoteController()