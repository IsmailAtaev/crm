const { Op } = require('sequelize')
const { Holiday } = require('../models/model')

class HolidayService {
    async get() {
        const holidays = await Holiday.findAll();
        return holidays;
    }

    async add(name, date, color) {
        try {
            const result = await Holiday.create({ name, date, color });
            if (!result) { throw new Error("Failed to create holiday") }
            return result;
        } catch (error) {
            throw new Error(error.message);
        }
    }

    async update(id, name, date, color) {
        try {
            const [affectedRows, updatedHolidays] = await Holiday.update(
                { name, date, color }, {
                where: { id }, returning: true, plain: true,
            });

            if (affectedRows === 0) { throw new Error("Holiday not found or no changes made") }

            return updatedHolidays;
        } catch (error) {
            throw new Error(error.message);
        }
    }

    async delete(id) {
        try {
            const affectedRows = await Holiday.destroy({ where: { id } });

            if (affectedRows === 0) { throw new Error("Holiday not found") }

            return "Holiday deleted successfully";
        } catch (error) {
            throw new Error(error.message);
        }
    }

    async getIntervalDate(startDate, endDate) {
        try {
            const holidays = await Holiday.findAll({
                where: {
                    date: {
                        [Op.gte]: startDate,
                        [Op.lte]: endDate,
                    }
                }
            });

            return holidays.length > 0 ? holidays : [];
        } catch (error) {
            throw new Error(error.message);
        }
    }
}

module.exports = new HolidayService();