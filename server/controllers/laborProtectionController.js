const { LaborProtection, User } = require("../models/model")


class LaborProtectionController {

    async addLaborProtection(req, res) {
        try {
            const { title, description, usersId } = req.body;
            if (!title || !description || !usersId) {
                return res.status(400).json("Empty obj request. please check");
            }
            const laborProtection = await LaborProtection.create({ title, description });
            await laborProtection.setUsers(usersId);
            return res.status(200).json("OK");
        } catch (e) {
            return res.status(500).json(e.message);
        }
    }

    async deleteLaborProtection(req, res) {
        try {
            const { id, userId } = req.query;
            const user = await User.findByPk(userId);

            const laborProtection = await LaborProtection.findByPk(id);
            if (!laborProtection) {
                return res.status(404).json("LaborProtection not found");
            }

            if (user.role !== "ADMIN") {
                return res.status(403).json("Permission denied");
            }
            await laborProtection.destroy();
            return res.status(200).json({ message: "LaborProtection deleted successfully" });
        } catch (e) {
            return res.status(500).json(e.message);
        }
    }

    async editLaborProtection(req, res) {
        try {
            const { id, title, description, usersId, userId } = req.body;
            if (!id || !title || !description || !usersId) {
                return res.status(400).json("Empty obj request. Please check");
            }

            const user = await User.findByPk(userId);
            if (!user || user.role !== "ADMIN") {
                return res.status(403).json("Permission denied"); // Если не администратор
            }

            const [updated] = await LaborProtection.update(
                { title, description },
                { where: { id } } // Указываем ID для обновления конкретной записи
            );

            if (!updated) {
                return res.status(404).json("LaborProtection not found");
            }
            const laborProtection = await LaborProtection.findByPk(id);
            await laborProtection.setUsers(usersId);
            return res.status(200).json({ message: "LaborProtection updated successfully" });
        } catch (e) {
            return res.status(500).json(e.message);
        }
    }

    async getAllLaborProtection(req, res) {
        try {
            const { userId } = req.query;
            if (!userId) {
                return res.status(400).json("Empty obj request. Please check");
            }

            const user = await User.findByPk(userId);
            if (!user) {
                return res.status(404).json("User not found");
            }

            if (user.role !== "ADMIN") {
                return res.status(403).json("Permission denied");
            }

            const laborProtections = await LaborProtection.findAll({
                include: [
                    {
                        model: User,
                        attributes: ['id', 'name', 'surname'],
                        through: { attributes: [] },
                    }
                ]
            });
            return res.status(200).json(laborProtections);
        } catch (e) {
            return res.status(500).json(e.message);
        }
    }

    async getUserAllLaborProtection(req, res) {
        try {
            const { userId } = req.query;
            if (!userId) {
                return res.status(400).json("Empty obj request. Please check");
            }

            const user = await User.findByPk(userId);
            if (!user) {
                return res.status(404).json("User not found");
            }


            const laborProtections = await LaborProtection.findAll({
                include: [
                    {
                        model: User,
                        attributes: ['id', 'name', 'surname'],
                        through: {
                            attributes: [],
                            where: { userId: userId } // Указываем ID пользователя для фильтрации
                        }
                    }
                ],
                where: {
                    '$users.id$': userId // Убедитесь, что у записи есть связь с пользователем
                }
            });
            return res.status(200).json(laborProtections);
        } catch (e) {
            return res.status(500).json(e.message);
        }
    }

    // For all
    async addLaborProtectionForAll(req, res) {
        try {
            const { permissionUserId, title, description } = req.body;
            if (!permissionUserId || !title || !description) {
                return res.status(400).json("Empty obj request. please check");
            }
            const laborProtection = await LaborProtection.create({ title, description });
            return res.status(200).json({ message: "Ok", data: laborProtection });
        } catch (e) {
            return res.status(500).json(e.message);
        }
    }

    async getForAll(req, res) {
        try {
            const laborProtections = await LaborProtection.findAll({
                include: [
                    {
                        model: User,
                        attributes: [],
                        required: false
                    }
                ],
                where: { '$users.id$': null },
                order: [['createdAt', 'ASC']]
            });
            return res.status(200).json({ status: 200, message: "Ok", data: laborProtections });
        } catch (e) {
            return res.status(500).json(e.message);
        }
    }

    async editLaborProtectionForAll(req, res) {
        try {
            const { permissionUserId, id, title, description } = req.body;
            if (!permissionUserId || !id || !title || !description) {
                return res.status(400).json({ status: 400, message: "Empty obj request. Please check", data: null });
            }

            const [updated] = await LaborProtection.update({ title, description }, { where: { id } });
            if (!updated) {
                return res.status(404).json({ status: 404, message: "LaborProtection not found", data: null })
            }
            return res.status(200).json({ status: 200, message: "Successfully", data: null });
        } catch (e) {
            return res.status(500).json({ status: 500, message: e.message, data: null });
        }
    }

    async deleteForAllLaborProtection(req, res) {
        try {
            const { permissionUserId, id } = req.query;
            if (!permissionUserId || !id) {
                return res.status(400).json({ status: 404, message: "Request error", data: null });
            }

            const laborProtection = await LaborProtection.findByPk(id);
            if (!laborProtection) {
                return res.status(404).json({ status: 404, message: "LaborProtection not found", data: null });
            }
            await laborProtection.destroy();
            return res.status(200).json({ status: 200, message: "LaborProtection deleted successfully", data: null });
        } catch (e) {
            return res.status(500).json({ status: 500, message: e.message, data: null });
        }
    }
}

module.exports = new LaborProtectionController();
