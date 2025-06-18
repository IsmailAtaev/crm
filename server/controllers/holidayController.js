const HolidayService = require("../service/holidayService")


class HolidayController {

    async add(req, res) {
        try {
            const { name, date, color } = req.body;
            if (!name || !date || !color) { return res.status(400).json({ message: "Missing required fields" }) }
            const result = await HolidayService.add(name, date, color);
            return res.status(200).json({ message: "Successfully added", data: result });
        } catch (e) {
            return res.status(500).json({ message: e.message, data: [] });
        }
    }

    async get(req, res) {
        try {
            const result = await HolidayService.get();
            return res.status(200).json({ message: "Successfully gated", data: result });
        } catch (e) {
            return res.status(500).json({ message: e.message, data: [] });
        }
    }

    async update(req, res) {
        try {
            const { id, name, date, color } = req.body;
            if (!id || !name || !date || !color) { return res.status(400).json({ message: "Missing required fields" }) }
            const result = await HolidayService.update(id, name, date, color);
            return res.status(200).json({ message: "Successfully update", data: result });
        } catch (e) {
            return res.status(500).json({ message: e.message, data: [] });
        }
    }

    async delete(req, res) {
        try {
            const { id } = req.query;
            if (!id) { return res.status(400).json({ message: "Missing required fields" }) }
            const result = await HolidayService.delete(id);
            return res.status(200).json({ message: "Successfully deleted", data: result });
        } catch (e) {
            return res.status(500).json({ message: e.message, data: [] });
        }
    }

    async getIntervalDate(req, res) {
        try {
            const { startDate, endDate } = req.query;
            const result = await HolidayService.getIntervalDate(startDate, endDate);
            return res.status(200).json({ message: "Successfully", data: result });
        } catch (e) {
            return res.status(500).json({ message: e.message, data: [] });
        }
    }



}

module.exports = new HolidayController();
