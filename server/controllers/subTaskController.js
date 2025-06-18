const { SubTask } = require("../models/model");

class SubTaskController {
    async addSubTasks(req, res) {
        try {
            const { subTasks } = req.body
            if (!subTasks) { return res.status(400).json({ message: "Request error" }) }
            await SubTask.bulkCreate(subTasks)
            return res.status(200).json({ message: "Secsefully" })
        } catch (e) {
            return res.status(500).json({ message: e.message })
        }
    }

    async updateSubTasks(req, res) {
        try {
            const { userId, taskId, id, text, isCompleted } = req.body
            if (!userId || !taskId || !id || !text) {
                return res.status(400).json({ message: "Request error" })
            }
            const result = await SubTask.update({ text, isCompleted }, { where: { id, taskId, userId } });
            if (!result) {
                return res.status(500).json("Do not update " + taskId)
            }
            return res.status(200).json({ message: "Secsefully" })
        } catch (e) {
            return res.status(500).json({ message: e.message })
        }
    }

    async deleteSubTask(req, res) {
        try {
            const { permissionId, taskId, subTaskId } = req.query;

            console.log(permissionId, taskId, subTaskId)
            if (!permissionId || !taskId || !subTaskId) {
                return res.status(400).json({ message: "No subTaskIds provided" })
            }

            const deletedCount = await SubTask.destroy({ where: { id: subTaskId, taskId: taskId } });
            if (deletedCount > 0) {
                return res.status(200).json({ message: `Successfully deleted ${deletedCount} subtask(s)` });
            } else {
                return res.status(404).json({ message: "No subtasks found to delete" });
            }
        } catch (e) {
            return res.status(500).json({ message: e.message });
        }
    }

    async getUserSubTasks(req, res) {
        try {
            const { userId, taskId } = req.query

            if (!userId || !taskId) { return res.status(400).json({ message: "Request error" }) }

            const subTasks = await SubTask.findAll({ where: { userId, taskId }, order: [['text', 'ASC']], });

            return res.status(200).json({ data: subTasks })
        } catch (e) {
            return res.status(500).json({ message: e })
        }
    }

    async getSubTasks(req, res) {
        try {
            const subTasks = await SubTask.findAll()
            return res.status(200).json({ data: subTasks })
        } catch (e) {
            return res.status(500).json({ message: e })
        }
    }
}

module.exports = new SubTaskController();