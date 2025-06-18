const axios = require("axios")
const { Task, Holiday, EmployeeRegistrationTime } = require("../models/model")
const moment = require("moment")
const ApiError = require("../error/ApiError")
const { raw } = require("body-parser")
const { Op } = require("sequelize")


class WorkTimeController {

    async getEvents(req, res) { // updata server ubuntu 
        const { startDate, endDate } = req.query

        const startDayOfMonth = moment.unix(startDate).format("YYYY-MM-DD")
        const endDayOfMonth = moment.unix(endDate).format("YYYY-MM-DD")

        const startDay = moment(startDayOfMonth).toDate()
        const endDay = moment(endDayOfMonth).toDate()

        try {
            const holidaysDB = await Holiday.findAll({
                raw: true,
                where: {
                    date: {
                        [Op.between]: [startDay, endDay]
                    }
                },
                order: [['date', 'ASC']]
            })

            if (!holidaysDB) throw ApiError.internal("Can not create databese holiday chech your request")

            return res.json(holidaysDB);
        } catch (e) { console.log(e) }

        return res.json(true);
    }

    async addEvent(req, res) {
        const { EmployeeRegistrationTimeId, title, description, date } = req.body;

        const momentDate = moment.tz(date, 'DD-MM-YYYY HH:mm:ss', 'Asia/Ashgabat');
        const el = momentDate.toDate()

        const result = await Task.create({ title, description, date: el, EmployeeRegistrationTimeId })

        return res.json(true);
    }

    async updateEvent(req, res) {
        const { id, title, description, date, EmployeeRegistrationTimeId } = req.body;

        const updateEvent = await Task.update(
            { title, description }, {
            where: { id, EmployeeRegistrationTimeId }
        })

        if (!updateEvent) return res.json("error db when update task " + title);

        return res.json(updateEvent);
    }

    async removeEvent(req, res) {
        try {
            const eventId = req.params.id;

            if (eventId.length === 0) return res.status(400).json({ status: "400", messagge: "unknow parametr" });

            const removeEvent = await Task.destroy({ where: { id: eventId } })

            if (removeEvent > 0) return res.status(200).json({ status: "400", messagge: "Event removed successfully" });
            else return res.status(400).json({ status: "400", messagge: "Event not found or not removed" });

        } catch (e) {
            return res.status(400).json({ status: "400", messagge: "Server error" });
        }
    }

    async getUserEvents(req, res, next) {
        try {
            const userEventsDB = await EmployeeRegistrationTime.findAll({
                raw: true,
                where: {
                    userId,
                    date: { [Op.between]: [startOfDayUTC, endOfDayUTC] }
                },
                include: [{
                    model: "task",
                    required: true // Включаем только те записи времени работы, для которых есть связанная задача
                }]
            })

            return res.json(true)
        } catch (e) {
            next(ApiError.badRequest(e))
        }
    }
}

module.exports = new WorkTimeController();