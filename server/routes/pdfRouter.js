const Router = require("express");
const PdfController = require("../controllers/pdfController");
const router = new Router();
const multer = require("multer");
const path = require("path");

const storage = multer.diskStorage({
    destination: (req, file, cb) => cb(null, path.join(__dirname, '../files')),
    filename: function (req, file, cb) {
        const uniqueSuffix = Date.now();
        cb(null, uniqueSuffix + file.originalname);
    }
})
const upload = multer({ storage: storage });


const storageUpdata = multer.diskStorage({
    destination: (req, file, cb) => cb(null, path.join(__dirname, '../files')),
    filename: function (req, file, cb) {
        const uniqueSuffix = Date.now();
        cb(null, uniqueSuffix + file.originalname);
    }
})
const uploadUpdata = multer({ storage: storageUpdata });

router.post("/upload/file", upload.single("file"), PdfController.addDocument);
router.get("/get/files", PdfController.getByUserDocument);
router.delete("/delete", PdfController.deleteDocument);

router.put("/edit", PdfController.editDocument);
router.put("/edit/file", uploadUpdata.single("file"), PdfController.editDocumentFile);

module.exports = router;