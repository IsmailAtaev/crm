const { DocumtType, PdfDocument, User } = require("../models/model");


class DocumentTypeController {

    async addDocumentType(req, res) {
        try {
            const { editorId, name } = req.body;
            if (!name || !editorId) {
                return res.status(400).json({ message: "Empty obj request query. please cheked" });
            }
            const user = await User.findByPk(editorId)
            if (user.role !== "USER") {
                const documentType = await DocumtType.create({ name });
                return res.status(200).json({ message: "Successfully", data: documentType })
            } else {
                return res.status(400).json({ message: "Permision denite", data: { id: user.id, name: user.name } })
            }
        } catch (e) {
            return res.status(500).json({ message: e.message });
        }
    }

    async editDocumentType(req, res) {
        try {
            const { editorId, documentTypeId, name } = req.body
            if (!editorId || !documentTypeId || !name) {
                return res.status(400).json({ message: "Request error" });
            }

            const user = await User.findByPk(editorId)

            if (user.role !== "USER") {
                const [updatedCount, updatedDocumentType] = await DocumtType.update({ name }, { where: { id: documentTypeId }, returning: true });
                if (updatedCount === 0) {
                    throw new Error("Do not update note");
                }
                return res.status(200).json({ message: "Successfully", data: updatedDocumentType[0] });
            } else {
                return res.status(400).json({ message: "Permision dinete", data: { id: user.id, name: user.name } });
            }
        } catch (e) {
            return res.status(500).json({ message: e.message });
        }
    }

    async getDocumentTypes(req, res) {
        try {
            const documentTypes = await DocumtType.findAll({ order: [['name', 'ASC']] })
            return res.status(200).json({ message: "Successfully", data: documentTypes });
        } catch (e) {
            return res.status(500).json({ message: e.message });
        }
    }

    async deleteDocumentType(req, res) {
        try {
            const { id } = req.query;
            if (!id) {
                return res.status(400).json({ message: "Request error: id is required" });
            }

            const documentType = await DocumtType.findOne({
                where: { id },
                include: [
                    {
                        model: PdfDocument,
                        attributes: { exclude: ['userId'] },
                        as: 'pdfDocuments',
                        include: [
                            {
                                model: User,
                                as: 'user', // Указываем ассоциацию с моделью User
                                attributes: ['id', 'name', 'mail', 'surname'] // Выбираем нужные атрибуты пользователя
                            }
                        ]
                    }
                ]
            });

            if (!documentType) {
                return res.status(404).json({ message: "Document type not found" });
            }

            if (documentType.pdfDocuments.length > 0) {
                return res.status(200).json({
                    message: "Document type has related PDF documents. Please update their document type before deleting.",
                    pdfDocuments: documentType.pdfDocuments
                });
            }


            await DocumtType.destroy({ where: { id } });
            return res.status(200).json({ message: "Document type deleted successfully" });
        } catch (error) {
            return res.status(500).json({ message: error.message });
        }
    }



}

module.exports = new DocumentTypeController();