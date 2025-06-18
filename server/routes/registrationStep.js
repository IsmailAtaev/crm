const Router = require("express");
const router = new Router();
const multer = require("multer");
const path = require("path");
const RegistrationStepController = require("../controllers/registrationStepController");

const storage = multer.diskStorage({
    destination: (req, file, cb) => cb(null, path.join(__dirname, '../files')),
    filename: function (req, file, cb) {
        const uniqueSuffix = Date.now();
        cb(null, uniqueSuffix + file.originalname);
    }
});
const upload = multer({ storage: storage });

router.post("/step", upload.single("file"), RegistrationStepController.registrationStep);

module.exports = router;