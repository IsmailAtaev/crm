const UserService = require("../service/userService");
const { EmployeeRegistrationTime, Task } = require("../models/model");
const { PERMISIONS } = require("../consts");


class userController {

    async registration(req, res) {
        try {
            const { surname, name, birthday, phoneNumber, mail, whereStudy, whereLive, languages, role, login, pass, positionId } = req.body;
            if (!surname || !name || !birthday || !phoneNumber || !mail || !whereStudy || !whereLive || !languages || !role || !pass || !positionId) {
                return res.status(400).json("Empty obj request. please cheked");
            }
            const result = await UserService.registration(surname, name, birthday, phoneNumber, mail, whereStudy, whereLive, languages, role, login, pass, positionId);
            return res.status(200).json({ data: "Successfully" });
        }
        catch (e) {
            if (e.message.includes('User exists in CRM with login')) {
                return res.status(409).json({ message: e.message });  // Код 409 Conflict для конфликта ресурса
            }
            return res.status(500).json({ message: 'Internal Server Error' });  // Возвращаем стандартное сообщение об ошибке

        }
    }

    async login(req, res) {
        try {
            const { login, pass } = req.body;
            if (!pass || !login) {
                return res.status(400).json("Empty obj request query. please cheked");
            }
            const result = await UserService.login(login, pass);
            return res.status(200).json(result);
        } catch (e) {
            return res.status(500).json(e.message);
        }
    }

    async uploadImagProfil(req, res) {
        try {
            const { userId } = req.body;
            const file = req.file.filename;

            if (!userId || !file) return res.status(400).json("Empty obj request query or file select. please cheked");

            const result = await UserService.addImpageProfil(userId, file)

            return res.status(200).json(result)
        } catch (e) {
            return res.status(500).json(e.message);
        }
    }

    async getUsers(req, res) {
        try {
            const users = await UserService.getUsers();
            return res.status(200).json(users);
        } catch (e) {
            return res.status(500).json("Not found users");
        }
    }

    async updataUserInfo(req, res) {
        try {
            const { userId, surname, name, phoneNumber, languages, whereLive, whereStudy, mail, birthday, positionId, doorId } = req.body

            if (!name || !surname || !phoneNumber || !languages || !whereLive || !whereStudy || !mail || !birthday || !positionId) {
                return res.status(400).json("Empty obj request. please cheked");
            }

            const result = await UserService.updateUser(userId, name, surname, phoneNumber, languages, whereLive, whereStudy, mail, birthday, positionId, doorId)
            return res.status(200).json(result)
        } catch (e) {
            return res.status(500).json("Server error updata user info");
        }
    }

    async getUsersStatus(req, res) {
        try {
            const result = await UserService.getUserStatus()
            return res.status(200).json({ status: 200, messagge: result })
        } catch (e) {
            return res.status(500).json({ status: 500, messagge: "Invalid status server" })
        }
    }

    async updataUserStatus(req, res) {
        try {
            const { userId, status } = req.body
            const temp = typeof status

            if (status == null || status === '') return res.status(400).json({ status: 400, messagge: "Empty status" })

            if (!userId || !temp === 'boolean') return res.status(400).json({ status: 400, messagge: "Empty userId or status" })

            const result = await UserService.updataUserStatus(userId, status)
            return res.status(200).json({ status: 200, messagge: result })
        } catch (e) {
            return res.status(500).json({ status: 500, messagge: "Server error updata user status" })
        }
    }

    async updataUserPosition(req, res) {
        try {
            const { userId, newPositionId } = req.body

            if (!userId || !newPositionId) return res.status(400).json("Empty obj request. please cheked");

            const result = await UserService.updataUserPosition(userId, newPositionId)

            return res.status(200).json(result)
        } catch (e) {
            return res.status(500).json("Server error updata user position");
        }
    }

    async getUsersAndWorkTime(req, res) {
        try {
            const { date } = req.query;

            if (!date) return res.status(400).json("Empty obj request. please cheked");

            const users = await UserService.getUsersAndWorkTime(date);
            return res.json({ status: 200, users });
        } catch (e) {
            return res.json(e)
        }
    }

    async notComeWork(req, res) {
        try {

            const { userId, title, description, date, flag } = req.body;

            const resultDB = await EmployeeRegistrationTime.create({ comeTime: date, userId, flag })

            if (!resultDB) return res.json({ status: "400", messagge: "Do not save come time work" });

            const result = await Task.create({ title, description, date, EmployeeRegistrationTimeId: resultDB.id })

            if (!result) return res.json({ status: "400", messagge: "Do not save come time work" });

            return res.status(200).json({ status: 200, messagge: "OK" })
        } catch (e) {
            return res.status(500).json({ status: 500, messagge: "Invalid status server" })
        }
    }

    async getUserPermisions(req, res) {
        return res.json({ message: "Ok", data: PERMISIONS });
    }

    async updataUserPasswordLogin(req, res) {
        try {
            const { editorId, userId, newPassword, newLogin } = req.body

            if (!editorId || !userId || !newPassword || !newLogin) {
                return res.status(400).json("Empty obj request. please cheked");
            }

            const result = await UserService.updateUserPasswordLogin(editorId, userId, newPassword, newLogin)

            return res.status(200).json(result)
        } catch (e) {
            return res.status(500).json("Server error update user password and login");
        }
    }

    async updateRole(req, res) {
        try {
            const { editorId, userId, newRole } = req.body

            if (!editorId || !userId || !newRole) {
                return res.status(400).json("Empty obj request. please cheked");
            }

            const result = await UserService.updateUserRole(editorId, userId, newRole)
            return res.status(200).json(result)
        } catch (e) {
            return res.status(500).json(`Server error ${e.message}`);
        }
    }
}

module.exports = new userController();