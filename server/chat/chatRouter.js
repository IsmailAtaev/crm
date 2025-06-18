const Router = require("express");
const chatController = require("./chatController");
const router = new Router()

router.get("/users/:id", chatController.getUsers)
router.get("/chats/:id", chatController.getChats)
router.get("/histori", chatController.getChatsHistori)
router.post("/create", chatController.createChat)
router.post("/messagge", chatController.messaggeChat)


module.exports = router;