const { PdfDocument, DocumtType, User } = require("../models/model");
const path = require('path');
const fs = require('fs');

class PdfService {
    async addFile(userId, title, pathPdf, documentTypeId) {
        let pdfDoc = null;

        const docType = await DocumtType.findByPk(documentTypeId)

        if (docType) {
            pdfDoc = await PdfDocument.create({ userId, title, pathPdf, documentTypeId });
            if (!pdfDoc) throw new Error("Document creation returned no result.");
        }
        else throw new Error("Not found document type ID: " + documentTypeId);

        return pdfDoc;
    }

    async editDoc(title, userId, documentId, documentTypeId) {
        try {
            const user = await User.findByPk(userId)

            if (!user) throw new Error("Not found user for update document");

            const docType = await DocumtType.findByPk(documentTypeId)

            if (!docType) throw new Error("Not found document type for update document");

            const [updatedCount, updatedDocument] = await PdfDocument.update(
                { title, documentTypeId },
                { where: { id: documentId }, returning: true, }
            );

            if (updatedCount === 0) throw new Error("Do not update note");

            return { message: "Successfully", data: updatedDocument[0] };
        } catch (e) {
            throw new Error({ message: e.message })
        }
    }

    async getFiles(userId) {
        const documentTypesWithPdfDocuments = await DocumtType.findAll({
            include: [{ model: PdfDocument, as: 'pdfDocuments', where: { userId, deleted: false }, required: false, }],
        });

        return documentTypesWithPdfDocuments;
    }



    async editDocumentFile(title, userId, documentId, documentTypeId, pathPdf) {
        try {
            const user = await User.findByPk(userId)

            if (!user) throw new Error("Not found user for update document");

            const docType = await DocumtType.findByPk(documentTypeId)

            if (!docType) throw new Error("Not found document type for update document");

            const oldDoc = await PdfDocument.findByPk(documentId)

            if (!oldDoc) throw new Error("Not found document for update document");

            const absolutePath = path.join(__dirname, `../files/${oldDoc.pathPdf}`)

            const [updatedCount, updatedDocument] = await PdfDocument.update(
                { title, pathPdf, documentTypeId }, {
                where: { id: documentId },
                returning: true,
            });

            if (updatedCount === 0) throw new Error("Do not update note");

            fs.unlink(absolutePath, (err) => {
                if (err) throw new Error("Error when update file")
            });

            return { message: "Successfully   ", data: updatedDocument[0] };
        } catch (e) {
            throw new Error({ message: e.message })
        }
    }

    async deleteDoc(userId, documentId) {
        const [updateStatusDeleted] = await PdfDocument.update(
            { deleted: true },
            { where: { id: documentId, userId } })

        if (updateStatusDeleted === 0) {
            throw new Error("No document found or the document was already deleted.");
        }

        return { message: "Document successfully deleted." };
    }
}

module.exports = new PdfService();