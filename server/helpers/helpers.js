const HelpersWorkTime = require("../helpers/helpersWorkTime")

const currentDate = () => {
    const currentDate = new Date();
    const year = String(currentDate.getFullYear());
    const month = String(currentDate.getMonth() + 1).padStart(2, '0'); // month started with 0
    const day = String(currentDate.getDate()).padStart(2, '0');
    const hours = String(currentDate.getHours()).padStart(2, '0');
    const minutes = String(currentDate.getMinutes()).padStart(2, '0');
    const seconds = String(currentDate.getSeconds()).padStart(2, '0');
    return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
}

function calculateTimeDifference(startTime, endTime) {
    const timeDifference = new Date(endTime) - new Date(startTime);
    const hours = Math.floor(timeDifference / (1000 * 60 * 60)); // Получаем часы
    const minutes = Math.floor((timeDifference % (1000 * 60 * 60)) / (1000 * 60)); // Получаем минуты
    const seconds = Math.floor((timeDifference % (1000 * 60)) / 1000); // Получаем секунды
    return `${hours}:${minutes}:${seconds}`;
}

async function sumWorkTimeByDay(data) {
    const filteredData = data.filter(item => item.leaveTime !== null);

    const groupedData = filteredData.reduce((acc, item) => {
        const date = moment(item.comeTime).format('DD-MM-YYYY');
        if (!acc[date]) {
            acc[date] = [];
        }
        acc[date].push(item);
        return acc;
    }, {});

    const result = await Promise.all(Object.keys(groupedData).map(async date => {
        const workTimes = groupedData[date].map(item => {
            const comeTime = moment(item.comeTime);
            const leaveTime = moment(item.leaveTime);
            const duration = moment.duration(leaveTime.diff(comeTime));
            const hours = Math.floor(duration.asHours());
            const minutes = duration.minutes();
            const seconds = duration.seconds();
            return `${String(hours).padStart(2, '0')}:${String(minutes).padStart(2, '0')}:${String(seconds).padStart(2, '0')}`;
        });

        const totalWorkTime = await HelpersWorkTime.getSumWorkTime(workTimes);
        return {
            date,
            totalWorkTime
        };
    }));

    return result;
}

function formatDateTime(dateString) {
    const [year, month, day, hours, minutes] = dateString.split(/[\s:-]+/);
    const myDate = new Date(year, month - 1, day, hours, minutes);
    return myDate;

    // const [year, month, day, hours, minutes] = dateString.split(/[\s:-]+/);
    // const myDate = new Date(Date.UTC(year, month - 1, day, hours, minutes)); // Use Date.UTC to ensure no timezone offset
    // return myDate;
}

function isNumber(value) {
    return !isNaN(value);
};

function isEmptyMy(value) {
    return value === undefined || value === null || value.trim() === '';
};

const sumWorkingHours = (data) => {
    let totalSeconds = 0;

    data.forEach((item) => {
        if (item.workingHours) {
            const [hours, minutes, seconds] = item.workingHours.split(":").map(Number);
            totalSeconds += hours * 3600 + minutes * 60 + seconds;
        }
    });

    const hours = Math.floor(totalSeconds / 3600);
    const minutes = Math.floor((totalSeconds % 3600) / 60);
    const seconds = totalSeconds % 60;

    return `${hours}:${minutes.toString().padStart(2, "0")}:${seconds.toString().padStart(2, "0")}`;
};

module.exports = { currentDate, sumWorkTimeByDay, formatDateTime, isNumber, isEmptyMy, calculateTimeDifference, sumWorkingHours };