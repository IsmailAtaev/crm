const sequelize = require("../database");
const { Project, ProjectBetweenTask, User, Task, Position } = require('../models/model')
const { sqlQueryGetActiveProjectsAndUsers, sqlQueryGetNotActiveProjectsAndUsers, sqlQueryGetProjectsAndUsers } = require("../models/SQL_QUERY");
const { USER } = require("../consts")
const { getItemUser } = require("./userService");
const { FLOAT } = require("sequelize");
const { DONE } = require("../consts");


class ProjectAndTaskService {

    // Projects
    async createProject(name, status, priority, startDate, endDate, tasks) {
        const myTransaction = await sequelize.transaction();
        try {
            const projectResult = await Project.create({ name, status, priority, startDate, endDate }, { transaction: myTransaction })

            const completionUsers = (100 / tasks.length);

            for (const item of tasks) {
                const user = await User.findOne({ where: { id: item.userId, status: true } });
                if (!user) throw new Error("Do not find user ID in database " + item.userId)

                await Task.create({
                    userId: item.userId,
                    projectId: projectResult.id,
                    name: item.name,
                    status: item.status,
                    priority: item.priority,
                    startDate: item.startDate,
                    endDate: item.endDate,
                    completionProject: completionUsers
                }, { transaction: myTransaction });
            }

            await myTransaction.commit();
            return projectResult;
        } catch (e) {
            await myTransaction.rollback();
            throw new Error(e.message);
        }
    }

    async updataProject(userId, projectId, name, status, priority, startDate, endDate, archived) {
        try {
            // const user = await getItemUser(userId);
            // if (user.role === USER) { return { message: "Dinete permisions" }; }

            const [projectUpdata] = await Project.update(
                { name, status, priority, startDate, endDate, archived },
                { where: { id: projectId } })

            if (projectUpdata === 1) {
                return { message: "Project updated successfully" }
            } else {
                return { message: "No project found with this ID " + projectId }
            }
        } catch (e) {
            return "Error updating task" + e.message;
        }
    }

    async removeProject(projectId, responsibleUserId) {
        try {
            // const responsibleUser = await getItemUser(responsibleUserId);
            // if (responsibleUser.role === USER) {
            //  return { message: "Dinete permisions" }
            //}

            const projectRemove = await Project.destroy({ where: { id: projectId }, });
            return projectRemove === 1
                ? { message: "Project remove successfully" }
                : { message: `Do not remove project with this ID ${projectId}` };

        } catch (e) {
            throw new Error(e.message);
        }
    }

    // Tasks
    async addTaskExistingProject(projectId, userId, name, status, priority, startDate, endDate) {
        const myTransaction = await sequelize.transaction();
        try {
            await getItemUser(userId);
            const projectExisting = await Project.findByPk(projectId)
            if (!projectExisting) {
                return { message: "Project not found for add task user id " + userId };
            }

            //const taskCount = await Task.count({ where: { projectId } }, { transaction: myTransaction });
            const taskCount = await Task.count({ where: { projectId } }, { transaction: myTransaction });
            const procent = (100 / (taskCount + 1));

            const resultTask = await Task.create(
                { userId, projectId, name, status, priority, startDate, endDate, completionProject: procent },
                { transaction: myTransaction }
            )

            if (!resultTask) return { message: "Task not create" };

            await Task.update({ completionProject: procent }, { where: { projectId: projectId }, transaction: myTransaction });

            await myTransaction.commit();
            await calculateProcentProject(projectId)
            return { message: "Task created" };
        } catch (e) {
            await myTransaction.rollback();
            throw new Error(e.message);
        }
    }

    async updataTask(taskId, userId, name, status, priority, startDate, endDate, completionTask) {
        try {

            await getItemUser(userId);

            // Обновление задачи и получение обновленных данных
            const [taskUpdatedCount, [updatedTask]] = await Task.update(
                { userId, name, status, priority, startDate, endDate, completionTask }, {
                where: { id: taskId },
                returning: true
            });

            // Проверка, была ли задача обновлена
            if (taskUpdatedCount === 0) return "No task found with this ID";

            await calculateProcentProject(updatedTask.projectId);
            await this._updateProjectStatus(updatedTask.projectId);

            return { message: "Task updated successfully", updatedTask };
        } catch (e) {
            return "Error updating task" + e.message;
        }
    }

    async removeTask(projectId, taskId, responsibleUserId) {
        const myTransaction = await sequelize.transaction();
        try {
            // const responsibleUser = await getItemUser(responsibleUserId);
            // if (responsibleUser.role === "USER") {
            //    throw new Error("Dinete permisions");
            //}

            const taskCount = await Task.count({ where: { projectId } }, { transaction: myTransaction });
            const procent = taskCount > 0 ? (100 / (taskCount - 1)) : 0;

            const taskRemove = await Task.destroy({ where: { id: taskId, projectId }, transaction: myTransaction });

            await Task.update({ completionProject: procent }, { where: { projectId: projectId }, transaction: myTransaction });

            await myTransaction.commit();
            await calculateProcentProject(projectId)
            return taskRemove === 1 ? "Task remove successfully" : `Do not remove task with this ID ${taskId}`;
        } catch (e) {
            await myTransaction.rollback();
            throw new Error(e.message);
        }
    }

    /** Gets */
    async getProjectsAndTask() {
        const projects = await Project.findAll({
            include: [
                {
                    model: Task,
                    attributes: { exclude: ['userId'] },
                    as: 'tasks',
                    include: [
                        {
                            model: User,
                            as: 'user',
                            where: { status: true },
                            attributes: ['id', 'surname', 'name', 'mail', 'role'],
                            include: [
                                {
                                    model: Position,
                                    as: 'position',
                                    attributes: ['name']

                                }
                            ]
                        }
                    ]
                }
            ],
            order: [[{ model: Task, as: 'tasks' }, 'createdAt', 'DESC']]
        });

        if (!projects) return { message: "No projects", data: [] };

        return { message: "OK", data: projects }
    }

    async getProjects() { // Return one project and tasks users 
        try {
            const results = await sequelize.query(sqlQueryGetActiveProjectsAndUsers, { type: sequelize.QueryTypes.SELECT });

            if (Array.isArray(results) && results.length > 0)
                return { message: "OK", data: results };
            else return { message: "No data found", data: [] };

        } catch (error) {
            return { message: "Error executing query", data: [], error: error.message };
        }
    }

    async getProjectIdTasksUsers(projectId) { // Return all project and users but not tasks

        ///  await calculateProcentProject(projectId)

        const project = await Project.findOne({
            where: { id: projectId },
            include: [
                {
                    model: Task,
                    attributes: { exclude: ["userId", "projectId"] },
                    as: 'tasks',
                    include: [
                        {
                            model: User,
                            as: 'user',
                            where: { status: true },
                            attributes: ['id', 'surname', 'name', 'mail', 'role'],
                            include: [
                                {
                                    model: Position,
                                    as: 'position',
                                    attributes: ['name']

                                }
                            ]
                        }
                    ]
                }
            ], order: [[{ model: Task, as: 'tasks' }, 'createdAt', 'DESC']]
        });

        if (!project) return { message: "No projects", data: [] };

        return { message: "OK", data: project }
    }

    async getProjectsUser(userId) { // Return projects for user 
        try {
            const projects = await Project.findAll({
                where: { archived: false },
                // 'id' = Project.id
                attributes: ['id', 'name', 'status', 'priority', 'startDate', 'endDate', 'completion', 'archived', 'createdAt', 'updatedAt'],
                include: [{
                    model: Task,
                    as: 'tasks',
                    where: { userId },
                    required: true, // Делает INNER JOIN
                    attributes: [] // Не хотим возвращать поля задач
                }],
                // 'project.id' Указываем имя атрибута с префиксом
                group: ['project.id', 'project.name', 'project.status', 'project.priority', 'project.startDate', 'project.endDate', 'project.completion', 'project.archived', 'project.createdAt', 'project.updatedAt'],
                order: [['createdAt', 'ASC']],
            });

            if (!projects) return { message: "No projects", data: [] };

            return { message: "OK", data: projects }
        } catch (e) {
            throw new Error(e.message)
        }
    }

    async getProjectUserTasks(userId, projectId) { // Return one project for user tasks 
        try {
            const projects = await Project.findOne({
                where: { archived: false, id: projectId },
                include: [{ model: Task, as: 'tasks', where: { userId }, required: true, }]
            });

            if (!projects) return { message: "No projects", data: [] };

            return { message: "OK", data: projects }
        } catch (e) {
            throw new Error(e.message)
        }
    }

    /** Cheeked Tasks and update Project status */
    async _updateProjectStatus(projectId) {
        const allTasks = await Task.findAll({ where: { projectId }, attributes: ['status'] });

        // Проверяем, завершены ли все задачи проекта
        const allTasksDone = allTasks.every(task => task.status === "Tamamlanan");

        // Обновляем статус проекта на 'DONE'
        if (allTasksDone) {
            await Project.update({ status: "Tamamlanan" }, { where: { id: projectId } });
        }
    }
}


async function calculateProcentProject(projectId) {
    try {
        const updata = `
            UPDATE projects 
            SET completion = (
                SELECT SUM(t."completionProject" * t."completionTask" / 100)
                FROM tasks t 
                WHERE t."projectId" = projects.id
            )
            WHERE id = :projectId; 
        `;

        const results = await sequelize.query(updata, {
            replacements: { projectId: projectId }, // безопасная подстановка параметров
            type: sequelize.QueryTypes.UPDATE // корректный тип запроса
        });
    } catch (e) {
        throw new Error(e.message)
    }
}

module.exports = new ProjectAndTaskService();