const Router = require("express");
const DocumentTypeController = require("../controllers/documentTypeController");
const router = new Router();

router.post("/add", DocumentTypeController.addDocumentType);
router.put("/edit", DocumentTypeController.editDocumentType);
router.get("/get", DocumentTypeController.getDocumentTypes);
router.delete("/delete", DocumentTypeController.deleteDocumentType);

module.exports = router;