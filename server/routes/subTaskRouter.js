const Router = require("express");
const router = new Router();
const SubTaskController = require("../controllers/subTaskController");

router.post("/add", SubTaskController.addSubTasks);
router.put("/update", SubTaskController.updateSubTasks);
router.delete("/delete", SubTaskController.deleteSubTask);
router.get("/get", SubTaskController.getUserSubTasks);
router.get("/get/subtasks", SubTaskController.getSubTasks);

module.exports = router;