const express = require("express");
const cors = require("cors");
const cookieParser = require("cookie-parser");
const chatServer = require('./chat/chatServer');
const bodyParser = require("body-parser");
const sequelize = require("./database");
const router = require("./routes/index");
const path = require('path');

const PORT = 5022;

const app = express();
const http = require('http');
const server = http.createServer(app);

chatServer(server);

app.use(express.json({ limit: '50mb' }));
app.use(express.urlencoded({ limit: '50mb', extended: true }));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(express.json());
app.use(cookieParser());

app.use(cors({ credentials: true, origin: "*" }));

app.use("/files", express.static("files"));
app.use("/images", express.static("public/images"));
app.use(express.static("public"))

app.use("/api", router);


const main = async () => {
    try {
        const a = await sequelize.authenticate();
        // const b = await sequelize.sync({ alter: true });

        server.listen(PORT, () => console.log("Server started on port: " + PORT));
    } catch (e) { console.error("Error " + e) }
}

main();