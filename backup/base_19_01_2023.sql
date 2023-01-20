--
-- PostgreSQL database dump
--

-- Dumped from database version 14.0
-- Dumped by pg_dump version 14.0

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
-- Name: removetoken(); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.removetoken()
    LANGUAGE sql
    AS $$
    delete from token where dateins < current_timestamp - (select duree from tokenexp);
$$;


ALTER PROCEDURE public.removetoken() OWNER TO postgres;

--
-- Name: tokenexpins(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.tokenexpins() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  delete from tokenexp;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tokenexpins() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Transaction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Transaction" (
    id integer NOT NULL,
    montant double precision DEFAULT 0 NOT NULL,
    datetransfer date DEFAULT CURRENT_DATE NOT NULL,
    enchereid integer NOT NULL,
    idrechargesend integer NOT NULL,
    idrechargereceive integer NOT NULL
);


ALTER TABLE public."Transaction" OWNER TO postgres;

--
-- Name: Transaction_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Transaction_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Transaction_id_seq" OWNER TO postgres;

--
-- Name: Transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Transaction_id_seq" OWNED BY public."Transaction".id;


--
-- Name: categorie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categorie (
    id integer NOT NULL,
    designation character varying(40)
);


ALTER TABLE public.categorie OWNER TO postgres;

--
-- Name: categorie_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categorie_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categorie_id_seq OWNER TO postgres;

--
-- Name: categorie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categorie_id_seq OWNED BY public.categorie.id;


--
-- Name: commission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.commission (
    pourcentage double precision NOT NULL
);


ALTER TABLE public.commission OWNER TO postgres;

--
-- Name: comptesysteme; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comptesysteme (
    id integer NOT NULL,
    montant double precision DEFAULT 0 NOT NULL,
    pourcentage integer DEFAULT 20 NOT NULL,
    transactionid integer NOT NULL
);


ALTER TABLE public.comptesysteme OWNER TO postgres;

--
-- Name: comptesysteme_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.comptesysteme_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comptesysteme_id_seq OWNER TO postgres;

--
-- Name: comptesysteme_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comptesysteme_id_seq OWNED BY public.comptesysteme.id;


--
-- Name: enchere; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.enchere (
    id integer NOT NULL,
    designation character varying(255),
    prixminimise double precision DEFAULT 10 NOT NULL,
    etat integer DEFAULT 0 NOT NULL,
    loginid integer NOT NULL,
    produitid integer NOT NULL,
    datedebut timestamp without time zone,
    datefin timestamp without time zone
);


ALTER TABLE public.enchere OWNER TO postgres;

--
-- Name: COLUMN enchere.etat; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.enchere.etat IS '0 en cours
50 termin‚';


--
-- Name: enchere_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.enchere_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.enchere_id_seq OWNER TO postgres;

--
-- Name: enchere_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.enchere_id_seq OWNED BY public.enchere.id;


--
-- Name: recharge; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recharge (
    id integer NOT NULL,
    montant numeric(15,2) DEFAULT 0 NOT NULL,
    etat integer,
    loginid integer NOT NULL
);


ALTER TABLE public.recharge OWNER TO postgres;

--
-- Name: COLUMN recharge.etat; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.recharge.etat IS '0 Entree
50 Sortie';


--
-- Name: entree; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.entree AS
 SELECT recharge.id,
    recharge.montant,
    recharge.etat,
    recharge.loginid
   FROM public.recharge
  WHERE (recharge.etat = 0);


ALTER TABLE public.entree OWNER TO postgres;

--
-- Name: login; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.login (
    id integer NOT NULL,
    nom character varying(50),
    prenom character varying(50),
    contact character varying(20),
    email character varying(50),
    pwd character varying(32)
);


ALTER TABLE public.login OWNER TO postgres;

--
-- Name: login_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.login_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.login_id_seq OWNER TO postgres;

--
-- Name: login_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.login_id_seq OWNED BY public.login.id;


--
-- Name: mise; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mise (
    id integer NOT NULL,
    prix double precision DEFAULT 0 NOT NULL,
    datemise timestamp without time zone,
    enchereid integer NOT NULL,
    loginid integer NOT NULL
);


ALTER TABLE public.mise OWNER TO postgres;

--
-- Name: mise_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mise_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mise_id_seq OWNER TO postgres;

--
-- Name: mise_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mise_id_seq OWNED BY public.mise.id;


--
-- Name: photo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.photo (
    id integer NOT NULL,
    designation text
);


ALTER TABLE public.photo OWNER TO postgres;

--
-- Name: photo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.photo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.photo_id_seq OWNER TO postgres;

--
-- Name: photo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.photo_id_seq OWNED BY public.photo.id;


--
-- Name: produit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.produit (
    id integer NOT NULL,
    designation character varying(40),
    description character varying(255),
    prixmin double precision DEFAULT 0 NOT NULL,
    prixmax double precision DEFAULT 0 NOT NULL,
    photoid integer NOT NULL,
    categorieid integer NOT NULL,
    loginid integer NOT NULL
);


ALTER TABLE public.produit OWNER TO postgres;

--
-- Name: produit_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.produit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.produit_id_seq OWNER TO postgres;

--
-- Name: produit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.produit_id_seq OWNED BY public.produit.id;


--
-- Name: produit_photo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.produit_photo (
    produitid integer NOT NULL,
    photoid integer NOT NULL
);


ALTER TABLE public.produit_photo OWNER TO postgres;

--
-- Name: recharge_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.recharge_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.recharge_id_seq OWNER TO postgres;

--
-- Name: recharge_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.recharge_id_seq OWNED BY public.recharge.id;


--
-- Name: sortie; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.sortie AS
 SELECT recharge.id,
    recharge.montant,
    recharge.etat,
    recharge.loginid
   FROM public.recharge
  WHERE (recharge.etat = 50);


ALTER TABLE public.sortie OWNER TO postgres;

--
-- Name: token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.token (
    id integer NOT NULL,
    dateins date NOT NULL,
    value character varying(150),
    loginid integer NOT NULL
);


ALTER TABLE public.token OWNER TO postgres;

--
-- Name: token_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.token_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.token_id_seq OWNER TO postgres;

--
-- Name: token_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.token_id_seq OWNED BY public.token.id;


--
-- Name: tokenexp; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tokenexp (
    duree time without time zone
);


ALTER TABLE public.tokenexp OWNER TO postgres;

--
-- Name: Transaction id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaction" ALTER COLUMN id SET DEFAULT nextval('public."Transaction_id_seq"'::regclass);


--
-- Name: categorie id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorie ALTER COLUMN id SET DEFAULT nextval('public.categorie_id_seq'::regclass);


--
-- Name: comptesysteme id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comptesysteme ALTER COLUMN id SET DEFAULT nextval('public.comptesysteme_id_seq'::regclass);


--
-- Name: enchere id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enchere ALTER COLUMN id SET DEFAULT nextval('public.enchere_id_seq'::regclass);


--
-- Name: login id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.login ALTER COLUMN id SET DEFAULT nextval('public.login_id_seq'::regclass);


--
-- Name: mise id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mise ALTER COLUMN id SET DEFAULT nextval('public.mise_id_seq'::regclass);


--
-- Name: photo id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.photo ALTER COLUMN id SET DEFAULT nextval('public.photo_id_seq'::regclass);


--
-- Name: produit id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produit ALTER COLUMN id SET DEFAULT nextval('public.produit_id_seq'::regclass);


--
-- Name: recharge id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recharge ALTER COLUMN id SET DEFAULT nextval('public.recharge_id_seq'::regclass);


--
-- Name: token id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token ALTER COLUMN id SET DEFAULT nextval('public.token_id_seq'::regclass);


--
-- Data for Name: Transaction; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Transaction" (id, montant, datetransfer, enchereid, idrechargesend, idrechargereceive) FROM stdin;
\.


--
-- Data for Name: categorie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categorie (id, designation) FROM stdin;
1	Categorie1
2	Categorie2
3	Categorie3
4	Categorie4
\.


--
-- Data for Name: commission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.commission (pourcentage) FROM stdin;
\.


--
-- Data for Name: comptesysteme; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comptesysteme (id, montant, pourcentage, transactionid) FROM stdin;
\.


--
-- Data for Name: enchere; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.enchere (id, designation, prixminimise, etat, loginid, produitid, datedebut, datefin) FROM stdin;
1	Vente produit1 par le premier client	100	0	1	1	2023-01-18 04:39:14	2023-01-18 06:30:00
2	Vente produit1 du dexieme client	200	0	2	1	2023-01-18 04:53:14	2023-01-18 06:47:00
3	Vente produit1 du troisieme client	150	0	3	1	2023-01-18 07:24:14	2023-01-18 08:45:00
4	Vente produit2	370	0	1	2	2023-01-18 09:01:14	2023-01-18 11:13:00
7	Vente produit14	1000	0	1	2	2023-06-18 00:00:00	2023-06-28 00:00:00
\.


--
-- Data for Name: login; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.login (id, nom, prenom, contact, email, pwd) FROM stdin;
1	Hasina	Rivonandrasana	0347460809	enchere@gmail.com	mdp
2	Hery	Naivo	0347460809	hery@gmail.com	mdp
3	Faly	Ravo	0347460809	faly@gmail.com	mdp
\.


--
-- Data for Name: mise; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mise (id, prix, datemise, enchereid, loginid) FROM stdin;
\.


--
-- Data for Name: photo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.photo (id, designation) FROM stdin;
1	photo
\.


--
-- Data for Name: produit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.produit (id, designation, description, prixmin, prixmax, photoid, categorieid, loginid) FROM stdin;
1	Produit1	Une petite description	100	500	1	1	1
2	Produit2	Une petite description	300	900	1	2	2
3	Produit3	Une petite description	1000	1900	1	3	3
4	Produit4	Une petite description	1000	1900	1	4	3
\.


--
-- Data for Name: produit_photo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.produit_photo (produitid, photoid) FROM stdin;
\.


--
-- Data for Name: recharge; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recharge (id, montant, etat, loginid) FROM stdin;
\.


--
-- Data for Name: token; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.token (id, dateins, value, loginid) FROM stdin;
\.


--
-- Data for Name: tokenexp; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tokenexp (duree) FROM stdin;
00:06:00
\.


--
-- Name: Transaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Transaction_id_seq"', 1, false);


--
-- Name: categorie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categorie_id_seq', 4, true);


--
-- Name: comptesysteme_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comptesysteme_id_seq', 1, false);


--
-- Name: enchere_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.enchere_id_seq', 7, true);


--
-- Name: login_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.login_id_seq', 3, true);


--
-- Name: mise_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mise_id_seq', 1, false);


--
-- Name: photo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.photo_id_seq', 1, true);


--
-- Name: produit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.produit_id_seq', 4, true);


--
-- Name: recharge_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.recharge_id_seq', 1, false);


--
-- Name: token_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.token_id_seq', 2, true);


--
-- Name: Transaction Transaction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT "Transaction_pkey" PRIMARY KEY (id);


--
-- Name: categorie categorie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorie
    ADD CONSTRAINT categorie_pkey PRIMARY KEY (id);


--
-- Name: comptesysteme comptesysteme_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comptesysteme
    ADD CONSTRAINT comptesysteme_pkey PRIMARY KEY (id);


--
-- Name: enchere enchere_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enchere
    ADD CONSTRAINT enchere_pkey PRIMARY KEY (id);


--
-- Name: login login_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.login
    ADD CONSTRAINT login_pkey PRIMARY KEY (id);


--
-- Name: mise mise_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mise
    ADD CONSTRAINT mise_pkey PRIMARY KEY (id);


--
-- Name: photo photo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.photo
    ADD CONSTRAINT photo_pkey PRIMARY KEY (id);


--
-- Name: produit_photo produit_photo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produit_photo
    ADD CONSTRAINT produit_photo_pkey PRIMARY KEY (produitid, photoid);


--
-- Name: produit produit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produit
    ADD CONSTRAINT produit_pkey PRIMARY KEY (id);


--
-- Name: recharge recharge_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recharge
    ADD CONSTRAINT recharge_pkey PRIMARY KEY (id);


--
-- Name: token token_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token
    ADD CONSTRAINT token_pkey PRIMARY KEY (id);


--
-- Name: tokenexp tokenexpins; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tokenexpins BEFORE INSERT ON public.tokenexp FOR EACH ROW EXECUTE FUNCTION public.tokenexpins();


--
-- Name: comptesysteme fkcomptesyst882901; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comptesysteme
    ADD CONSTRAINT fkcomptesyst882901 FOREIGN KEY (transactionid) REFERENCES public."Transaction"(id);


--
-- Name: enchere fkenchere390744; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enchere
    ADD CONSTRAINT fkenchere390744 FOREIGN KEY (produitid) REFERENCES public.produit(id);


--
-- Name: enchere fkenchere577256; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enchere
    ADD CONSTRAINT fkenchere577256 FOREIGN KEY (loginid) REFERENCES public.login(id);


--
-- Name: mise fkmise463106; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mise
    ADD CONSTRAINT fkmise463106 FOREIGN KEY (enchereid) REFERENCES public.enchere(id);


--
-- Name: mise fkmise896981; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mise
    ADD CONSTRAINT fkmise896981 FOREIGN KEY (loginid) REFERENCES public.login(id);


--
-- Name: produit fkproduit337246; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produit
    ADD CONSTRAINT fkproduit337246 FOREIGN KEY (photoid) REFERENCES public.photo(id);


--
-- Name: produit fkproduit369232; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produit
    ADD CONSTRAINT fkproduit369232 FOREIGN KEY (categorieid) REFERENCES public.categorie(id);


--
-- Name: produit fkproduit679257; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produit
    ADD CONSTRAINT fkproduit679257 FOREIGN KEY (loginid) REFERENCES public.login(id);


--
-- Name: produit_photo fkproduit_ph746396; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produit_photo
    ADD CONSTRAINT fkproduit_ph746396 FOREIGN KEY (photoid) REFERENCES public.photo(id);


--
-- Name: produit_photo fkproduit_ph794899; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produit_photo
    ADD CONSTRAINT fkproduit_ph794899 FOREIGN KEY (produitid) REFERENCES public.produit(id);


--
-- Name: recharge fkrecharge49561; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recharge
    ADD CONSTRAINT fkrecharge49561 FOREIGN KEY (loginid) REFERENCES public.login(id);


--
-- Name: token fktoken487215; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token
    ADD CONSTRAINT fktoken487215 FOREIGN KEY (loginid) REFERENCES public.login(id);


--
-- Name: Transaction fktransactio109453; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT fktransactio109453 FOREIGN KEY (idrechargesend) REFERENCES public.recharge(id);


--
-- Name: Transaction fktransactio301887; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT fktransactio301887 FOREIGN KEY (idrechargereceive) REFERENCES public.recharge(id);


--
-- Name: Transaction fktransactio714554; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT fktransactio714554 FOREIGN KEY (enchereid) REFERENCES public.enchere(id);


--
-- PostgreSQL database dump complete
--

