const bcrypt = require("bcryptjs");
const path = require('path');
const fs = require('fs');
const sequelize = require("../database");
const { User, Position, StartEndWorkTime, DocumtType, PdfDocument } = require("../models/model");

function removeDocumentPdf(pathPdf) {
    const absolutePath = path.join(__dirname, `../files/${pathPdf}`)
    fs.unlink(absolutePath, (err) => {
        if (err) { throw new Error("Error when update file") }
    });
}

class RegistrationStepController {
    async registrationStep(req, res) {
        const myTransaction = await sequelize.transaction();
        let pathPdf = null;
        try {
            pathPdf = req.file.filename;
            const { surname, name, birthday, phoneNumber, mail, whereStudy, whereLive, languages, pass, positionId, title, documentTypeId } = req.body;

            if (!surname || !name || !birthday || !phoneNumber || !mail || !whereStudy || !whereLive || !languages || !pass || !positionId || !title || !documentTypeId || !pathPdf) {
                removeDocumentPdf(pathPdf)
                await myTransaction.rollback();
                return res.status(400).json({ status: 400, message: `Empty obj request query. please checked` });
            }

            const login = phoneNumber;

            const docType = await DocumtType.findByPk(documentTypeId)
            if (!docType) {
                removeDocumentPdf(pathPdf)
                await myTransaction.rollback();
                return res.status(404).json({ status: 404, message: `Not found documentTypeId: ${documentTypeId}` });
            }

            const position = await Position.findByPk(positionId)
            if (!position) {
                removeDocumentPdf(pathPdf)
                await myTransaction.rollback();
                return res.status(404).json({ status: 404, message: `Not found positionId: ${positionId} ` });
            }

            const candidate = await User.findOne({ where: { login } });
            if (candidate) {
                removeDocumentPdf(pathPdf)
                await myTransaction.rollback();
                return res.status(404).json({ status: 404, message: `User exists in CRM with login: ${login}` });
            }

            const hash = await bcrypt.hash(pass, 3);
            const user = await User.create(
                { surname, name, birthday, phoneNumber, mail, whereStudy, whereLive, languages, role: "USER", login, pass: hash, positionId },
                { transaction: myTransaction });

            if (!user) {
                removeDocumentPdf(pathPdf)
                await myTransaction.rollback();
                return res.status(500).json({ status: 500, message: `Server do not registration this user: ${surname} ${name}. please say administration` });
            }

            const workTime = await StartEndWorkTime.create({ userId: user.id, startTime: "09:00", endTime: "18:00" }, { transaction: myTransaction });
            if (!workTime) {
                removeDocumentPdf(pathPdf)
                await myTransaction.rollback();
                return res.status(500).json({ status: 500, message: `Iş sagatyny create funcsiyasy ýerine yetirlmedi. Administratora yuzlenin` });
            }

            const pdfDoc = await PdfDocument.create({ userId: user.id, title, pathPdf, documentTypeId }, { transaction: myTransaction });
            if (!pdfDoc) {
                removeDocumentPdf(pathPdf)
                await myTransaction.rollback();
                return res.status(500).json({ status: 500, message: `Do not add document. please say administration, thanks.` });
            }
            await myTransaction.commit();

            const newUser = await User.findOne({
                where: { id: user.id },
                required: false,
                include: [
                    { model: Position, as: "position", attributes: { exclude: ['createdAt', 'updatedAt'] }, required: false, },
                    { model: StartEndWorkTime, as: 'workTime', required: false, },
                    { model: PdfDocument, as: 'pdfDocuments', required: false, }
                ],
            })

            return res.status(200).json({ status: 200, message: "true", data: newUser })
        } catch (e) {
            try {
                removeDocumentPdf(pathPdf)
                await myTransaction.rollback();
            } catch (error) {
                await myTransaction.rollback();
                return res.status(500).json({ status: 500, message: error.message });
            }
            await myTransaction.rollback();
            return res.status(500).json({ status: 500, message: e.message });
        }
    }
}

module.exports = new RegistrationStepController();

function generateUUID() {
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
        var r = crypto.getRandomValues(new Uint8Array(1))[0] & 15;
        var v = c === 'x' ? r : (r & 0x3 | 0x8);
        return v.toString(16);
    });
};