const Router = require("express");
const router = new Router();
const startEndWorkTimeController = require("../controllers/startEndWorkTimeController");

router.get("/get", startEndWorkTimeController.getWorkTime);
router.post("/add/user", startEndWorkTimeController.addWorkTimeForUser);
router.put("/update/user", startEndWorkTimeController.updateWorkTimeForUser);
router.get("/get/user", startEndWorkTimeController.getWorkTimeForUser);

module.exports = router;