const moment = require('moment')
const ApiError = require("../error/ApiError")
const { EmployeeRegistrationTime, Task, User, PdfDocument, Project, ProjectBetweenTask } = require("../models/model")
const { Op } = require('sequelize')
const { currentDate, formatDateTime, sumWorkingHours } = require("../helpers/helpers")
const HelpersWorkTime = require('../helpers/helpersWorkTime')
const { calculateTimeDifference } = require("../helpers/helpers")
const { getItemUser } = require('../service/userService')


class ComeLeaveWork {

    async comeWork(req, res) {
        try {
            const { userId, comeStatus } = req.body;
            if (!userId || !comeStatus) {
                return res.status(400).json({ status: "400", messagge: "Do not save date time" });
            }

            const dateNow = currentDate()
            const resultDB = await EmployeeRegistrationTime.create({ comeTime: dateNow, userId })
            if (!resultDB) {
                return res.status(500).json({ status: "500", messagge: "Do not save come time work" });
            }

            return res.status(200).json({ status: "200", messagge: "Saved come time work", date: dateNow });
        } catch (e) {
            return res.status(500).json({ status: "400", messagge: "Do not save come time work" });
        }
    }

    async leaveWork(req, res) {
        try {
            const { userId, leaveStatus } = req.body;
            if (!userId || !leaveStatus) {
                return res.status(400).json({ status: "400", messagge: "Do not save date time" });
            }

            const starDay = moment().clone().startOf("day").format("YYYY-MM-DD HH:mm:ssZ");
            const myDate = moment(starDay, "YYYY-MM-DD HH:mm:ssZ").toDate();
            const dateNow = currentDate()

            const [updateDB, affectedRows] = await EmployeeRegistrationTime.update(
                { leaveTime: dateNow },
                {
                    where: {
                        userId,
                        leaveTime: null,
                        comeTime: { [Op.gt]: myDate }
                    },
                    returning: true // Получаем обновленные строки
                }
            )

            if (updateDB > 0) {
                const updatedRecord = affectedRows[0].get({ plain: true });
                const { comeTime, leaveTime } = updatedRecord;

                const workingHours = calculateTimeDifference(comeTime, leaveTime)
                await EmployeeRegistrationTime.update({ workingHours }, { where: { id: updatedRecord.id } });

                return res.status(200).json({ status: "200", messagge: "Запись обновлена ", date: dateNow });
            } else {
                return res.status(400).json({ status: "400", messagge: "Запись не найдена или не обновлена" });
            }
        } catch (e) {
            return res.status(500).json({ status: "400", messagge: e.messagge });
        }
    }



    async getMonthWorkTimeEmploye(req, res) {
        function generateDays(startDate, endDate) {
            const daysArray = [];
            let currentDate = moment(startDate);
            while (currentDate <= moment(endDate)) {
                if (currentDate.day() !== 0) {
                    daysArray.push(currentDate.format('YYYY-MM-DD'));
                }
                currentDate.add(1, 'day');
            }
            return daysArray;
        }

        try {
            const { userId, date } = req.query
            if (!userId || !date) {
                return res.status(400).json({ error: "Missing user ID or date" });
            }

            const startDay = moment(date, 'YYYY-MM').startOf('month').format("YYYY-MM-DD HH:mm:ssZ");
            const endDay = moment(date, 'YYYY-MM').endOf('month').format("YYYY-MM-DD HH:mm:ssZ");


            // const startDay = moment(date, 'YYYY-MM').clone().startOf('month').startOf('day').format("YYYY-MM-DD HH:mm:ssZ");
            // const endDay = moment(date, 'YYYY-MM').clone().endOf('month').endOf('day').format("YYYY-MM-DD HH:mm:ssZ");

            const plainEmployeerTime = await EmployeeRegistrationTime.findAll({
                where: {
                    userId,
                    comeTime: { [Op.gte]: startDay, [Op.lte]: endDay },
                    [Op.or]: [{ leaveTime: { [Op.lte]: endDay } }, { leaveTime: { [Op.eq]: null } }]
                }
            })

	    let employeerTime = plainEmployeerTime
           // const employeerTime = plainEmployeerTime.map(entry => entry.get({ plain: true }));

            const allDays = generateDays(startDay, endDay);

            const existingDays = employeerTime.map(item => moment(item.comeTime).format('YYYY-MM-DD'));
            const missingDays = allDays.filter(day => !existingDays.includes(day)); // возвращаются только те дни, когда сотрудник не приходил на работу.


	    const workingHours = sumWorkingHours(plainEmployeerTime) 


            missingDays.forEach(day => {
                employeerTime.push({
                    id: null,
                    comeTime: moment(day).format("YYYY-MM-DD HH:mm:ss"),
                    leaveTime: null,
		    workingHours: null,
                    flag: false,
                    note: null,
                    color: null,
                    userId
                });
            });

            employeerTime.sort((a, b) => new Date(a.comeTime) - new Date(b.comeTime));


           
            const projects = await Project.findAll({
                include: [{
                    model: Task,
                    as: 'tasks',
                    where: { userId: userId },
                }],
                order: [['createdAt', 'ASC'], [{ model: Task, as: 'tasks' }, 'createdAt', 'ASC']]
            });

            const documents = await PdfDocument.findAll({ where: { userId, deleted: false }, order: [['createdAt', 'ASC']] });
            const user = await getItemUser(userId);


	    return res.status(200).json({
                user,
                employeerTime,
                workingHours,
                projects,
                documents
            })

        } catch (e) {
            return res.status(500).json({ msg: e.messagge })
        }
    }




    async getUserIdTimeForDay(req, res) {
        try {
            const { userId, date } = req.query;
            const startOfDay = moment(date).startOf('day').format("YYYY-MM-DD 00:00:00+03");
            const endOfDay = moment(date).endOf('day').format("YYYY-MM-DD 23:59:59+03");

            const employeerTime = await EmployeeRegistrationTime.findAll({
                raw: true,
                where: {
                    userId,
                    comeTime: { [Op.gte]: startOfDay, [Op.lte]: endOfDay }
                },
                order: [["comeTime", "ASC"]]

            });

            if (!employeerTime || employeerTime.length === 0) {
                return res.status(200).json([]);
            }

            return res.status(200).json(employeerTime);
        } catch (error) {
            return res.status(500).json({ status: "500", message: error.message });
        }
    }

    async updateNoteById(req, res) {
        try {
            const { id, note, color } = req.body;
            if (!id || note === undefined || !color) {
                return res.status(400).json({ message: "ID and note must be provided" });
            }

            const [updatedRows] = await EmployeeRegistrationTime.update({ note, color }, { where: { id } });
            if (updatedRows === 0) {
                return res.status(404).json({ message: "No record found with the specified ID" });
            }

            const updatedRecord = await EmployeeRegistrationTime.findOne({ where: { id } });
            if (!updatedRecord) {
                return res.status(404).json({ message: "No record found with the specified ID" });
            }

            return res.status(200).json({
                message: " Note updated successfully ",
                data: updatedRecord
            });
        } catch (error) {
            return res.status(500).json({ status: "500", message: error.message });
        }
    }

    async createOrUpdateNoteByAdmin(req, res) {
        try {
            const { userId, date, note, editorUserId, color } = req.body;
            if (!userId || !date || note === undefined || !editorUserId || !color) {
                return res.status(400).json({ message: "User ID, date, note, and editor ID must be provided" });
            }

            const editor = await User.findOne({ where: { id: editorUserId } });
            if (!editor) {
                return res.status(404).json({ message: "Editor user not found" });
            }

            const role = editor.role;
            if (role !== "ADMIN") {
                return res.status(403).json({ message: "Access denied. Only admins can add notes." });
            }

            const OfDay = new Date(date);
            OfDay.setHours(12, 0, 0, 0);

            await EmployeeRegistrationTime.create({
                userId,
                comeTime: OfDay,
                leaveTime: OfDay,
                workingHours: "00:00:00",
                note,
                color,
                flag: false
            });
            return res.status(200).json({ message: "successfully" + OfDay });
        } catch (error) {
            return res.status(500).json({ status: "500", message: error.message });
        }
    }

    async workedUserButNotComeOffice(req, res) {
        try {
            const { userId, date, note, color } = req.body;
            if (!userId || !date || !note || !color) {
                return res.status(400).json({ message: "User ID, date, note, and editor ID must be provided" });
            }

            const OfDay = new Date(date);
            OfDay.setUTCHours(0, 0, 0, 0); // updata 
            // OfDay.setHours(0, 0, 0, 0);

            await EmployeeRegistrationTime.create({
                userId,
                comeTime: OfDay,
                leaveTime: OfDay,
                workingHours: "00:00:00",
                note,
                color,
                flag: true
            });
            return res.status(200).json("successfully");
        } catch (error) {
            return res.status(500).json({ status: "500", message: error.message });
        }
    }

    async getUserAllInfo(req, res) {
        // // function generateDays(startDate, endDate) {
        // //     const daysArray = [];
        // //     let currentDate = moment(startDate);
        // //     while (currentDate <= moment(endDate)) {
        // //         if (currentDate.day() !== 0) {
        // //             daysArray.push(currentDate.format('YYYY-MM-DD'));
        // //         }
        // //         currentDate.add(1, 'day');
        // //     }
        // //     return daysArray;
        // // }
        // // try {
        // //     const { userId, finderUserId, date } = req.query;
        // //     const startDay = moment(date, 'YYYY-MM').startOf('month').format("YYYY-MM-DD HH:mm:ssZ");
        // //     const endDay = moment(date, 'YYYY-MM').endOf('month').format("YYYY-MM-DD HH:mm:ssZ");
        // //     console.log(startDay, endDay)


        // //     const userInfo = await User.findOne({
        // //         where: { id: userId },
        // //         include: [
        // //             {
        // //                 model: PdfDocument,
        // //                 as: 'pdfDocuments',
        // //                 required: false,
        // //             },
        // //             {
        // //                 model: EmployeeRegistrationTime,
        // //                 as: 'employeeRegistrationTimes',
        // //                 where: {
        // //                     comeTime: {
        // //                         [Op.gte]: startDay,
        // //                         [Op.lte]: endDay
        // //                     },
        // //                     [Op.or]: [{
        // //                         leaveTime: { [Op.lte]: endDay }
        // //                     }, {
        // //                         leaveTime: { [Op.eq]: null }
        // //                     }]
        // //                 },
        // //                 required: false,
        // //             },
        // //         ],
        // //     })

        // //     if (!userInfo) {
        // //         return res.status(404).json({ message: "User not found" });
        // //     }

        // //     const allDays = generateDays(startDay, endDay);
        // //     const existingDays = userInfo.employeeRegistrationTimes.map(item => moment(item.comeTime).format('YYYY-MM-DD'));

        // //     // Пропущенные дни
        // //     const missingDays = allDays.filter(day => !existingDays.includes(day));
        // //     let employeerTime = userInfo.employeeRegistrationTimes.map(item => item.toJSON());

        // //     // Добавляем отсутствующие дни
        // //     missingDays.forEach(day => {
        // //         employeerTime.push({
        // //             id: null,
        // //             comeTime: moment(day).format("YYYY-MM-DD HH:mm:ss"),
        // //             leaveTime: null,
        // //             flag: false,
        // //             note: null,
        // //             userId
        // //         });
        // //     });

        // //     // Сортировка по времени прихода
        // //     employeerTime.sort((a, b) => new Date(a.comeTime) - new Date(b.comeTime));

        // //     return res.status(200).json({
        // //         userInfo: {
        // //             ...userInfo.toJSON(),
        // //             employeeRegistrationTimes: employeerTime
        // //         }
        // //     });
        // // } catch (error) {
        // //     return res.status(500).json({ status: "500", message: error.message });
        // // }


        // function generateDays(startDate, endDate) {
        //     const daysArray = [];
        //     let currentDate = moment(startDate);
        //     while (currentDate <= moment(endDate)) {
        //         if (currentDate.day() !== 0) { // Пропускаем воскресенья
        //             daysArray.push(currentDate.format('YYYY-MM-DD')); // Форматируем только дату
        //         }
        //         currentDate.add(1, 'day');
        //     }
        //     return daysArray;
        // }

        // try {
        //     const { userId, date } = req.query;

        //     if (!userId || !date) {
        //         return res.status(400).json({ message: "User ID and date are required" });
        //     }

        //     const startDay = moment(date, 'YYYY-MM').startOf('month').format("YYYY-MM-DD");
        //     const endDay = moment(date, 'YYYY-MM').endOf('month').format("YYYY-MM-DD");

        //     const userInfo = await User.findOne({
        //         where: { id: userId },
        //         include: [
        //             {
        //                 model: PdfDocument,
        //                 as: 'pdfDocuments',
        //                 required: false,
        //             },
        //             {
        //                 model: EmployeeRegistrationTime,
        //                 as: 'employeeRegistrationTimes',
        //                 where: {
        //                     comeTime: {
        //                         [Op.gte]: startDay,
        //                         [Op.lte]: endDay
        //                     }
        //                 },
        //                 required: false,
        //             },
        //         ],
        //     });

        //     if (!userInfo) {
        //         return res.status(404).json({ message: "User not found" });
        //     }

        //     userInfo.employeeRegistrationTimes.sort((a, b) => new Date(a.comeTime) - new Date(b.comeTime));
        //     const allDays = generateDays(startDay, endDay);
        //     const existingDays = userInfo.employeeRegistrationTimes.map(item => moment(item.comeTime).format('YYYY-MM-DD'));

        //     // Пропущенные дни (дни, для которых нет записей)
        //     const missingDays = allDays.filter(day => !existingDays.includes(day));
        //     let employeerTime = userInfo.employeeRegistrationTimes.map(item => item.toJSON());

        //     console.log("userInfo.employeeRegistrationTimes ", employeerTime)
        //     console.log("allDays ", allDays)
        //     console.log("existingDays ", existingDays)
        //     console.log("missingDays ", missingDays)
        //     console.log("employeerTime ", employeerTime)


        //     // Проверка на дублирование записей и добавление отсутствующих дней
        //     missingDays.forEach(day => {
        //         const existingRecordsForDay = userInfo.employeeRegistrationTimes.some(record =>
        //             moment(record.comeTime).format('YYYY-MM-DD') === day
        //         );
        //         console.log("existingRecordsForDay ", existingRecordsForDay)

        //         if (!existingRecordsForDay) {
        //             employeerTime.push({
        //                 id: null,
        //                 comeTime: moment(day).startOf('day').format("YYYY-MM-DD HH:mm:ss"), // Начало дня
        //                 leaveTime: null,
        //                 flag: false,
        //                 note: null,
        //                 userId
        //             });
        //         }
        //     });

        //     // Сортировка по времени прихода
        //     employeerTime.sort((a, b) => new Date(a.comeTime) - new Date(b.comeTime));

        //     return res.status(200).json({
        //         userInfo: {
        //             // ...userInfo.toJSON(),
        //             employeeRegistrationTimes: employeerTime,

        //         },
        //         //ee: userInfo.employeeRegistrationTimes
        //     });




        // } catch (error) {
        //     return res.status(500).json({ status: "500", message: error.message });
        // }



        const generateDays = (startDate, endDate) => {
            const daysArray = [];
            let currentDate = moment(startDate);
            while (currentDate <= moment(endDate)) {
                if (currentDate.day() !== 0) { // Пропускаем воскресенья
                    daysArray.push(currentDate.format('YYYY-MM-DD')); // Форматируем только дату
                }
                currentDate.add(1, 'day');
            }
            return daysArray;
        };

        try {
            const { userId, date } = req.query;

            if (!userId || !date) {
                return res.status(400).json({ message: "User ID and date are required" });
            }

            const startDay = moment(date, 'YYYY-MM').startOf('month').format("YYYY-MM-DD");
            const endDay = moment(date, 'YYYY-MM').endOf('month').format("YYYY-MM-DD");

            const userInfo = await User.findOne({
                where: { id: userId },
                include: [
                    {
                        model: PdfDocument,
                        as: 'pdfDocuments',
                        required: false,
                    },
                    {
                        model: EmployeeRegistrationTime,
                        as: 'employeeRegistrationTimes',
                        where: {
                            comeTime: {
                                [Op.gte]: startDay,
                                [Op.lte]: endDay
                            }
                        },
                        required: false,
                    },
                ],
            });

            if (!userInfo) {
                return res.status(404).json({ message: "User not found" });
            }

            // Сортировка записей
            userInfo.employeeRegistrationTimes.sort((a, b) => new Date(a.comeTime) - new Date(b.comeTime));

            // Создаем массив всех дней
            const allDays = generateDays(startDay, endDay);

            allDays.map((e) => console.log(e))

            // Массив пропущенных дней
            const missingDays = [];

            // Преобразуем записи во временные метки формата 'YYYY-MM-DD'
            const recordedDays = new Set(userInfo.employeeRegistrationTimes.map(item => moment(item.comeTime).format('YYYY-MM-DD')));
            console.log("-----------------------------------------------------")
            console.log("----------------------------------------------------- recordedDays ", recordedDays)



            allDays.forEach(day => {
                if (!recordedDays.has(day)) {
                    missingDays.push(day);
                }
            });

            console.log("----------------------------------------------------- missingDays ", missingDays)


            // Массив для записи времени прихода и ухода
            const employeerTime = userInfo.employeeRegistrationTimes.map(item => item.toJSON());


            // Сортировка массива по времени прихода
            employeerTime.sort((a, b) => new Date(a.comeTime) - new Date(b.comeTime));

            console.log("----------------------------------------------------- employeerTime ", employeerTime)

            return res.status(200).json({
                userInfo: {
                    employeeRegistrationTimes: employeerTime,
                    missingDays
                }
            });



        } catch (error) {
            console.error(error);
            return res.status(500).json({ message: "Server error" });
        }


    }


    async removeNote(req, res) {
        try {
            const { id, userId } = req.query;
            if (!id || !userId) {
                return res.status(400).json({ msg: "Request query error" });
            }

            const [updatedRows] = await EmployeeRegistrationTime.update({ note: null, color: null }, { where: { id, userId } });
            if (updatedRows === 0) {
                return res.status(404).json({ msg: "Do not find note id or user id for remove note" });
            }
            return res.status(200).json({ msg: "Successfully" });
        } catch (error) {
            return res.status(500).json({ msg: error.message });
        }
    }




    async updateLeaveTime(req, res) {
        try {
            const { id, leaveTime, userId } = req.body
            //const dateTimeWithSeconds = leaveTime + ":00";
            //const parsedDate = new Date(dateTimeWithSeconds);


            const parsedDate = formatDateTime(leaveTime) //moment.tz(leaveTime, "YYYY-MM-DD HH:mm", "UTC").local().toDate();
            console.log(formatDateTime(leaveTime));
            console.log(typeof formatDateTime(leaveTime));
            const yesterdayLeftTime = await EmployeeRegistrationTime.update(
                { leaveTime: parsedDate }, { where: { id, userId } }
            )
            console.log(yesterdayLeftTime)

            if (!yesterdayLeftTime) {
                throw ApiError.BadRequest("error database not added");
            }


            return res.json(true)
        } catch (exception) {
            return res.json("Error update left work time")
        }
    }


    async getUserIdTime(req, res) {
        try {
            const userId = req.params.id;
            const startDay = moment().clone().startOf('month').startOf('day').format("YYYY-MM-DD HH:mm:ssZ");
            const endDay = moment().clone().endOf('month').endOf('day').format("YYYY-MM-DD HH:mm:ssZ");

            const employeerTime = await EmployeeRegistrationTime.findAll({
                raw: true,
                where: {
                    userId,
                    comeTime: { [Op.gte]: startDay },
                    [Op.or]: [{ leaveTime: { [Op.lte]: endDay } }, { leaveTime: { [Op.eq]: null } }]
                },
                include: {
                    model: Task,
                    as: "task",
                    required: false
                }
            });

            if (!employeerTime) {
                throw ApiError.BadRequest("error database not added");
            }

            return res.json(employeerTime);
        } catch (e) {
            return res.status(500).json({ status: "500", messagge: e.messagge });
        }
    }







}

module.exports = new ComeLeaveWork();


/*
    //const startOfMonth = moment(date, 'YYYY-MM').startOf('month')
            //const endOfMonth = moment(date, 'YYYY-MM').endOf('month')

            //const workDays = HelpersWorkTime.getBusinessDays(startOfMonth, endOfMonth)
            //const workDaysSaturday = HelpersWorkTime.getNotBusinessDays(startOfMonth, endOfMonth)


  // const workingTimeMonth = employeerTime.filter(g => g.leaveTime !== null)
            // const noWorkDays = employeerTime.filter(g => g.leaveTime === null)
            // const timeWorkMonth = workingTimeMonth.map(elem => Math.floor(
            //     moment.duration(moment(elem.leaveTime).diff(moment(elem.comeTime))).asHours())
            //     + " : " +
            //     moment.duration(moment(elem.leaveTime).diff(moment(elem.comeTime))).minutes()
            //     + " : " +
            //     moment.duration(moment(elem.leaveTime).diff(moment(elem.comeTime))).seconds()
            // )
            // const sumWorkTime = await HelpersWorkTime.getSumWorkTime(timeWorkMonth)
            // async function sumWorkTimeByDay(data) {
            //     const filteredData = data.filter(item => item.leaveTime !== null);
            //     const groupedData = filteredData.reduce((acc, item) => {
            //         const date = moment(item.comeTime).format('DD-MM-YYYY');
            //         if (!acc[date]) {
            //             acc[date] = [];
            //         }
            //         acc[date].push(item);
            //         return acc;
            //     }, {});
            //     const result = await Promise.all(Object.keys(groupedData).map(async date => {
            //         const workTimes = groupedData[date].map(item => {
            //             const comeTime = moment(item.comeTime);
            //             const leaveTime = moment(item.leaveTime);
            //             const duration = moment.duration(leaveTime.diff(comeTime));
            //             const hours = Math.floor(duration.asHours());
            //             const minutes = duration.minutes();
            //             const seconds = duration.seconds();
            //             return `${String(hours).padStart(2, '0')}:${String(minutes).padStart(2, '0')}:${String(seconds).padStart(2, '0')}`;
            //         });
            //         const totalWorkTime = await HelpersWorkTime.getSumWorkTime(workTimes);
            //         return {
            //             date,
            //             totalWorkTime
            //         };
            //     }));
            //     return result;
            // }
            // const temp = await sumWorkTimeByDay(employeerTime);
            // console.log("plainEmployeerTime ", employeerTime, temp)
            // return res.json({ workingDaysMonth: temp, employeerTimeWork: sumWorkTime, employeerTime })

*/
