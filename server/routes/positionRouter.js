const Router = require('express');
const router = new Router();
const PositionController = require('../controllers/positionController');

router.post('/create', PositionController.addPosition);
router.get('/get', PositionController.getPositions);
router.get('/item/:id', PositionController.getItemPosition);
router.patch('/updata', PositionController.updatePosition);
router.delete('/delete/:id', PositionController.removePosition);

module.exports = router;