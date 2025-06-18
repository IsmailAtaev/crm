const Router = require("express");
const router = new Router();
const userRouter = require("./userRouter");
const position = require('./positionRouter')
const pdfRouter = require("./pdfRouter");
const comeLeaveRouter = require("./comeLeaveRouter");
const startEndWorkTimeRouter = require("./startEndWorkTimeRouter")
const noteRouter = require("./noteRouter")
const projectAndTaskRouter = require("./projectAndTaskRouter")
const chatRouter = require("../chat/chatRouter")
const laborProtection = require("./laborProtectionRouter")
const documentTypeRouter = require("./documentTypeRouter")
const warningRouter = require("./warningRouter");
const holidayRouter = require("./holidayRouter")
const subTaskRouter = require("./subTaskRouter")
const registrationStep = require("./registrationStep")
const absenceRouter = require("./absenceRouter")

router.use("/user", userRouter);
router.use("/pdf", pdfRouter);
router.use("/time", comeLeaveRouter);
router.use("/time", startEndWorkTimeRouter);
router.use("/warning", warningRouter);
router.use("/position", position);
router.use("/note", noteRouter); // bellik
router.use("/project", projectAndTaskRouter);
router.use("/labor/protection", laborProtection);
router.use("/document/type", documentTypeRouter);
router.use("/holiday", holidayRouter);
router.use("/subtask", subTaskRouter);
router.use("/registration", registrationStep);
router.use("/absence", absenceRouter);
router.use("/chat", chatRouter);

module.exports = router;