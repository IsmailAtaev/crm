/** Status Project and Task. */
const BACKLOG = "Backlog"; // Отставание
const PlANNING = "Planning"; // Планирование
const IN_PROGRESS = "In progress"; // В ходе выполнения
const PAUSED = "Paused"; // Приостановлено
const DONE = "Done"; // Сделанный
const CANCELLED = "Cancelled"; // Отменено
const NOT_STARTED = "Not started"; // Не начато

/** Status Project. rus tkm eng */
const STATUS_PROJECT = [
    {
        tkm: "Dowam edýän",
        eng: PlANNING,
        rus: "Планирование",
        color: "#d7e7ed"
    },
    {
        tkm: "Ýerine ýetirilýär",
        eng: IN_PROGRESS,
        rus: "В ходе выполнения",
        color: "#f8e4b6"
    },
    {
        tkm: "Saklanyldy",
        eng: PAUSED,
        rus: "Приостановлено",
        color: "#ece1f0"
    },
    {
        tkm: "Tamamlanan",
        eng: DONE,
        rus: "Сделанный",
        color: "#d6ecd6"
    },
    {
        tkm: "Ýatyryldy",
        eng: CANCELLED,
        rus: "Отменено",
        color: "#ffebe9"
    },
    {
        tkm: "Başlanmadyk",
        eng: NOT_STARTED,
        rus: "Не начато",
        color: "#e2e1df"
    },
];

/** Status Task. */
const STATUS_TASK = [
    {
        tkm: "Başlanmadyk",
        eng: NOT_STARTED,
        rus: "Не начато",
        color: "#e2e1df"
    },
    {
        tkm: "Ýerine ýetirilýär",
        eng: IN_PROGRESS,
        rus: "В ходе выполнения",
        color: "#d5e7f2"
    },
    {
        tkm: "Tamamlanan",
        eng: DONE,
        rus: "Сделанный",
        color: "#d6ecd6"
    }
];

/**  Priority Project and Task. */
const LOW = "Low"; // Низкий
const MEDIUM = "Medium"; // СРЕДНИЙ
const HIGH = "High"; // Высокий

const PRIORITY = [
    {
        tkm: "Pes",
        eng: LOW,
        rus: "Низкий",
        color: "#d4e8d6"
    },
    {
        tkm: "Orta",
        eng: MEDIUM,
        rus: "Средний",
        color: "#fbe5c0"
    },
    {
        tkm: "Ýokary",
        eng: HIGH,
        rus: "Высокий",
        color: "#fbded8"
    }
];

/** USER PERMISSIONS */
const USER = "USER";
const ADMIN = "ADMIN";
const MODERATOR = "MODERATOR";
const PERMISIONS = [USER, ADMIN, MODERATOR]


module.exports = {
    STATUS_PROJECT,
    STATUS_TASK,
    PRIORITY,
    PERMISIONS,
    USER,
    ADMIN,
    MODERATOR,
    DONE
};