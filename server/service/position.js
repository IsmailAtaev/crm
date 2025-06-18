const { Position } = require('../models/model')

class PositionService {
    async createPosition(name) {
        const position = await Position.create({ name })

        if (!position) throw new Error("Do not create department")

        return true
    }

    async getPositions() {
        const positions = await Position.findAll({ order: [['name', 'ASC']] })
        return positions
    }

    async updatePosition(id, name) {
        const updata = await Position.update({ name }, { where: { id } })

        if (!updata) throw new Error("Do not updata department name")

        return updata
    }

    async removePosition(id) {
        const result = await Position.destroy({ where: { id } })

        if (result === 0) throw new Error("Department not found or already deleted")

        return result;
    }

    async getItemPosition(id) {
        const result = await Position.findOne({ where: { id } });

        if (!result) throw new Error("Department not found");

        return result
    }
}

module.exports = new PositionService();