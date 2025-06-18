const Router = require("express");
const router = new Router();
const AbsenceController = require("../controllers/AbsenceController")

router.post("/add", AbsenceController.addAbsenceUser);
router.get("/get", AbsenceController.getAbsenceUser);
router.get("/get-all", AbsenceController.getAbsenceAll);
router.delete("/delete", AbsenceController.deleteOneAbsenceForUser);
router.put("/update", AbsenceController.updateOneAbsenceForUser);

module.exports = router;