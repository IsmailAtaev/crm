const Router = require("express");
const HolidayController = require("../controllers/holidayController");
const router = new Router();

router.get("/get", HolidayController.get);
router.post("/add", HolidayController.add);
router.put("/update", HolidayController.update);
router.delete("/delete", HolidayController.delete);
router.get("/get/interval", HolidayController.getIntervalDate);

module.exports = router;