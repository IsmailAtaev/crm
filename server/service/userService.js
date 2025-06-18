const { User, EmployeeRegistrationTime, Position, StartEndWorkTime } = require("../models/model");
const bcrypt = require("bcryptjs");
const ApiError = require("../error/ApiError");
const { Op } = require('sequelize');
const moment = require('moment');
const path = require("path");
const fs = require('fs');
const { PERMISIONS } = require("../consts");


class UserService {
    async registration(surname, name, birthday, phoneNumber, mail, whereStudy, whereLive, languages, role, login, pass, positionId) {
        try {
            const candidate = await User.findOne({ where: { login } });
            if (candidate) throw new Error("User exists in CRM with login: " + login);

            const hash = await bcrypt.hash(pass, 3);
            const user = await User.create({ surname, name, birthday, phoneNumber, mail, whereStudy, whereLive, languages, role, login, pass: hash, positionId });

            if (!user) throw new Error("Server error registration");
            const workTime = await StartEndWorkTime.create({ userId: user.id });

            if (!workTime) throw new Error(`Do not create work time for user ID = ${user.id}`);
            return true;

        } catch (error) {
            throw new Error(error.message);
        }
    }

    async login(login, pass) {
        try {
            const user = await User.findOne({
                where: { login }, include: [
                    { model: Position, as: 'position', },
                    { model: StartEndWorkTime, as: 'workTime', }
                ]
            });

            if (!user) throw new Error("Error client request login");

            if (user.status === false) throw new Error("Error client false you do not active question for admin");

            const res = await bcrypt.compare(pass, user.pass);

            if (!res) throw new Error("Error client request password");
            return user;
        } catch (e) {
            throw new Error(e.message);
        }
    }

    async addImpageProfil(userId, fileName) {
        try {
            const findUser = await User.findByPk(userId);

            if (findUser.img !== null) {
                const imgPath = path.join(__dirname, "..", 'public', 'images', `${findUser.img}`);

                fs.unlink(imgPath, (err) => {
                    if (err) throw new Error(`Ошибка при обновлении фото: ${err.message}`);
                });
            }

            const [updateImageDB, updatedUser] = await User.update({ img: fileName }, { where: { id: userId }, returning: true })

            if (updateImageDB === 0) throw new Error("error update Photo profil");

            return updatedUser[0];
        } catch (e) {
            const imgPath = path.join(__dirname, "..", 'public', 'images', `${fileName}`);

            fs.unlink(imgPath, (err) => {
                if (err) console.error(`Ошибка при удалении файла: ${err.message}`);
            });

            throw new Error(e.message)
        }
    }

    async getUsers() {
        const users = await User.findAll({
            where: { status: true },
            include: [
                { model: Position, as: 'position' },
                { model: StartEndWorkTime, as: 'workTime', }
            ],
            order: [["name", "ASC"]]
        });

        if (!users) throw new Error("do not have users");

        return users
    }

    async updateUser(userId, name, surname, phoneNumber, languages, whereLive, whereStudy, mail, birthday, positionId, doorId) {

        const [updateUserName] = await User.update({
            name, languages, surname, phoneNumber, whereStudy, whereLive, mail, birthday, positionId, doorId
        }, { where: { id: userId } })

        if (updateUserName === 0) throw new Error("Do not updata user" + name);

        const updatedUser = await User.findOne({
            where: { id: userId },
            include: [{ model: Position, as: 'position' }]
        });

        if (!updatedUser) throw new Error("Do not updata user" + name);

        return updatedUser;
    }

    async updataUserPosition(userId, newPositionId) {
        const position = await Position.findByPk(newPositionId);

        if (!position) throw new Error("Not found position " + newPositionId);

        const [updataUserName] = await User.update({ positionId: newPositionId }, { where: { id: userId } })

        if (updataUserName === 0) throw new Error("Do not updata user postion");

        const user = await User.findOne({
            where: { id: userId },
            include: [
                { model: Position, as: 'position' }
            ]
        });

        return user;
    }

    async getUserStatus() {
        const users = await User.findAll({
            attributes: { exclude: ['pass'] },
            include: [
                { model: StartEndWorkTime, as: 'workTime', }
            ],
            order: [['name', 'ASC']]
        });

        if (!users) throw new Error("Do not find users");

        return users
    }

    async updataUserStatus(userId, status) {
        const [updataStatus] = await User.update({ status }, { where: { id: userId } })

        if (updataStatus === 0) throw new Error("Do not updata user status");

        const updatedUser = await User.findOne({
            where: { id: userId },
            include: [
                { model: Position, as: 'position' }
            ]
        });

        if (!updatedUser) throw new Error("User not found after update");

        return updatedUser;
    }

    async getItemUser(id) {
        const user = await User.findOne({
            attributes: { exclude: ['pass', 'createdAt', 'updatedAt', 'positionId'] },
            where: { id },
            include: [
                { attributes: { exclude: ['createdAt', 'updatedAt'] }, model: Position, as: 'position' },
                { model: StartEndWorkTime, as: 'workTime', }
            ]
        });

        if (!user) throw new Error("Do not find user");

        return user
    }

    async updateUserPasswordLogin(editorId, userId, newPassword, newLogin) {
        try {
            const admin = await User.findByPk(editorId);
            if (!admin) throw new Error("Admin not found: " + editorId);

            if (admin.role !== "ADMIN") throw new Error(`Permission denied for ${admin.name} (ID: ${editorId})`);

            const user = await User.findByPk(userId);
            if (!user) throw new Error(`User not found (ID: ${userId})`);

            const hash = await bcrypt.hash(newPassword, 3);
            const [updatePasswordLogin] = await User.update({ login: newLogin, pass: hash }, { where: { id: userId } });

            // Check if the update was successful
            if (updatePasswordLogin === 0) throw new Error("Failed to update user password and login");

            // Optionally return some success message or the updated user
            return `User ID ${userId} login and password updated successfully.`;

        } catch (e) {
            throw new Error(e.message);
        }
    }

    async updateUserRole(editorId, userId, newRole) {
        try {
            const admin = await User.findByPk(editorId);
            if (!admin) throw new Error("Admin not found: " + editorId);

            if (admin.role !== "ADMIN") throw new Error(`Permission denied for ${admin.name} (ID: ${editorId})`);

            const user = await User.findByPk(userId);
            if (!user) throw new Error(`User not found (ID: ${userId})`);

            const correctRole = PERMISIONS.find(permission => permission === newRole);

            if (correctRole) {
                const [updateRole] = await User.update({ role: newRole }, { where: { id: userId } });
                if (updateRole === 0) throw new Error("Failed to update user role");
            }
            else throw new Error(` Permisions: (${PERMISIONS}) Role: ("${newRole}") is not valid. `);

            return `User ID ${userId} role updated successfully.`;
        } catch (e) {
            throw new Error(e.message);
        }
    }

    async getUsersAndWorkTime(date) {
        const startOfDay = moment.utc(date).startOf('day').format();
        const endOfDay = moment.utc(date).endOf('day').format();

        const users = await User.findAll({
            attributes: { exclude: ['pass', 'createdAt', 'updatedAt', "login"] },
            where: { status: true },
            include: [
                {
                    model: EmployeeRegistrationTime,
                    as: "employeeRegistrationTimes",
                    attributes: { exclude: ['createdAt', 'updatedAt', 'userId', 'flag'] },
                    where: {
                        comeTime: {
                            [Op.between]: [startOfDay, endOfDay]
                        }
                    },
                    required: false,
                },
                {
                    model: Position, as: "position",
                    attributes: { exclude: ['createdAt', 'updatedAt'] },
                    required: false,
                },
                { model: StartEndWorkTime, as: 'workTime' }

            ],
            order: [
                ['name', 'ASC'], [{ model: EmployeeRegistrationTime, as: "employeeRegistrationTimes" }, 'comeTime', 'ASC'],
            ]
        });

        const plainUsers = users.map(user => user.get({ plain: true }));

        if (!users) return ApiError.badRequest("Do not have users");

        return plainUsers
    }
}

module.exports = new UserService();