--
-- PostgreSQL database dump
--

-- Dumped from database version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)
-- Dumped by pg_dump version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)

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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(22) NOT NULL,
    games_played integer DEFAULT 0,
    best_game integer
);


ALTER TABLE public.users OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES (33, 'user_1790449560183', 0, NULL);
INSERT INTO public.users VALUES (34, 'user_1790449560182', 0, NULL);
INSERT INTO public.users VALUES (2, 'user_1790444555849', 2, 448);
INSERT INTO public.users VALUES (1, 'user_1790444555850', 5, 91);
INSERT INTO public.users VALUES (18, 'user_1790446687762', 2, 461);
INSERT INTO public.users VALUES (4, 'user_1790445013100', 2, 401);
INSERT INTO public.users VALUES (17, 'user_1790446687763', 5, 41);
INSERT INTO public.users VALUES (3, 'user_1790445013101', 5, 23);
INSERT INTO public.users VALUES (6, 'user_1790445183702', 2, 334);
INSERT INTO public.users VALUES (20, 'user_1790447958058', 2, 55);
INSERT INTO public.users VALUES (5, 'user_1790445183703', 5, 109);
INSERT INTO public.users VALUES (19, 'user_1790447958059', 5, 438);
INSERT INTO public.users VALUES (8, 'user_1790445403852', 2, 336);
INSERT INTO public.users VALUES (7, 'user_1790445403853', 5, 287);
INSERT INTO public.users VALUES (10, 'user_1790445440311', 2, 76);
INSERT INTO public.users VALUES (22, 'user_1790448094506', 2, 7);
INSERT INTO public.users VALUES (9, 'user_1790445440312', 5, 351);
INSERT INTO public.users VALUES (21, 'user_1790448094507', 5, 52);
INSERT INTO public.users VALUES (12, 'user_1790445816463', 2, 488);
INSERT INTO public.users VALUES (11, 'user_1790445816464', 5, 357);
INSERT INTO public.users VALUES (24, 'user_1790448182371', 2, 96);
INSERT INTO public.users VALUES (14, 'user_1790446067560', 2, 440);
INSERT INTO public.users VALUES (13, 'user_1790446067561', 5, 223);
INSERT INTO public.users VALUES (23, 'user_1790448182372', 5, 303);
INSERT INTO public.users VALUES (16, 'user_1790446241158', 2, 766);
INSERT INTO public.users VALUES (15, 'user_1790446241159', 5, 357);
INSERT INTO public.users VALUES (26, 'user_1790448638736', 2, 255);
INSERT INTO public.users VALUES (25, 'user_1790448638737', 5, 234);
INSERT INTO public.users VALUES (28, 'user_1790448733373', 2, 355);
INSERT INTO public.users VALUES (27, 'user_1790448733374', 5, 15);
INSERT INTO public.users VALUES (30, 'user_1790449036591', 2, 650);
INSERT INTO public.users VALUES (29, 'user_1790449036592', 5, 63);
INSERT INTO public.users VALUES (32, 'user_1790449243351', 2, 881);
INSERT INTO public.users VALUES (31, 'user_1790449243352', 5, 325);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.users_user_id_seq', 34, true);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- PostgreSQL database dump complete
--

