const sequelize = require("../database");
const { DataTypes } = require("sequelize");

const StartEndWorkTime = sequelize.define('startEndWorkTime', {
    id: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4, primaryKey: true },
    userId: { type: DataTypes.INTEGER, allowNull: false, },
    startTime: { type: DataTypes.TIME, allowNull: false, defaultValue: "09:00" },
    endTime: { type: DataTypes.TIME, allowNull: false, defaultValue: "18:00" }
}, { timestamps: false });

const Position = sequelize.define('position', {
    id: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4, primaryKey: true },
    name: { type: DataTypes.STRING, allowNull: false, unique: true },
})

const User = sequelize.define('user', {
    id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    surname: { type: DataTypes.STRING },
    name: { type: DataTypes.STRING },
    birthday: { type: DataTypes.DATEONLY },
    phoneNumber: { type: DataTypes.STRING },
    mail: { type: DataTypes.STRING },
    whereStudy: { type: DataTypes.STRING },
    whereLive: { type: DataTypes.STRING },
    languages: { type: DataTypes.STRING },
    img: { type: DataTypes.STRING },
    role: { type: DataTypes.STRING, allowNull: false, defaultValue: "USER" },
    status: { type: DataTypes.BOOLEAN, allowNull: false, defaultValue: true },
    login: { type: DataTypes.STRING, unique: true },
    pass: { type: DataTypes.STRING, unique: true },
    positionId: { type: DataTypes.UUID, },
    doorId: { type: DataTypes.STRING },
})

const DocumtType = sequelize.define('DocumtType', {
    id: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4, primaryKey: true },
    name: { type: DataTypes.STRING, unique: true, allowNull: false },
})

const PdfDocument = sequelize.define('pdfDocument', {
    id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    title: { type: DataTypes.STRING },
    pathPdf: { type: DataTypes.STRING },
    deleted: { type: DataTypes.BOOLEAN, defaultValue: false },
    userId: { type: DataTypes.INTEGER, allowNull: false },
    documentTypeId: { type: DataTypes.UUID, allowNull: false }
})

const EmployeeRegistrationTime = sequelize.define('EmployeeRegistrationTime', {
    id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    comeTime: { type: DataTypes.DATE, allowNull: false },
    leaveTime: { type: DataTypes.DATE, },
    workingHours: { type: DataTypes.STRING, },
    flag: { type: DataTypes.BOOLEAN, defaultValue: true },
    note: { type: DataTypes.STRING },
    color: { type: DataTypes.STRING },
}, {
    tableName: 'EmployeeRegistrationTime',
    timestamps: false, // Disable timestamps if needed
    tableOptions: { timezone: false } // Disable timezone conversion for this table
})

const Warning = sequelize.define('warning', {
    id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    title: { type: DataTypes.STRING, allowNull: false },
    date: { type: DataTypes.DATE, allowNull: false, defaultValue: DataTypes.NOW },
    color: { type: DataTypes.STRING, allowNull: false },
});

const ShareWarning = sequelize.define('shareWarning', {
    id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    warningId: { type: DataTypes.INTEGER, allowNull: false },
    userId: { type: DataTypes.INTEGER, allowNull: false },
});

const Note = sequelize.define('note', {
    id: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4, primaryKey: true },
    userId: { type: DataTypes.INTEGER, allowNull: false },
    authorType: { type: DataTypes.STRING, allowNull: false },
    authorId: { type: DataTypes.INTEGER, allowNull: false },
    content: { type: DataTypes.TEXT, allowNull: false },
    projectId: { type: DataTypes.STRING },
})

const Project = sequelize.define('project', {
    id: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4, primaryKey: true },
    name: { type: DataTypes.STRING, allowNull: false },
    status: { type: DataTypes.STRING, allowNull: false, defaultValue: "Paused" },
    priority: { type: DataTypes.STRING, allowNull: false, defaultValue: "High" },
    startDate: { type: DataTypes.DATEONLY, allowNull: false, defaultValue: DataTypes.NOW },
    endDate: { type: DataTypes.DATEONLY, allowNull: false, defaultValue: DataTypes.NOW },
    completion: { type: DataTypes.FLOAT, allowNull: false, defaultValue: 0 },
    archived: { type: DataTypes.BOOLEAN, allowNull: false, defaultValue: false }
})

const Task = sequelize.define('task', {
    id: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4, primaryKey: true },
    userId: { type: DataTypes.INTEGER, allowNull: false },
    projectId: { type: DataTypes.UUID, allowNull: false },
    name: { type: DataTypes.STRING, allowNull: false },
    status: { type: DataTypes.STRING, allowNull: false, defaultValue: "Paused" },
    priority: { type: DataTypes.STRING, allowNull: false, defaultValue: "High" },
    startDate: { type: DataTypes.DATEONLY, allowNull: false, defaultValue: DataTypes.NOW },
    endDate: { type: DataTypes.DATEONLY, allowNull: false, defaultValue: DataTypes.NOW },
    completionProject: { type: DataTypes.FLOAT, allowNull: false, defaultValue: 0 },
    completionTask: { type: DataTypes.FLOAT, allowNull: false, defaultValue: 0 },
})

const SubTask = sequelize.define("subTask", {
    id: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4, primaryKey: true },
    userId: { type: DataTypes.INTEGER, allowNull: false },
    taskId: { type: DataTypes.UUID, allowNull: false },
    text: { type: DataTypes.STRING, allowNull: false },
    isCompleted: { type: DataTypes.BOOLEAN, allowNull: false, defaultValue: false }
})

// Teswir duzgunnama | labor protection
const LaborProtection = sequelize.define('LaborProtection', {
    id: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4, primaryKey: true },
    title: { type: DataTypes.STRING, allowNull: false },
    description: { type: DataTypes.TEXT, allowNull: false },
})

const Holiday = sequelize.define('holiday', {
    id: { type: DataTypes.UUID, primaryKey: true, defaultValue: DataTypes.UUIDV4, },
    name: { type: DataTypes.STRING, allowNull: false },
    date: { type: DataTypes.DATEONLY, allowNull: false, defaultValue: DataTypes.NOW },
    color: { type: DataTypes.STRING, allowNull: false, defaultValue: "#9fc2a4" },
})

// Rugsat alan gunleri
const Absence = sequelize.define('Absence', {
    id: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4, primaryKey: true },
    userId: { type: DataTypes.INTEGER, allowNull: false, },
    startDate: { type: DataTypes.DATEONLY, allowNull: false, },
    endDate: { type: DataTypes.DATEONLY, allowNull: false, },
    reason: { type: DataTypes.STRING, allowNull: false, defaultValue: 'Işe gelmedi', },
    daysOff: { type: DataTypes.SMALLINT, allowNull: false, defaultValue: 0, },
    color: { type: DataTypes.STRING(15), allowNull: false, defaultValue: "#ffffff", },
}, {
    hooks: {
        beforeSave: (absence, options) => {
            const startDate = new Date(absence.startDate);
            const endDate = new Date(absence.endDate);
            const startDay = startDate.toISOString().split('T')[0];
            const endDay = endDate.toISOString().split('T')[0];
            const diffTime = Math.abs(new Date(endDay) - new Date(startDay));
            absence.daysOff = Math.ceil(diffTime / (1000 * 3600 * 24)); // + 1; // Count days
        },
    },
});

/** Chat Socket IO */
const Chat = sequelize.define('chat', {
    id: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4, primaryKey: true },
    participantOne: { type: DataTypes.INTEGER, allowNull: false },
    participantTwo: { type: DataTypes.INTEGER, allowNull: false },
})
const Message = sequelize.define('messagge', {
    id: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4, primaryKey: true },
    text: { type: DataTypes.STRING, allowNull: false },
    read: { type: DataTypes.BOOLEAN, defaultValue: false },
    senderId: { type: DataTypes.INTEGER, allowNull: false },
    receiverId: { type: DataTypes.INTEGER, allowNull: false },
})
Chat.hasMany(Message)
Message.belongsTo(Chat)
/** Chat Socket IO END*/


User.hasMany(PdfDocument, { as: 'pdfDocuments', foreignKey: 'userId' });
PdfDocument.belongsTo(User, { as: 'user', foreignKey: 'userId' });

User.hasMany(EmployeeRegistrationTime, { as: 'employeeRegistrationTimes', foreignKey: 'userId' });
EmployeeRegistrationTime.belongsTo(User, { as: 'user', foreignKey: 'userId' });

Position.hasMany(User, { foreignKey: 'positionId', as: 'users', onDelete: 'SET NULL' });
User.belongsTo(Position, { foreignKey: 'positionId', as: 'position' });

User.hasMany(ShareWarning, { as: 'SharedWarnings', foreignKey: 'userId' });
ShareWarning.belongsTo(User, { as: 'User', foreignKey: 'userId' });
Warning.hasMany(ShareWarning, { as: 'WarningShares', foreignKey: 'warningId', onDelete: 'CASCADE' });
ShareWarning.belongsTo(Warning, { as: 'Warning', foreignKey: 'warningId' });

User.hasMany(Note, { as: 'OwnedNotes', foreignKey: 'userId', onDelete: 'CASCADE' });
Note.belongsTo(User, { as: 'Owner', foreignKey: 'userId' });

User.hasMany(Note, { as: 'AuthoredNotes', foreignKey: 'authorId', onDelete: 'CASCADE' });
Note.belongsTo(User, { as: 'Author', foreignKey: 'authorId' });

User.hasMany(Task, { foreignKey: 'userId', as: 'tasks' });
Task.belongsTo(User, { foreignKey: 'userId', as: 'user' });

Project.hasMany(Task, { foreignKey: 'projectId', as: 'tasks', onDelete: 'CASCADE' });
Task.belongsTo(Project, { foreignKey: 'projectId', as: 'project' });

User.belongsToMany(LaborProtection, { through: 'UserLaborProtection' });
LaborProtection.belongsToMany(User, { through: 'UserLaborProtection', onDelete: 'CASCADE', });

DocumtType.hasMany(PdfDocument, { as: 'pdfDocuments', foreignKey: 'documentTypeId', onDelete: 'CASCADE' });
PdfDocument.belongsTo(DocumtType, { as: 'documentType', foreignKey: 'documentTypeId' });

Task.hasMany(SubTask, { foreignKey: 'taskId', as: 'subTasks', onDelete: 'CASCADE' });
SubTask.belongsTo(Task, { foreignKey: 'taskId', as: 'task' });
User.hasMany(SubTask, { foreignKey: 'userId', as: 'subTasks' });
SubTask.belongsTo(User, { foreignKey: 'userId', as: 'user' });

User.hasOne(StartEndWorkTime, { foreignKey: 'userId', as: 'workTime', onDelete: 'CASCADE', });
StartEndWorkTime.belongsTo(User, { foreignKey: 'userId', as: 'user' });

User.hasMany(Absence, { foreignKey: 'userId', as: 'absences', onDelete: 'CASCADE', });
Absence.belongsTo(User, { foreignKey: 'userId', as: 'user', });


module.exports = {
    User,
    PdfDocument,
    EmployeeRegistrationTime,
    StartEndWorkTime,
    Position,
    Note,
    Chat,
    Message,
    Project,
    Task,
    LaborProtection,
    DocumtType,
    Warning,
    ShareWarning,
    Holiday,
    SubTask,
    Absence,
};