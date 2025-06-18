const { Sequelize } = require("sequelize")
//const { DB_NAME, DB_USER, DB_PASSWORD, DB_HOST, DB_PORT } = require("./config")

module.exports = new Sequelize('personnelrecordsdb', 'postgres', '123456789', {
    dialect: 'postgres',
    host: 'localhost',
    port: 5432
})
