const UserService = require("../service/userService")
const { StartEndWorkTime } = require("../models/model");

class StartEndWorkTimeController {
    async getWorkTime(req, res) {
        try {
            const result = await StartEndWorkTime.findAll();
            return res.status(200).json({ data: result })
        } catch (e) {
            return res.status(500).json({ message: e.message })
        }
    }

    async addWorkTimeForUser(req, res) {
        try {
            const { permissionUserId, userId, startTime, endTime } = req.body;

            if (!permissionUserId || !userId || !startTime || !endTime) {
                return res.status(400).json({ message: "Request error" })
            }

            const user = await UserService.getItemUser(userId)

            if (user.workTime) return res.status(404).json({ message: "Ulanyjyn ish sagady bar", data: user.workTime })


            const workTime = await StartEndWorkTime.create({ userId: user.id, startTime, endTime });

            if (!workTime) {
                return res.status(500).json({ message: "Failed to create WorkTime record." })
            }

            return res.status(200).json({ data: {}, message: `Successfully create work time for userId ${userId}` })
        } catch (e) { return res.status(500).json({ message: e.message }) }
    }

    async updateWorkTimeForUser(req, res) {
        try {
            const { id, permissionUserId, userId, startTime, endTime } = req.body;

            if (!id || !permissionUserId || !userId || !startTime || !endTime) {
                return res.status(400).json({ message: "Request error" })
            }

            await UserService.getItemUser(userId)
            const [affectedRows] = await StartEndWorkTime.update({ startTime, endTime }, { where: { id, userId } });

            if (affectedRows === 0) {
                return res.status(404).json({ message: "WorkTime record not found or no changes made." })
            }

            return res.status(200).json({ message: "WorkTime updated successfully." });
        } catch (e) {
            return res.status(500).json({ message: e.message })
        }
    }

    async getWorkTimeForUser(req, res) {
        try {
            const { permissionUserId, id, userId, } = req.query;

            if (!permissionUserId || !id || !userId) {
                return res.status(400).json({ message: "Request error" })
            }

            await UserService.getItemUser(userId)
            const result = await StartEndWorkTime.findOne({ where: { id, userId } });

            if (!result) throw new Error("Do not find user work time");

            return res.status(200).json({ message: "successfully", data: result });
        } catch (e) {
            return res.status(500).json({ message: e.message })
        }
    }
}

module.exports = new StartEndWorkTimeController();