const PositionService = require('../service/position')



class PositionController {

    async addPosition(req, res) {
        try {
            const { name } = req.body
            if (!name) {
                return res.status(500).json({ message: 'Request error position name' })
            }
            await PositionService.createPosition(name)
            return res.status(200).json({ message: "OK" })
        } catch (e) {
            return res.status(500).json({ message: e.message })
        }
    }

    async getPositions(req, res) {
        try {
            const result = await PositionService.getPositions()
            return res.status(200).json(result)
        } catch (e) {
            return res.status(500).json({ message: e.message })
        }
    }

    async updatePosition(req, res) {
        try {
            const { id, name } = req.body
            if (!id || !name) {
                return res.status(500).json({ message: 'Request error department name or department id' })
            }
            await PositionService.updatePosition(id, name)
            return res.status(200).json({ message: "OK" })
        } catch (e) {
            return res.status(500).json({ message: e.message })
        }
    }

    async removePosition(req, res) {
        try {
            const id = req.params.id
            if (!id) {
                return res.status(500).json({ message: 'Request error Department id' })
            }
            await PositionService.removePosition(id)
            return res.status(200).json({ message: 'Successfully' })
        } catch (e) {
            return res.status(500).json({ message: e.message })
        }
    }

    async getItemPosition(req, res) {
        try {
            const id = req.params.id
            if (!id) {
                return res.status(500).json({ message: 'Request error Department id' })
            }
            const department = await PositionService.getItemPosition(id)
            return res.status(200).json(department)
        } catch (e) {
            return res.status(500).json({ message: e.message })
        }
    }
}


module.exports = new PositionController()