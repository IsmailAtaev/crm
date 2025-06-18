const Router = require("express");
const router = new Router();
const ComeLeaveWork = require("../controllers/comeLeaveWork");

router.get("/work/user", ComeLeaveWork.getMonthWorkTimeEmploye);
router.get("/for/day", ComeLeaveWork.getUserIdTimeForDay);
router.post("/come", ComeLeaveWork.comeWork);
router.post("/leave", ComeLeaveWork.leaveWork);
router.patch("/updata/note", ComeLeaveWork.updateNoteById);

router.patch("/worked", ComeLeaveWork.workedUserButNotComeOffice); // ishe gelmedi, yagny ish usti bilen gitdi we belenip bilmedik bellik goshyp bilyar 
router.delete("/remove/note", ComeLeaveWork.removeNote); // ulanyjyn belligini ret etmek 

// one user get all info document and employaerr registration
router.get("/user/info", ComeLeaveWork.getUserAllInfo);
//router.patch("/not/come", ComeLeaveWork.createOrUpdateNoteByAdmin);

router.get("/timesUser/:id", ComeLeaveWork.getUserIdTime);
router.put("/update", ComeLeaveWork.updateLeaveTime);

module.exports = router;