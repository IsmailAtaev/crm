const Router = require('express')
const router = new Router()
const WarningController = require('../controllers/WarningController')

router.post('/create', WarningController.create)
router.get('/get', WarningController.getWarnings)
router.patch('/edit', WarningController.editWarning)
router.delete('/remove', WarningController.deleteWarning)

// Share Holiday
router.post('/post', WarningController.post)
router.get('/get/share', WarningController.getWarningShare)
router.delete('/remove/share', WarningController.deleteWarningShare)
router.post('/add/share', WarningController.addWarningShareUser)
router.put('/update', WarningController.editWarningAndUsers)

module.exports = router;