const { Op } = require("sequelize")
const { ShareWarning, User, Warning } = require("../models/model")


class WarningService {
    async addWarning(title, date, color) {
        const resultWarningDB = await Warning.create({ title, date, color });

        if (!resultWarningDB) throw new Error("Can not create database warning, check your request");

        return resultWarningDB;
    }

    async getWarning(startDate, endDate) {
        const startDay = new Date(startDate);
        const endDay = new Date(endDate);

        const warningsDB = await Warning.findAll({
            where: { date: { [Op.between]: [startDay, endDay] } },
            include: [
                {
                    model: ShareWarning,
                    as: "WarningShares",
                    attributes: { exclude: ["createdAt", "updatedAt", "warningId", "id"] },
                    required: true,
                    include: [
                        {
                            model: User,
                            as: "User",
                            attributes: ["name", "surname"],
                            required: true,
                        },
                    ],
                },
            ],
            order: [["createdAt", "DESC"]],
            required: false,
        });

        if (!warningsDB || warningsDB.length === 0) return [];

        return warningsDB;
    }

    async remove(id) {
        const result = await Warning.destroy({ where: { id } });
        if (!result) {
            throw new Error("Can not remove warning, check your request");
        }
        return result;
    }

    // Share Warning
    async warningPost(title, date, color, users) {

        const resultWarningDB = await Warning.create({ title, date, color });
        if (!resultWarningDB) {
            throw new Error("Can not create database warning, check your request");
        }

        for (let u of users) {
            const share = await ShareWarning.create({ warningId: resultWarningDB.id, userId: u.id });
            if (!share) {
                throw new Error("Can not create database warning share, check your request");
            }
        }
        return "OK";
    }

    async getWarningShare(startDate, endDate, userId) {
        const startDay = new Date(startDate);
        const endDay = new Date(endDate);

        const share = await Warning.findAll({
            attributes: { exclude: ['createdAt', 'updatedAt'] },
            where: { date: { [Op.between]: [startDay, endDay] } },
            include: [
                {
                    model: ShareWarning,
                    as: "WarningShares",
                    attributes: { exclude: ['createdAt', 'updatedAt', 'warningId', 'userId', 'id'] },
                    where: { userId },
                    required: true,
                },
            ],
            order: [['date', 'ASC']],
        });
        return share;
    }

    async removeShareWarningsItem(warningId, userId) {
        const result = await ShareWarning.destroy({ where: { warningId, userId } });
        if (result === 0) {
            return `No record found for warningId: ${warningId} and userId: ${userId}`;
        }
        return "OK deleted";
    }

    async addShareWarningUser(warningId, userId) {
        const warning = await Warning.findByPk(warningId);
        if (!warning) {
            throw new Error(`Warning with id: ${warningId} does not exist.`);
        }
        const addShareWarning = await ShareWarning.create({ warningId, userId });
        if (!addShareWarning) {
            throw new Error("Can not add database warning share, check your request");
        }
        return "OK";
    }
}

module.exports = new WarningService();