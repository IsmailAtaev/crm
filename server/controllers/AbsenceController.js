const { Op } = require('sequelize');
const { Absence } = require("../models/model");

// Absence - Отсутствие

class AbsenceController {
    async addAbsenceUser(req, res) {
        try {
            const { permissionUserId, userId, startDate, endDate, reason, color } = req.body;
            if (!permissionUserId || !userId || !startDate || !endDate || !reason || !color) {
                return res.status(400).json({
                    status: "400",
                    message: `Request error need body: ${permissionUserId, userId, startDate, endDate, reason, color}`
                });
            }

            const start = new Date(startDate);
            const end = new Date(endDate);
            if (end <= start) {
                return res.status(400).json({
                    status: "400",
                    message: `Request error: startDate (${startDate}) should not be later than endDate (${endDate})`
                });
            }

            const conflictingAbsence = await Absence.findOne({
                where: {
                    userId,
                    [Op.or]: [
                        { startDate: { [Op.between]: [startDate, endDate] }, },
                        { endDate: { [Op.between]: [startDate, endDate] }, },
                        {
                            [Op.and]: [
                                { startDate: { [Op.lte]: startDate } },
                                { endDate: { [Op.gte]: endDate } },
                            ]
                        },
                    ],
                },
            });

            if (conflictingAbsence) {
                return res.status(400).json({
                    status: "400",
                    message: `Request error: The absence period overlaps with an existing absence`
                });
            }

            const result = await Absence.create({ userId, startDate, endDate, reason, color });
            if (!result) {
                throw new Error("Server error when");
            }
            return res.status(200).json({ status: "200", message: "Successfully", date: result });
        } catch (e) {
            return res.status(500).json({ status: "500", message: `Server error ${e.message}` });
        }
    }

    async getAbsenceUser(req, res) {
        try {
            const { permissionUserId, userId, } = req.query;
            if (!permissionUserId || !userId) {
                return res.status(400).json({ status: "400", message: `Request error` });
            }
            const result = await Absence.findAll({ where: { userId }, order: [['createdAt', 'DESC']] })
            return res.status(200).json({ status: "200", message: "Successfully", date: result });
        } catch (e) {
            return res.status(500).json({ status: "500", message: `Server error ${e.message}` });
        }
    }

    async getAbsenceAll(req, res) {
        try {
            const result = await Absence.findAll({ order: [['createdAt', 'DESC']] })
            return res.status(200).json({ status: "200", message: "Successfully", date: result });
        } catch (e) {
            return res.status(500).json({ status: "500", message: `Server error ${e.message}` });
        }
    }

    async deleteOneAbsenceForUser(req, res) {
        try {
            const { permissionUserId, userId, absenceId } = req.query;
            if (!permissionUserId || !userId || !absenceId) {
                return res.status(400).json({ status: "400", message: `Request error` });
            }

            const result = await Absence.destroy({ where: { id: absenceId, userId } })
            if (result === 0) {
                throw new Error(`do not deleted Absence for userId ${userId} absenceId${absenceId}, check please`);
            }
            return res.status(200).json({ status: "200", message: "Successfully", date: result });
        } catch (e) {
            return res.status(500).json({ status: "500", message: `Server error ${e.message}` });
        }
    }

    async updateOneAbsenceForUser(req, res) {
        try {
            const { permissionUserId, userId, absenceId, startDate, endDate, reason, color } = req.body;
            if (!permissionUserId || !userId || !absenceId || !startDate || !endDate || !reason || !color) {
                return res.status(400).json({
                    status: "400",
                    message: `Request error need body: (permissionUserId, userId, absenceId, startDate, endDate, reason)`
                });
            }

            const start = new Date(startDate);
            const end = new Date(endDate);
            if (end <= start) {
                return res.status(400).json({
                    status: "400",
                    message: `Request error: startDate (${startDate}) should not be later than endDate (${endDate})`
                });
            }

            const conflictingAbsence = await Absence.findOne({
                where: {
                    userId,
                    id: { [Op.ne]: absenceId },
                    [Op.or]: [
                        { startDate: { [Op.between]: [startDate, endDate] } },  // Новый период входит в существующий
                        { endDate: { [Op.between]: [startDate, endDate] } },    // Существующий период входит в новый
                        {
                            [Op.and]: [
                                { startDate: { [Op.lte]: startDate } },  // Новый период полностью покрыт существующим
                                { endDate: { [Op.gte]: endDate } }
                            ]
                        },
                    ],
                },
            });

            if (conflictingAbsence) {
                return res.status(400).json({
                    status: "400",
                    message: `Request error: The absence period overlaps with an existing absence`
                });
            }

            const start_date = new Date(startDate);
            const end_date = new Date(endDate);
            const startDay = start_date.toISOString().split('T')[0];
            const endDay = end_date.toISOString().split('T')[0];
            const diffTime = Math.abs(new Date(endDay) - new Date(startDay));
            const daysOff = Math.ceil(diffTime / (1000 * 3600 * 24));

            const [updatedCount, updatedAbsence] = await Absence.update(
                { startDate, endDate, reason, daysOff, color },
                {
                    where: { id: absenceId, userId },
                    returning: true,
                    plain: true
                }
            );

            if (updatedCount === 0) {
                return res.status(404).json({
                    status: "404",
                    message: `Absence record not found or already updated`
                });
            }

            return res.status(200).json({
                status: "200",
                message: "Successfully",
                data: updatedAbsence
            });
        } catch (e) {
            console.log(e)
            return res.status(500).json({ status: "500", message: `Server error: ${e.message}` });
        }
    }
}

module.exports = new AbsenceController();