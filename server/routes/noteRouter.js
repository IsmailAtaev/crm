const Router = require('express')
const router = new Router()
const NoteController = require('../controllers/noteController')

router.post('/create', NoteController.addNote)
//router.get('/my/notes', NoteController.getMyNotes)
router.get('/received/notes', NoteController.getReceivedNotes)
router.get('/my/sent/notes', NoteController.getMySentNotes)
router.delete('/delete', NoteController.deleteNote)
router.patch('/updata', NoteController.updateNote)
// router.get('/item/:id', NoteController.getItemPosition)

module.exports = router;