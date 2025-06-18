const { Warning, ShareWarning } = require("../models/model")
const WarningService = require("../service/warning")


class WarningController {
    async create(req, res) {
        try {
            const { title, date, color } = req.body

            if (!title || !date || !color) {
                return res.status(400).json("Require error")
            }

            await WarningService.addWarning(title, date, color)
            return res.status(200).json("OK")
        } catch (e) {
            return res.status(500).json("Server error holiday add")
        }
    }

    async getWarnings(req, res) {
        try {
            const { startDate, endDate } = req.query;

            if (!startDate || !endDate) {
                return res.status(400).json("Request error")
            }

            const reslut = await WarningService.getWarning(startDate, endDate)
            return res.status(200).json(reslut)
        } catch (e) {
            return res.status(500).json("Server error holiday")
        }
    }

    async editWarning(req, res) {
        try {
            const { id, title, color, date } = req.body

            if (!id || !title || !color || !date) {
                return res.status(400).json("Request error")
            }

            const result = await Warning.update({ title, color, date }, { where: { id } });

            if (!result) return res.status(500).json("Do not update" + id)

            return res.status(200).json("OK")
        } catch (e) {
            return res.status(500).json("Server error when update")
        }
    }

    async deleteWarning(req, res) {
        try {
            const { id } = req.query
            if (!id) { return res.status(400).json("Request error") }

            const result = await Warning.destroy({ where: { id } })
            if (!result) return res.status(500).json("Do not remove holiday " + id)

            return res.status(200).json("OK")
        } catch (e) {
            return res.status(500).json("Server error when remove holiday")
        }
    }

    // Share holiday
    async post(req, res) {
        try {
            const { title, date, color, users } = req.body

            if (!title || !date || !color || !users) return res.status(400).json("Require error")

            await WarningService.warningPost(title, date, color, users)

            return res.status(200).json("OK")
        } catch (e) {
            return res.status(500).json("Server error add")
        }
    }

    async getWarningShare(req, res) {
        try {
            const { startDate, endDate, userId } = req.query;

            if (!startDate || !endDate || !userId) return res.status(400).json("Request error")

            const reslut = await WarningService.getWarningShare(startDate, endDate, userId)

            return res.status(200).json(reslut)
        } catch (e) {
            return res.status(500).json("Server error holiday")
        }
    }

    async deleteWarningShare(req, res) {
        try {
            const { warningId, userId } = req.query
            if (!warningId || !userId) return res.status(400).json("Request error")

            const reslut = await WarningService.removeShareWarningsItem(warningId, userId)

            return res.status(200).json(reslut)
        } catch (e) {
            return res.status(500).json("Server error when remove holiday")
        }
    }

    async addWarningShareUser(req, res) {
        try {
            const { warningId, userId } = req.body

            if (!warningId || !userId) return res.status(400).json("Request error")

            const reslut = await WarningService.addShareWarningUser(warningId, userId)

            return res.status(200).json(reslut)
        } catch (e) {
            return res.status(500).json({ error: e.message || "Server error" });
        }
    }

    async editWarningAndUsers(req, res) {
        try {
            const { warningId, title, color, date, users } = req.body

            if (!warningId || !title || !color || !date || !users) return res.status(400).json("Request error")

            const result = await Warning.update({ title, color, date }, { where: { id: warningId } });

            if (!result) return res.status(500).json("Do not updated" + warningId)

            const shareWarning = await ShareWarning.findAll({ where: { warningId } })
            const sharedUserIds = shareWarning.map(item => item.userId);
            const userIds = users.map(user => user.id);

            if (users.length > shareWarning.length) {

                let notSharedUsers = users.filter(user => !sharedUserIds.includes(user.id));

                for (const u of notSharedUsers) {
                    await ShareWarning.create({ warningId, userId: u.id })
                }
            }
            else {
                let extraSharedUserIds = sharedUserIds.filter(id => !userIds.includes(id));
                let extraSharedUsers = extraSharedUserIds.map(id => ({ id }));

                for (const u of extraSharedUsers) {
                    await ShareWarning.destroy({ where: { warningId, userId: u.id } })
                }
            }
            return res.status(200).json({ msg: "OK" })
        } catch (e) {
            return res.status(500).json(e.message)
        }
    }
}

module.exports = new WarningController();