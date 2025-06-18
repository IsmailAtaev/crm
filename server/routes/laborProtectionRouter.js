const Router = require('express');
const router = new Router();
const LaborProtectionController = require('../controllers/laborProtectionController');

router.post('/add', LaborProtectionController.addLaborProtection);
router.get('/get', LaborProtectionController.getAllLaborProtection);
router.get('/get/user', LaborProtectionController.getUserAllLaborProtection);
router.put('/update', LaborProtectionController.editLaborProtection);
router.delete('/delete', LaborProtectionController.deleteLaborProtection);

// Add for all 
router.post('/add/for/all', LaborProtectionController.addLaborProtectionForAll);
router.get('/get/for/all', LaborProtectionController.getForAll);
router.put('/update/for/all', LaborProtectionController.editLaborProtectionForAll);
router.delete('/delete/for/all', LaborProtectionController.deleteForAllLaborProtection);

module.exports = router