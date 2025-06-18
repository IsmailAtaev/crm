const Router = require('express')
const router = new Router()
const ProjectAndTaskController = require('../controllers/projectAndTaskController')

router.get('/task/get', ProjectAndTaskController.getProjectAndTaskForAdmin)
router.get('/get', ProjectAndTaskController.getProjectForAdmin) // retunr one project and tasks users  
router.get('/id/get', ProjectAndTaskController.getProjectIdTasksUsers) // retunr all project and users but not tasks
router.get('/status/priority', ProjectAndTaskController.getStatusAndPriority) // retunr status priority
router.get('/get/user/projects', ProjectAndTaskController.getProjectsUser) // retunr projects for user
router.get('/get/user/tasks', ProjectAndTaskController.getProjectUserTasks) // retunr one project for user tasks

// PROJECT
router.post('/create', ProjectAndTaskController.createProject)
router.put('/updata/project', ProjectAndTaskController.updataProject)
router.delete('/delete/project', ProjectAndTaskController.removeProject)

// TASK 
router.post('/add/task/existing/project', ProjectAndTaskController.addTaskExistingProject)
router.put('/updata/task', ProjectAndTaskController.updataTask)
router.delete('/delete/task', ProjectAndTaskController.removeTask)

module.exports = router;