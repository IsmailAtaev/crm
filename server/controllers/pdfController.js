const axios = require("axios");
const ApiError = require("../error/ApiError");
const PdfService = require("../service/pdfService");


class PdfController {

    async addDocument(req, res) {
        try {
            const pathPdf = req.file.filename;
            const { title, userId, documentTypeId } = req.body;
            if (!userId || !title || !pathPdf || !documentTypeId) {
                return res.status(400).json("Empty obj request query. please cheked");
            }
            const result = await PdfService.addFile(userId, title, pathPdf, documentTypeId);
            return res.status(200).json(result)
        } catch (e) {
            return res.status(500).json("Server error add pdf document");
        }
    }

    async editDocument(req, res) {
        try {
            const { title, userId, documentId, documentTypeId } = req.body
            if (!title || !userId || !documentId || !documentTypeId) {
                return res.status(400).json("Request error");
            }
            const Doc = await PdfService.editDoc(title, userId, documentId, documentTypeId)
            return res.status(200).json(Doc)
        } catch (e) {
            return res.status(500).json({ messagge: e });
        }
    }



    async editDocumentFile(req, res) {
        try {
            const pathPdf = req.file.filename;
            const { title, userId, documentId, documentTypeId } = req.body
            if (!title || !userId || !documentId || !documentTypeId || !pathPdf) {
                return res.status(400).json("Request error");
            }
            const Doc = await PdfService.editDocumentFile(title, userId, documentId, documentTypeId, pathPdf)
            return res.status(200).json(Doc)
        } catch (e) {
            return res.status(500).json({ messagge: e });
        }
    }


    async deleteDocument(req, res) {
        try {
            const { userId, documentId } = req.query
            if (!userId || !documentId) {
                return res.status(400).json("User ID is required.");
            }
            const removeDoc = await PdfService.deleteDoc(userId, documentId)
            return res.status(200).json(removeDoc)
        } catch (e) {
            return res.status(500).json({ messagge: "Remove document server error", date: e });
        }
    }


    async getByUserDocument(req, res) {
        try {
            const { userId } = req.query;
            if (!userId) {
                return res.status(400).json({ error: "User ID is required." });
            }
            const docs = await PdfService.getFiles(userId);
            return res.status(200).json(docs);
        } catch (e) {
            return res.status(500).json("Get documents server error");
        }
    }
}

module.exports = new PdfController();