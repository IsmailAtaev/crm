const ProjectAndTaskService = require('../service/projectAndTaskService')
const TaskService = require("../service/taskService")

const { STATUS_PROJECT, STATUS_TASK, PRIORITY } = require("../consts")


class ProjectAndTaskController {

    // Projects
    async createProject(req, res) {
        try {
            // const { name, status, priority, startDate, endDate, completion, tasks } = req.body
            const { name, status, priority, startDate, endDate, tasks } = req.body
            if (!name || !status || !priority || !startDate || !endDate || !tasks) {
                return res.status(500).json({ message: 'Request error' })
            }

            // let count = 0;
            // for (const item of tasks) {
            //     count += item.completionProject
            //     if (count > 100) {
            //         throw new Error("Лимит процнтов привышает больше 100")
            //     }
            // }

            const result = await ProjectAndTaskService.createProject(name, status, priority, startDate, endDate, tasks)
            return res.status(200).json(result)
        } catch (e) {
            return res.status(500).json({ message: e.message })
        }
    }

    async updataProject(req, res) {
        try {
            const { userId, projectId, name, status, priority, startDate, endDate, archived } = req.body
            if (!userId || !projectId || !name || !status || !priority || !startDate || !endDate || archived === undefined || archived === null) {
                return res.status(500).json({ message: 'Request error' })
            }


            const result = await ProjectAndTaskService.updataProject(userId, projectId, name, status, priority, startDate, endDate, archived)
            return res.status(200).json(result)
        } catch (e) {
            return res.status(500).json({ message: e.message })
        }
    }


    // Tasks
    async addTaskExistingProject(req, res) {
        try {
            const { projectId, userId, name, status, priority, startDate, endDate } = req.body
            if (!projectId || !userId || !name || !status || !priority || !startDate || !endDate) {
                return res.status(500).json({ message: 'Request error' })
            }

            const result = await ProjectAndTaskService.addTaskExistingProject(projectId, userId, name, status, priority, startDate, endDate)
            return res.status(200).json(result)
        } catch (e) {
            return res.status(500).json({ message: e.message })
        }
    }

    async updataTask(req, res) {
        try {
            const { taskId, userId, name, status, priority, startDate, endDate, completionTask } = req.body

	   if (completionTask < 0 || completionTask > 100) {
                return res.status(500).json({ message: 'Request error completionTask < 0 or completionTask > 100' })
            }


            if (!taskId || !userId || !name || !status || !priority || !startDate || !endDate) {
                return res.status(500).json({ message: 'Request error' })
            }

            if (completionTask > 100) {
                return res.status(500).json({ message: 'Request error completionTask then 100%' })
            }


            const result = await ProjectAndTaskService.updataTask(taskId, userId, name, status, priority, startDate, endDate, completionTask)
            return res.status(200).json(result)
        } catch (e) {
            return res.status(500).json({ message: e.message })
        }
    }

    async removeProject(req, res) {
        try {
            const { projectId, responsibleUserId } = req.query
            if (!projectId || !responsibleUserId) {
                return res.status(500).json({ message: 'Request body error' })
            }
            const result = await ProjectAndTaskService.removeProject(projectId, responsibleUserId)
            return res.status(200).json(result)
        } catch (e) {
            return res.status(500).json({ message: e.message })
        }
    }

    // Gets
    async getProjectAndTaskForAdmin(req, res) {
        try {
            const result = await ProjectAndTaskService.getProjectsAndTask()
            return res.status(200).json(result)
        } catch (e) {
            return res.status(500).json({ message: e.message })
        }
    }

    async getProjectForAdmin(req, res) { // retunr one project and tasks users 
        try {
            const result = await ProjectAndTaskService.getProjects()
            return res.status(200).json(result)
        } catch (e) {
            return res.status(500).json({ message: e.message })
        }
    }

    async getProjectIdTasksUsers(req, res) { // retunr all project and users but not tasks
        try {
            const { projectId } = req.query;
            if (!projectId) {
                return res.status(500).json({ message: 'Request error' })
            }
            const result = await ProjectAndTaskService.getProjectIdTasksUsers(projectId)
            return res.status(200).json(result)
        } catch (e) {
            return res.status(500).json({ message: e.message })
        }
    }

    async removeTask(req, res) {
        try {
            const { projectId, taskId, responsibleUserId } = req.query
            if (!projectId || !taskId || !responsibleUserId) {
                return res.status(500).json({ message: 'Request body error' })
            }
            const result = await ProjectAndTaskService.removeTask(projectId, taskId, responsibleUserId)
            return res.status(200).json({ message: result })
        } catch (e) {
            return res.status(500).json({ message: e.message })
        }
    }

    // Get - Status and Priority
    async getStatusAndPriority(req, res) {
        try {
            return res.status(200).json({
                message: "Ok",
                data: {
                    STATUS_PROJECT,
                    STATUS_TASK,
                    PRIORITY
                }
            })
        } catch (e) {
            return res.status(500).json({ message: e.message })
        }
    }



    async getProjectsUser(req, res) {
        try {
            const { userId } = req.query
            if (!userId) {
                return res.status(500).json({ message: 'Request error' })
            }

            const result = await ProjectAndTaskService.getProjectsUser(userId)
            return res.status(200).json(result)
        } catch (e) {
            return res.status(500).json({ message: e.message })
        }
    }

    async getProjectUserTasks(req, res) {
        try {
            const { userId, projectId } = req.query
            if (!userId || !projectId) {
                return res.status(500).json({ message: 'Request error' })
            }
            const result = await ProjectAndTaskService.getProjectUserTasks(userId, projectId)
            return res.status(200).json(result)
        } catch (e) {
            return res.status(500).json({ message: e.message })
        }
    }
}


module.exports = new ProjectAndTaskController()
