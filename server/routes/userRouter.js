const Router = require("express");
const multer = require('multer')
const path = require("path")
const router = new Router();
const userController = require("../controllers/userController");

const storage = multer.diskStorage({
    destination: function (req, file, cb) { cb(null, path.join(__dirname, '../public/images')) },
    filename: function (req, file, cb) {
        const uniqueFilename = `${Date.now()}_${file.originalname.replace(/\s+/g, '_')}`;
        cb(null, uniqueFilename);
    }
})
const upload = multer({ storage: storage })

router.patch("/updata/img", upload.single("file"), userController.uploadImagProfil)
router.post("/registration", userController.registration)
router.post("/login", userController.login)
router.get("/users", userController.getUsers)
router.put("/updata/info", userController.updataUserInfo)
router.get("/status", userController.getUsersStatus)
router.patch("/updata/status", userController.updataUserStatus)
router.patch("/updata/position", userController.updataUserPosition)
router.patch("/updata/password", userController.updataUserPasswordLogin)
router.patch("/updata/role", userController.updateRole)
router.get("/get/users", userController.getUsersAndWorkTime)
router.post("/notcome", userController.notComeWork)
router.get("/permisions", userController.getUserPermisions)


router.get("/get-ip", (req, res) => {
    let ip = 1;
    ip = req.headers['x-forwarded-for'] || req.socket.remoteAddress;

    console.log("0: ", req.headers['x-forwarded-for'])
    console.log("1: ", req.socket)
    console.log("Client IP: ", ip)
    res.json({ ip });
});

module.exports = router;