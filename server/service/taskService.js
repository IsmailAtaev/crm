const { Task, User } = require("../models/model");

class TaskService {

    async addTaskAndUser(userId, name, status, priority, startDate, endDate, completion) {
        const user = await User.findByPk(userId);

        if (!user) throw new Error("Do not find user ID in database " + userId)

        const result = await Task.create({ userId, name, status, priority, startDate, endDate, completion });

        if (!result) throw new Error("Soory do not add task")

        return result;
    }
}

module.exports = new TaskService();