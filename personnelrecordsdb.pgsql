--
-- PostgreSQL database dump
--

-- Dumped from database version 14.12 (Ubuntu 14.12-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.12 (Ubuntu 14.12-0ubuntu0.22.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: personnelrecordsdb; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE personnelrecordsdb WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'ru_RU.UTF-8';


ALTER DATABASE personnelrecordsdb OWNER TO postgres;

\connect personnelrecordsdb

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Absences; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Absences" (
    id uuid NOT NULL,
    "userId" integer NOT NULL,
    "startDate" date NOT NULL,
    "endDate" date NOT NULL,
    reason character varying(255) DEFAULT 'Işe gelmedi'::character varying NOT NULL,
    "daysOff" smallint DEFAULT 0 NOT NULL,
    color character varying(15) DEFAULT '#ffffff'::character varying NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public."Absences" OWNER TO postgres;

--
-- Name: DocumtTypes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."DocumtTypes" (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public."DocumtTypes" OWNER TO postgres;

--
-- Name: EmployeeRegistrationTime; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."EmployeeRegistrationTime" (
    id integer NOT NULL,
    "comeTime" timestamp with time zone NOT NULL,
    "leaveTime" timestamp with time zone,
    flag boolean DEFAULT true,
    "userId" integer,
    "workingHours" character varying(255),
    note character varying(255),
    color character varying(255)
);


ALTER TABLE public."EmployeeRegistrationTime" OWNER TO postgres;

--
-- Name: EmployeeRegistrationTime_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."EmployeeRegistrationTime_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."EmployeeRegistrationTime_id_seq" OWNER TO postgres;

--
-- Name: EmployeeRegistrationTime_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."EmployeeRegistrationTime_id_seq" OWNED BY public."EmployeeRegistrationTime".id;


--
-- Name: LaborProtections; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."LaborProtections" (
    id uuid NOT NULL,
    title character varying(255) NOT NULL,
    description text NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public."LaborProtections" OWNER TO postgres;

--
-- Name: UserLaborProtection; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UserLaborProtection" (
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "userId" integer NOT NULL,
    "LaborProtectionId" uuid NOT NULL
);


ALTER TABLE public."UserLaborProtection" OWNER TO postgres;

--
-- Name: chats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chats (
    id uuid NOT NULL,
    "participantOne" integer NOT NULL,
    "participantTwo" integer NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.chats OWNER TO postgres;

--
-- Name: holidays; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.holidays (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    date date NOT NULL,
    color character varying(255) DEFAULT '#9fc2a4'::character varying NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.holidays OWNER TO postgres;

--
-- Name: messagges; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.messagges (
    id uuid NOT NULL,
    text character varying(255) NOT NULL,
    read boolean DEFAULT false,
    "senderId" integer NOT NULL,
    "receiverId" integer NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "chatId" uuid
);


ALTER TABLE public.messagges OWNER TO postgres;

--
-- Name: notes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notes (
    id uuid NOT NULL,
    "userId" integer NOT NULL,
    "authorType" character varying(255) NOT NULL,
    "authorId" integer NOT NULL,
    content text NOT NULL,
    "projectId" character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.notes OWNER TO postgres;

--
-- Name: pdfDocuments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."pdfDocuments" (
    id integer NOT NULL,
    title character varying(255),
    "pathPdf" character varying(255),
    deleted boolean DEFAULT false,
    "userId" integer NOT NULL,
    "documentTypeId" uuid NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public."pdfDocuments" OWNER TO postgres;

--
-- Name: pdfDocuments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."pdfDocuments_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."pdfDocuments_id_seq" OWNER TO postgres;

--
-- Name: pdfDocuments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."pdfDocuments_id_seq" OWNED BY public."pdfDocuments".id;


--
-- Name: positions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.positions (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.positions OWNER TO postgres;

--
-- Name: projects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.projects (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    status character varying(255) DEFAULT 'Paused'::character varying NOT NULL,
    priority character varying(255) DEFAULT 'High'::character varying NOT NULL,
    "startDate" date NOT NULL,
    "endDate" date NOT NULL,
    completion double precision DEFAULT '0'::double precision NOT NULL,
    archived boolean DEFAULT false NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.projects OWNER TO postgres;

--
-- Name: shareWarnings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."shareWarnings" (
    id integer NOT NULL,
    "warningId" integer NOT NULL,
    "userId" integer NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public."shareWarnings" OWNER TO postgres;

--
-- Name: shareWarnings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."shareWarnings_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."shareWarnings_id_seq" OWNER TO postgres;

--
-- Name: shareWarnings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."shareWarnings_id_seq" OWNED BY public."shareWarnings".id;


--
-- Name: startEndWorkTimes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."startEndWorkTimes" (
    id uuid NOT NULL,
    "userId" integer NOT NULL,
    "startTime" time without time zone DEFAULT '09:00:00'::time without time zone NOT NULL,
    "endTime" time without time zone DEFAULT '18:00:00'::time without time zone NOT NULL
);


ALTER TABLE public."startEndWorkTimes" OWNER TO postgres;

--
-- Name: subTasks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."subTasks" (
    id uuid NOT NULL,
    "userId" integer NOT NULL,
    "taskId" uuid NOT NULL,
    text character varying(255) NOT NULL,
    "isCompleted" boolean DEFAULT false NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public."subTasks" OWNER TO postgres;

--
-- Name: tasks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tasks (
    id uuid NOT NULL,
    "userId" integer NOT NULL,
    "projectId" uuid NOT NULL,
    name character varying(255) NOT NULL,
    status character varying(255) DEFAULT 'Paused'::character varying NOT NULL,
    priority character varying(255) DEFAULT 'High'::character varying NOT NULL,
    "startDate" date NOT NULL,
    "endDate" date NOT NULL,
    "completionProject" double precision DEFAULT '0'::double precision NOT NULL,
    "completionTask" double precision DEFAULT '0'::double precision NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.tasks OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(255),
    pass character varying(255),
    login character varying(255),
    role character varying(255) DEFAULT 'USER'::character varying NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    status boolean DEFAULT true NOT NULL,
    surname character varying(255),
    birthday date,
    "phoneNumber" character varying(255),
    mail character varying(255),
    "whereStudy" character varying(255),
    "whereLive" character varying(255),
    languages character varying(255),
    img character varying(255),
    "positionId" uuid,
    "doorId" character varying(255)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: warnings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.warnings (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    date timestamp with time zone NOT NULL,
    color character varying(255) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.warnings OWNER TO postgres;

--
-- Name: warnings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.warnings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.warnings_id_seq OWNER TO postgres;

--
-- Name: warnings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.warnings_id_seq OWNED BY public.warnings.id;


--
-- Name: EmployeeRegistrationTime id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."EmployeeRegistrationTime" ALTER COLUMN id SET DEFAULT nextval('public."EmployeeRegistrationTime_id_seq"'::regclass);


--
-- Name: pdfDocuments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."pdfDocuments" ALTER COLUMN id SET DEFAULT nextval('public."pdfDocuments_id_seq"'::regclass);


--
-- Name: shareWarnings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."shareWarnings" ALTER COLUMN id SET DEFAULT nextval('public."shareWarnings_id_seq"'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: warnings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.warnings ALTER COLUMN id SET DEFAULT nextval('public.warnings_id_seq'::regclass);


--
-- Data for Name: Absences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Absences" (id, "userId", "startDate", "endDate", reason, "daysOff", color, "createdAt", "updatedAt") FROM stdin;
5f21653c-bb21-47e4-8b0a-9a9c2e3efa2c	18	2024-12-22	2024-12-23	test	1	#E951BF	2024-12-22 12:39:58.445+00	2024-12-22 12:39:58.445+00
20beba17-c343-404a-a5a9-3613d5460c86	18	2025-01-07	2025-01-08	testing	1	#FF9E58	2025-01-07 12:42:32.922+00	2025-01-07 12:42:32.922+00
\.


--
-- Data for Name: DocumtTypes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."DocumtTypes" (id, name, "createdAt", "updatedAt") FROM stdin;
0b368ac2-e7a4-41e4-b749-26099c8c610e	Pasport	2024-10-26 09:44:09.013+00	2024-10-26 09:44:09.013+00
fc4095f1-a573-490a-83f6-ca03c7b85fb8	Dogluş hakynda şahadatnama	2024-10-26 12:35:26.7+00	2024-10-26 12:35:26.7+00
d86dee4f-05e7-4811-8968-b881e0e3c29c	Nika hakynda şahadatnama	2024-10-26 12:35:36.508+00	2024-10-26 12:35:36.508+00
804e69e1-3640-4404-b33a-571fa015cc29	Sertifikat	2024-10-26 12:35:50.583+00	2024-10-26 12:35:50.583+00
4f91e3de-7dc3-439b-9a6c-125d31e45d9b	Harby bilet	2024-10-26 12:36:24.958+00	2024-10-26 12:36:24.958+00
b1b9b120-dafc-485f-8234-f56863efa9b6	Sürüjilik şahadatnamasy	2024-10-26 09:44:30.162+00	2024-10-26 12:37:23.257+00
545403b3-8703-465d-a47c-c164c4fbcf6e	Diplom , Attestat	2024-10-26 09:44:23.553+00	2024-10-26 12:43:38.937+00
17e6fed6-a4bc-4d1d-98f1-d014fedb99f9	Goşmaça	2024-10-26 14:49:03.834+00	2024-10-26 14:49:03.834+00
408f4f57-75f2-481f-ab1c-c58410b33b11	Zagran	2024-11-07 14:56:47.48+00	2024-11-07 14:56:47.48+00
\.


--
-- Data for Name: EmployeeRegistrationTime; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."EmployeeRegistrationTime" (id, "comeTime", "leaveTime", flag, "userId", "workingHours", note, color) FROM stdin;
341	2024-08-20 06:32:00+00	\N	f	16	\N	\N	\N
337	2024-08-27 03:54:34+00	2024-08-27 09:40:58+00	t	14	\N	\N	\N
347	2024-08-28 02:54:07+00	\N	t	14	\N	\N	\N
242	2024-08-20 05:00:38+00	\N	t	\N	\N	\N	\N
306	2024-08-22 12:00:09+00	\N	t	\N	\N	\N	\N
79	2024-07-31 03:55:23+00	\N	t	8	\N	\N	\N
80	2024-07-31 03:57:41+00	\N	t	17	\N	\N	\N
352	2024-08-28 12:51:10+00	2024-08-28 12:59:21+00	t	20	\N	\N	\N
2	2024-06-15 05:56:38+00	2024-06-15 06:27:42+00	t	5	\N	\N	\N
7	2024-06-15 06:27:52+00	2024-06-15 06:28:40+00	t	5	\N	\N	\N
355	2024-08-29 03:53:35+00	2024-08-29 08:43:32+00	t	15	\N	\N	\N
8	2024-06-15 06:29:53+00	\N	t	5	\N	\N	\N
358	2024-08-29 06:04:28+00	2024-08-29 12:35:02+00	t	18	\N	\N	\N
14	2024-06-27 04:41:43+00	2024-06-27 04:42:18+00	t	8	\N	\N	\N
361	2024-08-30 03:53:16+00	2024-08-30 13:01:27+00	t	15	\N	\N	\N
17	2024-06-27 07:14:50+00	\N	t	5	\N	\N	\N
364	2024-08-30 04:29:41+00	2024-08-30 14:00:17+00	t	10	\N	\N	\N
15	2024-06-27 04:42:23+00	2024-06-27 11:01:33+00	t	8	\N	\N	\N
19	2024-06-27 11:01:45+00	2024-06-27 11:01:47+00	t	8	\N	\N	\N
370	2024-08-31 04:08:47+00	2024-08-31 08:25:00+00	t	20	\N	\N	\N
24	2024-07-06 06:54:12+00	2024-07-06 06:54:13+00	t	10	\N	\N	\N
367	2024-08-31 03:43:07+00	2024-08-31 09:50:41+00	t	16	\N	\N	\N
25	2024-07-06 06:54:15+00	2024-07-06 06:54:16+00	t	10	\N	\N	\N
373	2024-08-31 08:25:55+00	2024-08-31 10:45:55+00	t	18	\N	\N	\N
30	2024-07-18 06:53:31+00	2024-07-18 06:55:28+00	t	8	\N	\N	\N
29	2024-07-18 06:05:02+00	2024-07-18 07:02:51+00	t	5	\N	\N	\N
379	2024-09-02 03:35:14+00	2024-09-02 05:51:45+00	t	10	\N	\N	\N
1	2024-06-14 12:47:57+00	\N	t	\N	\N	\N	\N
382	2024-09-02 04:16:40+00	2024-09-02 06:04:51+00	t	18	\N	\N	\N
10	2024-06-20 05:05:41+00	\N	t	\N	\N	\N	\N
376	2024-09-02 03:11:34+00	2024-09-02 07:41:48+00	t	14	\N	\N	\N
385	2024-09-02 10:14:23+00	2024-09-02 13:30:17+00	t	14	\N	\N	\N
388	2024-09-02 11:50:57+00	2024-09-02 14:51:38+00	t	18	\N	\N	\N
391	2024-09-03 03:24:54+00	2024-09-03 05:18:47+00	t	14	\N	\N	\N
394	2024-09-03 04:07:13+00	2024-09-03 13:02:57+00	t	17	\N	\N	\N
3	2024-06-15 06:07:04+00	2024-06-15 06:07:59+00	t	\N	\N	\N	\N
397	2024-09-03 11:20:08+00	2024-09-03 15:20:58+00	t	19	\N	\N	\N
4	2024-06-15 06:08:02+00	2024-06-15 06:08:04+00	t	\N	\N	\N	\N
5	2024-06-15 06:08:06+00	2024-06-15 06:08:07+00	t	\N	\N	\N	\N
403	2024-09-04 04:27:27+00	\N	t	20	\N	\N	\N
400	2024-09-04 03:52:09+00	2024-09-04 08:10:08+00	t	15	\N	\N	\N
409	2024-09-04 11:29:21+00	\N	t	18	\N	\N	\N
406	2024-09-04 11:12:10+00	2024-09-04 13:36:21+00	t	15	\N	\N	\N
6	2024-06-15 06:08:25+00	2024-06-15 06:09:23+00	t	\N	\N	\N	\N
415	2024-09-05 03:46:34+00	2024-09-05 09:37:21+00	t	15	\N	\N	\N
418	2024-09-05 04:05:23+00	2024-09-05 09:37:50+00	t	5	\N	\N	\N
412	2024-09-05 03:25:05+00	2024-09-05 15:06:53+00	t	10	\N	\N	\N
421	2024-09-05 12:28:24+00	2024-09-05 15:19:46+00	t	19	\N	\N	\N
424	2024-09-06 03:41:30+00	2024-09-06 05:26:19+00	t	14	\N	\N	\N
430	2024-09-06 08:43:52+00	2024-09-06 13:00:06+00	t	15	\N	\N	\N
427	2024-09-06 04:18:15+00	2024-09-06 13:02:19+00	t	20	\N	\N	\N
441	2024-09-06 12:45:59+00	2024-09-06 15:18:09+00	t	10	\N	\N	\N
460	2024-09-07 03:59:15+00	2024-09-07 07:55:44+00	t	17	\N	\N	\N
457	2024-09-07 03:16:25+00	2024-09-07 08:04:34+00	t	16	\N	\N	\N
463	2024-09-07 11:07:49+00	2024-09-07 14:44:58+00	t	19	\N	\N	\N
475	2024-09-09 11:27:34+00	\N	t	18	\N	\N	\N
472	2024-09-09 04:11:27+00	2024-09-09 13:00:30+00	t	5	\N	\N	\N
469	2024-09-09 03:44:28+00	2024-09-09 13:17:03+00	t	16	\N	\N	\N
466	2024-09-09 03:25:45+00	2024-09-09 15:12:06+00	t	10	\N	\N	\N
484	2024-09-10 04:35:19+00	2024-09-10 05:47:58+00	t	18	\N	\N	\N
478	2024-09-10 03:45:10+00	2024-09-10 08:43:56+00	t	14	\N	\N	\N
481	2024-09-10 03:57:33+00	2024-09-10 13:07:18+00	t	20	\N	\N	\N
487	2024-09-10 11:37:23+00	2024-09-10 15:08:10+00	t	19	\N	\N	\N
490	2024-09-11 03:43:42+00	2024-09-11 08:02:00+00	t	14	\N	\N	\N
493	2024-09-11 04:07:21+00	2024-09-11 13:02:01+00	t	17	\N	\N	\N
496	2024-09-11 10:45:35+00	2024-09-11 15:12:55+00	t	19	\N	\N	\N
33	2024-07-19 12:34:49+00	2024-07-19 12:36:05+00	t	5	\N	\N	\N
499	2024-09-12 03:25:07+00	2024-09-12 05:38:53+00	t	10	\N	\N	\N
502	2024-09-12 03:56:26+00	2024-09-12 13:03:29+00	t	20	\N	\N	\N
505	2024-09-12 11:37:18+00	2024-09-12 15:01:49+00	t	10	\N	\N	\N
511	2024-09-13 04:14:05+00	2024-09-13 11:20:38+00	t	18	\N	\N	\N
508	2024-09-13 03:55:38+00	2024-09-13 13:01:11+00	t	15	\N	\N	\N
514	2024-09-13 11:22:18+00	2024-09-13 14:53:05+00	t	10	\N	\N	\N
517	2024-09-14 03:35:45+00	2024-09-14 08:04:06+00	t	15	\N	\N	\N
521	2024-09-14 04:52:37+00	2024-09-14 11:57:05+00	t	18	\N	\N	\N
524	2024-09-14 11:57:06+00	2024-09-14 15:19:09+00	t	18	\N	\N	\N
527	2024-09-16 03:31:26+00	2024-09-16 08:36:32+00	t	14	\N	\N	\N
537	2024-09-13 00:00:00+00	\N	f	16	\N	\N	\N
534	2024-09-16 10:35:33+00	2024-09-16 13:00:30+00	t	15	\N	\N	\N
531	2024-09-16 04:04:07+00	2024-09-16 13:06:26+00	t	5	\N	\N	\N
540	2024-09-16 04:19:21+00	2024-09-16 15:21:01+00	f	18	\N	\N	\N
549	2024-09-17 04:09:35+00	2024-09-17 05:49:37+00	t	18	\N	\N	\N
543	2024-09-17 03:40:32+00	2024-09-17 08:41:52+00	t	15	\N	\N	\N
546	2024-09-17 04:06:04+00	2024-09-17 13:03:07+00	t	5	\N	\N	\N
555	2024-09-18 03:55:21+00	2024-09-18 11:21:58+00	t	18	\N	\N	\N
558	2024-09-18 04:17:52+00	2024-09-18 12:59:53+00	t	5	\N	\N	\N
552	2024-09-18 03:30:59+00	2024-09-18 13:04:26+00	t	16	\N	\N	\N
561	2024-09-18 11:39:22+00	2024-09-18 15:17:24+00	t	19	\N	\N	\N
567	2024-09-19 04:08:15+00	2024-09-19 13:14:07+00	t	20	\N	\N	\N
564	2024-09-19 03:40:37+00	2024-09-19 13:21:37+00	t	14	\N	\N	\N
570	2024-09-19 11:09:41+00	2024-09-19 14:38:06+00	t	19	\N	\N	\N
573	2024-09-20 03:45:59+00	2024-09-20 13:21:16+00	t	14	\N	\N	\N
579	2024-09-20 04:39:40+00	2024-09-20 13:34:08+00	t	16	\N	\N	\N
576	2024-09-20 04:07:23+00	2024-09-20 13:44:27+00	t	17	\N	\N	\N
582	2024-09-20 11:31:46+00	2024-09-20 15:16:54+00	t	18	\N	\N	\N
588	2024-09-21 04:14:59+00	2024-09-21 08:06:23+00	t	17	\N	\N	\N
585	2024-09-21 03:48:15+00	2024-09-21 12:03:53+00	t	14	\N	\N	\N
591	2024-09-21 11:13:51+00	2024-09-21 15:20:43+00	t	19	\N	\N	\N
597	2024-09-23 04:08:55+00	2024-09-23 08:23:10+00	t	15	\N	\N	\N
600	2024-09-23 04:12:41+00	2024-09-23 10:57:07+00	t	5	\N	\N	\N
603	2024-09-23 11:01:06+00	2024-09-23 14:52:15+00	t	19	\N	\N	\N
606	2024-09-23 14:52:26+00	2024-09-23 14:52:26+00	t	10	\N	\N	\N
594	2024-09-23 03:49:50+00	2024-09-23 14:53:08+00	t	16	\N	\N	\N
609	2024-09-24 03:38:19+00	\N	t	17	\N	\N	\N
613	2024-09-24 03:54:57+00	2024-09-24 09:30:19+00	t	14	\N	\N	\N
612	2024-09-24 03:54:39+00	2024-09-24 13:05:47+00	t	16	\N	\N	\N
619	2024-09-24 11:27:23+00	2024-09-24 15:15:12+00	t	18	\N	\N	\N
626	2024-09-25 04:11:49+00	2024-09-25 12:31:28+00	t	5	8:19:39	\N	\N
621	2024-09-25 03:55:57+00	2024-09-25 13:05:08+00	t	20	9:9:11	\N	\N
437	2024-09-06 10:50:25+00	2024-09-06 10:50:26+00	t	\N	\N	\N	\N
623	2024-09-25 04:02:49+00	2024-09-25 09:53:03+00	t	14	5:50:14	\N	\N
444	2024-09-06 13:19:00+00	\N	t	\N	\N	\N	\N
448	2024-09-06 13:21:42+00	\N	t	\N	\N	\N	\N
451	2024-09-06 13:46:25+00	\N	t	\N	\N	\N	\N
454	2024-09-06 13:55:22+00	\N	t	\N	\N	\N	\N
616	2024-09-24 07:30:53+00	\N	t	\N	\N	\N	\N
628	2024-09-25 07:36:05+00	2024-09-25 07:44:48+00	t	\N	0:8:43	qqqqqq	#7551E9
630	2024-09-25 08:45:20+00	\N	t	\N	\N	xxxxx	#E951BF
433	2024-09-06 09:15:20+00	2024-09-06 09:15:22+00	t	\N	\N	\N	\N
434	2024-09-06 09:15:22+00	2024-09-06 09:15:23+00	t	\N	\N	\N	\N
34	2024-07-20 07:44:19+00	2024-07-20 07:44:30+00	t	10	\N	\N	\N
35	2024-07-20 07:46:11+00	2024-07-20 07:46:16+00	t	14	\N	\N	\N
40	2024-07-25 12:34:02+00	2024-07-25 12:34:15+00	t	5	\N	\N	\N
342	2024-08-02 00:00:00+00	\N	f	16	\N	\N	\N
335	2024-08-27 03:04:25+00	2024-08-27 14:38:30+00	t	16	\N	\N	\N
348	2024-08-28 03:15:16+00	\N	t	10	\N	\N	\N
350	2024-08-28 05:45:30+00	2024-08-28 15:07:29+00	t	19	\N	\N	\N
359	2024-08-29 08:30:35+00	\N	t	19	\N	\N	\N
356	2024-08-29 04:13:01+00	2024-08-29 13:05:30+00	t	20	\N	\N	\N
353	2024-08-29 03:42:46+00	2024-08-29 13:58:05+00	t	10	\N	\N	\N
365	2024-08-30 08:20:02+00	\N	t	18	\N	\N	\N
362	2024-08-30 04:00:36+00	2024-08-30 13:01:00+00	t	14	\N	\N	\N
368	2024-08-31 03:53:34+00	2024-08-31 08:04:21+00	t	15	\N	\N	\N
371	2024-08-31 06:38:17+00	2024-08-31 11:12:06+00	t	10	\N	\N	\N
374	2024-08-31 11:20:13+00	2024-08-31 13:16:41+00	t	18	\N	\N	\N
377	2024-09-02 03:13:01+00	2024-09-02 07:02:37+00	t	16	\N	\N	\N
383	2024-09-02 07:06:21+00	2024-09-02 12:59:17+00	t	16	\N	\N	\N
380	2024-09-02 03:56:33+00	2024-09-02 13:00:10+00	t	5	\N	\N	\N
386	2024-09-02 10:29:09+00	2024-09-02 14:41:26+00	t	19	\N	\N	\N
389	2024-09-03 03:03:24+00	\N	t	26	\N	\N	\N
395	2024-09-03 04:08:03+00	\N	t	20	\N	\N	\N
398	2024-09-03 13:27:44+00	2024-09-03 15:30:15+00	t	18	\N	\N	\N
392	2024-09-03 03:28:38+00	2024-09-03 15:31:25+00	t	10	\N	\N	\N
401	2024-09-04 03:54:24+00	2024-09-04 08:09:59+00	t	14	\N	\N	\N
407	2024-09-04 11:12:41+00	2024-09-04 13:01:14+00	t	14	\N	\N	\N
404	2024-09-04 04:28:11+00	2024-09-04 13:03:05+00	t	16	\N	\N	\N
410	2024-09-04 11:37:39+00	2024-09-04 15:01:04+00	t	10	\N	\N	\N
419	2024-09-05 04:19:44+00	2024-09-05 11:26:37+00	t	18	\N	\N	\N
416	2024-09-05 04:00:48+00	2024-09-05 13:20:10+00	t	20	\N	\N	\N
413	2024-09-05 03:27:06+00	2024-09-05 13:29:13+00	t	16	\N	\N	\N
422	2024-09-06 03:23:13+00	2024-09-06 05:28:57+00	t	10	\N	\N	\N
428	2024-09-06 04:31:02+00	2024-09-06 05:52:49+00	t	18	\N	\N	\N
438	2024-09-06 11:28:58+00	2024-09-06 12:47:47+00	t	18	\N	\N	\N
439	2024-09-06 11:28:58+00	2024-09-06 12:47:47+00	t	18	\N	\N	\N
431	2024-09-06 08:44:10+00	2024-09-06 13:00:37+00	t	14	\N	\N	\N
425	2024-09-06 03:57:57+00	2024-09-06 14:01:47+00	t	16	\N	\N	\N
442	2024-09-06 12:47:50+00	2024-09-06 15:18:33+00	t	18	\N	\N	\N
458	2024-09-07 03:30:18+00	\N	t	14	\N	\N	\N
461	2024-09-07 04:00:15+00	2024-09-07 08:23:28+00	t	5	\N	\N	\N
464	2024-09-07 11:29:22+00	2024-09-07 15:23:05+00	t	18	\N	\N	\N
473	2024-09-09 04:18:01+00	2024-09-09 05:51:46+00	t	18	\N	\N	\N
470	2024-09-09 04:01:44+00	2024-09-09 12:47:28+00	t	17	\N	\N	\N
476	2024-09-09 11:55:12+00	2024-09-09 13:00:40+00	t	14	\N	\N	\N
467	2024-09-09 03:42:49+00	2024-09-09 13:01:17+00	t	15	\N	\N	\N
479	2024-09-10 03:52:21+00	\N	t	16	\N	\N	\N
482	2024-09-10 03:57:54+00	2024-09-10 13:07:33+00	t	17	\N	\N	\N
485	2024-09-10 11:28:25+00	2024-09-10 15:15:45+00	t	18	\N	\N	\N
491	2024-09-11 03:51:01+00	2024-09-11 08:02:15+00	t	15	\N	\N	\N
497	2024-09-11 11:33:18+00	\N	t	18	\N	\N	\N
488	2024-09-11 03:36:29+00	2024-09-11 13:25:45+00	t	16	\N	\N	\N
494	2024-09-11 04:08:42+00	2024-09-11 13:26:55+00	t	20	\N	\N	\N
500	2024-09-12 03:38:42+00	2024-09-12 13:00:37+00	t	15	\N	\N	\N
503	2024-09-12 04:15:40+00	2024-09-12 13:02:19+00	t	5	\N	\N	\N
506	2024-09-12 11:39:57+00	2024-09-12 15:09:44+00	t	18	\N	\N	\N
512	2024-09-13 04:19:07+00	2024-09-13 13:03:13+00	t	5	\N	\N	\N
509	2024-09-13 04:02:41+00	2024-09-13 13:07:40+00	t	17	\N	\N	\N
518	2024-09-14 04:01:58+00	2024-09-14 07:59:54+00	t	17	\N	\N	\N
515	2024-09-14 03:10:53+00	2024-09-14 08:00:41+00	t	16	\N	\N	\N
519	2024-09-14 04:02:15+00	2024-09-14 08:01:31+00	t	20	\N	\N	\N
522	2024-09-14 10:28:32+00	\N	t	19	\N	\N	\N
532	2024-09-16 04:19:21+00	2024-09-16 05:54:28+00	t	18	\N	\N	\N
528	2024-09-16 03:47:16+00	2024-09-16 08:33:52+00	t	15	\N	\N	\N
535	2024-09-16 10:35:58+00	2024-09-16 13:00:21+00	t	14	\N	\N	\N
525	2024-09-16 03:17:22+00	2024-09-16 13:01:27+00	t	16	\N	\N	\N
550	2024-09-17 10:32:47+00	\N	t	19	\N	\N	\N
544	2024-09-17 03:43:35+00	2024-09-17 13:04:20+00	t	16	\N	\N	\N
547	2024-09-17 04:06:54+00	2024-09-17 13:04:44+00	t	17	\N	\N	\N
553	2024-09-18 03:44:59+00	2024-09-18 12:00:33+00	t	14	\N	\N	\N
559	2024-09-18 06:41:10+00	2024-09-18 13:00:49+00	t	17	\N	\N	\N
556	2024-09-18 03:58:35+00	2024-09-18 13:02:50+00	t	15	\N	\N	\N
562	2024-09-18 14:52:40+00	2024-09-18 14:52:45+00	t	18	\N	\N	\N
568	2024-09-19 04:16:15+00	2024-09-19 11:25:23+00	t	18	\N	\N	\N
565	2024-09-19 03:42:15+00	2024-09-19 13:03:57+00	t	15	\N	\N	\N
571	2024-09-19 11:25:48+00	2024-09-19 14:59:51+00	t	18	\N	\N	\N
577	2024-09-20 04:08:06+00	2024-09-20 13:53:42+00	t	20	\N	\N	\N
580	2024-09-20 09:16:56+00	2024-09-20 14:08:38+00	t	10	\N	\N	\N
574	2024-09-20 03:48:16+00	2024-09-20 15:26:44+00	t	15	\N	\N	\N
583	2024-09-21 03:25:19+00	2024-09-21 05:34:53+00	t	10	\N	\N	\N
586	2024-09-21 03:57:12+00	2024-09-21 08:00:50+00	t	5	\N	\N	\N
589	2024-09-21 04:16:45+00	2024-09-21 08:06:12+00	t	20	\N	\N	\N
592	2024-09-21 11:26:30+00	2024-09-21 15:14:06+00	t	18	\N	\N	\N
598	2024-09-23 04:09:44+00	\N	t	17	\N	\N	\N
601	2024-09-23 04:30:59+00	2024-09-23 05:50:22+00	t	18	\N	\N	\N
595	2024-09-23 03:53:13+00	2024-09-23 08:23:03+00	t	14	\N	\N	\N
607	2024-09-23 12:14:24+00	\N	f	10	\N	\N	\N
604	2024-09-23 11:20:37+00	2024-09-23 14:54:38+00	t	18	\N	\N	\N
614	2024-09-24 04:06:59+00	2024-09-24 13:00:20+00	t	5	\N	\N	\N
610	2024-09-24 03:38:38+00	2024-09-24 13:12:37+00	t	20	\N	\N	\N
618	2024-09-24 11:21:03+00	2024-09-24 15:00:53+00	t	10	\N	\N	\N
617	2024-09-24 11:07:30+00	2024-09-24 16:24:58+00	t	19	\N	\N	\N
627	2024-09-25 04:31:23+00	\N	t	10	\N	\N	\N
624	2024-09-25 04:03:12+00	2024-09-25 05:52:39+00	t	18	\N	\N	\N
637	2024-09-25 13:00:59+00	2024-09-25 13:01:02+00	t	5	0:0:3	Не понятно но ушел я в 18.01	#7551E9
445	2024-09-06 13:19:17+00	\N	t	\N	\N	\N	\N
446	2024-09-06 13:19:27+00	\N	t	\N	\N	\N	\N
449	2024-09-06 13:23:09+00	\N	t	\N	\N	\N	\N
452	2024-09-06 13:47:13+00	\N	t	\N	\N	\N	\N
538	2024-09-06 09:15:37+00	\N	f	\N	\N	\N	\N
541	2024-09-07 00:00:00+00	\N	f	\N	\N	\N	\N
629	2024-09-25 08:43:59+00	2024-09-25 08:45:14+00	t	\N	0:1:15	\N	\N
435	2024-09-06 09:15:23+00	2024-09-06 09:15:24+00	t	\N	\N	\N	\N
436	2024-09-06 09:15:37+00	2024-09-06 10:50:24+00	t	\N	\N	\N	\N
443	2024-09-06 13:18:11+00	\N	t	\N	\N	\N	\N
447	2024-09-06 13:21:05+00	\N	t	\N	\N	\N	\N
450	2024-09-06 13:44:39+00	\N	t	\N	\N	\N	\N
453	2024-09-06 13:52:40+00	\N	t	\N	\N	\N	\N
622	2024-09-25 03:56:53+00	2024-09-25 13:05:23+00	t	17	9:8:30	\N	\N
455	2024-09-02 00:00:00+00	\N	f	\N	\N	\N	\N
631	2024-09-25 03:57:15+00	2024-09-25 13:23:57+00	t	16	9:26:42	Тест	blue
634	2024-09-25 12:22:57+00	2024-09-25 12:22:59+00	t	\N	0:0:2	\N	\N
635	2024-09-25 12:23:00+00	2024-09-25 12:23:01+00	t	\N	0:0:1	\N	\N
636	2024-09-25 12:23:54+00	2024-09-25 12:23:59+00	t	\N	0:0:5	\N	\N
633	2024-09-25 11:43:57+00	2024-09-25 15:01:02+00	t	19	3:17:5	\N	\N
632	2024-09-25 11:21:57+00	2024-09-25 15:21:19+00	t	18	3:59:22	\N	\N
136	2024-08-07 07:15:44+00	\N	t	18	\N	\N	\N
639	2024-09-25 13:30:22+00	2024-09-25 13:33:22+00	t	\N	0:3:0	\N	\N
647	2024-09-26 03:35:02+00	2024-09-26 13:58:22+00	t	16	10:23:20	\N	\N
650	2024-09-26 03:57:58+00	2024-09-26 05:36:14+00	t	18	1:38:16	\N	\N
648	2024-09-26 03:47:08+00	2024-09-26 08:28:43+00	t	14	4:41:35	\N	\N
646	2024-09-26 03:34:34+00	2024-09-26 08:29:14+00	t	15	4:54:40	\N	\N
343	2024-08-27 07:08:39+00	2024-08-27 13:45:08+00	t	18	\N	\N	\N
345	2024-08-28 02:47:49+00	\N	t	5	\N	\N	\N
349	2024-08-28 03:19:21+00	2024-08-28 13:17:27+00	t	16	\N	\N	\N
351	2024-08-28 05:47:56+00	2024-08-28 14:20:46+00	t	18	\N	\N	\N
357	2024-08-29 04:14:45+00	2024-08-29 08:43:43+00	t	14	\N	\N	\N
354	2024-08-29 03:50:48+00	2024-08-29 13:02:25+00	t	16	\N	\N	\N
366	2024-08-30 09:29:53+00	\N	t	19	\N	\N	\N
363	2024-08-30 04:21:43+00	2024-08-30 13:01:31+00	t	20	\N	\N	\N
360	2024-08-30 03:44:57+00	2024-08-30 14:01:10+00	t	16	\N	\N	\N
369	2024-08-31 03:59:46+00	2024-08-31 08:07:04+00	t	14	\N	\N	\N
372	2024-08-31 08:13:52+00	2024-08-31 13:04:27+00	t	19	\N	\N	\N
375	2024-09-01 05:27:41+00	\N	t	18	\N	\N	\N
378	2024-09-02 03:27:36+00	2024-09-02 07:42:14+00	t	15	\N	\N	\N
384	2024-09-02 10:13:55+00	2024-09-02 13:01:09+00	t	15	\N	\N	\N
381	2024-09-02 04:04:42+00	2024-09-02 13:01:18+00	t	20	\N	\N	\N
387	2024-09-02 11:32:23+00	2024-09-02 14:51:29+00	t	10	\N	\N	\N
393	2024-09-03 03:59:57+00	\N	t	5	\N	\N	\N
396	2024-09-03 04:18:44+00	2024-09-03 06:01:17+00	t	18	\N	\N	\N
390	2024-09-03 03:04:51+00	2024-09-03 13:06:30+00	t	16	\N	\N	\N
399	2024-09-04 03:33:39+00	2024-09-04 05:46:51+00	t	10	\N	\N	\N
405	2024-09-04 04:32:16+00	2024-09-04 05:55:58+00	t	18	\N	\N	\N
411	2024-09-04 12:58:21+00	2024-09-04 13:00:07+00	t	5	\N	\N	\N
402	2024-09-04 04:14:34+00	2024-09-04 13:02:59+00	t	17	\N	\N	\N
408	2024-09-04 11:16:49+00	2024-09-04 15:17:35+00	t	19	\N	\N	\N
414	2024-09-05 03:30:02+00	2024-09-05 09:37:25+00	t	14	\N	\N	\N
417	2024-09-05 04:01:18+00	2024-09-05 13:10:25+00	t	17	\N	\N	\N
420	2024-09-05 11:26:38+00	2024-09-05 15:17:39+00	t	18	\N	\N	\N
426	2024-09-06 04:05:37+00	\N	t	5	\N	\N	\N
423	2024-09-06 03:40:55+00	2024-09-06 05:26:06+00	t	15	\N	\N	\N
429	2024-09-06 06:58:49+00	\N	t	17	\N	\N	\N
620	2024-09-25 03:48:18+00	2024-09-25 13:01:03+00	t	15	9:12:45	\N	\N
440	2024-09-06 12:44:14+00	2024-09-06 12:47:47+00	t	18	\N	\N	\N
456	2024-09-07 03:01:38+00	2024-09-07 05:49:58+00	t	10	\N	\N	\N
459	2024-09-07 03:49:55+00	2024-09-07 08:01:26+00	t	15	\N	\N	\N
462	2024-09-07 04:18:56+00	2024-09-07 11:28:51+00	t	18	\N	\N	\N
465	2024-09-07 11:36:29+00	2024-09-07 14:40:29+00	t	10	\N	\N	\N
468	2024-09-09 03:43:07+00	2024-09-09 05:48:01+00	t	14	\N	\N	\N
471	2024-09-09 04:02:12+00	2024-09-09 13:00:40+00	t	20	\N	\N	\N
474	2024-09-09 10:15:53+00	2024-09-09 15:20:17+00	t	19	\N	\N	\N
477	2024-09-10 03:30:02+00	2024-09-10 05:41:16+00	t	10	\N	\N	\N
483	2024-09-10 04:23:02+00	2024-09-10 08:42:48+00	t	5	\N	\N	\N
480	2024-09-10 03:55:05+00	2024-09-10 08:43:44+00	t	15	\N	\N	\N
486	2024-09-10 11:36:20+00	2024-09-10 15:02:03+00	t	10	\N	\N	\N
492	2024-09-11 04:05:30+00	2024-09-11 05:44:50+00	t	18	\N	\N	\N
495	2024-09-11 04:10:03+00	2024-09-11 08:01:47+00	t	5	\N	\N	\N
489	2024-09-11 03:36:53+00	2024-09-11 14:22:52+00	t	10	\N	\N	\N
504	2024-09-12 04:19:03+00	2024-09-12 11:39:47+00	t	18	\N	\N	\N
498	2024-09-12 03:20:07+00	2024-09-12 13:00:58+00	t	16	\N	\N	\N
501	2024-09-12 03:55:54+00	2024-09-12 13:06:44+00	t	17	\N	\N	\N
507	2024-09-13 03:10:46+00	2024-09-13 05:46:42+00	t	10	\N	\N	\N
510	2024-09-13 04:03:21+00	2024-09-13 13:11:29+00	t	20	\N	\N	\N
513	2024-09-13 11:20:39+00	2024-09-13 15:14:25+00	t	18	\N	\N	\N
516	2024-09-14 03:27:26+00	2024-09-14 05:52:47+00	t	10	\N	\N	\N
520	2024-09-14 04:04:52+00	2024-09-14 08:03:00+00	t	5	\N	\N	\N
523	2024-09-14 11:39:02+00	2024-09-14 14:57:44+00	t	10	\N	\N	\N
533	2024-09-05 04:19:44+00	\N	f	18	\N	\N	\N
530	2024-09-16 03:57:44+00	2024-09-16 13:04:28+00	t	20	\N	\N	\N
529	2024-09-16 03:57:42+00	2024-09-16 13:05:59+00	t	17	\N	\N	\N
526	2024-09-16 03:23:30+00	2024-09-16 13:13:17+00	t	10	\N	\N	\N
536	2024-09-16 11:02:25+00	2024-09-16 14:22:18+00	t	19	\N	\N	\N
539	2024-09-16 11:55:50+00	2024-09-16 15:21:01+00	t	18	\N	\N	\N
548	2024-09-17 04:07:49+00	\N	t	20	\N	\N	\N
545	2024-09-17 03:45:50+00	2024-09-17 08:42:14+00	t	14	\N	\N	\N
542	2024-09-17 03:37:49+00	2024-09-17 14:18:38+00	t	10	\N	\N	\N
551	2024-09-17 11:48:09+00	2024-09-17 15:19:49+00	t	18	\N	\N	\N
557	2024-09-18 04:14:37+00	2024-09-18 13:05:06+00	t	20	\N	\N	\N
554	2024-09-18 03:51:07+00	2024-09-18 14:14:42+00	t	10	\N	\N	\N
560	2024-09-18 11:22:00+00	2024-09-18 14:52:27+00	t	18	\N	\N	\N
569	2024-09-19 07:44:58+00	2024-09-19 13:04:49+00	t	5	\N	\N	\N
563	2024-09-19 03:34:17+00	2024-09-19 14:03:14+00	t	10	\N	\N	\N
566	2024-09-19 03:50:33+00	2024-09-19 14:32:49+00	t	16	\N	\N	\N
572	2024-09-20 03:31:24+00	2024-09-20 05:35:08+00	t	10	\N	\N	\N
578	2024-09-20 04:26:52+00	2024-09-20 05:51:36+00	t	18	\N	\N	\N
575	2024-09-20 04:04:02+00	2024-09-20 13:00:09+00	t	5	\N	\N	\N
581	2024-09-20 11:12:04+00	2024-09-20 15:39:00+00	t	19	\N	\N	\N
584	2024-09-21 03:36:54+00	2024-09-21 07:59:55+00	t	16	\N	\N	\N
587	2024-09-21 04:06:23+00	2024-09-21 10:51:14+00	t	15	\N	\N	\N
41	2024-07-25 12:52:13+00	2024-07-25 12:52:19+00	t	15	\N	\N	\N
42	2024-07-25 12:52:35+00	2024-07-25 12:52:38+00	t	15	\N	\N	\N
43	2024-07-25 13:23:53+00	2024-07-25 13:23:54+00	t	16	\N	\N	\N
45	2024-07-26 03:58:03+00	\N	t	15	\N	\N	\N
46	2024-07-26 03:58:41+00	\N	t	8	\N	\N	\N
47	2024-07-26 03:58:44+00	2024-07-26 04:00:08+00	t	16	\N	\N	\N
48	2024-07-26 04:00:17+00	2024-07-26 04:00:32+00	t	16	\N	\N	\N
49	2024-07-26 04:00:40+00	2024-07-26 04:00:52+00	t	16	\N	\N	\N
44	2024-07-26 03:57:49+00	2024-07-26 04:01:13+00	t	10	\N	\N	\N
50	2024-07-26 04:01:19+00	2024-07-26 04:02:20+00	t	10	\N	\N	\N
52	2024-07-26 04:02:47+00	\N	t	16	\N	\N	\N
51	2024-07-26 04:02:22+00	2024-07-26 04:05:14+00	t	10	\N	\N	\N
53	2024-07-26 04:05:17+00	\N	t	10	\N	\N	\N
54	2024-07-26 04:06:52+00	\N	t	14	\N	\N	\N
56	2024-07-26 04:10:07+00	\N	t	5	\N	\N	\N
55	2024-07-26 04:10:02+00	2024-07-26 04:10:09+00	t	17	\N	\N	\N
57	2024-07-26 04:10:27+00	\N	t	17	\N	\N	\N
58	2024-07-29 04:02:45+00	\N	t	16	\N	\N	\N
59	2024-07-29 04:03:30+00	\N	t	10	\N	\N	\N
60	2024-07-29 04:03:39+00	\N	t	15	\N	\N	\N
61	2024-07-29 04:03:41+00	\N	t	8	\N	\N	\N
62	2024-07-29 04:08:32+00	\N	t	14	\N	\N	\N
246	2024-08-20 06:34:17+00	2024-08-20 11:40:14+00	t	16	\N	\N	\N
247	2024-08-20 11:40:16+00	2024-08-20 12:53:54+00	t	16	\N	\N	\N
248	2024-08-20 12:53:59+00	2024-08-20 13:43:50+00	t	16	\N	\N	\N
238	2024-08-20 04:05:00+00	2024-08-20 13:44:38+00	t	20	\N	\N	\N
432	2024-09-06 09:15:15+00	2024-09-06 09:15:16+00	t	\N	\N	\N	\N
266	2024-08-21 03:59:09+00	2024-08-21 05:01:45+00	t	14	\N	\N	\N
267	2024-08-21 03:59:16+00	2024-08-21 05:01:45+00	t	14	\N	\N	\N
268	2024-08-21 03:59:16+00	2024-08-21 05:01:45+00	t	14	\N	\N	\N
269	2024-08-21 03:59:17+00	2024-08-21 05:01:45+00	t	14	\N	\N	\N
270	2024-08-21 03:59:17+00	2024-08-21 05:01:45+00	t	14	\N	\N	\N
271	2024-08-21 03:59:17+00	2024-08-21 05:01:45+00	t	14	\N	\N	\N
272	2024-08-21 03:59:17+00	2024-08-21 05:01:45+00	t	14	\N	\N	\N
273	2024-08-21 03:59:19+00	2024-08-21 05:01:45+00	t	14	\N	\N	\N
274	2024-08-21 03:59:29+00	2024-08-21 05:01:45+00	t	14	\N	\N	\N
275	2024-08-21 03:59:29+00	2024-08-21 05:01:45+00	t	14	\N	\N	\N
276	2024-08-21 03:59:29+00	2024-08-21 05:01:45+00	t	14	\N	\N	\N
590	2024-09-21 09:24:58+00	2024-09-21 14:00:08+00	t	10	\N	\N	\N
596	2024-09-13 00:00:00+00	\N	f	16	\N	\N	\N
593	2024-09-23 03:22:35+00	2024-09-23 04:11:05+00	t	10	\N	\N	\N
602	2024-09-23 05:38:01+00	2024-09-23 05:49:54+00	t	10	\N	\N	\N
605	2024-09-23 12:14:24+00	2024-09-23 12:14:24+00	t	10	\N	\N	\N
599	2024-09-23 04:10:53+00	2024-09-23 12:41:30+00	t	20	\N	\N	\N
608	2024-09-24 03:33:37+00	2024-09-24 05:38:00+00	t	10	\N	\N	\N
615	2024-09-24 04:10:58+00	2024-09-24 05:45:56+00	t	18	\N	\N	\N
611	2024-09-24 03:47:20+00	2024-09-24 09:30:01+00	t	15	\N	\N	\N
63	2024-07-29 04:31:34+00	2024-07-29 04:38:30+00	t	17	\N	\N	\N
64	2024-07-29 04:38:39+00	\N	t	17	\N	\N	\N
65	2024-07-29 07:43:01+00	\N	t	19	\N	\N	\N
66	2024-07-29 07:50:23+00	2024-07-29 07:50:35+00	t	18	\N	\N	\N
67	2024-07-29 07:50:38+00	2024-07-29 13:09:58+00	t	18	\N	\N	\N
69	2024-07-30 03:34:04+00	\N	t	15	\N	\N	\N
70	2024-07-30 03:42:16+00	\N	t	10	\N	\N	\N
71	2024-07-30 03:59:53+00	\N	t	8	\N	\N	\N
72	2024-07-30 04:02:31+00	\N	t	14	\N	\N	\N
73	2024-07-30 04:06:16+00	2024-07-30 04:06:58+00	t	5	\N	\N	\N
74	2024-07-30 04:06:59+00	\N	t	5	\N	\N	\N
68	2024-07-30 02:59:47+00	2024-07-30 13:00:10+00	t	16	\N	\N	\N
75	2024-07-31 03:17:41+00	\N	t	16	\N	\N	\N
81	2024-07-31 04:00:59+00	\N	t	5	\N	\N	\N
84	2024-07-31 09:43:06+00	\N	t	19	\N	\N	\N
78	2024-07-31 03:38:24+00	2024-07-31 13:02:37+00	t	10	\N	\N	\N
83	2024-07-31 08:53:10+00	2024-07-31 13:05:45+00	t	18	\N	\N	\N
85	2024-07-31 13:05:53+00	2024-07-31 13:05:56+00	t	18	\N	\N	\N
77	2024-07-31 03:36:26+00	2024-07-31 13:08:39+00	t	15	\N	\N	\N
82	2024-07-31 04:05:09+00	2024-07-31 13:09:05+00	t	14	\N	\N	\N
86	2024-08-01 03:37:38+00	2024-08-01 08:22:21+00	t	15	\N	\N	\N
90	2024-08-01 04:32:02+00	2024-08-01 08:22:51+00	t	14	\N	\N	\N
94	2024-08-01 13:01:32+00	2024-08-01 13:01:33+00	t	17	\N	\N	\N
87	2024-08-01 03:43:16+00	2024-08-01 13:05:12+00	t	16	\N	\N	\N
92	2024-08-01 11:20:47+00	2024-08-01 13:06:30+00	t	14	\N	\N	\N
93	2024-08-01 11:32:10+00	2024-08-01 13:06:46+00	t	15	\N	\N	\N
91	2024-08-01 06:22:39+00	2024-08-01 13:13:56+00	t	18	\N	\N	\N
95	2024-08-01 13:02:18+00	2024-08-01 13:26:07+00	t	19	\N	\N	\N
88	2024-08-01 03:51:51+00	2024-08-01 13:29:55+00	t	10	\N	\N	\N
96	2024-08-02 04:08:01+00	\N	t	17	\N	\N	\N
100	2024-08-02 04:34:10+00	\N	t	5	\N	\N	\N
98	2024-08-02 04:09:02+00	2024-08-02 13:11:15+00	t	14	\N	\N	\N
97	2024-08-02 04:08:42+00	2024-08-02 13:11:52+00	t	15	\N	\N	\N
99	2024-08-02 04:09:54+00	2024-08-02 13:16:28+00	t	10	\N	\N	\N
101	2024-08-02 07:19:55+00	2024-08-02 13:48:24+00	t	18	\N	\N	\N
102	2024-08-02 07:26:00+00	2024-08-02 14:06:02+00	t	19	\N	\N	\N
108	2024-08-03 05:17:32+00	\N	t	5	\N	\N	\N
105	2024-08-03 03:59:08+00	2024-08-03 06:56:29+00	t	14	\N	\N	\N
107	2024-08-03 04:08:54+00	2024-08-03 07:58:17+00	t	20	\N	\N	\N
106	2024-08-03 04:00:10+00	2024-08-03 07:58:39+00	t	17	\N	\N	\N
104	2024-08-03 03:59:03+00	2024-08-03 08:00:02+00	t	10	\N	\N	\N
103	2024-08-03 03:58:52+00	2024-08-03 08:01:30+00	t	15	\N	\N	\N
109	2024-08-03 06:45:24+00	2024-08-03 08:08:14+00	t	18	\N	\N	\N
111	2024-08-03 07:54:47+00	2024-08-03 10:17:25+00	t	19	\N	\N	\N
112	2024-08-05 03:59:59+00	\N	t	5	\N	\N	\N
115	2024-08-05 05:34:41+00	\N	t	20	\N	\N	\N
113	2024-08-05 04:00:39+00	2024-08-05 12:50:14+00	t	15	\N	\N	\N
119	2024-08-05 09:26:40+00	2024-08-05 13:02:59+00	t	17	\N	\N	\N
114	2024-08-05 04:08:28+00	2024-08-05 13:05:25+00	t	14	\N	\N	\N
117	2024-08-05 07:26:29+00	2024-08-05 13:15:29+00	t	18	\N	\N	\N
118	2024-08-05 07:34:24+00	2024-08-05 13:41:42+00	t	19	\N	\N	\N
116	2024-08-05 06:03:32+00	2024-08-05 14:10:07+00	t	10	\N	\N	\N
122	2024-08-06 04:22:50+00	\N	t	10	\N	\N	\N
125	2024-08-06 06:42:22+00	2024-08-06 08:39:48+00	t	17	\N	\N	\N
124	2024-08-06 04:23:14+00	2024-08-06 09:13:42+00	t	15	\N	\N	\N
123	2024-08-06 04:22:50+00	2024-08-06 09:14:00+00	t	14	\N	\N	\N
121	2024-08-06 04:18:26+00	2024-08-06 13:04:27+00	t	20	\N	\N	\N
128	2024-08-06 13:04:48+00	2024-08-06 13:05:13+00	t	20	\N	\N	\N
120	2024-08-06 04:18:01+00	2024-08-06 13:05:59+00	t	16	\N	\N	\N
126	2024-08-06 07:09:44+00	2024-08-06 13:08:41+00	t	18	\N	\N	\N
127	2024-08-06 08:23:44+00	2024-08-06 13:36:25+00	t	19	\N	\N	\N
134	2024-08-07 04:04:45+00	\N	t	20	\N	\N	\N
135	2024-08-07 04:15:13+00	\N	t	17	\N	\N	\N
129	2024-08-07 03:29:21+00	2024-08-07 13:01:06+00	t	16	\N	\N	\N
130	2024-08-07 03:33:50+00	2024-08-07 13:01:13+00	t	15	\N	\N	\N
131	2024-08-07 03:38:31+00	2024-08-07 13:02:22+00	t	10	\N	\N	\N
9	2024-06-20 05:03:36+00	2024-06-20 05:07:23+00	t	\N	\N	\N	\N
133	2024-08-07 04:01:51+00	2024-08-07 13:00:18+00	t	14	\N	\N	\N
132	2024-08-07 03:56:59+00	2024-08-07 13:03:21+00	t	8	\N	\N	\N
137	2024-08-07 07:52:38+00	2024-08-07 13:11:56+00	t	19	\N	\N	\N
138	2024-08-08 03:58:12+00	\N	t	15	\N	\N	\N
139	2024-08-08 03:58:21+00	\N	t	16	\N	\N	\N
140	2024-08-08 03:59:54+00	\N	t	14	\N	\N	\N
141	2024-08-08 04:00:13+00	\N	t	10	\N	\N	\N
142	2024-08-08 04:10:12+00	\N	t	8	\N	\N	\N
143	2024-08-08 04:20:58+00	2024-08-08 12:34:59+00	t	17	\N	\N	\N
148	2024-08-09 13:02:57+00	2024-08-09 13:02:57+00	t	8	\N	\N	\N
145	2024-08-09 08:56:35+00	2024-08-09 13:03:13+00	t	20	\N	\N	\N
144	2024-08-09 06:45:01+00	2024-08-09 13:03:37+00	t	16	\N	\N	\N
149	2024-08-09 13:07:32+00	2024-08-09 13:07:33+00	t	15	\N	\N	\N
147	2024-08-09 10:39:52+00	2024-08-09 13:20:14+00	t	18	\N	\N	\N
146	2024-08-09 09:28:52+00	2024-08-09 14:15:11+00	t	19	\N	\N	\N
151	2024-08-10 03:46:11+00	\N	t	10	\N	\N	\N
152	2024-08-10 03:46:54+00	\N	t	15	\N	\N	\N
150	2024-08-10 03:10:40+00	2024-08-10 07:58:50+00	t	16	\N	\N	\N
153	2024-08-10 04:00:28+00	2024-08-10 07:59:00+00	t	17	\N	\N	\N
155	2024-08-10 04:25:19+00	2024-08-10 07:59:01+00	t	20	\N	\N	\N
156	2024-08-10 07:58:54+00	2024-08-10 08:00:18+00	t	16	\N	\N	\N
154	2024-08-10 04:02:33+00	2024-08-10 08:02:42+00	t	5	\N	\N	\N
158	2024-08-10 09:06:25+00	2024-08-10 13:23:24+00	t	18	\N	\N	\N
157	2024-08-10 08:24:30+00	2024-08-10 13:47:57+00	t	19	\N	\N	\N
165	2024-08-12 04:10:47+00	\N	t	5	\N	\N	\N
166	2024-08-12 04:14:55+00	\N	t	20	\N	\N	\N
161	2024-08-12 03:58:39+00	2024-08-12 13:01:01+00	t	16	\N	\N	\N
163	2024-08-12 04:06:17+00	2024-08-12 13:02:27+00	t	17	\N	\N	\N
164	2024-08-12 04:06:22+00	2024-08-12 13:02:27+00	t	17	\N	\N	\N
159	2024-08-12 03:45:01+00	2024-08-12 13:03:09+00	t	15	\N	\N	\N
160	2024-08-12 03:50:35+00	2024-08-12 13:04:33+00	t	8	\N	\N	\N
168	2024-08-12 06:54:55+00	2024-08-12 13:05:02+00	t	14	\N	\N	\N
167	2024-08-12 05:44:45+00	2024-08-12 13:39:43+00	t	19	\N	\N	\N
169	2024-08-12 08:39:28+00	2024-08-12 13:45:28+00	t	18	\N	\N	\N
162	2024-08-12 03:58:51+00	2024-08-12 13:53:45+00	t	10	\N	\N	\N
173	2024-08-13 03:59:43+00	2024-08-13 09:44:36+00	t	14	\N	\N	\N
170	2024-08-13 03:46:01+00	2024-08-13 09:45:08+00	t	15	\N	\N	\N
174	2024-08-13 04:01:11+00	2024-08-13 09:47:39+00	t	8	\N	\N	\N
175	2024-08-13 04:01:16+00	2024-08-13 09:47:39+00	t	8	\N	\N	\N
176	2024-08-13 04:10:20+00	2024-08-13 13:03:57+00	t	17	\N	\N	\N
177	2024-08-13 04:12:40+00	2024-08-13 13:04:22+00	t	20	\N	\N	\N
172	2024-08-13 03:50:36+00	2024-08-13 13:20:49+00	t	16	\N	\N	\N
178	2024-08-13 07:45:21+00	2024-08-13 13:23:48+00	t	18	\N	\N	\N
179	2024-08-13 09:45:24+00	2024-08-13 13:44:25+00	t	19	\N	\N	\N
171	2024-08-13 03:49:05+00	2024-08-13 14:24:18+00	t	10	\N	\N	\N
181	2024-08-14 03:37:19+00	\N	t	16	\N	\N	\N
185	2024-08-14 03:55:26+00	2024-08-14 04:18:22+00	t	17	\N	\N	\N
184	2024-08-14 03:54:29+00	2024-08-14 06:59:31+00	t	15	\N	\N	\N
180	2024-08-14 03:35:54+00	2024-08-14 06:59:41+00	t	14	\N	\N	\N
186	2024-08-14 03:58:02+00	2024-08-14 07:00:31+00	t	8	\N	\N	\N
183	2024-08-14 03:53:33+00	2024-08-14 12:56:57+00	t	20	\N	\N	\N
187	2024-08-14 06:36:12+00	2024-08-14 13:00:42+00	t	17	\N	\N	\N
189	2024-08-14 09:00:05+00	2024-08-14 13:02:54+00	t	14	\N	\N	\N
191	2024-08-14 09:45:23+00	2024-08-14 13:04:38+00	t	15	\N	\N	\N
190	2024-08-14 09:00:10+00	2024-08-14 13:05:21+00	t	8	\N	\N	\N
188	2024-08-14 08:13:28+00	2024-08-14 13:43:06+00	t	18	\N	\N	\N
192	2024-08-14 12:51:34+00	2024-08-14 14:00:00+00	t	19	\N	\N	\N
182	2024-08-14 03:42:19+00	2024-08-14 14:12:01+00	t	10	\N	\N	\N
193	2024-08-15 03:11:15+00	2024-08-15 13:01:03+00	t	16	\N	\N	\N
198	2024-08-15 04:00:51+00	2024-08-15 13:02:54+00	t	17	\N	\N	\N
199	2024-08-15 04:03:13+00	2024-08-15 13:03:04+00	t	20	\N	\N	\N
197	2024-08-15 03:59:04+00	2024-08-15 13:05:57+00	t	14	\N	\N	\N
196	2024-08-15 03:58:42+00	2024-08-15 13:08:21+00	t	8	\N	\N	\N
194	2024-08-15 03:45:46+00	2024-08-15 13:09:40+00	t	15	\N	\N	\N
201	2024-08-15 08:16:39+00	2024-08-15 13:18:46+00	t	19	\N	\N	\N
200	2024-08-15 08:16:18+00	2024-08-15 13:22:45+00	t	18	\N	\N	\N
195	2024-08-15 03:50:52+00	2024-08-15 13:58:08+00	t	10	\N	\N	\N
205	2024-08-16 04:01:14+00	\N	t	8	\N	\N	\N
206	2024-08-16 04:09:55+00	\N	t	20	\N	\N	\N
209	2024-08-16 09:25:45+00	\N	t	18	\N	\N	\N
204	2024-08-16 03:47:29+00	2024-08-16 13:02:16+00	t	14	\N	\N	\N
203	2024-08-16 03:38:39+00	2024-08-16 13:02:37+00	t	15	\N	\N	\N
210	2024-08-16 12:26:09+00	2024-08-16 13:02:57+00	t	17	\N	\N	\N
207	2024-08-16 05:40:13+00	2024-08-16 14:02:14+00	t	16	\N	\N	\N
211	2024-08-16 14:02:16+00	\N	t	16	\N	\N	\N
202	2024-08-16 03:38:10+00	2024-08-16 14:17:25+00	t	10	\N	\N	\N
208	2024-08-16 08:38:23+00	2024-08-16 14:44:37+00	t	19	\N	\N	\N
213	2024-08-17 04:00:23+00	2024-08-17 08:06:02+00	t	14	\N	\N	\N
212	2024-08-17 04:00:05+00	2024-08-17 08:06:45+00	t	15	\N	\N	\N
214	2024-08-17 04:00:41+00	2024-08-17 08:06:52+00	t	8	\N	\N	\N
219	2024-08-17 08:07:32+00	\N	t	19	\N	\N	\N
216	2024-08-17 04:14:59+00	2024-08-17 08:10:20+00	t	16	\N	\N	\N
217	2024-08-17 04:50:48+00	2024-08-17 08:17:45+00	t	20	\N	\N	\N
218	2024-08-17 07:18:11+00	2024-08-17 08:20:34+00	t	17	\N	\N	\N
215	2024-08-17 04:00:41+00	2024-08-17 12:02:59+00	t	10	\N	\N	\N
220	2024-08-17 09:43:43+00	2024-08-17 13:34:00+00	t	18	\N	\N	\N
221	2024-08-19 03:42:34+00	2024-08-19 05:16:09+00	t	16	\N	\N	\N
225	2024-08-19 05:16:19+00	2024-08-19 05:17:46+00	t	16	\N	\N	\N
227	2024-08-19 05:18:49+00	\N	t	5	\N	\N	\N
224	2024-08-19 04:01:42+00	2024-08-19 11:40:10+00	t	8	\N	\N	\N
11	2024-06-20 05:18:01+00	2024-06-20 06:22:34+00	t	\N	\N	\N	\N
12	2024-06-20 07:52:27+00	2024-06-20 07:54:09+00	t	\N	\N	\N	\N
13	2024-06-27 04:30:34+00	2024-06-27 05:25:32+00	t	\N	\N	\N	\N
16	2024-06-27 05:25:35+00	2024-06-27 07:28:06+00	t	\N	\N	\N	\N
18	2024-06-27 07:28:11+00	2024-06-27 07:28:17+00	t	\N	\N	\N	\N
20	2024-07-05 03:55:45+00	2024-07-05 04:47:33+00	t	\N	\N	\N	\N
21	2024-07-06 04:30:50+00	2024-07-06 05:33:50+00	t	\N	\N	\N	\N
22	2024-07-06 06:03:00+00	2024-07-06 06:11:44+00	t	\N	\N	\N	\N
23	2024-07-06 06:42:04+00	2024-07-06 07:32:10+00	t	\N	\N	\N	\N
26	2024-07-15 06:23:48+00	2024-07-15 07:33:18+00	t	\N	\N	\N	\N
27	2024-07-17 06:00:16+00	2024-07-17 06:00:58+00	t	\N	\N	\N	\N
28	2024-07-17 06:01:07+00	2024-07-17 06:02:09+00	t	\N	\N	\N	\N
31	2024-07-18 09:57:58+00	2024-07-18 09:58:01+00	t	\N	\N	\N	\N
32	2024-07-18 10:00:01+00	2024-07-18 10:00:25+00	t	\N	\N	\N	\N
36	2024-07-25 07:02:12+00	2024-07-25 07:44:46+00	t	\N	\N	\N	\N
37	2024-07-25 11:57:16+00	2024-07-25 11:57:17+00	t	\N	\N	\N	\N
38	2024-07-25 12:02:16+00	2024-07-25 12:02:17+00	t	\N	\N	\N	\N
39	2024-07-25 12:03:59+00	2024-07-25 13:09:48+00	t	\N	\N	\N	\N
76	2024-07-31 03:20:58+00	2024-07-31 08:20:18+00	t	\N	\N	\N	\N
89	2024-08-01 04:29:37+00	\N	t	\N	\N	\N	\N
110	2024-08-03 07:17:35+00	\N	t	\N	\N	\N	\N
226	2024-08-19 05:18:02+00	2024-08-19 12:04:07+00	t	16	\N	\N	\N
231	2024-08-19 06:28:07+00	2024-08-19 13:02:53+00	t	17	\N	\N	\N
229	2024-08-19 05:20:43+00	2024-08-19 13:05:25+00	t	15	\N	\N	\N
223	2024-08-19 03:55:10+00	2024-08-19 13:06:34+00	t	14	\N	\N	\N
230	2024-08-19 05:22:50+00	2024-08-19 13:08:12+00	t	20	\N	\N	\N
228	2024-08-19 05:19:36+00	2024-08-19 13:56:16+00	t	19	\N	\N	\N
233	2024-08-19 12:04:49+00	2024-08-19 14:17:32+00	t	16	\N	\N	\N
222	2024-08-19 03:47:49+00	2024-08-19 14:25:32+00	t	10	\N	\N	\N
232	2024-08-19 07:25:48+00	2024-08-19 14:30:10+00	t	18	\N	\N	\N
235	2024-08-20 03:53:09+00	\N	t	8	\N	\N	\N
237	2024-08-20 03:57:26+00	\N	t	5	\N	\N	\N
243	2024-08-20 06:31:00+00	\N	t	18	\N	\N	\N
234	2024-08-20 03:48:57+00	2024-08-20 06:31:58+00	t	16	\N	\N	\N
245	2024-08-20 06:32:00+00	2024-08-20 06:34:14+00	t	16	\N	\N	\N
241	2024-08-20 04:44:14+00	2024-08-20 12:10:02+00	t	15	\N	\N	\N
236	2024-08-20 03:57:11+00	2024-08-20 12:10:13+00	t	14	\N	\N	\N
239	2024-08-20 04:07:22+00	2024-08-20 13:14:28+00	t	17	\N	\N	\N
240	2024-08-20 04:42:18+00	2024-08-20 14:14:48+00	t	10	\N	\N	\N
244	2024-08-20 06:31:20+00	2024-08-20 14:54:40+00	t	19	\N	\N	\N
277	2024-08-21 03:59:29+00	2024-08-21 05:01:45+00	t	14	\N	\N	\N
278	2024-08-21 03:59:29+00	2024-08-21 05:01:45+00	t	14	\N	\N	\N
279	2024-08-21 03:59:30+00	2024-08-21 05:01:45+00	t	14	\N	\N	\N
280	2024-08-21 04:01:27+00	2024-08-21 05:01:45+00	t	14	\N	\N	\N
251	2024-08-21 03:52:46+00	2024-08-21 05:02:01+00	t	15	\N	\N	\N
252	2024-08-21 03:52:55+00	2024-08-21 05:02:01+00	t	15	\N	\N	\N
253	2024-08-21 03:53:07+00	2024-08-21 05:02:01+00	t	15	\N	\N	\N
254	2024-08-21 03:53:46+00	2024-08-21 05:02:01+00	t	15	\N	\N	\N
255	2024-08-21 03:53:48+00	2024-08-21 05:02:01+00	t	15	\N	\N	\N
256	2024-08-21 03:53:48+00	2024-08-21 05:02:01+00	t	15	\N	\N	\N
257	2024-08-21 03:53:48+00	2024-08-21 05:02:01+00	t	15	\N	\N	\N
249	2024-08-21 03:35:12+00	2024-08-21 05:49:20+00	t	10	\N	\N	\N
250	2024-08-21 03:35:22+00	2024-08-21 05:49:20+00	t	10	\N	\N	\N
285	2024-08-21 05:49:21+00	2024-08-21 12:43:23+00	t	10	\N	\N	\N
264	2024-08-21 03:56:41+00	2024-08-21 12:58:54+00	t	20	\N	\N	\N
265	2024-08-21 03:56:51+00	2024-08-21 12:58:54+00	t	20	\N	\N	\N
258	2024-08-21 03:56:21+00	2024-08-21 12:59:39+00	t	17	\N	\N	\N
259	2024-08-21 03:56:24+00	2024-08-21 12:59:39+00	t	17	\N	\N	\N
260	2024-08-21 03:56:25+00	2024-08-21 12:59:39+00	t	17	\N	\N	\N
261	2024-08-21 03:56:29+00	2024-08-21 12:59:39+00	t	17	\N	\N	\N
262	2024-08-21 03:56:33+00	2024-08-21 12:59:39+00	t	17	\N	\N	\N
263	2024-08-21 03:56:36+00	2024-08-21 12:59:39+00	t	17	\N	\N	\N
288	2024-08-21 11:37:49+00	2024-08-21 13:02:25+00	t	15	\N	\N	\N
295	2024-08-21 13:02:44+00	2024-08-21 13:02:53+00	t	14	\N	\N	\N
287	2024-08-21 08:17:45+00	2024-08-21 14:08:58+00	t	18	\N	\N	\N
286	2024-08-21 06:27:38+00	2024-08-21 14:27:19+00	t	19	\N	\N	\N
297	2024-08-22 03:44:06+00	\N	t	5	\N	\N	\N
298	2024-08-22 03:53:20+00	2024-08-22 03:53:34+00	t	16	\N	\N	\N
303	2024-08-22 04:39:30+00	\N	t	19	\N	\N	\N
304	2024-08-22 05:55:02+00	\N	t	20	\N	\N	\N
300	2024-08-22 03:56:30+00	2024-08-22 12:03:23+00	t	15	\N	\N	\N
301	2024-08-22 04:05:01+00	2024-08-22 12:03:27+00	t	14	\N	\N	\N
302	2024-08-22 04:05:42+00	2024-08-22 12:59:31+00	t	17	\N	\N	\N
305	2024-08-22 07:19:18+00	2024-08-22 13:18:12+00	t	18	\N	\N	\N
299	2024-08-22 03:53:35+00	2024-08-22 13:25:53+00	t	16	\N	\N	\N
296	2024-08-22 03:33:08+00	2024-08-22 14:02:20+00	t	10	\N	\N	\N
312	2024-08-23 04:05:07+00	\N	t	20	\N	\N	\N
314	2024-08-23 06:31:17+00	\N	t	19	\N	\N	\N
313	2024-08-23 04:05:43+00	2024-08-23 06:47:13+00	t	14	\N	\N	\N
310	2024-08-23 03:59:11+00	2024-08-23 06:50:24+00	t	15	\N	\N	\N
311	2024-08-23 04:04:02+00	2024-08-23 13:00:14+00	t	17	\N	\N	\N
308	2024-08-23 03:56:09+00	2024-08-23 13:03:55+00	t	16	\N	\N	\N
316	2024-08-23 10:10:24+00	2024-08-23 13:05:10+00	t	15	\N	\N	\N
309	2024-08-23 03:56:33+00	2024-08-23 13:05:40+00	t	5	\N	\N	\N
317	2024-08-23 10:10:25+00	2024-08-23 13:11:29+00	t	14	\N	\N	\N
315	2024-08-23 08:40:00+00	2024-08-23 13:18:43+00	t	18	\N	\N	\N
307	2024-08-23 03:54:20+00	2024-08-23 14:10:26+00	t	10	\N	\N	\N
321	2024-08-24 04:00:08+00	\N	t	17	\N	\N	\N
318	2024-08-24 02:54:36+00	2024-08-24 06:42:48+00	t	16	\N	\N	\N
326	2024-08-24 06:43:06+00	2024-08-24 06:43:07+00	t	16	\N	\N	\N
323	2024-08-24 04:01:29+00	2024-08-24 08:00:46+00	t	20	\N	\N	\N
322	2024-08-24 04:01:28+00	2024-08-24 08:01:20+00	t	14	\N	\N	\N
320	2024-08-24 03:56:12+00	2024-08-24 08:01:36+00	t	15	\N	\N	\N
319	2024-08-24 03:37:29+00	2024-08-24 08:01:44+00	t	10	\N	\N	\N
324	2024-08-24 04:05:20+00	2024-08-24 08:02:14+00	t	5	\N	\N	\N
327	2024-08-24 08:42:44+00	2024-08-24 13:35:37+00	t	18	\N	\N	\N
325	2024-08-24 06:00:00+00	2024-08-24 13:47:33+00	t	19	\N	\N	\N
332	2024-08-26 04:04:08+00	\N	t	20	\N	\N	\N
333	2024-08-26 04:09:43+00	\N	t	5	\N	\N	\N
330	2024-08-26 03:57:08+00	2024-08-26 09:37:36+00	t	15	\N	\N	\N
331	2024-08-26 04:01:35+00	2024-08-26 09:38:05+00	t	14	\N	\N	\N
328	2024-08-26 02:42:24+00	2024-08-26 13:57:47+00	t	10	\N	\N	\N
329	2024-08-26 03:22:56+00	2024-08-26 14:27:40+00	t	16	\N	\N	\N
334	2024-08-26 06:36:24+00	2024-08-26 14:39:08+00	t	19	\N	\N	\N
339	2024-08-27 03:56:03+00	\N	t	20	\N	\N	\N
340	2024-08-27 03:58:23+00	\N	t	5	\N	\N	\N
338	2024-08-27 03:54:46+00	2024-08-27 09:41:26+00	t	15	\N	\N	\N
336	2024-08-27 03:24:03+00	2024-08-27 14:00:02+00	t	10	\N	\N	\N
344	2024-08-27 07:24:51+00	2024-08-27 15:40:08+00	t	19	\N	\N	\N
346	2024-08-28 02:53:44+00	2024-08-28 13:01:33+00	t	15	\N	\N	\N
284	2024-08-21 03:47:15+00	2024-08-21 13:00:05+00	t	16	9:12	\N	\N
678	2024-09-28 08:08:35+00	2024-09-28 08:08:39+00	t	\N	0:0:4	\N	\N
735	2024-10-03 11:21:34+00	2024-10-03 15:11:56+00	t	18	3:50:22	\N	\N
700	2024-10-01 03:49:25+00	2024-10-01 14:06:05+00	t	16	10:16:40	\N	\N
687	2024-09-30 03:54:57+00	2024-09-30 03:55:00+00	t	\N	0:0:3	\N	\N
657	2024-09-26 04:46:34+00	\N	t	5	\N	Изучал обновление	#7551E9
645	2024-09-26 03:18:51+00	2024-09-26 05:35:14+00	t	10	2:16:23	okuw wagty	#7551E9
722	2024-10-02 10:58:09+00	2024-10-02 16:41:26+00	t	19	5:43:17	\N	\N
658	2024-09-26 05:43:19+00	2024-09-26 05:43:19+00	t	18	0:0:0	\N	\N
711	2024-10-01 11:22:20+00	2024-10-01 14:54:22+00	t	18	3:32:2	\N	\N
659	2024-09-26 05:44:03+00	2024-09-26 05:44:11+00	t	18	0:0:8	\N	\N
660	2024-09-26 08:32:30+00	\N	t	17	\N	Banka gitdim,pensiýa gaznasyna, naloga 	#7551E9
661	2024-09-26 09:58:04+00	2024-09-26 10:30:17+00	t	14	0:32:13	\N	\N
697	2024-10-01 03:06:11+00	2024-10-01 14:57:35+00	t	10	11:51:24	\N	\N
662	2024-09-26 09:58:04+00	2024-09-26 13:00:30+00	t	15	3:2:26	\N	\N
649	2024-09-26 03:55:44+00	2024-09-26 13:14:36+00	t	20	9:18:52	\N	\N
684	2024-09-30 03:31:16+00	2024-09-30 13:06:45+00	t	16	9:35:29	\N	\N
663	2024-09-26 11:19:01+00	2024-09-26 14:34:11+00	t	10	3:15:10	\N	\N
664	2024-09-26 11:19:26+00	2024-09-26 15:05:36+00	t	19	3:46:10	\N	\N
692	2024-09-30 04:16:59+00	2024-09-30 13:16:13+00	t	17	8:59:14	\N	\N
665	2024-09-26 11:40:46+00	2024-09-26 15:21:43+00	t	18	3:40:57	\N	\N
712	2024-10-01 11:56:14+00	2024-10-01 16:38:57+00	t	19	4:42:43	\N	\N
688	2024-09-30 03:55:14+00	2024-09-30 05:41:58+00	t	\N	1:46:44	\N	\N
689	2024-09-30 03:56:11+00	2024-09-30 13:33:20+00	t	20	9:37:9	\N	\N
713	2024-10-01 13:49:05+00	2024-10-01 13:49:06+00	t	\N	0:0:1	\N	\N
718	2024-10-02 03:52:14+00	\N	t	20	\N	\N	\N
695	2024-09-30 11:26:16+00	2024-09-30 15:17:15+00	t	18	3:50:59	\N	\N
696	2024-09-30 11:29:39+00	2024-09-30 15:29:07+00	t	10	3:59:28	\N	\N
668	2024-09-28 03:34:25+00	2024-09-28 05:34:30+00	t	10	2:0:5	okuw wagty	#E951BF
672	2024-09-28 04:24:42+00	2024-09-28 05:42:16+00	t	18	1:17:34	\N	\N
671	2024-09-28 04:00:35+00	2024-09-28 07:59:54+00	t	5	3:59:19	\N	\N
670	2024-09-28 03:52:45+00	2024-09-28 08:02:10+00	t	15	4:9:25	\N	\N
667	2024-09-28 03:34:15+00	2024-09-28 08:05:46+00	t	14	4:31:31	\N	\N
666	2024-09-28 03:15:40+00	2024-09-28 08:14:27+00	t	16	4:58:47	\N	\N
669	2024-09-28 03:45:19+00	2024-09-28 09:20:26+00	t	20	5:35:7	\N	\N
681	2024-09-28 11:32:17+00	2024-09-28 13:36:27+00	t	10	2:4:10	\N	\N
679	2024-09-28 09:45:02+00	2024-09-28 14:15:34+00	t	19	4:30:32	\N	\N
680	2024-09-28 11:28:53+00	2024-09-28 15:17:04+00	t	18	3:48:11	\N	\N
691	2024-09-30 04:07:26+00	\N	t	5	\N	\N	\N
683	2024-09-30 02:39:59+00	2024-09-30 05:31:56+00	t	10	2:51:57	\N	\N
690	2024-09-30 04:02:03+00	2024-09-30 05:45:41+00	t	18	1:43:38	\N	\N
685	2024-09-30 03:46:28+00	2024-09-30 08:38:09+00	t	14	4:51:41	REHAB 	#9FC2A5
686	2024-09-30 03:49:59+00	2024-09-30 08:38:17+00	t	15	4:48:18	\N	\N
694	2024-09-30 11:09:15+00	\N	t	19	\N	\N	\N
714	2024-10-02 03:20:52+00	2024-10-02 05:35:26+00	t	10	2:14:34	\N	\N
721	2024-10-02 05:22:16+00	2024-10-02 05:48:55+00	t	18	0:26:39	\N	\N
699	2024-10-01 03:45:17+00	2024-10-01 05:28:36+00	t	14	1:43:19	arkadag	#9FC2A5
720	2024-10-02 04:13:17+00	2024-10-02 09:21:17+00	t	5	5:8:0	\N	\N
702	2024-10-01 03:58:39+00	2024-10-01 05:39:07+00	t	18	1:40:28	\N	\N
698	2024-10-01 03:43:59+00	2024-10-01 08:58:02+00	t	15	5:14:3	\N	\N
717	2024-10-02 03:49:39+00	2024-10-02 09:51:23+00	t	15	6:1:44	\N	\N
709	2024-10-01 08:57:51+00	2024-10-01 10:09:58+00	t	14	1:12:7	fiz	#9FC2A5
715	2024-10-02 03:43:38+00	2024-10-02 09:51:53+00	t	14	6:8:15	\N	\N
710	2024-10-01 10:10:40+00	2024-10-01 10:10:41+00	t	15	0:0:1	\N	\N
705	2024-10-01 04:11:11+00	2024-10-01 13:01:15+00	t	5	8:50:4	\N	\N
704	2024-10-01 04:01:36+00	2024-10-01 13:03:26+00	t	17	\N	\N	\N
703	2024-10-01 04:01:35+00	2024-10-01 13:03:26+00	t	17	9:1:51	\N	\N
701	2024-10-01 03:57:45+00	2024-10-01 13:07:28+00	t	20	9:9:43	\N	\N
732	2024-10-03 04:06:43+00	2024-10-03 05:42:47+00	t	18	1:36:4	\N	\N
719	2024-10-02 03:52:59+00	2024-10-02 13:01:06+00	t	17	9:8:7	\N	\N
728	2024-10-03 03:43:48+00	2024-10-03 13:00:03+00	t	14	9:16:15	\N	\N
716	2024-10-02 03:44:17+00	2024-10-02 13:52:38+00	t	16	10:8:21	\N	\N
724	2024-10-02 12:37:26+00	2024-10-02 15:03:39+00	t	10	2:26:13	bellemek yatdan cykdy	#7551E9
727	2024-10-03 03:42:07+00	2024-10-03 13:01:08+00	t	16	9:19:1	\N	\N
723	2024-10-02 11:26:27+00	2024-10-02 15:14:57+00	t	18	3:48:30	irden jogaply 	#E951BF
733	2024-10-03 04:16:16+00	2024-10-03 13:01:51+00	t	5	8:45:35	\N	\N
740	2024-10-04 03:57:59+00	\N	t	20	\N	\N	\N
729	2024-10-03 03:45:01+00	2024-10-03 13:08:08+00	t	15	9:23:7	\N	\N
731	2024-10-03 03:52:21+00	2024-10-03 13:10:20+00	t	17	9:17:59	\N	\N
742	2024-10-04 04:18:47+00	\N	t	5	\N	\N	\N
730	2024-10-03 03:52:09+00	2024-10-03 13:23:06+00	t	20	9:30:57	\N	\N
739	2024-10-04 03:56:47+00	2024-10-04 10:44:30+00	t	17	6:47:43	Agentlige lisenziýadan habar tutmaly	#7551E9
726	2024-10-03 02:41:22+00	2024-10-03 14:51:50+00	t	10	12:10:28	\N	\N
741	2024-10-04 04:09:30+00	2024-10-04 05:43:48+00	t	18	1:34:18	\N	\N
734	2024-10-03 11:09:24+00	2024-10-03 14:57:03+00	t	19	3:47:39	\N	\N
737	2024-10-04 03:28:13+00	2024-10-04 09:26:35+00	t	14	5:58:22	fiz	#9FC2A5
743	2024-10-04 07:07:07+00	2024-10-04 09:26:51+00	t	15	2:19:44	\N	\N
738	2024-10-04 03:55:08+00	2024-10-04 13:37:54+00	t	16	9:42:46	\N	\N
744	2024-10-04 10:48:02+00	2024-10-04 13:00:44+00	t	15	2:12:42	\N	\N
746	2024-10-04 11:12:49+00	2024-10-04 14:24:21+00	t	19	3:11:32	\N	\N
745	2024-10-04 10:48:25+00	2024-10-04 13:00:51+00	t	14	2:12:26	\N	\N
736	2024-10-04 03:25:33+00	2024-10-04 14:03:55+00	t	10	10:38:22	\N	\N
747	2024-10-04 11:27:33+00	2024-10-04 15:19:33+00	t	18	3:52:0	\N	\N
748	2024-10-05 03:07:08+00	2024-10-05 05:37:45+00	t	10	2:30:37	\N	\N
755	2024-10-05 04:23:23+00	2024-10-05 05:48:23+00	t	18	1:25:0	\N	\N
754	2024-10-05 03:59:00+00	2024-10-05 07:43:01+00	t	17	3:44:1	\N	\N
751	2024-10-05 03:47:48+00	2024-10-05 08:00:31+00	t	5	4:12:43	\N	\N
750	2024-10-05 03:47:26+00	2024-10-05 08:01:49+00	t	15	4:14:23	\N	\N
753	2024-10-05 03:57:48+00	2024-10-05 08:02:18+00	t	14	4:4:30	\N	\N
752	2024-10-05 03:57:22+00	2024-10-05 08:07:29+00	t	20	4:10:7	\N	\N
749	2024-10-05 03:43:20+00	2024-10-05 08:23:46+00	t	16	4:40:26	\N	\N
758	2024-10-05 11:31:48+00	2024-10-05 13:34:40+00	t	10	2:2:52	\N	\N
757	2024-10-05 11:28:19+00	2024-10-05 13:44:59+00	t	18	2:16:40	\N	\N
756	2024-10-05 11:21:56+00	2024-10-05 14:06:20+00	t	19	2:44:24	\N	\N
655	2024-09-26 04:22:12+00	2024-09-26 04:22:13+00	t	\N	0:0:1	\N	\N
759	2024-10-08 03:08:33+00	2024-10-08 13:16:28+00	t	16	10:7:55	\N	\N
682	2024-09-28 11:45:56+00	\N	t	\N	\N	\N	\N
801	2024-10-12 03:56:11+00	2024-10-12 08:01:40+00	t	5	4:5:29	\N	\N
762	2024-10-08 03:54:20+00	2024-10-08 04:50:03+00	t	5	0:55:43	Уехал в травму, потом институт.	#7551E9
798	2024-10-12 03:47:40+00	2024-10-12 08:01:41+00	t	17	4:14:1	\N	\N
766	2024-10-08 04:05:55+00	2024-10-08 05:41:39+00	t	18	1:35:44	\N	\N
800	2024-10-12 03:56:04+00	2024-10-12 08:09:33+00	t	20	4:13:29	\N	\N
764	2024-10-08 04:01:00+00	2024-10-08 09:11:28+00	t	17	5:10:28	Agentlige lisenziýa üçin	#7551E9
761	2024-10-08 03:47:44+00	2024-10-08 10:00:56+00	t	15	6:13:12	\N	\N
765	2024-10-08 04:05:37+00	2024-10-08 10:01:09+00	t	14	5:55:32	\N	\N
799	2024-10-12 03:49:15+00	2024-10-12 08:30:50+00	t	16	4:41:35	\N	\N
763	2024-10-08 04:00:28+00	2024-10-08 13:12:38+00	t	20	9:12:10	\N	\N
760	2024-10-08 03:33:05+00	2024-10-08 14:25:37+00	t	10	10:52:32	\N	\N
803	2024-10-12 11:16:14+00	\N	t	19	\N	\N	\N
768	2024-10-08 11:27:47+00	2024-10-08 14:55:52+00	t	18	3:28:5	\N	\N
767	2024-10-08 10:56:59+00	2024-10-08 15:27:46+00	t	19	4:30:47	\N	\N
772	2024-10-09 04:01:35+00	\N	t	14	\N	\N	\N
773	2024-10-09 04:02:28+00	\N	t	15	\N	\N	\N
797	2024-10-12 03:20:22+00	2024-10-12 14:05:27+00	t	10	10:45:5	\N	\N
775	2024-10-09 04:12:41+00	2024-10-09 11:54:31+00	t	18	7:41:50	\N	\N
827	2024-10-16 04:37:25+00	2024-10-16 05:57:04+00	t	18	1:19:39	\N	\N
770	2024-10-09 03:31:48+00	2024-10-09 12:57:07+00	t	16	9:25:19	\N	\N
804	2024-10-12 14:20:39+00	2024-10-12 15:07:13+00	t	18	0:46:34	unutdym	#7551E9
778	2024-10-09 12:57:14+00	2024-10-09 13:01:03+00	t	16	0:3:49	Yalnysh belledim	#FF9E58
771	2024-10-09 03:49:30+00	2024-10-09 13:01:48+00	t	20	9:12:18	\N	\N
777	2024-10-09 12:54:55+00	2024-10-09 13:01:54+00	t	5	0:6:59	\N	\N
807	2024-10-14 03:55:43+00	\N	t	20	\N	\N	\N
774	2024-10-09 04:07:10+00	2024-10-09 13:02:05+00	t	17	8:54:55	\N	\N
779	2024-10-09 13:02:06+00	2024-10-09 13:02:09+00	t	17	0:0:3	\N	\N
769	2024-10-09 03:24:55+00	2024-10-09 14:57:35+00	t	10	11:32:40	\N	\N
833	2024-10-17 03:59:37+00	2024-10-17 13:04:10+00	t	5	9:4:33	\N	\N
776	2024-10-09 11:54:33+00	2024-10-09 15:13:01+00	t	18	3:18:28	bellemegi unutdym 	#FF9E58
784	2024-10-10 04:11:29+00	2024-10-10 05:51:19+00	t	18	1:39:50	\N	\N
808	2024-10-14 04:01:24+00	\N	t	5	\N	Уехал в акйол	#7551E9
783	2024-10-10 04:10:29+00	2024-10-10 12:57:12+00	t	17	8:46:43	\N	\N
785	2024-10-10 04:12:05+00	2024-10-10 13:00:26+00	t	5	8:48:21	\N	\N
810	2024-10-14 04:16:23+00	2024-10-14 05:52:58+00	t	18	1:36:35	\N	\N
781	2024-10-10 03:16:58+00	2024-10-10 13:01:29+00	t	16	9:44:31	\N	\N
811	2024-10-14 11:17:29+00	\N	t	19	\N	\N	\N
782	2024-10-10 03:58:29+00	2024-10-10 13:04:41+00	t	20	9:6:12	\N	\N
780	2024-10-10 03:14:22+00	2024-10-10 14:03:49+00	t	10	10:49:27	\N	\N
787	2024-10-10 11:30:30+00	2024-10-10 14:41:26+00	t	19	3:10:56	\N	\N
806	2024-10-14 03:55:37+00	2024-10-14 13:17:10+00	t	17	9:21:33	\N	\N
786	2024-10-10 11:26:19+00	2024-10-10 14:45:27+00	t	18	3:19:8	\N	\N
789	2024-10-11 04:01:11+00	\N	t	17	\N	\N	\N
790	2024-10-11 04:01:17+00	\N	t	5	\N	\N	\N
852	2024-10-19 03:59:29+00	2024-10-19 08:01:30+00	t	5	4:2:1	\N	\N
805	2024-10-14 03:25:59+00	2024-10-14 14:15:36+00	t	10	10:49:37	\N	\N
793	2024-10-11 04:27:07+00	2024-10-11 05:50:16+00	t	18	1:23:9	\N	\N
828	2024-10-16 06:30:02+00	2024-10-16 12:52:21+00	t	17	6:22:19	Zähmet we ilaty goramak min. Agamuradow 	#7551E9
794	2024-10-11 07:46:48+00	2024-10-11 08:53:29+00	t	15	1:6:41	\N	\N
812	2024-10-14 11:26:11+00	2024-10-14 15:20:37+00	t	18	3:54:26	\N	\N
792	2024-10-11 04:12:13+00	2024-10-11 13:03:12+00	t	16	8:50:59	Yollar probka 8:35 taxi mundim	#7551E9
831	2024-10-17 03:37:49+00	2024-10-17 14:44:46+00	t	10	11:6:57	\N	\N
791	2024-10-11 04:09:55+00	2024-10-11 13:06:23+00	t	20	8:56:28	\N	\N
809	2024-10-14 04:05:17+00	2024-10-14 15:23:54+00	t	16	11:18:37	Polisiya saklady yolda	#7551E9
795	2024-10-11 11:25:25+00	2024-10-11 15:03:12+00	t	18	3:37:47	\N	\N
788	2024-10-11 03:14:01+00	2024-10-11 15:14:52+00	t	10	12:0:51	\N	\N
796	2024-10-11 11:42:48+00	2024-10-11 15:38:52+00	t	19	3:56:4	\N	\N
802	2024-10-12 05:45:05+00	2024-10-12 05:45:34+00	t	18	0:0:29	irden bellemegi unutdym 	#7551E9
826	2024-10-16 04:00:36+00	2024-10-16 13:01:39+00	t	5	9:1:3	\N	\N
819	2024-10-15 04:24:35+00	\N	t	15	\N	\N	\N
848	2024-10-18 15:05:01+00	2024-10-18 15:05:03+00	t	19	0:0:2	\N	\N
824	2024-10-16 03:48:53+00	2024-10-16 14:01:42+00	t	16	10:12:49	\N	\N
838	2024-10-17 11:41:07+00	2024-10-17 15:18:30+00	t	19	3:37:23	\N	\N
815	2024-10-15 03:51:03+00	2024-10-15 04:29:39+00	t	14	0:38:36	Fiz	#9FC2A5
825	2024-10-16 03:58:23+00	2024-10-16 14:01:55+00	t	20	10:3:32	\N	\N
820	2024-10-15 04:26:58+00	2024-10-15 05:36:18+00	t	18	1:9:20	\N	\N
846	2024-10-18 07:31:10+00	2024-10-18 10:26:42+00	t	17	2:55:32	Agentlige lisenziýany soramaly	#7551E9
818	2024-10-15 04:03:35+00	2024-10-15 12:59:45+00	t	17	8:56:10	\N	\N
823	2024-10-16 03:28:42+00	2024-10-16 14:17:04+00	t	10	10:48:22	\N	\N
817	2024-10-15 04:03:05+00	2024-10-15 13:01:37+00	t	5	8:58:32	\N	\N
837	2024-10-17 11:27:20+00	2024-10-17 15:23:50+00	t	18	3:56:30	\N	\N
814	2024-10-15 03:48:42+00	2024-10-15 13:04:53+00	t	16	9:16:11	\N	\N
829	2024-10-16 11:19:47+00	2024-10-16 15:25:23+00	t	18	4:5:36	\N	\N
816	2024-10-15 03:53:18+00	2024-10-15 13:05:38+00	t	20	9:12:20	\N	\N
813	2024-10-15 03:26:27+00	2024-10-15 13:42:48+00	t	10	10:16:21	\N	\N
830	2024-10-16 11:57:34+00	2024-10-16 15:53:43+00	t	19	3:56:9	\N	\N
821	2024-10-15 11:23:43+00	2024-10-15 15:15:30+00	t	18	3:51:47	\N	\N
822	2024-10-15 12:48:10+00	2024-10-15 15:32:50+00	t	19	2:44:40	\N	\N
832	2024-10-17 03:48:47+00	\N	t	20	\N	\N	\N
834	2024-10-17 04:08:29+00	2024-10-17 05:48:56+00	t	18	1:40:27	\N	\N
836	2024-10-17 06:03:36+00	2024-10-17 12:48:36+00	t	17	6:45:0	Migrasiýa gitdim	#7551E9
835	2024-10-17 04:11:52+00	2024-10-17 13:01:02+00	t	16	8:49:10	\N	\N
853	2024-10-19 03:59:52+00	2024-10-19 07:15:38+00	t	17	3:15:46	\N	\N
841	2024-10-18 03:56:43+00	2024-10-18 13:01:43+00	t	5	9:5:0	\N	\N
843	2024-10-18 04:27:59+00	\N	t	10	\N	internet ishlemedi	#E951BF
847	2024-10-18 11:25:56+00	2024-10-18 15:26:23+00	t	18	4:0:27	\N	\N
842	2024-10-18 04:16:08+00	2024-10-18 05:50:20+00	t	18	1:34:12	\N	\N
839	2024-10-18 03:38:07+00	2024-10-18 13:02:34+00	t	16	9:24:27	\N	\N
849	2024-10-19 03:11:18+00	\N	t	10	\N	\N	\N
840	2024-10-18 03:53:27+00	2024-10-18 13:48:47+00	t	20	9:55:20	\N	\N
854	2024-10-19 04:20:31+00	2024-10-19 05:48:40+00	t	18	1:28:9	\N	\N
851	2024-10-19 03:57:53+00	2024-10-19 08:00:32+00	t	20	4:2:39	\N	\N
850	2024-10-19 03:31:02+00	2024-10-19 08:14:01+00	t	16	4:42:59	\N	\N
855	2024-10-19 11:25:02+00	2024-10-19 14:12:25+00	t	18	2:47:23	\N	\N
856	2024-10-19 11:57:49+00	2024-10-19 15:12:36+00	t	19	3:14:47	\N	\N
858	2024-10-21 03:28:54+00	2024-10-21 05:39:56+00	t	10	2:11:2	rugsatly doglan gun bar. okuwdan song gelemok	#7551E9
861	2024-10-21 04:22:07+00	2024-10-21 05:49:32+00	t	18	1:27:25	\N	\N
859	2024-10-21 03:40:59+00	2024-10-21 12:44:06+00	t	17	9:3:7	\N	\N
865	2024-10-21 12:50:02+00	2024-10-21 13:00:34+00	t	5	0:10:32	159 207	#7551E9
860	2024-10-21 03:58:22+00	2024-10-21 13:45:37+00	t	20	9:47:15	\N	\N
857	2024-10-21 03:18:33+00	2024-10-21 14:12:06+00	t	16	10:53:33	\N	\N
863	2024-10-21 11:14:45+00	2024-10-21 14:18:36+00	t	19	3:3:51	\N	\N
864	2024-10-21 11:28:09+00	2024-10-21 14:40:54+00	t	18	3:12:45	\N	\N
845	2024-10-18 04:31:17+00	\N	t	\N	\N	\N	\N
867	2024-10-22 03:24:10+00	2024-10-22 15:10:08+00	t	10	11:45:58	\N	\N
871	2024-10-22 04:20:53+00	2024-10-22 05:47:47+00	t	18	1:26:54	\N	\N
868	2024-10-22 03:56:21+00	2024-10-22 12:47:42+00	t	17	8:51:21	\N	\N
907	2024-10-26 11:22:22+00	2024-10-26 15:06:24+00	t	19	3:44:2	\N	\N
870	2024-10-22 04:00:39+00	2024-10-22 13:01:56+00	t	5	9:1:17	\N	\N
892	2024-10-24 13:30:25+00	2024-10-24 13:30:26+00	t	\N	0:0:1	\N	\N
866	2024-10-22 03:18:34+00	2024-10-22 13:53:38+00	t	16	10:35:4	\N	\N
869	2024-10-22 03:58:59+00	2024-10-22 13:58:40+00	t	20	9:59:41	\N	\N
872	2024-10-22 11:08:13+00	2024-10-22 14:59:28+00	t	19	3:51:15	\N	\N
873	2024-10-22 11:32:40+00	2024-10-22 15:15:05+00	t	18	3:42:25	\N	\N
879	2024-10-23 04:04:14+00	\N	t	20	\N	\N	\N
877	2024-10-23 03:57:08+00	2024-10-23 05:30:25+00	t	10	1:33:17	okuw wagty	#7551E9
955	2024-11-02 03:51:01+00	2024-11-02 05:47:26+00	t	18	1:56:25	\N	\N
880	2024-10-23 04:11:50+00	2024-10-23 05:48:56+00	t	18	1:37:6	\N	\N
914	2024-10-28 04:34:46+00	2024-10-28 05:51:05+00	t	18	1:16:19	\N	\N
878	2024-10-23 03:57:57+00	2024-10-23 12:52:11+00	t	17	8:54:14	\N	\N
949	2024-11-01 04:13:56+00	2024-11-01 05:46:52+00	t	18	1:32:56	\N	\N
881	2024-10-23 04:23:09+00	2024-10-23 13:00:59+00	t	5	8:37:50	\N	\N
932	2024-10-30 13:01:03+00	2024-10-30 13:01:05+00	t	5	0:0:2	2.30	#7551E9
876	2024-10-23 03:42:44+00	2024-10-23 13:08:56+00	t	16	9:26:12	\N	\N
912	2024-10-28 03:57:41+00	2024-10-28 10:22:11+00	t	17	6:24:30	Agentlige gitdim	#7551E9
884	2024-10-23 11:28:04+00	2024-10-23 14:25:19+00	t	18	2:57:15	\N	\N
883	2024-10-23 11:24:22+00	2024-10-23 14:46:52+00	t	10	3:22:30	\N	\N
882	2024-10-23 11:01:36+00	2024-10-23 16:02:12+00	t	19	5:0:36	\N	\N
885	2024-10-24 03:12:34+00	\N	t	10	\N	\N	\N
958	2024-11-02 11:25:50+00	2024-11-02 13:54:08+00	t	18	2:28:18	\N	\N
890	2024-10-24 04:25:02+00	2024-10-24 05:55:03+00	t	18	1:30:1	\N	\N
913	2024-10-28 03:57:59+00	2024-10-28 13:00:21+00	t	16	9:2:22	\N	\N
889	2024-10-24 03:58:48+00	2024-10-24 12:48:11+00	t	17	8:49:23	\N	\N
926	2024-10-30 03:17:47+00	2024-10-30 14:23:44+00	t	10	11:5:57	\N	\N
886	2024-10-24 03:45:13+00	2024-10-24 13:00:22+00	t	5	9:15:9	\N	\N
911	2024-10-28 03:57:15+00	2024-10-28 13:02:03+00	t	5	9:4:48	\N	\N
953	2024-11-02 03:30:47+00	2024-11-02 08:16:01+00	t	16	4:45:14	\N	\N
888	2024-10-24 03:56:37+00	2024-10-24 13:49:30+00	t	20	9:52:53	\N	\N
910	2024-10-28 03:56:54+00	2024-10-28 14:05:13+00	t	20	10:8:19	\N	\N
887	2024-10-24 03:54:20+00	2024-10-24 14:04:39+00	t	16	10:10:19	\N	\N
931	2024-10-30 11:33:06+00	2024-10-30 14:52:32+00	t	18	3:19:26	\N	\N
891	2024-10-24 11:28:51+00	2024-10-24 15:41:35+00	t	18	4:12:44	\N	\N
909	2024-10-28 03:00:04+00	2024-10-28 15:00:09+00	t	10	12:0:5	\N	\N
895	2024-10-25 03:39:15+00	2024-10-25 05:49:19+00	t	18	2:10:4	\N	\N
916	2024-10-28 11:23:30+00	2024-10-28 15:41:15+00	t	18	4:17:45	\N	\N
899	2024-10-25 04:03:01+00	2024-10-25 09:09:49+00	t	17	5:6:48	Agentlige dokument	#7551E9
915	2024-10-28 10:56:01+00	2024-10-28 16:02:31+00	t	19	5:6:30	\N	\N
897	2024-10-25 03:57:18+00	2024-10-25 13:02:29+00	t	5	9:5:11	\N	\N
917	2024-10-29 03:04:20+00	\N	t	10	\N	\N	\N
896	2024-10-25 03:51:29+00	2024-10-25 14:06:18+00	t	16	10:14:49	\N	\N
901	2024-10-25 14:06:54+00	2024-10-25 14:07:40+00	t	20	0:0:46	Stomatologiýa gitdim, 11:45 geldim.	#7551E9
894	2024-10-25 03:21:46+00	2024-10-25 15:04:33+00	t	10	11:42:47	\N	\N
900	2024-10-25 11:31:46+00	2024-10-25 15:33:01+00	t	18	4:1:15	\N	\N
906	2024-10-26 05:49:37+00	2024-10-26 05:49:59+00	t	18	0:0:22	irden bellemegi unutdym	#7551E9
903	2024-10-26 03:47:52+00	2024-10-26 07:57:47+00	t	17	4:9:55	\N	\N
936	2024-10-31 03:59:42+00	\N	t	20	\N	\N	\N
904	2024-10-26 03:50:13+00	2024-10-26 08:00:04+00	t	20	4:9:51	\N	\N
893	2024-10-24 13:30:50+00	\N	t	\N	\N	\N	\N
905	2024-10-26 03:50:53+00	2024-10-26 10:22:59+00	t	16	6:32:6	\N	\N
902	2024-10-26 03:15:45+00	2024-10-26 14:36:35+00	t	10	11:20:50	\N	\N
922	2024-10-29 04:49:12+00	2024-10-29 05:49:42+00	t	18	1:0:30	\N	\N
908	2024-10-26 11:24:42+00	2024-10-26 15:01:56+00	t	18	3:37:14	\N	\N
947	2024-11-01 04:13:31+00	2024-11-01 10:39:54+00	t	17	6:26:23	Agentlige	#7551E9
920	2024-10-29 04:43:55+00	2024-10-29 10:19:23+00	t	17	5:35:28	Agentlige tablisa	#7551E9
938	2024-10-31 04:17:40+00	2024-10-31 05:50:28+00	t	18	1:32:48	\N	\N
921	2024-10-29 04:44:17+00	2024-10-29 13:00:08+00	t	5	8:15:51	\N	\N
918	2024-10-29 04:40:55+00	2024-10-29 13:15:31+00	t	16	8:34:36	\N	\N
919	2024-10-29 04:41:02+00	2024-10-29 13:36:00+00	t	20	8:54:58	08:57 de geldim, emma CRM işlemedi	#FF9E58
940	2024-10-31 12:18:53+00	2024-10-31 12:18:55+00	t	26	0:0:2	\N	\N
925	2024-10-29 12:21:08+00	2024-10-29 15:19:12+00	t	18	2:58:4	16:35 de geldim	#7551E9
924	2024-10-29 11:19:06+00	2024-10-29 15:45:58+00	t	19	4:26:52	\N	\N
928	2024-10-30 03:55:03+00	\N	t	20	\N	\N	\N
930	2024-10-30 04:21:47+00	2024-10-30 05:51:06+00	t	18	1:29:19	\N	\N
941	2024-10-31 12:18:56+00	2024-10-31 12:18:57+00	t	26	0:0:1	\N	\N
929	2024-10-30 04:03:56+00	2024-10-30 12:58:15+00	t	17	8:54:19	\N	\N
927	2024-10-30 03:46:55+00	2024-10-30 13:00:21+00	t	16	9:13:26	\N	\N
965	2024-11-04 04:21:11+00	2024-11-04 11:21:37+00	t	18	7:0:26	okuwa giden wagty unutdym	#7551E9
945	2024-11-01 03:54:19+00	2024-11-01 13:00:55+00	t	20	9:6:36	\N	\N
937	2024-10-31 04:00:29+00	2024-10-31 12:46:26+00	t	17	8:45:57	\N	\N
956	2024-11-02 03:59:22+00	2024-11-02 08:33:56+00	t	20	4:34:34	\N	\N
934	2024-10-31 03:31:39+00	2024-10-31 13:00:43+00	t	16	9:29:4	\N	\N
950	2024-11-01 10:59:59+00	2024-11-01 13:53:28+00	t	19	2:53:29	\N	\N
935	2024-10-31 03:57:49+00	2024-10-31 13:04:00+00	t	5	9:6:11	\N	\N
952	2024-11-02 03:25:29+00	2024-11-02 14:01:23+00	t	10	10:35:54	\N	\N
933	2024-10-31 02:56:44+00	2024-10-31 14:44:03+00	t	10	11:47:19	\N	\N
943	2024-11-01 03:19:41+00	2024-11-01 14:46:16+00	t	10	11:26:35	\N	\N
939	2024-10-31 11:32:48+00	2024-10-31 14:56:39+00	t	18	3:23:51	\N	\N
944	2024-11-01 03:28:35+00	\N	t	16	\N	\N	\N
946	2024-11-01 03:57:08+00	\N	t	5	\N	\N	\N
954	2024-11-02 03:48:44+00	2024-11-02 09:25:36+00	t	5	5:36:52	\N	\N
951	2024-11-01 11:23:24+00	2024-11-01 14:57:58+00	t	18	3:34:34	\N	\N
960	2024-11-04 03:15:02+00	\N	t	10	\N	\N	\N
957	2024-11-02 04:15:00+00	2024-11-02 09:30:20+00	t	17	5:15:20	\N	\N
959	2024-11-02 11:35:09+00	\N	t	19	\N	\N	\N
964	2024-11-04 04:07:21+00	2024-11-04 12:56:35+00	t	17	8:49:14	\N	\N
961	2024-11-04 04:00:01+00	2024-11-04 13:04:10+00	t	5	9:4:9	\N	\N
963	2024-11-04 04:07:11+00	2024-11-04 13:21:04+00	t	20	9:13:53	\N	\N
962	2024-11-04 04:05:22+00	2024-11-04 14:11:39+00	t	16	10:6:17	\N	\N
967	2024-11-04 11:21:39+00	2024-11-04 14:47:08+00	t	18	3:25:29	\N	\N
966	2024-11-04 11:19:02+00	2024-11-04 14:51:54+00	t	19	3:32:52	\N	\N
969	2024-11-05 03:27:28+00	\N	t	10	\N	\N	\N
970	2024-11-05 04:00:09+00	\N	t	17	\N	\N	\N
972	2024-11-05 04:24:53+00	2024-11-05 05:50:06+00	t	18	1:25:13	\N	\N
973	2024-11-05 06:44:44+00	\N	t	20	\N	Taze Markede gidildi	#7551E9
971	2024-11-05 04:02:52+00	2024-11-05 13:00:59+00	t	5	8:58:7	\N	\N
968	2024-11-05 02:46:46+00	2024-11-05 13:18:58+00	t	16	10:32:12	\N	\N
975	2024-11-05 11:19:21+00	2024-11-05 14:44:55+00	t	18	3:25:34	\N	\N
974	2024-11-05 11:08:56+00	2024-11-05 15:37:35+00	t	19	4:28:39	\N	\N
874	2024-10-22 13:34:40+00	2024-10-22 13:34:41+00	t	\N	0:0:1	\N	\N
977	2024-11-06 03:16:23+00	2024-11-06 15:04:57+00	t	10	11:48:34	\N	\N
898	2024-10-25 04:01:36+00	2024-10-25 04:01:38+00	t	\N	0:0:2	\N	\N
980	2024-11-06 04:05:52+00	\N	t	17	\N	\N	\N
981	2024-11-06 04:31:50+00	2024-11-06 05:51:42+00	t	18	1:19:52	\N	\N
1019	2024-11-12 04:10:07+00	2024-11-12 14:37:20+00	t	10	10:27:13	bellemegi unutdum	#7551E9
979	2024-11-06 03:59:59+00	2024-11-06 13:00:36+00	t	5	9:0:37	\N	\N
976	2024-11-06 02:54:20+00	2024-11-06 13:03:39+00	t	16	10:9:19	\N	\N
978	2024-11-06 03:55:47+00	2024-11-06 13:26:49+00	t	20	9:31:2	\N	\N
1043	2024-11-15 11:24:49+00	2024-11-15 15:17:46+00	t	18	3:52:57	\N	\N
982	2024-11-06 11:29:00+00	2024-11-06 15:28:00+00	t	19	3:59:0	\N	\N
1021	2024-11-12 11:24:39+00	2024-11-12 15:35:03+00	t	18	4:10:24	\N	\N
988	2024-11-07 04:22:41+00	2024-11-07 05:43:41+00	t	18	1:21:0	\N	\N
987	2024-11-07 04:04:11+00	2024-11-07 12:55:41+00	t	17	8:51:30	\N	\N
1023	2024-11-13 03:57:09+00	\N	t	20	\N	\N	\N
986	2024-11-07 03:59:39+00	2024-11-07 13:01:12+00	t	5	9:1:33	\N	\N
983	2024-11-07 03:21:14+00	2024-11-07 13:14:03+00	t	16	9:52:49	\N	\N
1025	2024-11-13 04:04:18+00	\N	t	5	\N	\N	\N
985	2024-11-07 03:58:39+00	2024-11-07 13:19:43+00	t	20	9:21:4	\N	\N
990	2024-11-07 11:31:50+00	2024-11-07 14:49:36+00	t	19	3:17:46	\N	\N
984	2024-11-07 03:24:47+00	2024-11-07 14:53:31+00	t	10	11:28:44	\N	\N
989	2024-11-07 11:26:24+00	2024-11-07 15:30:18+00	t	18	4:3:54	\N	\N
1039	2024-11-15 03:29:58+00	2024-11-15 15:43:33+00	t	10	12:13:35	\N	\N
1046	2024-11-16 03:24:16+00	\N	t	10	\N	\N	\N
995	2024-11-08 04:15:53+00	2024-11-08 11:26:40+00	t	18	7:10:47	unutdym 	#7551E9
1027	2024-11-13 04:52:21+00	2024-11-13 05:46:58+00	t	18	0:54:37	Talyplar saglyk oyune gitdim	#7551E9
993	2024-11-08 03:58:33+00	2024-11-08 12:55:16+00	t	17	8:56:43	\N	\N
1024	2024-11-13 03:59:04+00	2024-11-13 13:03:35+00	t	17	9:4:31	\N	\N
996	2024-11-08 04:17:56+00	2024-11-08 13:03:33+00	t	5	8:45:37	\N	\N
1048	2024-11-16 04:06:45+00	\N	t	20	\N	\N	\N
994	2024-11-08 04:00:33+00	2024-11-08 13:17:56+00	t	16	9:17:23	\N	\N
1022	2024-11-13 03:15:14+00	2024-11-13 13:04:30+00	t	16	9:49:16	\N	\N
992	2024-11-08 03:52:53+00	2024-11-08 13:26:24+00	t	20	9:33:31	\N	\N
998	2024-11-08 11:29:06+00	2024-11-08 14:12:52+00	t	19	2:43:46	\N	\N
1026	2024-11-13 04:08:08+00	2024-11-13 14:01:02+00	t	10	9:52:54	Talyp saglyk oyune gidildi. shonung ucin gija galdym	#7551E9
991	2024-11-08 03:23:24+00	2024-11-08 14:59:00+00	t	10	11:35:36	\N	\N
997	2024-11-08 11:26:51+00	2024-11-08 15:10:26+00	t	18	3:43:35	\N	\N
1000	2024-11-09 03:42:50+00	\N	t	20	\N	\N	\N
1002	2024-11-09 03:58:59+00	\N	t	17	\N	\N	\N
1028	2024-11-13 11:58:37+00	2024-11-13 15:08:21+00	t	19	3:9:44	\N	\N
1004	2024-11-09 04:41:14+00	2024-11-09 05:48:54+00	t	18	1:7:40	\N	\N
1003	2024-11-09 04:01:43+00	2024-11-09 08:06:11+00	t	5	4:4:28	\N	\N
1001	2024-11-09 03:55:10+00	2024-11-09 08:18:04+00	t	16	4:22:54	\N	\N
1031	2024-11-14 03:51:38+00	\N	t	20	\N	\N	\N
999	2024-11-09 03:35:12+00	2024-11-09 14:39:01+00	t	10	11:3:49	\N	\N
1006	2024-11-09 11:22:07+00	2024-11-09 14:51:11+00	t	18	3:29:4	\N	\N
1005	2024-11-09 11:09:27+00	2024-11-09 15:24:45+00	t	19	4:15:18	\N	\N
1011	2024-11-11 04:09:34+00	\N	t	17	\N	\N	\N
1012	2024-11-11 04:19:57+00	2024-11-11 05:32:54+00	t	18	1:12:57	\N	\N
1013	2024-11-11 11:27:04+00	\N	t	19	\N	\N	\N
1007	2024-11-11 02:28:03+00	2024-11-11 13:01:56+00	t	16	10:33:53	\N	\N
1034	2024-11-14 04:17:59+00	2024-11-14 05:47:06+00	t	18	1:29:7	\N	\N
1010	2024-11-11 04:06:17+00	2024-11-11 13:02:35+00	t	5	8:56:18	\N	\N
1008	2024-11-11 03:54:50+00	2024-11-11 13:20:53+00	t	20	9:26:3	\N	\N
1009	2024-11-11 03:59:36+00	2024-11-11 14:41:48+00	t	10	10:42:12	\N	\N
1030	2024-11-14 03:44:14+00	2024-11-14 13:00:03+00	t	16	9:15:49	\N	\N
1014	2024-11-11 11:48:14+00	2024-11-11 15:28:10+00	t	18	3:39:56	\N	\N
1020	2024-11-12 04:39:29+00	2024-11-12 05:43:21+00	t	18	1:3:52	\N	\N
1032	2024-11-14 04:02:08+00	2024-11-14 13:00:25+00	t	5	8:58:17	\N	\N
1017	2024-11-12 04:02:29+00	2024-11-12 13:03:59+00	t	5	9:1:30	\N	\N
1056	2024-11-16 11:31:25+00	2024-11-16 15:00:19+00	t	18	3:28:54	\N	\N
1015	2024-11-12 03:57:53+00	2024-11-12 13:04:30+00	t	16	9:6:37	\N	\N
1033	2024-11-14 04:08:34+00	2024-11-14 13:18:53+00	t	17	9:10:19	\N	\N
1018	2024-11-12 04:09:14+00	2024-11-12 13:14:10+00	t	17	9:4:56	\N	\N
1036	2024-11-14 13:45:44+00	\N	t	19	\N	\N	\N
1016	2024-11-12 04:00:28+00	2024-11-12 13:16:33+00	t	20	9:16:5	\N	\N
1051	2024-11-16 04:21:50+00	2024-11-16 05:40:59+00	t	18	1:19:9	\N	\N
1029	2024-11-14 03:22:36+00	2024-11-14 15:00:32+00	t	10	11:37:56	\N	\N
1035	2024-11-14 11:28:39+00	2024-11-14 15:32:48+00	t	18	4:4:9	\N	\N
1040	2024-11-15 03:49:57+00	\N	t	20	\N	\N	\N
1042	2024-11-15 04:20:29+00	2024-11-15 05:45:35+00	t	18	1:25:6	\N	\N
1041	2024-11-15 03:50:05+00	2024-11-15 13:00:19+00	t	16	9:10:14	\N	\N
1049	2024-11-16 04:11:27+00	2024-11-16 08:01:35+00	t	5	3:50:8	\N	\N
1047	2024-11-16 03:24:56+00	2024-11-16 08:19:28+00	t	16	4:54:32	\N	\N
1055	2024-11-16 11:04:02+00	\N	t	19	\N	\N	\N
1076	2024-11-18 03:44:06+00	\N	t	20	\N	\N	\N
1079	2024-11-18 04:38:57+00	2024-11-18 13:07:13+00	t	17	8:28:16	Ýolda ofise gerek zatlary aldym giç galdym	#7551E9
1077	2024-11-18 04:33:21+00	2024-11-18 05:42:27+00	t	18	1:9:6	\N	\N
1080	2024-11-18 11:09:04+00	\N	t	26	\N	\N	\N
1074	2024-11-18 02:50:29+00	2024-11-18 13:09:39+00	t	16	10:19:10	\N	\N
1075	2024-11-18 03:13:22+00	2024-11-18 14:59:13+00	t	10	11:45:51	\N	\N
1081	2024-11-18 11:19:22+00	2024-11-18 15:36:43+00	t	18	4:17:21	\N	\N
1082	2024-11-18 11:46:35+00	2024-11-18 15:51:55+00	t	19	4:5:20	\N	\N
1087	2024-11-19 04:31:21+00	2024-11-19 05:39:19+00	t	18	1:7:58	\N	\N
1084	2024-11-19 03:38:20+00	2024-11-19 14:21:53+00	t	10	10:43:33	\N	\N
1083	2024-11-19 03:22:27+00	2024-11-19 13:05:50+00	t	16	9:43:23	\N	\N
1085	2024-11-19 03:56:40+00	2024-11-19 13:12:27+00	t	20	9:15:47	\N	\N
1089	2024-11-19 11:44:54+00	2024-11-19 15:11:45+00	t	19	3:26:51	\N	\N
1088	2024-11-19 11:20:50+00	2024-11-19 15:34:58+00	t	18	4:14:8	\N	\N
1061	2024-11-16 12:29:31+00	2024-11-16 12:29:39+00	t	\N	0:0:8	\N	\N
1203	2024-12-05 04:06:18+00	2024-12-05 13:15:26+00	t	20	9:9:8	\N	\N
1086	2024-11-19 03:57:06+00	2024-11-19 13:12:37+00	t	17	9:15:31	Banka töleg geçeni barada kagyzy almaly	#7551E9
1138	2024-11-25 03:57:52+00	\N	t	20	\N	\N	\N
1140	2024-11-25 04:18:39+00	2024-11-25 05:53:07+00	t	18	1:34:28	\N	\N
1136	2024-11-25 03:22:52+00	2024-11-25 13:07:19+00	t	16	9:44:27	\N	\N
1104	2024-11-20 03:52:30+00	\N	t	20	\N	\N	\N
1105	2024-11-20 03:58:38+00	\N	t	17	\N	\N	\N
1106	2024-11-20 04:30:12+00	2024-11-20 05:41:49+00	t	18	1:11:37	\N	\N
1139	2024-11-25 04:09:23+00	2024-11-25 13:08:12+00	t	17	8:58:49	Sagat 8-50 de geldim bellemek yatdan çykypdyr	#7551E9
1103	2024-11-20 03:39:43+00	2024-11-20 13:00:31+00	t	16	9:20:48	\N	\N
1107	2024-11-20 11:18:02+00	2024-11-20 13:57:59+00	t	19	2:39:57	\N	\N
1135	2024-11-25 03:22:23+00	2024-11-25 15:03:26+00	t	10	11:41:3	\N	\N
1102	2024-11-20 03:31:35+00	2024-11-20 14:53:39+00	t	10	11:22:4	\N	\N
1161	2024-11-28 04:35:15+00	2024-11-28 05:46:50+00	t	18	1:11:35	\N	\N
1108	2024-11-20 11:29:53+00	2024-11-20 15:08:41+00	t	18	3:38:48	\N	\N
1142	2024-11-25 12:05:39+00	2024-11-25 15:46:49+00	t	19	3:41:10	\N	\N
1113	2024-11-21 04:26:19+00	2024-11-21 05:47:16+00	t	18	1:20:57	\N	\N
1115	2024-11-21 11:37:20+00	\N	t	19	\N	\N	\N
1112	2024-11-21 04:05:30+00	2024-11-21 13:03:25+00	t	16	8:57:55	\N	\N
1141	2024-11-25 11:25:04+00	2024-11-25 15:52:16+00	t	18	4:27:12	\N	\N
1111	2024-11-21 04:02:48+00	2024-11-21 13:09:32+00	t	17	9:6:44	\N	\N
1110	2024-11-21 03:44:27+00	2024-11-21 13:11:28+00	t	20	9:27:1	\N	\N
1109	2024-11-21 03:27:43+00	2024-11-21 14:50:45+00	t	10	11:23:2	\N	\N
1114	2024-11-21 11:22:11+00	2024-11-21 15:43:03+00	t	18	4:20:52	\N	\N
1121	2024-11-22 04:36:57+00	2024-11-22 05:56:49+00	t	18	1:19:52	\N	\N
1119	2024-11-22 03:58:15+00	2024-11-22 13:13:05+00	t	17	9:14:50	\N	\N
1163	2024-11-28 11:34:02+00	\N	t	19	\N	\N	\N
1118	2024-11-22 03:48:27+00	2024-11-22 13:16:38+00	t	20	9:28:11	\N	\N
1147	2024-11-26 04:20:51+00	2024-11-26 05:53:21+00	t	18	1:32:30	\N	\N
1120	2024-11-22 04:01:33+00	2024-11-22 13:20:02+00	t	16	9:18:29	\N	\N
1124	2024-11-22 13:13:20+00	2024-11-22 14:41:03+00	t	19	1:27:43	\N	\N
1117	2024-11-22 03:37:06+00	2024-11-22 14:49:59+00	t	10	11:12:53	\N	\N
1123	2024-11-22 11:21:34+00	2024-11-22 16:03:05+00	t	18	4:41:31	\N	\N
1127	2024-11-23 04:03:41+00	\N	t	17	\N	\N	\N
1128	2024-11-23 04:09:31+00	\N	t	20	\N	\N	\N
1145	2024-11-26 03:52:53+00	2024-11-26 13:15:19+00	t	17	9:22:26	\N	\N
1129	2024-11-23 04:16:22+00	2024-11-23 05:45:21+00	t	18	1:28:59	\N	\N
1158	2024-11-28 03:18:31+00	2024-11-28 13:01:50+00	t	16	9:43:19	\N	\N
1146	2024-11-26 03:53:14+00	2024-11-26 13:15:54+00	t	20	9:22:40	\N	\N
1171	2024-11-30 02:28:40+00	2024-11-30 05:49:29+00	t	18	3:20:49	\N	\N
1126	2024-11-23 03:33:14+00	2024-11-23 08:01:02+00	t	16	4:27:48	\N	\N
1148	2024-11-26 11:22:31+00	2024-11-26 14:34:44+00	t	18	3:12:13	\N	\N
1134	2024-11-23 11:24:12+00	2024-11-23 13:16:07+00	t	18	1:51:55	\N	\N
1160	2024-11-28 04:16:52+00	2024-11-28 13:23:31+00	t	20	9:6:39	\N	\N
1125	2024-11-23 03:17:54+00	2024-11-23 14:39:19+00	t	10	11:21:25	\N	\N
1143	2024-11-26 03:11:36+00	2024-11-26 14:58:29+00	t	16	11:46:53	\N	\N
1132	2024-11-23 11:23:48+00	2024-11-23 14:46:31+00	t	19	3:22:43	\N	\N
1177	2024-11-30 11:41:13+00	2024-11-30 14:58:00+00	t	19	3:16:47	\N	\N
1144	2024-11-26 03:19:40+00	2024-11-26 14:59:58+00	t	10	11:40:18	\N	\N
1159	2024-11-28 04:16:21+00	2024-11-28 13:23:48+00	t	17	9:7:27	\N	\N
1149	2024-11-26 11:24:02+00	2024-11-26 15:39:32+00	t	19	4:15:30	\N	\N
1174	2024-11-30 03:58:40+00	2024-11-30 07:01:43+00	t	17	3:3:3	\N	\N
1154	2024-11-27 04:17:03+00	2024-11-27 05:49:08+00	t	18	1:32:5	\N	\N
1162	2024-11-28 11:20:36+00	2024-11-28 14:46:39+00	t	18	3:26:3	\N	\N
1150	2024-11-27 03:34:06+00	2024-11-27 13:00:18+00	t	16	9:26:12	Huawei datacom gatnashdyk	#9FC2A5
1157	2024-11-28 03:16:10+00	2024-11-28 15:02:51+00	t	10	11:46:41	\N	\N
1153	2024-11-27 04:00:17+00	2024-11-27 13:06:13+00	t	17	9:5:56	\N	\N
1152	2024-11-27 03:58:10+00	2024-11-27 13:16:16+00	t	20	9:18:6	\N	\N
1155	2024-11-27 04:57:23+00	2024-11-27 13:59:21+00	t	19	9:1:58	\N	\N
1151	2024-11-27 03:57:02+00	2024-11-27 14:03:49+00	t	10	10:6:47	\N	\N
1167	2024-11-29 03:59:07+00	\N	t	17	\N	\N	\N
1156	2024-11-27 11:23:07+00	2024-11-27 15:03:34+00	t	18	3:40:27	\N	\N
1173	2024-11-30 03:54:59+00	2024-11-30 08:01:45+00	t	16	4:6:46	\N	\N
1168	2024-11-29 04:14:57+00	2024-11-29 05:48:21+00	t	18	1:33:24	\N	\N
1181	2024-12-02 03:25:34+00	\N	t	10	\N	\N	\N
1165	2024-11-29 03:45:56+00	2024-11-29 13:01:11+00	t	16	9:15:15	\N	\N
1175	2024-11-30 04:04:12+00	2024-11-30 08:13:29+00	t	20	4:9:17	\N	\N
1166	2024-11-29 03:58:22+00	2024-11-29 13:13:04+00	t	20	9:14:42	\N	\N
1170	2024-11-29 11:20:33+00	2024-11-29 14:37:36+00	t	18	3:17:3	\N	\N
1164	2024-11-29 03:26:00+00	2024-11-29 14:38:41+00	t	10	11:12:41	\N	\N
1169	2024-11-29 11:14:08+00	2024-11-29 15:13:09+00	t	19	3:59:1	\N	\N
1090	2024-11-19 14:12:45+00	2024-11-19 14:24:50+00	t	\N	0:12:5	\N	\N
1137	2024-11-25 03:44:06+00	\N	t	\N	\N	\N	\N
1176	2024-11-30 11:26:01+00	2024-11-30 14:13:01+00	t	18	2:47:0	\N	\N
1180	2024-12-02 02:54:08+00	2024-12-02 13:20:46+00	t	16	10:26:38	\N	\N
1172	2024-11-30 03:25:51+00	2024-11-30 14:25:00+00	t	10	10:59:9	\N	\N
1184	2024-12-02 04:52:05+00	2024-12-02 05:52:53+00	t	18	1:0:48	\N	\N
1183	2024-12-02 04:03:11+00	2024-12-02 13:06:25+00	t	17	9:3:14	\N	\N
1186	2024-12-02 11:26:32+00	2024-12-02 15:29:50+00	t	18	4:3:18	\N	\N
1182	2024-12-02 03:59:46+00	2024-12-02 13:13:16+00	t	20	9:13:30	\N	\N
1185	2024-12-02 11:15:04+00	2024-12-02 15:46:44+00	t	19	4:31:40	\N	\N
1191	2024-12-03 04:29:00+00	2024-12-03 05:36:44+00	t	18	1:7:44	\N	\N
1190	2024-12-03 04:08:08+00	2024-12-03 13:03:00+00	t	17	8:54:52	\N	\N
1189	2024-12-03 03:56:53+00	2024-12-03 13:06:15+00	t	20	9:9:22	\N	\N
1187	2024-12-03 03:14:55+00	2024-12-03 13:17:01+00	t	16	10:2:6	\N	\N
1193	2024-12-03 11:25:22+00	2024-12-03 13:26:47+00	t	19	2:1:25	\N	\N
1188	2024-12-03 03:32:56+00	2024-12-03 14:38:38+00	t	10	11:5:42	\N	\N
1192	2024-12-03 11:21:40+00	2024-12-03 14:56:28+00	t	18	3:34:48	\N	\N
1197	2024-12-04 04:27:34+00	2024-12-04 13:13:54+00	t	17	8:46:20	Bellemani unudypdyryn gelemson	#7551E9
1198	2024-12-04 04:33:04+00	2024-12-04 05:54:56+00	t	18	1:21:52	\N	\N
1196	2024-12-04 03:56:43+00	2024-12-04 13:33:12+00	t	20	9:36:29	\N	\N
1194	2024-12-04 03:15:12+00	2024-12-04 13:49:12+00	t	16	10:34:0	\N	\N
1195	2024-12-04 03:34:12+00	2024-12-04 14:30:51+00	t	10	10:56:39	\N	\N
1200	2024-12-04 11:24:47+00	2024-12-04 15:36:48+00	t	18	4:12:1	\N	\N
1199	2024-12-04 11:15:10+00	2024-12-04 15:46:53+00	t	19	4:31:43	\N	\N
1178	2024-11-30 13:17:48+00	2024-11-30 13:17:49+00	t	\N	0:0:1	\N	\N
1091	2024-11-19 14:24:51+00	2024-11-19 14:24:52+00	t	\N	0:0:1	\N	\N
1204	2024-12-05 04:08:06+00	2024-12-05 05:47:48+00	t	18	1:39:42	\N	\N
1201	2024-12-05 03:43:24+00	2024-12-05 13:01:48+00	t	16	9:18:24	\N	\N
1205	2024-12-05 04:08:37+00	2024-12-05 13:15:08+00	t	17	9:6:31	\N	\N
1202	2024-12-05 03:45:35+00	2024-12-05 14:23:43+00	t	10	10:38:8	\N	\N
1206	2024-12-05 08:35:38+00	\N	t	\N	\N	\N	\N
1224	2024-12-07 10:02:32+00	2024-12-07 10:02:33+00	t	\N	0:0:1	\N	\N
1208	2024-12-05 14:58:13+00	2024-12-05 15:00:44+00	t	18	0:2:31	oylan sagat 16:25de geldim,unutdym	#FF9E58
1225	2024-12-07 10:12:36+00	2024-12-07 10:12:38+00	t	\N	0:0:2	\N	\N
1207	2024-12-05 11:28:54+00	2024-12-05 16:02:03+00	t	19	4:33:9	\N	\N
1213	2024-12-06 04:27:14+00	2024-12-06 05:52:45+00	t	18	1:25:31	\N	\N
1212	2024-12-06 04:05:16+00	2024-12-06 12:58:08+00	t	17	8:52:52	\N	\N
1179	2024-11-30 13:17:49+00	2024-11-30 13:17:49+00	t	\N	0:0:0	\N	\N
1236	2024-12-09 12:57:55+00	2024-12-09 12:58:18+00	t	\N	0:0:23	Dekanyn baryp gaytmaly	#7551E9
1237	2024-12-09 12:58:32+00	\N	t	\N	\N	\N	\N
1211	2024-12-06 03:56:33+00	2024-12-06 13:22:21+00	t	20	9:25:48	\N	\N
1209	2024-12-06 03:16:43+00	2024-12-06 14:12:13+00	t	16	10:55:30	\N	\N
1252	2024-12-11 04:16:28+00	2024-12-11 05:47:13+00	t	18	1:30:45	\N	\N
1210	2024-12-06 03:50:04+00	2024-12-06 14:42:32+00	t	10	10:52:28	\N	\N
1230	2024-12-09 03:48:56+00	2024-12-09 13:22:19+00	t	17	9:33:23	\N	\N
1215	2024-12-06 11:19:16+00	2024-12-06 15:32:09+00	t	18	4:12:53	\N	\N
1238	2024-12-09 13:24:23+00	\N	t	63	\N	\N	\N
1214	2024-12-06 10:52:42+00	2024-12-06 16:10:03+00	t	19	5:17:21	\N	\N
1223	2024-12-07 04:29:12+00	2024-12-07 05:44:58+00	t	18	1:15:46	\N	\N
1248	2024-12-11 03:07:27+00	2024-12-11 12:56:14+00	t	66	9:48:47	\N	\N
1251	2024-12-11 03:50:57+00	2024-12-11 13:19:07+00	t	20	9:28:10	\N	\N
1240	2024-12-09 13:28:14+00	2024-12-09 13:30:16+00	t	64	0:2:2	\N	\N
1239	2024-12-09 13:26:51+00	2024-12-09 13:26:52+00	t	64	0:0:1	\N	\N
1220	2024-12-07 03:48:55+00	2024-12-07 08:08:24+00	t	20	4:19:29	zdfg	#7551E9
1235	2024-12-09 11:42:23+00	2024-12-09 14:07:05+00	t	19	2:24:42	\N	\N
1221	2024-12-07 03:49:28+00	2024-12-07 08:11:18+00	t	17	4:21:50	\N	\N
1250	2024-12-11 03:28:04+00	2024-12-11 13:19:21+00	t	16	9:51:17	\N	\N
1228	2024-12-09 03:31:26+00	2024-12-09 14:46:05+00	t	10	11:14:39	\N	\N
1249	2024-12-11 03:27:35+00	2024-12-11 14:21:56+00	t	10	10:54:21	\N	\N
1219	2024-12-07 03:33:48+00	2024-12-07 10:14:26+00	t	16	6:40:38	\N	\N
1229	2024-12-09 03:39:41+00	2024-12-09 15:15:27+00	t	16	11:35:46	\N	\N
1222	2024-12-07 03:50:22+00	2024-12-07 13:09:39+00	t	10	9:19:17	\N	\N
1227	2024-12-07 11:26:46+00	2024-12-07 14:16:58+00	t	18	2:50:12	\N	\N
1234	2024-12-09 11:21:45+00	2024-12-09 15:50:32+00	t	18	4:28:47	\N	\N
1226	2024-12-07 10:31:05+00	2024-12-07 15:16:14+00	t	19	4:45:9	\N	\N
1231	2024-12-09 03:49:07+00	\N	t	20	\N	\N	\N
1216	2024-12-06 13:14:09+00	2024-12-06 13:14:10+00	t	\N	0:0:1	\N	\N
1232	2024-12-09 04:29:39+00	2024-12-09 05:59:33+00	t	18	1:29:54	\N	\N
1233	2024-12-09 06:01:12+00	\N	t	\N	\N	\N	\N
1217	2024-12-06 13:45:45+00	2024-12-06 13:45:45+00	t	\N	0:0:0	\N	\N
1218	2024-12-06 13:46:36+00	\N	t	\N	\N	\N	\N
640	2024-09-25 13:33:23+00	2024-09-25 13:37:10+00	t	\N	0:3:47	\N	\N
641	2024-09-25 13:37:11+00	2024-09-25 13:44:45+00	t	\N	0:7:34	\N	\N
642	2024-09-25 13:44:46+00	2024-09-25 13:44:48+00	t	\N	0:0:2	\N	\N
643	2024-09-25 13:44:49+00	2024-09-25 13:50:14+00	t	\N	0:5:25	bb	#7551E9
644	2024-09-25 13:50:40+00	\N	t	\N	\N	aaaaa	#FF9E58
651	2024-09-26 04:22:05+00	2024-09-26 04:22:06+00	t	\N	0:0:1	\N	\N
652	2024-09-26 04:22:07+00	2024-09-26 04:22:08+00	t	\N	0:0:1	\N	\N
653	2024-09-26 04:22:09+00	2024-09-26 04:22:10+00	t	\N	0:0:1	\N	\N
654	2024-09-26 04:22:11+00	2024-09-26 04:22:12+00	t	\N	0:0:1	\N	\N
656	2024-09-26 04:22:14+00	2024-09-26 04:22:15+00	t	\N	0:0:1	cascsa vSDVasvsadvas  sdvsdavsd EB svDSsdv snfgndsgfbadf afasdgareb adfbagfqrwegas aerhqerhqre	#FF9E58
673	2024-09-28 04:27:08+00	2024-09-28 04:27:21+00	t	\N	0:0:13	\N	\N
674	2024-09-28 04:27:22+00	2024-09-28 04:27:23+00	t	\N	0:0:1	\N	\N
675	2024-09-28 04:27:24+00	2024-09-28 04:27:25+00	t	\N	0:0:1	\N	\N
693	2024-09-30 05:47:48+00	\N	t	\N	\N	test	#7551E9
676	2024-09-28 04:27:25+00	2024-09-28 04:27:27+00	t	\N	0:0:2	\N	\N
677	2024-09-28 04:27:28+00	2024-09-28 04:27:29+00	t	\N	0:0:1	sddff	#7551E9
706	2024-10-01 04:19:53+00	2024-10-01 04:19:55+00	t	\N	0:0:2	\N	\N
707	2024-10-01 04:19:56+00	2024-10-01 04:25:29+00	t	\N	0:5:33	aaa	#7551E9
708	2024-10-01 05:01:18+00	2024-10-01 05:01:18+00	t	\N	0:0:0	aaasasss	#9FC2A5
725	2024-10-02 13:48:10+00	2024-10-02 13:48:11+00	t	\N	0:0:1	\N	\N
875	2024-10-22 13:34:42+00	\N	t	\N	\N	\N	\N
923	2024-10-29 05:22:33+00	2024-10-29 05:22:35+00	t	\N	0:0:2	\N	\N
1242	2024-12-10 03:36:45+00	\N	t	10	\N	\N	\N
1245	2024-12-10 04:10:53+00	2024-12-10 05:46:48+00	t	18	1:35:55	\N	\N
1241	2024-12-10 03:06:37+00	2024-12-10 13:00:02+00	t	16	9:53:25	\N	\N
1244	2024-12-10 03:56:05+00	2024-12-10 13:03:44+00	t	20	9:7:39	\N	\N
1247	2024-12-10 13:24:54+00	2024-12-10 13:24:56+00	t	17	0:0:2	\N	\N
1243	2024-12-10 03:40:45+00	2024-12-10 14:10:47+00	t	66	10:30:2	\N	\N
1246	2024-12-10 11:50:21+00	2024-12-10 15:50:23+00	t	19	4:0:2	\N	\N
844	2024-10-18 04:28:19+00	2024-10-18 04:31:16+00	t	\N	0:2:57	qwertyu	#7551E9
862	2024-10-21 04:40:56+00	\N	t	\N	\N	\N	\N
942	2024-10-31 12:36:22+00	2024-10-31 12:36:23+00	t	\N	0:0:1	\N	\N
948	2024-11-01 04:13:32+00	\N	t	\N	\N	\N	\N
1050	2024-11-16 04:21:34+00	2024-11-16 05:20:02+00	t	\N	0:58:28	\N	\N
1062	2024-11-16 12:30:28+00	2024-11-16 12:31:47+00	t	\N	0:1:19	\N	\N
1037	2024-11-14 15:26:03+00	2024-11-14 15:27:43+00	t	\N	0:1:40	\N	\N
1052	2024-11-16 05:20:04+00	2024-11-16 05:41:14+00	t	\N	0:21:10	\N	\N
1038	2024-11-14 15:27:44+00	2024-11-14 15:27:44+00	t	\N	0:0:0	\N	\N
1053	2024-11-16 05:41:41+00	2024-11-16 05:42:13+00	t	\N	0:0:32	\N	\N
1044	2024-11-15 14:53:56+00	2024-11-15 15:00:53+00	t	\N	0:6:57	\N	\N
1069	2024-11-16 13:04:41+00	2024-11-16 13:05:51+00	t	\N	0:1:10	\N	\N
1045	2024-11-15 15:02:56+00	2024-11-15 15:04:03+00	t	\N	0:1:7	\N	\N
1063	2024-11-16 12:32:54+00	2024-11-16 12:34:03+00	t	\N	0:1:9	\N	\N
1054	2024-11-16 05:42:28+00	2024-11-16 12:09:27+00	t	\N	6:26:59	\N	\N
1058	2024-11-16 12:09:46+00	2024-11-16 12:23:38+00	t	\N	\N	\N	\N
1057	2024-11-16 12:09:42+00	2024-11-16 12:23:38+00	t	\N	0:13:56	\N	\N
1064	2024-11-16 12:37:57+00	2024-11-16 12:39:31+00	t	\N	0:1:34	\N	\N
1059	2024-11-16 12:26:10+00	2024-11-16 12:27:08+00	t	\N	0:0:58	\N	\N
1060	2024-11-16 12:28:05+00	2024-11-16 12:28:22+00	t	\N	0:0:17	\N	\N
1065	2024-11-16 12:43:32+00	2024-11-16 12:46:26+00	t	\N	0:2:54	\N	\N
1066	2024-11-16 12:47:06+00	2024-11-16 12:49:59+00	t	\N	0:2:53	\N	\N
1067	2024-11-16 12:50:12+00	2024-11-16 12:51:03+00	t	\N	0:0:51	\N	\N
1071	2024-11-16 13:07:21+00	2024-11-16 13:09:15+00	t	\N	\N	\N	\N
1068	2024-11-16 12:51:06+00	2024-11-16 12:51:30+00	t	\N	0:0:24	\N	\N
1072	2024-11-16 13:07:25+00	2024-11-16 13:09:15+00	t	\N	\N	\N	\N
1070	2024-11-16 13:07:13+00	2024-11-16 13:09:15+00	t	\N	0:2:2	\N	\N
1073	2024-11-16 13:09:53+00	2024-11-16 13:09:57+00	t	\N	0:0:4	\N	\N
1078	2024-11-18 04:37:18+00	\N	t	\N	\N	\N	\N
1092	2024-11-19 14:24:54+00	2024-11-19 14:24:56+00	t	\N	0:0:2	\N	\N
1093	2024-11-19 14:24:57+00	2024-11-19 14:24:58+00	t	\N	0:0:1	\N	\N
1094	2024-11-19 14:24:59+00	2024-11-19 14:25:01+00	t	\N	0:0:2	\N	\N
1095	2024-11-19 14:25:04+00	2024-11-19 14:25:06+00	t	\N	0:0:2	\N	\N
1096	2024-11-19 14:25:35+00	2024-11-19 14:25:36+00	t	\N	0:0:1	\N	\N
1097	2024-11-19 14:25:37+00	2024-11-19 14:25:38+00	t	\N	0:0:1	\N	\N
1098	2024-11-19 14:25:38+00	2024-11-19 14:25:39+00	t	\N	0:0:1	\N	\N
1099	2024-11-19 14:25:40+00	2024-11-19 14:25:41+00	t	\N	0:0:1	\N	\N
1100	2024-11-19 14:25:43+00	2024-11-19 14:25:44+00	t	\N	0:0:1	\N	\N
1101	2024-11-19 15:08:26+00	2024-11-19 15:10:59+00	t	\N	0:2:33	\N	\N
1116	2024-11-21 12:53:23+00	\N	t	\N	\N	\N	\N
1122	2024-11-22 10:47:37+00	\N	t	\N	\N	\N	\N
1130	2024-11-23 05:45:39+00	2024-11-23 05:45:41+00	t	\N	0:0:2	\N	\N
1131	2024-11-23 07:17:25+00	2024-11-23 07:17:30+00	t	\N	0:0:5	\N	\N
1133	2024-11-23 11:24:02+00	\N	t	\N	\N	\N	\N
1283	2024-12-17 03:43:33+00	2024-12-17 13:00:35+00	t	16	9:17:2	\N	\N
1255	2024-12-11 11:03:06+00	\N	t	63	\N	\N	\N
1315	2024-12-21 04:03:49+00	\N	t	20	\N	\N	\N
1253	2024-12-11 06:57:25+00	2024-12-11 13:15:49+00	t	17	6:18:24	Bank işleri bn gitdim	#7551E9
1285	2024-12-17 03:53:06+00	2024-12-17 13:05:27+00	t	17	9:12:21	\N	\N
1256	2024-12-11 11:20:30+00	2024-12-11 15:41:41+00	t	19	4:21:11	\N	\N
1298	2024-12-19 03:31:05+00	2024-12-19 14:58:05+00	t	10	11:27:0	\N	\N
1254	2024-12-11 10:40:44+00	2024-12-11 15:53:28+00	t	18	5:12:44	\N	\N
1257	2024-12-13 02:59:26+00	\N	t	26	\N	\N	\N
1263	2024-12-13 03:53:01+00	\N	t	17	\N	\N	\N
1281	2024-12-17 03:30:05+00	2024-12-17 14:49:54+00	t	10	11:19:49	\N	\N
1264	2024-12-13 04:28:32+00	2024-12-13 05:50:01+00	t	18	1:21:29	\N	\N
1316	2024-12-21 04:03:55+00	\N	t	17	\N	\N	\N
1287	2024-12-17 11:35:20+00	2024-12-17 15:40:29+00	t	18	4:5:9	\N	\N
1262	2024-12-13 03:52:46+00	2024-12-13 12:58:22+00	t	66	9:5:36	\N	\N
1304	2024-12-19 13:08:53+00	2024-12-19 15:24:50+00	t	18	2:15:57	\N	\N
1259	2024-12-13 03:51:55+00	2024-12-13 13:03:34+00	t	16	9:11:39	\N	\N
1288	2024-12-17 16:31:14+00	2024-12-17 16:31:16+00	t	19	0:0:2	\N	\N
1266	2024-12-13 11:24:37+00	2024-12-13 13:22:27+00	t	18	1:57:50	\N	\N
1258	2024-12-13 03:49:22+00	2024-12-13 14:23:32+00	t	10	10:34:10	\N	\N
1290	2024-12-18 03:46:01+00	\N	t	10	\N	\N	\N
1265	2024-12-13 11:17:15+00	2024-12-13 15:18:02+00	t	19	4:0:47	\N	\N
1261	2024-12-13 03:52:29+00	2024-12-13 15:27:46+00	t	20	\N	\N	\N
1260	2024-12-13 03:52:29+00	2024-12-13 15:27:46+00	t	20	11:35:17	\N	\N
1267	2024-12-14 03:17:53+00	\N	t	10	\N	\N	\N
1269	2024-12-14 04:23:43+00	2024-12-14 05:30:36+00	t	18	1:6:53	\N	\N
1270	2024-12-14 05:23:01+00	2024-12-14 05:54:40+00	t	66	0:31:39	Mashgala yagdayy sebapli gaytmaly boldum	#FF9E58
1293	2024-12-18 04:23:14+00	2024-12-18 05:41:44+00	t	18	1:18:30	\N	\N
1268	2024-12-14 03:33:42+00	2024-12-14 10:47:52+00	t	16	7:14:10	\N	\N
1271	2024-12-14 11:13:53+00	2024-12-14 13:59:28+00	t	19	2:45:35	\N	\N
1272	2024-12-14 11:35:01+00	2024-12-14 15:47:05+00	t	18	4:12:4	\N	\N
1275	2024-12-16 03:29:50+00	\N	t	17	\N	\N	\N
1277	2024-12-16 04:22:14+00	2024-12-16 05:45:25+00	t	18	1:23:11	\N	\N
1303	2024-12-19 11:47:50+00	2024-12-19 16:09:39+00	t	19	4:21:49	\N	\N
1276	2024-12-16 03:41:37+00	2024-12-16 13:07:12+00	t	66	9:25:35	\N	\N
1294	2024-12-18 09:28:22+00	2024-12-18 12:00:37+00	t	66	2:32:15	\N	\N
1278	2024-12-16 04:26:56+00	2024-12-16 13:13:39+00	t	20	8:46:43	\N	\N
1274	2024-12-16 03:28:39+00	2024-12-16 14:21:13+00	t	16	10:52:34	\N	\N
1289	2024-12-18 02:52:50+00	2024-12-18 13:02:03+00	t	16	10:9:13	\N	\N
1273	2024-12-16 03:25:59+00	2024-12-16 14:37:42+00	t	10	11:11:43	\N	\N
1280	2024-12-16 12:33:12+00	2024-12-16 15:10:56+00	t	19	2:37:44	\N	\N
1292	2024-12-18 03:49:24+00	2024-12-18 13:06:17+00	t	17	9:16:53	\N	\N
1279	2024-12-16 11:25:59+00	2024-12-16 15:19:08+00	t	18	3:53:9	\N	\N
1286	2024-12-17 04:13:51+00	2024-12-17 05:43:33+00	t	18	1:29:42	\N	\N
1291	2024-12-18 03:49:14+00	2024-12-18 13:06:24+00	t	20	9:17:10	\N	\N
1282	2024-12-17 03:43:25+00	2024-12-17 12:50:48+00	t	66	9:7:23	\N	\N
1284	2024-12-17 03:47:32+00	2024-12-17 13:00:18+00	t	20	9:12:46	\N	\N
1295	2024-12-18 11:33:53+00	2024-12-18 15:49:28+00	t	18	4:15:35	\N	\N
1296	2024-12-18 11:36:05+00	2024-12-18 16:32:48+00	t	19	4:56:43	\N	\N
1301	2024-12-19 04:27:23+00	2024-12-19 05:48:29+00	t	18	1:21:6	\N	\N
1310	2024-12-20 04:34:54+00	2024-12-20 05:41:51+00	t	18	1:6:57	\N	\N
1297	2024-12-19 02:47:38+00	2024-12-19 12:47:14+00	t	66	9:59:36	\N	\N
1299	2024-12-19 03:42:23+00	2024-12-19 13:00:24+00	t	16	9:18:1	\N	\N
1302	2024-12-19 06:36:04+00	2024-12-19 13:12:04+00	t	17	6:36:0	Malive we ykdysadyvet ministrligine gitdim	#7551E9
1308	2024-12-20 03:49:40+00	2024-12-20 12:56:37+00	t	20	9:6:57	\N	\N
1300	2024-12-19 04:01:28+00	2024-12-19 13:13:37+00	t	20	9:12:9	\N	\N
1305	2024-12-20 03:11:48+00	2024-12-20 13:00:06+00	t	16	9:48:18	\N	\N
1318	2024-12-21 11:56:09+00	2024-12-21 14:02:33+00	t	18	2:6:24	irden Aman serverde isledi crm islemedi	#E951BF
1309	2024-12-20 03:51:05+00	2024-12-20 13:02:27+00	t	17	9:11:22	\N	\N
1322	2024-12-23 03:35:40+00	2024-12-23 13:05:29+00	t	66	9:29:49	\N	\N
1306	2024-12-20 03:27:09+00	2024-12-20 13:25:19+00	t	66	9:58:10	\N	\N
1314	2024-12-21 03:37:11+00	2024-12-21 14:32:50+00	t	10	10:55:39	\N	\N
1312	2024-12-20 11:48:46+00	2024-12-20 14:20:30+00	t	18	2:31:44	\N	\N
1325	2024-12-23 04:21:46+00	2024-12-23 05:46:53+00	t	18	1:25:7	\N	\N
1307	2024-12-20 03:36:27+00	2024-12-20 14:43:18+00	t	10	11:6:51	\N	\N
1317	2024-12-21 11:55:38+00	2024-12-21 16:00:48+00	t	19	4:5:10	\N	\N
1311	2024-12-20 11:38:32+00	2024-12-20 16:16:18+00	t	19	4:37:46	\N	\N
1313	2024-12-21 03:36:09+00	\N	t	16	\N	\N	\N
1319	2024-12-22 05:56:23+00	2024-12-22 14:37:20+00	t	18	8:40:57	\N	\N
1320	2024-12-23 03:29:26+00	\N	t	10	\N	\N	\N
1323	2024-12-23 04:00:29+00	2024-12-23 13:03:20+00	t	17	9:2:51	\N	\N
1321	2024-12-23 03:35:29+00	2024-12-23 13:17:17+00	t	16	9:41:48	\N	\N
1324	2024-12-23 04:00:49+00	2024-12-23 13:03:39+00	t	20	9:2:50	\N	\N
1326	2024-12-23 11:23:27+00	2024-12-23 15:26:01+00	t	18	4:2:34	\N	\N
1330	2024-12-24 04:01:04+00	\N	t	20	\N	\N	\N
1331	2024-12-24 04:24:13+00	2024-12-24 05:56:04+00	t	18	1:31:51	\N	\N
1332	2024-12-24 07:10:37+00	2024-12-24 13:01:41+00	t	17	5:51:4	Banka we Maliýe ministrligine gitdim	#7551E9
1327	2024-12-24 02:50:23+00	2024-12-24 13:12:25+00	t	16	10:22:2	\N	\N
1329	2024-12-24 03:49:25+00	2024-12-24 13:12:35+00	t	66	9:23:10	\N	\N
1328	2024-12-24 03:41:23+00	2024-12-24 14:28:51+00	t	10	10:47:28	\N	\N
1333	2024-12-24 11:22:54+00	2024-12-24 15:28:43+00	t	18	4:5:49	\N	\N
1334	2024-12-24 11:33:15+00	2024-12-24 15:47:07+00	t	19	4:13:52	\N	\N
1339	2024-12-25 03:54:58+00	\N	t	20	\N	\N	\N
1340	2024-12-25 04:27:24+00	2024-12-25 05:44:55+00	t	18	1:17:31	\N	\N
1338	2024-12-25 03:54:47+00	2024-12-25 13:04:18+00	t	17	9:9:31	\N	\N
1336	2024-12-25 03:43:24+00	2024-12-25 14:55:04+00	t	10	11:11:40	\N	\N
1341	2024-12-25 11:19:24+00	2024-12-25 15:18:17+00	t	19	3:58:53	\N	\N
1335	2024-12-25 02:23:34+00	2024-12-25 13:01:43+00	t	16	10:38:9	\N	\N
1337	2024-12-25 03:47:51+00	2024-12-25 13:24:59+00	t	66	9:37:8	\N	\N
1342	2024-12-25 11:24:20+00	2024-12-25 15:32:41+00	t	18	4:8:21	\N	\N
1344	2024-12-26 03:32:17+00	\N	t	10	\N	\N	\N
1347	2024-12-26 03:39:10+00	\N	t	17	\N	\N	\N
1382	2025-01-03 03:37:22+00	2025-01-03 14:57:43+00	t	10	11:20:21	\N	\N
1348	2024-12-26 04:24:10+00	2024-12-26 05:44:17+00	t	18	1:20:7	\N	\N
1421	2025-01-08 05:20:11+00	2025-01-08 15:01:43+00	t	18	9:41:32	\N	\N
1343	2024-12-26 02:47:49+00	2024-12-26 13:09:49+00	t	16	10:22:0	\N	\N
1387	2025-01-03 11:18:08+00	2025-01-03 15:08:14+00	t	18	3:50:6	\N	\N
1345	2024-12-26 03:32:28+00	2024-12-26 13:13:18+00	t	66	9:40:50	\N	\N
1346	2024-12-26 03:38:48+00	2024-12-26 13:37:55+00	t	20	9:59:7	\N	\N
1413	2025-01-07 03:48:49+00	2025-01-07 13:08:25+00	t	17	9:19:36	\N	\N
1349	2024-12-26 10:23:14+00	2024-12-26 15:26:52+00	t	18	5:3:38	\N	\N
1388	2025-01-03 11:39:29+00	2025-01-03 15:42:15+00	t	19	\N	\N	\N
1350	2024-12-26 11:49:29+00	2024-12-26 16:09:24+00	t	19	4:19:55	\N	\N
1353	2024-12-27 03:25:11+00	\N	t	10	\N	\N	\N
1390	2025-01-03 15:42:12+00	2025-01-03 15:42:15+00	t	19	0:0:3	\N	\N
1352	2024-12-27 02:48:53+00	2024-12-27 04:57:46+00	t	66	2:8:53	\N	\N
1357	2024-12-27 11:21:16+00	\N	t	19	\N	\N	\N
1356	2024-12-27 10:19:22+00	2024-12-27 12:55:54+00	t	66	2:36:32	\N	\N
1354	2024-12-27 03:39:21+00	2024-12-27 12:59:00+00	t	17	9:19:39	\N	\N
1355	2024-12-27 04:07:30+00	2024-12-27 13:00:02+00	t	20	8:52:32	\N	\N
1351	2024-12-27 02:11:24+00	2024-12-27 14:13:15+00	t	16	12:1:51	\N	\N
1358	2024-12-27 11:25:10+00	2024-12-27 15:26:20+00	t	18	4:1:10	\N	\N
1364	2024-12-28 04:14:15+00	2024-12-28 06:02:18+00	t	18	1:48:3	\N	\N
1362	2024-12-28 03:47:44+00	2024-12-28 07:39:38+00	t	17	3:51:54	\N	\N
1395	2025-01-04 03:59:34+00	2025-01-04 04:34:17+00	t	18	0:34:43	\N	\N
1360	2024-12-28 03:31:02+00	2024-12-28 07:46:19+00	t	66	4:15:17	\N	\N
1397	2025-01-04 05:27:25+00	\N	t	26	\N	\N	\N
1363	2024-12-28 03:49:10+00	2024-12-28 08:35:17+00	t	20	4:46:7	\N	\N
1412	2025-01-07 03:47:06+00	2025-01-07 13:08:45+00	t	20	9:21:39	\N	\N
1359	2024-12-28 02:42:23+00	2024-12-28 08:55:07+00	t	16	6:12:44	\N	\N
1394	2025-01-04 03:47:49+00	2025-01-04 07:59:40+00	t	17	4:11:51	\N	\N
1366	2024-12-28 11:46:25+00	2024-12-28 13:53:58+00	t	19	2:7:33	\N	\N
1365	2024-12-28 11:21:22+00	2024-12-28 14:48:14+00	t	18	3:26:52	\N	\N
1393	2025-01-04 03:39:25+00	2025-01-04 08:00:05+00	t	16	4:20:40	\N	\N
1361	2024-12-28 03:40:32+00	2024-12-28 14:52:57+00	t	10	11:12:25	\N	\N
1416	2025-01-07 05:15:11+00	2025-01-07 14:14:58+00	t	18	8:59:47	\N	\N
1370	2024-12-30 04:34:46+00	2024-12-30 05:48:50+00	t	18	1:14:4	\N	\N
1396	2025-01-04 04:06:58+00	2025-01-04 08:00:44+00	t	20	3:53:46	\N	\N
1367	2024-12-30 02:19:04+00	2024-12-30 06:39:04+00	t	16	4:20:0	\N	\N
1369	2024-12-30 04:10:03+00	2024-12-30 08:48:45+00	t	66	4:38:42	\N	\N
1372	2024-12-30 12:11:40+00	\N	t	19	\N	\N	\N
1392	2025-01-04 03:34:17+00	2025-01-04 08:04:44+00	t	66	4:30:27	\N	\N
1371	2024-12-30 11:21:20+00	2024-12-30 12:50:53+00	t	18	1:29:33	\N	\N
1368	2024-12-30 03:26:51+00	2024-12-30 13:07:46+00	t	10	9:40:55	\N	\N
1376	2025-01-02 03:48:19+00	\N	t	17	\N	\N	\N
1377	2025-01-02 03:48:31+00	\N	t	20	\N	\N	\N
1378	2025-01-02 04:25:38+00	2025-01-02 05:45:49+00	t	18	1:20:11	\N	\N
1373	2025-01-02 03:23:52+00	2025-01-02 12:49:41+00	t	66	9:25:49	\N	\N
1411	2025-01-07 03:39:19+00	2025-01-07 14:37:39+00	t	10	10:58:20	\N	\N
1375	2025-01-02 03:40:21+00	2025-01-02 13:06:21+00	t	16	9:26:0	\N	\N
1391	2025-01-04 03:30:18+00	2025-01-04 14:44:46+00	t	10	11:14:28	\N	\N
1374	2025-01-02 03:29:55+00	2025-01-02 14:43:09+00	t	10	11:13:14	\N	\N
1379	2025-01-02 11:24:51+00	2025-01-02 14:45:21+00	t	18	3:20:30	\N	\N
1398	2025-01-04 11:58:21+00	2025-01-04 15:42:49+00	t	18	3:44:28	\N	\N
1380	2025-01-02 12:53:34+00	2025-01-02 15:53:19+00	t	19	2:59:45	\N	\N
1383	2025-01-03 03:52:05+00	\N	t	17	\N	\N	\N
1417	2025-01-07 11:23:05+00	2025-01-07 14:56:35+00	t	19	3:33:30	\N	\N
1386	2025-01-03 04:32:26+00	2025-01-03 05:46:26+00	t	18	1:14:0	\N	\N
1400	2025-01-04 12:18:06+00	2025-01-04 15:43:59+00	t	19	\N	\N	\N
1384	2025-01-03 03:52:23+00	2025-01-03 12:47:46+00	t	66	8:55:23	\N	\N
1399	2025-01-04 12:18:06+00	2025-01-04 15:43:59+00	t	19	3:25:53	\N	\N
1385	2025-01-03 03:54:02+00	2025-01-03 13:00:03+00	t	20	9:6:1	\N	\N
1381	2025-01-03 02:38:12+00	2025-01-03 13:00:41+00	t	16	10:22:29	\N	\N
1389	2025-01-03 13:41:30+00	2025-01-03 13:41:41+00	t	64	0:0:11	\N	\N
1401	2025-01-05 05:25:31+00	2025-01-05 11:49:38+00	t	18	6:24:7	\N	\N
1403	2025-01-06 03:41:33+00	\N	t	17	\N	\N	\N
1408	2025-01-06 10:06:15+00	\N	t	63	\N	\N	\N
1409	2025-01-06 10:06:31+00	\N	t	69	\N	\N	\N
1405	2025-01-06 03:47:53+00	2025-01-06 12:52:09+00	t	66	9:4:16	\N	\N
1402	2025-01-06 03:41:05+00	2025-01-06 13:01:42+00	t	20	9:20:37	\N	\N
1404	2025-01-06 03:45:34+00	2025-01-06 13:02:26+00	t	16	9:16:52	\N	\N
1423	2025-01-08 12:08:04+00	\N	t	19	\N	\N	\N
1407	2025-01-06 07:29:52+00	2025-01-06 14:35:02+00	t	18	7:5:10	\N	\N
1406	2025-01-06 06:27:05+00	2025-01-06 14:38:45+00	t	10	8:11:40	\N	\N
1428	2025-01-09 05:56:25+00	2025-01-09 14:27:37+00	t	10	8:31:12	konsultasiya boldy	#7551E9
1410	2025-01-06 12:00:27+00	2025-01-06 14:48:01+00	t	19	2:47:34	\N	\N
1415	2025-01-07 04:23:47+00	\N	t	66	\N	\N	\N
1429	2025-01-09 06:48:37+00	\N	t	66	\N	\N	\N
1414	2025-01-07 03:49:23+00	2025-01-07 13:00:21+00	t	16	9:10:58	\N	\N
1420	2025-01-08 03:48:09+00	2025-01-08 13:00:51+00	t	20	9:12:42	\N	\N
1419	2025-01-08 03:37:19+00	2025-01-08 13:01:29+00	t	16	9:24:10	\N	\N
1440	2025-01-10 11:19:59+00	\N	t	19	\N	\N	\N
1424	2025-01-08 12:15:51+00	2025-01-08 13:17:00+00	t	17	1:1:9	Sagat 12 de geldim Banka bardym aylyk kart açdyrmak üçin,Sobese bardym deklarasiýa üçin bellemani unutdym	#7551E9
1422	2025-01-08 09:47:05+00	2025-01-08 14:13:15+00	t	69	4:26:10	\N	\N
1418	2025-01-08 03:23:24+00	2025-01-08 14:34:12+00	t	10	11:10:48	\N	\N
1435	2025-01-10 03:59:08+00	2025-01-10 13:57:21+00	t	17	9:58:13	Zähmet ministrligine hat almaga gitdim	#7551E9
1430	2025-01-09 07:18:12+00	2025-01-09 15:14:15+00	t	18	7:56:3	unutdym	#E951BF
1425	2025-01-09 03:42:45+00	2025-01-09 13:00:01+00	t	16	9:17:16	\N	\N
1426	2025-01-09 03:53:35+00	2025-01-09 13:36:51+00	t	17	9:43:16	\N	\N
1434	2025-01-10 03:59:04+00	\N	t	66	\N	\N	\N
1427	2025-01-09 03:54:34+00	2025-01-09 13:41:53+00	t	20	9:47:19	\N	\N
1431	2025-01-09 10:06:39+00	2025-01-09 14:08:34+00	t	69	4:1:55	\N	\N
1432	2025-01-09 10:25:57+00	2025-01-09 14:14:22+00	t	19	3:48:25	\N	\N
1438	2025-01-10 07:44:46+00	2025-01-10 12:18:56+00	t	18	4:34:10	\N	\N
1439	2025-01-10 09:39:12+00	2025-01-10 13:59:59+00	t	69	4:20:47	\N	\N
1437	2025-01-10 06:25:48+00	2025-01-10 15:01:32+00	t	10	8:35:44	exam boldy	#7551E9
1441	2025-01-10 12:26:29+00	2025-01-10 13:09:17+00	t	18	0:42:48	\N	\N
1433	2025-01-10 02:53:41+00	2025-01-10 13:02:01+00	t	16	10:8:20	\N	\N
1436	2025-01-10 03:59:27+00	2025-01-10 13:57:40+00	t	20	9:58:13	\N	\N
1443	2025-01-11 03:18:45+00	\N	t	10	\N	\N	\N
1444	2025-01-11 03:41:42+00	\N	t	66	\N	\N	\N
1445	2025-01-11 03:52:17+00	\N	t	17	\N	\N	\N
1448	2025-01-11 10:08:40+00	\N	t	69	\N	\N	\N
1446	2025-01-11 03:53:36+00	2025-01-11 08:02:46+00	t	20	4:9:10	\N	\N
1442	2025-01-11 02:53:49+00	2025-01-11 08:11:04+00	t	16	5:17:15	\N	\N
1450	2025-01-11 11:58:44+00	\N	t	64	\N	E-commerce	#7551E9
1447	2025-01-11 04:11:08+00	2025-01-11 13:20:02+00	t	18	9:8:54	\N	\N
1449	2025-01-11 10:58:37+00	2025-01-11 15:29:20+00	t	19	4:30:43	\N	\N
1452	2025-01-13 03:45:10+00	\N	t	17	\N	\N	\N
1455	2025-01-13 06:28:01+00	2025-01-13 14:48:24+00	t	18	8:20:23	\N	\N
1454	2025-01-13 05:09:29+00	2025-01-13 15:04:57+00	t	10	9:55:28	\N	\N
1451	2025-01-13 02:35:47+00	2025-01-13 13:02:29+00	t	16	10:26:42	\N	\N
1453	2025-01-13 03:46:33+00	2025-01-13 13:04:14+00	t	20	9:17:41	\N	\N
1517	2025-01-23 04:59:51+00	2025-01-23 15:07:42+00	t	18	10:7:51	\N	\N
1457	2025-01-13 11:56:45+00	2025-01-13 15:00:58+00	t	64	3:4:13	\N	\N
1456	2025-01-13 11:13:43+00	2025-01-13 15:05:13+00	t	19	3:51:30	\N	\N
1458	2025-01-14 03:29:49+00	\N	t	66	\N	\N	\N
1493	2025-01-20 03:38:15+00	2025-01-20 15:11:20+00	t	10	11:33:5	\N	\N
1532	2025-01-25 05:28:53+00	2025-01-25 09:15:13+00	t	18	3:46:20	\N	\N
1459	2025-01-14 03:43:55+00	2025-01-14 11:09:49+00	t	17	7:25:54	\N	\N
1497	2025-01-20 04:05:46+00	2025-01-20 15:29:32+00	t	18	11:23:46	\N	\N
1461	2025-01-14 03:45:54+00	2025-01-14 13:01:09+00	t	16	9:15:15	\N	\N
1513	2025-01-23 03:29:06+00	2025-01-23 15:10:28+00	t	10	11:41:22	\N	\N
1460	2025-01-14 03:44:01+00	2025-01-14 13:01:09+00	t	20	9:17:8	\N	\N
1498	2025-01-20 10:19:07+00	2025-01-20 16:00:03+00	t	19	5:40:56	\N	\N
1462	2025-01-14 06:24:19+00	2025-01-14 14:34:06+00	t	10	8:9:47	exam boldy	#7551E9
1464	2025-01-14 11:25:46+00	2025-01-14 14:58:21+00	t	19	3:32:35	\N	\N
1463	2025-01-14 06:41:58+00	2025-01-14 15:51:24+00	t	18	9:9:26	\N	\N
1469	2025-01-15 03:52:59+00	\N	t	10	\N	\N	\N
1470	2025-01-15 04:36:11+00	2025-01-15 06:10:12+00	t	18	1:34:1	\N	\N
1466	2025-01-15 03:50:24+00	2025-01-15 12:54:29+00	t	17	9:4:5	\N	\N
1468	2025-01-15 03:51:00+00	2025-01-15 12:59:43+00	t	20	\N	\N	\N
1467	2025-01-15 03:50:46+00	2025-01-15 12:59:43+00	t	20	9:8:57	\N	\N
1465	2025-01-15 02:37:55+00	2025-01-15 13:01:49+00	t	16	10:23:54	\N	\N
1471	2025-01-15 07:27:42+00	2025-01-15 13:01:58+00	t	18	5:34:16	\N	\N
1521	2025-01-24 03:30:11+00	\N	t	10	\N	\N	\N
1472	2025-01-15 10:51:29+00	2025-01-15 13:21:05+00	t	19	2:29:36	\N	\N
1503	2025-01-21 03:57:20+00	2025-01-21 11:21:30+00	t	17	7:24:10	Zähmet biržasyna hasabat tabşyrmana gitdim 16sagat 20 min	#7551E9
1473	2025-01-15 12:00:52+00	2025-01-15 13:33:22+00	t	64	1:32:30	\N	\N
1475	2025-01-16 03:55:43+00	\N	t	20	\N	\N	\N
1476	2025-01-16 04:10:02+00	2025-01-16 13:03:07+00	t	16	8:53:5	\N	\N
1477	2025-01-16 04:12:51+00	2025-01-16 14:41:18+00	t	18	10:28:27	\N	\N
1501	2025-01-21 03:56:18+00	2025-01-21 13:23:41+00	t	16	9:27:23	\N	\N
1474	2025-01-16 03:39:40+00	2025-01-16 15:05:34+00	t	10	11:25:54	\N	\N
1478	2025-01-16 11:52:23+00	2025-01-16 15:06:33+00	t	19	3:14:10	\N	\N
1480	2025-01-17 03:38:24+00	\N	t	10	\N	\N	\N
1502	2025-01-21 03:57:09+00	2025-01-21 13:25:53+00	t	20	9:28:44	\N	\N
1479	2025-01-17 02:59:35+00	2025-01-17 13:01:34+00	t	16	10:1:59	\N	\N
1482	2025-01-17 03:53:45+00	2025-01-17 13:10:07+00	t	17	9:16:22	\N	\N
1506	2025-01-21 12:12:47+00	2025-01-21 14:42:50+00	t	64	2:30:3	\N	\N
1481	2025-01-17 03:52:37+00	2025-01-17 13:10:48+00	t	20	9:18:11	\N	\N
1483	2025-01-17 05:27:42+00	2025-01-17 13:38:16+00	t	18	8:10:34	\N	\N
1500	2025-01-21 03:26:49+00	2025-01-21 15:16:23+00	t	10	11:49:34	\N	\N
1484	2025-01-17 11:28:17+00	2025-01-17 14:21:09+00	t	19	2:52:52	\N	\N
1505	2025-01-21 11:12:43+00	2025-01-21 15:26:39+00	t	19	4:13:56	\N	\N
1485	2025-01-18 02:58:39+00	2025-01-18 08:00:32+00	t	16	5:1:53	\N	\N
1486	2025-01-18 03:47:57+00	2025-01-18 08:00:34+00	t	17	4:12:37	\N	\N
1504	2025-01-21 05:56:00+00	2025-01-21 15:47:19+00	t	18	9:51:19	\N	\N
1488	2025-01-18 03:49:00+00	2025-01-18 08:24:49+00	t	20	\N	\N	\N
1487	2025-01-18 03:48:12+00	2025-01-18 08:24:49+00	t	20	4:36:37	\N	\N
1490	2025-01-18 09:20:56+00	2025-01-18 14:14:00+00	t	18	4:53:4	\N	\N
1489	2025-01-18 07:42:33+00	2025-01-18 14:44:54+00	t	10	7:2:21	bellemegi unutdum	#7551E9
1491	2025-01-18 11:33:00+00	2025-01-18 15:12:34+00	t	64	3:39:34	\N	\N
1492	2025-01-18 12:11:57+00	2025-01-18 15:43:08+00	t	19	3:31:11	\N	\N
1494	2025-01-20 03:47:07+00	\N	t	17	\N	Intellektual eýeçilik Sertifikady almaga gitdim 	#7551E9
1496	2025-01-20 03:54:55+00	2025-01-20 13:00:31+00	t	16	9:5:36	\N	\N
1495	2025-01-20 03:47:59+00	2025-01-20 13:03:21+00	t	20	9:15:22	\N	\N
1523	2025-01-24 05:07:05+00	2025-01-24 13:11:26+00	t	18	8:4:21	\N	\N
1499	2025-01-20 11:45:11+00	2025-01-20 14:46:40+00	t	64	3:1:29	\N	\N
1508	2025-01-22 03:53:20+00	2025-01-22 13:00:36+00	t	20	9:7:16	\N	\N
1507	2025-01-22 03:48:52+00	2025-01-22 13:03:41+00	t	16	9:14:49	\N	\N
1524	2025-01-24 05:48:21+00	2025-01-24 13:34:24+00	t	69	7:46:3	\N	\N
1509	2025-01-22 03:53:28+00	2025-01-22 13:04:34+00	t	17	9:11:6	\N	\N
1512	2025-01-22 11:21:00+00	2025-01-22 15:13:39+00	t	19	3:52:39	\N	\N
1522	2025-01-24 03:47:48+00	2025-01-24 13:39:40+00	t	20	9:51:52	\N	\N
1510	2025-01-22 04:49:27+00	2025-01-22 15:15:39+00	t	10	10:26:12	\N	\N
1534	2025-01-25 09:33:12+00	2025-01-25 12:06:12+00	t	18	2:33:0	\N	\N
1511	2025-01-22 07:57:31+00	2025-01-22 15:58:39+00	t	18	8:1:8	\N	\N
1520	2025-01-24 03:10:11+00	2025-01-24 13:40:09+00	t	16	10:29:58	\N	\N
1516	2025-01-23 03:53:19+00	2025-01-23 13:00:14+00	t	20	9:6:55	\N	\N
1515	2025-01-23 03:53:01+00	2025-01-23 13:00:25+00	t	16	9:7:24	\N	\N
1525	2025-01-24 06:15:12+00	2025-01-24 13:52:34+00	t	17	7:37:22	\N	\N
1514	2025-01-23 03:46:02+00	2025-01-23 13:00:55+00	t	17	9:14:53	\N	\N
1518	2025-01-23 10:55:42+00	2025-01-23 14:49:22+00	t	19	3:53:40	\N	\N
1535	2025-01-25 09:42:52+00	2025-01-25 14:06:07+00	t	19	4:23:15	\N	\N
1519	2025-01-23 11:54:28+00	2025-01-23 15:04:55+00	t	64	3:10:27	\N	\N
1536	2025-01-27 03:02:08+00	\N	t	16	\N	\N	\N
1527	2025-01-24 14:04:41+00	2025-01-24 14:04:42+00	t	64	0:0:1	\N	\N
1537	2025-01-27 03:38:51+00	\N	t	10	\N	\N	\N
1526	2025-01-24 10:09:24+00	2025-01-24 14:39:56+00	t	19	4:30:32	\N	\N
1533	2025-01-25 07:52:56+00	\N	t	17	\N	Telekeçiler birleşmesine gitdim	#7551E9
1538	2025-01-27 03:52:12+00	\N	t	17	\N	\N	\N
1530	2025-01-25 03:42:14+00	2025-01-25 07:54:57+00	t	10	4:12:43	\N	\N
1531	2025-01-25 03:44:15+00	2025-01-25 07:57:39+00	t	69	4:13:24	\N	\N
1528	2025-01-25 03:16:24+00	2025-01-25 08:00:30+00	t	20	4:44:6	\N	\N
1529	2025-01-25 03:32:19+00	2025-01-25 08:00:31+00	t	16	4:28:12	\N	\N
1541	2025-01-27 04:57:24+00	2025-01-27 13:02:56+00	t	69	8:5:32	\N	\N
1539	2025-01-27 03:52:30+00	2025-01-27 13:05:35+00	t	20	9:13:5	\N	\N
1542	2025-01-27 10:37:09+00	2025-01-27 14:12:19+00	t	19	3:35:10	\N	\N
1546	2025-01-28 03:48:58+00	2025-01-28 13:16:31+00	t	17	9:27:33	Statistikadan žurnal almaga gitdim	#7551E9
1540	2025-01-27 04:33:17+00	2025-01-27 14:18:09+00	t	18	9:44:52	\N	\N
1543	2025-01-27 11:24:17+00	2025-01-27 14:39:54+00	t	64	3:15:37	\N	\N
1549	2025-01-28 05:37:32+00	2025-01-28 14:47:20+00	t	18	9:9:48	\N	\N
1548	2025-01-28 05:06:14+00	2025-01-28 13:14:58+00	t	69	8:8:44	\N	\N
1544	2025-01-28 02:30:02+00	2025-01-28 14:18:24+00	t	16	11:48:22	\N	\N
1547	2025-01-28 03:49:32+00	2025-01-28 13:15:02+00	t	20	9:25:30	\N	\N
1550	2025-01-28 11:19:58+00	2025-01-28 15:55:42+00	t	19	4:35:44	\N	\N
1545	2025-01-28 03:42:43+00	2025-01-28 14:55:28+00	t	10	11:12:45	\N	\N
1556	2025-01-29 09:35:31+00	2025-01-29 13:04:23+00	t	17	3:28:52	\N	\N
1554	2025-01-29 03:55:36+00	2025-01-29 13:05:24+00	t	20	9:9:48	\N	\N
1551	2025-01-29 02:54:28+00	2025-01-29 13:05:50+00	t	16	10:11:22	\N	\N
1553	2025-01-29 03:38:57+00	2025-01-29 13:21:38+00	t	69	9:42:41	\N	\N
1555	2025-01-29 05:28:25+00	2025-01-29 14:26:34+00	t	18	8:58:9	\N	\N
1557	2025-01-29 11:06:01+00	2025-01-29 15:38:46+00	t	19	4:32:45	\N	\N
1552	2025-01-29 03:25:18+00	2025-01-29 15:40:09+00	t	10	12:14:51	\N	\N
1560	2025-01-30 03:53:10+00	2025-01-30 13:04:46+00	t	69	9:11:36	\N	\N
1561	2025-01-30 03:55:19+00	2025-01-30 13:05:02+00	t	17	9:9:43	\N	\N
1562	2025-01-30 03:55:40+00	2025-01-30 13:21:01+00	t	20	9:25:21	\N	\N
1563	2025-01-30 05:56:25+00	2025-01-30 13:33:21+00	t	18	7:36:56	\N	\N
1564	2025-01-30 10:32:17+00	2025-01-30 14:14:09+00	t	19	3:41:52	\N	\N
1559	2025-01-30 03:39:58+00	2025-01-30 13:21:02+00	t	16	9:41:4	\N	\N
1558	2025-01-30 03:35:11+00	2025-01-30 14:49:45+00	t	10	11:14:34	\N	\N
1566	2025-01-31 03:29:30+00	\N	t	69	\N	\N	\N
1611	2025-02-07 04:03:40+00	2025-02-07 12:51:30+00	t	20	8:47:50	\N	\N
1571	2025-01-31 08:16:18+00	2025-01-31 12:24:34+00	t	19	4:8:16	\N	\N
1568	2025-01-31 03:54:01+00	2025-01-31 13:06:49+00	t	17	9:12:48	\N	\N
1606	2025-02-07 03:18:27+00	2025-02-07 12:52:58+00	t	69	9:34:31	\N	\N
1569	2025-01-31 03:54:16+00	2025-01-31 13:15:31+00	t	20	9:21:15	\N	\N
1565	2025-01-31 03:07:07+00	2025-01-31 13:16:01+00	t	16	10:8:54	\N	\N
1607	2025-02-07 03:37:37+00	2025-02-07 13:02:11+00	t	10	9:24:34	\N	\N
1567	2025-01-31 03:39:14+00	2025-01-31 15:05:43+00	t	10	11:26:29	\N	\N
1570	2025-01-31 06:09:06+00	2025-01-31 15:16:26+00	t	18	9:7:20	\N	\N
1577	2025-02-01 06:14:28+00	\N	t	18	\N	\N	\N
1609	2025-02-07 03:58:56+00	2025-02-07 13:05:20+00	t	19	9:6:24	\N	\N
1576	2025-02-01 04:35:12+00	2025-02-01 07:56:31+00	t	69	3:21:19	\N	\N
1645	2025-02-14 03:10:44+00	\N	t	10	\N	\N	\N
1572	2025-02-01 02:28:39+00	2025-02-01 08:00:30+00	t	16	5:31:51	\N	\N
1608	2025-02-07 03:56:34+00	2025-02-07 15:06:05+00	t	16	11:9:31	\N	\N
1574	2025-02-01 03:44:12+00	2025-02-01 08:00:44+00	t	17	4:16:32	\N	\N
1575	2025-02-01 03:44:44+00	2025-02-01 08:02:37+00	t	20	4:17:53	\N	\N
1573	2025-02-01 03:28:45+00	2025-02-01 12:48:39+00	t	10	9:19:54	\N	\N
1614	2025-02-08 04:00:20+00	\N	t	19	\N	\N	\N
1578	2025-02-01 08:53:47+00	2025-02-01 13:00:29+00	t	19	4:6:42	\N	\N
1580	2025-02-03 03:44:03+00	\N	t	16	\N	\N	\N
1615	2025-02-08 04:00:28+00	\N	t	19	\N	\N	\N
1583	2025-02-03 03:47:15+00	2025-02-03 12:57:52+00	t	69	9:10:37	\N	\N
1581	2025-02-03 03:46:17+00	2025-02-03 13:00:28+00	t	17	9:14:11	\N	\N
1582	2025-02-03 03:46:30+00	2025-02-03 13:01:27+00	t	20	9:14:57	\N	\N
1635	2025-02-12 04:03:34+00	2025-02-12 13:01:07+00	t	20	8:57:33	\N	\N
1584	2025-02-03 04:25:50+00	2025-02-03 14:31:10+00	t	18	10:5:20	\N	\N
1616	2025-02-08 04:05:58+00	2025-02-08 08:00:28+00	t	20	3:54:30	\N	\N
1585	2025-02-03 11:13:30+00	2025-02-03 14:46:16+00	t	19	3:32:46	\N	\N
1646	2025-02-14 03:29:16+00	\N	t	16	\N	\N	\N
1579	2025-02-03 03:42:05+00	2025-02-03 14:49:21+00	t	10	11:7:16	\N	\N
1612	2025-02-08 02:44:32+00	2025-02-08 08:00:41+00	t	16	5:16:9	\N	\N
1588	2025-02-04 03:55:57+00	2025-02-04 12:54:14+00	t	69	8:58:17	\N	\N
1634	2025-02-12 04:03:14+00	2025-02-12 13:03:45+00	t	17	9:0:31	\N	\N
1589	2025-02-04 04:01:14+00	2025-02-04 12:54:27+00	t	20	8:53:13	\N	\N
1617	2025-02-08 04:07:34+00	2025-02-08 08:03:05+00	t	69	3:55:31	\N	\N
1591	2025-02-04 06:54:52+00	2025-02-04 12:54:38+00	t	17	5:59:46	\N	\N
1647	2025-02-14 03:52:41+00	\N	t	17	\N	\N	\N
1613	2025-02-08 03:36:34+00	2025-02-08 11:17:55+00	t	10	7:41:21	\N	\N
1587	2025-02-04 03:29:51+00	2025-02-04 12:54:39+00	t	10	9:24:48	ir basypdyryna	#7551E9
1586	2025-02-04 02:38:32+00	2025-02-04 12:56:26+00	t	16	10:17:54	\N	\N
1593	2025-02-04 12:59:18+00	2025-02-04 13:00:15+00	t	16	0:0:57	\N	\N
1590	2025-02-04 04:18:03+00	2025-02-04 13:13:29+00	t	18	8:55:26	\N	\N
1621	2025-02-10 04:15:30+00	\N	t	19	\N	\N	\N
1592	2025-02-04 10:32:29+00	2025-02-04 14:33:59+00	t	19	4:1:30	\N	\N
1597	2025-02-05 03:55:40+00	\N	t	17	\N	\N	\N
1594	2025-02-05 03:39:16+00	2025-02-05 13:06:16+00	t	10	9:27:0	\N	\N
1637	2025-02-12 09:19:44+00	2025-02-12 13:04:42+00	t	69	3:44:58	\N	\N
1596	2025-02-05 03:49:48+00	2025-02-05 13:32:18+00	t	69	9:42:30	\N	\N
1595	2025-02-05 03:44:00+00	2025-02-05 13:33:08+00	t	16	9:49:8	\N	\N
1648	2025-02-14 03:52:53+00	\N	t	20	\N	\N	\N
1598	2025-02-05 03:56:18+00	2025-02-05 13:54:04+00	t	20	9:57:46	\N	\N
1619	2025-02-10 03:59:41+00	2025-02-10 13:02:26+00	t	17	9:2:45	\N	\N
1599	2025-02-05 11:40:09+00	2025-02-05 15:53:24+00	t	19	4:13:15	\N	\N
1604	2025-02-06 03:49:09+00	\N	t	20	\N	\N	\N
1633	2025-02-12 03:56:18+00	2025-02-12 13:05:35+00	t	19	9:9:17	\N	\N
1601	2025-02-06 03:28:20+00	2025-02-06 13:00:24+00	t	69	9:32:4	\N	\N
1618	2025-02-10 03:49:22+00	2025-02-10 13:02:27+00	t	16	9:13:5	\N	\N
1603	2025-02-06 03:47:34+00	2025-02-06 13:02:24+00	t	17	9:14:50	\N	\N
1649	2025-02-14 03:54:05+00	\N	t	19	\N	\N	\N
1600	2025-02-06 02:46:43+00	2025-02-06 13:03:31+00	t	16	10:16:48	\N	\N
1620	2025-02-10 04:00:57+00	2025-02-10 13:03:00+00	t	20	9:2:3	\N	\N
1605	2025-02-06 04:59:59+00	2025-02-06 13:07:58+00	t	19	8:7:59	\N	\N
1636	2025-02-12 04:03:39+00	2025-02-12 13:42:19+00	t	18	9:38:40	\N	\N
1602	2025-02-06 03:33:28+00	2025-02-06 15:01:18+00	t	10	11:27:50	\N	\N
1610	2025-02-07 04:03:31+00	\N	t	17	\N	\N	\N
1650	2025-02-14 04:02:33+00	\N	t	18	\N	\N	\N
1622	2025-02-10 04:53:17+00	2025-02-10 13:03:15+00	t	10	8:9:58	praktika bardyk	#7551E9
1631	2025-02-12 03:21:57+00	2025-02-12 14:56:51+00	t	10	11:34:54	\N	\N
1623	2025-02-10 10:20:40+00	2025-02-10 13:09:28+00	t	69	2:48:48	\N	\N
1627	2025-02-11 03:52:54+00	\N	t	20	\N	\N	\N
1626	2025-02-11 03:52:35+00	2025-02-11 13:01:18+00	t	17	9:8:43	\N	\N
1624	2025-02-11 01:58:46+00	2025-02-11 13:06:44+00	t	16	11:7:58	\N	\N
1630	2025-02-11 13:11:19+00	2025-02-11 13:11:41+00	t	18	0:0:22	irden geldim , bellemegi unutdym	#9FC2A5
1629	2025-02-11 10:08:28+00	2025-02-11 13:15:28+00	t	69	3:7:0	\N	\N
1628	2025-02-11 04:16:03+00	2025-02-11 14:06:22+00	t	19	9:50:19	\N	\N
1625	2025-02-11 03:39:01+00	2025-02-11 14:58:23+00	t	10	11:19:22	\N	\N
1632	2025-02-12 03:50:29+00	\N	t	16	\N	\N	\N
1641	2025-02-13 03:58:43+00	2025-02-13 12:58:21+00	t	19	8:59:38	\N	\N
1640	2025-02-13 03:57:59+00	2025-02-13 13:00:12+00	t	17	9:2:13	\N	\N
1639	2025-02-13 03:57:14+00	2025-02-13 13:00:19+00	t	20	9:3:5	\N	\N
1644	2025-02-13 09:34:26+00	2025-02-13 13:04:03+00	t	69	3:29:37	\N	\N
1638	2025-02-13 03:43:00+00	2025-02-13 13:19:39+00	t	16	9:36:39	\N	\N
1642	2025-02-13 04:01:33+00	2025-02-13 14:05:13+00	t	18	10:3:40	\N	\N
1643	2025-02-13 04:33:12+00	2025-02-13 15:01:03+00	t	10	10:27:51	praktika	#7551E9
\.


--
-- Data for Name: LaborProtections; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."LaborProtections" (id, title, description, "createdAt", "updatedAt") FROM stdin;
547ac850-225e-410f-b110-177681110c3a	Ýerine yetirmeli işler	Her gün:\n\nHer aý:\n1. Her aýyň soňunda arendanyň tölegi geçenligi barada töleg tabsyrygy getirimeli (stolumda goýmaly). \n2. Her aýyň soňunda her işgäre naçe manat kartyna aýylyk geçirendigiňiz barada elektron ýagdaýda poçtama ugratmaly. 	2024-12-27 04:45:33.853+00	2024-12-27 04:57:52.216+00
feb43190-478c-4b03-bc0d-b8800a988d3e	Alem Tilsimat HJ içki tertip düzgünleri	Mail:\n1. Alem Tilsimat HJ mailyny ulanan ýagdaýyňyzda hökmany ýagdaýda öz dogry adyňyz we familiýaňyz bolmaly. Surat goýan halatyňyzda diňe öz suratyňyzy goýmaly yada suratsyz goýup bilersiňiz.\n2. Islendik ýazylýan hatyň temasy bolmaly we boş goýmaly däl.\n\nInternet:\n1. Internetde diňe iş bilen bagly web saýtlara girmeli we uly faýyllar ýükläp (trafik ulanyp) päsgelçilik döretmeli däl\n2. Internet gurşawuny peýdalananyňyzda ulanýan materiýallaryňyza we girýän ähli web saýtlaryň bilen bagly ähli işlere hut özüňiz Türkmenistanyň kanunyna laýyklykda jogap berýänsiňiz.\n3. Internet gurşawuny peýdalananyňyzda dürli wiruslardan goramak üçin kompaniýa tarapyndan firewall ulanylýar, şeýle hem bu firewall ulanyjy tarapyndan girilýän we ulanýan maglumatlaryňyzy ýatda saklaýar, seljerilýär we analiz edilýär.\n\nHususy we firma degişli emläkler:\nNoutbuk, klawiatura, myşka, goşmaça ekran, kreslo, stol, çekme we ş.m. wagtlaýyn ulanmaga berilen firma degişli ähli enjamlara siz doly jogap berýärsiňiz we ulanyş döwründe siziň seresapsyzlygyňyz bilen ýüze çykan ähli kemçilikleri öz hasabyňyza düzetmelisiňiz. \nSiz sebäpli firmanyň, işgärleriň, myhmanlaryň eýeçiligindäki zatlara zeper ýetse siz öz hasabyňyza öwezini dolmalysyňyz. \nÖz hususy zadyňyz ya-da size wagtlaýyn ulanmaga berilmedik islendik zady (printer, kreslo, zarýatnik, nauşnik, nahar, suw, bir bölek çörek we ş.m.) birugsat ellemek bolmaýar. 	2024-12-08 06:24:49.154+00	2025-01-04 04:46:27.154+00
\.


--
-- Data for Name: UserLaborProtection; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."UserLaborProtection" ("createdAt", "updatedAt", "userId", "LaborProtectionId") FROM stdin;
2024-12-27 04:45:33.863+00	2024-12-27 04:45:33.863+00	17	547ac850-225e-410f-b110-177681110c3a
\.


--
-- Data for Name: chats; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.chats (id, "participantOne", "participantTwo", "createdAt", "updatedAt") FROM stdin;
7a4fdada-b415-47c8-8741-280528e55129	9	16	2024-08-19 14:20:29.016+00	2024-08-19 14:20:29.016+00
eda2e444-2066-419c-8464-3ebd46ca63ac	16	9	2024-08-19 14:20:29.021+00	2024-08-19 14:20:29.021+00
d07c1f42-6ea3-4b03-8289-9e9a9437814f	16	14	2024-08-19 14:26:35.081+00	2024-08-19 14:26:35.081+00
a9d75f75-1529-4abe-9e9c-230b78295cbb	14	16	2024-08-19 14:26:35.085+00	2024-08-19 14:26:35.085+00
526f1d0a-72eb-4c18-98c0-12710dba9f23	16	18	2024-08-19 14:30:14.108+00	2024-08-19 14:30:14.108+00
06a5c33c-30c3-4031-b73b-5d6526aad35b	18	16	2024-08-19 14:30:14.113+00	2024-08-19 14:30:14.113+00
502cfe29-3cc0-4b57-92c4-40d14ea40993	16	8	2024-08-20 03:54:06.205+00	2024-08-20 03:54:06.205+00
37ade6ce-4043-45ba-93a2-1e00bdf30e14	8	16	2024-08-20 03:54:06.209+00	2024-08-20 03:54:06.209+00
9b78f2be-7c2d-4269-978b-cc1eec384fe4	14	8	2024-08-20 03:59:07.36+00	2024-08-20 03:59:07.36+00
96140700-7944-4ec4-9ec9-81cd4fbf673b	8	14	2024-08-20 03:59:07.368+00	2024-08-20 03:59:07.368+00
ab1f3414-8224-4061-baec-bf22bd676420	8	10	2024-08-20 04:00:02.638+00	2024-08-20 04:00:02.638+00
bb17636c-1a36-4606-b159-8b9b9426eb8d	10	8	2024-08-20 04:00:02.641+00	2024-08-20 04:00:02.641+00
c921d1fa-115c-4ef8-a422-fe0d24657720	16	20	2024-08-20 04:04:06.211+00	2024-08-20 04:04:06.211+00
fd6baea6-a931-4869-9b77-450bc891215a	20	16	2024-08-20 04:04:06.219+00	2024-08-20 04:04:06.219+00
1800e9fd-f0be-49a2-bdb0-82ae634f3f30	16	5	2024-08-20 04:37:13.564+00	2024-08-20 04:37:13.564+00
ead23234-0e53-4e83-8ffc-a52d3526dfa5	5	16	2024-08-20 04:37:13.568+00	2024-08-20 04:37:13.568+00
c8bf3fef-1f7a-446c-978e-e1dd94544fb0	16	10	2024-08-20 04:38:53.261+00	2024-08-20 04:38:53.261+00
697f696c-94cd-4eaf-9747-aca46c979f71	10	16	2024-08-20 04:38:53.264+00	2024-08-20 04:38:53.264+00
a5a1ac77-3218-4729-85ba-0b52b50974fd	23	16	2024-08-20 05:02:37.184+00	2024-08-20 05:02:37.184+00
3f2d85b0-1ec8-4730-9e3a-c7a2b841c27c	16	23	2024-08-20 05:02:37.188+00	2024-08-20 05:02:37.188+00
1f1147f8-61d9-46aa-b19e-2c95c2825721	16	19	2024-08-20 10:06:31.021+00	2024-08-20 10:06:31.021+00
5c614b47-892d-4719-8d77-ae96fb691d1c	19	16	2024-08-20 10:06:31.026+00	2024-08-20 10:06:31.026+00
15d50223-2f73-4260-a613-fc084000dd7d	18	10	2024-08-20 10:23:27.357+00	2024-08-20 10:23:27.357+00
36e5f8bd-beba-467b-8ee5-e653940a0b43	10	18	2024-08-20 10:23:27.36+00	2024-08-20 10:23:27.36+00
82b2aba3-106a-437a-af6a-146d8d2c5913	18	19	2024-08-20 10:25:34.067+00	2024-08-20 10:25:34.067+00
b983e5dc-775a-4d67-8cb9-a97c4a57935b	19	18	2024-08-20 10:25:34.075+00	2024-08-20 10:25:34.075+00
91eef835-ed65-49bd-abac-42f310875287	24	9	2024-08-20 11:49:10.789+00	2024-08-20 11:49:10.789+00
cf3e9840-dd0a-4c13-b416-6a0e1b5faf87	9	24	2024-08-20 11:49:10.797+00	2024-08-20 11:49:10.797+00
01f6b688-61f7-4cd6-a191-da2dddfe4d0d	18	24	2024-08-22 09:10:12.018+00	2024-08-22 09:10:12.018+00
a10e7f0e-58cc-49cc-9c30-30a1df4a645c	24	18	2024-08-22 09:10:12.023+00	2024-08-22 09:10:12.023+00
ff169eee-371c-4bd5-b589-86c17988afc2	9	5	2024-08-23 03:58:46.625+00	2024-08-23 03:58:46.625+00
58dcb5fb-c2d3-4d3c-bc50-9f147f4977f3	5	9	2024-08-23 03:58:46.637+00	2024-08-23 03:58:46.637+00
2ea8c84c-92c9-4f9b-bc56-7d1c31cff6da	9	5	2024-08-23 03:58:52.118+00	2024-08-23 03:58:52.118+00
d5cb5ea4-5918-4872-88dc-855ee7e8f14a	5	9	2024-08-23 03:58:52.122+00	2024-08-23 03:58:52.122+00
524d22c5-a91d-4051-863e-72c944d8b7d1	9	10	2024-08-23 03:58:57.948+00	2024-08-23 03:58:57.948+00
84edf44f-49fe-43dd-9b60-e8d01e2533ca	10	9	2024-08-23 03:58:57.954+00	2024-08-23 03:58:57.954+00
ce0ca34e-4af2-41d9-8bbe-841e9ca20002	19	10	2024-08-26 06:37:01.605+00	2024-08-26 06:37:01.605+00
5b75b005-f04d-49ee-bbfd-7d982a0e743f	10	19	2024-08-26 06:37:01.609+00	2024-08-26 06:37:01.609+00
2c55a863-28c9-4ded-b9e1-d03096d8207c	19	8	2024-08-26 06:37:08.369+00	2024-08-26 06:37:08.369+00
08c54956-af8b-48aa-a215-049c75641f35	8	19	2024-08-26 06:37:08.372+00	2024-08-26 06:37:08.372+00
b729f2f4-82c7-4735-89bb-8bb366e9adba	15	14	2024-08-31 09:49:58.64+00	2024-08-31 09:49:58.64+00
c4317f17-4338-469a-80f3-ed932fdd9f1e	14	15	2024-08-31 09:49:58.645+00	2024-08-31 09:49:58.645+00
9386c6e4-54d0-40f8-a098-f8a3d62381c6	26	16	2024-09-03 03:06:56.897+00	2024-09-03 03:06:56.897+00
4ec3dc05-e2d6-4305-9543-887a4a3bec7d	16	26	2024-09-03 03:06:56.906+00	2024-09-03 03:06:56.906+00
f4f91f9f-412d-48e1-8fad-7c75f909f94e	27	16	2024-09-06 09:08:53.63+00	2024-09-06 09:08:53.63+00
b3e12564-bd8a-4548-9838-0f99ebccfb2f	16	27	2024-09-06 09:08:53.634+00	2024-09-06 09:08:53.634+00
e6b99092-f4bc-4154-b9bb-e11201d59fe1	9	28	2024-10-18 15:11:29.682+00	2024-10-18 15:11:29.682+00
59955386-ae4f-4f88-bf42-a4c450b94845	28	9	2024-10-18 15:11:29.686+00	2024-10-18 15:11:29.686+00
e4666499-5919-4912-9557-737e8cb67c7f	18	28	2024-10-19 11:26:07.553+00	2024-10-19 11:26:07.553+00
f357c224-8ba7-435a-a76b-e4b0b6af7690	28	18	2024-10-19 11:26:07.56+00	2024-10-19 11:26:07.56+00
24397af7-9575-44ab-99ff-1909adc65181	9	18	2024-10-19 13:44:04.511+00	2024-10-19 13:44:04.511+00
840fecce-1cef-403b-ab6f-21d94ba1f614	18	9	2024-10-19 13:44:04.522+00	2024-10-19 13:44:04.522+00
010e465e-eac7-4507-a221-d769ed168818	18	29	2024-10-21 04:39:01.076+00	2024-10-21 04:39:01.076+00
e68176e5-16ef-4d6f-8a84-e1f706aea1c0	29	18	2024-10-21 04:39:01.08+00	2024-10-21 04:39:01.08+00
02c06f28-c96f-44ea-8520-4dba052b9b55	9	19	2024-10-22 14:21:02.035+00	2024-10-22 14:21:02.035+00
92475336-f85c-4b75-8a60-8da3abf6bb79	19	9	2024-10-22 14:21:02.04+00	2024-10-22 14:21:02.04+00
6fd2dea6-c71b-4084-b9c1-a27cdb6a9b13	17	16	2024-10-25 04:24:29.581+00	2024-10-25 04:24:29.581+00
43e90f88-9e46-46f6-ad66-e602b8247f9a	16	17	2024-10-25 04:24:29.586+00	2024-10-25 04:24:29.586+00
8b72172e-c4b3-4f7f-9393-11ce457b929f	26	8	2024-10-31 12:18:26.559+00	2024-10-31 12:18:26.559+00
9e01da12-a5f7-4962-9d26-36c036a55ba5	8	26	2024-10-31 12:18:26.564+00	2024-10-31 12:18:26.564+00
29c38e90-e868-4f9f-8603-cec6f0691c75	26	14	2024-11-18 11:10:35.832+00	2024-11-18 11:10:35.832+00
196c1b69-056e-423e-8627-f5df50f20f8c	14	26	2024-11-18 11:10:35.836+00	2024-11-18 11:10:35.836+00
094e9b25-e624-45f5-9091-a4e61a04cc12	26	9	2024-12-09 13:26:55.682+00	2024-12-09 13:26:55.682+00
64e6f1bc-b4cf-4966-a64a-65699d9ca05e	9	26	2024-12-09 13:26:55.687+00	2024-12-09 13:26:55.687+00
574bfcc6-95cc-470b-8ca2-ba09975da04f	64	28	2024-12-09 13:27:49.662+00	2024-12-09 13:27:49.662+00
1da2dfb2-2fdd-4be3-90fe-4622e6b9daf0	28	64	2024-12-09 13:27:49.67+00	2024-12-09 13:27:49.67+00
d8c6bd20-971b-40b4-94fe-59c2f0148a1f	64	26	2024-12-09 13:47:37.157+00	2024-12-09 13:47:37.157+00
bae20e64-7911-49bb-b764-2a7d9d0450c3	26	64	2024-12-09 13:47:37.168+00	2024-12-09 13:47:37.168+00
3cbc2c04-94b7-4702-96cd-ac2fce3cc397	16	66	2024-12-14 05:29:37.892+00	2024-12-14 05:29:37.892+00
8ec5c5f0-0c92-49f0-9b70-da9898ef7dc8	66	16	2024-12-14 05:29:37.896+00	2024-12-14 05:29:37.896+00
64e8cdd5-65a0-4c49-a947-4b78985543e8	69	16	2025-01-25 03:45:37.853+00	2025-01-25 03:45:37.853+00
3e7d6c5a-9449-483b-aee5-eaa942a825c0	16	69	2025-01-25 03:45:37.867+00	2025-01-25 03:45:37.867+00
\.


--
-- Data for Name: holidays; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.holidays (id, name, date, color, "createdAt", "updatedAt") FROM stdin;
fe6da5d3-fc74-4d16-a846-cc5549f3fc32	Tazelendi updata	2024-06-28	#88888	2024-11-26 11:50:18.181+00	2024-11-26 12:28:19.099+00
9e43a0e9-f11f-4e31-aa41-9f1ba59d7a65	Täze ýyl baýramçylygy	2024-12-31	#4CAF50	2024-12-04 11:09:18.627+00	2024-12-04 11:09:18.627+00
c00a91f4-f3cb-4d20-be49-2e48f986f410	Bitaraplyk güni	2024-12-12	#05dac5	2024-11-28 04:38:49.365+00	2024-12-18 04:53:34.381+00
\.


--
-- Data for Name: messagges; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.messagges (id, text, read, "senderId", "receiverId", "createdAt", "updatedAt", "chatId") FROM stdin;
c5ccb7b9-b6ea-4cca-9f14-da91780a5368	Salam	f	9	16	2024-08-19 14:20:34.738+00	2024-08-19 14:20:34.738+00	7a4fdada-b415-47c8-8741-280528e55129
c7251099-d959-4a7f-93f5-8312e9161653	Salam	f	9	16	2024-08-19 14:20:34.744+00	2024-08-19 14:20:34.744+00	eda2e444-2066-419c-8464-3ebd46ca63ac
cde091f4-be31-41af-a2dc-4fd0613586be	Google morning	f	16	14	2024-08-19 14:26:45.535+00	2024-08-19 14:26:45.535+00	d07c1f42-6ea3-4b03-8289-9e9a9437814f
e4385d9b-c6b1-4d81-83a0-79a41ab0484e	Google morning	f	16	14	2024-08-19 14:26:45.54+00	2024-08-19 14:26:45.54+00	a9d75f75-1529-4abe-9e9c-230b78295cbb
e615697a-c982-4f33-86f3-06f91235b9de	Esalamalikim abjim	f	14	16	2024-08-19 14:27:44.311+00	2024-08-19 14:27:44.311+00	a9d75f75-1529-4abe-9e9c-230b78295cbb
72f04955-0354-4876-9fd4-93bda0d9428b	Esalamalikim abjim	f	14	16	2024-08-19 14:27:44.32+00	2024-08-19 14:27:44.32+00	d07c1f42-6ea3-4b03-8289-9e9a9437814f
389e259b-1fd9-4b95-8c2e-b15a04ad44c1	test	f	16	14	2024-08-19 14:28:16.913+00	2024-08-19 14:28:16.913+00	d07c1f42-6ea3-4b03-8289-9e9a9437814f
43b4f952-59e1-443f-88ae-560918e32da6	test	f	16	14	2024-08-19 14:28:16.922+00	2024-08-19 14:28:16.922+00	a9d75f75-1529-4abe-9e9c-230b78295cbb
2d35b6ee-8858-4f3f-b548-91b7c49b5d1b	ras ras, jimmi poy poy..., neayk neayk	f	14	16	2024-08-19 14:29:14.128+00	2024-08-19 14:29:14.128+00	a9d75f75-1529-4abe-9e9c-230b78295cbb
463cc307-b301-47de-94ad-cd98992ddfcb	ras ras, jimmi poy poy..., neayk neayk	f	14	16	2024-08-19 14:29:14.135+00	2024-08-19 14:29:14.135+00	d07c1f42-6ea3-4b03-8289-9e9a9437814f
409df208-ceac-4160-ad67-eb6648588a9a	Yeap	f	16	14	2024-08-19 14:29:23.946+00	2024-08-19 14:29:23.946+00	d07c1f42-6ea3-4b03-8289-9e9a9437814f
7d7b2bb8-2081-4d34-ae24-5fd5d68dc826	Yeap	f	16	14	2024-08-19 14:29:23.952+00	2024-08-19 14:29:23.952+00	a9d75f75-1529-4abe-9e9c-230b78295cbb
f0cf0aa9-17fd-4cac-8c25-89e4aa2ffe97	iuj	f	16	18	2024-08-19 14:30:21.098+00	2024-08-19 14:30:21.098+00	526f1d0a-72eb-4c18-98c0-12710dba9f23
581cb490-e959-4907-b791-b42ad10fc46a	iuj	f	16	18	2024-08-19 14:30:21.103+00	2024-08-19 14:30:21.103+00	06a5c33c-30c3-4031-b73b-5d6526aad35b
17a7a904-6611-4a65-ab80-fb0bf2e94f33	vfdjbvbhjfd	f	16	18	2024-08-19 14:30:29.521+00	2024-08-19 14:30:29.521+00	526f1d0a-72eb-4c18-98c0-12710dba9f23
eccf0421-6410-4bc6-a5f0-c221c46d6172	vfdjbvbhjfd	f	16	18	2024-08-19 14:30:29.525+00	2024-08-19 14:30:29.525+00	06a5c33c-30c3-4031-b73b-5d6526aad35b
b7c8dd3e-bbe5-457f-9222-4d4140e13259	dfjvnfdn	f	16	18	2024-08-19 14:30:31.127+00	2024-08-19 14:30:31.127+00	526f1d0a-72eb-4c18-98c0-12710dba9f23
d2e86ba5-3530-4023-b3e7-560c5f744457	dfjvnfdn	f	16	18	2024-08-19 14:30:31.131+00	2024-08-19 14:30:31.131+00	06a5c33c-30c3-4031-b73b-5d6526aad35b
4e3c56bb-d851-4617-8735-a3c564056e95	gbjgfb	f	16	18	2024-08-19 14:30:32.52+00	2024-08-19 14:30:32.52+00	526f1d0a-72eb-4c18-98c0-12710dba9f23
101e71fb-872b-47ab-aaae-4b20868917f3	gbjgfb	f	16	18	2024-08-19 14:30:32.524+00	2024-08-19 14:30:32.524+00	06a5c33c-30c3-4031-b73b-5d6526aad35b
762b6cf7-d986-4589-a300-b5098a24fda6	fdsdf	f	16	8	2024-08-20 03:54:10.487+00	2024-08-20 03:54:10.487+00	502cfe29-3cc0-4b57-92c4-40d14ea40993
5d269e6b-c2a4-4674-94cb-9d242d07672a	fdsdf	f	16	8	2024-08-20 03:54:10.491+00	2024-08-20 03:54:10.491+00	37ade6ce-4043-45ba-93a2-1e00bdf30e14
be1950d5-b64a-4966-a236-e48330598fe8	 l;mvzdlkfb	f	16	8	2024-08-20 03:54:37.671+00	2024-08-20 03:54:37.671+00	502cfe29-3cc0-4b57-92c4-40d14ea40993
100d4fe5-dcb5-4761-8283-2a3379f91db7	 l;mvzdlkfb	f	16	8	2024-08-20 03:54:37.675+00	2024-08-20 03:54:37.675+00	37ade6ce-4043-45ba-93a2-1e00bdf30e14
4f9d34eb-88a4-48d8-a26b-65649904ff42	ryerdr	f	16	8	2024-08-20 03:55:17.931+00	2024-08-20 03:55:17.931+00	502cfe29-3cc0-4b57-92c4-40d14ea40993
8f4737c9-907d-4ec0-80db-c5366d4f201d	ryerdr	f	16	8	2024-08-20 03:55:17.935+00	2024-08-20 03:55:17.935+00	37ade6ce-4043-45ba-93a2-1e00bdf30e14
aa055612-616b-4448-87c3-388deab26023	slm	f	9	16	2024-08-20 03:56:44.916+00	2024-08-20 03:56:44.916+00	7a4fdada-b415-47c8-8741-280528e55129
48a46861-5001-437a-adb3-f90d277ad125	slm	f	9	16	2024-08-20 03:56:44.92+00	2024-08-20 03:56:44.92+00	eda2e444-2066-419c-8464-3ebd46ca63ac
3cc886bd-ee11-4978-913f-59dc81a6cc91	jfbvhkhdfkv	f	14	16	2024-08-20 03:57:44.471+00	2024-08-20 03:57:44.471+00	a9d75f75-1529-4abe-9e9c-230b78295cbb
2da2ea1a-d9ba-4ec3-a25f-ad4d98642577	jfbvhkhdfkv	f	14	16	2024-08-20 03:57:44.481+00	2024-08-20 03:57:44.481+00	d07c1f42-6ea3-4b03-8289-9e9a9437814f
d252408c-9847-4d0c-94ac-582e019a2df3	dfsbkdsfnb	f	16	14	2024-08-20 03:57:55.758+00	2024-08-20 03:57:55.758+00	d07c1f42-6ea3-4b03-8289-9e9a9437814f
bfc27903-be79-404a-8db7-8151bf8762f0	dfsbkdsfnb	f	16	14	2024-08-20 03:57:55.761+00	2024-08-20 03:57:55.761+00	a9d75f75-1529-4abe-9e9c-230b78295cbb
5d0f0571-7a1e-4ef5-9006-24a82153a39f	 vlndsfv df	f	14	8	2024-08-20 03:59:10.299+00	2024-08-20 03:59:10.299+00	9b78f2be-7c2d-4269-978b-cc1eec384fe4
1273f14a-c0f6-4e55-94de-37c4106f1c4e	 vlndsfv df	f	14	8	2024-08-20 03:59:10.303+00	2024-08-20 03:59:10.303+00	96140700-7944-4ec4-9ec9-81cd4fbf673b
8d97287e-6550-447b-9345-bd583e40d5d2	dfkvksdfvbdfsvbhsdfvbhjdsfvh	f	14	8	2024-08-20 03:59:28.35+00	2024-08-20 03:59:28.35+00	9b78f2be-7c2d-4269-978b-cc1eec384fe4
7f5e5d32-52b6-4ff5-bc43-9a66c2af42de	dfkvksdfvbdfsvbhsdfvbhjdsfvh	f	14	8	2024-08-20 03:59:28.354+00	2024-08-20 03:59:28.354+00	96140700-7944-4ec4-9ec9-81cd4fbf673b
4a97620a-114d-4ac9-91c2-b06041de80c0	jfdnvjkdf	f	14	8	2024-08-20 03:59:29.641+00	2024-08-20 03:59:29.641+00	9b78f2be-7c2d-4269-978b-cc1eec384fe4
4c6bec22-5d21-4c67-95d2-3ac8eb16de6f	jfdnvjkdf	f	14	8	2024-08-20 03:59:29.646+00	2024-08-20 03:59:29.646+00	96140700-7944-4ec4-9ec9-81cd4fbf673b
88b1da56-fb46-4e99-958e-d9085c9390ea	jasdvbbfv	f	8	16	2024-08-20 03:59:47.035+00	2024-08-20 03:59:47.035+00	37ade6ce-4043-45ba-93a2-1e00bdf30e14
756983ee-614e-4478-97c0-c4372b655392	jasdvbbfv	f	8	16	2024-08-20 03:59:47.039+00	2024-08-20 03:59:47.039+00	502cfe29-3cc0-4b57-92c4-40d14ea40993
d82f0cc1-4fc6-4c58-a0d1-da5b5708448f	jksfdnvf	f	8	16	2024-08-20 03:59:53.052+00	2024-08-20 03:59:53.052+00	37ade6ce-4043-45ba-93a2-1e00bdf30e14
e1b492cf-37d8-4a46-a074-4aea2f57b46b	jksfdnvf	f	8	16	2024-08-20 03:59:53.056+00	2024-08-20 03:59:53.056+00	502cfe29-3cc0-4b57-92c4-40d14ea40993
7eebeafb-9a63-447f-a9d9-2e60d619a0e3	Gulnur biz gellik sen nirde	f	8	10	2024-08-20 04:00:15.795+00	2024-08-20 04:00:15.795+00	ab1f3414-8224-4061-baec-bf22bd676420
c529536d-ebad-430f-9d46-91797ebe8047	Gulnur biz gellik sen nirde	f	8	10	2024-08-20 04:00:15.799+00	2024-08-20 04:00:15.799+00	bb17636c-1a36-4606-b159-8b9b9426eb8d
ac8f9ce4-2a34-4863-9ba5-04c8d33b6af6	Salam men babaduk	f	8	14	2024-08-20 04:02:38.899+00	2024-08-20 04:02:38.899+00	96140700-7944-4ec4-9ec9-81cd4fbf673b
53734d09-572a-486e-879d-0489b9b7ed4b	Salam men babaduk	f	8	14	2024-08-20 04:02:38.903+00	2024-08-20 04:02:38.903+00	9b78f2be-7c2d-4269-978b-cc1eec384fe4
1a988421-fea5-44de-acd1-866b10565b72	Today my birthday	f	8	14	2024-08-20 04:03:13.383+00	2024-08-20 04:03:13.383+00	96140700-7944-4ec4-9ec9-81cd4fbf673b
e4706158-8d3d-4fbb-967d-85f1fe8a5259	Today my birthday	f	8	14	2024-08-20 04:03:13.39+00	2024-08-20 04:03:13.39+00	9b78f2be-7c2d-4269-978b-cc1eec384fe4
c9aec5fa-e653-456f-8f91-f6fa010dc867	Arslan salam	f	16	20	2024-08-20 04:04:12.332+00	2024-08-20 04:04:12.332+00	c921d1fa-115c-4ef8-a422-fe0d24657720
deeaafe4-2bdd-448e-b52d-dd4349036f0f	Arslan salam	f	16	20	2024-08-20 04:04:12.336+00	2024-08-20 04:04:12.336+00	fd6baea6-a931-4869-9b77-450bc891215a
e6bcc254-ed55-4cfa-b818-d3d393e7b058	Hello	f	20	16	2024-08-20 04:05:33.732+00	2024-08-20 04:05:33.732+00	fd6baea6-a931-4869-9b77-450bc891215a
bdf0705f-7dc6-4e82-8ee2-a4892c0384f9	Hello	f	20	16	2024-08-20 04:05:33.74+00	2024-08-20 04:05:33.74+00	c921d1fa-115c-4ef8-a422-fe0d24657720
35e62fbd-c0c0-447a-9870-e4747d62e8c6	....	f	16	20	2024-08-20 04:05:36.124+00	2024-08-20 04:05:36.124+00	c921d1fa-115c-4ef8-a422-fe0d24657720
4d9c8387-07f6-4728-8b9a-553bbeded94b	....	f	16	20	2024-08-20 04:05:36.139+00	2024-08-20 04:05:36.139+00	fd6baea6-a931-4869-9b77-450bc891215a
a898ca54-4c9c-49d1-bc1c-a0268c6ca362	1	f	20	16	2024-08-20 04:06:19.397+00	2024-08-20 04:06:19.397+00	fd6baea6-a931-4869-9b77-450bc891215a
3645d681-9f4d-4628-b5f6-7c1035e00d7d	1	f	20	16	2024-08-20 04:06:19.406+00	2024-08-20 04:06:19.406+00	c921d1fa-115c-4ef8-a422-fe0d24657720
ab9093a9-c2a3-463f-9f2b-104a6b6a2132	2	f	20	16	2024-08-20 04:06:28.185+00	2024-08-20 04:06:28.185+00	fd6baea6-a931-4869-9b77-450bc891215a
41707979-0007-4d89-be8d-a862fa1842dc	2	f	20	16	2024-08-20 04:06:28.19+00	2024-08-20 04:06:28.19+00	c921d1fa-115c-4ef8-a422-fe0d24657720
d70cbf94-9f6c-4388-b1bd-7cbf438eee30	3	f	20	16	2024-08-20 04:07:16.088+00	2024-08-20 04:07:16.088+00	fd6baea6-a931-4869-9b77-450bc891215a
6f5f87cd-dafb-486c-ace8-dab1a51fbdf8	3	f	20	16	2024-08-20 04:07:16.097+00	2024-08-20 04:07:16.097+00	c921d1fa-115c-4ef8-a422-fe0d24657720
beec182c-34c4-4446-a598-b1915e10c054	Salamaleykum Maksim	f	16	5	2024-08-20 04:37:26.56+00	2024-08-20 04:37:26.56+00	1800e9fd-f0be-49a2-bdb0-82ae634f3f30
83aa9dc3-5a86-46e1-b37c-883804320d0f	Salamaleykum Maksim	f	16	5	2024-08-20 04:37:26.568+00	2024-08-20 04:37:26.568+00	ead23234-0e53-4e83-8ffc-a52d3526dfa5
585eab0b-d2af-4f56-905a-bfb343488e39	Salam	f	16	10	2024-08-20 04:39:02.426+00	2024-08-20 04:39:02.426+00	c8bf3fef-1f7a-446c-978e-e1dd94544fb0
ff0ffd0b-c561-4769-8c7e-82930026ba2f	Salam	f	16	10	2024-08-20 04:39:02.429+00	2024-08-20 04:39:02.429+00	697f696c-94cd-4eaf-9747-aca46c979f71
8e4e581d-bb1a-4dff-b810-250b06e0c4a9	бббб	f	10	16	2024-08-20 04:44:44.008+00	2024-08-20 04:44:44.008+00	697f696c-94cd-4eaf-9747-aca46c979f71
33d508d4-bd2f-41f3-8c77-178e0a244f86	бббб	f	10	16	2024-08-20 04:44:44.012+00	2024-08-20 04:44:44.012+00	c8bf3fef-1f7a-446c-978e-e1dd94544fb0
deef3731-4fa9-4cee-b7df-1b25cbb4144a	Selbi	f	16	8	2024-08-20 04:55:38.668+00	2024-08-20 04:55:38.668+00	502cfe29-3cc0-4b57-92c4-40d14ea40993
baac5464-87b8-4ca5-9a9c-373b7264aade	Selbi	f	16	8	2024-08-20 04:55:38.675+00	2024-08-20 04:55:38.675+00	37ade6ce-4043-45ba-93a2-1e00bdf30e14
6759ccbc-bfc9-4592-a8b8-40461ab7b2d5	gowmy	f	16	8	2024-08-20 04:55:41.24+00	2024-08-20 04:55:41.24+00	502cfe29-3cc0-4b57-92c4-40d14ea40993
0f792096-4c35-4b45-ae27-557192587c33	gowmy	f	16	8	2024-08-20 04:55:41.244+00	2024-08-20 04:55:41.244+00	37ade6ce-4043-45ba-93a2-1e00bdf30e14
34240952-fcb9-4500-8f09-5b9ba4e28fba	Fredi Mercuri	f	16	14	2024-08-20 04:57:02.228+00	2024-08-20 04:57:02.228+00	d07c1f42-6ea3-4b03-8289-9e9a9437814f
decff83c-3f59-44b3-bcb2-ceae86ff0727	Fredi Mercuri	f	16	14	2024-08-20 04:57:02.24+00	2024-08-20 04:57:02.24+00	a9d75f75-1529-4abe-9e9c-230b78295cbb
8c96188d-c884-4b6d-9def-4d4e46349945	the silver beatles	f	16	14	2024-08-20 04:58:17.916+00	2024-08-20 04:58:17.916+00	d07c1f42-6ea3-4b03-8289-9e9a9437814f
5bd3aaaf-239f-41ed-ab59-04a6bb9e1b22	the silver beatles	f	16	14	2024-08-20 04:58:17.925+00	2024-08-20 04:58:17.925+00	a9d75f75-1529-4abe-9e9c-230b78295cbb
5b7f2870-ad10-4e5a-a072-8b1d7de35628	q1	f	23	16	2024-08-20 05:02:40.775+00	2024-08-20 05:02:40.775+00	a5a1ac77-3218-4729-85ba-0b52b50974fd
cfe3e99e-382e-4d29-bb81-df5b8a78949f	q1	f	23	16	2024-08-20 05:02:40.779+00	2024-08-20 05:02:40.779+00	3f2d85b0-1ec8-4730-9e3a-c7a2b841c27c
26add14f-eb0f-4e6e-b78d-914d28ef6e25	vnjf	f	16	19	2024-08-20 10:06:35.465+00	2024-08-20 10:06:35.465+00	1f1147f8-61d9-46aa-b19e-2c95c2825721
3eeb6da1-f823-4c91-96c6-7df26b9c6100	vnjf	f	16	19	2024-08-20 10:06:35.472+00	2024-08-20 10:06:35.472+00	5c614b47-892d-4719-8d77-ae96fb691d1c
63b355a1-aa63-4867-b0df-244be602f6c8	vfdvmkdf	f	16	19	2024-08-20 10:06:36.583+00	2024-08-20 10:06:36.583+00	1f1147f8-61d9-46aa-b19e-2c95c2825721
da2d781a-4f0f-40f7-aa45-b17db917ed55	vfdvmkdf	f	16	19	2024-08-20 10:06:36.587+00	2024-08-20 10:06:36.587+00	5c614b47-892d-4719-8d77-ae96fb691d1c
c4f87984-ed58-4090-a279-d40beb948ab6	fdvidofvdfivoj	f	16	19	2024-08-20 10:06:48.256+00	2024-08-20 10:06:48.256+00	1f1147f8-61d9-46aa-b19e-2c95c2825721
4363891c-e32c-4bd4-a6e6-3a8d5a7161c6	fdvidofvdfivoj	f	16	19	2024-08-20 10:06:48.265+00	2024-08-20 10:06:48.265+00	5c614b47-892d-4719-8d77-ae96fb691d1c
80837116-c489-4df1-b259-559376b82906	mvkfdvkfdlm	f	16	19	2024-08-20 10:06:49.695+00	2024-08-20 10:06:49.695+00	1f1147f8-61d9-46aa-b19e-2c95c2825721
12e22b5e-3ff5-4035-a41d-6b95b73bcfd9	mvkfdvkfdlm	f	16	19	2024-08-20 10:06:49.699+00	2024-08-20 10:06:49.699+00	5c614b47-892d-4719-8d77-ae96fb691d1c
8e5c0e37-9d20-4a45-8d4f-46a5cc8f05c0	hello	f	19	16	2024-08-20 10:07:06.554+00	2024-08-20 10:07:06.554+00	5c614b47-892d-4719-8d77-ae96fb691d1c
4b0422f0-a82e-4f5a-99ed-60d2c4fffa0e	hello	f	19	16	2024-08-20 10:07:06.558+00	2024-08-20 10:07:06.558+00	1f1147f8-61d9-46aa-b19e-2c95c2825721
0fb8104f-8a5d-40b2-9ec6-949cbaba9b89	fvm,fkmdv	f	16	19	2024-08-20 10:07:08.134+00	2024-08-20 10:07:08.134+00	1f1147f8-61d9-46aa-b19e-2c95c2825721
47768569-c4a2-422b-bf5a-6877fe45bd80	fvm,fkmdv	f	16	19	2024-08-20 10:07:08.138+00	2024-08-20 10:07:08.138+00	5c614b47-892d-4719-8d77-ae96fb691d1c
eca106a3-6e0a-43ff-8ca7-8f14abed8864	kcnv	f	19	16	2024-08-20 10:07:13.321+00	2024-08-20 10:07:13.321+00	5c614b47-892d-4719-8d77-ae96fb691d1c
49788719-b45b-4b4d-9d9a-a7c8412b54f1	kcnv	f	19	16	2024-08-20 10:07:13.323+00	2024-08-20 10:07:13.323+00	1f1147f8-61d9-46aa-b19e-2c95c2825721
06cec5ef-a4cf-4b67-bcee-22638f39c869	dsaf	f	19	16	2024-08-20 10:07:13.688+00	2024-08-20 10:07:13.688+00	5c614b47-892d-4719-8d77-ae96fb691d1c
72e4a008-8d1f-4f89-8fce-ad80ac892395	dsaf	f	19	16	2024-08-20 10:07:13.691+00	2024-08-20 10:07:13.691+00	1f1147f8-61d9-46aa-b19e-2c95c2825721
bff6f285-77a8-4031-b94f-f1132810293f	ds	f	19	16	2024-08-20 10:07:13.832+00	2024-08-20 10:07:13.832+00	5c614b47-892d-4719-8d77-ae96fb691d1c
cb841b26-37be-4bdb-9cef-88fcf9d19b4d	ds	f	19	16	2024-08-20 10:07:13.836+00	2024-08-20 10:07:13.836+00	1f1147f8-61d9-46aa-b19e-2c95c2825721
d4864200-798e-4377-8f0f-0e9da12a3afd	f	f	19	16	2024-08-20 10:07:13.936+00	2024-08-20 10:07:13.936+00	5c614b47-892d-4719-8d77-ae96fb691d1c
8e512003-53ca-4649-a4b6-44a0308aeb49	f	f	19	16	2024-08-20 10:07:13.939+00	2024-08-20 10:07:13.939+00	1f1147f8-61d9-46aa-b19e-2c95c2825721
749296c9-4069-4030-82bf-6dc240db8d6f	dsf	f	19	16	2024-08-20 10:07:14.047+00	2024-08-20 10:07:14.047+00	5c614b47-892d-4719-8d77-ae96fb691d1c
3bdc89b2-0928-4c12-a8a1-06d21f1ca5af	dsf	f	19	16	2024-08-20 10:07:14.052+00	2024-08-20 10:07:14.052+00	1f1147f8-61d9-46aa-b19e-2c95c2825721
b1a0d241-84c4-4dcc-a42e-42720521ee90	ds	f	19	16	2024-08-20 10:07:14.175+00	2024-08-20 10:07:14.175+00	5c614b47-892d-4719-8d77-ae96fb691d1c
100c79a0-f6c3-4511-b238-b5a4ca271868	ds	f	19	16	2024-08-20 10:07:14.178+00	2024-08-20 10:07:14.178+00	1f1147f8-61d9-46aa-b19e-2c95c2825721
26bc627a-8cde-495b-86f5-5c464ea8412d	f	f	19	16	2024-08-20 10:07:14.279+00	2024-08-20 10:07:14.279+00	5c614b47-892d-4719-8d77-ae96fb691d1c
a422a643-317b-45ab-a694-981266644ffc	f	f	19	16	2024-08-20 10:07:14.282+00	2024-08-20 10:07:14.282+00	1f1147f8-61d9-46aa-b19e-2c95c2825721
8c3531a3-4b24-43c1-952d-bbc9a1bed568	ds	f	19	16	2024-08-20 10:07:14.376+00	2024-08-20 10:07:14.376+00	5c614b47-892d-4719-8d77-ae96fb691d1c
a548c183-9b33-43f5-b71b-68647540bcfa	ds	f	19	16	2024-08-20 10:07:14.379+00	2024-08-20 10:07:14.379+00	1f1147f8-61d9-46aa-b19e-2c95c2825721
e0fc3049-1f0d-491d-ac5d-3eca96aface4	f	f	19	16	2024-08-20 10:07:14.526+00	2024-08-20 10:07:14.526+00	5c614b47-892d-4719-8d77-ae96fb691d1c
2654d20a-51e3-485a-a49b-2ffe218101e8	f	f	19	16	2024-08-20 10:07:14.53+00	2024-08-20 10:07:14.53+00	1f1147f8-61d9-46aa-b19e-2c95c2825721
0131a953-f6fd-4237-861b-f0bb78ed7379	dsf	f	19	16	2024-08-20 10:07:14.631+00	2024-08-20 10:07:14.631+00	5c614b47-892d-4719-8d77-ae96fb691d1c
4454ddd5-8e58-42ca-9c77-26f0ad6d45ef	dsf	f	19	16	2024-08-20 10:07:14.634+00	2024-08-20 10:07:14.634+00	1f1147f8-61d9-46aa-b19e-2c95c2825721
2c00a974-506f-4070-83a4-28c937f85adc	ds	f	19	16	2024-08-20 10:07:14.767+00	2024-08-20 10:07:14.767+00	5c614b47-892d-4719-8d77-ae96fb691d1c
ac506da7-7f9d-41fc-83e3-898f6d2dbdc0	ds	f	19	16	2024-08-20 10:07:14.77+00	2024-08-20 10:07:14.77+00	1f1147f8-61d9-46aa-b19e-2c95c2825721
17b017a9-f40e-4f2e-bb76-1542a6ade54c	f	f	19	16	2024-08-20 10:07:14.912+00	2024-08-20 10:07:14.912+00	5c614b47-892d-4719-8d77-ae96fb691d1c
60e63c8c-12f6-4b31-b5e6-90ff056cf608	f	f	19	16	2024-08-20 10:07:14.915+00	2024-08-20 10:07:14.915+00	1f1147f8-61d9-46aa-b19e-2c95c2825721
6fb54588-3de6-4979-812d-e84feeb7c353	sdf	f	19	16	2024-08-20 10:07:15.015+00	2024-08-20 10:07:15.015+00	5c614b47-892d-4719-8d77-ae96fb691d1c
243cdcd4-431c-4aec-9e04-c6070e9698f5	sdf	f	19	16	2024-08-20 10:07:15.017+00	2024-08-20 10:07:15.017+00	1f1147f8-61d9-46aa-b19e-2c95c2825721
7b0dbec0-968a-44c1-9f3e-c6f665233f1a	ds	f	19	16	2024-08-20 10:07:15.135+00	2024-08-20 10:07:15.135+00	5c614b47-892d-4719-8d77-ae96fb691d1c
3129eefc-0ec4-404c-a3ab-ad4ff49d103c	ds	f	19	16	2024-08-20 10:07:15.138+00	2024-08-20 10:07:15.138+00	1f1147f8-61d9-46aa-b19e-2c95c2825721
d61c3ec0-0a11-44a4-9fe4-b3b1c2847045	fdsf	f	19	16	2024-08-20 10:07:15.386+00	2024-08-20 10:07:15.386+00	5c614b47-892d-4719-8d77-ae96fb691d1c
634d7d2e-4dfe-4482-a428-58d4aa87430f	fdsf	f	19	16	2024-08-20 10:07:15.391+00	2024-08-20 10:07:15.391+00	1f1147f8-61d9-46aa-b19e-2c95c2825721
29261e96-aeea-48b2-9062-12910b7f32e9	ds	f	19	16	2024-08-20 10:07:15.496+00	2024-08-20 10:07:15.496+00	5c614b47-892d-4719-8d77-ae96fb691d1c
00df2474-3fee-4b7c-a3da-1460e4d9bc73	ds	f	19	16	2024-08-20 10:07:15.499+00	2024-08-20 10:07:15.499+00	1f1147f8-61d9-46aa-b19e-2c95c2825721
b179dcfd-47a7-435d-a4ed-34d0e0f6c17f	f	f	19	16	2024-08-20 10:07:15.64+00	2024-08-20 10:07:15.64+00	5c614b47-892d-4719-8d77-ae96fb691d1c
bf8c3956-849f-4d6e-b382-9cbab20887dc	f	f	19	16	2024-08-20 10:07:15.644+00	2024-08-20 10:07:15.644+00	1f1147f8-61d9-46aa-b19e-2c95c2825721
5189275e-f4b4-4bcb-a77d-10448da25a32	dsf	f	19	16	2024-08-20 10:07:15.76+00	2024-08-20 10:07:15.76+00	5c614b47-892d-4719-8d77-ae96fb691d1c
f6f347ec-1ac6-41b7-a634-529916266a33	dsf	f	19	16	2024-08-20 10:07:15.763+00	2024-08-20 10:07:15.763+00	1f1147f8-61d9-46aa-b19e-2c95c2825721
07951183-0d96-498c-9a3a-0796af3ea8ba	sd	f	19	16	2024-08-20 10:07:15.895+00	2024-08-20 10:07:15.895+00	5c614b47-892d-4719-8d77-ae96fb691d1c
e0504285-69c9-4fe6-bbc8-761eee825dee	sd	f	19	16	2024-08-20 10:07:15.899+00	2024-08-20 10:07:15.899+00	1f1147f8-61d9-46aa-b19e-2c95c2825721
27032b0a-27e6-433f-a4e9-a0d8c26246b6	f	f	19	16	2024-08-20 10:07:16.007+00	2024-08-20 10:07:16.007+00	5c614b47-892d-4719-8d77-ae96fb691d1c
50bce4ae-818b-4c52-b4ca-a0a44681648e	f	f	19	16	2024-08-20 10:07:16.011+00	2024-08-20 10:07:16.011+00	1f1147f8-61d9-46aa-b19e-2c95c2825721
25cf1cdc-5b65-4999-aba0-668e5cb3a387	sd	f	19	16	2024-08-20 10:07:16.127+00	2024-08-20 10:07:16.127+00	5c614b47-892d-4719-8d77-ae96fb691d1c
30f1862a-c0b1-4f6a-8d53-f3fe69d0166c	sd	f	19	16	2024-08-20 10:07:16.132+00	2024-08-20 10:07:16.132+00	1f1147f8-61d9-46aa-b19e-2c95c2825721
d32f3993-bc48-4d6d-aea5-4faf50b4fe22	fds	f	19	16	2024-08-20 10:07:16.255+00	2024-08-20 10:07:16.255+00	5c614b47-892d-4719-8d77-ae96fb691d1c
7f7e1127-a67f-4612-9484-ef20a20b4bf3	fds	f	19	16	2024-08-20 10:07:16.258+00	2024-08-20 10:07:16.258+00	1f1147f8-61d9-46aa-b19e-2c95c2825721
13178fa5-82f4-4d2d-a390-0ac18eefa72e	f	f	19	16	2024-08-20 10:07:16.375+00	2024-08-20 10:07:16.375+00	5c614b47-892d-4719-8d77-ae96fb691d1c
1a3295d6-ca52-49c4-befe-e6b919bc24e4	f	f	19	16	2024-08-20 10:07:16.379+00	2024-08-20 10:07:16.379+00	1f1147f8-61d9-46aa-b19e-2c95c2825721
8085b3a8-03fe-46ce-baef-55cd7e1b9535	ds	f	19	16	2024-08-20 10:07:16.519+00	2024-08-20 10:07:16.519+00	5c614b47-892d-4719-8d77-ae96fb691d1c
69004a3a-f34e-48f8-a12c-d03440bd4f88	ds	f	19	16	2024-08-20 10:07:16.522+00	2024-08-20 10:07:16.522+00	1f1147f8-61d9-46aa-b19e-2c95c2825721
bdbaac4d-a7d3-4401-8a3a-0903d0819f72	fsd	f	19	16	2024-08-20 10:07:16.655+00	2024-08-20 10:07:16.655+00	5c614b47-892d-4719-8d77-ae96fb691d1c
9cbb73a4-44ca-4feb-8a01-4bef293693c7	fsd	f	19	16	2024-08-20 10:07:16.659+00	2024-08-20 10:07:16.659+00	1f1147f8-61d9-46aa-b19e-2c95c2825721
cdcb09fa-c335-4bdb-819b-b8696aba946e	f	f	19	16	2024-08-20 10:07:16.783+00	2024-08-20 10:07:16.783+00	5c614b47-892d-4719-8d77-ae96fb691d1c
fc414fe3-62d4-429a-93f4-1ba1ae98451b	f	f	19	16	2024-08-20 10:07:16.786+00	2024-08-20 10:07:16.786+00	1f1147f8-61d9-46aa-b19e-2c95c2825721
11a62fc5-cffd-4392-b22c-486a5613fdd2	ds	f	19	16	2024-08-20 10:07:16.919+00	2024-08-20 10:07:16.919+00	5c614b47-892d-4719-8d77-ae96fb691d1c
2f0210a2-a7a2-4505-afd1-34b667a664b3	ds	f	19	16	2024-08-20 10:07:16.922+00	2024-08-20 10:07:16.922+00	1f1147f8-61d9-46aa-b19e-2c95c2825721
375bc0b9-84a5-4ca6-88c1-38c018b18ed9	45678	f	16	20	2024-08-20 10:19:06.01+00	2024-08-20 10:19:06.01+00	c921d1fa-115c-4ef8-a422-fe0d24657720
328221d1-1786-4f1c-8443-ece24f2278f3	45678	f	16	20	2024-08-20 10:19:06.014+00	2024-08-20 10:19:06.014+00	fd6baea6-a931-4869-9b77-450bc891215a
4a05b8c4-f984-4990-a204-5ec899713b7f	fddfgsdfg	f	16	20	2024-08-20 10:19:10.862+00	2024-08-20 10:19:10.862+00	c921d1fa-115c-4ef8-a422-fe0d24657720
3a502642-8a95-4e8e-8da9-0c42ca2b10fa	fddfgsdfg	f	16	20	2024-08-20 10:19:10.866+00	2024-08-20 10:19:10.866+00	fd6baea6-a931-4869-9b77-450bc891215a
fcaaecdc-c9ab-4da8-8753-cf662ab17df7	ghjmkj	f	16	20	2024-08-20 10:19:12.068+00	2024-08-20 10:19:12.068+00	c921d1fa-115c-4ef8-a422-fe0d24657720
f24f7778-52f6-49c7-a1ff-9fd61bc1de48	ghjmkj	f	16	20	2024-08-20 10:19:12.071+00	2024-08-20 10:19:12.071+00	fd6baea6-a931-4869-9b77-450bc891215a
54ed5a91-0226-41e4-946e-718b3080e950	1	f	20	16	2024-08-20 10:19:26.975+00	2024-08-20 10:19:26.975+00	fd6baea6-a931-4869-9b77-450bc891215a
1ed9d5e3-edeb-4de4-a185-bf21926953f1	1	f	20	16	2024-08-20 10:19:26.984+00	2024-08-20 10:19:26.984+00	c921d1fa-115c-4ef8-a422-fe0d24657720
cd195b86-e98d-445c-9e47-fb8f010d3472	qwerty	f	16	20	2024-08-20 10:19:32.047+00	2024-08-20 10:19:32.047+00	c921d1fa-115c-4ef8-a422-fe0d24657720
0c4cd493-30a9-42db-9814-a99499d2a4ed	qwerty	f	16	20	2024-08-20 10:19:32.052+00	2024-08-20 10:19:32.052+00	fd6baea6-a931-4869-9b77-450bc891215a
462c5dfc-e595-460d-911d-6f4b00dbf247	jnvsfjbv	f	16	20	2024-08-20 10:19:34.4+00	2024-08-20 10:19:34.4+00	c921d1fa-115c-4ef8-a422-fe0d24657720
f51c3cbb-4554-424b-93b4-290801a46db9	jnvsfjbv	f	16	20	2024-08-20 10:19:34.404+00	2024-08-20 10:19:34.404+00	fd6baea6-a931-4869-9b77-450bc891215a
e5cee1f2-3ed7-45bd-9252-70a163236dcf	fskjvnfdlkj	f	16	20	2024-08-20 10:19:35.111+00	2024-08-20 10:19:35.111+00	c921d1fa-115c-4ef8-a422-fe0d24657720
1b5270fa-0172-4d07-aee5-c0f460b43241	fskjvnfdlkj	f	16	20	2024-08-20 10:19:35.115+00	2024-08-20 10:19:35.115+00	fd6baea6-a931-4869-9b77-450bc891215a
d88e1b3a-1c01-4769-8f21-202875f1875a	sdf	f	20	16	2024-08-20 10:19:36.263+00	2024-08-20 10:19:36.263+00	fd6baea6-a931-4869-9b77-450bc891215a
ab67d657-695e-4f9c-93ea-40da94732ebe	sdf	f	20	16	2024-08-20 10:19:36.267+00	2024-08-20 10:19:36.267+00	c921d1fa-115c-4ef8-a422-fe0d24657720
62cea12e-560b-49ee-80f0-565814c3e934	adf	f	20	16	2024-08-20 10:19:36.775+00	2024-08-20 10:19:36.775+00	fd6baea6-a931-4869-9b77-450bc891215a
b3043163-094c-460a-bc34-c0d55357f877	adf	f	20	16	2024-08-20 10:19:36.779+00	2024-08-20 10:19:36.779+00	c921d1fa-115c-4ef8-a422-fe0d24657720
0c1570f1-63b9-4ffb-a6c7-6f3d1d6183b9	fd	f	20	16	2024-08-20 10:19:37.862+00	2024-08-20 10:19:37.862+00	fd6baea6-a931-4869-9b77-450bc891215a
f8c16ea7-bffb-4617-8334-b20208dbff27	fd	f	20	16	2024-08-20 10:19:37.865+00	2024-08-20 10:19:37.865+00	c921d1fa-115c-4ef8-a422-fe0d24657720
7e86e609-d847-4a3d-bef2-eb65c1cff16f	f	f	20	16	2024-08-20 10:19:38.07+00	2024-08-20 10:19:38.07+00	fd6baea6-a931-4869-9b77-450bc891215a
85753a2c-1b6d-4097-b845-1ca5ec40c305	f	f	20	16	2024-08-20 10:19:38.073+00	2024-08-20 10:19:38.073+00	c921d1fa-115c-4ef8-a422-fe0d24657720
6b1468dd-4bc9-4d2a-90cf-daf19befe3d5	f	f	20	16	2024-08-20 10:19:38.776+00	2024-08-20 10:19:38.776+00	fd6baea6-a931-4869-9b77-450bc891215a
a7bef394-5598-4d4a-a835-3403a45646bb	f	f	20	16	2024-08-20 10:19:38.78+00	2024-08-20 10:19:38.78+00	c921d1fa-115c-4ef8-a422-fe0d24657720
546621b2-5141-4005-8af4-6b95b2f525b5	ff	f	20	16	2024-08-20 10:19:39.279+00	2024-08-20 10:19:39.279+00	fd6baea6-a931-4869-9b77-450bc891215a
6bbe5b76-21e0-446f-8f6b-1b0fccdf201e	ff	f	20	16	2024-08-20 10:19:39.286+00	2024-08-20 10:19:39.286+00	c921d1fa-115c-4ef8-a422-fe0d24657720
5d24af0a-629b-4d62-922f-207b4351fd4f	f	f	20	16	2024-08-20 10:19:39.671+00	2024-08-20 10:19:39.671+00	fd6baea6-a931-4869-9b77-450bc891215a
7e8ebe9c-7c43-4e60-8498-b6101baa9191	f	f	20	16	2024-08-20 10:19:39.675+00	2024-08-20 10:19:39.675+00	c921d1fa-115c-4ef8-a422-fe0d24657720
8017af42-3288-4eb5-a8dd-fcceb544e23b	f	f	20	16	2024-08-20 10:19:39.862+00	2024-08-20 10:19:39.862+00	fd6baea6-a931-4869-9b77-450bc891215a
433c0f9f-b191-4fdc-8bee-97b05754c948	f	f	20	16	2024-08-20 10:19:39.866+00	2024-08-20 10:19:39.866+00	c921d1fa-115c-4ef8-a422-fe0d24657720
ab72c397-873d-4f56-a32a-008a3736c352	f	f	20	16	2024-08-20 10:19:40.062+00	2024-08-20 10:19:40.062+00	fd6baea6-a931-4869-9b77-450bc891215a
bf98b916-5be6-4f02-8251-e3cd702e3bf8	f	f	20	16	2024-08-20 10:19:40.065+00	2024-08-20 10:19:40.065+00	c921d1fa-115c-4ef8-a422-fe0d24657720
6923d260-3a2d-4938-bdea-2da587167804	bjdndkfb	f	16	20	2024-08-20 10:19:40.391+00	2024-08-20 10:19:40.391+00	c921d1fa-115c-4ef8-a422-fe0d24657720
4b7488bf-21ee-4ad5-ac90-6c3d9aece7fd	bjdndkfb	f	16	20	2024-08-20 10:19:40.395+00	2024-08-20 10:19:40.395+00	fd6baea6-a931-4869-9b77-450bc891215a
f16bfe59-4349-41b8-a556-9b6bfec78e7a	f	f	20	16	2024-08-20 10:19:40.55+00	2024-08-20 10:19:40.55+00	fd6baea6-a931-4869-9b77-450bc891215a
29700db0-b80f-4f3c-9f27-9f964dfb658d	f	f	20	16	2024-08-20 10:19:40.554+00	2024-08-20 10:19:40.554+00	c921d1fa-115c-4ef8-a422-fe0d24657720
baf0ebc9-4f82-4492-9911-4a42cf842d16	dsfvldkf	f	16	20	2024-08-20 10:19:41.191+00	2024-08-20 10:19:41.191+00	c921d1fa-115c-4ef8-a422-fe0d24657720
341feaf9-007e-4664-9f85-b86d19a25114	dsfvldkf	f	16	20	2024-08-20 10:19:41.195+00	2024-08-20 10:19:41.195+00	fd6baea6-a931-4869-9b77-450bc891215a
7c8af4e2-0a52-4637-9359-afcfc8921bc9	fff	f	20	16	2024-08-20 10:19:47.19+00	2024-08-20 10:19:47.19+00	fd6baea6-a931-4869-9b77-450bc891215a
0d874cf1-cb9c-4b6a-aeb8-86094da3477c	fff	f	20	16	2024-08-20 10:19:47.193+00	2024-08-20 10:19:47.193+00	c921d1fa-115c-4ef8-a422-fe0d24657720
6a70dcb1-6a35-41d2-9ed9-1894a0b9aa3a	f	f	20	16	2024-08-20 10:19:47.358+00	2024-08-20 10:19:47.358+00	fd6baea6-a931-4869-9b77-450bc891215a
287e9f00-48ef-43e8-b3b6-4780a729ef94	f	f	20	16	2024-08-20 10:19:47.361+00	2024-08-20 10:19:47.361+00	c921d1fa-115c-4ef8-a422-fe0d24657720
c0d6e912-8bb7-4597-9e08-51f946a757a0	f	f	20	16	2024-08-20 10:19:47.534+00	2024-08-20 10:19:47.534+00	fd6baea6-a931-4869-9b77-450bc891215a
68d2308f-f4da-434c-aa88-4c6e44cb73c0	f	f	20	16	2024-08-20 10:19:47.537+00	2024-08-20 10:19:47.537+00	c921d1fa-115c-4ef8-a422-fe0d24657720
79aace23-a524-4a9c-8d22-d16eda3d315b	f	f	20	16	2024-08-20 10:19:47.702+00	2024-08-20 10:19:47.702+00	fd6baea6-a931-4869-9b77-450bc891215a
55f1b079-765b-45d2-9131-75aff922eef7	f	f	20	16	2024-08-20 10:19:47.705+00	2024-08-20 10:19:47.705+00	c921d1fa-115c-4ef8-a422-fe0d24657720
f81e1129-0773-4b7e-974e-29f6be47e156	f	f	20	16	2024-08-20 10:19:47.87+00	2024-08-20 10:19:47.87+00	fd6baea6-a931-4869-9b77-450bc891215a
bc922174-5942-4f01-9ccc-a07fc34d688b	f	f	20	16	2024-08-20 10:19:47.874+00	2024-08-20 10:19:47.874+00	c921d1fa-115c-4ef8-a422-fe0d24657720
a7283792-4ae0-4d7f-bf21-4a3d55d15ed5	f	f	20	16	2024-08-20 10:19:48.039+00	2024-08-20 10:19:48.039+00	fd6baea6-a931-4869-9b77-450bc891215a
30835d4e-7c67-4e01-a7c6-bae47b6e0709	f	f	20	16	2024-08-20 10:19:48.042+00	2024-08-20 10:19:48.042+00	c921d1fa-115c-4ef8-a422-fe0d24657720
9825fca3-7fc4-4db0-b95d-5060b27bf1d2	f	f	20	16	2024-08-20 10:19:48.214+00	2024-08-20 10:19:48.214+00	fd6baea6-a931-4869-9b77-450bc891215a
209609b3-c748-4e67-9604-3fb1adaaade8	f	f	20	16	2024-08-20 10:19:48.227+00	2024-08-20 10:19:48.227+00	c921d1fa-115c-4ef8-a422-fe0d24657720
01ba5e45-1652-45f8-ac27-a65db7be3579	f	f	20	16	2024-08-20 10:19:48.383+00	2024-08-20 10:19:48.383+00	fd6baea6-a931-4869-9b77-450bc891215a
21467627-8c83-4393-8a9c-4d0b1b00661f	f	f	20	16	2024-08-20 10:19:48.387+00	2024-08-20 10:19:48.387+00	c921d1fa-115c-4ef8-a422-fe0d24657720
1ad256c8-a38e-4fe7-b595-ca1fdd2a8ee5	f	f	20	16	2024-08-20 10:19:48.559+00	2024-08-20 10:19:48.559+00	fd6baea6-a931-4869-9b77-450bc891215a
7a163997-e451-4508-871b-d85bcb9a9217	f	f	20	16	2024-08-20 10:19:48.562+00	2024-08-20 10:19:48.562+00	c921d1fa-115c-4ef8-a422-fe0d24657720
61b885ac-4021-436f-8238-e4ec7b5362f5	f	f	20	16	2024-08-20 10:19:48.718+00	2024-08-20 10:19:48.718+00	fd6baea6-a931-4869-9b77-450bc891215a
0889cb13-f3af-473b-881c-13ebcc75b903	f	f	20	16	2024-08-20 10:19:48.722+00	2024-08-20 10:19:48.722+00	c921d1fa-115c-4ef8-a422-fe0d24657720
4cc00c8c-f935-4094-a205-5d60ea05cd2c	f	f	20	16	2024-08-20 10:19:48.911+00	2024-08-20 10:19:48.911+00	fd6baea6-a931-4869-9b77-450bc891215a
668e850d-ecc5-4017-a950-0eb542609979	f	f	20	16	2024-08-20 10:19:48.914+00	2024-08-20 10:19:48.914+00	c921d1fa-115c-4ef8-a422-fe0d24657720
0eb4251f-f667-41ae-ad5b-3fd6381fc0b5	f	f	20	16	2024-08-20 10:19:49.086+00	2024-08-20 10:19:49.086+00	fd6baea6-a931-4869-9b77-450bc891215a
5a1130a3-0000-4e1c-85b5-72dbada0e712	f	f	20	16	2024-08-20 10:19:49.09+00	2024-08-20 10:19:49.09+00	c921d1fa-115c-4ef8-a422-fe0d24657720
2f3c7618-2d36-40f2-a2c5-d68884998c3f	f	f	20	16	2024-08-20 10:19:49.263+00	2024-08-20 10:19:49.263+00	fd6baea6-a931-4869-9b77-450bc891215a
d96be0ed-892e-459c-af06-9f2dcbc77389	f	f	20	16	2024-08-20 10:19:49.266+00	2024-08-20 10:19:49.266+00	c921d1fa-115c-4ef8-a422-fe0d24657720
dc428b1c-e6ee-4a7e-a4c1-c233c31ebdc4	f	f	20	16	2024-08-20 10:19:49.446+00	2024-08-20 10:19:49.446+00	fd6baea6-a931-4869-9b77-450bc891215a
b23c2e3b-871b-456e-9623-cc1d9e9921ab	f	f	20	16	2024-08-20 10:19:49.449+00	2024-08-20 10:19:49.449+00	c921d1fa-115c-4ef8-a422-fe0d24657720
89933afc-fcdc-44c2-9233-b5beb03e780d	f	f	20	16	2024-08-20 10:19:49.638+00	2024-08-20 10:19:49.638+00	fd6baea6-a931-4869-9b77-450bc891215a
b8a93380-5747-406d-8989-3deae8b1c10b	f	f	20	16	2024-08-20 10:19:49.641+00	2024-08-20 10:19:49.641+00	c921d1fa-115c-4ef8-a422-fe0d24657720
5ebb331a-c8a4-4792-80b9-641b54edc0d6	f	f	20	16	2024-08-20 10:19:49.822+00	2024-08-20 10:19:49.822+00	fd6baea6-a931-4869-9b77-450bc891215a
26628e82-af08-4188-b2d2-5b353c5b96ea	f	f	20	16	2024-08-20 10:19:49.825+00	2024-08-20 10:19:49.825+00	c921d1fa-115c-4ef8-a422-fe0d24657720
016d3696-6c64-4d05-871d-63dff97fdbcf	ffff	f	20	16	2024-08-20 10:19:51.135+00	2024-08-20 10:19:51.135+00	fd6baea6-a931-4869-9b77-450bc891215a
828a3b8d-205b-4bab-838d-4ccdb813e1f2	ffff	f	20	16	2024-08-20 10:19:51.138+00	2024-08-20 10:19:51.138+00	c921d1fa-115c-4ef8-a422-fe0d24657720
353982d4-4894-4c3e-b410-0d17405da3da	gjcgj	f	18	10	2024-08-20 10:23:31.586+00	2024-08-20 10:23:31.586+00	15d50223-2f73-4260-a613-fc084000dd7d
9c59e892-a75d-480c-8d9c-711c64aaae7b	gjcgj	f	18	10	2024-08-20 10:23:31.589+00	2024-08-20 10:23:31.589+00	36e5f8bd-beba-467b-8ee5-e653940a0b43
ca337101-0f16-4e83-ac81-296c7f1d061c	hbjm	f	10	18	2024-08-20 10:23:44.025+00	2024-08-20 10:23:44.025+00	36e5f8bd-beba-467b-8ee5-e653940a0b43
cfc3419a-daa7-4ad2-b1a2-12ceb4780a6f	hbjm	f	10	18	2024-08-20 10:23:44.029+00	2024-08-20 10:23:44.029+00	15d50223-2f73-4260-a613-fc084000dd7d
1e830433-fc09-4303-8292-b78d7e8e6a2e	fnkvjrf	f	18	10	2024-08-20 10:23:45.651+00	2024-08-20 10:23:45.651+00	15d50223-2f73-4260-a613-fc084000dd7d
685f12f5-f579-4ec4-a38f-c6c99896ab47	fnkvjrf	f	18	10	2024-08-20 10:23:45.655+00	2024-08-20 10:23:45.655+00	36e5f8bd-beba-467b-8ee5-e653940a0b43
09a0241c-f5b3-4997-878b-2ae4ce0137c9	rvv	f	18	10	2024-08-20 10:23:46.626+00	2024-08-20 10:23:46.626+00	15d50223-2f73-4260-a613-fc084000dd7d
89ff8f25-091b-454c-8642-5a89ef2a6f2e	rvv	f	18	10	2024-08-20 10:23:46.629+00	2024-08-20 10:23:46.629+00	36e5f8bd-beba-467b-8ee5-e653940a0b43
528092d5-c6b7-45f6-8c4d-4e4d008a2364	vr	f	18	10	2024-08-20 10:23:46.996+00	2024-08-20 10:23:46.996+00	15d50223-2f73-4260-a613-fc084000dd7d
e333201d-6870-4837-afe0-ee85fd3341fc	vr	f	18	10	2024-08-20 10:23:46.999+00	2024-08-20 10:23:46.999+00	36e5f8bd-beba-467b-8ee5-e653940a0b43
60d5ca1e-3946-4dc8-8846-d4c9a51d9c30	r	f	18	10	2024-08-20 10:23:47.599+00	2024-08-20 10:23:47.599+00	15d50223-2f73-4260-a613-fc084000dd7d
2cf1d098-4493-4d1b-8936-4becd9413e98	r	f	18	10	2024-08-20 10:23:47.602+00	2024-08-20 10:23:47.602+00	36e5f8bd-beba-467b-8ee5-e653940a0b43
372893cc-d3ae-4345-ad96-775e6540888b	r	f	18	10	2024-08-20 10:23:47.771+00	2024-08-20 10:23:47.771+00	15d50223-2f73-4260-a613-fc084000dd7d
3fe224ec-0be2-4fa3-9d0c-b444251f365c	r	f	18	10	2024-08-20 10:23:47.775+00	2024-08-20 10:23:47.775+00	36e5f8bd-beba-467b-8ee5-e653940a0b43
f94210bc-41f0-4d86-8a2f-c5b14e5b1f05	vr	f	18	10	2024-08-20 10:23:48.183+00	2024-08-20 10:23:48.183+00	15d50223-2f73-4260-a613-fc084000dd7d
310abb02-7fda-442f-8549-d6345e9272bf	vr	f	18	10	2024-08-20 10:23:48.186+00	2024-08-20 10:23:48.186+00	36e5f8bd-beba-467b-8ee5-e653940a0b43
5eaef902-a0b2-45be-98a6-b076d92375e3	thb	f	18	10	2024-08-20 10:23:48.763+00	2024-08-20 10:23:48.763+00	15d50223-2f73-4260-a613-fc084000dd7d
fdc0a099-292e-482d-95c9-538ce7d1e7af	thb	f	18	10	2024-08-20 10:23:48.767+00	2024-08-20 10:23:48.767+00	36e5f8bd-beba-467b-8ee5-e653940a0b43
2ed3da63-730b-4801-8230-1d16dd9bac16	,l,l..kl,.m,	f	10	18	2024-08-20 10:23:49.027+00	2024-08-20 10:23:49.027+00	36e5f8bd-beba-467b-8ee5-e653940a0b43
6f10e028-d767-41d3-8e84-e71a8d784d9c	,l,l..kl,.m,	f	10	18	2024-08-20 10:23:49.031+00	2024-08-20 10:23:49.031+00	15d50223-2f73-4260-a613-fc084000dd7d
56ba48cf-d518-4bbb-ac2f-3218dbaab783	h	f	10	18	2024-08-20 10:23:49.58+00	2024-08-20 10:23:49.58+00	36e5f8bd-beba-467b-8ee5-e653940a0b43
6f97999f-4483-49e2-8ba0-ca13d25a9566	h	f	10	18	2024-08-20 10:23:49.583+00	2024-08-20 10:23:49.583+00	15d50223-2f73-4260-a613-fc084000dd7d
f5ac1f97-f717-478a-8058-a35671595a7f	h	f	10	18	2024-08-20 10:23:49.811+00	2024-08-20 10:23:49.811+00	36e5f8bd-beba-467b-8ee5-e653940a0b43
6014898d-4dc7-4b59-bf7b-5bf413839cdf	h	f	10	18	2024-08-20 10:23:49.814+00	2024-08-20 10:23:49.814+00	15d50223-2f73-4260-a613-fc084000dd7d
e63cc216-3ab1-4fa1-ac42-748d0d810f90	h	f	10	18	2024-08-20 10:23:50.051+00	2024-08-20 10:23:50.051+00	36e5f8bd-beba-467b-8ee5-e653940a0b43
f802c62b-f89f-406c-9865-97e4f554aa0b	h	f	10	18	2024-08-20 10:23:50.054+00	2024-08-20 10:23:50.054+00	15d50223-2f73-4260-a613-fc084000dd7d
66db5abb-37d6-4ee6-a187-9f601923835a	h	f	10	18	2024-08-20 10:23:50.376+00	2024-08-20 10:23:50.376+00	36e5f8bd-beba-467b-8ee5-e653940a0b43
49fd9167-05a0-4a9f-ab11-a4b4834e4dbe	h	f	10	18	2024-08-20 10:23:50.379+00	2024-08-20 10:23:50.379+00	15d50223-2f73-4260-a613-fc084000dd7d
dbc3e37f-6586-43bf-bd13-b4a8e4b258b9	hh	f	10	18	2024-08-20 10:23:50.59+00	2024-08-20 10:23:50.59+00	36e5f8bd-beba-467b-8ee5-e653940a0b43
f8dc19c3-13d2-4b01-bb5c-8fd3cf543f65	hh	f	10	18	2024-08-20 10:23:50.593+00	2024-08-20 10:23:50.593+00	15d50223-2f73-4260-a613-fc084000dd7d
0d879be4-81bb-4870-adfd-6c057e579fec	th	f	18	10	2024-08-20 10:24:02.037+00	2024-08-20 10:24:02.037+00	15d50223-2f73-4260-a613-fc084000dd7d
26cd9ffd-cf9f-4fd5-882d-6c5811d58555	th	f	18	10	2024-08-20 10:24:02.046+00	2024-08-20 10:24:02.046+00	36e5f8bd-beba-467b-8ee5-e653940a0b43
09c225be-4b14-4f1a-a533-78a469da4fda	=)	f	18	10	2024-08-20 10:24:14.956+00	2024-08-20 10:24:14.956+00	15d50223-2f73-4260-a613-fc084000dd7d
bca83761-a18f-4418-9add-44f990c798a3	=)	f	18	10	2024-08-20 10:24:14.965+00	2024-08-20 10:24:14.965+00	36e5f8bd-beba-467b-8ee5-e653940a0b43
67957e21-ab15-40e9-8a4e-30f8956a52b9	😊	f	18	10	2024-08-20 10:24:26.799+00	2024-08-20 10:24:26.799+00	15d50223-2f73-4260-a613-fc084000dd7d
d6df6571-c0fb-4f0b-a680-aa2cfcfc57c3	😊	f	18	10	2024-08-20 10:24:26.807+00	2024-08-20 10:24:26.807+00	36e5f8bd-beba-467b-8ee5-e653940a0b43
f13a088d-dc37-413a-92be-d912e97c87c7	😎	f	10	18	2024-08-20 10:24:43.908+00	2024-08-20 10:24:43.908+00	36e5f8bd-beba-467b-8ee5-e653940a0b43
21fe1d58-0673-47b0-97ab-9bf9a293bfc6	😎	f	10	18	2024-08-20 10:24:43.918+00	2024-08-20 10:24:43.918+00	15d50223-2f73-4260-a613-fc084000dd7d
49c4383e-64b8-419e-8f96-71ca83b2e85e	privet	f	18	16	2024-08-20 10:25:24.267+00	2024-08-20 10:25:24.267+00	06a5c33c-30c3-4031-b73b-5d6526aad35b
85e892b6-5bbf-4eec-b83c-ef8a53b146b4	privet	f	18	16	2024-08-20 10:25:24.271+00	2024-08-20 10:25:24.271+00	526f1d0a-72eb-4c18-98c0-12710dba9f23
5cd95905-d443-4547-b35f-4a50d4c7111c	salam	f	18	19	2024-08-20 10:25:38.593+00	2024-08-20 10:25:38.593+00	82b2aba3-106a-437a-af6a-146d8d2c5913
33dbf594-cd9b-4ed3-94c2-10596c18859c	salam	f	18	19	2024-08-20 10:25:38.597+00	2024-08-20 10:25:38.597+00	b983e5dc-775a-4d67-8cb9-a97c4a57935b
971f9dd7-ca12-4906-bde4-746938193c78	naili	f	18	19	2024-08-20 10:25:43.112+00	2024-08-20 10:25:43.112+00	82b2aba3-106a-437a-af6a-146d8d2c5913
6a7a880a-d71f-4e93-ad41-dccf828e63c9	naili	f	18	19	2024-08-20 10:25:43.115+00	2024-08-20 10:25:43.115+00	b983e5dc-775a-4d67-8cb9-a97c4a57935b
fe393c5c-4fe4-41bd-93f9-3c8c363316cf	cdcddcdc	f	14	16	2024-08-20 11:19:28.825+00	2024-08-20 11:19:28.825+00	a9d75f75-1529-4abe-9e9c-230b78295cbb
01bd00d0-7a25-43cb-8b67-1d49b34697e1	cdcddcdc	f	14	16	2024-08-20 11:19:28.83+00	2024-08-20 11:19:28.83+00	d07c1f42-6ea3-4b03-8289-9e9a9437814f
3e57f50c-d4b9-44eb-9c1b-b55745147918	ok google	f	16	14	2024-08-20 11:20:02.39+00	2024-08-20 11:20:02.39+00	d07c1f42-6ea3-4b03-8289-9e9a9437814f
9b72833d-6987-45ed-b0a9-63c6eafc2e9d	ok google	f	16	14	2024-08-20 11:20:02.4+00	2024-08-20 11:20:02.4+00	a9d75f75-1529-4abe-9e9c-230b78295cbb
e02f1363-c78f-4b42-a5f8-23f251b82ac1	ok gpt	f	16	14	2024-08-20 11:22:58.447+00	2024-08-20 11:22:58.447+00	d07c1f42-6ea3-4b03-8289-9e9a9437814f
029841dc-7790-4975-b08a-994d3f3cdc69	ok gpt	f	16	14	2024-08-20 11:22:58.45+00	2024-08-20 11:22:58.45+00	a9d75f75-1529-4abe-9e9c-230b78295cbb
9f53a46b-18b5-4373-bd22-4b52728514a1	salam	f	14	16	2024-08-20 11:23:02.787+00	2024-08-20 11:23:02.787+00	a9d75f75-1529-4abe-9e9c-230b78295cbb
7fac35e4-c2e1-486b-aba0-f0fa64dfdf9c	salam	f	14	16	2024-08-20 11:23:02.791+00	2024-08-20 11:23:02.791+00	d07c1f42-6ea3-4b03-8289-9e9a9437814f
1da13321-ef53-415e-ba4f-bfc45f82a990	test	f	14	16	2024-08-20 11:23:09.657+00	2024-08-20 11:23:09.657+00	a9d75f75-1529-4abe-9e9c-230b78295cbb
397e11e8-9eb8-42fa-81b7-7c9a48679d22	test	f	14	16	2024-08-20 11:23:09.661+00	2024-08-20 11:23:09.661+00	d07c1f42-6ea3-4b03-8289-9e9a9437814f
c61d694d-481f-47eb-a9ac-79355bbdf1cf	1	f	14	16	2024-08-20 11:23:11.776+00	2024-08-20 11:23:11.776+00	a9d75f75-1529-4abe-9e9c-230b78295cbb
a32f882d-f3df-46f9-9186-a9badb65cc98	1	f	14	16	2024-08-20 11:23:11.78+00	2024-08-20 11:23:11.78+00	d07c1f42-6ea3-4b03-8289-9e9a9437814f
75765ef9-4dc5-4e25-bce0-19d6ef0fca09	f	f	14	16	2024-08-20 11:23:13.25+00	2024-08-20 11:23:13.25+00	a9d75f75-1529-4abe-9e9c-230b78295cbb
0b2f2f93-5ebb-4f86-b07a-f6d77620dec5	f	f	14	16	2024-08-20 11:23:13.254+00	2024-08-20 11:23:13.254+00	d07c1f42-6ea3-4b03-8289-9e9a9437814f
d296792d-d9ad-4a5a-8fb9-e971ec825566	dc	f	14	16	2024-08-20 11:23:13.593+00	2024-08-20 11:23:13.593+00	a9d75f75-1529-4abe-9e9c-230b78295cbb
731ce317-35c3-4eb4-b38d-896522dce363	dc	f	14	16	2024-08-20 11:23:13.597+00	2024-08-20 11:23:13.597+00	d07c1f42-6ea3-4b03-8289-9e9a9437814f
e49c12f5-5101-4779-bbf9-32341907031a	dcd	f	14	16	2024-08-20 11:23:13.858+00	2024-08-20 11:23:13.858+00	a9d75f75-1529-4abe-9e9c-230b78295cbb
9ef926e6-7ea3-4724-8ad3-dcdf04689dc8	dcd	f	14	16	2024-08-20 11:23:13.861+00	2024-08-20 11:23:13.861+00	d07c1f42-6ea3-4b03-8289-9e9a9437814f
b3240dae-d94c-4a27-9a8c-29c82b183e42	c	f	14	16	2024-08-20 11:23:14.032+00	2024-08-20 11:23:14.032+00	a9d75f75-1529-4abe-9e9c-230b78295cbb
c173ee3d-e35f-4784-b15a-b9ccaf10175e	c	f	14	16	2024-08-20 11:23:14.035+00	2024-08-20 11:23:14.035+00	d07c1f42-6ea3-4b03-8289-9e9a9437814f
8293671d-4c4c-4a74-a354-76a8850d3cda	d	f	14	16	2024-08-20 11:23:14.226+00	2024-08-20 11:23:14.226+00	a9d75f75-1529-4abe-9e9c-230b78295cbb
825bd222-6463-4968-b565-c3b4a0429b86	d	f	14	16	2024-08-20 11:23:14.229+00	2024-08-20 11:23:14.229+00	d07c1f42-6ea3-4b03-8289-9e9a9437814f
cf001cbb-a859-4e89-a1b7-642fd3a50aae	vas	f	14	16	2024-08-20 11:23:14.667+00	2024-08-20 11:23:14.667+00	a9d75f75-1529-4abe-9e9c-230b78295cbb
254387ed-af65-4f75-a0b8-8c13fa94b2ee	vas	f	14	16	2024-08-20 11:23:14.67+00	2024-08-20 11:23:14.67+00	d07c1f42-6ea3-4b03-8289-9e9a9437814f
202e0490-09da-4d6e-ac4c-1e735f8d3ff2	vfvfvf	f	16	14	2024-08-20 11:23:18.051+00	2024-08-20 11:23:18.051+00	d07c1f42-6ea3-4b03-8289-9e9a9437814f
9440870b-8cb7-4d5e-a424-21d28ce2107d	vfvfvf	f	16	14	2024-08-20 11:23:18.054+00	2024-08-20 11:23:18.054+00	a9d75f75-1529-4abe-9e9c-230b78295cbb
0d8fd485-e709-484b-878f-829ec0fc9837	vfvf	f	16	14	2024-08-20 11:23:18.58+00	2024-08-20 11:23:18.58+00	d07c1f42-6ea3-4b03-8289-9e9a9437814f
be7668fa-f10a-4228-bc9b-88009e8ca696	vfvf	f	16	14	2024-08-20 11:23:18.583+00	2024-08-20 11:23:18.583+00	a9d75f75-1529-4abe-9e9c-230b78295cbb
4f29c152-1984-47fe-a91b-c8d12dea6262	vf	f	16	14	2024-08-20 11:23:18.802+00	2024-08-20 11:23:18.802+00	d07c1f42-6ea3-4b03-8289-9e9a9437814f
50cb20b3-5491-4b75-a6ef-826f0b7bcc30	vf	f	16	14	2024-08-20 11:23:18.805+00	2024-08-20 11:23:18.805+00	a9d75f75-1529-4abe-9e9c-230b78295cbb
32bcfeee-5cf5-4121-b8b6-34d890ad188c	vf	f	16	14	2024-08-20 11:23:19.064+00	2024-08-20 11:23:19.064+00	d07c1f42-6ea3-4b03-8289-9e9a9437814f
08f7b224-a1f1-4a55-ad7d-d7cdc3a8c808	vf	f	16	14	2024-08-20 11:23:19.067+00	2024-08-20 11:23:19.067+00	a9d75f75-1529-4abe-9e9c-230b78295cbb
8518def7-c5ca-4ba7-9ccc-54383a2bae5b	bir zatlar bolyamy?	f	16	18	2024-08-20 11:25:20.549+00	2024-08-20 11:25:20.549+00	526f1d0a-72eb-4c18-98c0-12710dba9f23
f3abe4fd-b572-4dfd-9bfc-b214eafd7014	bir zatlar bolyamy?	f	16	18	2024-08-20 11:25:20.56+00	2024-08-20 11:25:20.56+00	06a5c33c-30c3-4031-b73b-5d6526aad35b
35cd7884-6549-41a1-83f3-84f666d2f637	hello	f	16	18	2024-08-20 11:33:23.249+00	2024-08-20 11:33:23.249+00	526f1d0a-72eb-4c18-98c0-12710dba9f23
bf2da5b4-9601-462b-b092-77843f6ac4bb	hello	f	16	18	2024-08-20 11:33:23.264+00	2024-08-20 11:33:23.264+00	06a5c33c-30c3-4031-b73b-5d6526aad35b
4a08cdbf-114b-419a-8280-1591b47a1d22	bolyamy bir zatlar	f	16	18	2024-08-20 11:33:29.819+00	2024-08-20 11:33:29.819+00	526f1d0a-72eb-4c18-98c0-12710dba9f23
06a8d43a-01c8-4ada-9d0d-48ccbb2d55d4	bolyamy bir zatlar	f	16	18	2024-08-20 11:33:29.823+00	2024-08-20 11:33:29.823+00	06a5c33c-30c3-4031-b73b-5d6526aad35b
ad78e0b8-fbfa-402a-901b-1ae8e61a5b82	cknds	f	16	14	2024-08-20 11:37:44.415+00	2024-08-20 11:37:44.415+00	d07c1f42-6ea3-4b03-8289-9e9a9437814f
82cc8299-e621-4030-8505-e6fba4ec5719	cknds	f	16	14	2024-08-20 11:37:44.419+00	2024-08-20 11:37:44.419+00	a9d75f75-1529-4abe-9e9c-230b78295cbb
052b3b58-9ccb-4bcc-ba3b-1925a5073788	cdcdcdc	f	14	16	2024-08-20 11:37:48.039+00	2024-08-20 11:37:48.039+00	a9d75f75-1529-4abe-9e9c-230b78295cbb
c703bfff-de83-44ca-9dd8-7be09cd3d400	cdcdcdc	f	14	16	2024-08-20 11:37:48.042+00	2024-08-20 11:37:48.042+00	d07c1f42-6ea3-4b03-8289-9e9a9437814f
b0f4b76e-4548-4caa-adbd-726bf3b350a4	sdcsd	f	16	14	2024-08-20 11:37:50.702+00	2024-08-20 11:37:50.702+00	d07c1f42-6ea3-4b03-8289-9e9a9437814f
2cb024cf-3d44-470a-b5fe-fbe5ed3a52a4	sdcsd	f	16	14	2024-08-20 11:37:50.706+00	2024-08-20 11:37:50.706+00	a9d75f75-1529-4abe-9e9c-230b78295cbb
7e886738-c701-47fb-96d8-6718fa3369eb	Hi	f	16	10	2024-08-20 11:39:37.998+00	2024-08-20 11:39:37.998+00	c8bf3fef-1f7a-446c-978e-e1dd94544fb0
81a01ffd-b675-4efe-aff9-29471de42cf1	Hi	f	16	10	2024-08-20 11:39:38.008+00	2024-08-20 11:39:38.008+00	697f696c-94cd-4eaf-9747-aca46c979f71
4159ba6b-206b-4c90-a4a1-53f119b2936c	gowy	f	19	18	2024-08-21 06:32:39.153+00	2024-08-21 06:32:39.153+00	b983e5dc-775a-4d67-8cb9-a97c4a57935b
3b3ea68f-35b8-42e3-8a84-e8cd74e6ef22	gowy	f	19	18	2024-08-21 06:32:39.159+00	2024-08-21 06:32:39.159+00	82b2aba3-106a-437a-af6a-146d8d2c5913
abe9b330-f11b-4048-9031-805363b046d2	sen naili	f	19	18	2024-08-21 06:32:42.191+00	2024-08-21 06:32:42.191+00	b983e5dc-775a-4d67-8cb9-a97c4a57935b
277e415f-13b0-4725-bbc7-2d27b9f72364	sen naili	f	19	18	2024-08-21 06:32:42.195+00	2024-08-21 06:32:42.195+00	82b2aba3-106a-437a-af6a-146d8d2c5913
11bfa449-76e6-418f-8cd6-248ab02c6112	hello	f	19	16	2024-08-21 06:32:48.92+00	2024-08-21 06:32:48.92+00	5c614b47-892d-4719-8d77-ae96fb691d1c
e26fea18-ddc3-4923-b0c4-a12b3830d84a	hello	f	19	16	2024-08-21 06:32:48.924+00	2024-08-21 06:32:48.924+00	1f1147f8-61d9-46aa-b19e-2c95c2825721
f5aff473-46ed-49fc-8e56-7ca8371f0912	Atamyrat updata etdim barlap gor 	f	16	18	2024-08-21 09:45:09.008+00	2024-08-21 09:45:09.008+00	526f1d0a-72eb-4c18-98c0-12710dba9f23
781f3b71-233a-4af5-8fcf-38c2309b2392	Atamyrat updata etdim barlap gor 	f	16	18	2024-08-21 09:45:09.017+00	2024-08-21 09:45:09.017+00	06a5c33c-30c3-4031-b73b-5d6526aad35b
7bb2516c-5668-4255-916f-67e004930c8c	nali	f	18	16	2024-08-22 07:19:36.963+00	2024-08-22 07:19:36.963+00	06a5c33c-30c3-4031-b73b-5d6526aad35b
854e16a6-aca9-4469-a59c-2d4b061f3e52	nali	f	18	16	2024-08-22 07:19:36.97+00	2024-08-22 07:19:36.97+00	526f1d0a-72eb-4c18-98c0-12710dba9f23
53a23778-7bd6-4415-bb44-60517585b4d7	erbet dal	f	18	19	2024-08-22 07:19:47.585+00	2024-08-22 07:19:47.585+00	82b2aba3-106a-437a-af6a-146d8d2c5913
7f6ef7bd-a64e-449a-bba8-e0b10704e44f	erbet dal	f	18	19	2024-08-22 07:19:47.588+00	2024-08-22 07:19:47.588+00	b983e5dc-775a-4d67-8cb9-a97c4a57935b
8e43ffb7-92e7-44c5-af51-4004a27810ea	chrome da uwedomlemie nadip edip bolya su chat ucin ?	f	18	19	2024-08-22 07:20:20.837+00	2024-08-22 07:20:20.837+00	82b2aba3-106a-437a-af6a-146d8d2c5913
7c11e093-d655-4b42-aabe-7d3104261672	chrome da uwedomlemie nadip edip bolya su chat ucin ?	f	18	19	2024-08-22 07:20:20.846+00	2024-08-22 07:20:20.846+00	b983e5dc-775a-4d67-8cb9-a97c4a57935b
96995e45-3a2b-4332-bddc-84af8975443e	aa	f	18	24	2024-08-22 09:10:16.338+00	2024-08-22 09:10:16.338+00	01f6b688-61f7-4cd6-a191-da2dddfe4d0d
1d5b2475-c75d-4f64-a635-880e8d5ed4d6	aa	f	18	24	2024-08-22 09:10:16.343+00	2024-08-22 09:10:16.343+00	a10e7f0e-58cc-49cc-9c30-30a1df4a645c
7beca7d2-fb2a-4154-ad8d-31c5337e2a5f	AA	f	18	24	2024-08-22 09:10:22.388+00	2024-08-22 09:10:22.388+00	01f6b688-61f7-4cd6-a191-da2dddfe4d0d
79bde37d-0536-4237-8d9c-ac00f08a7d8c	AA	f	18	24	2024-08-22 09:10:22.403+00	2024-08-22 09:10:22.403+00	a10e7f0e-58cc-49cc-9c30-30a1df4a645c
0c7c3ce9-9d64-4aea-a77c-f2fb88ccd691	ACFG	f	18	24	2024-08-22 09:10:33.344+00	2024-08-22 09:10:33.344+00	01f6b688-61f7-4cd6-a191-da2dddfe4d0d
be91e877-c3f6-4a1d-b61b-ce6de22badde	ACFG	f	18	24	2024-08-22 09:10:33.347+00	2024-08-22 09:10:33.347+00	a10e7f0e-58cc-49cc-9c30-30a1df4a645c
67e793b8-e2f7-45e1-aa9c-dfe2fc855dcf	a	f	9	16	2024-08-23 03:59:08.654+00	2024-08-23 03:59:08.654+00	7a4fdada-b415-47c8-8741-280528e55129
4bed7975-8baf-4075-8377-0fef76f04b04	a	f	9	16	2024-08-23 03:59:08.66+00	2024-08-23 03:59:08.66+00	eda2e444-2066-419c-8464-3ebd46ca63ac
1a7be4b2-b469-4ba9-848f-a71b533c1c1b	fff	f	18	24	2024-08-24 08:43:03.481+00	2024-08-24 08:43:03.481+00	01f6b688-61f7-4cd6-a191-da2dddfe4d0d
5e8dc405-18cf-445f-83ea-da7c591fc430	fff	f	18	24	2024-08-24 08:43:03.486+00	2024-08-24 08:43:03.486+00	a10e7f0e-58cc-49cc-9c30-30a1df4a645c
c5dc39a2-9726-4b7a-8252-2720fa52f4cd	zapros soramaly bashda	f	19	18	2024-08-26 06:36:51.073+00	2024-08-26 06:36:51.073+00	b983e5dc-775a-4d67-8cb9-a97c4a57935b
6d83f815-89a2-44c8-a197-cf929738c51d	zapros soramaly bashda	f	19	18	2024-08-26 06:36:51.084+00	2024-08-26 06:36:51.084+00	82b2aba3-106a-437a-af6a-146d8d2c5913
891c0f93-12fa-4cd5-882d-cf10950ef903	son enable etmeli	f	19	18	2024-08-26 06:36:55.343+00	2024-08-26 06:36:55.343+00	b983e5dc-775a-4d67-8cb9-a97c4a57935b
86f22044-173e-4db1-88e0-36af28974d85	son enable etmeli	f	19	18	2024-08-26 06:36:55.346+00	2024-08-26 06:36:55.346+00	82b2aba3-106a-437a-af6a-146d8d2c5913
ec8f1bfc-af49-4d75-9bbd-3c6ecd97bd17	vfdvd	f	14	16	2024-08-27 05:48:25.581+00	2024-08-27 05:48:25.581+00	a9d75f75-1529-4abe-9e9c-230b78295cbb
1a2a6718-9066-4dba-99e7-ac2be2aedc18	vfdvd	f	14	16	2024-08-27 05:48:25.608+00	2024-08-27 05:48:25.608+00	d07c1f42-6ea3-4b03-8289-9e9a9437814f
ac90aa5a-16b2-480a-b4c4-52d40f49cc99	qqq	f	16	14	2024-08-27 05:48:33.902+00	2024-08-27 05:48:33.902+00	d07c1f42-6ea3-4b03-8289-9e9a9437814f
bf0e2f93-5d26-4ed2-81d5-a1c01d1a213d	qqq	f	16	14	2024-08-27 05:48:33.907+00	2024-08-27 05:48:33.907+00	a9d75f75-1529-4abe-9e9c-230b78295cbb
5237729f-e6e1-41bd-8f90-0dbd87213ab2	aaaaa1`	f	16	14	2024-08-27 07:21:18.011+00	2024-08-27 07:21:18.011+00	d07c1f42-6ea3-4b03-8289-9e9a9437814f
9bb104c6-635d-4e95-a54a-347843aa4399	aaaaa1`	f	16	14	2024-08-27 07:21:18.017+00	2024-08-27 07:21:18.017+00	a9d75f75-1529-4abe-9e9c-230b78295cbb
5b1e8a4f-d3c2-45f2-95cc-eb32a0880425	Salouwa	f	5	16	2024-08-28 02:48:11.273+00	2024-08-28 02:48:11.273+00	ead23234-0e53-4e83-8ffc-a52d3526dfa5
d619b4ee-47fa-4af0-8dcc-5653ee54e1f3	Salouwa	f	5	16	2024-08-28 02:48:11.278+00	2024-08-28 02:48:11.278+00	1800e9fd-f0be-49a2-bdb0-82ae634f3f30
4403a56f-13d3-45cf-a19b-d46210dcc684	salam	f	15	14	2024-08-31 09:50:01.873+00	2024-08-31 09:50:01.873+00	b729f2f4-82c7-4735-89bb-8bb366e9adba
e08682f9-d9a8-4a27-b809-caca3b68407b	salam	f	15	14	2024-08-31 09:50:01.881+00	2024-08-31 09:50:01.881+00	c4317f17-4338-469a-80f3-ed932fdd9f1e
c11fb6e1-855d-4108-ae9a-72f6f64f9e4a	ASlo	f	18	16	2024-09-02 04:49:45.48+00	2024-09-02 04:49:45.48+00	06a5c33c-30c3-4031-b73b-5d6526aad35b
d147a92c-7f6e-479e-9fd4-f6e0038b3c66	ASlo	f	18	16	2024-09-02 04:49:45.488+00	2024-09-02 04:49:45.488+00	526f1d0a-72eb-4c18-98c0-12710dba9f23
1248ade4-7bab-45cc-8b73-51d1958a0121	Alo	f	18	16	2024-09-02 04:49:46.94+00	2024-09-02 04:49:46.94+00	06a5c33c-30c3-4031-b73b-5d6526aad35b
71990bfb-bb62-4099-bab9-ccf49fcc7b31	Alo	f	18	16	2024-09-02 04:49:46.944+00	2024-09-02 04:49:46.944+00	526f1d0a-72eb-4c18-98c0-12710dba9f23
2eb7a0fb-c1d8-4a80-a149-27ae65e0d22e	Alo	f	18	16	2024-09-02 04:49:48.744+00	2024-09-02 04:49:48.744+00	06a5c33c-30c3-4031-b73b-5d6526aad35b
d97d8c66-5b97-4bcb-aeb9-b29914964203	Alo	f	18	16	2024-09-02 04:49:48.748+00	2024-09-02 04:49:48.748+00	526f1d0a-72eb-4c18-98c0-12710dba9f23
5afa7ee9-a677-49bc-bc9a-400d27d1d039	Salam	f	26	16	2024-09-03 03:07:01.839+00	2024-09-03 03:07:01.839+00	\N
c94090db-f461-42b8-874d-771a0a0724df	Salam	f	26	16	2024-09-03 03:07:01.844+00	2024-09-03 03:07:01.844+00	\N
7f858f6e-2edd-49b3-b9cf-022f2bae08d8	Good morning	f	26	16	2024-09-03 03:07:13.3+00	2024-09-03 03:07:13.3+00	\N
7cb2c9e9-1654-4450-9c8d-a01ef35370e0	Good morning	f	26	16	2024-09-03 03:07:13.304+00	2024-09-03 03:07:13.304+00	\N
cf824c6e-0662-4d88-b52b-d8d2b9c0dd7e	Hshsh	f	16	26	2024-09-03 03:07:46.177+00	2024-09-03 03:07:46.177+00	4ec3dc05-e2d6-4305-9543-887a4a3bec7d
37156ee9-24cb-46b5-8c50-8fd6a9a4e527	Hshsh	f	16	26	2024-09-03 03:07:46.182+00	2024-09-03 03:07:46.182+00	9386c6e4-54d0-40f8-a098-f8a3d62381c6
0dccae9c-9b26-4aa8-9c60-c0daed3a532e	Sajaha	f	16	26	2024-09-03 03:08:20.276+00	2024-09-03 03:08:20.276+00	4ec3dc05-e2d6-4305-9543-887a4a3bec7d
958ca4fe-87c9-4d44-b99e-7c73a0fd8a7f	Sajaha	f	16	26	2024-09-03 03:08:20.281+00	2024-09-03 03:08:20.281+00	9386c6e4-54d0-40f8-a098-f8a3d62381c6
384ef3cd-0eec-438f-a703-4d4c430abd28	ssss	f	26	16	2024-09-03 03:08:22.605+00	2024-09-03 03:08:22.605+00	9386c6e4-54d0-40f8-a098-f8a3d62381c6
2b9c6990-8e2b-455b-b3fb-1f5709596160	ssss	f	26	16	2024-09-03 03:08:22.609+00	2024-09-03 03:08:22.609+00	4ec3dc05-e2d6-4305-9543-887a4a3bec7d
62d74896-bd60-421b-a946-8d55157b847d	üsüsü	f	27	16	2024-09-06 09:08:56.407+00	2024-09-06 09:08:56.407+00	f4f91f9f-412d-48e1-8fad-7c75f909f94e
64cbbf85-2c25-4cf5-8c6a-71f73b00c437	üsüsü	f	27	16	2024-09-06 09:08:56.412+00	2024-09-06 09:08:56.412+00	b3e12564-bd8a-4548-9838-0f99ebccfb2f
1bb06745-c6ce-41da-aad1-432dbd2059b4	us susu sususu	f	27	16	2024-09-06 10:51:21.831+00	2024-09-06 10:51:21.831+00	f4f91f9f-412d-48e1-8fad-7c75f909f94e
b9632f42-c557-4871-b0a2-6815f48983f3	us susu sususu	f	27	16	2024-09-06 10:51:21.834+00	2024-09-06 10:51:21.834+00	b3e12564-bd8a-4548-9838-0f99ebccfb2f
3005778e-6ff5-477c-83c2-92ca86fe2637	🦾	f	16	27	2024-09-06 10:52:14.331+00	2024-09-06 10:52:14.331+00	b3e12564-bd8a-4548-9838-0f99ebccfb2f
9c84d179-bf6d-42b9-a9a5-30c76e358845	🦾	f	16	27	2024-09-06 10:52:14.34+00	2024-09-06 10:52:14.34+00	f4f91f9f-412d-48e1-8fad-7c75f909f94e
02a1d390-f667-4b5c-b8e6-5f3ff5c9b1e0	¯\\_(ツ)_/¯	f	27	16	2024-09-06 10:52:38.051+00	2024-09-06 10:52:38.051+00	f4f91f9f-412d-48e1-8fad-7c75f909f94e
e3f1619e-2df2-41f0-aadf-9840843318ab	¯\\_(ツ)_/¯	f	27	16	2024-09-06 10:52:38.06+00	2024-09-06 10:52:38.06+00	b3e12564-bd8a-4548-9838-0f99ebccfb2f
3a6f1b79-dec3-4cf2-9160-7b1d1ecc3ded	🔥🌊🌪❄	f	16	27	2024-09-06 10:53:48.525+00	2024-09-06 10:53:48.525+00	b3e12564-bd8a-4548-9838-0f99ebccfb2f
7f8c19c7-dbcb-4fc2-931a-459d240d61a7	🔥🌊🌪❄	f	16	27	2024-09-06 10:53:48.532+00	2024-09-06 10:53:48.532+00	f4f91f9f-412d-48e1-8fad-7c75f909f94e
1b2ec6b5-ed51-4b39-8dda-7b549a475a7a	(⌐■_■)	f	16	27	2024-09-06 10:54:07.547+00	2024-09-06 10:54:07.547+00	b3e12564-bd8a-4548-9838-0f99ebccfb2f
0da5fb2a-09c8-469f-bec2-0a2ca8d579b9	(⌐■_■)	f	16	27	2024-09-06 10:54:07.555+00	2024-09-06 10:54:07.555+00	f4f91f9f-412d-48e1-8fad-7c75f909f94e
5ca91cd4-b701-4303-981c-ea0014a5fb70	🕟	f	27	16	2024-09-06 10:54:34.35+00	2024-09-06 10:54:34.35+00	f4f91f9f-412d-48e1-8fad-7c75f909f94e
a1cd3592-c5df-4bce-9b22-f43eb0133806	🕟	f	27	16	2024-09-06 10:54:34.359+00	2024-09-06 10:54:34.359+00	b3e12564-bd8a-4548-9838-0f99ebccfb2f
4ae6fa9e-85a6-468c-bc2b-97c6edaeedc5	asdasdasd	f	27	16	2024-09-24 07:39:49.784+00	2024-09-24 07:39:49.784+00	f4f91f9f-412d-48e1-8fad-7c75f909f94e
fa3f5407-0989-4836-8f41-827f14446153	asdasdasd	f	27	16	2024-09-24 07:39:49.791+00	2024-09-24 07:39:49.791+00	b3e12564-bd8a-4548-9838-0f99ebccfb2f
f42ceb85-39a6-416f-a20e-f009c7cc5a42	cascasdc	f	16	27	2024-09-24 07:39:59.804+00	2024-09-24 07:39:59.804+00	b3e12564-bd8a-4548-9838-0f99ebccfb2f
8b40faa3-3e20-448d-ae8a-cefdb32fcde3	cascasdc	f	16	27	2024-09-24 07:39:59.808+00	2024-09-24 07:39:59.808+00	f4f91f9f-412d-48e1-8fad-7c75f909f94e
c62b9c9c-661c-4b73-85fc-dff2cf219d37	dsfadsfasd	f	27	16	2024-09-24 07:40:11.391+00	2024-09-24 07:40:11.391+00	f4f91f9f-412d-48e1-8fad-7c75f909f94e
66a2ac76-1818-4241-a048-7e33cd3dea6d	dsfadsfasd	f	27	16	2024-09-24 07:40:11.401+00	2024-09-24 07:40:11.401+00	b3e12564-bd8a-4548-9838-0f99ebccfb2f
714756ef-8ac4-4f35-8be0-d360e7ca58d3	03.10	f	16	14	2024-10-03 07:07:47.212+00	2024-10-03 07:07:47.212+00	d07c1f42-6ea3-4b03-8289-9e9a9437814f
239ed416-646f-489f-a4c8-5128c194498c	03.10	f	16	14	2024-10-03 07:07:47.219+00	2024-10-03 07:07:47.219+00	\N
264cb67a-7ec6-450f-a398-f2bee706f41f	Ismayyl 03.10	f	14	16	2024-10-03 07:09:19.343+00	2024-10-03 07:09:19.343+00	a9d75f75-1529-4abe-9e9c-230b78295cbb
0b521066-3d4d-4766-a073-880fe51756cf	Ismayyl 03.10	f	14	16	2024-10-03 07:09:19.353+00	2024-10-03 07:09:19.353+00	\N
367a7b42-4903-41c2-b305-b2726943d3c7	Test 03.10	f	14	16	2024-10-03 07:09:42.868+00	2024-10-03 07:09:42.868+00	a9d75f75-1529-4abe-9e9c-230b78295cbb
552c092b-9bed-47cd-81d0-53d0f0b7abd0	Test 03.10	f	14	16	2024-10-03 07:09:42.874+00	2024-10-03 07:09:42.874+00	\N
ae17fc60-8fb5-40d9-8aa8-431f4309e1a8	Bahar -> ismayyl msg	f	16	14	2024-10-03 07:12:10.027+00	2024-10-03 07:12:10.027+00	d07c1f42-6ea3-4b03-8289-9e9a9437814f
d353e78b-593f-48f1-8f55-83b96cc39224	Bahar -> ismayyl msg	f	16	14	2024-10-03 07:12:10.038+00	2024-10-03 07:12:10.038+00	\N
4d49c4f4-167c-47b7-973a-493cc5b792c5	Bahar send msg to Ismayyl	f	14	16	2024-10-03 07:18:24.049+00	2024-10-03 07:18:24.049+00	a9d75f75-1529-4abe-9e9c-230b78295cbb
501fa12c-9916-44a5-ab05-5cab3f17d260	Bahar send msg to Ismayyl	f	14	16	2024-10-03 07:18:24.059+00	2024-10-03 07:18:24.059+00	\N
c4f259d8-c042-4930-90ca-6353cbf9b50b	Ismayyl to bahar send msg smurfiki	f	16	14	2024-10-03 07:18:59.792+00	2024-10-03 07:18:59.792+00	d07c1f42-6ea3-4b03-8289-9e9a9437814f
d0548383-4fff-4974-b291-c52ee5f9c6ac	Ismayyl to bahar send msg smurfiki	f	16	14	2024-10-03 07:18:59.801+00	2024-10-03 07:18:59.801+00	\N
c77b6135-b875-4e90-a303-9334df321ba5	..	f	16	8	2024-10-03 07:24:53.319+00	2024-10-03 07:24:53.319+00	502cfe29-3cc0-4b57-92c4-40d14ea40993
30d334d6-772f-4be3-aaf3-6863d9fdb5a6	..	f	16	8	2024-10-03 07:24:53.324+00	2024-10-03 07:24:53.324+00	\N
d0df695e-b1e4-4485-8e30-613926d13ce8	Bahar men	f	14	15	2024-10-03 07:25:44.442+00	2024-10-03 07:25:44.442+00	c4317f17-4338-469a-80f3-ed932fdd9f1e
77f671b2-b3e0-4e90-85d6-8d49156b5949	Bahar men	f	14	15	2024-10-03 07:25:44.449+00	2024-10-03 07:25:44.449+00	\N
a9f275d8-1060-4ccd-bed5-b09e843f55f1	Aylar men bahar diyan😡	f	14	15	2024-10-03 07:28:17.164+00	2024-10-03 07:28:17.164+00	c4317f17-4338-469a-80f3-ed932fdd9f1e
207c4cb4-cde4-40e4-9702-3d67056a5918	Aylar men bahar diyan😡	f	14	15	2024-10-03 07:28:17.174+00	2024-10-03 07:28:17.174+00	\N
c2b39310-70fb-4187-938a-fcde7b47bcfe	Men aylar 05	f	15	14	2024-10-03 07:29:12.658+00	2024-10-03 07:29:12.658+00	b729f2f4-82c7-4735-89bb-8bb366e9adba
e5b15f50-1d5e-441d-954f-bf3033d424ca	Men aylar 05	f	15	14	2024-10-03 07:29:12.664+00	2024-10-03 07:29:12.664+00	\N
183d8c26-4e29-43c3-90ad-b6252bf7341b	....	f	15	14	2024-10-03 07:36:08.697+00	2024-10-03 07:36:08.697+00	b729f2f4-82c7-4735-89bb-8bb366e9adba
5347ab6b-09f7-4fbc-a19a-7b5189b3bd4c	....	f	15	14	2024-10-03 07:36:08.707+00	2024-10-03 07:36:08.707+00	\N
2c0a0de8-9088-4f4e-b3d1-dfe3361af491	Mercuri	f	14	16	2024-10-03 07:38:16.593+00	2024-10-03 07:38:16.593+00	a9d75f75-1529-4abe-9e9c-230b78295cbb
b144cb31-9e68-488b-b74a-27a8c6ce11d7	Mercuri	f	14	16	2024-10-03 07:38:16.604+00	2024-10-03 07:38:16.604+00	\N
4fa9ca71-695f-4f34-8464-e6d20fa19f45	09875422	f	14	16	2024-10-03 07:43:26.025+00	2024-10-03 07:43:26.025+00	a9d75f75-1529-4abe-9e9c-230b78295cbb
62978f4d-9b4c-4560-b01f-3a4bf12c72f5	09875422	f	14	16	2024-10-03 07:43:26.035+00	2024-10-03 07:43:26.035+00	\N
226531cc-5990-455e-9cfb-82bae693442a	Bshdh	f	14	14	2024-10-03 07:43:52.239+00	2024-10-03 07:43:52.239+00	d07c1f42-6ea3-4b03-8289-9e9a9437814f
32dc4984-c08a-41e9-a9dd-2daa659aedb8	Bshdh	f	14	14	2024-10-03 07:43:52.244+00	2024-10-03 07:43:52.244+00	\N
6f94ed37-79b8-48d1-9e5f-06ab49783047	Opera	f	14	16	2024-10-03 08:26:44.993+00	2024-10-03 08:26:44.993+00	a9d75f75-1529-4abe-9e9c-230b78295cbb
41318a3b-49bb-4a51-9536-893655c22a96	Opera	f	14	16	2024-10-03 08:26:44.998+00	2024-10-03 08:26:44.998+00	d07c1f42-6ea3-4b03-8289-9e9a9437814f
3146de05-b382-4158-a035-d8910edf4ddb	Hello	f	16	14	2024-10-03 08:27:20.183+00	2024-10-03 08:27:20.183+00	d07c1f42-6ea3-4b03-8289-9e9a9437814f
ac484157-f901-474e-950e-dbe55897ff3d	Hello	f	16	14	2024-10-03 08:27:20.188+00	2024-10-03 08:27:20.188+00	a9d75f75-1529-4abe-9e9c-230b78295cbb
513df501-c65b-4688-a2b3-6188c892e795	Obed	f	14	16	2024-10-03 08:27:52.516+00	2024-10-03 08:27:52.516+00	a9d75f75-1529-4abe-9e9c-230b78295cbb
77cbf5d9-5e9b-4160-bb32-d75c005a97e8	Obed	f	14	16	2024-10-03 08:27:52.521+00	2024-10-03 08:27:52.521+00	d07c1f42-6ea3-4b03-8289-9e9a9437814f
4ece7866-ab39-4c27-a2b5-7625b56d0fcc	Boldy	f	14	16	2024-10-03 08:28:33.625+00	2024-10-03 08:28:33.625+00	a9d75f75-1529-4abe-9e9c-230b78295cbb
2aae7907-f0f4-4165-a020-7b633073d0ae	Boldy	f	14	16	2024-10-03 08:28:33.633+00	2024-10-03 08:28:33.633+00	d07c1f42-6ea3-4b03-8289-9e9a9437814f
39d2409b-9c10-450e-8da4-fb8721e70d20	Gowmy ismayyl diyp yaz	f	14	16	2024-10-03 08:30:08.931+00	2024-10-03 08:30:08.931+00	a9d75f75-1529-4abe-9e9c-230b78295cbb
6e6fbd6c-2240-4007-aade-30497442e3bd	Gowmy ismayyl diyp yaz	f	14	16	2024-10-03 08:30:08.944+00	2024-10-03 08:30:08.944+00	d07c1f42-6ea3-4b03-8289-9e9a9437814f
7f72bc89-c509-4221-aa2c-a01c1f2b4343	Deada Maksim 	f	16	5	2024-10-03 08:32:38.667+00	2024-10-03 08:32:38.667+00	1800e9fd-f0be-49a2-bdb0-82ae634f3f30
db4da133-9003-4ec5-bf9a-bad97ec53830	Deada Maksim 	f	16	5	2024-10-03 08:32:38.679+00	2024-10-03 08:32:38.679+00	ead23234-0e53-4e83-8ffc-a52d3526dfa5
d7e444a5-9ee0-4266-a3de-6c33210eaf1a	aaaaaa	f	9	28	2024-10-18 15:00:39.554+00	2024-10-18 15:00:39.554+00	7a4fdada-b415-47c8-8741-280528e55129
eeb57952-ea21-46c7-b533-c82d1d93fc8a	aaaaaa	f	9	28	2024-10-18 15:00:39.559+00	2024-10-18 15:00:39.559+00	eda2e444-2066-419c-8464-3ebd46ca63ac
8d7a97f0-88e7-464b-9991-38aced22e80e	xzxxxz	f	9	28	2024-10-18 15:11:32.482+00	2024-10-18 15:11:32.482+00	\N
ae2cf1cb-4117-41e6-b256-dd00b8693475	xzxxxz	f	9	28	2024-10-18 15:11:32.488+00	2024-10-18 15:11:32.488+00	\N
d9b4de69-4b7d-43fa-9219-6fbc488c71b2	xzcxz	f	28	9	2024-10-18 15:11:49.899+00	2024-10-18 15:11:49.899+00	59955386-ae4f-4f88-bf42-a4c450b94845
94473924-2a3e-40de-bbd9-ec3e8a090553	xzcxz	f	28	9	2024-10-18 15:11:49.903+00	2024-10-18 15:11:49.903+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
fc06bfd1-0e70-4482-8555-51b8058e028f	xzcxz	f	28	9	2024-10-18 15:11:54.69+00	2024-10-18 15:11:54.69+00	59955386-ae4f-4f88-bf42-a4c450b94845
2d9cdefa-8731-45dd-aa0b-6fa0c5e8a8fa	xzcxz	f	28	9	2024-10-18 15:11:54.694+00	2024-10-18 15:11:54.694+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
b94c6033-8723-4114-956a-351ec59af94c	zxczxzxcxz	f	28	9	2024-10-18 15:12:05.143+00	2024-10-18 15:12:05.143+00	59955386-ae4f-4f88-bf42-a4c450b94845
c02cfad6-8f3e-429d-9bc8-721918ef9f57	zxczxzxcxz	f	28	9	2024-10-18 15:12:05.147+00	2024-10-18 15:12:05.147+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
89346715-bf79-452d-b47b-4ca3d1ce8b43	adsdsad	f	9	28	2024-10-18 15:15:35.926+00	2024-10-18 15:15:35.926+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
974374fd-aac8-45de-b90f-fb0434d8100d	adsdsad	f	9	28	2024-10-18 15:15:35.943+00	2024-10-18 15:15:35.943+00	59955386-ae4f-4f88-bf42-a4c450b94845
2015e66a-4087-4c5b-8b4e-d147dd1c4d8e	xxcc	f	9	28	2024-10-18 15:17:39.283+00	2024-10-18 15:17:39.283+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
f2ef605f-f309-4d27-9309-f0b71293a215	xxcc	f	9	28	2024-10-18 15:17:39.287+00	2024-10-18 15:17:39.287+00	59955386-ae4f-4f88-bf42-a4c450b94845
25fa4483-8ab3-4802-ae15-8f8d87a895e0	cxz	f	9	28	2024-10-18 15:18:41.027+00	2024-10-18 15:18:41.027+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
76f51290-4dbb-4732-954e-c702866a22d2	cxz	f	9	28	2024-10-18 15:18:41.032+00	2024-10-18 15:18:41.032+00	59955386-ae4f-4f88-bf42-a4c450b94845
57b5cbe8-1fa3-4f0f-88ca-5f1f196867d6	xzczz	f	9	28	2024-10-18 15:18:48.834+00	2024-10-18 15:18:48.834+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
3e591130-9054-410a-8d2c-b47bd302ef85	xzczz	f	9	28	2024-10-18 15:18:48.838+00	2024-10-18 15:18:48.838+00	59955386-ae4f-4f88-bf42-a4c450b94845
10be3496-b5f8-426e-ada8-e064413b4f82	xcvxcv	f	9	28	2024-10-18 15:19:17.419+00	2024-10-18 15:19:17.419+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
96340418-15cf-46aa-a999-408d2a144062	xcvxcv	f	9	28	2024-10-18 15:19:17.423+00	2024-10-18 15:19:17.423+00	59955386-ae4f-4f88-bf42-a4c450b94845
9336e5f7-84a1-4484-b636-ab1c9e47df59	vxcvx	f	9	16	2024-10-18 15:19:25.531+00	2024-10-18 15:19:25.531+00	7a4fdada-b415-47c8-8741-280528e55129
981115c0-c647-443a-9852-28f66b04d816	vxcvx	f	9	16	2024-10-18 15:19:25.534+00	2024-10-18 15:19:25.534+00	eda2e444-2066-419c-8464-3ebd46ca63ac
3a6af0db-f0d9-48dc-9bcd-473cbb25760a	aaa	f	9	28	2024-10-19 04:39:11.553+00	2024-10-19 04:39:11.553+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
cfcea160-2b94-487e-8809-f9ef879add6f	aaa	f	9	28	2024-10-19 04:39:11.569+00	2024-10-19 04:39:11.569+00	59955386-ae4f-4f88-bf42-a4c450b94845
cd3e2d11-cc57-4189-afd7-35ac85033859	ccxc	f	28	9	2024-10-19 04:46:46.447+00	2024-10-19 04:46:46.447+00	59955386-ae4f-4f88-bf42-a4c450b94845
35f63c39-504e-4db7-afa1-8da2ac2d6f8e	ccxc	f	28	9	2024-10-19 04:46:46.454+00	2024-10-19 04:46:46.454+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
0fe61bbf-e2b4-4502-b5d9-4afc3b83f8d7	salam	f	9	28	2024-10-19 04:46:59.847+00	2024-10-19 04:46:59.847+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
068ab133-773d-4f09-b5fd-3a0b493cbe4d	salam	f	9	28	2024-10-19 04:46:59.852+00	2024-10-19 04:46:59.852+00	59955386-ae4f-4f88-bf42-a4c450b94845
38956e18-606e-4f43-ba66-e4b3a9a0a0e8	salkam	f	9	28	2024-10-19 04:47:03.751+00	2024-10-19 04:47:03.751+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
8b5b854d-4f41-4e09-971c-c8ff9e1f8f85	salkam	f	9	28	2024-10-19 04:47:03.756+00	2024-10-19 04:47:03.756+00	59955386-ae4f-4f88-bf42-a4c450b94845
68df09f7-81b1-4f1a-9781-f850e6f18d1b	alo	f	9	28	2024-10-19 04:47:38.095+00	2024-10-19 04:47:38.095+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
5e4db9f5-4763-4b70-a247-b65de04db7e5	alo	f	9	28	2024-10-19 04:47:38.101+00	2024-10-19 04:47:38.101+00	59955386-ae4f-4f88-bf42-a4c450b94845
4eecbd91-c021-4142-8c08-f2f9b452a647	hi	f	9	28	2024-10-19 04:55:22.705+00	2024-10-19 04:55:22.705+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
b8c6c636-9a74-414b-a41c-3eba046ed4dc	hi	f	9	28	2024-10-19 04:55:22.716+00	2024-10-19 04:55:22.716+00	59955386-ae4f-4f88-bf42-a4c450b94845
3f016bb8-8d1a-4d74-b554-b78c3eaddf29	hello	f	28	9	2024-10-19 04:55:39.665+00	2024-10-19 04:55:39.665+00	59955386-ae4f-4f88-bf42-a4c450b94845
1d703879-59c7-43bf-8aff-37d3d18b8662	hello	f	28	9	2024-10-19 04:55:39.669+00	2024-10-19 04:55:39.669+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
97ad80cf-ebb7-427b-bc9f-615768f915e2	b	f	28	9	2024-10-19 04:55:53.514+00	2024-10-19 04:55:53.514+00	59955386-ae4f-4f88-bf42-a4c450b94845
ae713433-962f-4575-b20b-1888df134cdc	b	f	28	9	2024-10-19 04:55:53.523+00	2024-10-19 04:55:53.523+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
560f797c-fa91-49ee-9117-8c6d1ed4a279	ыы	f	28	9	2024-10-19 05:01:54.089+00	2024-10-19 05:01:54.089+00	59955386-ae4f-4f88-bf42-a4c450b94845
7146f115-2aec-4df9-a558-8bc166441260	ыы	f	28	9	2024-10-19 05:01:54.095+00	2024-10-19 05:01:54.095+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
8d2dd658-6875-470b-a89b-9830252ff232	че н	f	9	28	2024-10-19 05:02:11.865+00	2024-10-19 05:02:11.865+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
ec620a71-3069-470a-937c-296648fd70da	че н	f	9	28	2024-10-19 05:02:11.87+00	2024-10-19 05:02:11.87+00	59955386-ae4f-4f88-bf42-a4c450b94845
f3cb904a-508d-4b08-be3d-185f19061049	вв	f	9	28	2024-10-19 05:07:12.882+00	2024-10-19 05:07:12.882+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
641395c8-088b-4f14-99b0-fb72fa95b581	вв	f	9	28	2024-10-19 05:07:12.886+00	2024-10-19 05:07:12.886+00	59955386-ae4f-4f88-bf42-a4c450b94845
39ce4515-f52f-456a-b925-9194b9865f0c	ало	f	9	28	2024-10-19 05:07:25.857+00	2024-10-19 05:07:25.857+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
7dd17497-0851-4e51-b768-50a861048cd2	ало	f	9	28	2024-10-19 05:07:25.861+00	2024-10-19 05:07:25.861+00	59955386-ae4f-4f88-bf42-a4c450b94845
1722315b-5728-498f-8b19-602b48866f9e	привет	f	28	9	2024-10-19 05:07:40.851+00	2024-10-19 05:07:40.851+00	59955386-ae4f-4f88-bf42-a4c450b94845
ecb65fd3-ee71-477c-a6dd-d514696e93f4	привет	f	28	9	2024-10-19 05:07:40.856+00	2024-10-19 05:07:40.856+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
1bbe7333-9624-4bab-9ab3-104f6f710e27	хаи	f	28	9	2024-10-19 05:10:18.137+00	2024-10-19 05:10:18.137+00	59955386-ae4f-4f88-bf42-a4c450b94845
0cff3591-c04d-46d7-b676-525ad29ecd36	хаи	f	28	9	2024-10-19 05:10:18.141+00	2024-10-19 05:10:18.141+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
0e610927-c656-4d04-8edb-1ae299ffce1e	df	f	28	9	2024-10-19 05:10:44.417+00	2024-10-19 05:10:44.417+00	59955386-ae4f-4f88-bf42-a4c450b94845
5552b694-e615-42e2-8ff7-ffe4d40c471b	df	f	28	9	2024-10-19 05:10:44.423+00	2024-10-19 05:10:44.423+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
6889d182-6d3b-44c0-a118-343f69d8f561	dd	f	9	28	2024-10-19 05:11:00.043+00	2024-10-19 05:11:00.043+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
af6a20a3-f4c1-4d9b-8e55-caafcefc7d2e	dd	f	9	28	2024-10-19 05:11:00.047+00	2024-10-19 05:11:00.047+00	59955386-ae4f-4f88-bf42-a4c450b94845
4f80db80-d9e1-4746-a3e5-1d3ec338a4ae	зкшмуе	f	28	9	2024-10-19 05:12:47.009+00	2024-10-19 05:12:47.009+00	59955386-ae4f-4f88-bf42-a4c450b94845
ff9b7de5-e20f-4bfc-94cf-bb473f8bb4a1	зкшмуе	f	28	9	2024-10-19 05:12:47.014+00	2024-10-19 05:12:47.014+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
38565149-bbc5-40aa-b81b-30834722229f	cxz	f	9	28	2024-10-19 05:15:17.398+00	2024-10-19 05:15:17.398+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
eff201db-841c-4a27-afa2-981ccdd55d07	cxz	f	9	28	2024-10-19 05:15:17.403+00	2024-10-19 05:15:17.403+00	59955386-ae4f-4f88-bf42-a4c450b94845
062c72a2-31e2-4dc7-946b-b0ec29418d35	hi	f	28	9	2024-10-19 05:15:29.897+00	2024-10-19 05:15:29.897+00	59955386-ae4f-4f88-bf42-a4c450b94845
c3a56fe7-4c82-488d-81cc-15f95cd9070f	hi	f	28	9	2024-10-19 05:15:29.903+00	2024-10-19 05:15:29.903+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
1214b52e-fa5e-4a66-a64d-36662c93cea7	fff	f	28	9	2024-10-19 05:20:54.658+00	2024-10-19 05:20:54.658+00	59955386-ae4f-4f88-bf42-a4c450b94845
4fa9cd35-3961-49cc-a44b-3989b6c20153	fff	f	28	9	2024-10-19 05:20:54.663+00	2024-10-19 05:20:54.663+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
07a08537-a71d-42f8-871e-73724f50cfa7	ffds	f	9	28	2024-10-19 05:21:12.186+00	2024-10-19 05:21:12.186+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
bc338c02-6945-4725-94bb-1f29985ea4fd	ffds	f	9	28	2024-10-19 05:21:12.191+00	2024-10-19 05:21:12.191+00	59955386-ae4f-4f88-bf42-a4c450b94845
a2a63fa6-17a8-4ce0-b1d1-4d0c16bf5d79	dsaf	f	9	28	2024-10-19 05:21:59.338+00	2024-10-19 05:21:59.338+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
9149543f-3133-464f-9327-bb55a9b5b8bf	dsaf	f	9	28	2024-10-19 05:21:59.351+00	2024-10-19 05:21:59.351+00	59955386-ae4f-4f88-bf42-a4c450b94845
05eeac96-4349-4a3a-a746-8d8573217348	cdsc	f	9	28	2024-10-19 05:22:43.754+00	2024-10-19 05:22:43.754+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
9c948c50-ba79-4b43-85f7-9d71646b58cb	cdsc	f	9	28	2024-10-19 05:22:43.76+00	2024-10-19 05:22:43.76+00	59955386-ae4f-4f88-bf42-a4c450b94845
a7237ea0-8b57-4b95-be27-980831359c23	cds	f	9	28	2024-10-19 05:22:51.562+00	2024-10-19 05:22:51.562+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
45735731-33af-4ce8-adbd-8d1a4e0f32fa	cds	f	9	28	2024-10-19 05:22:51.568+00	2024-10-19 05:22:51.568+00	59955386-ae4f-4f88-bf42-a4c450b94845
ff3b06b8-a5b4-485f-8ff8-ab97411bd171	vxc	f	28	9	2024-10-19 05:23:05.306+00	2024-10-19 05:23:05.306+00	59955386-ae4f-4f88-bf42-a4c450b94845
b67a24fb-9eec-4cc0-8229-403364ca8930	vxc	f	28	9	2024-10-19 05:23:05.311+00	2024-10-19 05:23:05.311+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
f3e4ba28-6b84-4ee3-a6fe-b63217181ebc	gferaffdsf	f	28	9	2024-10-19 05:24:36.739+00	2024-10-19 05:24:36.739+00	59955386-ae4f-4f88-bf42-a4c450b94845
5ab38062-65c3-49c6-be46-20f10338cf7c	gferaffdsf	f	28	9	2024-10-19 05:24:36.762+00	2024-10-19 05:24:36.762+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
080de88c-c654-4bab-b971-8b9b7515a149	hi	f	9	28	2024-10-19 05:24:53.133+00	2024-10-19 05:24:53.133+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
60222bb0-d72e-4e3e-b552-d206bc51465c	hi	f	9	28	2024-10-19 05:24:53.155+00	2024-10-19 05:24:53.155+00	59955386-ae4f-4f88-bf42-a4c450b94845
64b0d9a9-dadf-4610-ab8e-b69649c60e06	sda	f	9	28	2024-10-19 05:33:25.06+00	2024-10-19 05:33:25.06+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
13fd0cf4-7c77-4f20-a4f1-6381e2056322	sda	f	9	28	2024-10-19 05:33:25.066+00	2024-10-19 05:33:25.066+00	59955386-ae4f-4f88-bf42-a4c450b94845
3238561f-9021-4324-a7e3-9b17f9bcaf70	bye	f	9	28	2024-10-19 05:33:37.413+00	2024-10-19 05:33:37.413+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
e290e814-1408-42e7-87fa-275c709b059f	bye	f	9	28	2024-10-19 05:33:37.424+00	2024-10-19 05:33:37.424+00	59955386-ae4f-4f88-bf42-a4c450b94845
ede6e356-a783-4d64-884f-987bbe8e3f6b	hi	f	28	9	2024-10-19 05:33:48.477+00	2024-10-19 05:33:48.477+00	59955386-ae4f-4f88-bf42-a4c450b94845
947ab646-e98a-44d8-b7bc-fc99ff479dbb	hi	f	28	9	2024-10-19 05:33:48.483+00	2024-10-19 05:33:48.483+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
81c51581-c7c2-4d85-a898-eac29daa8997	good	f	28	9	2024-10-19 05:34:53.773+00	2024-10-19 05:34:53.773+00	59955386-ae4f-4f88-bf42-a4c450b94845
b82e524d-4cd0-42b2-b5ff-f3131715d5ca	good	f	28	9	2024-10-19 05:34:53.779+00	2024-10-19 05:34:53.779+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
df7f9c19-0166-4f18-a867-e85711025e81	cc	f	28	9	2024-10-19 05:35:03.143+00	2024-10-19 05:35:03.143+00	59955386-ae4f-4f88-bf42-a4c450b94845
9ba604a1-c7cf-4178-811d-37d1ea2d9971	cc	f	28	9	2024-10-19 05:35:03.147+00	2024-10-19 05:35:03.147+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
3406f229-1a2c-4d3f-9c0a-d7665b539885	aa	f	28	9	2024-10-19 05:35:17.448+00	2024-10-19 05:35:17.448+00	59955386-ae4f-4f88-bf42-a4c450b94845
9546fe23-454a-4b28-8b64-f2f434d6d3b7	aa	f	28	9	2024-10-19 05:35:17.453+00	2024-10-19 05:35:17.453+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
c6a641f6-1abe-4389-a946-8f3be60d68fc	bvb	f	28	9	2024-10-19 05:35:20.399+00	2024-10-19 05:35:20.399+00	59955386-ae4f-4f88-bf42-a4c450b94845
2bb97573-5123-4026-ba3f-30d035ad2aff	bvb	f	28	9	2024-10-19 05:35:20.403+00	2024-10-19 05:35:20.403+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
f0190330-c33c-4969-89f2-5a0532dba13f	df	f	9	28	2024-10-19 05:35:33.181+00	2024-10-19 05:35:33.181+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
ad244103-679b-4922-9754-ede85059ee2f	df	f	9	28	2024-10-19 05:35:33.185+00	2024-10-19 05:35:33.185+00	59955386-ae4f-4f88-bf42-a4c450b94845
fa10c2c4-6181-4516-9087-4eee6de7887f	dfd	f	9	28	2024-10-19 05:35:38.149+00	2024-10-19 05:35:38.149+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
d8a8300e-960c-47df-a128-aff80f7f6889	dfd	f	9	28	2024-10-19 05:35:38.154+00	2024-10-19 05:35:38.154+00	59955386-ae4f-4f88-bf42-a4c450b94845
c025ed06-675b-4fe9-9e79-9500ee14cebf	cdsc	f	9	28	2024-10-19 05:37:03.406+00	2024-10-19 05:37:03.406+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
53adef9f-cac1-4f12-ab19-4c156a7e4a1e	cdsc	f	9	28	2024-10-19 05:37:03.412+00	2024-10-19 05:37:03.412+00	59955386-ae4f-4f88-bf42-a4c450b94845
aaed4fd4-7fc2-4e26-8812-1d3f10ea8083	ccsd	f	9	28	2024-10-19 05:37:14.086+00	2024-10-19 05:37:14.086+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
bb8d4e07-d29e-4332-ad8b-dcd82e3dece5	ccsd	f	9	28	2024-10-19 05:37:14.091+00	2024-10-19 05:37:14.091+00	59955386-ae4f-4f88-bf42-a4c450b94845
1f4ea602-a7ce-4159-b19f-5a5261a79415	csdcsdcdscdcdwsc	f	9	28	2024-10-19 05:37:18.231+00	2024-10-19 05:37:18.231+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
ed3d1ade-5b28-4e5a-9fe6-be96c9f0ba92	csdcsdcdscdcdwsc	f	9	28	2024-10-19 05:37:18.237+00	2024-10-19 05:37:18.237+00	59955386-ae4f-4f88-bf42-a4c450b94845
91ed6593-d6cd-4478-a8d5-2c33840574c3	csdc	f	9	28	2024-10-19 05:37:27.014+00	2024-10-19 05:37:27.014+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
cd662fb8-fc2e-4819-8e1f-68d700a8b3d8	csdc	f	9	28	2024-10-19 05:37:27.019+00	2024-10-19 05:37:27.019+00	59955386-ae4f-4f88-bf42-a4c450b94845
31b2e0d2-8dd7-4a3a-b1ac-47c99767ee95	dcs	f	28	9	2024-10-19 05:37:39.262+00	2024-10-19 05:37:39.262+00	59955386-ae4f-4f88-bf42-a4c450b94845
d09b3460-099b-4488-8f52-d089a157efd1	dcs	f	28	9	2024-10-19 05:37:39.267+00	2024-10-19 05:37:39.267+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
ee5be48e-1886-4c7b-9336-b8ac66475160	dsa	f	28	9	2024-10-19 05:38:22.039+00	2024-10-19 05:38:22.039+00	59955386-ae4f-4f88-bf42-a4c450b94845
8e1fcdca-b6fa-4a0b-9801-abac93e26cb3	dsa	f	28	9	2024-10-19 05:38:22.044+00	2024-10-19 05:38:22.044+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
fd28f29c-11af-4acc-878c-1f20a024710c	bye	f	9	28	2024-10-19 05:38:33.318+00	2024-10-19 05:38:33.318+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
7dabd9e8-ce12-4f9c-b79e-c61cd99f8614	bye	f	9	28	2024-10-19 05:38:33.323+00	2024-10-19 05:38:33.323+00	59955386-ae4f-4f88-bf42-a4c450b94845
420d0e41-212f-4ec4-abf4-09f8edf59afe	gi	f	9	28	2024-10-19 05:41:57.736+00	2024-10-19 05:41:57.736+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
d83cf50d-289e-4080-96c0-9d0f9e1fb89a	gi	f	9	28	2024-10-19 05:41:57.743+00	2024-10-19 05:41:57.743+00	59955386-ae4f-4f88-bf42-a4c450b94845
286278b2-da26-4489-9b53-99ceb065fbb2	what	f	28	9	2024-10-19 05:42:12.817+00	2024-10-19 05:42:12.817+00	59955386-ae4f-4f88-bf42-a4c450b94845
ed1920dd-1893-4739-8289-f66209cdbddd	what	f	28	9	2024-10-19 05:42:12.822+00	2024-10-19 05:42:12.822+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
37e5a33d-c0c1-4ca2-af86-69d7b79eab42	xsa	f	28	9	2024-10-19 05:48:28.555+00	2024-10-19 05:48:28.555+00	59955386-ae4f-4f88-bf42-a4c450b94845
d75ec00a-1139-49a7-92e6-44ec99826afc	xsa	f	28	9	2024-10-19 05:48:28.564+00	2024-10-19 05:48:28.564+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
af9c5624-c6c9-4a2e-9260-52e38f4bb712	salam	f	18	28	2024-10-19 11:26:13.289+00	2024-10-19 11:26:13.289+00	\N
90b524c8-dde8-42e7-90dd-900430dbb388	salam	f	18	28	2024-10-19 11:26:13.294+00	2024-10-19 11:26:13.294+00	\N
119fd970-fdad-4dce-93b7-421d79a46068	hi	f	18	28	2024-10-19 11:29:44.469+00	2024-10-19 11:29:44.469+00	\N
2c4b5eb0-4d78-486e-880e-0c45865be50c	hi	f	18	28	2024-10-19 11:29:44.475+00	2024-10-19 11:29:44.475+00	\N
06c3de92-fd78-4a7b-a9ff-fd7204ad6ae7	salam men atamyrat	f	18	28	2024-10-19 11:29:56.634+00	2024-10-19 11:29:56.634+00	\N
1e200ab9-f0f8-419f-8d06-68ea7957dd03	salam men atamyrat	f	18	28	2024-10-19 11:29:56.643+00	2024-10-19 11:29:56.643+00	\N
61932e3a-3cc1-4e42-a764-ef0aedb6c143	salam men atamyrat 1 salam men atamyrat 1 salam men atamyrat 1 salam men atamyrat 1	f	18	28	2024-10-19 11:30:23.21+00	2024-10-19 11:30:23.21+00	\N
9c60f213-d9f4-4a52-a706-c50de2f3cefa	salam men atamyrat 1 salam men atamyrat 1 salam men atamyrat 1 salam men atamyrat 1	f	18	28	2024-10-19 11:30:23.223+00	2024-10-19 11:30:23.223+00	\N
17cb8ec7-225b-4c3a-b48b-47855b8ebed1	hi	f	28	18	2024-10-19 11:30:46.338+00	2024-10-19 11:30:46.338+00	f357c224-8ba7-435a-a76b-e4b0b6af7690
fc8ca0fa-2702-46d3-a793-129ab9b4f89d	hi	f	28	18	2024-10-19 11:30:46.343+00	2024-10-19 11:30:46.343+00	e4666499-5919-4912-9557-737e8cb67c7f
f1f18211-1656-47a0-936e-151f53659062	aa	f	9	16	2024-10-19 12:39:04.245+00	2024-10-19 12:39:04.245+00	7a4fdada-b415-47c8-8741-280528e55129
4fa14e98-423f-4b6f-a56d-97e92b5ec9af	aa	f	9	16	2024-10-19 12:39:04.25+00	2024-10-19 12:39:04.25+00	eda2e444-2066-419c-8464-3ebd46ca63ac
1277ec9d-d589-4271-8790-f00e17788042	salam	f	28	18	2024-10-19 13:21:52.023+00	2024-10-19 13:21:52.023+00	f357c224-8ba7-435a-a76b-e4b0b6af7690
fab9cfde-2982-43b2-91f2-b9773179bc00	salam	f	28	18	2024-10-19 13:21:52.028+00	2024-10-19 13:21:52.028+00	e4666499-5919-4912-9557-737e8cb67c7f
122b5942-68a9-46ce-a6aa-b6e3b87e533f	gbhfdgdf	f	18	24	2024-10-19 13:40:45.239+00	2024-10-19 13:40:45.239+00	01f6b688-61f7-4cd6-a191-da2dddfe4d0d
4cc4893e-a480-4049-ade1-a6e8fd4f726b	gbhfdgdf	f	18	24	2024-10-19 13:40:45.244+00	2024-10-19 13:40:45.244+00	a10e7f0e-58cc-49cc-9c30-30a1df4a645c
993ce442-44ad-4677-81ab-a7db9b4a777a	vfdfv	f	18	24	2024-10-19 13:40:47.239+00	2024-10-19 13:40:47.239+00	01f6b688-61f7-4cd6-a191-da2dddfe4d0d
d086001b-0b81-48f6-9dd0-a27e6642baf2	vfdfv	f	18	24	2024-10-19 13:40:47.243+00	2024-10-19 13:40:47.243+00	a10e7f0e-58cc-49cc-9c30-30a1df4a645c
79ce4b1c-2f7b-4665-8892-ca90418789bd	fdbvbx	f	18	24	2024-10-19 13:41:01.023+00	2024-10-19 13:41:01.023+00	01f6b688-61f7-4cd6-a191-da2dddfe4d0d
05fb707b-5a8f-4c38-9e1f-610011dea9cd	fdbvbx	f	18	24	2024-10-19 13:41:01.033+00	2024-10-19 13:41:01.033+00	a10e7f0e-58cc-49cc-9c30-30a1df4a645c
f5866ea4-9d08-4158-8a8a-e3486b5b0193	salam	f	9	18	2024-10-19 13:44:11.616+00	2024-10-19 13:44:11.616+00	24397af7-9575-44ab-99ff-1909adc65181
da07f063-cd8f-45c0-98fd-150e8d5febd0	salam	f	9	18	2024-10-19 13:44:11.62+00	2024-10-19 13:44:11.62+00	840fecce-1cef-403b-ab6f-21d94ba1f614
43fceda7-5587-48d3-b2db-0bda58f51e5e	salam	f	18	9	2024-10-19 13:55:04.672+00	2024-10-19 13:55:04.672+00	840fecce-1cef-403b-ab6f-21d94ba1f614
73264143-a8a0-4683-8b5c-db86bf99635f	salam	f	18	9	2024-10-19 13:55:04.676+00	2024-10-19 13:55:04.676+00	24397af7-9575-44ab-99ff-1909adc65181
f2f78b48-3c53-477c-8c24-045804e8fb50	aa	f	9	28	2024-10-19 14:04:30.401+00	2024-10-19 14:04:30.401+00	e6b99092-f4bc-4154-b9bb-e11201d59fe1
5f533489-d125-4eaf-b7f3-64e6b677dfb8	aa	f	9	28	2024-10-19 14:04:30.412+00	2024-10-19 14:04:30.412+00	59955386-ae4f-4f88-bf42-a4c450b94845
6d29d6b6-fd0f-4047-aad6-bdf57e1a1dac	hi	f	9	18	2024-10-19 14:09:21.481+00	2024-10-19 14:09:21.481+00	24397af7-9575-44ab-99ff-1909adc65181
ea076ecf-1ba9-4175-abd2-db979bac04cd	hi	f	9	18	2024-10-19 14:09:21.485+00	2024-10-19 14:09:21.485+00	840fecce-1cef-403b-ab6f-21d94ba1f614
2ff255d6-1300-439f-8e67-d70d292ccf75	hello	f	18	9	2024-10-19 14:09:46.409+00	2024-10-19 14:09:46.409+00	840fecce-1cef-403b-ab6f-21d94ba1f614
ff2de2f2-88dd-44e0-8be0-b3ae241dd59f	hello	f	18	9	2024-10-19 14:09:46.413+00	2024-10-19 14:09:46.413+00	24397af7-9575-44ab-99ff-1909adc65181
589fec09-e9b5-43de-b944-24fde9b358f0	hi	f	18	9	2024-10-19 14:09:56.665+00	2024-10-19 14:09:56.665+00	840fecce-1cef-403b-ab6f-21d94ba1f614
90850c82-4dd1-4897-87e0-f7145fd020a5	hi	f	18	9	2024-10-19 14:09:56.669+00	2024-10-19 14:09:56.669+00	24397af7-9575-44ab-99ff-1909adc65181
cc455c4c-44c0-4914-bcac-9ea22a55d990	isma	f	28	18	2024-10-21 04:38:00.275+00	2024-10-21 04:38:00.275+00	f357c224-8ba7-435a-a76b-e4b0b6af7690
85825855-2cb0-44c5-89bd-381fe1211373	isma	f	28	18	2024-10-21 04:38:00.284+00	2024-10-21 04:38:00.284+00	e4666499-5919-4912-9557-737e8cb67c7f
384207fb-6f80-45d1-817a-dcb4ae4aaca7	cncj	f	28	18	2024-10-21 04:38:02.6+00	2024-10-21 04:38:02.6+00	f357c224-8ba7-435a-a76b-e4b0b6af7690
29441498-7b2a-4b4a-90e2-c9de14c6160c	cncj	f	28	18	2024-10-21 04:38:02.604+00	2024-10-21 04:38:02.604+00	e4666499-5919-4912-9557-737e8cb67c7f
92fd2821-dc46-4514-8bd4-a5e84e45ac6b	ffrfrgdgtd	f	18	29	2024-10-21 04:39:06.895+00	2024-10-21 04:39:06.895+00	010e465e-eac7-4507-a221-d769ed168818
fc53eded-12c0-4d55-b5be-827348f0f47b	ffrfrgdgtd	f	18	29	2024-10-21 04:39:06.899+00	2024-10-21 04:39:06.899+00	e68176e5-16ef-4d6f-8a84-e1f706aea1c0
be986bd3-097d-4525-95d5-fe80cec0e157	👍👍	f	9	18	2024-10-21 05:12:27.751+00	2024-10-21 05:12:27.751+00	24397af7-9575-44ab-99ff-1909adc65181
6754049d-9bbb-41cc-b50f-b847305c2fb4	👍👍	f	9	18	2024-10-21 05:12:27.761+00	2024-10-21 05:12:27.761+00	840fecce-1cef-403b-ab6f-21d94ba1f614
8f52f678-d3b7-4765-906b-98f99b5c147c	hello	f	18	16	2024-10-22 04:21:07.748+00	2024-10-22 04:21:07.748+00	06a5c33c-30c3-4031-b73b-5d6526aad35b
8c66ad4e-0989-4d1a-9636-cf3575305eea	hello	f	18	16	2024-10-22 04:21:07.752+00	2024-10-22 04:21:07.752+00	526f1d0a-72eb-4c18-98c0-12710dba9f23
7351fea0-abae-4b73-a668-be31b48ade28	priver	f	18	28	2024-10-22 13:07:24.018+00	2024-10-22 13:07:24.018+00	e4666499-5919-4912-9557-737e8cb67c7f
e4949717-73fd-450e-b113-780dcc3b8c3a	priver	f	18	28	2024-10-22 13:07:24.029+00	2024-10-22 13:07:24.029+00	f357c224-8ba7-435a-a76b-e4b0b6af7690
23700116-4244-4c41-80bc-50fcc82863b1	privet	f	29	18	2024-10-22 13:34:49.001+00	2024-10-22 13:34:49.001+00	e68176e5-16ef-4d6f-8a84-e1f706aea1c0
7cd6af17-b1fe-4cdd-aec8-f2bf3b969195	privet	f	29	18	2024-10-22 13:34:49.008+00	2024-10-22 13:34:49.008+00	010e465e-eac7-4507-a221-d769ed168818
4f6ecf6a-e787-44c0-9797-0225cde1f216	Salam	f	9	19	2024-10-22 14:21:06.387+00	2024-10-22 14:21:06.387+00	02c06f28-c96f-44ea-8520-4dba052b9b55
8ff3ab3c-8435-44fa-9ed3-f088ff223e0f	Salam	f	9	19	2024-10-22 14:21:06.393+00	2024-10-22 14:21:06.393+00	92475336-f85c-4b75-8a60-8da3abf6bb79
ac724eaf-7ca2-4e34-88c4-173ba193cfe9	hi	f	28	18	2024-10-24 14:59:15.092+00	2024-10-24 14:59:15.092+00	f357c224-8ba7-435a-a76b-e4b0b6af7690
c5f34a38-8bbb-47a7-b2e8-a037f0a62060	hi	f	28	18	2024-10-24 14:59:15.098+00	2024-10-24 14:59:15.098+00	e4666499-5919-4912-9557-737e8cb67c7f
d5d31f5a-88b2-482c-b712-8ce85f47ed2c	sss	f	17	16	2024-10-25 04:24:34.799+00	2024-10-25 04:24:34.799+00	6fd2dea6-c71b-4084-b9c1-a27cdb6a9b13
d43c2223-054d-4b5e-87ca-085b6f8175f5	sss	f	17	16	2024-10-25 04:24:34.805+00	2024-10-25 04:24:34.805+00	43e90f88-9e46-46f6-ad66-e602b8247f9a
6665f777-840b-4a42-a9bc-140e536a0eb9	ccc	f	9	18	2024-10-25 05:15:23.049+00	2024-10-25 05:15:23.049+00	24397af7-9575-44ab-99ff-1909adc65181
ca752270-1cb8-452d-a220-e429eacac78a	ccc	f	9	18	2024-10-25 05:15:23.054+00	2024-10-25 05:15:23.054+00	840fecce-1cef-403b-ab6f-21d94ba1f614
d0a7b758-16ee-4580-914d-12adc0f302ee	hi	f	16	18	2024-10-29 05:12:22.034+00	2024-10-29 05:12:22.034+00	526f1d0a-72eb-4c18-98c0-12710dba9f23
0f7593c6-f06f-47da-8503-ad4150028edd	hi	f	16	18	2024-10-29 05:12:22.042+00	2024-10-29 05:12:22.042+00	06a5c33c-30c3-4031-b73b-5d6526aad35b
d6ea1f2d-80bc-424c-926c-fcaffb65dc5d	Test2	f	29	18	2024-10-29 05:23:04.067+00	2024-10-29 05:23:04.067+00	e68176e5-16ef-4d6f-8a84-e1f706aea1c0
471ecf68-0986-4c19-8c50-372d21056347	Test2	f	29	18	2024-10-29 05:23:04.072+00	2024-10-29 05:23:04.072+00	010e465e-eac7-4507-a221-d769ed168818
ac38541b-0d74-4222-b0d2-db6ba055a910	ээээээууууу	f	5	16	2024-10-29 12:57:41.4+00	2024-10-29 12:57:41.4+00	ead23234-0e53-4e83-8ffc-a52d3526dfa5
8eb2b43c-4d4a-438d-b6f2-128f7245a60e	ээээээууууу	f	5	16	2024-10-29 12:57:41.405+00	2024-10-29 12:57:41.405+00	1800e9fd-f0be-49a2-bdb0-82ae634f3f30
b5100f70-0c4e-4148-87e1-7351cdf3d207	работает?	f	5	16	2024-10-29 12:57:47.681+00	2024-10-29 12:57:47.681+00	ead23234-0e53-4e83-8ffc-a52d3526dfa5
2b661de7-8f9c-468f-bc6a-45c48461eb1a	работает?	f	5	16	2024-10-29 12:57:47.685+00	2024-10-29 12:57:47.685+00	1800e9fd-f0be-49a2-bdb0-82ae634f3f30
e8514d76-fb80-4a25-a249-2e4854eea5e4	.	f	26	16	2024-10-31 12:18:21.129+00	2024-10-31 12:18:21.129+00	9386c6e4-54d0-40f8-a098-f8a3d62381c6
90c66972-7f58-49e9-9e5a-da9a14eef682	.	f	26	16	2024-10-31 12:18:21.141+00	2024-10-31 12:18:21.141+00	4ec3dc05-e2d6-4305-9543-887a4a3bec7d
7b5f54be-d4cc-4de5-9573-13a8632a4d35	.	f	26	16	2024-10-31 12:18:23.529+00	2024-10-31 12:18:23.529+00	9386c6e4-54d0-40f8-a098-f8a3d62381c6
569fb7da-9723-4ea8-b691-8d48ad9422d2	.	f	26	16	2024-10-31 12:18:23.533+00	2024-10-31 12:18:23.533+00	4ec3dc05-e2d6-4305-9543-887a4a3bec7d
0d1fb023-90fd-4da6-915e-7b9c0e3d2aa9	Работает 	f	16	5	2024-11-02 06:53:25.638+00	2024-11-02 06:53:25.638+00	1800e9fd-f0be-49a2-bdb0-82ae634f3f30
3714a66b-703f-4900-86a6-cb21f2c808a0	Работает 	f	16	5	2024-11-02 06:53:25.646+00	2024-11-02 06:53:25.646+00	ead23234-0e53-4e83-8ffc-a52d3526dfa5
68dd9835-2894-4393-97b0-c794f6f624f8	hi\\	f	18	29	2024-11-09 04:47:59.946+00	2024-11-09 04:47:59.946+00	010e465e-eac7-4507-a221-d769ed168818
7c140a06-820d-4e85-a6ca-405a4af8294b	hi\\	f	18	29	2024-11-09 04:47:59.957+00	2024-11-09 04:47:59.957+00	e68176e5-16ef-4d6f-8a84-e1f706aea1c0
80314b55-2e2b-4ee4-9cdd-8f269be97b36	hi	f	18	29	2024-11-09 04:47:59.946+00	2024-11-09 04:47:59.946+00	010e465e-eac7-4507-a221-d769ed168818
09a62310-092e-4c21-9531-023e91a84916	hi	f	18	29	2024-11-09 04:47:59.959+00	2024-11-09 04:47:59.959+00	e68176e5-16ef-4d6f-8a84-e1f706aea1c0
bcc7faff-5273-4342-b213-cf77dcf49157	hello	f	19	18	2024-11-09 11:52:00.959+00	2024-11-09 11:52:00.959+00	b983e5dc-775a-4d67-8cb9-a97c4a57935b
62b67bf9-24c3-4acb-8c24-ee082c31006a	hello	f	19	18	2024-11-09 11:52:00.963+00	2024-11-09 11:52:00.963+00	82b2aba3-106a-437a-af6a-146d8d2c5913
137c217a-02e2-4958-a120-95aa7f20026c	how are you?	f	19	18	2024-11-09 11:52:07.644+00	2024-11-09 11:52:07.644+00	b983e5dc-775a-4d67-8cb9-a97c4a57935b
88fcb872-8d1f-4290-8b35-b33b31570c1d	how are you?	f	19	18	2024-11-09 11:52:07.648+00	2024-11-09 11:52:07.648+00	82b2aba3-106a-437a-af6a-146d8d2c5913
71f993b5-d391-4798-8edf-a998b3ed1c33	Salam	f	26	16	2024-11-18 11:10:17.561+00	2024-11-18 11:10:17.561+00	9386c6e4-54d0-40f8-a098-f8a3d62381c6
038df399-ff9f-4f76-9f69-1cb6897968d3	Salam	f	26	16	2024-11-18 11:10:17.569+00	2024-11-18 11:10:17.569+00	4ec3dc05-e2d6-4305-9543-887a4a3bec7d
aac382ff-e331-401b-9943-c7dcd3b08c67	Gowumy	f	26	16	2024-11-18 11:10:22.129+00	2024-11-18 11:10:22.129+00	9386c6e4-54d0-40f8-a098-f8a3d62381c6
086f9cff-741e-4d46-804c-e3adf2a1269a	Gowumy	f	26	16	2024-11-18 11:10:22.133+00	2024-11-18 11:10:22.133+00	4ec3dc05-e2d6-4305-9543-887a4a3bec7d
62a11af5-29d9-4525-b7cb-58e3af4bd3e6	Onat	f	26	16	2024-11-18 11:10:25.641+00	2024-11-18 11:10:25.641+00	9386c6e4-54d0-40f8-a098-f8a3d62381c6
262eb2a7-0d4f-47cc-9b45-fe520d949674	Onat	f	26	16	2024-11-18 11:10:25.644+00	2024-11-18 11:10:25.644+00	4ec3dc05-e2d6-4305-9543-887a4a3bec7d
ff6f9f19-5376-414d-acc3-af762cd5bce2	salam	f	19	9	2024-11-19 15:11:22.715+00	2024-11-19 15:11:22.715+00	92475336-f85c-4b75-8a60-8da3abf6bb79
9bc53775-3ab9-44f1-bebf-77380081c1cc	salam	f	19	9	2024-11-19 15:11:22.721+00	2024-11-19 15:11:22.721+00	02c06f28-c96f-44ea-8520-4dba052b9b55
c28e2c6e-e123-402b-8163-0c4f669e938a	bn	f	9	18	2024-11-20 05:13:08.643+00	2024-11-20 05:13:08.643+00	24397af7-9575-44ab-99ff-1909adc65181
0d0cf724-d0c2-4731-953d-99a4cd9d67d4	bn	f	9	18	2024-11-20 05:13:08.647+00	2024-11-20 05:13:08.647+00	840fecce-1cef-403b-ab6f-21d94ba1f614
378453a3-7606-42f4-b568-7230e1354430	user@ubuntuserver:/etc/nginx/sites-available$ ls default  mysite.conf  mysite.conf.save  personnelrecordsy	f	16	18	2024-11-25 12:56:36.421+00	2024-11-25 12:56:36.421+00	526f1d0a-72eb-4c18-98c0-12710dba9f23
f4292af5-1da6-4f77-b6e0-5d51d4e0d57f	user@ubuntuserver:/etc/nginx/sites-available$ ls default  mysite.conf  mysite.conf.save  personnelrecordsy	f	16	18	2024-11-25 12:56:36.429+00	2024-11-25 12:56:36.429+00	06a5c33c-30c3-4031-b73b-5d6526aad35b
588d0085-b9dd-4c15-b978-7b179abdc300	Isma	f	18	16	2024-11-26 14:35:37.132+00	2024-11-26 14:35:37.132+00	06a5c33c-30c3-4031-b73b-5d6526aad35b
b2515f30-2397-45f9-bff5-a4edf0b81fe3	Isma	f	18	16	2024-11-26 14:35:37.141+00	2024-11-26 14:35:37.141+00	526f1d0a-72eb-4c18-98c0-12710dba9f23
cf5c7995-2ea5-43e6-9c52-2050deac24f4	Adjara gutjuu	f	29	18	2024-12-05 08:36:22.83+00	2024-12-05 08:36:22.83+00	e68176e5-16ef-4d6f-8a84-e1f706aea1c0
f55ade9a-4b6d-4193-b5d2-34b77d887354	Adjara gutjuu	f	29	18	2024-12-05 08:36:22.839+00	2024-12-05 08:36:22.839+00	010e465e-eac7-4507-a221-d769ed168818
25b106a5-5aa9-4301-b317-42dfd1ac3dc5	👁‍🗨 Big Brother see all	f	18	29	2024-12-05 08:37:26.603+00	2024-12-05 08:37:26.603+00	010e465e-eac7-4507-a221-d769ed168818
315eec8d-4fbb-4f93-b716-ea8617e17fc6	👁‍🗨 Big Brother see all	f	18	29	2024-12-05 08:37:26.613+00	2024-12-05 08:37:26.613+00	e68176e5-16ef-4d6f-8a84-e1f706aea1c0
9f10f6bc-a33f-48b5-82ac-50c0966363fa	tocno	f	9	16	2024-12-06 14:25:32.28+00	2024-12-06 14:25:32.28+00	7a4fdada-b415-47c8-8741-280528e55129
42c50e14-7461-4889-8a61-3eff59a42882	tocno	f	9	16	2024-12-06 14:25:32.285+00	2024-12-06 14:25:32.285+00	eda2e444-2066-419c-8464-3ebd46ca63ac
317b1180-85b9-44ac-b020-3993efbf8f5b	sccsasc	f	29	18	2024-12-07 10:12:56.659+00	2024-12-07 10:12:56.659+00	e68176e5-16ef-4d6f-8a84-e1f706aea1c0
587d0bab-436f-4a61-b7b1-1ae25371247e	sccsasc	f	29	18	2024-12-07 10:12:56.664+00	2024-12-07 10:12:56.664+00	010e465e-eac7-4507-a221-d769ed168818
063e71be-06dd-430b-8b5e-c424c97a87a7	*2121/3	f	26	9	2024-12-09 13:27:10.172+00	2024-12-09 13:27:10.172+00	\N
49db64fe-6efd-4716-b153-9bc1cf0a8f44	*2121/3	f	26	9	2024-12-09 13:27:10.182+00	2024-12-09 13:27:10.182+00	\N
cb33fcd1-2fb6-4262-b7c1-8b97e1d5dc27	hninjon	f	64	28	2024-12-09 13:27:54.37+00	2024-12-09 13:27:54.37+00	574bfcc6-95cc-470b-8ca2-ba09975da04f
a31dd6e3-57f1-47c1-b0c8-2c362d217597	hninjon	f	64	28	2024-12-09 13:27:54.376+00	2024-12-09 13:27:54.376+00	1da2dfb2-2fdd-4be3-90fe-4622e6b9daf0
433adad8-80aa-4906-b9b6-8452e7984b2c	<div style="top:0; position:absolute;">Salam</div>	f	26	9	2024-12-09 13:28:05.528+00	2024-12-09 13:28:05.528+00	\N
2b6995b5-19b8-4821-ba3b-6bf5fa4a0acf	<div style="top:0; position:absolute;">Salam</div>	f	26	9	2024-12-09 13:28:05.532+00	2024-12-09 13:28:05.532+00	\N
389d73fb-bf26-4cd6-a34d-365b339acd67	<div style="top:0; position:absolute; background:red;">Salam</div>	f	26	9	2024-12-09 13:28:32.454+00	2024-12-09 13:28:32.454+00	\N
46e419c5-27b2-4321-934e-ed0644c842e8	<div style="top:0; position:absolute; background:red;">Salam</div>	f	26	9	2024-12-09 13:28:32.462+00	2024-12-09 13:28:32.462+00	\N
56ef0afb-33d1-462e-af94-527ceafe3843	"; SELECt * FROM users;	f	26	9	2024-12-09 13:28:58.361+00	2024-12-09 13:28:58.361+00	\N
d3dedcb2-6c75-4685-bdfc-e5037aa2a33a	"; SELECt * FROM users;	f	26	9	2024-12-09 13:28:58.371+00	2024-12-09 13:28:58.371+00	\N
538cbf0c-cdf2-4bbc-9918-b540696946d8	<div style="top:0; position:absolute;">Salam</div>	f	26	9	2024-12-09 13:29:24.935+00	2024-12-09 13:29:24.935+00	094e9b25-e624-45f5-9091-a4e61a04cc12
f2ae2501-6e4f-492f-8d55-8cf80d816c74	<div style="top:0; position:absolute;">Salam</div>	f	26	9	2024-12-09 13:29:24.944+00	2024-12-09 13:29:24.944+00	64e6f1bc-b4cf-4966-a64a-65699d9ca05e
b2fd610e-b2ae-4f51-bbde-cbb79e711c31	"'`; SELECT * FROM users;	f	26	9	2024-12-09 13:30:06.696+00	2024-12-09 13:30:06.696+00	094e9b25-e624-45f5-9091-a4e61a04cc12
0cbaf92a-5376-49d9-a482-cce62e1d0c2e	"'`; SELECT * FROM users;	f	26	9	2024-12-09 13:30:06.705+00	2024-12-09 13:30:06.705+00	64e6f1bc-b4cf-4966-a64a-65699d9ca05e
98e9ebfa-f682-4fce-a25d-eafa0b371fa9	"'`; SELECT * FROM permissions;	f	26	9	2024-12-09 13:30:23.151+00	2024-12-09 13:30:23.151+00	094e9b25-e624-45f5-9091-a4e61a04cc12
a997a1d1-53f9-4b1c-aea2-83ff641e56bf	"'`; SELECT * FROM permissions;	f	26	9	2024-12-09 13:30:23.156+00	2024-12-09 13:30:23.156+00	64e6f1bc-b4cf-4966-a64a-65699d9ca05e
0d7096b7-f7c6-4a3b-95a5-3bcb36435d42	\\"\\'\\`\\; SELECT * FROM permissions;	f	26	9	2024-12-09 13:30:48.606+00	2024-12-09 13:30:48.606+00	094e9b25-e624-45f5-9091-a4e61a04cc12
5e93e670-1f5d-4345-93c0-eafc5431a34f	\\"\\'\\`\\; SELECT * FROM permissions;	f	26	9	2024-12-09 13:30:48.616+00	2024-12-09 13:30:48.616+00	64e6f1bc-b4cf-4966-a64a-65699d9ca05e
6bab14c3-0ae4-4853-a5c1-912d8ae9b3e3	    Lorem ipsum dolor, sit amet consectetur adipisicing elit. Dolore sequi esse quas possimus itaque praesentium culpa tempora distinctio dolores incidunt libero cumque, inventore quasi quibusdam quidem, qui sunt fugit non.	f	26	9	2024-12-09 13:31:33.285+00	2024-12-09 13:31:33.285+00	094e9b25-e624-45f5-9091-a4e61a04cc12
56de8b7e-f25e-4cc2-ad26-cc6dcc3888e9	    Lorem ipsum dolor, sit amet consectetur adipisicing elit. Dolore sequi esse quas possimus itaque praesentium culpa tempora distinctio dolores incidunt libero cumque, inventore quasi quibusdam quidem, qui sunt fugit non.	f	26	9	2024-12-09 13:31:33.289+00	2024-12-09 13:31:33.289+00	64e6f1bc-b4cf-4966-a64a-65699d9ca05e
93d25bc2-866b-4e14-a49e-902414d9599b	    Lorem ipsum dolor, sit amet consectetur adipisicing elit. Dolore sequi esse quas possimus itaque praesentium culpa tempora distinctio dolores incidunt libero cumque, inventore quasi quibusdam quidem, qui sunt fugit non.	f	26	9	2024-12-09 13:31:55.294+00	2024-12-09 13:31:55.294+00	094e9b25-e624-45f5-9091-a4e61a04cc12
3eb31d46-c341-4608-be11-153680444dc8	    Lorem ipsum dolor, sit amet consectetur adipisicing elit. Dolore sequi esse quas possimus itaque praesentium culpa tempora distinctio dolores incidunt libero cumque, inventore quasi quibusdam quidem, qui sunt fugit non.	f	26	9	2024-12-09 13:31:55.299+00	2024-12-09 13:31:55.299+00	64e6f1bc-b4cf-4966-a64a-65699d9ca05e
e7352612-0c40-45ed-ba67-34f810c84c0a	    Lorem ipsum dolor, sit amet consectetur adipisicing elit. Dolore sequi esse quas possimus itaque praesentium culpa tempora distinctio dolores incidunt libero cumque, inventore quasi quibusdam quidem, qui sunt fugit non.	f	26	9	2024-12-09 13:32:08.021+00	2024-12-09 13:32:08.021+00	094e9b25-e624-45f5-9091-a4e61a04cc12
b69f98fc-c9be-44dd-91f4-1208e9107142	    Lorem ipsum dolor, sit amet consectetur adipisicing elit. Dolore sequi esse quas possimus itaque praesentium culpa tempora distinctio dolores incidunt libero cumque, inventore quasi quibusdam quidem, qui sunt fugit non.	f	26	9	2024-12-09 13:32:08.03+00	2024-12-09 13:32:08.03+00	64e6f1bc-b4cf-4966-a64a-65699d9ca05e
e531a0c2-1364-47fb-872f-e1d2211dbd91	    Lorem ipsum dolor, sit amet consectetur adipisicing elit. Dolore sequi esse quas possimus itaque praesentium culpa tempora distinctio dolores incidunt libero cumque, inventore quasi quibusdam quidem, qui sunt fugit non.	f	26	9	2024-12-09 13:33:33.029+00	2024-12-09 13:33:33.029+00	094e9b25-e624-45f5-9091-a4e61a04cc12
18c9d5cb-a8bb-4e7a-afac-b506eed277d5	    Lorem ipsum dolor, sit amet consectetur adipisicing elit. Dolore sequi esse quas possimus itaque praesentium culpa tempora distinctio dolores incidunt libero cumque, inventore quasi quibusdam quidem, qui sunt fugit non.	f	26	9	2024-12-09 13:33:33.038+00	2024-12-09 13:33:33.038+00	64e6f1bc-b4cf-4966-a64a-65699d9ca05e
10b8ab60-0038-4dbb-bcf8-98c6218af85b	hello word	f	9	16	2024-12-14 05:29:15.907+00	2024-12-14 05:29:15.907+00	7a4fdada-b415-47c8-8741-280528e55129
f63ddaac-3f5c-45ef-996d-8d8bbd94d69f	hello word	f	9	16	2024-12-14 05:29:15.911+00	2024-12-14 05:29:15.911+00	eda2e444-2066-419c-8464-3ebd46ca63ac
b314c133-7dfd-4ca3-a8fa-07ff46e679d2	Halil geldinmi agam	f	16	66	2024-12-14 05:29:46.992+00	2024-12-14 05:29:46.992+00	3cbc2c04-94b7-4702-96cd-ac2fce3cc397
d0ba881d-df04-481b-b4be-43a645aa5a14	Halil geldinmi agam	f	16	66	2024-12-14 05:29:46.998+00	2024-12-14 05:29:46.998+00	8ec5c5f0-0c92-49f0-9b70-da9898ef7dc8
fa57c754-37d3-4837-a58a-c238a261181c	gfhgfgh	f	16	18	2025-01-09 10:13:00.812+00	2025-01-09 10:13:00.812+00	526f1d0a-72eb-4c18-98c0-12710dba9f23
ead65810-dc89-45dd-97f0-917ebf520689	gfhgfgh	f	16	18	2025-01-09 10:13:00.821+00	2025-01-09 10:13:00.821+00	06a5c33c-30c3-4031-b73b-5d6526aad35b
5959b0ea-7412-4c41-b8ae-251a0248130d	"'`; SELECT * FROM permissions;	f	9	26	2025-01-28 03:32:54.297+00	2025-01-28 03:32:54.297+00	64e6f1bc-b4cf-4966-a64a-65699d9ca05e
6ad85927-1172-493d-a20e-f487e6dfee77	"'`; SELECT * FROM permissions;	f	9	26	2025-01-28 03:32:54.314+00	2025-01-28 03:32:54.314+00	094e9b25-e624-45f5-9091-a4e61a04cc12
1ec1b2ed-f7ee-4c23-82ce-da9fa346ad27	😂	f	9	26	2025-01-28 03:33:05.979+00	2025-01-28 03:33:05.979+00	64e6f1bc-b4cf-4966-a64a-65699d9ca05e
417ea814-438b-4b5b-b0d1-d2f451b91b76	😂	f	9	26	2025-01-28 03:33:05.989+00	2025-01-28 03:33:05.989+00	094e9b25-e624-45f5-9091-a4e61a04cc12
abd7dd4b-bd85-4942-820e-49660f745148	wsdefgfdxsz	f	9	24	2025-01-29 14:43:17.584+00	2025-01-29 14:43:17.584+00	cf3e9840-dd0a-4c13-b416-6a0e1b5faf87
aeea898a-74b1-4d46-b7c1-6d9fbf32fc5b	wsdefgfdxsz	f	9	24	2025-01-29 14:43:17.591+00	2025-01-29 14:43:17.591+00	91eef835-ed65-49bd-abac-42f310875287
\.


--
-- Data for Name: notes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notes (id, "userId", "authorType", "authorId", content, "projectId", "createdAt", "updatedAt") FROM stdin;
dcbfd3a5-ceb6-4d5b-9f8a-d14c7f8b653f	9	ADMIN	9	aaa	Kassa we ammar ucin girish sahypa dizayn	2024-12-13 13:02:54.027+00	2024-12-13 13:02:54.027+00
45ab6389-4f63-446f-a1ce-f1ab7a605da7	9	ADMIN	9	test	\N	2024-11-07 15:20:27.004+00	2024-11-07 15:20:27.004+00
9be4a2a5-5ea2-416a-8df3-72cdc87d1bae	9	ADMIN	9	csdcdc	Alem CRM	2024-11-07 15:22:56.951+00	2024-11-07 15:22:56.951+00
\.


--
-- Data for Name: pdfDocuments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."pdfDocuments" (id, title, "pathPdf", deleted, "userId", "documentTypeId", "createdAt", "updatedAt") FROM stdin;
3	Zagran	1732257258549Dasharyurt_Pasport_Kopiya.pdf	f	20	408f4f57-75f2-481f-ab1c-c58410b33b11	2024-11-22 06:34:18.617+00	2024-11-22 06:34:18.617+00
13	Pasport Kopiýa	1732257637042Pasport_Kopiya.pdf	f	5	0b368ac2-e7a4-41e4-b749-26099c8c610e	2024-11-22 06:40:37.087+00	2024-11-22 06:40:37.087+00
72	Pasport	1737455022702Pasport.PDF	f	70	0b368ac2-e7a4-41e4-b749-26099c8c610e	2025-01-21 10:23:42.884+00	2025-01-21 10:23:42.884+00
73	Diplom	1737455086001Japarow GuwanÃ§ Diplom reÅkli.PDF	f	70	545403b3-8703-465d-a47c-c164c4fbcf6e	2025-01-21 10:24:46.055+00	2025-01-21 10:24:46.055+00
74	Zähmet depderçe	1737455108848Japarow G.ZÃ¤hmet depderÃ§esi.PDF	f	70	17e6fed6-a4bc-4d1d-98f1-d014fedb99f9	2025-01-21 10:25:08.94+00	2025-01-21 10:25:08.94+00
6	Pasport Kopiya	1732257369382Pasport_Kopiya.pdf	f	18	0b368ac2-e7a4-41e4-b749-26099c8c610e	2024-11-22 06:36:09.446+00	2024-11-23 05:44:14.359+00
20	edit	1732287445254KabinetlaryÅ ady mbke (1).xlsx	t	18	17e6fed6-a4bc-4d1d-98f1-d014fedb99f9	2024-11-22 14:57:25.332+00	2024-11-23 05:44:28.354+00
21	Kabinetlaryň ady mbke (1).xlsx	1732290736026KabinetlaryÅ ady mbke (1).xlsx	t	9	fc4095f1-a573-490a-83f6-ca03c7b85fb8	2024-11-22 15:52:16.042+00	2024-11-23 04:31:37.653+00
1	Pasport	1732257186302Pasport_Kopiya.pdf	f	26	0b368ac2-e7a4-41e4-b749-26099c8c610e	2024-11-22 06:33:06.381+00	2024-11-23 04:44:24.129+00
2	Bellige_Alysh_Shahadatnama	1732257242011Bellige_Alysh_Shahadatnama.pdf	f	20	17e6fed6-a4bc-4d1d-98f1-d014fedb99f9	2024-11-22 06:34:02.025+00	2024-11-23 04:44:41.664+00
4	Pasport Kopiya	1732257293274Pasport_Kopiya.pdf	f	20	0b368ac2-e7a4-41e4-b749-26099c8c610e	2024-11-22 06:34:53.35+00	2024-11-23 04:45:39.516+00
5	Rezume	1732257344948Rezume.pdf	f	20	17e6fed6-a4bc-4d1d-98f1-d014fedb99f9	2024-11-22 06:35:44.966+00	2024-11-23 04:45:52.189+00
7	 Pasport Kopiya	1732257427776Pasport_Kopiya.pdf	f	14	0b368ac2-e7a4-41e4-b749-26099c8c610e	2024-11-22 06:37:07.871+00	2024-11-23 04:46:26.17+00
8	 Pasport Kopiya	1732257454720Pasport_Kopiya.pdf	f	19	0b368ac2-e7a4-41e4-b749-26099c8c610e	2024-11-22 06:37:34.747+00	2024-11-23 04:46:36.387+00
9	 Pasport Kopiya	1732257474071Pasport_Kopiya.pdf	f	10	0b368ac2-e7a4-41e4-b749-26099c8c610e	2024-11-22 06:37:54.149+00	2024-11-23 04:46:44.102+00
10	Sertifikat	1732257507793Delivering_Quality_Work_with_Agility.pdf	f	10	804e69e1-3640-4404-b33a-571fa015cc29	2024-11-22 06:38:27.853+00	2024-11-23 04:46:50.481+00
11	Daşary ýurt diplom	1732257562286AtayewIsmayyl_Diplom.pdf	f	16	545403b3-8703-465d-a47c-c164c4fbcf6e	2024-11-22 06:39:22.552+00	2024-11-23 04:46:57.318+00
12	Diplom Tassyklama	1732257597572Atayew_Ismayyl_Diplaom_Tassyklama.pdf	f	16	545403b3-8703-465d-a47c-c164c4fbcf6e	2024-11-22 06:39:57.69+00	2024-11-23 04:47:01.063+00
14	Bellige_Alyş_ Şahadatnama	1732257700072Bellige_Alysh_ Shahadatnama.pdf	f	17	17e6fed6-a4bc-4d1d-98f1-d014fedb99f9	2024-11-22 06:41:40.085+00	2024-11-23 04:47:08.853+00
15	Bilim Şahadatnamasy	1732257733105Bilim_Shahadatnamasy.pdf	f	17	545403b3-8703-465d-a47c-c164c4fbcf6e	2024-11-22 06:42:13.135+00	2024-11-23 04:47:17.317+00
16	Pasport Kopiýa	1732257789468Pasport_Kopiya.pdf	f	17	0b368ac2-e7a4-41e4-b749-26099c8c610e	2024-11-22 06:43:09.537+00	2024-11-23 04:47:23.406+00
17	Zahmet Depderçesi	1732257824619Zahmet_Depderchesi.pdf	f	17	17e6fed6-a4bc-4d1d-98f1-d014fedb99f9	2024-11-22 06:43:44.875+00	2024-11-23 04:47:28.336+00
29	Pasport	1732709837563Pasport kopiÃ½a Dermanowa A.PDF	f	15	0b368ac2-e7a4-41e4-b749-26099c8c610e	2024-11-27 12:17:17.639+00	2024-11-27 12:17:17.639+00
30	Diplom	1732709893917Diplom kopiÃ½a Dermanowa A.PDF	f	15	545403b3-8703-465d-a47c-c164c4fbcf6e	2024-11-27 12:18:13.972+00	2024-11-27 12:18:13.972+00
28	Kabinetlaryň ady mbke (1).xlsx	1732709658118KabinetlaryÅ ady mbke (1).xlsx	t	10	17e6fed6-a4bc-4d1d-98f1-d014fedb99f9	2024-11-27 12:14:18.137+00	2024-11-27 13:48:40.025+00
32	Kabinetlaryň ady mbvdsvdsvsvsvvke (1).xlsx	1732715332576KabinetlaryÅ ady mbke (1).xlsx	t	10	17e6fed6-a4bc-4d1d-98f1-d014fedb99f9	2024-11-27 13:48:52.589+00	2024-11-27 13:48:59.518+00
33	ser (1).xlsx	1732715494736KabinetlaryÅ ady mbke (1).xlsx	t	10	17e6fed6-a4bc-4d1d-98f1-d014fedb99f9	2024-11-27 13:51:34.75+00	2024-11-27 13:58:54.559+00
31	Kabinetlaryň ady mbke (1).xlsx	1732714169101KabinetlaryÅ ady mbke (1).xlsx	t	10	17e6fed6-a4bc-4d1d-98f1-d014fedb99f9	2024-11-27 13:29:29.32+00	2024-11-27 13:58:55.441+00
53	Agamyradow Şatlyk pasport.PDF	1733750622128Agamyradow Åatlyk pasport.PDF	f	63	0b368ac2-e7a4-41e4-b749-26099c8c610e	2024-12-09 13:23:42.191+00	2024-12-09 13:23:42.191+00
54	Resulgeldi pasporty (1).pdf	1733750762443Resulgeldi pasporty (1).pdf	f	64	0b368ac2-e7a4-41e4-b749-26099c8c610e	2024-12-09 13:26:02.736+00	2024-12-09 13:26:02.736+00
56	Passport.pdf	1733802005231Passport.pdf	f	66	0b368ac2-e7a4-41e4-b749-26099c8c610e	2024-12-10 03:40:05.33+00	2024-12-10 03:40:05.33+00
59	Diplom.pdf	1734091257053Diplom.pdf	f	66	545403b3-8703-465d-a47c-c164c4fbcf6e	2024-12-13 12:00:57.108+00	2024-12-13 12:00:57.108+00
60	Diplom Lissey.pdf	1734091288797Diplom Lissey.pdf	f	66	17e6fed6-a4bc-4d1d-98f1-d014fedb99f9	2024-12-13 12:01:28.835+00	2024-12-13 12:01:28.835+00
61	Atetsat.pdf	1734091307093Atetsat.pdf	f	66	17e6fed6-a4bc-4d1d-98f1-d014fedb99f9	2024-12-13 12:01:47.267+00	2024-12-13 12:01:47.267+00
62	Rahman.pdf	1736157602266Rahman.pdf	f	69	0b368ac2-e7a4-41e4-b749-26099c8c610e	2025-01-06 10:00:02.7+00	2025-01-06 10:00:02.7+00
63	Zähmet depderçe	1737453531344AtaÃ½ew I. ZÃ¤hmet depderÃ§e.PDF	f	16	17e6fed6-a4bc-4d1d-98f1-d014fedb99f9	2025-01-21 09:58:51.368+00	2025-01-21 09:58:51.368+00
64	Pasport	1737453846799ÅÃ¼kÃ¼row pasport.pdf	f	24	0b368ac2-e7a4-41e4-b749-26099c8c610e	2025-01-21 10:00:23.254+00	2025-01-21 10:04:06.869+00
65	Zähmet depderçe	1737453968923ÅÃ¼kurow A..ZÃ¤hmet depderÃ§e.PDF	f	24	17e6fed6-a4bc-4d1d-98f1-d014fedb99f9	2025-01-21 10:06:08.952+00	2025-01-21 10:06:08.952+00
66	Pasport	1737454048054AtaÃ½ew IsmaÃ½yl Pasport kopiÃ½a.PDF	f	16	0b368ac2-e7a4-41e4-b749-26099c8c610e	2025-01-21 10:07:28.177+00	2025-01-21 10:07:28.177+00
67	Zähmet depderçe	1737454102768Begmyradow A..ZÃ¤hmet depderÃ§esi.PDF	f	20	17e6fed6-a4bc-4d1d-98f1-d014fedb99f9	2025-01-21 10:08:22.798+00	2025-01-21 10:08:22.798+00
68	Zähmet depderçe	1737454337628Dermanowa A ..ZÃ¤hmet depderÃ§e.PDF	f	15	17e6fed6-a4bc-4d1d-98f1-d014fedb99f9	2025-01-21 10:12:17.657+00	2025-01-21 10:12:17.657+00
69	Zähmet depderçe	1737454375210EgemberdiÃ½ew E ..ZÃ¤hmet depderÃ§e.PDF	f	19	17e6fed6-a4bc-4d1d-98f1-d014fedb99f9	2025-01-21 10:12:55.301+00	2025-01-21 10:12:55.301+00
70	Zähmet depderçe	1737454410839Gurbanowa G ..ZÃ¤hmet depderÃ§e.PDF	f	10	17e6fed6-a4bc-4d1d-98f1-d014fedb99f9	2025-01-21 10:13:30.891+00	2025-01-21 10:13:30.891+00
71	Zähmet depderçe	1737454520780Agamuradow Å..ZÃ¤hmet depderÃ§esi.PDF	f	63	17e6fed6-a4bc-4d1d-98f1-d014fedb99f9	2025-01-21 10:15:20.806+00	2025-01-21 10:15:20.806+00
\.


--
-- Data for Name: positions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.positions (id, name, "createdAt", "updatedAt") FROM stdin;
16e15ee8-95be-4837-a9b0-3c42e37938c1	Designer	2024-09-25 10:53:51.996+00	2024-09-25 10:53:51.996+00
9eb3d10c-083a-4af8-bc2a-0d5e8fa7c147	Programmist	2024-09-25 12:14:40.094+00	2024-09-25 12:14:40.094+00
9156e956-2baf-4191-9d4f-22a128efe3df	Buhgalter	2024-10-23 04:27:29.118+00	2024-10-23 04:27:29.118+00
8c5421f1-f2bf-4c35-98e0-d4c18ab9f976	Testirowşik	2024-10-24 12:40:55.264+00	2024-10-24 12:40:55.264+00
\.


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.projects (id, name, status, priority, "startDate", "endDate", completion, archived, "createdAt", "updatedAt") FROM stdin;
f1b38ba5-1983-4958-8a1c-b8528d25a6e2	Narko-psih dispanser	Dowam edýän	Orta	2025-01-12	2025-01-15	30	f	2025-01-12 06:09:53.07+00	2025-01-12 06:46:57.654+00
f427e0af-4a22-4a0e-bc38-e7bceabec0a6	14-nji sagyk oyi	Dowam edýän	Orta	2025-01-12	2025-01-31	30	f	2025-01-12 06:11:39.829+00	2025-01-12 06:47:05.087+00
f80f7e79-360f-4bb8-a8dd-d62b4dd22a25	Goz hasssahanaasy	Başlanmadyk	Ýokary	2025-01-12	2025-01-31	0	f	2025-01-12 06:32:24.89+00	2025-01-12 06:47:16.272+00
1f8c73a2-088b-40de-96d1-2d288440c3b4	Minstroy	Dowam edýän	Ýokary	2024-10-03	2025-01-30	70	f	2024-10-15 13:02:27.084+00	2024-10-15 13:02:27.084+00
a8a42a89-6248-4438-bae7-2a21f97690ba	Kassa we ammar ucin girish sahypa dizayn	Başlanmadyk	Orta	2024-11-30	2024-12-17	0	f	2024-11-24 07:10:32.667+00	2024-11-28 14:12:10.504+00
c36178d7-99a2-4e12-8fff-01253a91422f	Halkara sagaldyş-dikeldiş merkezi	Dowam edýän	Orta	2025-01-06	2025-01-31	60	f	2025-01-06 09:15:04.588+00	2025-01-12 06:10:26.397+00
78646762-91ba-42ab-90a5-d2dd9e2a899d	E-Commerce	Dowam edýän	Orta	2025-01-11	2025-01-23	90	f	2025-01-11 12:04:32.907+00	2025-01-21 14:39:37.422+00
e71b5dfb-7de5-483a-8551-4d9ccc779064	Arkadag saheri HMDU	Dowam edýän	Ýokary	2025-01-12	2025-01-31	10	f	2025-01-12 06:33:29.916+00	2025-01-16 07:02:01.296+00
d9e6e29c-a142-4186-afae-60e1d6131da2	EGMU	Başlanmadyk	Orta	2025-01-12	2025-01-12	80	f	2025-01-12 06:53:46.416+00	2025-01-12 06:53:46.416+00
7ef4f7b7-cd90-4567-aa50-5ceb4a6db036	Arkadag Kopugurly hassahana	Başlanmadyk	Orta	2025-02-09	2025-02-09	0	f	2025-02-09 08:38:21.826+00	2025-02-09 08:38:21.826+00
2afd66f5-6824-4a2e-a594-f565ae46358a	Begmyradow A.,begmyradowa M.wagtlaýyn propiska üçin bukja tabşyrlan 27.12.2024ý.netijesini alyp Aşgabat migrasiýa 5 günüň dowamynda tabşyrmaly 	Tamamlanan	Orta	2024-12-23	2025-01-05	55	f	2024-12-27 04:21:20.039+00	2025-01-17 03:55:32.046+00
98d52dbd-ffb1-4f63-9336-50f801516db1	Japarow Güýçgeldi wagtlaýyn hasaba almak	Dowam edýän	Orta	2025-02-12	2025-02-12	0	f	2025-02-12 11:53:11.713+00	2025-02-12 11:53:11.713+00
bdd4a02a-1798-425f-8fbc-db7e72c6dabb	Japarow B.Japarow G. wagtlaýyn bellege goýmak üçin 14.01.2025ý. çenli resminamalary doly we düzgün taýýar etmeli	Tamamlanan	Orta	2025-01-02	2025-01-10	0	f	2024-12-27 04:33:15.365+00	2025-01-17 03:55:51.607+00
869f6b79-06f0-45ab-ab31-fe2321a98f3f	Intellektual eýeçilikden sertifikady alyp TDS e başlamaly	Başlanmadyk	Ýokary	2025-01-25	2025-02-25	0	f	2025-01-17 04:00:15.557+00	2025-01-17 04:00:15.557+00
2dd4ab36-f323-4984-9b47-7f1ae8aea548	E-market	Başlanmadyk	Orta	2024-09-30	2024-10-30	0	f	2024-10-03 12:18:40.312+00	2024-10-03 12:18:40.312+00
359e00cb-8b0e-4e30-b2e8-5c9d16db222e	HMDU	Başlanmadyk	Orta	2024-12-01	2024-12-31	34.333333333333336	f	2024-12-03 10:58:16.101+00	2024-12-03 10:58:16.101+00
b3b5169c-c72e-473c-a1d8-1fa2b71e5fdd	Turkmen atlar	Dowam edýän	Ýokary	2024-10-21	2024-10-24	0	f	2024-10-25 06:14:49.265+00	2024-10-25 06:14:49.265+00
82867539-37d1-4bc0-a259-585f0564e6e7	Web site...	Başlanmadyk	Orta	2024-09-30	2024-09-30	0	f	2024-10-03 12:43:56.835+00	2024-10-03 12:43:56.835+00
851d6822-97e4-4d9d-ac96-c8a1f39841c9	Intellektual eýeçiligi doly tabşyryp sertifikat almaly	Tamamlanan	Ýokary	2025-01-10	2025-01-25	0	f	2025-01-17 03:58:46.401+00	2025-01-21 10:09:16.801+00
0c4e671f-5de1-44a7-b686-69348ae4b0e1	Intellektual eýeçilikden sertifikat alyp TDS-e resminamalary taýýarlamaly we tabşyrmaly	Tamamlanan	Ýokary	2025-01-25	2025-02-25	0	f	2025-01-17 04:02:18.47+00	2025-01-21 10:09:26.902+00
8cee5991-1d9f-475d-93b3-0be94746b5b1	Goz keseller hassahanasy ucin resminamalary tayyarlamaly	Başlanmadyk	Ýokary	2024-10-24	2024-10-27	6	f	2024-10-25 06:17:46.209+00	2024-10-25 06:17:46.209+00
e0710351-f510-4b14-b077-dfdcd6831516	Türkmenistanyň döwlet standartlary dokument taýýarlamaly	Dowam edýän	Ýokary	2025-01-21	2025-02-21	0	f	2025-01-21 10:11:14.034+00	2025-01-21 10:32:34.437+00
b43e914d-c622-4967-95b3-bea16cdf3fcd	Originals web sayt	Başlanmadyk	Orta	2024-11-05	2024-11-19	31.5	f	2024-11-05 12:07:13.133+00	2024-11-05 12:07:13.133+00
1183c3db-3d26-4a79-9919-e660cd3c9558	ishgaring sahypasyna girenimde proyeklerining sanawy bar yone shol ishgare shol yerde proyekt goshup bolanok	Tamamlanan	Orta	2024-10-27	2024-10-27	100	f	2024-10-27 12:53:04.965+00	2024-12-17 12:56:43.492+00
908ba08c-5a35-4df9-8d7a-84f65ac43411	kalendara noyabr we dekabr ucin bayramchylyklary we careleri girizmeli	Başlanmadyk	Orta	2024-11-18	2024-11-21	33	f	2024-11-16 14:08:48.561+00	2024-11-16 14:08:48.561+00
31f13802-cd95-4920-b606-a187a3496c64	lisenziya	Tamamlanan	Ýokary	2024-10-24	2024-10-24	100	f	2024-10-25 06:27:06.621+00	2024-12-27 04:22:51.172+00
ea2f8580-1733-4f1d-a05a-6363f0199b86	web	Başlanmadyk	Orta	2024-11-28	2024-11-30	0	f	2024-11-28 14:19:37.466+00	2024-11-28 14:19:37.466+00
afecd596-0719-4bce-9b61-69d502236570	www	Başlanmadyk	Orta	2025-01-06	2025-01-06	0	f	2025-01-06 09:11:43.048+00	2025-01-06 09:11:43.048+00
b0c7c907-88e2-4afb-8dfa-4d3344166b51	LIS	Dowam edýän	Orta	2025-01-04	2025-01-31	20	f	2025-01-04 05:30:31.019+00	2025-01-12 06:45:02.564+00
56741f8b-f394-462e-b576-305a8debd2f0	Halkara Fiziologiya ylmy-kliniki merkezi	Dowam edýän	Orta	2025-01-06	2025-02-01	60	f	2025-01-06 09:14:26.767+00	2025-01-12 06:10:50.338+00
\.


--
-- Data for Name: shareWarnings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."shareWarnings" (id, "warningId", "userId", "createdAt", "updatedAt") FROM stdin;
4	3	18	2024-11-25 03:52:13.613+00	2024-11-25 03:52:13.613+00
\.


--
-- Data for Name: startEndWorkTimes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."startEndWorkTimes" (id, "userId", "startTime", "endTime") FROM stdin;
395aab6a-d06c-4057-9bec-4aad3e5cf25d	63	09:00:00	18:00:00
02779d97-dd32-4f26-86b8-5cf598d09024	66	09:00:00	18:00:00
13603e63-32cb-4116-a333-8e0dd669ec7e	64	16:00:00	20:00:00
ced94e56-1746-4157-9302-3e34486d788c	69	09:00:00	18:00:00
3ef0ec3c-0d5d-46cd-8b5f-dacbe0972fad	70	09:00:00	18:00:00
88978fd8-7aa2-40e8-bfeb-6b9e0e928e97	19	09:00:00	18:00:00
11ebb724-1bb1-4dcb-afe0-605aee832d10	9	10:00:00	19:00:00
23facc01-50d7-44f5-a076-b5527d46b0a7	26	09:00:00	18:00:00
8b79dc19-da7c-42c4-9b3f-3e84ac2bbe30	20	09:00:00	18:00:00
f6262e61-6fff-488c-88e3-e66f45eecc35	24	09:00:00	18:00:00
9c01c914-0115-49dd-bd1b-93f14db1aead	18	09:00:00	18:00:00
931e0538-6298-4950-835a-af111825b8c3	15	09:00:00	18:00:00
8eb2c896-02f5-43fd-b954-4b67fe96493d	10	09:00:00	11:00:00
45b17023-06b4-4c9d-9174-d5f0a60a57c1	16	09:00:00	18:00:00
fb0db74f-0912-4f30-a71c-9857a863314a	17	09:00:00	18:00:00
\.


--
-- Data for Name: subTasks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."subTasks" (id, "userId", "taskId", text, "isCompleted", "createdAt", "updatedAt") FROM stdin;
551cabbc-a625-461d-b5b4-421fbe20ee98	16	20024006-b2dc-4b29-9fdf-2b0f2f1d6d79	Minstroy Quartel (Netijenama berlen yuzlenmelerin essasynda, taze ETALLONY baza emele getirlsh )	t	2024-12-07 07:43:16.898+00	2024-12-07 07:43:18.505+00
002fb139-b26d-4e4e-a22e-7b497e82919c	16	20024006-b2dc-4b29-9fdf-2b0f2f1d6d79	Nadip  IP adresyny almalydygyn  Node-js Reac	t	2024-12-07 07:44:01.57+00	2024-12-07 07:44:02.991+00
13463b5a-24d6-4892-b071-d16c661db982	26	8fa6d61c-d0a0-4920-aae4-1d1b036c14b4	Reabilitasiya epikrizi blanky uytgetmeli	f	2025-01-12 06:27:02.799+00	2025-01-12 06:27:02.799+00
66da9920-1baa-4133-ace9-39c9b4e083a9	26	8fa6d61c-d0a0-4920-aae4-1d1b036c14b4	Nakopitelnyy scyot gerek	f	2025-01-12 06:27:02.799+00	2025-01-12 06:27:02.799+00
ec0dd4d1-28fd-4394-93a6-61f1e0eb61b1	18	38f86063-b9dd-4d0b-aef4-8a3786e190ba	(((( hmdu test 2 subtask test test tets )))	t	2024-12-04 04:40:13.359+00	2024-12-06 14:10:34.977+00
1759b866-fa30-43c4-b7d8-5f5fb04a4398	26	fb7efe51-cadd-4627-9cca-09dd938a4e8b	Dashyndan zaprosy kabul eder ytaly API doretmek, zapros meydanlaryny kesgitlemek	f	2025-01-12 06:17:12.761+00	2025-01-12 06:17:12.761+00
f92c3433-c05c-4e35-bddd-7b5398de21e6	18	38f86063-b9dd-4d0b-aef4-8a3786e190ba	hmdu test 3 subtask	t	2024-12-04 04:40:13.359+00	2024-12-06 14:10:39.67+00
fa50bee7-cbda-4eb6-8134-e489ba36384f	26	fb7efe51-cadd-4627-9cca-09dd938a4e8b	Gelen zaprosa jogap tayyarlamak, gelen zaprosyng polaylary boyunça rayatlary filterlemek	f	2025-01-12 06:17:12.761+00	2025-01-12 06:17:12.761+00
7452199f-7b69-41f3-baa0-fdf7adbd19a3	26	fb7efe51-cadd-4627-9cca-09dd938a4e8b	Jogaby ibermek	f	2025-01-12 06:17:12.761+00	2025-01-12 06:17:12.761+00
19923a7a-8507-4a59-878c-fe19118c2cec	26	fb7efe51-cadd-4627-9cca-09dd938a4e8b	JOgaby ibermegin tertiplerini uytgetmage mumkinçilik bermek	f	2025-01-12 06:17:12.761+00	2025-01-12 06:17:12.761+00
f3778d50-a0cd-4044-8a08-d4863c5085df	16	20024006-b2dc-4b29-9fdf-2b0f2f1d6d79	Document Template text	t	2024-12-07 07:36:04.256+00	2024-12-07 07:36:06.114+00
91a76c13-e9a4-415d-b25d-2a4c3d3b4a33	26	fb7efe51-cadd-4627-9cca-09dd938a4e8b	API documentation doretmek. Open API formata getirmek	f	2025-01-12 06:17:12.761+00	2025-01-12 06:17:12.761+00
61dd0d91-74ee-4c0b-8274-b723ef7fcc3b	16	20024006-b2dc-4b29-9fdf-2b0f2f1d6d79	Monitoring 25000 harydy sortirowka etmeli	t	2024-12-07 07:37:07.601+00	2024-12-07 07:37:08.55+00
ba9a1f55-cb20-44e0-a158-6078e9e059ff	16	20024006-b2dc-4b29-9fdf-2b0f2f1d6d79	Monitoring database N-1 link: https://drive.google.com/file/d/196DL-k3WiIdYASV5dftiVoDWAWS6k1Sd/view?usp=sharing	t	2024-12-07 07:39:31.526+00	2024-12-07 07:39:33.225+00
0f667a05-1e75-424b-adc6-5572aed3dbd8	26	fb7efe51-cadd-4627-9cca-09dd938a4e8b	Bellikleri almak we duzetmek	f	2025-01-12 06:17:12.761+00	2025-01-12 06:17:12.761+00
028e2d66-da56-493a-bf6a-919a6324677c	16	20024006-b2dc-4b29-9fdf-2b0f2f1d6d79	Monitoring Figma Link: https://www.figma.com/design/M6mZHKusuMXBZc7M7E7ifw/Untitled?node-id=0-1&node-type=canvas&t=dxHBbFzxvhhaZXUv-0	t	2024-12-07 07:40:28.975+00	2024-12-07 07:40:31.481+00
54915742-40af-4366-af7d-755526ca3164	16	20024006-b2dc-4b29-9fdf-2b0f2f1d6d79	Pretty-json FRONT-END Front end-da nadip log file chykarmaly etdim. Link: https://e.mail.ru/sent/1:60505c98040ad1ce:500000/	t	2024-12-07 07:41:52.786+00	2024-12-07 07:41:57.535+00
3b34fe4c-35b0-4c0f-b4a4-f58f93e6866e	16	20024006-b2dc-4b29-9fdf-2b0f2f1d6d79	"Yuzlenman 60% gechayndigini we ettalonnyu bazadan alyp anamalny otkloneniya hasapladym"	t	2024-12-07 07:42:44.137+00	2024-12-07 07:42:45.447+00
5aabe7bd-7e66-4c93-ba61-52e7ac9823a9	26	fb7efe51-cadd-4627-9cca-09dd938a4e8b	Isi tamamlamak	f	2025-01-12 06:17:12.761+00	2025-01-12 06:17:12.761+00
1f9ebd0e-827e-4e22-81d5-cdd938d8bdb8	26	235d0ad8-8b3a-4249-bd65-9fb60c12b21b	Siemens Clinitek Advantus	f	2025-01-12 06:20:41.256+00	2025-01-12 06:20:41.256+00
24d14e07-3758-4450-80f7-39707579fe42	16	20024006-b2dc-4b29-9fdf-2b0f2f1d6d79	NGINX CRM fixed file permission url	t	2024-12-10 06:33:08.277+00	2024-12-10 06:42:58.475+00
094fb9e2-210e-4167-81c9-2f8c7a7deccc	26	235d0ad8-8b3a-4249-bd65-9fb60c12b21b	Siemens Atellica UAS 800	f	2025-01-12 06:20:41.256+00	2025-01-12 06:20:41.256+00
45f02f51-13a5-4a84-8f77-aa9f20ad9ab5	26	235d0ad8-8b3a-4249-bd65-9fb60c12b21b	Siemens RP500	f	2025-01-12 06:20:41.256+00	2025-01-12 06:20:41.256+00
3513a64e-be06-44dd-a7a0-4042ce7fa9ea	16	20024006-b2dc-4b29-9fdf-2b0f2f1d6d79	Document template img goshma moduli 	t	2024-12-07 07:45:19.267+00	2024-12-10 06:45:03.996+00
90e5df74-8f5b-46ce-9a23-4ad776c4a856	26	235d0ad8-8b3a-4249-bd65-9fb60c12b21b	Siemens ATELLICA CI 1900	f	2025-01-12 06:20:41.256+00	2025-01-12 06:20:41.256+00
659a8328-91bc-4601-8a46-cc84ac0ad686	20	35f5e848-7ee9-4126-bdb3-d6a6e8a72404	B	f	2024-12-10 06:45:38.516+00	2024-12-10 06:45:38.516+00
a304de49-7b1e-4df1-8b07-bfc280a5d797	20	35f5e848-7ee9-4126-bdb3-d6a6e8a72404	A	t	2024-12-10 06:45:38.516+00	2024-12-10 06:45:45.057+00
cf107903-7e34-4c84-b0ee-b97397a98fdf	26	235d0ad8-8b3a-4249-bd65-9fb60c12b21b	Siemens Immulite 2000 XPI	f	2025-01-12 06:20:41.256+00	2025-01-12 06:20:41.256+00
950e0f12-883e-43b6-9355-30859ae375d2	16	20024006-b2dc-4b29-9fdf-2b0f2f1d6d79	Monitoring database N-2 Link: https://drive.google.com/file/d/1K-hTHL_BmulD7P-bFcKIvDVH7e6olMyX/view?usp=sharing	t	2024-12-07 07:40:28.975+00	2024-12-14 05:28:47.254+00
e258bc56-edad-4056-9a10-b32376fda752	17	747a7685-e764-4093-a64a-95ae8c63b762	30 dekabyrda jogabyny alyp gaytmaly	f	2024-12-27 04:27:38.492+00	2024-12-27 04:27:38.492+00
5a581ed8-d5d9-4a52-8978-1635c733671c	17	747a7685-e764-4093-a64a-95ae8c63b762	Minieterstwa gitmeli haty bermeli	t	2024-12-27 04:27:38.492+00	2024-12-27 04:27:40.8+00
3fcd8428-92bf-47a8-8439-ca394590df92	17	3a6c0c87-767b-419d-9087-901c65a44e76	begenç oy kit almaly	t	2024-12-27 04:53:57.253+00	2024-12-27 04:54:26.426+00
43c0ba60-1ccd-4e33-906a-80501dea80e2	17	3a6c0c87-767b-419d-9087-901c65a44e76	guw dok almaly	t	2024-12-27 04:53:57.253+00	2024-12-27 04:54:31.955+00
5bbb5b1c-26b0-4fc4-8314-b4d46bd351f7	26	235d0ad8-8b3a-4249-bd65-9fb60c12b21b	Siemens Atellica NEPH 630	f	2025-01-12 06:20:41.256+00	2025-01-12 06:20:41.256+00
e72c15d0-8d38-4e0a-ab8e-2dfa094ef8b1	26	235d0ad8-8b3a-4249-bd65-9fb60c12b21b	Siemens linitek Status	f	2025-01-12 06:20:41.256+00	2025-01-12 06:20:41.256+00
026a9db5-a279-40a2-8932-c7f2a5dfe8f7	26	235d0ad8-8b3a-4249-bd65-9fb60c12b21b	Siemens Inovance PFA200	f	2025-01-12 06:20:41.256+00	2025-01-12 06:20:41.256+00
60c395e8-779e-4bfa-a682-431e58373139	26	235d0ad8-8b3a-4249-bd65-9fb60c12b21b	Horiba Microsemi CRP	f	2025-01-12 06:20:41.256+00	2025-01-12 06:20:41.256+00
85a94d6b-cb04-4804-9ab0-8daf67215322	26	235d0ad8-8b3a-4249-bd65-9fb60c12b21b	ELITECh SELECTRA ProM w/ISE	f	2025-01-12 06:23:13.689+00	2025-01-12 06:23:13.689+00
ec6d44f0-1f65-4685-b896-9b55721a15a8	26	235d0ad8-8b3a-4249-bd65-9fb60c12b21b	Elitech MIX-RATE	f	2025-01-12 06:23:13.689+00	2025-01-12 06:23:13.689+00
fe9edc4d-26f6-4ac0-8b71-c813c58fbc51	26	235d0ad8-8b3a-4249-bd65-9fb60c12b21b	Sysmex CS-2500	f	2025-01-12 06:23:13.689+00	2025-01-12 06:23:13.689+00
4eba9685-7615-44e8-81bd-65920c43efa4	26	235d0ad8-8b3a-4249-bd65-9fb60c12b21b	Sysmex XN-550	f	2025-01-12 06:23:13.689+00	2025-01-12 06:23:13.689+00
cef46eed-74d4-4338-bdf7-0027d1ac0f95	26	235d0ad8-8b3a-4249-bd65-9fb60c12b21b	Sebia MINICAP FLEX-PIERCING	f	2025-01-12 06:23:13.689+00	2025-01-12 06:23:13.689+00
f62deb6a-197c-4060-999c-cd2bdc7e5a11	26	235d0ad8-8b3a-4249-bd65-9fb60c12b21b	Cellavision by Sysmex	f	2025-01-12 06:23:13.689+00	2025-01-12 06:23:13.689+00
684f736a-d927-4f2a-8cec-b25f85cb609b	26	235d0ad8-8b3a-4249-bd65-9fb60c12b21b	Euroimmun Analyser C-1	f	2025-01-12 06:23:13.689+00	2025-01-12 06:23:13.689+00
64b44e92-6f65-4140-9aed-8cba59c2e7de	26	235d0ad8-8b3a-4249-bd65-9fb60c12b21b	Euroimmun EuroBlotMaster	f	2025-01-12 06:23:13.689+00	2025-01-12 06:23:13.689+00
b89306f1-5b9c-42b4-9206-753ed793fa92	26	235d0ad8-8b3a-4249-bd65-9fb60c12b21b	bioMerieux SA VIdas Cube	f	2025-01-12 06:23:13.689+00	2025-01-12 06:23:13.689+00
52d97c24-49cf-479e-aa67-ace36cdf9710	26	235d0ad8-8b3a-4249-bd65-9fb60c12b21b	bioMerieux SA Vitek2 Compact 60	f	2025-01-12 06:23:13.689+00	2025-01-12 06:23:13.689+00
6bf6a647-268a-4629-8903-68fc2c3530b1	26	235d0ad8-8b3a-4249-bd65-9fb60c12b21b	bioMerieux Bact/ALERT 3D 120 Combo	f	2025-01-12 06:23:13.689+00	2025-01-12 06:23:13.689+00
85502762-df4d-4c3f-85c8-00bce0c5c27a	26	d3011c64-dd8c-45b0-9128-80d5c337994e	Nakopitelnyy scyot gerek	f	2025-01-12 06:30:03.381+00	2025-01-12 06:30:03.381+00
038e7450-726c-40c7-856c-34003b2da3c4	26	d3011c64-dd8c-45b0-9128-80d5c337994e	Derman serishdeleri uly sepagat uyalary uytgedip biler yaly etmek	f	2025-01-12 06:30:03.381+00	2025-01-12 06:30:03.381+00
05988036-e3a0-4446-b023-6e3a726e272e	26	d3011c64-dd8c-45b0-9128-80d5c337994e	Hasabatlary has ginishleyin etmek	f	2025-01-12 06:30:03.381+00	2025-01-12 06:30:03.381+00
4a8a0086-1a95-4706-8c46-9da56fec2388	26	d3011c64-dd8c-45b0-9128-80d5c337994e	Operasiya bolumini ishletmek	f	2025-01-12 06:30:03.381+00	2025-01-12 06:30:03.381+00
a5f6b470-ebb7-46b1-a181-6c966573e304	26	d3011c64-dd8c-45b0-9128-80d5c337994e	ARB bolumini isletmek	f	2025-01-12 06:30:03.381+00	2025-01-12 06:30:03.381+00
92bd3852-3eb0-4428-868d-33668ee59875	26	d3011c64-dd8c-45b0-9128-80d5c337994e	Statistika	f	2025-01-12 06:30:20.028+00	2025-01-12 06:30:20.028+00
bd15cace-e144-4056-95d9-2288cf94ec23	26	d3011c64-dd8c-45b0-9128-80d5c337994e	Wagty sazlamaly	t	2025-01-12 06:30:03.381+00	2025-01-15 06:13:03.451+00
db1af322-6de3-47a2-8988-e969019194be	26	d3011c64-dd8c-45b0-9128-80d5c337994e	Donmagy ayyrmaly	t	2025-01-12 06:30:03.381+00	2025-01-15 06:13:06.68+00
8f79489a-cc9e-4a85-8936-3211a4b5b4f1	26	fb7efe51-cadd-4627-9cca-09dd938a4e8b	Ozalky bar bolan maglumatlary (excell) import etmek	t	2025-01-12 06:17:12.761+00	2025-01-15 06:13:33.585+00
824dd717-cec3-4ff6-b0b4-1eab7b6bbb8e	26	fb7efe51-cadd-4627-9cca-09dd938a4e8b	Registerler. Olary hasaba almagyň, hasapdan aýyrmagyň aýratynlyklary	t	2025-01-12 06:17:12.761+00	2025-01-15 06:13:37.894+00
38cf3267-1ecf-4505-bf54-8f003e970e9c	26	8fa6d61c-d0a0-4920-aae4-1d1b036c14b4	Dashary yurt rayaty ucin tolegleri kesgitlemek (dollar hasabynda gecirmegi yuucin yzygiderlilik)	t	2025-01-12 06:27:02.799+00	2025-01-16 05:37:38.367+00
64370ce0-d4dd-459c-8fd8-f1e1c58eeb43	26	8fa6d61c-d0a0-4920-aae4-1d1b036c14b4	Hassa kabulynyng maglumatlary bejeriji lukman barloagyny kopityalamak	t	2025-01-12 06:27:02.799+00	2025-01-16 05:37:40.785+00
f48f0c5f-c76f-4971-ba21-4f0dc950d8bd	26	8fa6d61c-d0a0-4920-aae4-1d1b036c14b4	Toleg blankynda uytgetmelki zatlary (saglyk depder belgisi, Lukman otagyny cykarmaly, rayat yatan bolsa boluminin ady) 	t	2025-01-12 06:27:02.799+00	2025-01-16 06:59:04.022+00
84f9eaf0-0b86-4154-b475-2c8c13642508	26	d3011c64-dd8c-45b0-9128-80d5c337994e	Ylym bolumi	f	2025-01-12 06:30:20.028+00	2025-01-12 06:30:20.028+00
e0713ad6-f00c-4036-a853-6d539094a73e	26	7f8c05ef-408c-4b4c-895a-1452b1994d38	Barlag meyilnamada barlag bahasyny tegeleklemek	f	2025-01-12 06:35:30.926+00	2025-01-12 06:35:30.926+00
72697de4-fb22-49e1-9808-21c4da4ef06c	26	7f8c05ef-408c-4b4c-895a-1452b1994d38	CAT islanok	f	2025-01-12 06:35:38.409+00	2025-01-12 06:35:38.409+00
60418d87-1603-4b17-a211-54403f3c4b85	26	3fa8e91f-5292-44ce-a4ba-8654cd5c14b3	Serverleri High availability, backup funsiyalaryny duzmeli	f	2025-01-12 06:37:33.06+00	2025-01-12 06:37:33.06+00
131187cf-d671-408c-b626-ef75d4467b94	26	3fa8e91f-5292-44ce-a4ba-8654cd5c14b3	Seti sazlamaly virtual adapterleri goshmaly	f	2025-01-12 06:37:33.06+00	2025-01-12 06:37:33.06+00
bcf25b97-2cfd-4312-bc06-fc556e23927d	26	3fa8e91f-5292-44ce-a4ba-8654cd5c14b3	Deploy etmeli proyektleri	f	2025-01-12 06:37:33.06+00	2025-01-12 06:37:33.06+00
80cd17f3-8072-4e46-a684-6c4c85d0e0b4	26	dbf04f1b-889d-439c-8bd7-5eb062fd87ad	1.Rayady registration edilende goni shol wkladka-da yuz tutma achar yaly etmeli {3.1 surat}.	f	2025-01-12 06:43:11.859+00	2025-01-12 06:43:11.859+00
3a7e976a-ed9e-44f9-b1f6-5dc31b170f03	26	dbf04f1b-889d-439c-8bd7-5eb062fd87ad	2.Registration-da passport seria we s.m yaly [yuz tutmanyn usuly, gornushi hem] kop ulanylyany goni 1-nji bolup durmak {3.2 surat}.	f	2025-01-12 06:43:11.859+00	2025-01-12 06:43:11.859+00
1a58637c-010b-440e-bd37-33626663c83f	26	dbf04f1b-889d-439c-8bd7-5eb062fd87ad	3.FIZIOLOGIYA hassahanasy punkt 1,2,3,4,5,6,8,9	f	2025-01-12 06:43:11.859+00	2025-01-12 06:43:11.859+00
f53dd124-2efc-464f-a72e-a2498692cb3c	26	dbf04f1b-889d-439c-8bd7-5eb062fd87ad	4.Operasiya [onki kesel kesgitleri] diylen yere awtomatiki onki berlen k.kesgidi gelmeli {3.3 surat}.	f	2025-01-12 06:43:11.859+00	2025-01-12 06:43:11.859+00
ba91d58a-d4d8-4dfa-acee-5213a7e0f0a6	26	dbf04f1b-889d-439c-8bd7-5eb062fd87ad	5.Operasiyanyn gutaran senesi hem bar wagty we (sagady hokmany dal yagdayda) {3.4 surat}.	f	2025-01-12 06:43:11.859+00	2025-01-12 06:43:11.859+00
082bd4c8-cb06-415a-a889-87e72751b7d8	26	235d0ad8-8b3a-4249-bd65-9fb60c12b21b	HOriba Micros ES60	t	2025-01-12 06:20:41.256+00	2025-01-12 06:53:11.368+00
003d0390-d290-40d5-8283-c104dd1c5f00	26	fb7efe51-cadd-4627-9cca-09dd938a4e8b	Rayatlary hasaba almak uçion gerek bolan polyalary kesgitlemek	t	2025-01-12 06:17:12.761+00	2025-01-15 06:13:35.772+00
62d6843f-642b-49fe-96e9-50069f66f2aa	26	7f8c05ef-408c-4b4c-895a-1452b1994d38	Gowrelili hasabynda sahpa calyshanok	t	2025-01-12 06:35:30.926+00	2025-01-15 06:13:55.93+00
14eb6082-a18f-4d5a-b335-d495ca6b0d1b	26	7f8c05ef-408c-4b4c-895a-1452b1994d38	Sagaldys gozegciligi filter islanok	t	2025-01-12 06:36:16.991+00	2025-01-15 06:13:57.479+00
3bb458fa-2f03-41ca-89a6-ee6e313a3345	17	4f52f145-6eee-45e5-8d68-506d11068148	sdfgfdz	f	2025-01-29 14:42:51.918+00	2025-01-29 14:42:51.918+00
0fd6dc2d-0f50-4edd-98ee-cbaf8df519d7	17	4f52f145-6eee-45e5-8d68-506d11068148	asdfghgh	t	2025-01-29 14:42:51.918+00	2025-01-29 14:42:54.658+00
2336211a-cb96-4cd0-84c4-5865da8069a4	26	dc222854-fc5b-424e-b86d-35cc0ab9a81e	Byujet hojalyk ulgamy. Toleg gecirilende tapawutlanyar	f	2025-02-09 08:55:57.318+00	2025-02-09 08:55:57.318+00
8c4c862a-2570-4426-a2e6-329946d6d312	26	dc222854-fc5b-424e-b86d-35cc0ab9a81e	Bejergi meyilnam kalendary ayyryp bellenilen blank gornushinde bolmaly	f	2025-02-09 12:08:56.695+00	2025-02-09 12:08:56.695+00
fc5d85fa-38d5-4b3c-8f41-d1f56196a449	26	dc222854-fc5b-424e-b86d-35cc0ab9a81e	OPerasiyany ika bolmeli onki we sonky bolekler	f	2025-02-09 12:08:56.695+00	2025-02-09 12:08:56.695+00
d903cd5d-9a7a-41c4-b7d2-8463b19d0c15	26	dc222854-fc5b-424e-b86d-35cc0ab9a81e	ARB list naznaçheniya goşmaly belleinilen görnüşde	f	2025-02-09 12:12:33.224+00	2025-02-09 12:12:33.224+00
3e01b87d-3f05-436e-93de-f69b9f818b74	26	dc222854-fc5b-424e-b86d-35cc0ab9a81e	ARB blanklary gerek	f	2025-02-09 12:12:33.224+00	2025-02-09 12:12:33.224+00
70d9956f-e72c-4f8f-86ff-be4739800399	26	dc222854-fc5b-424e-b86d-35cc0ab9a81e	Wezipe gornushi (talyp, okuwcy, esger, ishgar)? 	t	2025-02-09 08:55:57.318+00	2025-02-12 03:22:49.141+00
71e14080-aa04-446f-abd6-fd07d4b27584	26	dc222854-fc5b-424e-b86d-35cc0ab9a81e	Wezipe gornushi (talyp, okuwcy, esger, ishgar) (esger bolsa cast nomeri, talyp bolsa okuw jayy, kursy, ishgar bols ish yeri)?	t	2025-02-09 08:55:57.318+00	2025-02-12 03:22:49.972+00
\.


--
-- Data for Name: tasks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tasks (id, "userId", "projectId", name, status, priority, "startDate", "endDate", "completionProject", "completionTask", "createdAt", "updatedAt") FROM stdin;
43293655-a2ae-46ba-b2f4-f5320948b879	17	908ba08c-5a35-4df9-8d7a-84f65ac43411	kalendara noyabr we dekabr ayynyng charelerini girizmeli	Dowam edýän	Orta	2024-11-18	2024-11-21	100	33	2024-11-16 14:08:48.578+00	2024-12-27 04:21:39.78+00
4e88391f-82f0-47de-b5ad-edd70c630960	17	31f13802-cd95-4920-b606-a187a3496c64	dokumentleri akitmeli	Tamamlanan	Ýokary	2024-10-25	2024-10-25	100	100	2024-10-25 06:27:06.632+00	2024-12-27 04:22:51.164+00
dbf04f1b-889d-439c-8bd7-5eb062fd87ad	26	f80f7e79-360f-4bb8-a8dd-d62b4dd22a25	Goz hassahansy ucin HMDU	Başlanmadyk	Orta	2025-01-12	2025-01-12	100	0	2025-01-12 06:32:24.903+00	2025-01-12 06:32:24.903+00
20024006-b2dc-4b29-9fdf-2b0f2f1d6d79	16	1f8c73a2-088b-40de-96d1-2d288440c3b4	Back-end	Dowam edýän	Ýokary	2024-10-04	2025-01-02	50	74	2024-10-15 13:02:27.099+00	2025-01-04 06:03:03.828+00
35f5e848-7ee9-4126-bdb3-d6a6e8a72404	20	1f8c73a2-088b-40de-96d1-2d288440c3b4	Minstroy proek etmeli	Dowam edýän	Ýokary	2024-10-04	2025-01-01	50	66	2024-10-15 13:02:27.093+00	2025-01-04 06:04:12.881+00
235d0ad8-8b3a-4249-bd65-9fb60c12b21b	26	b0c7c907-88e2-4afb-8dfa-4d3344166b51	LIS	Dowam edýän	Orta	2025-01-04	2025-01-11	100	20	2025-01-04 05:30:31.021+00	2025-01-12 06:45:17.768+00
d3011c64-dd8c-45b0-9128-80d5c337994e	26	56741f8b-f394-462e-b576-305a8debd2f0	Fiziologiya	Dowam edýän	Orta	2025-01-06	2025-02-01	100	60	2025-01-06 09:14:26.781+00	2025-01-12 06:45:35.336+00
fb7efe51-cadd-4627-9cca-09dd938a4e8b	26	f1b38ba5-1983-4958-8a1c-b8528d25a6e2	Register hasabyny yoretmek, X-ROAD integration	Dowam edýän	Ýokary	2025-01-12	2025-01-15	100	30	2025-01-12 06:09:53.082+00	2025-01-12 06:46:07.132+00
7f8c05ef-408c-4b4c-895a-1452b1994d38	26	f427e0af-4a22-4a0e-bc38-e7bceabec0a6	HMDU kadal ishin upjin etmek	Dowam edýän	Ýokary	2025-01-12	2025-01-15	100	30	2025-01-12 06:11:39.841+00	2025-01-12 06:46:19.031+00
060eb416-7825-4a7e-8f4c-736eaf98c244	10	b3b5169c-c72e-473c-a1d8-1fa2b71e5fdd	Dizaynyny tayyarlamaly	Dowam edýän	Ýokary	2024-10-22	2024-10-25	100	0	2024-10-25 06:14:49.276+00	2024-10-25 06:14:49.276+00
38f86063-b9dd-4d0b-aef4-8a3786e190ba	18	1183c3db-3d26-4a79-9919-e660cd3c9558	goshmaly	Tamamlanan	Orta	2024-10-28	2024-10-30	50	100	2024-10-27 12:53:04.976+00	2024-11-26 05:15:54.223+00
8fa6d61c-d0a0-4920-aae4-1d1b036c14b4	26	c36178d7-99a2-4e12-8fff-01253a91422f	Reabilitaiya	Başlanmadyk	Orta	2025-01-06	2025-01-31	100	60	2025-01-06 09:15:04.601+00	2025-01-16 07:01:34.783+00
407a7564-0f4e-4083-82a4-434e3d12e423	10	b43e914d-c622-4967-95b3-bea16cdf3fcd	disaynyny tayyarlamaly	Başlanmadyk	Orta	2024-11-05	2024-11-11	50	0	2024-11-05 12:07:13.15+00	2024-11-05 12:07:13.15+00
bedb27aa-0e34-4fc2-9362-e436463f7af8	10	a8a42a89-6248-4438-bae7-2a21f97690ba	dizaynyny tayyarlamaly	Başlanmadyk	Pes	2024-11-30	2024-12-17	100	0	2024-11-24 07:10:32.681+00	2024-12-03 12:31:54.496+00
3fa8e91f-5292-44ce-a4ba-8654cd5c14b3	26	e71b5dfb-7de5-483a-8551-4d9ccc779064	Arkadag ucin bellikleriislap zapusk etmek	Dowam edýän	Ýokary	2025-01-12	2025-01-31	100	10	2025-01-12 06:33:29.936+00	2025-01-16 07:02:10.523+00
9afac096-485b-4a47-a9c5-18de979b93ec	26	d9e6e29c-a142-4186-afae-60e1d6131da2	EGMU bellikleri duzetmeli	Dowam edýän	Orta	2025-01-12	2025-01-31	100	80	2025-01-12 06:53:46.429+00	2025-01-16 07:02:32.05+00
15483337-9f34-40e5-b696-81d84fbf6caf	17	2afd66f5-6824-4a2e-a594-f565ae46358a	Resminamalary doly we düzgün tabşyryp işgärleri wagtlaýyn bellige almaly	Tamamlanan	Orta	2024-12-23	2025-01-05	100	55	2024-12-27 04:21:20.053+00	2025-01-17 03:55:32.039+00
3a6c0c87-767b-419d-9087-901c65a44e76	17	bdd4a02a-1798-425f-8fbc-db7e72c6dabb	Resminamalary doly ýygnap Zähmet we ilaty durmuş taýdan goramak ministrligine tabşyrmaly	Tamamlanan	Ýokary	2025-01-02	2025-01-10	100	0	2024-12-27 04:33:15.377+00	2025-01-17 03:55:51.6+00
8d0d661d-cbf5-49bc-95ab-624f889fe68b	17	851d6822-97e4-4d9d-ac96-c8a1f39841c9	sertifikat almak	Dowam edýän	Ýokary	2025-01-10	2025-01-25	100	0	2025-01-17 03:58:46.413+00	2025-01-17 03:58:46.413+00
4b91afa2-1728-40b4-8714-9b7a8bd99adf	17	0c4e671f-5de1-44a7-b686-69348ae4b0e1	TDS-e resminamalary taýýar etmeli	Başlanmadyk	Ýokary	2025-01-25	2025-02-25	100	0	2025-01-17 04:02:18.482+00	2025-01-17 04:02:18.482+00
d0e4e65c-4f9f-4d7e-913d-d4ccb8a423ce	18	afecd596-0719-4bce-9b61-69d502236570	www	Başlanmadyk	Orta	2025-01-06	2025-01-06	100	0	2025-01-06 09:11:43.063+00	2025-01-06 09:11:43.063+00
4f52f145-6eee-45e5-8d68-506d11068148	17	e0710351-f510-4b14-b077-dfdcd6831516	Türkmenistanyň döwlet standartlary dokument taýýarlamaly	Dowam edýän	Ýokary	2025-01-21	2025-02-21	100	0	2025-01-21 10:11:14.055+00	2025-01-21 10:32:19.63+00
00218fff-8555-4615-9a12-e4f3f65ca138	64	78646762-91ba-42ab-90a5-d2dd9e2a899d	Emeli Is	Dowam edýän	Orta	2025-01-11	2025-01-20	100	90	2025-01-11 12:04:32.919+00	2025-01-21 14:39:12.773+00
dc222854-fc5b-424e-b86d-35cc0ab9a81e	26	7ef4f7b7-cd90-4567-aa50-5ceb4a6db036	Bellikleri islhlemeli	Başlanmadyk	Orta	2025-02-09	2025-02-28	100	0	2025-02-09 08:38:21.84+00	2025-02-09 08:38:21.84+00
9185f6b5-c027-4a6f-bd62-462a11220011	17	98d52dbd-ffb1-4f63-9336-50f801516db1	Resminamalary taýýarlap Zähmet ministrligine Tabşyrmaly	Dowam edýän	Orta	2025-02-12	2025-02-12	100	0	2025-02-12 11:53:11.727+00	2025-02-12 11:53:11.727+00
829a1e28-1841-41c4-b1a4-27b0b6a4b2d6	16	1183c3db-3d26-4a79-9919-e660cd3c9558	duzetmeli	Tamamlanan	Orta	2024-10-09	2024-10-10	50	100	2024-10-27 12:53:04.982+00	2024-12-17 12:56:43.483+00
747a7685-e764-4093-a64a-95ae8c63b762	17	8cee5991-1d9f-475d-93b3-0be94746b5b1	dokumentleri tayyarlamaly	Tamamlanan	Ýokary	2024-10-25	2024-10-28	100	6	2024-10-25 06:17:46.22+00	2024-11-25 05:07:54.025+00
62a858dd-0a01-4216-beec-27fb74b2ba31	18	b43e914d-c622-4967-95b3-bea16cdf3fcd	dizayna gora ecommercy etmeli	Başlanmadyk	Orta	2024-11-12	2024-11-19	50	63	2024-11-05 12:07:13.161+00	2025-01-11 11:01:39.879+00
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, pass, login, role, "createdAt", "updatedAt", status, surname, birthday, "phoneNumber", mail, "whereStudy", "whereLive", languages, img, "positionId", "doorId") FROM stdin;
9	Admin	$2a$04$/k0KtwsDaiEsic84n5b.ieAmrX5aNDMAJPOk5SniaN1/5o0qqFvau	+99361166788	ADMIN	2024-07-06 05:42:19.121+00	2024-12-09 05:54:02.339+00	t	Adminow	1992-09-15	+99361166788	begench@alemtilsimat.com	MIT	Ashgabat	RUS,TKM,ENG	\N	\N	\N
17	Maral	$2a$04$8ydEQGqF7BpFTiZDvYy8qObJ2O0z5eQH31Z.tpliuGN.TPNze9.te	+99361233668	MODERATOR	2024-07-26 04:09:40.565+00	2024-12-09 06:03:49.706+00	t	Begmyradowa	1974-05-27	+99361233668	maral@alemtilsimat.com	Orta bilim	Aşgabat	RUS,TKM	\N	9156e956-2baf-4191-9d4f-22a128efe3df	\N
20	Arslan	$2a$04$Okl5v.5xYULsj3ryP4XI4.OdL8Pdrj89rzhYB3UNydtq.9IJ/T47K	+99363905012	USER	2024-08-03 04:08:26.372+00	2024-12-09 06:12:43.808+00	t	Begmyradow	1995-06-28	+99363905012	arslan@alemtilsimat.com	DEU	Ashgabat	TKM,RUS,ENG	\N	9eb3d10c-083a-4af8-bc2a-0d5e8fa7c147	\N
24	Atamyrat	$2a$04$Qmc1NvfeqBnt79veMtyqGudH.B.9mXgKjMAy9dPDI2FBRdo9mB8M.	atamyrat	USER	2024-08-20 11:48:27.225+00	2024-10-28 04:59:57.32+00	t	Şükürow	2005-07-13	+993	atamyrat@alemtilsimat.com	Türkmenistanyň Telekommunikasiýalar we informatika instituty	Aşgabat	TKM,RUS	\N	9eb3d10c-083a-4af8-bc2a-0d5e8fa7c147	\N
19	Eziz	$2a$04$z6YzRzNGd0gobAcb4fT2aeHMw8GmyEIThEUqCzmaZAUvK0Xyl.p7u	+99362934985	USER	2024-07-29 07:42:21.956+00	2024-12-09 06:31:13.916+00	t	Egemberdiyev	2002-03-05	+99362934985	eziz@alemtilsimat.com	TDBGI	Asgabat	ENG,RUS,TKM	\N	9eb3d10c-083a-4af8-bc2a-0d5e8fa7c147	\N
64	Resulgeldi	$2a$04$ba1ad5Y9NuvGHMyPJ.X1AOQ.C9uUvp89G17ssoqTH3c45E3Gt.e6m	99364430502	USER	2024-12-09 13:26:02.731+00	2024-12-09 13:48:41.853+00	t	Güýjow	2005-11-07	99364430502	resulgeldi4065@gmail.çom	Türkmenistanyň Inžener-Tehniki we Ulag kommunikasiýalary instituty	Aş Oguzhan 140/13	TKM,RUS,TR,TK	\N	9eb3d10c-083a-4af8-bc2a-0d5e8fa7c147	\N
26	Amangeldi	$2a$04$gB1ilNiJLZjJTbPF7yYQuO9Vq4fPdZkWjW08Tk2k2DOSNRjbIdqpa	+99361548104	USER	2024-09-03 03:03:00.695+00	2025-01-04 05:33:09.839+00	t	Berdiýew	1999-11-11	+99361548104	amangeldi@alemtilsimat.com	Harby deňiz instituty	Mary	TKM,Turkmen,Russian	\N	9eb3d10c-083a-4af8-bc2a-0d5e8fa7c147	\N
5	Maksim	$2a$04$ru3W6bcTpB.Lxcc0F5D0B.A8B5pMxxpfMSZ1CRt77041VhDLGYF6i	+99361864968	USER	2024-06-15 05:56:29.33+00	2024-12-09 06:50:02.302+00	f	Drozdowskiy	2000-05-11	+99361864968	maksim@alemtilsimat.com	Yokory okuw jay	Ashgabat	RUS	\N	9eb3d10c-083a-4af8-bc2a-0d5e8fa7c147	\N
70	Guwanç	$2a$04$LWBWDcl5HYHgIOMWYRXbxu105LDk4StdyEczeRkVT/DVMsWm8.Gqu	+99361352414	USER	2025-01-21 10:21:49.901+00	2025-01-21 10:21:49.901+00	t	Japarow	1996-04-19	+99361352414	guwanch@alemtilsimat.com	Magtymguly ad.Türkmen döwlet uniwersiteti	Aşgabat ş.Köpetdag etr. Howdan "W"	TKM	\N	9eb3d10c-083a-4af8-bc2a-0d5e8fa7c147	\N
14	Bahar	$2a$04$TtXFbNd5LhxYCpu0gShYCeOayDqVcv9OYr0fxAfeA8AL08Bn0dcVm	+99363592220	USER	2024-07-20 07:45:54.85+00	2024-12-09 07:08:08.814+00	f	Baýgeldiýewa	2002-04-19	+99363592220	bahar@alemtilsimat.com	Orta bilim	Aşgabat	TKM,RUS,ENG,TK	\N	8c5421f1-f2bf-4c35-98e0-d4c18ab9f976	\N
15	Aylar	$2a$04$JZoEydjokFN/ttUUi2LObOyyOkM7g9OHVI2br2CZRkUD9CYZKwj8i	+99365691723	USER	2024-07-25 12:51:41.8+00	2024-12-11 04:19:28.802+00	t	Dermanowa	2001-08-05	+99365691723	aylar@alemtilsimat.com	Yokory okuw jay	Ashgabat	TKM RUS,TKM,RUS,ENG	\N	8c5421f1-f2bf-4c35-98e0-d4c18ab9f976	\N
66	Halil	$2a$04$E3B2DE7aaTj0zS5d4GpcpuDE5IA5lphDFYpCfQo1b13rnlr2hEABi	99363430338	USER	2024-12-10 03:40:05.315+00	2025-01-30 03:44:59.864+00	f	Gayypow	1995-02-14	99363430338	microsoft7779@gmail.com	Türkmenistanyň Oguz han adyndaky Inžener-tehnologiýalar Uniwersiteti.	Ashgabat s, Bagtyyarlyk	TKM,ENG,RUS,TR	\N	9eb3d10c-083a-4af8-bc2a-0d5e8fa7c147	\N
63	Şatlyk	$2a$04$n5SpJRsGi9QXz34AhzvMnO/k.HhW1JwA.IVjpytsXeJByQG6Y8kXa	+99362922257	USER	2024-12-09 13:23:42.185+00	2025-01-06 10:05:58.158+00	t	Agamuradow	1998-05-25	+99362922257	shatlyk@alemtilsimat.com	41-nji mekdep	Gami zahmet 4/2	TKM	\N	8c5421f1-f2bf-4c35-98e0-d4c18ab9f976	\N
16	Ismayyl	$2a$04$zetNcXuoy5DwkY7Uohy3QucSSv0iVMd/j2XeWQAD1i95GqYr1CtzS	+99362108097	USER	2024-07-25 13:23:39.559+00	2025-01-08 12:56:22.774+00	t	Atayew	2001-06-21	+99362108097	ismayyl@alemtilsimat.com	Belarus döwlet informatika we radioelektronika uniwersitedy	Aşgabat	TKM,RUS,ENG	1732333573729_ismayylProfil.png	9eb3d10c-083a-4af8-bc2a-0d5e8fa7c147	17
69	Rahman	$2a$04$woUIqXmHz1ZVYPL7HKdMA.f7uqlQO9Gw5g8w28gOii9a4r1CXAX/i	+99362378507	USER	2025-01-06 10:00:02.422+00	2025-01-09 10:11:22.441+00	t	Nazarow	2004-01-05	+993 62 37 85 07	amanaman145632@gmail.com	Turkmenistanyn Oguzhan adyndaky Inzener Tehnologiyalar uniwersiteti	Gokdepe	TKM,ENG,RUS	\N	9eb3d10c-083a-4af8-bc2a-0d5e8fa7c147	\N
8	Selbi	$2a$04$eqyXRIkMOaaNARfC4DrHh.B9lQDURncqTyNVAH1V8/jgMynvv57Cy	+99364293275	USER	2024-06-27 04:40:50.866+00	2025-01-15 06:15:51.903+00	f	Arazjykowa	2005-08-11	+99364293275	selbi@alemtilsimat.com	4-nji Orat Mek	Ashgabat	RUS,TKM	\N	8c5421f1-f2bf-4c35-98e0-d4c18ab9f976	\N
10	Gülnur	$2a$04$vB2zGx530ae7LB/MBr77pOmeIJANogJeRLbcWAaPVLtVgGmX8PvNm	+99361843944	USER	2024-07-06 06:53:44.458+00	2025-01-18 07:43:53.584+00	t	Gurbanowa	2002-06-24	+99361843944	gulnur@alemtilsimat.com	Türkmen Döwlet Ykdysady we Dolandyryş instituty	Aşgabat	TKM,RUS,DEU,TR,ENG	\N	16e15ee8-95be-4837-a9b0-3c42e37938c1	\N
18	Atamyrat	$2a$04$qu9oScrZmm2nGOYrZctD5OAIVxhPPK9D6Yw0PZUnMcio9bkSYCSLG	atis	USER	2024-07-29 07:35:58.633+00	2025-01-21 05:59:24.012+00	t	Ikramow	2002-07-15	+99363885234	atamyratikramow@gmail.com	Türkmen Döwlet Ykdysadyýet we Dolandyryş Instituty	Ashgabat	TKM,RUS,ENG,TR	1727706897860_Rectangle_18.png	9eb3d10c-083a-4af8-bc2a-0d5e8fa7c147	\N
\.


--
-- Data for Name: warnings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.warnings (id, title, date, color, "createdAt", "updatedAt") FROM stdin;
3	oran hayal gityar ishlering	2024-09-27 07:00:00+00	#FF9E58	2024-11-25 03:52:13.603+00	2024-11-25 03:52:13.603+00
\.


--
-- Name: EmployeeRegistrationTime_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."EmployeeRegistrationTime_id_seq"', 1650, true);


--
-- Name: pdfDocuments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."pdfDocuments_id_seq"', 74, true);


--
-- Name: shareWarnings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."shareWarnings_id_seq"', 19, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 70, true);


--
-- Name: warnings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.warnings_id_seq', 12, true);


--
-- Name: Absences Absences_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Absences"
    ADD CONSTRAINT "Absences_pkey" PRIMARY KEY (id);


--
-- Name: DocumtTypes DocumtTypes_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key1" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key10; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key10" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key100; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key100" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key101; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key101" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key102; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key102" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key103; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key103" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key104; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key104" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key105; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key105" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key106; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key106" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key11; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key11" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key12; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key12" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key13; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key13" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key14; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key14" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key15; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key15" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key16; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key16" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key17; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key17" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key18; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key18" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key19; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key19" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key2" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key20; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key20" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key21; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key21" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key22; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key22" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key23; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key23" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key24; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key24" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key25; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key25" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key26; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key26" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key27; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key27" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key28; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key28" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key29; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key29" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key3" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key30; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key30" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key31; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key31" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key32; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key32" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key33" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key34; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key34" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key35; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key35" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key36; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key36" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key37; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key37" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key38; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key38" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key39; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key39" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key4" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key40" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key41; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key41" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key42; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key42" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key43; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key43" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key44; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key44" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key45; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key45" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key46; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key46" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key47; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key47" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key48; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key48" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key49; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key49" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key5" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key50; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key50" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key51; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key51" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key52; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key52" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key53; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key53" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key54; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key54" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key55; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key55" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key56; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key56" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key57; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key57" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key58; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key58" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key59; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key59" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key6" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key60; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key60" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key61; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key61" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key62; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key62" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key63; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key63" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key64; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key64" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key65; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key65" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key66; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key66" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key67; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key67" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key68; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key68" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key69; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key69" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key7" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key70; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key70" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key71; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key71" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key72; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key72" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key73; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key73" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key74; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key74" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key75; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key75" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key76; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key76" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key77; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key77" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key78; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key78" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key79; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key79" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key8" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key80; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key80" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key81; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key81" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key82; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key82" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key83; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key83" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key84; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key84" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key85; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key85" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key86; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key86" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key87; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key87" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key88; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key88" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key89; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key89" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key9" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key90; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key90" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key91; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key91" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key92; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key92" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key93; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key93" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key94; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key94" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key95; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key95" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key96; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key96" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key97; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key97" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key98; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key98" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_name_key99; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_name_key99" UNIQUE (name);


--
-- Name: DocumtTypes DocumtTypes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DocumtTypes"
    ADD CONSTRAINT "DocumtTypes_pkey" PRIMARY KEY (id);


--
-- Name: EmployeeRegistrationTime EmployeeRegistrationTime_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."EmployeeRegistrationTime"
    ADD CONSTRAINT "EmployeeRegistrationTime_pkey" PRIMARY KEY (id);


--
-- Name: LaborProtections LaborProtections_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."LaborProtections"
    ADD CONSTRAINT "LaborProtections_pkey" PRIMARY KEY (id);


--
-- Name: UserLaborProtection UserLaborProtection_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserLaborProtection"
    ADD CONSTRAINT "UserLaborProtection_pkey" PRIMARY KEY ("userId", "LaborProtectionId");


--
-- Name: chats chats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chats
    ADD CONSTRAINT chats_pkey PRIMARY KEY (id);


--
-- Name: holidays holidays_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.holidays
    ADD CONSTRAINT holidays_pkey PRIMARY KEY (id);


--
-- Name: messagges messagges_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messagges
    ADD CONSTRAINT messagges_pkey PRIMARY KEY (id);


--
-- Name: notes notes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);


--
-- Name: pdfDocuments pdfDocuments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."pdfDocuments"
    ADD CONSTRAINT "pdfDocuments_pkey" PRIMARY KEY (id);


--
-- Name: positions positions_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key UNIQUE (name);


--
-- Name: positions positions_name_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key1 UNIQUE (name);


--
-- Name: positions positions_name_key10; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key10 UNIQUE (name);


--
-- Name: positions positions_name_key100; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key100 UNIQUE (name);


--
-- Name: positions positions_name_key101; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key101 UNIQUE (name);


--
-- Name: positions positions_name_key102; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key102 UNIQUE (name);


--
-- Name: positions positions_name_key103; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key103 UNIQUE (name);


--
-- Name: positions positions_name_key104; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key104 UNIQUE (name);


--
-- Name: positions positions_name_key105; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key105 UNIQUE (name);


--
-- Name: positions positions_name_key106; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key106 UNIQUE (name);


--
-- Name: positions positions_name_key107; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key107 UNIQUE (name);


--
-- Name: positions positions_name_key108; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key108 UNIQUE (name);


--
-- Name: positions positions_name_key109; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key109 UNIQUE (name);


--
-- Name: positions positions_name_key11; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key11 UNIQUE (name);


--
-- Name: positions positions_name_key110; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key110 UNIQUE (name);


--
-- Name: positions positions_name_key111; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key111 UNIQUE (name);


--
-- Name: positions positions_name_key112; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key112 UNIQUE (name);


--
-- Name: positions positions_name_key113; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key113 UNIQUE (name);


--
-- Name: positions positions_name_key114; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key114 UNIQUE (name);


--
-- Name: positions positions_name_key115; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key115 UNIQUE (name);


--
-- Name: positions positions_name_key116; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key116 UNIQUE (name);


--
-- Name: positions positions_name_key117; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key117 UNIQUE (name);


--
-- Name: positions positions_name_key118; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key118 UNIQUE (name);


--
-- Name: positions positions_name_key119; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key119 UNIQUE (name);


--
-- Name: positions positions_name_key12; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key12 UNIQUE (name);


--
-- Name: positions positions_name_key120; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key120 UNIQUE (name);


--
-- Name: positions positions_name_key121; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key121 UNIQUE (name);


--
-- Name: positions positions_name_key122; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key122 UNIQUE (name);


--
-- Name: positions positions_name_key123; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key123 UNIQUE (name);


--
-- Name: positions positions_name_key124; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key124 UNIQUE (name);


--
-- Name: positions positions_name_key125; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key125 UNIQUE (name);


--
-- Name: positions positions_name_key126; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key126 UNIQUE (name);


--
-- Name: positions positions_name_key127; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key127 UNIQUE (name);


--
-- Name: positions positions_name_key128; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key128 UNIQUE (name);


--
-- Name: positions positions_name_key129; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key129 UNIQUE (name);


--
-- Name: positions positions_name_key13; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key13 UNIQUE (name);


--
-- Name: positions positions_name_key130; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key130 UNIQUE (name);


--
-- Name: positions positions_name_key131; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key131 UNIQUE (name);


--
-- Name: positions positions_name_key132; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key132 UNIQUE (name);


--
-- Name: positions positions_name_key133; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key133 UNIQUE (name);


--
-- Name: positions positions_name_key134; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key134 UNIQUE (name);


--
-- Name: positions positions_name_key135; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key135 UNIQUE (name);


--
-- Name: positions positions_name_key136; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key136 UNIQUE (name);


--
-- Name: positions positions_name_key137; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key137 UNIQUE (name);


--
-- Name: positions positions_name_key138; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key138 UNIQUE (name);


--
-- Name: positions positions_name_key139; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key139 UNIQUE (name);


--
-- Name: positions positions_name_key14; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key14 UNIQUE (name);


--
-- Name: positions positions_name_key140; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key140 UNIQUE (name);


--
-- Name: positions positions_name_key141; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key141 UNIQUE (name);


--
-- Name: positions positions_name_key142; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key142 UNIQUE (name);


--
-- Name: positions positions_name_key143; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key143 UNIQUE (name);


--
-- Name: positions positions_name_key144; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key144 UNIQUE (name);


--
-- Name: positions positions_name_key145; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key145 UNIQUE (name);


--
-- Name: positions positions_name_key146; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key146 UNIQUE (name);


--
-- Name: positions positions_name_key147; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key147 UNIQUE (name);


--
-- Name: positions positions_name_key148; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key148 UNIQUE (name);


--
-- Name: positions positions_name_key149; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key149 UNIQUE (name);


--
-- Name: positions positions_name_key15; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key15 UNIQUE (name);


--
-- Name: positions positions_name_key150; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key150 UNIQUE (name);


--
-- Name: positions positions_name_key151; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key151 UNIQUE (name);


--
-- Name: positions positions_name_key152; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key152 UNIQUE (name);


--
-- Name: positions positions_name_key153; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key153 UNIQUE (name);


--
-- Name: positions positions_name_key154; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key154 UNIQUE (name);


--
-- Name: positions positions_name_key155; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key155 UNIQUE (name);


--
-- Name: positions positions_name_key156; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key156 UNIQUE (name);


--
-- Name: positions positions_name_key157; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key157 UNIQUE (name);


--
-- Name: positions positions_name_key158; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key158 UNIQUE (name);


--
-- Name: positions positions_name_key159; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key159 UNIQUE (name);


--
-- Name: positions positions_name_key16; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key16 UNIQUE (name);


--
-- Name: positions positions_name_key160; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key160 UNIQUE (name);


--
-- Name: positions positions_name_key161; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key161 UNIQUE (name);


--
-- Name: positions positions_name_key162; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key162 UNIQUE (name);


--
-- Name: positions positions_name_key163; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key163 UNIQUE (name);


--
-- Name: positions positions_name_key164; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key164 UNIQUE (name);


--
-- Name: positions positions_name_key165; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key165 UNIQUE (name);


--
-- Name: positions positions_name_key166; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key166 UNIQUE (name);


--
-- Name: positions positions_name_key167; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key167 UNIQUE (name);


--
-- Name: positions positions_name_key168; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key168 UNIQUE (name);


--
-- Name: positions positions_name_key169; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key169 UNIQUE (name);


--
-- Name: positions positions_name_key17; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key17 UNIQUE (name);


--
-- Name: positions positions_name_key170; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key170 UNIQUE (name);


--
-- Name: positions positions_name_key171; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key171 UNIQUE (name);


--
-- Name: positions positions_name_key172; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key172 UNIQUE (name);


--
-- Name: positions positions_name_key173; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key173 UNIQUE (name);


--
-- Name: positions positions_name_key174; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key174 UNIQUE (name);


--
-- Name: positions positions_name_key18; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key18 UNIQUE (name);


--
-- Name: positions positions_name_key19; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key19 UNIQUE (name);


--
-- Name: positions positions_name_key2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key2 UNIQUE (name);


--
-- Name: positions positions_name_key20; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key20 UNIQUE (name);


--
-- Name: positions positions_name_key21; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key21 UNIQUE (name);


--
-- Name: positions positions_name_key22; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key22 UNIQUE (name);


--
-- Name: positions positions_name_key23; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key23 UNIQUE (name);


--
-- Name: positions positions_name_key24; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key24 UNIQUE (name);


--
-- Name: positions positions_name_key25; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key25 UNIQUE (name);


--
-- Name: positions positions_name_key26; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key26 UNIQUE (name);


--
-- Name: positions positions_name_key27; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key27 UNIQUE (name);


--
-- Name: positions positions_name_key28; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key28 UNIQUE (name);


--
-- Name: positions positions_name_key29; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key29 UNIQUE (name);


--
-- Name: positions positions_name_key3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key3 UNIQUE (name);


--
-- Name: positions positions_name_key30; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key30 UNIQUE (name);


--
-- Name: positions positions_name_key31; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key31 UNIQUE (name);


--
-- Name: positions positions_name_key32; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key32 UNIQUE (name);


--
-- Name: positions positions_name_key33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key33 UNIQUE (name);


--
-- Name: positions positions_name_key34; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key34 UNIQUE (name);


--
-- Name: positions positions_name_key35; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key35 UNIQUE (name);


--
-- Name: positions positions_name_key36; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key36 UNIQUE (name);


--
-- Name: positions positions_name_key37; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key37 UNIQUE (name);


--
-- Name: positions positions_name_key38; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key38 UNIQUE (name);


--
-- Name: positions positions_name_key39; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key39 UNIQUE (name);


--
-- Name: positions positions_name_key4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key4 UNIQUE (name);


--
-- Name: positions positions_name_key40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key40 UNIQUE (name);


--
-- Name: positions positions_name_key41; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key41 UNIQUE (name);


--
-- Name: positions positions_name_key42; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key42 UNIQUE (name);


--
-- Name: positions positions_name_key43; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key43 UNIQUE (name);


--
-- Name: positions positions_name_key44; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key44 UNIQUE (name);


--
-- Name: positions positions_name_key45; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key45 UNIQUE (name);


--
-- Name: positions positions_name_key46; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key46 UNIQUE (name);


--
-- Name: positions positions_name_key47; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key47 UNIQUE (name);


--
-- Name: positions positions_name_key48; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key48 UNIQUE (name);


--
-- Name: positions positions_name_key49; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key49 UNIQUE (name);


--
-- Name: positions positions_name_key5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key5 UNIQUE (name);


--
-- Name: positions positions_name_key50; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key50 UNIQUE (name);


--
-- Name: positions positions_name_key51; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key51 UNIQUE (name);


--
-- Name: positions positions_name_key52; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key52 UNIQUE (name);


--
-- Name: positions positions_name_key53; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key53 UNIQUE (name);


--
-- Name: positions positions_name_key54; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key54 UNIQUE (name);


--
-- Name: positions positions_name_key55; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key55 UNIQUE (name);


--
-- Name: positions positions_name_key56; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key56 UNIQUE (name);


--
-- Name: positions positions_name_key57; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key57 UNIQUE (name);


--
-- Name: positions positions_name_key58; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key58 UNIQUE (name);


--
-- Name: positions positions_name_key59; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key59 UNIQUE (name);


--
-- Name: positions positions_name_key6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key6 UNIQUE (name);


--
-- Name: positions positions_name_key60; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key60 UNIQUE (name);


--
-- Name: positions positions_name_key61; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key61 UNIQUE (name);


--
-- Name: positions positions_name_key62; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key62 UNIQUE (name);


--
-- Name: positions positions_name_key63; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key63 UNIQUE (name);


--
-- Name: positions positions_name_key64; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key64 UNIQUE (name);


--
-- Name: positions positions_name_key65; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key65 UNIQUE (name);


--
-- Name: positions positions_name_key66; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key66 UNIQUE (name);


--
-- Name: positions positions_name_key67; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key67 UNIQUE (name);


--
-- Name: positions positions_name_key68; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key68 UNIQUE (name);


--
-- Name: positions positions_name_key69; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key69 UNIQUE (name);


--
-- Name: positions positions_name_key7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key7 UNIQUE (name);


--
-- Name: positions positions_name_key70; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key70 UNIQUE (name);


--
-- Name: positions positions_name_key71; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key71 UNIQUE (name);


--
-- Name: positions positions_name_key72; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key72 UNIQUE (name);


--
-- Name: positions positions_name_key73; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key73 UNIQUE (name);


--
-- Name: positions positions_name_key74; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key74 UNIQUE (name);


--
-- Name: positions positions_name_key75; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key75 UNIQUE (name);


--
-- Name: positions positions_name_key76; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key76 UNIQUE (name);


--
-- Name: positions positions_name_key77; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key77 UNIQUE (name);


--
-- Name: positions positions_name_key78; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key78 UNIQUE (name);


--
-- Name: positions positions_name_key79; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key79 UNIQUE (name);


--
-- Name: positions positions_name_key8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key8 UNIQUE (name);


--
-- Name: positions positions_name_key80; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key80 UNIQUE (name);


--
-- Name: positions positions_name_key81; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key81 UNIQUE (name);


--
-- Name: positions positions_name_key82; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key82 UNIQUE (name);


--
-- Name: positions positions_name_key83; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key83 UNIQUE (name);


--
-- Name: positions positions_name_key84; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key84 UNIQUE (name);


--
-- Name: positions positions_name_key85; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key85 UNIQUE (name);


--
-- Name: positions positions_name_key86; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key86 UNIQUE (name);


--
-- Name: positions positions_name_key87; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key87 UNIQUE (name);


--
-- Name: positions positions_name_key88; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key88 UNIQUE (name);


--
-- Name: positions positions_name_key89; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key89 UNIQUE (name);


--
-- Name: positions positions_name_key9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key9 UNIQUE (name);


--
-- Name: positions positions_name_key90; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key90 UNIQUE (name);


--
-- Name: positions positions_name_key91; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key91 UNIQUE (name);


--
-- Name: positions positions_name_key92; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key92 UNIQUE (name);


--
-- Name: positions positions_name_key93; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key93 UNIQUE (name);


--
-- Name: positions positions_name_key94; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key94 UNIQUE (name);


--
-- Name: positions positions_name_key95; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key95 UNIQUE (name);


--
-- Name: positions positions_name_key96; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key96 UNIQUE (name);


--
-- Name: positions positions_name_key97; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key97 UNIQUE (name);


--
-- Name: positions positions_name_key98; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key98 UNIQUE (name);


--
-- Name: positions positions_name_key99; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key99 UNIQUE (name);


--
-- Name: positions positions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_pkey PRIMARY KEY (id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: shareWarnings shareWarnings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."shareWarnings"
    ADD CONSTRAINT "shareWarnings_pkey" PRIMARY KEY (id);


--
-- Name: startEndWorkTimes startEndWorkTimes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."startEndWorkTimes"
    ADD CONSTRAINT "startEndWorkTimes_pkey" PRIMARY KEY (id);


--
-- Name: subTasks subTasks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."subTasks"
    ADD CONSTRAINT "subTasks_pkey" PRIMARY KEY (id);


--
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: users users_login_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key UNIQUE (login);


--
-- Name: users users_login_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key1 UNIQUE (login);


--
-- Name: users users_login_key10; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key10 UNIQUE (login);


--
-- Name: users users_login_key100; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key100 UNIQUE (login);


--
-- Name: users users_login_key101; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key101 UNIQUE (login);


--
-- Name: users users_login_key102; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key102 UNIQUE (login);


--
-- Name: users users_login_key103; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key103 UNIQUE (login);


--
-- Name: users users_login_key104; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key104 UNIQUE (login);


--
-- Name: users users_login_key105; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key105 UNIQUE (login);


--
-- Name: users users_login_key106; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key106 UNIQUE (login);


--
-- Name: users users_login_key107; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key107 UNIQUE (login);


--
-- Name: users users_login_key108; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key108 UNIQUE (login);


--
-- Name: users users_login_key109; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key109 UNIQUE (login);


--
-- Name: users users_login_key11; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key11 UNIQUE (login);


--
-- Name: users users_login_key110; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key110 UNIQUE (login);


--
-- Name: users users_login_key111; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key111 UNIQUE (login);


--
-- Name: users users_login_key112; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key112 UNIQUE (login);


--
-- Name: users users_login_key113; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key113 UNIQUE (login);


--
-- Name: users users_login_key114; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key114 UNIQUE (login);


--
-- Name: users users_login_key115; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key115 UNIQUE (login);


--
-- Name: users users_login_key116; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key116 UNIQUE (login);


--
-- Name: users users_login_key117; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key117 UNIQUE (login);


--
-- Name: users users_login_key118; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key118 UNIQUE (login);


--
-- Name: users users_login_key119; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key119 UNIQUE (login);


--
-- Name: users users_login_key12; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key12 UNIQUE (login);


--
-- Name: users users_login_key120; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key120 UNIQUE (login);


--
-- Name: users users_login_key121; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key121 UNIQUE (login);


--
-- Name: users users_login_key122; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key122 UNIQUE (login);


--
-- Name: users users_login_key123; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key123 UNIQUE (login);


--
-- Name: users users_login_key124; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key124 UNIQUE (login);


--
-- Name: users users_login_key125; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key125 UNIQUE (login);


--
-- Name: users users_login_key126; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key126 UNIQUE (login);


--
-- Name: users users_login_key127; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key127 UNIQUE (login);


--
-- Name: users users_login_key128; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key128 UNIQUE (login);


--
-- Name: users users_login_key129; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key129 UNIQUE (login);


--
-- Name: users users_login_key13; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key13 UNIQUE (login);


--
-- Name: users users_login_key130; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key130 UNIQUE (login);


--
-- Name: users users_login_key131; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key131 UNIQUE (login);


--
-- Name: users users_login_key132; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key132 UNIQUE (login);


--
-- Name: users users_login_key133; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key133 UNIQUE (login);


--
-- Name: users users_login_key134; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key134 UNIQUE (login);


--
-- Name: users users_login_key135; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key135 UNIQUE (login);


--
-- Name: users users_login_key136; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key136 UNIQUE (login);


--
-- Name: users users_login_key137; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key137 UNIQUE (login);


--
-- Name: users users_login_key138; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key138 UNIQUE (login);


--
-- Name: users users_login_key139; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key139 UNIQUE (login);


--
-- Name: users users_login_key14; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key14 UNIQUE (login);


--
-- Name: users users_login_key140; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key140 UNIQUE (login);


--
-- Name: users users_login_key141; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key141 UNIQUE (login);


--
-- Name: users users_login_key142; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key142 UNIQUE (login);


--
-- Name: users users_login_key143; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key143 UNIQUE (login);


--
-- Name: users users_login_key144; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key144 UNIQUE (login);


--
-- Name: users users_login_key145; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key145 UNIQUE (login);


--
-- Name: users users_login_key146; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key146 UNIQUE (login);


--
-- Name: users users_login_key147; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key147 UNIQUE (login);


--
-- Name: users users_login_key148; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key148 UNIQUE (login);


--
-- Name: users users_login_key149; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key149 UNIQUE (login);


--
-- Name: users users_login_key15; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key15 UNIQUE (login);


--
-- Name: users users_login_key150; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key150 UNIQUE (login);


--
-- Name: users users_login_key151; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key151 UNIQUE (login);


--
-- Name: users users_login_key152; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key152 UNIQUE (login);


--
-- Name: users users_login_key153; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key153 UNIQUE (login);


--
-- Name: users users_login_key154; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key154 UNIQUE (login);


--
-- Name: users users_login_key155; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key155 UNIQUE (login);


--
-- Name: users users_login_key156; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key156 UNIQUE (login);


--
-- Name: users users_login_key157; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key157 UNIQUE (login);


--
-- Name: users users_login_key158; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key158 UNIQUE (login);


--
-- Name: users users_login_key159; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key159 UNIQUE (login);


--
-- Name: users users_login_key16; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key16 UNIQUE (login);


--
-- Name: users users_login_key160; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key160 UNIQUE (login);


--
-- Name: users users_login_key161; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key161 UNIQUE (login);


--
-- Name: users users_login_key162; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key162 UNIQUE (login);


--
-- Name: users users_login_key163; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key163 UNIQUE (login);


--
-- Name: users users_login_key164; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key164 UNIQUE (login);


--
-- Name: users users_login_key165; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key165 UNIQUE (login);


--
-- Name: users users_login_key166; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key166 UNIQUE (login);


--
-- Name: users users_login_key167; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key167 UNIQUE (login);


--
-- Name: users users_login_key168; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key168 UNIQUE (login);


--
-- Name: users users_login_key169; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key169 UNIQUE (login);


--
-- Name: users users_login_key17; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key17 UNIQUE (login);


--
-- Name: users users_login_key170; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key170 UNIQUE (login);


--
-- Name: users users_login_key171; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key171 UNIQUE (login);


--
-- Name: users users_login_key172; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key172 UNIQUE (login);


--
-- Name: users users_login_key173; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key173 UNIQUE (login);


--
-- Name: users users_login_key174; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key174 UNIQUE (login);


--
-- Name: users users_login_key175; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key175 UNIQUE (login);


--
-- Name: users users_login_key176; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key176 UNIQUE (login);


--
-- Name: users users_login_key177; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key177 UNIQUE (login);


--
-- Name: users users_login_key178; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key178 UNIQUE (login);


--
-- Name: users users_login_key179; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key179 UNIQUE (login);


--
-- Name: users users_login_key18; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key18 UNIQUE (login);


--
-- Name: users users_login_key180; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key180 UNIQUE (login);


--
-- Name: users users_login_key181; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key181 UNIQUE (login);


--
-- Name: users users_login_key182; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key182 UNIQUE (login);


--
-- Name: users users_login_key183; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key183 UNIQUE (login);


--
-- Name: users users_login_key184; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key184 UNIQUE (login);


--
-- Name: users users_login_key185; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key185 UNIQUE (login);


--
-- Name: users users_login_key186; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key186 UNIQUE (login);


--
-- Name: users users_login_key187; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key187 UNIQUE (login);


--
-- Name: users users_login_key188; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key188 UNIQUE (login);


--
-- Name: users users_login_key189; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key189 UNIQUE (login);


--
-- Name: users users_login_key19; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key19 UNIQUE (login);


--
-- Name: users users_login_key190; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key190 UNIQUE (login);


--
-- Name: users users_login_key191; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key191 UNIQUE (login);


--
-- Name: users users_login_key192; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key192 UNIQUE (login);


--
-- Name: users users_login_key193; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key193 UNIQUE (login);


--
-- Name: users users_login_key194; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key194 UNIQUE (login);


--
-- Name: users users_login_key195; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key195 UNIQUE (login);


--
-- Name: users users_login_key196; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key196 UNIQUE (login);


--
-- Name: users users_login_key197; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key197 UNIQUE (login);


--
-- Name: users users_login_key198; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key198 UNIQUE (login);


--
-- Name: users users_login_key199; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key199 UNIQUE (login);


--
-- Name: users users_login_key2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key2 UNIQUE (login);


--
-- Name: users users_login_key20; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key20 UNIQUE (login);


--
-- Name: users users_login_key200; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key200 UNIQUE (login);


--
-- Name: users users_login_key201; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key201 UNIQUE (login);


--
-- Name: users users_login_key202; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key202 UNIQUE (login);


--
-- Name: users users_login_key203; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key203 UNIQUE (login);


--
-- Name: users users_login_key204; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key204 UNIQUE (login);


--
-- Name: users users_login_key205; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key205 UNIQUE (login);


--
-- Name: users users_login_key206; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key206 UNIQUE (login);


--
-- Name: users users_login_key207; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key207 UNIQUE (login);


--
-- Name: users users_login_key208; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key208 UNIQUE (login);


--
-- Name: users users_login_key209; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key209 UNIQUE (login);


--
-- Name: users users_login_key21; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key21 UNIQUE (login);


--
-- Name: users users_login_key210; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key210 UNIQUE (login);


--
-- Name: users users_login_key211; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key211 UNIQUE (login);


--
-- Name: users users_login_key212; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key212 UNIQUE (login);


--
-- Name: users users_login_key213; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key213 UNIQUE (login);


--
-- Name: users users_login_key214; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key214 UNIQUE (login);


--
-- Name: users users_login_key215; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key215 UNIQUE (login);


--
-- Name: users users_login_key216; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key216 UNIQUE (login);


--
-- Name: users users_login_key217; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key217 UNIQUE (login);


--
-- Name: users users_login_key218; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key218 UNIQUE (login);


--
-- Name: users users_login_key219; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key219 UNIQUE (login);


--
-- Name: users users_login_key22; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key22 UNIQUE (login);


--
-- Name: users users_login_key220; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key220 UNIQUE (login);


--
-- Name: users users_login_key221; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key221 UNIQUE (login);


--
-- Name: users users_login_key222; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key222 UNIQUE (login);


--
-- Name: users users_login_key223; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key223 UNIQUE (login);


--
-- Name: users users_login_key224; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key224 UNIQUE (login);


--
-- Name: users users_login_key225; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key225 UNIQUE (login);


--
-- Name: users users_login_key226; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key226 UNIQUE (login);


--
-- Name: users users_login_key227; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key227 UNIQUE (login);


--
-- Name: users users_login_key228; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key228 UNIQUE (login);


--
-- Name: users users_login_key229; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key229 UNIQUE (login);


--
-- Name: users users_login_key23; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key23 UNIQUE (login);


--
-- Name: users users_login_key230; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key230 UNIQUE (login);


--
-- Name: users users_login_key231; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key231 UNIQUE (login);


--
-- Name: users users_login_key232; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key232 UNIQUE (login);


--
-- Name: users users_login_key233; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key233 UNIQUE (login);


--
-- Name: users users_login_key234; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key234 UNIQUE (login);


--
-- Name: users users_login_key235; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key235 UNIQUE (login);


--
-- Name: users users_login_key236; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key236 UNIQUE (login);


--
-- Name: users users_login_key237; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key237 UNIQUE (login);


--
-- Name: users users_login_key238; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key238 UNIQUE (login);


--
-- Name: users users_login_key239; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key239 UNIQUE (login);


--
-- Name: users users_login_key24; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key24 UNIQUE (login);


--
-- Name: users users_login_key240; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key240 UNIQUE (login);


--
-- Name: users users_login_key241; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key241 UNIQUE (login);


--
-- Name: users users_login_key242; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key242 UNIQUE (login);


--
-- Name: users users_login_key243; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key243 UNIQUE (login);


--
-- Name: users users_login_key244; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key244 UNIQUE (login);


--
-- Name: users users_login_key245; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key245 UNIQUE (login);


--
-- Name: users users_login_key246; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key246 UNIQUE (login);


--
-- Name: users users_login_key247; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key247 UNIQUE (login);


--
-- Name: users users_login_key248; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key248 UNIQUE (login);


--
-- Name: users users_login_key249; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key249 UNIQUE (login);


--
-- Name: users users_login_key25; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key25 UNIQUE (login);


--
-- Name: users users_login_key250; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key250 UNIQUE (login);


--
-- Name: users users_login_key251; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key251 UNIQUE (login);


--
-- Name: users users_login_key252; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key252 UNIQUE (login);


--
-- Name: users users_login_key253; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key253 UNIQUE (login);


--
-- Name: users users_login_key254; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key254 UNIQUE (login);


--
-- Name: users users_login_key255; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key255 UNIQUE (login);


--
-- Name: users users_login_key256; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key256 UNIQUE (login);


--
-- Name: users users_login_key257; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key257 UNIQUE (login);


--
-- Name: users users_login_key258; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key258 UNIQUE (login);


--
-- Name: users users_login_key259; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key259 UNIQUE (login);


--
-- Name: users users_login_key26; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key26 UNIQUE (login);


--
-- Name: users users_login_key260; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key260 UNIQUE (login);


--
-- Name: users users_login_key261; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key261 UNIQUE (login);


--
-- Name: users users_login_key262; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key262 UNIQUE (login);


--
-- Name: users users_login_key263; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key263 UNIQUE (login);


--
-- Name: users users_login_key264; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key264 UNIQUE (login);


--
-- Name: users users_login_key265; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key265 UNIQUE (login);


--
-- Name: users users_login_key266; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key266 UNIQUE (login);


--
-- Name: users users_login_key267; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key267 UNIQUE (login);


--
-- Name: users users_login_key268; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key268 UNIQUE (login);


--
-- Name: users users_login_key269; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key269 UNIQUE (login);


--
-- Name: users users_login_key27; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key27 UNIQUE (login);


--
-- Name: users users_login_key270; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key270 UNIQUE (login);


--
-- Name: users users_login_key271; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key271 UNIQUE (login);


--
-- Name: users users_login_key272; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key272 UNIQUE (login);


--
-- Name: users users_login_key273; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key273 UNIQUE (login);


--
-- Name: users users_login_key274; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key274 UNIQUE (login);


--
-- Name: users users_login_key275; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key275 UNIQUE (login);


--
-- Name: users users_login_key276; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key276 UNIQUE (login);


--
-- Name: users users_login_key277; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key277 UNIQUE (login);


--
-- Name: users users_login_key278; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key278 UNIQUE (login);


--
-- Name: users users_login_key279; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key279 UNIQUE (login);


--
-- Name: users users_login_key28; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key28 UNIQUE (login);


--
-- Name: users users_login_key280; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key280 UNIQUE (login);


--
-- Name: users users_login_key281; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key281 UNIQUE (login);


--
-- Name: users users_login_key282; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key282 UNIQUE (login);


--
-- Name: users users_login_key29; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key29 UNIQUE (login);


--
-- Name: users users_login_key3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key3 UNIQUE (login);


--
-- Name: users users_login_key30; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key30 UNIQUE (login);


--
-- Name: users users_login_key31; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key31 UNIQUE (login);


--
-- Name: users users_login_key32; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key32 UNIQUE (login);


--
-- Name: users users_login_key33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key33 UNIQUE (login);


--
-- Name: users users_login_key34; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key34 UNIQUE (login);


--
-- Name: users users_login_key35; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key35 UNIQUE (login);


--
-- Name: users users_login_key36; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key36 UNIQUE (login);


--
-- Name: users users_login_key37; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key37 UNIQUE (login);


--
-- Name: users users_login_key38; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key38 UNIQUE (login);


--
-- Name: users users_login_key39; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key39 UNIQUE (login);


--
-- Name: users users_login_key4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key4 UNIQUE (login);


--
-- Name: users users_login_key40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key40 UNIQUE (login);


--
-- Name: users users_login_key41; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key41 UNIQUE (login);


--
-- Name: users users_login_key42; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key42 UNIQUE (login);


--
-- Name: users users_login_key43; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key43 UNIQUE (login);


--
-- Name: users users_login_key44; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key44 UNIQUE (login);


--
-- Name: users users_login_key45; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key45 UNIQUE (login);


--
-- Name: users users_login_key46; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key46 UNIQUE (login);


--
-- Name: users users_login_key47; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key47 UNIQUE (login);


--
-- Name: users users_login_key48; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key48 UNIQUE (login);


--
-- Name: users users_login_key49; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key49 UNIQUE (login);


--
-- Name: users users_login_key5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key5 UNIQUE (login);


--
-- Name: users users_login_key50; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key50 UNIQUE (login);


--
-- Name: users users_login_key51; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key51 UNIQUE (login);


--
-- Name: users users_login_key52; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key52 UNIQUE (login);


--
-- Name: users users_login_key53; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key53 UNIQUE (login);


--
-- Name: users users_login_key54; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key54 UNIQUE (login);


--
-- Name: users users_login_key55; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key55 UNIQUE (login);


--
-- Name: users users_login_key56; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key56 UNIQUE (login);


--
-- Name: users users_login_key57; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key57 UNIQUE (login);


--
-- Name: users users_login_key58; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key58 UNIQUE (login);


--
-- Name: users users_login_key59; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key59 UNIQUE (login);


--
-- Name: users users_login_key6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key6 UNIQUE (login);


--
-- Name: users users_login_key60; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key60 UNIQUE (login);


--
-- Name: users users_login_key61; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key61 UNIQUE (login);


--
-- Name: users users_login_key62; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key62 UNIQUE (login);


--
-- Name: users users_login_key63; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key63 UNIQUE (login);


--
-- Name: users users_login_key64; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key64 UNIQUE (login);


--
-- Name: users users_login_key65; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key65 UNIQUE (login);


--
-- Name: users users_login_key66; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key66 UNIQUE (login);


--
-- Name: users users_login_key67; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key67 UNIQUE (login);


--
-- Name: users users_login_key68; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key68 UNIQUE (login);


--
-- Name: users users_login_key69; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key69 UNIQUE (login);


--
-- Name: users users_login_key7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key7 UNIQUE (login);


--
-- Name: users users_login_key70; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key70 UNIQUE (login);


--
-- Name: users users_login_key71; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key71 UNIQUE (login);


--
-- Name: users users_login_key72; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key72 UNIQUE (login);


--
-- Name: users users_login_key73; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key73 UNIQUE (login);


--
-- Name: users users_login_key74; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key74 UNIQUE (login);


--
-- Name: users users_login_key75; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key75 UNIQUE (login);


--
-- Name: users users_login_key76; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key76 UNIQUE (login);


--
-- Name: users users_login_key77; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key77 UNIQUE (login);


--
-- Name: users users_login_key78; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key78 UNIQUE (login);


--
-- Name: users users_login_key79; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key79 UNIQUE (login);


--
-- Name: users users_login_key8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key8 UNIQUE (login);


--
-- Name: users users_login_key80; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key80 UNIQUE (login);


--
-- Name: users users_login_key81; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key81 UNIQUE (login);


--
-- Name: users users_login_key82; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key82 UNIQUE (login);


--
-- Name: users users_login_key83; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key83 UNIQUE (login);


--
-- Name: users users_login_key84; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key84 UNIQUE (login);


--
-- Name: users users_login_key85; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key85 UNIQUE (login);


--
-- Name: users users_login_key86; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key86 UNIQUE (login);


--
-- Name: users users_login_key87; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key87 UNIQUE (login);


--
-- Name: users users_login_key88; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key88 UNIQUE (login);


--
-- Name: users users_login_key89; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key89 UNIQUE (login);


--
-- Name: users users_login_key9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key9 UNIQUE (login);


--
-- Name: users users_login_key90; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key90 UNIQUE (login);


--
-- Name: users users_login_key91; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key91 UNIQUE (login);


--
-- Name: users users_login_key92; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key92 UNIQUE (login);


--
-- Name: users users_login_key93; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key93 UNIQUE (login);


--
-- Name: users users_login_key94; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key94 UNIQUE (login);


--
-- Name: users users_login_key95; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key95 UNIQUE (login);


--
-- Name: users users_login_key96; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key96 UNIQUE (login);


--
-- Name: users users_login_key97; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key97 UNIQUE (login);


--
-- Name: users users_login_key98; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key98 UNIQUE (login);


--
-- Name: users users_login_key99; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key99 UNIQUE (login);


--
-- Name: users users_pass_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key UNIQUE (pass);


--
-- Name: users users_pass_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key1 UNIQUE (pass);


--
-- Name: users users_pass_key10; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key10 UNIQUE (pass);


--
-- Name: users users_pass_key100; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key100 UNIQUE (pass);


--
-- Name: users users_pass_key101; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key101 UNIQUE (pass);


--
-- Name: users users_pass_key102; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key102 UNIQUE (pass);


--
-- Name: users users_pass_key103; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key103 UNIQUE (pass);


--
-- Name: users users_pass_key104; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key104 UNIQUE (pass);


--
-- Name: users users_pass_key105; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key105 UNIQUE (pass);


--
-- Name: users users_pass_key106; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key106 UNIQUE (pass);


--
-- Name: users users_pass_key107; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key107 UNIQUE (pass);


--
-- Name: users users_pass_key108; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key108 UNIQUE (pass);


--
-- Name: users users_pass_key109; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key109 UNIQUE (pass);


--
-- Name: users users_pass_key11; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key11 UNIQUE (pass);


--
-- Name: users users_pass_key110; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key110 UNIQUE (pass);


--
-- Name: users users_pass_key111; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key111 UNIQUE (pass);


--
-- Name: users users_pass_key112; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key112 UNIQUE (pass);


--
-- Name: users users_pass_key113; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key113 UNIQUE (pass);


--
-- Name: users users_pass_key114; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key114 UNIQUE (pass);


--
-- Name: users users_pass_key115; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key115 UNIQUE (pass);


--
-- Name: users users_pass_key116; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key116 UNIQUE (pass);


--
-- Name: users users_pass_key117; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key117 UNIQUE (pass);


--
-- Name: users users_pass_key118; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key118 UNIQUE (pass);


--
-- Name: users users_pass_key119; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key119 UNIQUE (pass);


--
-- Name: users users_pass_key12; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key12 UNIQUE (pass);


--
-- Name: users users_pass_key120; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key120 UNIQUE (pass);


--
-- Name: users users_pass_key121; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key121 UNIQUE (pass);


--
-- Name: users users_pass_key122; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key122 UNIQUE (pass);


--
-- Name: users users_pass_key123; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key123 UNIQUE (pass);


--
-- Name: users users_pass_key124; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key124 UNIQUE (pass);


--
-- Name: users users_pass_key125; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key125 UNIQUE (pass);


--
-- Name: users users_pass_key126; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key126 UNIQUE (pass);


--
-- Name: users users_pass_key127; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key127 UNIQUE (pass);


--
-- Name: users users_pass_key128; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key128 UNIQUE (pass);


--
-- Name: users users_pass_key129; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key129 UNIQUE (pass);


--
-- Name: users users_pass_key13; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key13 UNIQUE (pass);


--
-- Name: users users_pass_key130; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key130 UNIQUE (pass);


--
-- Name: users users_pass_key131; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key131 UNIQUE (pass);


--
-- Name: users users_pass_key132; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key132 UNIQUE (pass);


--
-- Name: users users_pass_key133; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key133 UNIQUE (pass);


--
-- Name: users users_pass_key134; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key134 UNIQUE (pass);


--
-- Name: users users_pass_key135; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key135 UNIQUE (pass);


--
-- Name: users users_pass_key136; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key136 UNIQUE (pass);


--
-- Name: users users_pass_key137; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key137 UNIQUE (pass);


--
-- Name: users users_pass_key138; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key138 UNIQUE (pass);


--
-- Name: users users_pass_key139; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key139 UNIQUE (pass);


--
-- Name: users users_pass_key14; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key14 UNIQUE (pass);


--
-- Name: users users_pass_key140; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key140 UNIQUE (pass);


--
-- Name: users users_pass_key141; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key141 UNIQUE (pass);


--
-- Name: users users_pass_key142; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key142 UNIQUE (pass);


--
-- Name: users users_pass_key143; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key143 UNIQUE (pass);


--
-- Name: users users_pass_key144; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key144 UNIQUE (pass);


--
-- Name: users users_pass_key145; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key145 UNIQUE (pass);


--
-- Name: users users_pass_key146; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key146 UNIQUE (pass);


--
-- Name: users users_pass_key147; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key147 UNIQUE (pass);


--
-- Name: users users_pass_key148; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key148 UNIQUE (pass);


--
-- Name: users users_pass_key149; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key149 UNIQUE (pass);


--
-- Name: users users_pass_key15; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key15 UNIQUE (pass);


--
-- Name: users users_pass_key150; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key150 UNIQUE (pass);


--
-- Name: users users_pass_key151; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key151 UNIQUE (pass);


--
-- Name: users users_pass_key152; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key152 UNIQUE (pass);


--
-- Name: users users_pass_key153; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key153 UNIQUE (pass);


--
-- Name: users users_pass_key154; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key154 UNIQUE (pass);


--
-- Name: users users_pass_key155; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key155 UNIQUE (pass);


--
-- Name: users users_pass_key156; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key156 UNIQUE (pass);


--
-- Name: users users_pass_key157; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key157 UNIQUE (pass);


--
-- Name: users users_pass_key158; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key158 UNIQUE (pass);


--
-- Name: users users_pass_key159; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key159 UNIQUE (pass);


--
-- Name: users users_pass_key16; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key16 UNIQUE (pass);


--
-- Name: users users_pass_key160; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key160 UNIQUE (pass);


--
-- Name: users users_pass_key161; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key161 UNIQUE (pass);


--
-- Name: users users_pass_key162; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key162 UNIQUE (pass);


--
-- Name: users users_pass_key163; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key163 UNIQUE (pass);


--
-- Name: users users_pass_key164; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key164 UNIQUE (pass);


--
-- Name: users users_pass_key165; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key165 UNIQUE (pass);


--
-- Name: users users_pass_key166; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key166 UNIQUE (pass);


--
-- Name: users users_pass_key167; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key167 UNIQUE (pass);


--
-- Name: users users_pass_key168; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key168 UNIQUE (pass);


--
-- Name: users users_pass_key169; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key169 UNIQUE (pass);


--
-- Name: users users_pass_key17; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key17 UNIQUE (pass);


--
-- Name: users users_pass_key170; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key170 UNIQUE (pass);


--
-- Name: users users_pass_key171; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key171 UNIQUE (pass);


--
-- Name: users users_pass_key172; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key172 UNIQUE (pass);


--
-- Name: users users_pass_key173; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key173 UNIQUE (pass);


--
-- Name: users users_pass_key174; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key174 UNIQUE (pass);


--
-- Name: users users_pass_key175; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key175 UNIQUE (pass);


--
-- Name: users users_pass_key176; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key176 UNIQUE (pass);


--
-- Name: users users_pass_key177; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key177 UNIQUE (pass);


--
-- Name: users users_pass_key178; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key178 UNIQUE (pass);


--
-- Name: users users_pass_key179; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key179 UNIQUE (pass);


--
-- Name: users users_pass_key18; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key18 UNIQUE (pass);


--
-- Name: users users_pass_key180; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key180 UNIQUE (pass);


--
-- Name: users users_pass_key181; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key181 UNIQUE (pass);


--
-- Name: users users_pass_key182; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key182 UNIQUE (pass);


--
-- Name: users users_pass_key183; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key183 UNIQUE (pass);


--
-- Name: users users_pass_key184; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key184 UNIQUE (pass);


--
-- Name: users users_pass_key185; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key185 UNIQUE (pass);


--
-- Name: users users_pass_key186; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key186 UNIQUE (pass);


--
-- Name: users users_pass_key187; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key187 UNIQUE (pass);


--
-- Name: users users_pass_key188; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key188 UNIQUE (pass);


--
-- Name: users users_pass_key189; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key189 UNIQUE (pass);


--
-- Name: users users_pass_key19; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key19 UNIQUE (pass);


--
-- Name: users users_pass_key190; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key190 UNIQUE (pass);


--
-- Name: users users_pass_key191; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key191 UNIQUE (pass);


--
-- Name: users users_pass_key192; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key192 UNIQUE (pass);


--
-- Name: users users_pass_key193; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key193 UNIQUE (pass);


--
-- Name: users users_pass_key194; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key194 UNIQUE (pass);


--
-- Name: users users_pass_key195; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key195 UNIQUE (pass);


--
-- Name: users users_pass_key196; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key196 UNIQUE (pass);


--
-- Name: users users_pass_key197; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key197 UNIQUE (pass);


--
-- Name: users users_pass_key198; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key198 UNIQUE (pass);


--
-- Name: users users_pass_key199; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key199 UNIQUE (pass);


--
-- Name: users users_pass_key2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key2 UNIQUE (pass);


--
-- Name: users users_pass_key20; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key20 UNIQUE (pass);


--
-- Name: users users_pass_key200; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key200 UNIQUE (pass);


--
-- Name: users users_pass_key201; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key201 UNIQUE (pass);


--
-- Name: users users_pass_key202; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key202 UNIQUE (pass);


--
-- Name: users users_pass_key203; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key203 UNIQUE (pass);


--
-- Name: users users_pass_key204; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key204 UNIQUE (pass);


--
-- Name: users users_pass_key205; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key205 UNIQUE (pass);


--
-- Name: users users_pass_key206; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key206 UNIQUE (pass);


--
-- Name: users users_pass_key207; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key207 UNIQUE (pass);


--
-- Name: users users_pass_key208; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key208 UNIQUE (pass);


--
-- Name: users users_pass_key209; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key209 UNIQUE (pass);


--
-- Name: users users_pass_key21; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key21 UNIQUE (pass);


--
-- Name: users users_pass_key210; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key210 UNIQUE (pass);


--
-- Name: users users_pass_key211; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key211 UNIQUE (pass);


--
-- Name: users users_pass_key212; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key212 UNIQUE (pass);


--
-- Name: users users_pass_key213; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key213 UNIQUE (pass);


--
-- Name: users users_pass_key214; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key214 UNIQUE (pass);


--
-- Name: users users_pass_key215; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key215 UNIQUE (pass);


--
-- Name: users users_pass_key216; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key216 UNIQUE (pass);


--
-- Name: users users_pass_key217; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key217 UNIQUE (pass);


--
-- Name: users users_pass_key218; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key218 UNIQUE (pass);


--
-- Name: users users_pass_key219; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key219 UNIQUE (pass);


--
-- Name: users users_pass_key22; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key22 UNIQUE (pass);


--
-- Name: users users_pass_key220; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key220 UNIQUE (pass);


--
-- Name: users users_pass_key221; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key221 UNIQUE (pass);


--
-- Name: users users_pass_key222; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key222 UNIQUE (pass);


--
-- Name: users users_pass_key223; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key223 UNIQUE (pass);


--
-- Name: users users_pass_key224; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key224 UNIQUE (pass);


--
-- Name: users users_pass_key225; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key225 UNIQUE (pass);


--
-- Name: users users_pass_key226; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key226 UNIQUE (pass);


--
-- Name: users users_pass_key227; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key227 UNIQUE (pass);


--
-- Name: users users_pass_key228; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key228 UNIQUE (pass);


--
-- Name: users users_pass_key229; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key229 UNIQUE (pass);


--
-- Name: users users_pass_key23; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key23 UNIQUE (pass);


--
-- Name: users users_pass_key230; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key230 UNIQUE (pass);


--
-- Name: users users_pass_key231; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key231 UNIQUE (pass);


--
-- Name: users users_pass_key232; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key232 UNIQUE (pass);


--
-- Name: users users_pass_key233; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key233 UNIQUE (pass);


--
-- Name: users users_pass_key234; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key234 UNIQUE (pass);


--
-- Name: users users_pass_key235; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key235 UNIQUE (pass);


--
-- Name: users users_pass_key236; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key236 UNIQUE (pass);


--
-- Name: users users_pass_key237; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key237 UNIQUE (pass);


--
-- Name: users users_pass_key238; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key238 UNIQUE (pass);


--
-- Name: users users_pass_key239; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key239 UNIQUE (pass);


--
-- Name: users users_pass_key24; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key24 UNIQUE (pass);


--
-- Name: users users_pass_key240; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key240 UNIQUE (pass);


--
-- Name: users users_pass_key241; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key241 UNIQUE (pass);


--
-- Name: users users_pass_key242; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key242 UNIQUE (pass);


--
-- Name: users users_pass_key243; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key243 UNIQUE (pass);


--
-- Name: users users_pass_key244; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key244 UNIQUE (pass);


--
-- Name: users users_pass_key245; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key245 UNIQUE (pass);


--
-- Name: users users_pass_key246; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key246 UNIQUE (pass);


--
-- Name: users users_pass_key247; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key247 UNIQUE (pass);


--
-- Name: users users_pass_key248; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key248 UNIQUE (pass);


--
-- Name: users users_pass_key249; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key249 UNIQUE (pass);


--
-- Name: users users_pass_key25; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key25 UNIQUE (pass);


--
-- Name: users users_pass_key250; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key250 UNIQUE (pass);


--
-- Name: users users_pass_key251; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key251 UNIQUE (pass);


--
-- Name: users users_pass_key252; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key252 UNIQUE (pass);


--
-- Name: users users_pass_key253; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key253 UNIQUE (pass);


--
-- Name: users users_pass_key254; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key254 UNIQUE (pass);


--
-- Name: users users_pass_key255; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key255 UNIQUE (pass);


--
-- Name: users users_pass_key256; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key256 UNIQUE (pass);


--
-- Name: users users_pass_key257; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key257 UNIQUE (pass);


--
-- Name: users users_pass_key258; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key258 UNIQUE (pass);


--
-- Name: users users_pass_key259; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key259 UNIQUE (pass);


--
-- Name: users users_pass_key26; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key26 UNIQUE (pass);


--
-- Name: users users_pass_key260; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key260 UNIQUE (pass);


--
-- Name: users users_pass_key261; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key261 UNIQUE (pass);


--
-- Name: users users_pass_key262; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key262 UNIQUE (pass);


--
-- Name: users users_pass_key263; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key263 UNIQUE (pass);


--
-- Name: users users_pass_key264; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key264 UNIQUE (pass);


--
-- Name: users users_pass_key265; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key265 UNIQUE (pass);


--
-- Name: users users_pass_key266; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key266 UNIQUE (pass);


--
-- Name: users users_pass_key267; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key267 UNIQUE (pass);


--
-- Name: users users_pass_key268; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key268 UNIQUE (pass);


--
-- Name: users users_pass_key269; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key269 UNIQUE (pass);


--
-- Name: users users_pass_key27; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key27 UNIQUE (pass);


--
-- Name: users users_pass_key270; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key270 UNIQUE (pass);


--
-- Name: users users_pass_key271; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key271 UNIQUE (pass);


--
-- Name: users users_pass_key272; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key272 UNIQUE (pass);


--
-- Name: users users_pass_key273; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key273 UNIQUE (pass);


--
-- Name: users users_pass_key274; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key274 UNIQUE (pass);


--
-- Name: users users_pass_key275; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key275 UNIQUE (pass);


--
-- Name: users users_pass_key276; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key276 UNIQUE (pass);


--
-- Name: users users_pass_key277; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key277 UNIQUE (pass);


--
-- Name: users users_pass_key278; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key278 UNIQUE (pass);


--
-- Name: users users_pass_key279; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key279 UNIQUE (pass);


--
-- Name: users users_pass_key28; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key28 UNIQUE (pass);


--
-- Name: users users_pass_key280; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key280 UNIQUE (pass);


--
-- Name: users users_pass_key281; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key281 UNIQUE (pass);


--
-- Name: users users_pass_key282; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key282 UNIQUE (pass);


--
-- Name: users users_pass_key29; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key29 UNIQUE (pass);


--
-- Name: users users_pass_key3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key3 UNIQUE (pass);


--
-- Name: users users_pass_key30; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key30 UNIQUE (pass);


--
-- Name: users users_pass_key31; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key31 UNIQUE (pass);


--
-- Name: users users_pass_key32; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key32 UNIQUE (pass);


--
-- Name: users users_pass_key33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key33 UNIQUE (pass);


--
-- Name: users users_pass_key34; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key34 UNIQUE (pass);


--
-- Name: users users_pass_key35; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key35 UNIQUE (pass);


--
-- Name: users users_pass_key36; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key36 UNIQUE (pass);


--
-- Name: users users_pass_key37; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key37 UNIQUE (pass);


--
-- Name: users users_pass_key38; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key38 UNIQUE (pass);


--
-- Name: users users_pass_key39; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key39 UNIQUE (pass);


--
-- Name: users users_pass_key4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key4 UNIQUE (pass);


--
-- Name: users users_pass_key40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key40 UNIQUE (pass);


--
-- Name: users users_pass_key41; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key41 UNIQUE (pass);


--
-- Name: users users_pass_key42; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key42 UNIQUE (pass);


--
-- Name: users users_pass_key43; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key43 UNIQUE (pass);


--
-- Name: users users_pass_key44; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key44 UNIQUE (pass);


--
-- Name: users users_pass_key45; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key45 UNIQUE (pass);


--
-- Name: users users_pass_key46; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key46 UNIQUE (pass);


--
-- Name: users users_pass_key47; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key47 UNIQUE (pass);


--
-- Name: users users_pass_key48; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key48 UNIQUE (pass);


--
-- Name: users users_pass_key49; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key49 UNIQUE (pass);


--
-- Name: users users_pass_key5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key5 UNIQUE (pass);


--
-- Name: users users_pass_key50; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key50 UNIQUE (pass);


--
-- Name: users users_pass_key51; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key51 UNIQUE (pass);


--
-- Name: users users_pass_key52; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key52 UNIQUE (pass);


--
-- Name: users users_pass_key53; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key53 UNIQUE (pass);


--
-- Name: users users_pass_key54; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key54 UNIQUE (pass);


--
-- Name: users users_pass_key55; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key55 UNIQUE (pass);


--
-- Name: users users_pass_key56; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key56 UNIQUE (pass);


--
-- Name: users users_pass_key57; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key57 UNIQUE (pass);


--
-- Name: users users_pass_key58; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key58 UNIQUE (pass);


--
-- Name: users users_pass_key59; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key59 UNIQUE (pass);


--
-- Name: users users_pass_key6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key6 UNIQUE (pass);


--
-- Name: users users_pass_key60; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key60 UNIQUE (pass);


--
-- Name: users users_pass_key61; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key61 UNIQUE (pass);


--
-- Name: users users_pass_key62; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key62 UNIQUE (pass);


--
-- Name: users users_pass_key63; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key63 UNIQUE (pass);


--
-- Name: users users_pass_key64; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key64 UNIQUE (pass);


--
-- Name: users users_pass_key65; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key65 UNIQUE (pass);


--
-- Name: users users_pass_key66; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key66 UNIQUE (pass);


--
-- Name: users users_pass_key67; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key67 UNIQUE (pass);


--
-- Name: users users_pass_key68; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key68 UNIQUE (pass);


--
-- Name: users users_pass_key69; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key69 UNIQUE (pass);


--
-- Name: users users_pass_key7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key7 UNIQUE (pass);


--
-- Name: users users_pass_key70; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key70 UNIQUE (pass);


--
-- Name: users users_pass_key71; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key71 UNIQUE (pass);


--
-- Name: users users_pass_key72; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key72 UNIQUE (pass);


--
-- Name: users users_pass_key73; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key73 UNIQUE (pass);


--
-- Name: users users_pass_key74; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key74 UNIQUE (pass);


--
-- Name: users users_pass_key75; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key75 UNIQUE (pass);


--
-- Name: users users_pass_key76; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key76 UNIQUE (pass);


--
-- Name: users users_pass_key77; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key77 UNIQUE (pass);


--
-- Name: users users_pass_key78; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key78 UNIQUE (pass);


--
-- Name: users users_pass_key79; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key79 UNIQUE (pass);


--
-- Name: users users_pass_key8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key8 UNIQUE (pass);


--
-- Name: users users_pass_key80; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key80 UNIQUE (pass);


--
-- Name: users users_pass_key81; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key81 UNIQUE (pass);


--
-- Name: users users_pass_key82; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key82 UNIQUE (pass);


--
-- Name: users users_pass_key83; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key83 UNIQUE (pass);


--
-- Name: users users_pass_key84; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key84 UNIQUE (pass);


--
-- Name: users users_pass_key85; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key85 UNIQUE (pass);


--
-- Name: users users_pass_key86; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key86 UNIQUE (pass);


--
-- Name: users users_pass_key87; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key87 UNIQUE (pass);


--
-- Name: users users_pass_key88; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key88 UNIQUE (pass);


--
-- Name: users users_pass_key89; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key89 UNIQUE (pass);


--
-- Name: users users_pass_key9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key9 UNIQUE (pass);


--
-- Name: users users_pass_key90; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key90 UNIQUE (pass);


--
-- Name: users users_pass_key91; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key91 UNIQUE (pass);


--
-- Name: users users_pass_key92; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key92 UNIQUE (pass);


--
-- Name: users users_pass_key93; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key93 UNIQUE (pass);


--
-- Name: users users_pass_key94; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key94 UNIQUE (pass);


--
-- Name: users users_pass_key95; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key95 UNIQUE (pass);


--
-- Name: users users_pass_key96; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key96 UNIQUE (pass);


--
-- Name: users users_pass_key97; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key97 UNIQUE (pass);


--
-- Name: users users_pass_key98; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key98 UNIQUE (pass);


--
-- Name: users users_pass_key99; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pass_key99 UNIQUE (pass);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: warnings warnings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.warnings
    ADD CONSTRAINT warnings_pkey PRIMARY KEY (id);


--
-- Name: Absences Absences_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Absences"
    ADD CONSTRAINT "Absences_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: EmployeeRegistrationTime EmployeeRegistrationTime_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."EmployeeRegistrationTime"
    ADD CONSTRAINT "EmployeeRegistrationTime_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: UserLaborProtection UserLaborProtection_LaborProtectionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserLaborProtection"
    ADD CONSTRAINT "UserLaborProtection_LaborProtectionId_fkey" FOREIGN KEY ("LaborProtectionId") REFERENCES public."LaborProtections"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: UserLaborProtection UserLaborProtection_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserLaborProtection"
    ADD CONSTRAINT "UserLaborProtection_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: messagges messagges_chatId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messagges
    ADD CONSTRAINT "messagges_chatId_fkey" FOREIGN KEY ("chatId") REFERENCES public.chats(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: notes notes_authorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT "notes_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: notes notes_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT "notes_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: pdfDocuments pdfDocuments_documentTypeId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."pdfDocuments"
    ADD CONSTRAINT "pdfDocuments_documentTypeId_fkey" FOREIGN KEY ("documentTypeId") REFERENCES public."DocumtTypes"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: pdfDocuments pdfDocuments_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."pdfDocuments"
    ADD CONSTRAINT "pdfDocuments_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: shareWarnings shareWarnings_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."shareWarnings"
    ADD CONSTRAINT "shareWarnings_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: shareWarnings shareWarnings_warningId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."shareWarnings"
    ADD CONSTRAINT "shareWarnings_warningId_fkey" FOREIGN KEY ("warningId") REFERENCES public.warnings(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: startEndWorkTimes startEndWorkTimes_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."startEndWorkTimes"
    ADD CONSTRAINT "startEndWorkTimes_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: subTasks subTasks_taskId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."subTasks"
    ADD CONSTRAINT "subTasks_taskId_fkey" FOREIGN KEY ("taskId") REFERENCES public.tasks(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: subTasks subTasks_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."subTasks"
    ADD CONSTRAINT "subTasks_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: tasks tasks_projectId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT "tasks_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES public.projects(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: tasks tasks_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT "tasks_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: users users_positionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "users_positionId_fkey" FOREIGN KEY ("positionId") REFERENCES public.positions(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

