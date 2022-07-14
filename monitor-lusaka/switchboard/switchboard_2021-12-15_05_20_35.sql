--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.8
-- Dumped by pg_dump version 9.6.8

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE ONLY public.locations DROP CONSTRAINT fk_rails_fd0acb3830;
ALTER TABLE ONLY public.confederations DROP CONSTRAINT fk_rails_e011daadd8;
ALTER TABLE ONLY public.federations DROP CONSTRAINT fk_rails_b30ee0aeb4;
ALTER TABLE ONLY public.equipment DROP CONSTRAINT fk_rails_a354984e53;
ALTER TABLE ONLY public.memberships DROP CONSTRAINT fk_rails_99326fb65d;
ALTER TABLE ONLY public.locations DROP CONSTRAINT fk_rails_8f6b1eb5eb;
ALTER TABLE ONLY public.federations DROP CONSTRAINT fk_rails_7ff39eba2d;
ALTER TABLE ONLY public.locations DROP CONSTRAINT fk_rails_578138d58c;
ALTER TABLE ONLY public.realms DROP CONSTRAINT fk_rails_49cdb86653;
ALTER TABLE ONLY public.memberships DROP CONSTRAINT fk_rails_023b8c2508;
DROP INDEX public.index_users_on_reset_password_token;
DROP INDEX public.index_users_on_email;
DROP INDEX public.index_users_on_confirmation_token;
DROP INDEX public.index_realms_on_organisation_id;
DROP INDEX public.index_radius_servers_on_radiusable_type_and_radiusable_id;
DROP INDEX public.index_organisations_on_federation_id;
DROP INDEX public.index_memberships_on_user_id;
DROP INDEX public.index_memberships_on_organisation_id;
DROP INDEX public.index_locations_on_organisation_id;
DROP INDEX public.index_locations_on_contacts_id;
DROP INDEX public.index_locations_on_address_id;
DROP INDEX public.index_federations_on_operator_id;
DROP INDEX public.index_federations_on_confederation_id;
DROP INDEX public.index_equipment_on_location_id;
DROP INDEX public.index_contacts_on_contactable_type_and_contactable_id;
DROP INDEX public.index_confederations_on_operator_id;
DROP INDEX public.index_addresses_on_addressable_type_and_addressable_id;
ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
ALTER TABLE ONLY public.schema_migrations DROP CONSTRAINT schema_migrations_pkey;
ALTER TABLE ONLY public.realms DROP CONSTRAINT realms_pkey;
ALTER TABLE ONLY public.radius_servers DROP CONSTRAINT radius_servers_pkey;
ALTER TABLE ONLY public.organisations DROP CONSTRAINT organisations_pkey;
ALTER TABLE ONLY public.memberships DROP CONSTRAINT memberships_pkey;
ALTER TABLE ONLY public.locations DROP CONSTRAINT locations_pkey;
ALTER TABLE ONLY public.federations DROP CONSTRAINT federations_pkey;
ALTER TABLE ONLY public.equipment DROP CONSTRAINT equipment_pkey;
ALTER TABLE ONLY public.contacts DROP CONSTRAINT contacts_pkey;
ALTER TABLE ONLY public.confederations DROP CONSTRAINT confederations_pkey;
ALTER TABLE ONLY public.ar_internal_metadata DROP CONSTRAINT ar_internal_metadata_pkey;
ALTER TABLE ONLY public.addresses DROP CONSTRAINT addresses_pkey;
ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE public.users_id_seq;
DROP TABLE public.users;
DROP TABLE public.schema_migrations;
DROP TABLE public.realms;
DROP TABLE public.radius_servers;
DROP TABLE public.organisations;
DROP TABLE public.memberships;
DROP TABLE public.locations;
DROP TABLE public.federations;
DROP TABLE public.equipment;
DROP TABLE public.contacts;
DROP TABLE public.confederations;
DROP TABLE public.ar_internal_metadata;
DROP TABLE public.addresses;
DROP EXTENSION pgcrypto;
DROP EXTENSION plpgsql;
DROP SCHEMA public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: addresses; Type: TABLE; Schema: public; Owner: switchboarder
--

CREATE TABLE public.addresses (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    addressable_type character varying,
    addressable_id uuid,
    street character varying,
    street2 character varying,
    pobox character varying,
    city character varying,
    zip character varying,
    state character varying,
    country_code character varying(2) NOT NULL,
    latitude numeric(10,6),
    longitude numeric(10,6),
    altitude integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.addresses OWNER TO switchboarder;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: switchboarder
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO switchboarder;

--
-- Name: confederations; Type: TABLE; Schema: public; Owner: switchboarder
--

CREATE TABLE public.confederations (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    name character varying,
    operator_id uuid,
    email character varying,
    tld character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.confederations OWNER TO switchboarder;

--
-- Name: contacts; Type: TABLE; Schema: public; Owner: switchboarder
--

CREATE TABLE public.contacts (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    contactable_type character varying,
    contactable_id uuid,
    name character varying NOT NULL,
    email character varying NOT NULL,
    phone character varying NOT NULL,
    contact_type smallint DEFAULT 0 NOT NULL,
    privacy smallint DEFAULT 0 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.contacts OWNER TO switchboarder;

--
-- Name: equipment; Type: TABLE; Schema: public; Owner: switchboarder
--

CREATE TABLE public.equipment (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    name character varying NOT NULL,
    location_id uuid,
    ip4 inet,
    prefix4 integer DEFAULT 32,
    ip6 inet,
    prefix6 integer DEFAULT 128,
    mac macaddr,
    protocol character varying NOT NULL,
    upstream_secret character varying,
    monitor_secret character varying,
    switchboard_secret character varying,
    require_message_authenticator boolean DEFAULT true NOT NULL,
    nas_type character varying NOT NULL,
    nas_kind character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.equipment OWNER TO switchboarder;

--
-- Name: federations; Type: TABLE; Schema: public; Owner: switchboarder
--

CREATE TABLE public.federations (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    operator_id uuid,
    stage integer DEFAULT 1 NOT NULL,
    identifier character varying,
    tld character varying NOT NULL,
    info_url character varying NOT NULL,
    policy_url character varying NOT NULL,
    language character varying DEFAULT 'en'::character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    email character varying NOT NULL,
    confederation_id uuid
);


ALTER TABLE public.federations OWNER TO switchboarder;

--
-- Name: locations; Type: TABLE; Schema: public; Owner: switchboarder
--

CREATE TABLE public.locations (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    organisation_id uuid,
    name character varying,
    identifier uuid DEFAULT public.gen_random_uuid() NOT NULL,
    stage integer DEFAULT 1 NOT NULL,
    transmission integer DEFAULT 0 NOT NULL,
    venue_type character varying,
    ssid character varying DEFAULT 'eduroam'::character varying NOT NULL,
    address_id uuid,
    contacts_id uuid,
    wpa_mode character varying,
    encryption_mode character varying,
    ap_no integer DEFAULT 1,
    wired_no integer DEFAULT 1,
    port_restrict boolean,
    transp_proxy boolean,
    ipv6 boolean,
    nat boolean,
    hs20 boolean,
    availability integer DEFAULT 0,
    operation_hours character varying DEFAULT 'Always'::character varying,
    info_url character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.locations OWNER TO switchboarder;

--
-- Name: memberships; Type: TABLE; Schema: public; Owner: switchboarder
--

CREATE TABLE public.memberships (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    user_id bigint,
    organisation_id uuid,
    operator boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.memberships OWNER TO switchboarder;

--
-- Name: organisations; Type: TABLE; Schema: public; Owner: switchboarder
--

CREATE TABLE public.organisations (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    name character varying NOT NULL,
    federation_id uuid,
    country_code character varying(2) NOT NULL,
    identifier uuid DEFAULT public.gen_random_uuid() NOT NULL,
    eduroam_type character varying NOT NULL,
    venue_type character varying,
    stage integer DEFAULT 1 NOT NULL,
    info_url character varying NOT NULL,
    policy_url character varying NOT NULL,
    language character varying DEFAULT 'en'::character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    domain_name character varying NOT NULL
);


ALTER TABLE public.organisations OWNER TO switchboarder;

--
-- Name: radius_servers; Type: TABLE; Schema: public; Owner: switchboarder
--

CREATE TABLE public.radius_servers (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    radiusable_type character varying,
    radiusable_id uuid,
    name character varying NOT NULL,
    server_type character varying NOT NULL,
    product character varying,
    ip4 inet,
    ip6 inet,
    mac macaddr,
    protocol character varying NOT NULL,
    upstream_secret character varying,
    monitor_secret character varying,
    switchboard_secret character varying,
    require_message_authenticator boolean DEFAULT true NOT NULL,
    auth boolean DEFAULT true NOT NULL,
    acct boolean DEFAULT true NOT NULL,
    auth_port integer DEFAULT 1812 NOT NULL,
    acct_port integer DEFAULT 1813 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.radius_servers OWNER TO switchboarder;

--
-- Name: realms; Type: TABLE; Schema: public; Owner: switchboarder
--

CREATE TABLE public.realms (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    domain_name character varying,
    organisation_id uuid,
    test_user character varying,
    test_password character varying,
    generic boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    allow_subdomains boolean DEFAULT false
);


ALTER TABLE public.realms OWNER TO switchboarder;

--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: switchboarder
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO switchboarder;

--
-- Name: users; Type: TABLE; Schema: public; Owner: switchboarder
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    confirmation_token character varying,
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying,
    admin boolean DEFAULT false,
    first_name character varying NOT NULL,
    last_name character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.users OWNER TO switchboarder;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: switchboarder
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO switchboarder;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: switchboarder
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: switchboarder
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: addresses; Type: TABLE DATA; Schema: public; Owner: switchboarder
--

COPY public.addresses (id, addressable_type, addressable_id, street, street2, pobox, city, zip, state, country_code, latitude, longitude, altitude, created_at, updated_at) FROM stdin;
e99f8c5e-3ca7-489b-822b-132c4769a385	Organisation	b68aaf0c-78ad-401b-80ec-ff989e349e15	Kamuzu College of Nursing		Private Bag 1	Lilongwe			MW	-13.979112	33.785149	\N	2018-03-27 10:10:58.901986	2018-03-27 10:10:58.901986
39cff7ef-ac7d-4152-8d40-4d397431bba2	Location	22a8d18f-3404-4823-ba11-469bb838622c	Queen Elizabeth Central Hospital	College of Medicine	P.O. Box 30096, Chichiri	Blantyre			MW	-15.801860	35.015754	\N	2018-03-27 11:22:19.291311	2018-03-27 11:22:19.291311
c1e42166-b992-404a-a814-eb6dbb8e8da5	Organisation	1b86a4eb-944e-49c3-b183-0c631b1d27bc	School of Education	University of Zambia	P. O Box 32379	Lusaka			ZM	-15.387890	28.329733	\N	2018-05-17 14:41:52.161553	2018-05-17 14:41:52.161553
aa8afd74-4131-4112-a2ea-5db9c445f934	Organisation	cd8a9e52-58b9-4fcc-93ca-e53a81d50383	Ali Hassan Mwinyi Road	Kijitonyama (Sayansi ) COSTECH Building	P.O Box 95062	Dar es Salaam			TZ	-6.774542	39.241195	\N	2018-05-17 15:03:32.523234	2018-05-17 15:03:32.523234
d04a5233-f58f-4d81-916e-7642b339df65	Organisation	7d9384ac-82bf-430e-a5c6-3372970a13d0	Park of Science and Technology Maluana	Estrada N1, Km 60 		Maputo			MZ	-25.495520	32.651764	\N	2018-05-24 14:14:11.360372	2018-05-24 14:14:11.360372
12b01081-0b5f-4af2-a014-782f80094a9b	Location	f6e71221-a866-4095-99be-dc440dc499ee	Chirunga Campus			Zomba			MW	-15.385565	35.330876	\N	2018-03-27 11:25:26.352311	2018-07-23 14:22:35.319363
4cee3fbb-ac5d-45fd-98a8-892944911211	Location	8d4607fb-bc13-4fd6-bd46-128c8796b474	Off Mzimba Street		P.O. Box 2550	Lilongwe		Central Region	MW	-13.972758	33.765642	\N	2018-03-09 07:44:20.192336	2018-07-23 14:23:29.883606
f7a4581a-beaf-457f-9390-aac86b3c0ee2	Location	21cbf13c-0a9d-4b76-90e3-7028677d1dca	Mzimba Street			Lilongwe			MW	\N	\N	\N	2018-03-27 11:17:27.874959	2018-07-23 14:28:09.875743
362d284d-4cfa-4b12-bf99-dd1a0fe9769e	Location	a5c0271b-f7a5-4556-8fa3-1e7a213633bd	Porte 201 - Ministère de l’Enseignement Supérieur et de la Recherche Scientifique	Fiadanana		Antananarivo	101		MG	-18.931120	47.525121	\N	2018-07-25 08:33:20.217396	2018-07-25 08:33:20.217396
e3e98036-40cb-493d-b537-bb7dd6b28bc1	Organisation	1ae8ed07-9a09-4c42-ba70-45cefae61ac5	Rua Lauro Müller, 116			RIO DE JANEIRO	RJ - 22290-906		BR	-22.957215	-43.176186	\N	2018-08-30 14:35:42.597834	2018-08-30 14:35:42.597834
2f121598-3436-49d4-a437-03cf6aecbb75	Organisation	4f5825fb-a110-42d5-914b-3d94afd58caa	No.26 Aguiyi Ironsi Street	Maitama District	237, Garki G.P.O	Abuja		Federal Capital Territory 	NG	9.081454	7.490543	\N	2018-10-30 10:13:30.770835	2018-10-30 10:13:30.770835
1633977f-a1ba-4462-92a1-0a6e8cd1133f	Organisation	34857f08-b57a-42dc-bd2c-a418315f4631	Faravohitra			Antananarivo	101		MG	-18.909749	47.530918	\N	2018-11-20 13:06:17.120285	2018-11-20 13:06:17.120285
5374e4a7-bddb-4947-872b-da28ee18b736	Organisation	8d2a33be-7230-4c87-b6a3-499b4e18bf63	Avenue de l'UNESCO #1		1550	BUJUMBURA		BUJUMBURA	BI	-3.382237	29.381793	\N	2018-11-22 09:22:21.873332	2018-11-22 09:22:21.873332
f5185825-093f-4873-b094-7fac4b9c29bb	Organisation	c0457fb7-fc36-4bac-8e6d-019c5d716cd6	Solwezi Road			Solwezi		North Western	ZM	-12.166871	26.383977	\N	2018-11-26 10:26:49.879343	2018-11-26 10:26:49.879343
e6edd2fb-b63a-4ce1-a653-67bf3be670b0	Organisation	b7a4f25d-aa72-4812-a1dd-a563d26ba979	c/o UFHB			Abidjan			CI	5.347050	-3.985292	\N	2018-12-06 07:03:52.259733	2018-12-06 07:03:52.259733
6d40e280-0893-4b62-82fe-ea7835041600	Organisation	7ccfcd5c-da2a-44d2-acff-f7a51ec5b199	Peter Okebukola Building	26, Aguiyi Ironsi Street		Abuja			NG	9.081131	7.488921	\N	2018-08-27 09:04:44.62192	2018-12-06 07:19:09.575932
43792108-71c6-421f-8118-222d98bf4abb	Organisation	9b0f1760-1df5-4e5e-8118-a6cef51cf832	Great North Road		32379	Lusaka		Lusaka	ZM	-15.379471	28.279051	\N	2018-11-20 12:55:33.983526	2018-12-14 07:29:30.848534
96e7853e-8a74-4aca-b725-14aabecf3269	Organisation	408c3c2c-19cf-472e-82e4-9650641ede23	Great North Road			Kabwe		Central Province	ZM	-14.295009	28.559767	\N	2018-12-14 07:41:22.578253	2018-12-14 10:57:50.497687
68485898-84d3-4b57-b58c-696274baf832	Organisation	94cf650e-540c-4d89-9f69-8891719fb5b5	11b Taiye Olowu Street	Off Victoria Arobieke Street		Lekki 		Lagos	NG	6.445632	3.473721	\N	2019-02-01 04:35:09.053454	2019-02-01 04:35:09.053454
9a402f68-ae05-4906-8af4-acd595bc32e3	Location	24d2c3c3-f970-4b6d-82a1-90d24301fb2d	Kijitonyama			Dar es Salaam		Dar es Salaam	CG	\N	\N	\N	2019-03-18 08:32:27.652295	2019-03-18 08:32:27.652295
0b8bdfcc-f746-4721-bc69-7f4543e57d2d	Organisation	c6235a8c-9c92-43e5-b246-8e46132f22f6	African University House, 	Trinity Avenue		Accra			GH	5.646337	-0.170120	\N	2019-03-27 10:37:47.858178	2019-03-27 10:37:47.858178
c6c393e7-05a8-4fdc-a347-c9f98148950a	Organisation	f897a4d3-44ca-4543-82aa-b4e502c6463e	\t930001 Jos.			Jos	930	Plateau State	NG	9.947456	8.889120	\N	2019-04-01 13:32:57.754223	2019-04-01 13:32:57.754223
bd3aee5e-31ff-40b2-a7b0-021ed55c9898	Organisation	6f4462ad-1f14-4e25-be5e-88cf2e42cec1	Along Enugu-Onitsha Expressway Ifite Awka 		5025	Awka	420110	Anambra	NG	6.243716	7.121873	\N	2019-04-02 11:45:03.072943	2019-04-02 11:45:03.072943
817b9465-2fe3-49bb-a9fa-7c7dc5fb1f9a	Organisation	96f247af-06f8-4c6a-b325-71f89fd65bd5	KM 10 Idiroko Rd			Ota		Ogun	NG	6.672645	3.161213	\N	2019-03-15 11:49:04.457992	2019-04-03 14:46:51.788247
1adfe01a-6699-44f2-bd19-6baa89d27b2a	Organisation	d785f154-2f0a-4055-be46-e44862c54a67	Université de Ségou			Segou			ML	13.427183	-6.275017	\N	2019-07-31 14:04:29.995584	2019-07-31 14:04:29.995584
e2f62290-4549-464a-b7c5-2b5a8b7ff827	Location	2c66a0f0-2d5f-4510-acd1-d02365e7c0d7	Diamond Bank ICT Centre, Canaanland, Ota			Ota	112233	Ogun	NG	6.672600	3.161200	\N	2019-04-04 11:13:03.130634	2019-04-04 11:24:38.194097
45b1f4fc-9c80-4d6a-ae92-16c17c9726af	Location	cd5cd203-33cd-4d81-8057-d7f8b5aaf520	Along Enugu-Onitsha Expressway Ifite		5025	Awka	420110	Anambra	NG	6.243716	7.121873	\N	2019-04-04 13:11:48.634953	2019-04-04 13:12:28.500998
fccdb354-d87d-4b0e-944c-929792bf8474	Organisation	d732f8b8-d167-4dac-b175-724f7188be6a	Dundaye Area, Wamakko			Wamakko		Sokoto	NG	\N	\N	\N	2019-04-04 15:49:54.84375	2019-04-04 15:49:54.84375
192d5ca3-b5bf-497c-b6e5-e45763a16c68	Location	35858a1c-23b2-40f6-8ef1-b47f8efa3010	Dundaye Area, Wamakko 	Permanent Site	2346	Sokoto		Sokoto	NG	\N	\N	\N	2019-04-04 16:00:47.939643	2019-04-04 16:00:47.939643
16a19e57-81ba-4800-9f8d-4c07b2945b04	Organisation	9b15ed64-9965-4b8d-8857-98844f2a5e14	University of Lagos, Akoka Rd, Yaba, Lagos			Yaba	100001	Lagos	NG	\N	\N	\N	2019-04-18 11:13:23.737219	2019-04-18 11:13:23.737219
47cced45-d13d-4f56-a630-dff7cb612b1c	Location	7e6eba79-62c3-4720-93f3-416ea7b363d9	Unilag datacenter, 4th floor senate building			Akoka,Yaba	+23401	Lagos	NG	\N	\N	\N	2019-04-18 11:24:18.581936	2019-04-18 11:24:18.581936
a371fb46-9af2-4645-9321-0bb522eb13b4	Organisation	991db693-847f-4626-ab05-c4bafd190f92	Ali Hassan Mwinyi Road, Kijitonyama (Sayansi ) COSTECH Building		P.O. Box 4302	Dar es Salaam		Dar es Salaam	TZ	-6.781538	39.274815	\N	2019-05-03 10:39:44.95396	2019-05-03 10:39:44.95396
45f2fa2f-cb41-4243-8a24-2f24be7bd7cd	Location	58b87f31-d441-4e66-a8b1-2aba9e59e38a	Ali Hassan Mwinyi Road, Kijitonyama (Sayansi ) COSTECH Building		P.O. Box 4302	Dar es Salaam		Dar es Salaam	TZ	-6.781538	39.274815	\N	2019-05-03 13:02:30.127191	2019-05-03 13:02:30.127191
0095ea81-cc53-4217-8b77-921fde82c3ee	Organisation	2bf8127f-b5fa-4f92-a65c-fce09f50114c	Queen Elizabeth Central Hospital	College of Medicine	P.O. Box 30096, Chichiri	Blantyre			MW	35.015754	-15.801860	\N	2018-03-27 10:03:33.624865	2021-03-10 04:19:34.293071
2525212a-6023-4f9c-846d-79d25495321d	Organisation	679f67b6-cf16-4c36-a887-77c06fb2d05b	chambe street		210A	Mulanje		Southern	ME	\N	\N	\N	2019-05-15 14:56:47.192846	2019-05-15 14:56:47.192846
dd9a3f3d-962d-4bb2-9b3f-f3b7a5a9ae87	Organisation	b6c4ac4f-b841-48cc-9468-cd3a3e913fa7	chambe street		A211	Mulanje	Q	Southern	MW	\N	\N	\N	2019-05-17 08:05:24.798302	2019-05-17 08:05:24.798302
95f87e1a-69b7-4070-b67b-bc125de763fc	Location	baa295b2-d252-4134-ac20-445623abc2a9	11B Taiye Olowu Street	Lekki Phase 1		Lagos	100001	Lagos	NG	6.445632	3.473721	\N	2019-04-04 06:44:03.6436	2019-07-08 17:13:08.65007
5f118bee-13de-4cfc-8668-c27060828b00	Organisation	5b033895-13ed-43b3-a21a-62fdb56e38d4	UG			Accra			GH	5.650562	-0.196224	\N	2019-08-04 19:53:25.362343	2019-08-04 19:53:25.362343
5c687fa4-a65a-4d45-97a9-939eb9fab170	Organisation	0a67d914-b70f-4970-ad77-6b8caf423852	Ministry of Science and Higher Education			Addis Ababa			ET	9.032616	38.762953	\N	2018-07-24 15:33:55.195461	2020-11-21 12:41:19.891345
10c16f3e-c21b-42ba-ba8d-b200f0ebb8ca	Organisation	6461d70e-ebf3-4502-8125-6a4623ec2a9a	Chirunga		P.O Box 280	Zomba			MW	35.330876	-15.385565	\N	2018-03-13 22:45:28.389957	2021-03-10 04:18:18.977406
f27b4249-4799-4b47-b047-51d1f99546c7	Organisation	fad269fb-c5f3-4ab2-b7ce-2d5158df531a	Andraharo	Bât. SIRIUS – Zone Galaxy		Antananarivo	101		MG	\N	\N	\N	2019-01-03 05:37:21.586173	2021-04-15 05:04:38.56326
53f290de-5165-4377-b1e3-fe808bd5edb5	Organisation	1786272a-a169-4b8c-b7fa-9f47905733fc	College of Medicine		Private Bag 360, Chichiri	Blantyre	3		MW	35.015754	-15.801860	\N	2018-03-27 10:54:34.726655	2021-03-10 04:18:54.835347
0b89a994-4ed1-40b8-88de-56fcc86ad4f6	Organisation	911a5df1-70bb-43a6-99c3-9138271109ed	Mzimba Street	Onions Office Complex	P.O. Box 2550	Lilongwe		Central Region	MW	33.592394	-11.899183	\N	2018-01-10 15:30:52.309368	2021-03-10 04:19:15.477306
d69686a2-688b-410b-a99f-8bde1779d6e7	Organisation	ba395f36-ef32-4db2-8042-0f23c6fccbcb	Porte 201 - Ministère de l’Enseignement Supérieur et de la Recherche Scientifique	Fiadanana		Antananarivo	101		MG	-18.931059	47.525126	\N	2018-07-24 15:13:52.608966	2021-04-15 05:19:58.132173
5b7f703f-7089-48b3-9fe7-f0c456eef28a	Organisation	c6a1da0a-512f-477d-ad3b-4ed3f2cba737	Faravohitra			Antananarivo	101		MG	-18.904398	47.529030	\N	2018-11-20 13:04:17.507562	2021-04-15 05:18:58.408856
6ab15a29-f867-4467-96ac-adb60a5023cd	Location	535c9734-1017-4b44-9067-4fa6c61b5334	Accra Rd, Kumasi		PMB	Kumasi		Ashanti	GH	6.698790	-1.537912	\N	2019-08-06 07:30:48.395419	2019-08-06 07:30:48.395419
3709ac03-f560-4074-94da-20798d2bb1c0	Organisation	720b4990-7e36-4d61-83b5-09d2d0c46889	University of Ghana Computing System		LG25	Accra			GH	5.650562	-0.196224	\N	2019-08-04 21:01:25.868934	2019-08-06 07:45:24.20984
309a87a4-5ff0-46d4-8970-ff61bd66971b	Location	7244f5ab-baad-47f0-9207-df980e1ca91e	University of Ghana Computing System		LG25	Accra			GH	5.641382	-0.186052	\N	2019-08-04 21:07:28.326078	2019-08-06 15:06:20.888387
818c4fc0-78da-42d6-8c03-3d6b24225d25	Location	7be519c0-6bce-44a6-bc4b-730933c5b0a8	University of Ghana Computing Systems		LG 25	Accra			GH	5.652014	-0.187056	\N	2019-08-05 10:33:46.539816	2019-08-06 15:10:12.259007
9cd748bc-103d-48d8-b5ce-f0a84a09871d	Location	c81c1343-38e1-44b7-a4e2-c7bee9181edf	Earth-Science		LG25	Accra			GH	5.650962	-0.184244	\N	2019-08-06 15:04:58.638115	2019-08-09 09:10:14.518087
b9ccb196-8a02-42bb-95bc-5c01739a0bec	Location	d8f2a3a7-09ba-4f9a-b3f3-0f4bedc63fcd	Biochem		LG25	Accra			GH	5.654797	-0.189474	\N	2019-08-06 15:00:12.75445	2019-08-09 09:16:35.722361
74221890-597e-4c68-bebf-e7a18c509e82	Location	7ee138f9-5af1-46ac-90cb-2113cd252d17	IAS		LG25	Accra		Greater-Accra	GH	5.650220	-0.181105	\N	2019-08-07 08:46:00.983565	2019-08-07 08:46:00.983565
c630f4c3-24c3-4982-8de4-caaebfaa9af2	Location	470853fd-52ca-479b-b2d3-be619f9a18ed	Agric		LG25	Accra			GH	5.650139	-0.183829	\N	2019-08-06 14:49:30.0457	2019-08-07 15:31:13.449939
55eb0bdc-c674-4f62-8c01-54737c17b3b0	Location	2d85be45-66fc-40ea-bf9e-88b387ad6422	Sarbah-Hall		LG25	Accra		Greater-Accra	GH	5.645280	-0.187059	\N	2019-08-07 09:34:04.179731	2019-08-07 16:10:48.549426
e5bf39ca-c7ca-4043-9e5b-e9aa75b65c3c	Location	8c676cfb-f2f3-4ea3-8e92-3e481ea1e778	Commonwealth-Hall		LG25	Accra			GH	5.651310	-0.192643	\N	2019-08-06 15:04:57.073062	2019-08-07 15:44:08.924265
9290a2c9-ed38-4c62-a63a-6aa31daef57e	Location	5ea787c1-230b-4b10-8a96-e1daedbb015a	Grad_Sch		LG25	Accra		Greater-Accra	GH	5.653370	-0.190666	\N	2019-08-06 15:50:07.240971	2019-08-07 15:46:28.535855
486fffc7-76c9-4e12-903f-040f974f7843	Location	8924369e-94b1-4f7d-8ecd-823396fa3468	Legon Hall		LG25	Accra		Greater-Accra	GH	5.650311	-0.188477	\N	2019-08-06 16:52:03.657772	2019-08-07 15:49:17.080542
a9ad5a64-2f57-4a6f-9a8e-20a09467bdbc	Location	2712dc28-b453-44de-99bd-adaf85c59081	Akuafo-Hall		LG25	Accra			GH	5.650299	-0.185762	\N	2019-08-06 14:58:06.522476	2019-08-07 16:02:39.262611
4a63767d-ff1f-460a-91e9-c0e36d4b795c	Location	4f34c792-05ae-48b5-a2e4-8aa7b21d2443	Jubilee		LG25	Accra		Greater-Accra	GH	5.640011	-0.185981	\N	2019-08-06 16:11:58.179483	2019-08-07 16:50:42.151627
e21fa9f4-3cbb-4a0d-aa8d-6e198b84956e	Location	1a5c8784-c197-481a-b081-af89176bfdc0	Guest Centre, University of Ghana		LG25	Accra			GH	5.644914	-0.189450	\N	2019-08-05 22:17:15.129958	2019-08-08 14:54:31.79881
d9623d25-be34-4b58-843a-f26b11fc6ccc	Location	4a589fb5-6538-49de-932c-c9bd1ec02371	University Hospital		LG25	Accra			GH	5.651663	-0.178509	\N	2019-08-06 13:02:56.000504	2019-08-08 14:56:18.326165
80e59409-4fdb-4506-a18c-5757e18152c9	Location	e99acd89-9982-47de-b1fd-e24bf006721a	Alumni Office		LG25	Accra		Greater-Accra	GH	5.642446	-0.184876	\N	2019-08-07 10:23:55.770711	2019-08-08 15:02:09.247318
1437da09-54a9-41a7-bf85-0f5b1779ea9c	Location	1e977911-197d-4a6a-b78c-d2d4208539ed	SPH		LG25	Accra		Greater-Accra	GH	5.636908	-0.182579	\N	2019-08-07 10:21:09.354619	2019-08-08 14:59:58.207173
9d7b28eb-11d2-4853-b205-bfe7c6c983d2	Location	c496b833-d462-4d21-bf0b-d9dce167be62	kwapong -Hall		LG25	Accra		Greater-Accra	GH	5.636395	-0.185135	\N	2019-08-06 16:43:35.230613	2019-08-08 15:06:45.943295
111567de-6e2b-4f50-ad15-576382ff214f	Location	81651cf9-2308-4db2-83e6-1eeb328f1813	Frances_Sey		LG25	Accra		Greater-Accra	GH	5.635498	-0.186763	\N	2019-08-06 15:46:11.11469	2019-08-08 15:08:37.290427
1e55ed17-3115-42ea-a3dc-cc8f21e2a065	Location	72a90642-1df4-4099-88ac-7f0c5701d202	Jean-Nelson		LG25	Accra		Greater-Accra	GH	5.634843	-0.187895	\N	2019-08-06 16:30:35.302906	2019-08-08 15:10:41.265139
e773df91-c86c-444b-937a-a5dca5a8d8be	Location	40231793-3519-41aa-a01b-6bfa94390118	Registry		LG25	Accra		Greater-Accra	GH	5.650598	-0.195291	\N	2019-08-07 09:27:33.288208	2019-08-08 15:15:42.941391
29587776-ea46-452a-926c-ab938484b39c	Location	c17fc053-1f50-4940-9fc3-2975991326e8	Geog		LG25	Accra		Greater-Accra	GH	5.651076	-0.182582	\N	2019-08-06 15:48:20.481523	2019-08-08 15:17:02.547674
e6efa7d7-8ea4-40f1-a90a-ae6b9aa69da5	Location	98192fb7-578b-4e9a-a3a8-9613fc7b856f	Climate-change		LG25	Accra			GH	5.656580	-0.188010	\N	2019-08-06 15:03:13.372751	2019-08-08 15:20:15.061231
60d56be9-020e-4356-bc9a-79099079ac9e	Location	f189cf9e-c062-4288-9120-99f6e741f0b5	Faculty-of-Science		LG25	Accra		Greater-Accra	GH	5.655036	-0.189491	\N	2019-08-06 15:38:07.881041	2019-08-08 15:17:51.616998
356f9456-1791-47ea-9f88-6cebe872b7f6	Location	9164f2f5-30e1-46b0-a40b-d630d44bdc2b	SCDE		LG25	Accra		Greater-Accra	GH	5.651630	-0.181039	\N	2019-08-06 15:52:32.707457	2019-08-08 15:33:49.339726
7123383a-63b2-4878-8800-78aa698163cd	Location	fe0c19b7-e4cc-4ed9-9da2-b17d6f1e1abd	Pentagon		LG25	Accra		Greater-Accra	GH	5.656325	-0.181809	\N	2019-08-07 09:07:58.676329	2019-08-08 15:28:52.713026
747ae76f-3e6b-40e1-b1cb-5e113cc72b94	Location	23d0e5bc-dea5-4bd6-9375-7b33403e4f10	IPO		LG25	Accra		Greater-Accra	GH	5.653458	-0.181998	\N	2019-08-06 16:08:27.10682	2019-08-09 08:16:55.505784
c4590da3-8aa4-4409-a8f4-7b9e04c3b451	Location	de281323-cdf2-4098-94c4-76fbcee9cb07	Accra city campus		PMB, University Post Office	Kwabenya		Greater Accra	GH	5.605353	-0.268671	\N	2019-08-06 15:08:33.117459	2020-09-22 07:52:37.718569
cfe5d75c-aaff-496e-9c18-db0248af742f	Location	d2a132df-784c-468c-b006-a0965d0e8a16	Law		LG25	Accra		Greater-Accra	GH	5.652995	-0.181507	\N	2019-08-06 16:45:27.179321	2019-08-09 08:22:52.917437
923ab572-d2cc-4e09-8bb9-4303969688a4	Location	281b8570-0af5-47e5-8850-72650e9bb34b	Kwame Nkrumah University of Science and Technology		PMB	Kumasi		Ashanti	GH	6.683259	-1.576190	\N	2019-08-06 15:15:24.67043	2019-08-09 17:12:33.094624
ec114c8e-94c8-476a-91e5-23463d0acab9	Location	cd4a2e76-7c0c-467c-b72f-479de882224a	JQB		LG25	Accra		Greater-Accra	GH	5.652461	-0.181844	\N	2019-08-06 16:32:37.841505	2019-08-09 08:27:48.045461
491bd2d9-f41d-4d6c-a355-79ff6439eb7b	Location	1d1038e1-0d0a-4027-ad84-ca3856ad6998	NOC		LG25	Accra		Greater-Accra	GH	5.651341	-0.186411	\N	2019-08-07 08:53:39.814308	2019-08-09 08:35:45.247335
f9a01b52-4b51-49d9-a120-2bbbfcee2b4f	Organisation	983c15ee-9a50-4725-bfc0-9e2067ec14fa	Kwame Nkrumah University Of Science & Technology		PMB, University Post Office	Kumasi			GH	6.674688	-1.571728	\N	2019-08-06 06:36:07.325322	2019-08-09 08:40:36.689511
215d3868-e167-42e6-b7a8-b2f62f8196dc	Location	a81bdaf1-b144-499c-9f92-3232450f8692	SRC-Student-Clinic		LG25	Accra		Greater-Accra	GH	5.646860	-0.187505	\N	2019-08-07 10:32:51.79588	2019-08-09 08:41:24.825864
98ff247a-e8d1-4dfc-a93f-509d9b601976	Location	ac99ea85-6eab-49ce-8b75-c2d254ee64f0	New UGBS		LG25	Accra		Greater-Accra	GH	5.653073	-0.188026	\N	2019-08-07 08:49:06.562061	2019-08-09 08:57:06.160496
4ff1a869-4de4-4f7a-982d-955b8385d858	Location	1c1638bb-9a7d-49c8-9d87-d9278469920b	Pharmacy		LG25	Accra		Greater-Accra	GH	5.653921	-0.189214	\N	2019-08-07 09:13:45.690834	2019-08-09 09:03:13.300981
0091812a-a1ae-4120-86a0-3e370e69c0e4	Location	57b67154-f678-4704-9f0e-ca8350a04f8b	PHYS-CHEM		LG25	Accra		Greater-Accra	GH	5.652961	-0.185569	\N	2019-08-07 09:24:27.173113	2019-08-09 09:06:37.616516
d8648aa6-a56c-45c1-9d34-39df76a33bf3	Location	bf722ab4-b455-4b11-8e7d-e8c055f3c6bc	Math		LG25	Accra		Greater-Accra	GH	5.653857	-0.184474	\N	2019-08-06 17:03:05.058043	2019-08-09 09:08:46.775191
d1d69eef-1ad0-46bb-b345-055784bea84a	Location	c63419fb-7df2-4118-b967-1ff3ebed7a6f	English		LG25	Accra			GH	5.650348	-0.189690	\N	2019-08-06 15:04:53.177583	2019-08-09 09:12:01.373859
16d7de0b-c6de-4d0b-adc0-b129382ada45	Location	17f46ece-0ba6-457d-85ba-09dc37a4c4b0	Arts		LG25	Accra			GH	5.653051	-0.181226	\N	2019-08-06 14:53:16.562118	2019-08-09 09:23:33.167437
927daafa-4c3f-4f13-936a-15f0a3374a65	Location	c0a880ec-d563-4189-9be8-fdc968e804df	SPA		LG25	Accra		Greater-Accra	GH	5.649863	-0.181053	\N	2019-08-07 10:04:04.372627	2019-08-09 09:25:07.219584
eb4cf080-f7d4-477d-92ab-b65bd9063e7e	Location	08d96490-cee3-42fe-a312-0227cc8e1dbe	Religion		LG25	Accra		Greater-Accra	GH	5.650972	-0.188554	\N	2019-08-07 09:29:00.349368	2019-08-09 09:28:56.288902
b9fa32ed-d126-47e8-b86b-d460e9889856	Location	ccc7f73e-4a81-464e-8a93-757ccc450cad	Atomic		LG25	Accra		Greater-Accra	GH	5.667216	-0.230634	\N	2019-08-07 09:53:13.217619	2019-08-09 09:35:27.438406
b8859f76-868e-4fdd-97d4-fafc4d8dbaf6	Location	544bb5df-170f-48d8-8e0c-dd95955facd7	Social Studies		LG25	Accra		Greater-Accra	GH	5.655053	-0.187288	\N	2019-08-07 10:01:47.071759	2019-08-09 09:37:23.284683
9561e567-34a7-4df5-8e19-8feea4b878a6	Location	3ecc6c9c-30e1-42a4-a2d4-df69fd0b5e13	SCS-Annex		LG25	Accra		Greater-Accra	GH	5.652401	-0.181199	\N	2019-08-07 09:51:53.977329	2019-08-09 09:39:55.185439
0fceb425-cf50-466d-b37c-11cc3073dc1f	Location	3ea64816-b223-4b6c-a785-e836010f0b83	Wetland		LG25	Accra			GH	5.654083	-0.187398	\N	2019-08-06 15:01:24.033828	2019-08-09 09:42:07.266829
b0441208-9be3-401b-8946-3443123c4a52	Location	fdc2173c-a570-4d34-9f85-fed256350901	Kpong		LG25	Accra		Greater-Accra	GH	6.027863	-0.085659	\N	2019-08-06 16:39:35.790761	2019-08-09 16:34:35.475928
a3409956-b6fc-4a1e-8d37-0841e1a2106a	Location	9c6e6b33-c255-438d-80aa-6cf0f3d790f8	Nungua		LG25	Accra		Greater-Accra	GH	5.661922	-0.081927	\N	2019-08-07 08:59:29.130864	2019-08-09 16:42:13.119732
ea17d031-067d-47ab-8285-8c0300a93c78	Location	64d33e90-4154-4366-a482-00b844ee7799	Residence		LG25	Accra		Greater-Accra	GH	5.647811	-0.191929	\N	2019-08-07 09:30:20.630189	2019-08-09 16:43:51.390031
e9ceb036-0eaa-4509-8fd6-59258f030765	Location	1e5823f8-96db-4f06-a06e-0e6bbb4c9349	PDMSD		LG25	Accra		Greater-Accra	GH	5.647705	-0.181992	\N	2019-08-07 09:03:02.941733	2019-08-07 16:05:51.705499
49dafc80-dd35-44c1-9585-8cc5186e998e	Location	a0f66bdc-c12d-47d7-81db-2ab25f2e1282	Liman_Hall		LG25	Accra		Greater-Accra	GH	5.637019	-0.184120	\N	2019-08-06 16:55:29.213512	2019-08-08 15:04:53.598234
611363fd-4a61-4e02-b565-8cff022d48db	Location	da8335fd-5f85-4305-b5dc-576125731eba	ugcs		LG25	Accra		Greater-Accra	GH	5.652160	-0.188045	\N	2019-08-07 10:37:45.746392	2019-08-08 15:19:14.781791
62e981ed-1c03-45a7-8525-a06a4444901c	Location	f779763a-c926-4b2e-a7c0-48b77fcb9a9d	Veterinary		LG25	Accra		Greater-Accra	GH	5.666420	-0.185698	\N	2019-08-07 11:21:50.794855	2019-08-08 15:24:16.29273
8027c4f7-61a8-4169-ae5e-ad1b66314155	Location	7a535503-e260-4304-b6b5-cd28471b7831	ISSER		LG25	Accra		Greater-Accra	GH	5.655455	-0.184356	\N	2019-08-06 16:20:12.598928	2019-08-08 15:26:49.319374
f805d15e-4333-4fc8-a4f0-e165e10fa9f3	Location	a5d32ba3-9631-441f-913b-8f99b58c8aa6	WACCI		LG25	Accra		Greater-Accra	GH	5.649033	-0.184169	\N	2019-08-07 11:32:16.871452	2019-08-08 15:31:24.795306
a0539f79-08ed-4598-a3b2-71ed5a3c074e	Location	55e8405c-96af-4004-b7cb-d3c3eb0d3eae	Conf_Wkshop		LG25	Accra			GH	5.655455	-0.184356	\N	2019-08-06 15:04:54.663058	2019-08-09 08:12:48.531697
dd3d1602-56b0-46e1-b464-fce8077e5da6	Organisation	1e4bdaed-2062-439e-8ef3-593bdb2c4701	1 University Avenue	Berekuso, E/R	PMB CT3, 	Accra			GH	5.759771	-0.219740	\N	2019-08-07 15:27:39.068878	2019-08-09 08:42:19.520961
fae94968-f365-4eb9-8c25-332175e2de7d	Location	a6a374eb-268d-49d1-bf17-9aa1011970c8	Volta_Hall		LG25	Accra		Greater-Accra	GH	5.651494	-0.189462	\N	2019-08-07 11:25:17.295614	2019-08-09 08:46:30.414504
e129e5e0-455d-4f05-bf4b-1d1f4136748e	Location	476d0628-2adb-4ee9-a169-34cbdd8b49db	Vc Lodge		LG25	Accra		Greater-Accra	GH	5.649621	-0.197118	\N	2019-08-07 11:02:14.290747	2019-08-09 08:49:52.210126
726c63ba-a6e2-4935-94c6-5100a19e203e	Location	91b1721d-702d-4f35-8fa3-9f9580967c0e	Kwame Nkrumah University of Science and Technology		PMB	Kumasi		Ashanti	GH	6.681945	-1.573373	\N	2019-08-08 11:55:26.64941	2019-08-09 17:11:37.618628
f5c02b15-4013-444b-aa4a-8a36730a8ead	Location	038eed1e-fd13-48ed-9a6f-48326ab4be73	ugbs_Volta 		LG25	Accra		Greater-Accra	GH	5.658527	-0.177616	\N	2019-08-07 10:34:46.602621	2019-08-09 08:59:34.438241
4b7fe9e7-70a1-414e-8b67-10eed732d57d	Location	c4669900-ca9f-48bd-b400-1337edc3c159	Engineering		LG25	Accra			GH	5.655247	-0.183029	\N	2019-08-06 15:33:47.888744	2019-08-09 09:22:13.785025
c1afe101-d55e-4b99-830c-d1825d46ea64	Location	318c3911-1fd3-4856-bcac-d12cbb482ed0	VCG		LG25	Accra		Greater-Accra	GH	5.650600	-0.195948	\N	2019-08-07 11:15:24.449173	2019-08-09 16:39:26.599304
30dee194-9052-401f-a7dc-03bdfd2c2308	Location	6014c42d-5f6a-4398-8ba9-639b11f42a49	Kwame Nkrumah University of Science and Technology		PMB	Kumasi		Ashanti	GH	6.673936	-1.564623	\N	2019-08-08 12:12:45.199817	2019-08-09 17:11:47.819434
2423b13b-dfc1-45a1-9951-1d0a092d569c	Location	91de73b2-351d-4f09-8929-c51e9f25d2b3	Valco		LG25	Accra		Greater-Accra	GH	5.644825	-0.187005	\N	2019-08-07 10:42:52.300093	2019-08-09 16:49:42.452519
dc626c91-d9e3-440e-9a5d-f23be1f70a28	Location	4925482f-825c-4cac-9a1b-625cca95899e	5 kIllo Pharmacy Campus 			Addis Ababa			ET	\N	\N	\N	2020-02-29 06:47:43.355551	2020-02-29 06:47:43.355551
e876c45b-aae9-4edd-a9fd-071130c9557c	Location	11db708a-343e-420e-a975-123db5815fb2	Kwame Nkrumah University of Science and Technology		PMB	Kumasi		Ashanti	GH	6.674394	-1.565080	\N	2019-08-08 11:52:03.017785	2019-08-09 17:11:59.779399
810dedb6-d386-466e-846b-da9d585481f1	Location	c509880d-7e70-4b74-86bc-e8fc319d4d90	Kwame Nkrumah University of Science and Technology		PMB	Kumasi		Ashanti	GH	6.674185	-1.564372	\N	2019-08-08 11:46:26.085558	2019-08-09 17:12:12.917118
112e0226-f34e-4719-b188-02e90961bb47	Location	8e3edbfd-a7ee-4e80-acfc-f7f2505fd23f	Kwame Nkrumah University of Science and Technology		PMB	Kumasi		Ashanti	GH	6.674197	-1.564527	\N	2019-08-08 11:33:08.873112	2019-08-09 17:12:22.865651
7d26dc3b-cb32-499e-b944-1ba81e20447c	Location	b3689bc6-2963-48df-bad0-3a4f90578789	Kwame Nkrumah University of Science and Technology		PMB	Kumasi		Ashanti	GH	6.669485	-1.565181	\N	2019-08-08 11:59:19.484414	2019-08-09 17:11:06.99747
0667132d-dd33-45f4-ad66-6eee1965a2b6	Location	b517602d-def9-4fb2-be65-eea3dfacb200	Kwame Nkrumah University of Science and Technology		PMB	Kumasi		Ashanti	GH	6.682670	-1.573427	\N	2019-08-08 12:07:03.109871	2019-08-09 17:11:24.789349
7f8f48a9-4e37-4168-9afb-98059df0b202	Location	98b68fc7-6643-43df-a77f-33bf7cc14f1d	Kwame Nkrumah University of Science and Technology		PMB	Kumasi		Ashanti	GH	6.674297	-1.564718	\N	2019-08-06 15:34:23.481846	2019-08-09 17:12:43.754369
2f521b05-010b-4756-9b38-abb7409d12ce	Location	7ea10b78-2dce-462a-9189-7f740d32a6ce	Kwame Nkrumah University of Science and Technology		PMB, University Post Office	Kumasi		Ashanti	GH	6.675409	-1.564216	\N	2019-08-06 15:28:49.616717	2019-08-09 17:12:57.094313
e4b66174-0a3e-44b1-9c97-347a04b23f91	Location	c6274974-782d-4d86-a2cb-cb0cea017850	Kwame Nkrumah University of Science and Technology		PMB, University Post Office	Kumasi		Ashanti	GH	6.674734	-1.571193	\N	2019-08-06 15:12:59.117871	2019-08-09 17:13:06.215501
09c54b2f-88f5-4048-bd7d-e78ada2dfb2a	Organisation	1e45e65b-9167-4cc9-bbb7-1f11d63e70d8	Shala road		Private Bag 7	Luanshya		Copperbelt	ZM	\N	\N	\N	2019-09-23 10:30:58.680305	2019-09-23 10:30:58.680305
c59c9258-a7eb-45d9-8b4d-0ea45770fdb3	Organisation	64f81d4e-7d1a-4a40-b5b8-b1ddd99e5ecc	UAC Abomey-Calavi	Calavi	01 BP 526 RP Cotonou	Abomey-Calavi	00229	Littoral	BJ	\N	\N	\N	2019-10-01 10:48:52.744712	2019-10-01 10:48:52.744712
5cbb97da-a3bb-4f02-a1d0-4116d002cf40	Organisation	549299ce-02f6-4aed-bc57-b8e5131ff7f3	bamako			bamako			BJ	\N	\N	\N	2019-10-04 14:21:02.323641	2019-10-04 14:21:02.323641
1f498e4b-a0f0-47a4-93b9-b006be2ae4a6	Organisation	35d18cea-9f0b-42b3-989d-f9ea84b94ef6	bamako	bamako	01 BP 56	bamako		bamako	ML	\N	\N	\N	2019-10-16 11:12:50.384674	2019-10-16 11:12:50.384674
423c56ef-843d-498d-8ace-5e2b11af74f8	Location	ec8a4d5a-45f5-4bea-8f30-dcf7d40035c9	Entreprise de télécommunications à Antananarivo	Lalana Paul Dussac		Antananarivo	101		MG	\N	\N	\N	2019-10-24 05:44:58.871709	2019-10-27 14:39:49.295586
7f51a76b-94e8-4f29-ae02-107dabb025a1	Organisation	faddfab4-02d0-45b3-9ac1-351eacfd4efa	Chalimbana Road,	Chongwe	Private Bag East 1	Lusaka		Lusaka	ZM	\N	\N	\N	2019-10-30 13:12:35.962533	2019-10-30 13:12:35.962533
5786a18c-8ea5-4d59-8d45-b244ea3b827f	Organisation	aee1e708-5a8f-4465-a558-97c61110d4bb	dakar	dakar	0000	dakar	00000	dakar	SN	\N	\N	\N	2019-10-30 16:04:29.157722	2019-10-30 16:04:29.157722
1975719d-82c2-432a-bdcb-d2e3e3207802	Organisation	d6ec3437-802b-418e-8c40-08fc96e9bcc9	cotonou			Cotonou		littoral	BJ	\N	\N	\N	2019-11-19 11:15:53.848369	2019-11-19 11:15:53.848369
fd805602-b9a8-43d3-9f0c-e95aa90a74e6	Organisation	53cd2ce3-bd7b-420c-8802-a4731571da47	Kiko Ave, Dar es Salaam, Tanzania			Dar es Salaam		Dar es Salaam	TZ	\N	\N	\N	2020-02-27 14:38:46.044357	2020-02-27 14:38:46.044357
2d3bb0d6-91be-4a3b-bcd2-d82604900cc9	Location	6b84c295-0ce8-44aa-8058-154ee9a9d355	Bauchi Road		PMB 5774	Jos		Plateau	NG	\N	\N	\N	2020-03-04 09:08:48.918489	2020-03-04 09:08:48.918489
5c401a2b-3df9-4041-8c31-d95950aaee61	Location	66083abe-8a10-4b3f-a802-8ac3bb09fe5e	Bauchi Road		PMB 5774	Jos		Plateau	NG	\N	\N	\N	2020-03-04 09:10:10.414132	2020-03-04 09:10:10.414132
671f27ce-7153-400f-aa87-263f8aa83dcc	Location	4b1e7a68-c0dd-47d2-85f3-4d1857c84fb3	Bauchi Road		PMB 5774	Jos		Plateau	NG	\N	\N	\N	2020-03-04 09:11:13.788229	2020-03-04 09:11:13.788229
06b34a35-bae4-4256-aacf-fe253c1b3780	Location	4f30f466-cf19-4bd9-96a6-50dae24f9a0c	ICT Directorate	Bauchi Road Campus	P.M.B 2084	Jos	930001	Plateau	NG	27.204600	77.497700	\N	2019-08-09 11:58:34.205667	2021-04-07 14:49:50.482592
145423f4-51f5-4009-ada3-bcf2de75d6f5	Location	b4fc7f15-99dd-4471-bccb-a2ead832d8c9	Naraguta		PMB 5774	Jos		Plateau	NG	9.967146	8.881050	\N	2020-03-04 08:59:15.209681	2021-04-15 12:47:02.397312
2f625165-be8c-480b-a845-483ee9be7a1a	Location	a7181ef6-8df2-4def-9f8b-e2ce2a3100a0	Naraguta		PMB 5774	Jos		Plateau	NG	9.967664	8.884526	\N	2020-03-04 09:00:22.537081	2021-04-15 12:47:48.094596
958cc8a0-7c15-4a92-8d02-a1598461c92e	Location	93d6f58f-efa3-4516-9698-2f04cbea7db0	Bauchi Road		PMB 5774	Jos		Plateau	NG	9.950095	8.891424	\N	2020-03-04 09:02:19.48603	2021-04-15 12:58:45.406755
32aa4afe-5214-4111-b4a3-3908a682064a	Location	2fe4b053-3cd9-491b-987a-4061457e783f	Bauchi Road		PMB 5774	Jos		Plateau	NG	9.950095	8.891424	\N	2020-03-04 09:07:28.561792	2021-04-15 13:02:24.972786
66264f0d-35ed-4343-896d-e8fdc15c254c	Location	c1c1ba9d-6f90-4e88-9a75-27c4c98a7036	Bauchi Road		PMB 5774	Jos		Plateau	NG	9.950716	8.891236	\N	2020-03-04 09:05:44.537957	2021-04-15 13:04:16.986839
1a94e55a-666b-46e7-ba2f-ad6b91cf5743	Location	3cd7621f-5539-4035-8729-08adbd2e22f0	Bauchi Road		PMB 5774	Jos		Plateau	NG	9.951468	8.884676	\N	2020-03-04 08:55:31.623141	2021-04-15 13:08:40.4644
21e5109c-aab8-4d4a-86a4-d91156b6ecce	Location	ad495a86-dc97-4634-9c38-1c74825fd3ea	Bauchi Road		PMB 5774	Jos		Plateau	NG	9.952228	8.894289	\N	2020-03-04 08:58:08.771243	2021-04-15 13:09:37.40748
4d98a40f-04c9-4f2b-b079-596ac851b4b2	Location	c4ba8460-8a81-4c7e-852b-ab8f7515f7ce	Bauchi Road		PMB 5774	Jos		Plateau	NG	9.965598	8.886720	\N	2020-03-04 09:09:37.939067	2021-04-15 13:12:47.985006
36085db9-dd9c-4c63-8ede-4da6a90ed709	Location	cece05f8-00e5-49ed-a24a-584ebcfcb44f	Bauchi Road		PMB 5774	Jos		Plateau	NG	9.963441	8.879054	\N	2020-03-04 08:53:44.92626	2021-04-15 13:43:53.146258
151a0ff8-3db2-49dc-b6f2-726fc5a9136b	Location	6b092ff0-46a5-4ba6-9545-aea2f4e6590b	Naraguta Campus		2048	Jos	930001	Plateau	NG	9.963779	8.880685	\N	2020-03-03 12:45:19.34877	2021-04-15 13:44:22.250211
aa3c4187-8659-42d3-a23d-e46e71f08da0	Location	e5a6bcec-ab50-4e5f-840d-e75f8e6ca6dd	Fiadanana			Antananarivo	101		MG	-18.931059	47.525126	\N	2019-10-16 11:59:36.936342	2021-04-16 05:16:32.986608
fc7e08de-9722-4bb1-ac0f-4709749321f4	Location	f5f77c14-e6a1-48f3-971d-8721c1280cfb	Bauchi Road		PMB 5774	Jos		Plateau	NG	\N	\N	\N	2020-03-04 09:15:53.491725	2020-03-04 09:15:53.491725
cd5de89f-f501-4f22-b915-9d135414a48f	Location	86e6d2c7-821c-47b6-8bb6-c399978d9b6d	Bauchi Road		PMB 5774	Jos		Plateau	NG	\N	\N	\N	2020-03-04 09:17:32.045369	2020-03-04 09:17:32.045369
66b5162b-2c57-40e6-b442-e96d1de1682b	Location	f3bdd6e8-cf26-4984-863c-4f01f47ac359	Naraguta		PMB 5774	Jos		Plateau	NG	\N	\N	\N	2020-03-04 09:22:24.71333	2020-03-04 09:22:24.71333
cbd72f65-4156-4a95-96a7-715561ff6f35	Organisation	f8853894-499c-453a-bcde-376fca47aeab	10 Jubril Aminu Crescent			Abuja		FCT	NG	\N	\N	\N	2020-03-06 11:47:32.402479	2020-03-06 11:47:32.402479
8586463b-0931-4d2f-8e81-859943c37a4c	Organisation	bdbce8c6-b4e0-4504-ad5f-d2c5440a7213	Ganges Road			Harare			ZW	\N	\N	\N	2020-06-01 13:06:06.01005	2020-06-01 13:06:06.01005
8891471e-7790-4614-891b-31179f50166d	Location	a497f23b-9371-4393-9f52-7ddbec12033f	Kade		LG25	Accra		Greater-Accra	GH	6.093759	-0.834162	\N	2019-08-06 16:34:47.520241	2020-09-11 13:10:20.973144
2ed75cbf-76ae-49e5-8df8-e7bfb1455069	Organisation	c7b1c506-aaf5-4e61-b7cb-4d4feb85a5bd	Livingstone Road		660391	Monze		Southern Province	ZM	\N	\N	\N	2020-09-17 15:32:58.567719	2020-09-17 15:32:58.567719
b371dd2b-e313-48a1-b1dd-17feeae31c88	Organisation	d12bcb08-d0c5-4a5f-aedb-e1042a3e866e	Dushambe Road		31990	Lusaka		Lusaka	ZM	\N	\N	\N	2020-10-02 07:40:15.462754	2020-10-02 07:40:15.462754
9fc399c0-cf73-4681-b5a4-772db9f8ee66	Organisation	82797b17-9b81-45ca-b904-24671e521f97	Solwe Road			Solwezi		North Western Province	ZM	\N	\N	\N	2020-11-30 13:14:40.056318	2020-11-30 13:14:40.056318
1e733d05-cc5c-49a9-8030-7d9bcd101880	Organisation	5392bfa3-cf25-4e13-8528-d42baa9b7e7c	Nkana Road			Ndola		Copperbelt Province	ZM	\N	\N	\N	2020-12-14 07:33:44.74001	2020-12-14 15:14:05.973014
f0fc182b-2db9-4d7c-bd66-30b2b911cf58	Organisation	a42b1866-4163-45e2-b093-3edc1e6a71d9	Mpelembe Road		Box 90257	Luanshya		Copperbelt Province	ZM	\N	\N	\N	2020-12-14 15:17:37.126094	2020-12-14 15:17:37.126094
6a7bd9b3-5ca3-47aa-b7a3-d590b21b78ce	Organisation	cc373e93-f7d1-424e-9c21-801c6f1f758e	Nationalist Road		Box 50366	Lusaka		Lusaka Province	ZM	\N	\N	\N	2020-12-15 06:52:55.354021	2020-12-15 06:52:55.354021
200b9c49-6511-4071-81ed-6f8b9c4c658c	Organisation	05dab0bd-ad04-4820-a02a-15aa3e255b8f	Great-North Road		Box 450030	Mpika		Muchinga Province	ZM	\N	\N	\N	2020-12-14 20:35:04.977413	2020-12-15 06:54:17.610324
a58b9d1f-ba18-4213-b67d-06095565c737	Organisation	3a6f9417-4853-4522-863e-9c2e43aea6fa	Hospital Road		Box 510119	Chipata		Eastern Province	ZM	\N	\N	\N	2020-12-14 20:45:39.616053	2020-12-15 06:54:51.021985
90ff8f7d-646c-4993-91e2-19216db5b222	Organisation	48a3cb01-a52f-4f23-bc45-4d0e5a93f77e	Mukobeko Road		Box 80784	Kabwe		Central Province	ZM	\N	\N	\N	2020-12-14 20:49:45.895731	2020-12-15 06:55:11.19959
8badcab5-d277-4d88-8154-0aee2ca5f527	Organisation	e656e725-44cd-482a-b465-0340255d8ff6	Mpandafishala chilonga mpika, great North road		Box 450030	Mpika		Muchinga Province	ZM	\N	\N	\N	2020-12-15 07:00:02.017999	2020-12-15 07:00:02.017999
834b5908-eda1-433d-b99f-3d827a0c6a52	Organisation	cb11e742-b109-4f19-8a0f-f14481602895	Leopards Hill Road		Box 50507	Lusaka		Lusaka Province	ZM	\N	\N	\N	2020-12-15 07:12:54.933206	2020-12-15 07:12:54.933206
6e2866ca-5569-4bb3-9d8e-77a9fa8bb544	Organisation	bf33d3ba-99ba-4c1b-9c33-3310a65f09db	Cathedral Rd			Mansa		Luapula	ZM	\N	\N	\N	2020-12-15 07:43:38.192857	2020-12-15 07:43:38.192857
17c2967d-4448-4632-aa68-2293bedc761c	Organisation	350d84c1-c277-4363-a6dd-d58256b7b37e	Orange Street		Box 40897	Mufrila		Copperbelt Province	ZM	\N	\N	\N	2020-12-15 07:53:07.422785	2020-12-15 07:53:07.422785
97163ad7-1db3-4ae6-a7d4-fc917f5de180	Organisation	e89d53a5-d527-4ec0-a588-87e98d8b8148	Kansanshi Road		\t\t	Solwezi		North-Western Province	ZM	\N	\N	\N	2020-12-15 07:59:16.932804	2020-12-15 07:59:16.932804
ca6d72a6-5188-4801-a911-5d6a4b369ae6	Organisation	dccddb90-cbe6-46cb-a624-14b4dbf7e066	Mwanambinyi road			Senanga		Western Province	ZM	\N	\N	\N	2020-12-15 08:02:36.873146	2020-12-15 08:02:36.873146
9f039245-fce0-44c0-91ef-0182f0ec3770	Organisation	b3a6cfc1-b91c-485c-a005-4219b90eb83f	Hospital Road\t\t		Box 410891	Kasama\t\t		Northen Province	ZM	\N	\N	\N	2020-12-15 08:15:31.101192	2020-12-15 08:15:31.101192
6e64ca4c-afa1-4cfc-a329-06bab02b0a36	Organisation	ab836e55-9912-4a2a-a1ab-85df51382ef3	Hospital Road		Box 940009\t	Kaoma\t		Western Province \t	ZM	\N	\N	\N	2020-12-15 08:18:48.475158	2020-12-15 08:18:48.475158
4b5c7f9e-8e97-4961-8ac0-fa0866b1e798	Organisation	5f2139d1-75e0-4ac5-a44f-6381ee9f8c57	Great North Road\t		Private E15\t	Chibombo\t		Lusaka Province\t	ZM	\N	\N	\N	2020-12-15 08:29:30.320478	2020-12-15 08:29:30.320478
924ed18b-6439-421a-9b89-8b7f8a250e89	Organisation	00b18d3a-29c2-4e6a-bee3-453587844688	Lewanika general hospital road\t		Box 910147\t	Mongu\t		Western Province\t	ZM	\N	\N	\N	2020-12-15 08:38:12.258475	2020-12-15 08:38:12.258475
91ae57c1-2b65-4125-a898-00d77bb7803f	Organisation	b6f60b7d-230f-47e1-9580-11e6d899b539	off Mpika Road		P.O.Box 410195\t	Kasama\t		Northern Province\t	ZM	\N	\N	\N	2020-12-15 09:02:58.755845	2020-12-15 09:02:58.755845
8c92eb1b-1fc1-4fde-beea-46936322c077	Organisation	cab21e0d-202d-401f-951b-eddad5f148f1	Mindolo Road\t\t			Kitwe\t		Copperbelt Province \t	ZM	\N	\N	\N	2020-12-15 09:07:58.964405	2020-12-15 09:07:58.964405
b1e91ae6-774b-4a67-b0f8-e62aae464a88	Organisation	8dfc790e-ad17-467a-bc25-af17f7004c64	Kitwe/Mufrila Road\t		Box 40400\t	Mufrila\t		Copperbelt Province\t	ZM	\N	\N	\N	2020-12-15 09:22:21.693152	2020-12-15 09:22:21.693152
98728a4a-4bc4-40ff-bc7a-286b40b855f2	Organisation	1b7f3dec-e631-4cf3-bdd4-a68074eeefd1	mchini Road/umozi Highway\t		.Box 510189	Chipata	\t\t	Eastern Province	ZM	\N	\N	\N	2020-12-15 09:27:05.727958	2020-12-15 09:27:05.727958
dd07d4b4-c662-4a0e-922c-4974f47f3bda	Organisation	c709dc8e-aecc-4ce0-a1c2-bfe815ff122e	Limulunga Road		Box 910394\t\t	Mongu\t		Western Province	ZM	\N	\N	\N	2020-12-15 09:43:34.865069	2020-12-15 09:43:34.865069
1615f4f2-fa22-4348-8a7e-3b28121dd62b	Organisation	bf83777c-f620-42de-aa60-8cb4faf67171	Motomoto Road \t\t			Mbala\t \t		Northen Province	ZM	\N	\N	\N	2020-12-15 09:54:48.084239	2020-12-15 09:54:48.084239
262e14c1-5e3d-4b7d-b9e0-e17271ec05a5	Organisation	293982c4-1b82-4ff0-8cb8-a682a4528582	off Chivuna road\t\t		Box 66053	Monze		Southen Province\t	ZM	\N	\N	\N	2020-12-15 10:00:56.556307	2020-12-15 10:00:56.556307
73b1b064-4fa9-4bfb-a73c-2c7fc289c372	Organisation	a837afed-9908-4e0c-ade8-56a54d62ea9d	off Chivuna road, Monze East\t		P.O.Box 660078\t	Monze\t		Southen Province\t	ZM	\N	\N	\N	2020-12-15 10:06:58.134742	2020-12-15 10:06:58.134742
ee8d2df2-a119-4606-8b2d-df6602442948	Organisation	1c72adb6-7fd0-4ac9-86f2-f74a9ad7c895	off Ngaswa Road \t\t\t\t		Private bag 1	Serenge		Central Province	ZM	\N	\N	\N	2020-12-15 10:13:53.536275	2020-12-15 10:13:53.536275
066b8545-2af8-4297-a22d-dc4c1815ab62	Location	76133617-5b79-40fc-81eb-12188b395a58	Bauchi Road		PMB 5774	Jos		Plateau	NG	9.946265	8.899469	\N	2020-03-04 09:31:51.305129	2021-04-14 04:20:28.211587
f353fde7-c063-42d3-a906-5b81fc79a792	Location	f2ddd37e-05fc-4514-aaf6-9f0c45660f80	Naraguta		PMB 5774	Jos		Plateau	NG	9.950095	8.891477	\N	2020-03-04 09:25:34.417174	2021-04-15 13:01:51.176374
3d0208cd-f261-48ce-9a69-9b3114c09df4	Location	1cb045d8-7d91-40de-a301-70c328dcfb3d	Naraguta		PMB 5774	Jos		Plateau	NG	9.950095	8.891424	\N	2020-03-04 09:27:47.005933	2021-04-15 13:02:58.563079
5963cab4-2cf2-4ee4-bac9-bf6a5ec29f7d	Location	e6701145-1bd2-4da9-a3a7-928ee88dfbba	Bauchi Road		PMB 5774	Jos		Plateau	NG	9.948767	8.889292	\N	2020-03-04 09:14:16.832745	2021-04-15 13:14:59.361953
6ebcb060-7567-456a-a5e1-567c4ad19ee4	Location	91bf4fd6-b625-4db0-a1d2-907e310d8ba8	Bauchi Road		PMB 5774	Jos		Plateau	NG	9.951860	8.891846	\N	2020-03-04 09:16:29.072692	2021-04-15 13:16:11.888398
fb792d6c-e809-412b-85d7-c7167217f497	Location	7e37fe8d-448b-4347-8f5d-13a897b1f28f	Bauchi Road		PMB 5774	Jos		Plateau	NG	9.949926	8.891510	\N	2020-03-04 09:15:09.82064	2021-04-15 13:17:04.759148
6a96a354-edce-4c36-a4cc-31f7d55043d6	Location	ac431f27-aa43-47b7-a2c2-b9a99a6d5d6e	Bauchi Road		PMB 5774	Jos		Plateau	NG	9.949968	8.891467	\N	2020-03-04 09:20:41.238412	2021-04-15 13:18:36.748473
9349c501-fed7-41c0-8228-23e802005ee9	Location	11c87fe6-e931-4453-a29a-4647602dc1b5	Bauchi Road		PMB 5774	Jos		Plateau	NG	9.949968	8.891467	\N	2020-03-04 09:19:20.223622	2021-04-15 13:19:03.408641
a6b7f2f6-ed00-41e8-ab9b-f3e1f7e82f6c	Location	c78502ce-015c-4a83-aa78-750ab2b854a4	Naraguta		PMB 5774	Jos		Plateau	NG	9.967084	8.883275	\N	2020-03-04 09:28:59.854473	2021-04-15 13:21:38.716483
88f83d18-7b9f-4515-ba8b-7aeafe0d15f4	Location	d960e095-0ac9-4ae5-8a0c-7eb99f1ebaf3	Naraguta		PMB 5774	Jos		Plateau	NG	9.959412	8.876154	\N	2020-03-04 09:28:22.145783	2021-04-15 13:22:26.868844
50d5791b-9084-4343-bfee-c3f4e3820dbd	Location	1ed1c43b-9119-4170-9867-54b6620f9b2a	Naraguta		PMB 5774	Jos		Plateau	NG	9.968991	8.884274	\N	2020-03-04 09:30:22.339935	2021-04-15 13:23:20.483705
ef3acdc6-5586-4ccf-a4fe-f97a7ccbc89a	Location	f6d749b3-e281-4886-a14d-e63bf8ca4e4d	Naraguta		PMB 5774	Jos		Plateau	NG	9.967169	8.884305	\N	2020-03-04 09:23:03.634646	2021-04-15 13:45:58.375123
7ece92ad-c989-4125-baaf-f872310c436e	Location	61fd7d02-7660-4de9-8f3a-b451499c3db7	Naraguta		PMB 5774	Jos		Plateau	NG	9.966047	8.884201	\N	2020-03-04 09:21:54.730846	2021-04-15 13:49:07.068316
e7a6e830-80f7-4d03-acab-8174470f5ba5	Location	05707278-bf54-4f0a-b85e-d48edce107d4	Komfo Anokye Teaching Hospital		PMB, University Post Office	Kumasi		Ashanti	GH	6.697320	-1.627386	\N	2020-09-25 16:02:24.625734	2021-04-29 11:19:41.043061
45291feb-c7c0-4737-b030-5b8d94a799b9	Location	42aeb587-d91b-4665-9b17-9b048f0c14d9	Queens road		PMB, University Post Office	Kumasi		Ashanti	GH	6.682787	-1.575603	\N	2020-09-25 16:19:00.596526	2021-04-29 11:21:18.717951
b7965e87-2a80-4f30-b3f4-2e873fbb4501	Location	bf6fbc17-189d-40a8-a40d-fd10fa13cbca	P. V. Obeng avenue		PMB, University Post Office	Kumasi		Ashanti	GH	6.675888	-1.567684	\N	2020-09-25 16:23:08.737683	2021-04-29 11:23:12.748806
fa34bcd0-3897-436c-8676-68e5455c2598	Location	280d5af0-eeab-44e0-9d6e-384a6b05be94	Prempeh II link		PMB, University Post Office	Kumasi		Ashanti	GH	6.675342	-1.572886	\N	2020-09-25 16:30:04.880706	2021-04-29 11:23:49.351045
eb595182-dddf-4677-bb4c-25b637761ba7	Organisation	a98028c2-feb2-4129-afb9-3d75cffae1ee	St Clement Road\t\t\t\t		Box 710391	Mansa		Luapula Province	ZM	\N	\N	\N	2020-12-15 10:19:22.060116	2020-12-15 10:19:22.060116
eb46bdf7-4c1a-4efa-b73a-d2040cb5bc6c	Organisation	d70d67d3-5a37-4043-a5c3-0d795c143655	off Nakonde Road\t\t\t\t\t		Box 450143	Mpika		Muchinga Province	ZM	\N	\N	\N	2020-12-15 10:24:28.574315	2020-12-15 10:24:28.574315
8c60c74d-860e-491d-be20-95dda6c6b7e1	Organisation	f4b8dd42-f206-46ca-bb2b-e9a7d1f909a1	Livingstone Road			Monze 	\t\t	Southern Province 	ZM	\N	\N	\N	2020-12-15 10:43:37.110532	2020-12-15 10:43:37.110532
addd141a-d2d5-41de-9990-62140d065b5e	Organisation	11612124-c37e-4fca-9a4d-6a4d667c12a4	Off Livingstone  road		Box 640060	Pemba		Southen Province\t	ZM	\N	\N	\N	2020-12-15 11:07:00.133274	2020-12-15 11:07:00.133274
689ccc26-3a0b-41ce-924a-f6f29cc600d3	Organisation	1b548d86-53e2-485e-a124-280a75ca8dcf	Macha Road		Box 630351 	Choma		Southen Province\t	ZM	\N	\N	\N	2020-12-15 13:13:50.219894	2020-12-15 13:13:50.219894
78194099-8451-42a4-8f9f-1db67affba54	Organisation	4209f2c1-3849-46ae-87d9-004a22ce1a04	Jumbe Road\t\t\t\t		Box 10063	Chingola		Copperbelt Province	ZM	\N	\N	\N	2020-12-17 16:00:43.602112	2020-12-17 16:00:43.602112
4c4fbd82-7e5b-45ff-aa5e-44ca43a35dec	Organisation	76c1e832-d232-4cd1-b2c6-4d455c48296b	Great North Road	Lot 570/m	Private Bag CH99, Chelstone	Lusaka		Lusaka	ZM	\N	\N	\N	2021-02-04 09:16:00.050476	2021-02-04 09:16:00.050476
c66ee658-3f46-4a86-8df8-93aa0c34f1b0	Organisation	e974240c-1ece-4094-8a28-4a220ec0a9e5	Kuomboka Drive	Plot 2831	P.O Box 21994 	Kitwe		Copperbelt Province	ZM	\N	\N	\N	2021-02-04 09:55:25.378836	2021-02-04 09:55:25.378836
b1f714dc-619b-41a8-9dc6-6fe735e5615a	Organisation	12019ea3-124c-48b9-9772-c1c48af39cc9	Plot No. 119	Kalanga Road, Emmasdale	390022	Lusaka		Lusaka	ZM	\N	\N	\N	2021-02-09 09:28:42.732904	2021-02-09 09:28:42.732904
77cfde8e-8ca2-4ee7-86aa-090045b0e72a	Organisation	9e7c290c-2a2a-49d1-94c4-0aa9715d0818	Kampala	University Road	7856	Kampala	256	Central	MW	\N	\N	\N	2021-04-06 11:28:44.888479	2021-04-06 11:28:44.888479
bd391287-7833-4c61-9c3a-4d0c1c54ad3b	Organisation	1ce47b62-7c29-431f-889f-3e2949843b72	Accountants Park, Plot No. 2374/a	Thabo Mbeki Road		Lusaka		Lusaka	ZM	\N	\N	\N	2021-04-06 14:46:20.316496	2021-04-06 14:46:20.316496
a9e9ad60-8385-4d84-8939-4a9360144a8b	Organisation	1c04c719-fda2-49bb-a2e4-82c952394d50	Taleh Road			Mogadishu		 Hodan District	SO	\N	\N	\N	2021-04-07 12:58:15.533288	2021-04-07 12:58:15.533288
dda40eeb-7cf8-4f60-9823-d1e126fbd98a	Organisation	4266f4f5-9131-48d9-9ba4-042b7ed34f8f	Burma Road			Lusaka		Lusaka	ZM	\N	\N	\N	2021-04-08 12:34:57.590621	2021-04-08 12:34:57.590621
b2a7c8bd-bc92-4c03-a82a-442ea6dc1e6a	Location	899313e0-730d-4c25-8f2a-fa8e02cdab5e	VC's Lodge		PMB 5774	Jos		Plateau	NG	9.893496	8.898776	\N	2020-03-04 09:32:50.072239	2021-04-14 04:18:32.691854
80bebab0-fa60-41aa-a22a-9d1c2ec2cf60	Location	34e2e556-abe9-412b-8236-40812e006643	Naraguta		PMB 5774	Jos		Plateau	NG	9.965466	8.881104	\N	2020-03-04 09:29:49.612538	2021-04-15 12:45:20.073219
2562395a-5847-4aca-ae76-223d18dc3715	Location	737a1574-e746-4a6d-9b2e-375ab6105b0d	Naraguta		PMB 5774	Jos		Plateau	NG	9.965629	8.883497	\N	2020-03-04 09:06:28.130445	2021-04-15 12:50:18.125665
00fe7df2-5bb3-4c14-b8d6-f346c4b073c7	Location	61d83ad3-01a1-4dc7-a67d-b23548ab5735	Bauchi Road		PMB 5774	Jos		Plateau	NG	9.949819	8.889793	\N	2020-03-04 09:08:07.718428	2021-04-15 13:10:53.086556
954aa5fc-a2c1-4e62-a54b-ddb048544843	Location	61998dba-ce3f-4c24-9051-60d1d581f8ce	Bauchi Road		PMB 5774	Jos		Plateau	NG	9.949968	8.891510	\N	2020-03-04 09:18:10.142395	2021-04-15 13:18:04.724835
7c51d502-77de-4c9e-8c5f-9c7de99bed88	Location	d34a8c91-c44d-4ce4-8604-c294425f3edc	Naraguta		PMB 5774	Jos		Plateau	NG	9.965901	8.884305	\N	2020-03-04 09:30:55.553746	2021-04-15 13:46:58.673128
b7031c0b-22a5-43a7-90e8-eb524502e498	Location	d0d4e6c4-6d51-448b-b246-4ca16a1ec9b2	 AUF - Bureau Océan indien	7, rue Joël Rakotomalala, Faravohitra, Antananarivo		Antananarivo	101	Analamanga	MG	-18.904398	47.529030	\N	2021-04-15 05:17:53.96731	2021-04-16 05:14:42.061914
11847cee-d5e9-40fb-8098-645854fae6c6	Organisation	f5e8d182-0759-45a2-a54e-8a50a43fbab6	lome			Lome			TG	\N	\N	\N	2021-04-23 12:56:25.890128	2021-04-26 09:04:57.564745
d778d9dc-ff9e-4a54-a57a-c9771b80ddd6	Location	5246784b-692e-412f-8488-dae6f22d30d9	Taleh road, hodan district			Mogadishu		Benadir	SO	\N	\N	\N	2021-04-29 08:52:03.875006	2021-04-29 08:52:03.875006
45246d98-5267-4571-8093-6555ce81c2e7	Organisation	da5423fb-a58d-482f-b81d-a1bb8c3d0413	Plot No 37413, off Alick Nkhata Road, Mass Media		P.O. Box 36711	Lusaka		Lusaka	ZM	-15.413310	28.321590	\N	2021-05-03 08:45:08.537279	2021-05-03 08:55:53.920893
15f93a85-5f6e-4f8e-b731-ede6af60ca2b	Organisation	f2ec386f-3a4f-4579-b56d-a1e6da1b43aa	Solwezi Kansanshi Road		P.O.Box 110353	Solwezi	10101	North-Western Province	ZM	\N	\N	\N	2021-05-24 13:13:04.791833	2021-05-24 13:13:04.791833
e75e0799-e264-4367-b6c6-457376c01b68	Location	6b61d79d-8a7a-4c6f-b3d4-ff07877bd5ff	Zomba			Zomba			MW	\N	\N	\N	2021-06-11 09:52:29.899162	2021-06-11 09:52:29.899162
0651a220-fb36-4950-bd29-ec62ab7eeaf6	Organisation	86b3926e-5f58-4f34-a48c-e4cd7204bee9	Zomba		278	Zomba			MW	-15.378975	35.324990	\N	2021-06-11 09:27:29.951746	2021-06-11 09:58:53.983029
762882ff-7a7a-4f80-9308-a58fc87b1177	Organisation	c379f63a-ef47-491a-98ba-6cb76daa20b0	Chipembere Highway		303	Blantyre			MW	\N	\N	\N	2021-06-11 10:08:05.498016	2021-06-11 10:08:05.498016
2acd77a5-5c7e-43c0-a55c-3998a93f4fe2	Organisation	28694d8e-e7d7-417a-b5b0-cf4815c92234	Nationalist Street	Nationalist Street	Cancer Disease Hospital	Lusaka	10101	Lusaka	ZM	\N	\N	\N	2021-08-26 14:04:05.554427	2021-08-26 14:04:05.554427
0e80d7b3-9f04-45a3-9659-3769c8eac855	Location	831f7acb-a253-409c-942d-652ec3d21cf0	University of Lomé		1515	Lomé			TG	\N	\N	\N	2021-10-18 15:30:55.819485	2021-10-18 15:30:55.819485
d2b3e74b-3897-420c-827a-f50ccd6d7a53	Organisation	0bbc71ed-a2e0-4e10-983e-a7fb0ffec5b5	Off Chingola Dual Carriage Way, Itimpi,		 20382	Kitwe		Copperbelt	ZM	\N	\N	\N	2021-12-13 09:39:47.353687	2021-12-13 09:39:47.353687
\.


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: switchboarder
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	production	2018-01-10 15:27:14.668844	2018-01-10 15:27:14.668844
\.


--
-- Data for Name: confederations; Type: TABLE DATA; Schema: public; Owner: switchboarder
--

COPY public.confederations (id, name, operator_id, email, tld, created_at, updated_at) FROM stdin;
621b2e43-dc2e-4f26-99b4-e126bb4caff6	African eduroam Confederation	\N	eduroam@ren.africa	AFRICA	2018-08-28 14:32:56.632242	2018-08-28 14:32:56.632242
\.


--
-- Data for Name: contacts; Type: TABLE DATA; Schema: public; Owner: switchboarder
--

COPY public.contacts (id, contactable_type, contactable_id, name, email, phone, contact_type, privacy, created_at, updated_at) FROM stdin;
0d8b315a-1144-43cf-a572-39959c89e06b	Location	8d4607fb-bc13-4fd6-bd46-128c8796b474	Chris Rohrer	devops@ubuntunet.net	+265 1 754 535	0	1	2018-03-09 07:44:20.201902	2018-03-09 07:44:20.201902
4a240137-cd2d-46dd-b85d-d40181cd0729	Organisation	2bf8127f-b5fa-4f92-a65c-fce09f50114c	Owen Mwenefumbo	omwenefumbo@mlw.mw	+265 1874628	0	1	2018-03-27 10:03:33.803893	2018-03-27 10:03:33.803893
68104c3f-7ac6-4fd0-80de-af816e964494	Organisation	1786272a-a169-4b8c-b7fa-9f47905733fc	Chikumbutso Gremu	cgremu@medcol.mw	+265 999 671 959	0	1	2018-03-27 10:54:34.729841	2018-03-27 10:54:34.729841
878de8eb-abb9-4ff5-849f-5bdcb96b7ce5	Location	22a8d18f-3404-4823-ba11-469bb838622c	Owen Mwenefumbo	omwenefumbo@mlw.mw	+265 999 783937	0	1	2018-03-27 11:22:19.294535	2018-03-27 11:22:19.294535
c9a3a99d-59e6-4a3f-9c1b-73319444df0e	Organisation	1b86a4eb-944e-49c3-b183-0c631b1d27bc	Henry Simfukwe	henry.simfukwe@zamren.zm	+260 211 295927	0	0	2018-05-17 14:41:52.149682	2018-05-17 14:41:52.149682
09a64bed-58e7-4826-90c6-7030fcd065f0	Organisation	1b86a4eb-944e-49c3-b183-0c631b1d27bc	ZAMREN NOC	noc@zamren.zm	+260211295927	1	1	2018-05-17 14:43:00.620002	2018-05-17 14:43:00.620002
8107e617-1e76-40e0-94ee-c8096c4b5595	Organisation	cd8a9e52-58b9-4fcc-93ca-e53a81d50383	TERNET Helpdesk	helpdesk@ternet.or.tz	+255 222 77 53 78	1	1	2018-05-17 15:03:32.513139	2018-05-17 15:03:32.513139
63df3710-ef1b-4f65-b5fd-5ba0bb875566	Organisation	cd8a9e52-58b9-4fcc-93ca-e53a81d50383	Kilongi Kayera	kkayera@ternet.or.tz	+255 222 77 53 78	0	0	2018-05-17 15:05:29.116256	2018-05-17 15:05:29.116256
12685df3-9004-4889-b525-289088167376	Organisation	7d9384ac-82bf-430e-a5c6-3372970a13d0	Rogerio Muhate	rogerio.muhate@morenet.ac.mz	+258 21 352860	0	1	2018-05-24 14:14:11.353272	2018-05-24 14:15:35.905877
1fd94115-5b00-46f0-b37b-117e312b4808	Location	a5c0271b-f7a5-4556-8fa3-1e7a213633bd	Lalanirina Jean ANDRIANTSITOHAINA 	lalanirina@irenala.edu.mg	+261 34 30 412 42	0	0	2018-07-25 08:33:20.207001	2018-07-25 08:33:20.207001
91826629-4a6f-4b3b-8d16-9d15c75b88a4	Organisation	7ccfcd5c-da2a-44d2-acff-f7a51ec5b199	Anthony Adejumo	aaadejumo@ngren.edu.ng	+2348026709251	0	0	2018-08-27 09:04:44.572009	2018-08-27 09:04:44.572009
ab7e5977-dcae-4c12-833f-69166ce0b464	Organisation	1ae8ed07-9a09-4c42-ba70-45cefae61ac5	Calebe Souza Reis	calebe.reis@rnp.br	+55 21 2102-9660	0	1	2018-08-30 14:35:42.592015	2018-08-30 14:35:42.592015
77521c3d-391a-4764-9e2b-a06392d80e88	Organisation	4f5825fb-a110-42d5-914b-3d94afd58caa	Anthony Adejumo	aaadejumo@nuc.edu.ng	2348026709251	0	0	2018-10-30 10:13:30.758465	2018-10-30 10:13:30.758465
8373827f-0bb9-4600-8b41-66edd4f84000	Organisation	9b0f1760-1df5-4e5e-8118-a6cef51cf832	Henry Simfukwe	henry.simfukwe@zamren.zm	+260953205513	0	0	2018-11-20 12:55:33.969048	2018-11-20 12:55:33.969048
ba0561d1-9ace-4818-84ee-a1014d1c4962	Organisation	c6a1da0a-512f-477d-ad3b-4ed3f2cba737	Niry Andriambelo	niry.andriambelo@auf.org	+261 34 02 621 28	0	0	2018-11-20 13:04:17.502656	2018-11-20 13:04:17.502656
3e5cf442-c18f-4680-b6a5-ff87742a8c9a	Organisation	8d2a33be-7230-4c87-b6a3-499b4e18bf63	Eloge Bapfunya	eloge.bapfunya@ub.edu.bi	+25779841895	0	0	2018-11-22 09:22:21.852908	2018-11-22 09:22:21.852908
22cf6f6b-59f0-4318-bfee-59edd556cb4e	Organisation	c0457fb7-fc36-4bac-8e6d-019c5d716cd6	Francis Chikonde	francis.chikonde@solwezitrades.edu.zm	+260966993492	0	0	2018-11-26 10:26:49.857145	2018-11-26 10:26:49.857145
cd595063-6c3b-4990-8573-82eecd778ae4	Organisation	b7a4f25d-aa72-4812-a1dd-a563d26ba979	Issa Traore	traore.irma@gmail.com	+225 0622 2209	0	0	2018-12-06 07:03:52.244684	2018-12-06 07:11:53.601629
616c97cb-856b-46ef-a0b5-840d33aa0ac6	Organisation	408c3c2c-19cf-472e-82e4-9650641ede23	James Sakala	james@mu.edu.zm	+260967528864	0	0	2018-12-14 07:41:22.55793	2018-12-14 07:41:22.55793
f36ecef0-c558-41cc-8219-18bfa229378b	Organisation	94cf650e-540c-4d89-9f69-8891719fb5b5	Owen Iyoha	owen@eko-konnect.org.ng	+234 806 044 2383	0	1	2019-02-01 04:35:09.044642	2019-02-01 04:35:09.044642
6fd0bdaf-9e18-4dba-a175-35c5fa3f9153	Location	24d2c3c3-f970-4b6d-82a1-90d24301fb2d	Kilongi Kayera	kkayera@ternet.or.tz	+255222775378	1	0	2019-03-18 08:32:27.646171	2019-03-18 08:32:27.646171
d2a6f639-1fcb-45fc-b21e-8d4384340bc4	Organisation	c6235a8c-9c92-43e5-b246-8e46132f22f6	Omo Oaiya	omo.oaiya@wacren.net	+2348088881571	0	0	2019-03-27 10:37:47.829263	2019-03-27 10:37:47.829263
8f14b07e-5e45-4708-93b9-6732a1780694	Organisation	c6235a8c-9c92-43e5-b246-8e46132f22f6	eduroam Helpdesk	eduroam@wacren.net	+233 205 228 693	1	1	2019-03-27 10:37:47.834958	2019-03-27 10:37:47.834958
1b55f713-4b5e-49cf-b7ca-f93294d03212	Organisation	f897a4d3-44ca-4543-82aa-b4e502c6463e	Anaobi Ishaku	anaobii@unijos.edu.ng	+2348037008529	0	0	2019-04-01 13:32:57.743918	2019-04-01 13:32:57.743918
03132e0d-1e3d-4887-8113-007a7182b5b5	Organisation	96f247af-06f8-4c6a-b325-71f89fd65bd5	David Afolayan	david.afolayan1@covenantuniversity.edu.ng	+2348117756518	0	1	2019-03-15 11:49:04.445642	2019-04-03 14:46:51.771346
2af021de-49b7-4668-aee0-df79d98ab2fe	Location	58b87f31-d441-4e66-a8b1-2aba9e59e38a	Mauridi Mohamed	mmohamed@ternet.or.tz	+255 22 277 4023	0	0	2019-05-03 13:02:30.117224	2019-05-03 13:02:30.117224
b927a70b-9a37-49a5-8928-505957e0a7c1	Organisation	6f4462ad-1f14-4e25-be5e-88cf2e42cec1	Ekene Ezeasor	ezeasor.ekene@unizik.edu.ng	+2348063961963	0	1	2019-04-03 15:08:27.673225	2019-04-03 22:35:59.459454
3f296a18-3285-48c0-9db4-f7fa16e8c0e3	Location	baa295b2-d252-4134-ac20-445623abc2a9	Pius Effiom	pius.effiom@eko-konnect.org.ng	+2349067203479	0	0	2019-04-04 06:44:03.633484	2019-04-04 06:44:03.633484
8c56156f-2f64-43f1-a129-aa5010bd3292	Organisation	f897a4d3-44ca-4543-82aa-b4e502c6463e	Igba Priscillia	igbap@unijos.edu.ng	+2348035408895	0	0	2019-04-04 08:51:49.917562	2019-04-04 08:51:49.917562
1d3e956b-1ac2-4a43-b7a0-8b8851e368ab	Location	2c66a0f0-2d5f-4510-acd1-d02365e7c0d7	CUNOC	cunoc@covenantuniversity.edu.ng	+2348117756518	1	1	2019-04-04 11:13:03.125079	2019-04-04 11:13:03.125079
cab8cd37-5ff9-4488-84e0-30b64e39a593	Location	cd5cd203-33cd-4d81-8057-d7f8b5aaf520	Ekene Ezeasor	ezeasor.ekene@unizik.edu.ng	+2348063961963	0	1	2019-04-04 13:11:48.62479	2019-04-04 13:11:48.62479
62d6c4b8-1393-44ff-a524-c4f3d9a4ba33	Organisation	d732f8b8-d167-4dac-b175-724f7188be6a	Abdulkadir Danmaigoro	abdulkadir.danmaigoro@udusok.edu.ng	+2348038017393	0	1	2019-04-04 15:49:54.833282	2019-04-04 15:49:54.833282
39854884-81c7-4eec-be4e-ef2eb3bd9fd8	Location	35858a1c-23b2-40f6-8ef1-b47f8efa3010	Abdulkadir Danmaigoro	abdulkadir.danmaigoro@udusok.edu.ng	+2348038017393	0	1	2019-04-04 16:00:47.930194	2019-04-04 16:00:47.930194
f911e3f1-3676-4ace-a366-ec01a5c485da	Organisation	f897a4d3-44ca-4543-82aa-b4e502c6463e	Sati Satmer Dapel	dapels@unijos.edu.ng	2348036344965	0	0	2019-04-08 12:58:32.503784	2019-04-08 12:58:32.503784
4200c86c-4a4f-4762-8419-d02b894e21c9	Organisation	f897a4d3-44ca-4543-82aa-b4e502c6463e	Emmanuel Edemo	georgee@unijos.edu.ng	08033026065	0	0	2019-04-08 12:58:32.528291	2019-04-08 12:58:32.528291
2b941d8e-fd06-41b1-b2f5-18b26b08a74c	Organisation	9b15ed64-9965-4b8d-8857-98844f2a5e14	Azeez Faisal Abiola	fazeez@unilag.edu.ng	+2348082301337	0	1	2019-04-18 11:13:23.73127	2019-04-18 11:13:23.73127
523055cf-fc49-4a34-983d-c0e0a5557741	Location	7e6eba79-62c3-4720-93f3-416ea7b363d9	Azeez Faisal Abiola	fazeez@unilag.edu.ng	+2348082301337	0	1	2019-04-18 11:24:18.574792	2019-04-18 11:24:18.574792
ede3bb20-2c10-4cde-bf54-3b34e864965e	Organisation	991db693-847f-4626-ab05-c4bafd190f92	Mauridi Mohamed	mmohamed@costech.or.tz	+255 22 277 4023	0	0	2019-05-03 10:39:44.949125	2019-05-03 10:39:44.949125
8a5d27cd-8d3c-4deb-9616-56b767cb220c	Organisation	679f67b6-cf16-4c36-a887-77c06fb2d05b	Roy 	panganiroy@yahoo.com	+265 888 800 900	0	0	2019-05-15 14:56:47.183997	2019-05-15 14:56:47.183997
c843e8f8-a0ce-42d8-859d-fe6828d32f72	Organisation	b6c4ac4f-b841-48cc-9468-cd3a3e913fa7	Roy	panganiroy@yahoo.com	+265 888 800 900	0	0	2019-05-17 08:05:24.7892	2019-05-17 08:05:24.7892
34924224-236d-4917-96e6-82bcb8f85d1a	Organisation	911a5df1-70bb-43a6-99c3-9138271109ed	Alex Mwotil	alex.mwotil@ubuntunet.net	+260955884535	0	0	2019-05-13 08:34:36.870776	2021-04-06 07:48:45.960884
e8080e8a-8f5c-4009-9eed-a9e459c7b887	Organisation	7ccfcd5c-da2a-44d2-acff-f7a51ec5b199	Owen Iyoha	owen@eko-konnect.org.ng	+2348060442383	0	0	2019-02-27 13:09:07.401796	2019-06-14 07:17:04.157129
c9693992-0a06-46b9-88f9-0b5c8522c1c2	Organisation	7ccfcd5c-da2a-44d2-acff-f7a51ec5b199	Omo Oaiya	kodion@gmail.com	+2348088881571	0	0	2019-06-14 07:24:41.00055	2019-06-14 07:24:41.00055
0a75015f-55c5-4d26-a803-f615b7154c4a	Organisation	d785f154-2f0a-4055-be46-e44862c54a67	Yahaya Coulibaly	cyahaya@gmail.com	00223 66 35 99 98	0	0	2019-07-31 14:04:29.980083	2019-07-31 14:04:29.980083
38c74a03-1e05-400f-96c5-6838c4ee1c08	Organisation	5b033895-13ed-43b3-a21a-62fdb56e38d4	Emmanuel Togo	ematogo@garnet.edu.gh	+233 20 811 0248	0	1	2019-08-04 19:53:25.351383	2019-08-04 19:53:25.351383
d0feecc1-3e2d-4cb1-aa27-ae78c87ac0ac	Organisation	720b4990-7e36-4d61-83b5-09d2d0c46889	Emmanuel Togo	ematogo@ug.edu.gh	+233208110248	0	1	2019-08-04 21:01:25.842955	2019-08-04 21:02:35.962526
374effeb-7cf9-4431-94b7-ba6ef8551622	Location	7244f5ab-baad-47f0-9207-df980e1ca91e	Emmanuel Togo	ematogo@ug.edu.gh	+233208110248	0	1	2019-08-04 21:07:28.317248	2019-08-04 21:07:28.317248
cdfaf988-75cc-4ea4-a427-b8988878408e	Location	7be519c0-6bce-44a6-bc4b-730933c5b0a8	Emmanuel Togo	ematogo@ug.edu.gh	+233208110248	0	1	2019-08-05 10:33:46.527898	2019-08-05 10:33:46.527898
13d9fd24-6afd-48bc-bcd0-98a27ae658c5	Organisation	fad269fb-c5f3-4ab2-b7ce-2d5158df531a	Andriantsitohaina Lalanirina Jean	lalanirina@irenala.edu.mg	+261 34 30 412 42	0	1	2019-01-03 05:37:21.574537	2021-04-16 05:16:57.351452
a7da8535-94ea-4a6b-beff-d78075a58d17	Organisation	ba395f36-ef32-4db2-8042-0f23c6fccbcb	Lalanirina ANDRIANTSITOHAINA 	lalanirina@irenala.edu.mg	034 43 839 34	0	1	2018-07-24 15:13:52.60517	2020-12-07 07:09:39.583956
90661ba3-61af-4209-a11c-c77ba66c0b70	Location	f6e71221-a866-4095-99be-dc440dc499ee	Bridget Nyirongo	bnyirongo@cc.ac.mw	+265 995 14 86 26	0	1	2018-03-27 11:25:26.354704	2021-06-20 18:04:25.90724
9ce37680-bb95-4252-92e7-0f5047d6e706	Organisation	6461d70e-ebf3-4502-8125-6a4623ec2a9a	Bridget Nyirongo	bnyirongo@cc.ac.mw	00 265 1 524 222	0	1	2018-03-13 22:45:28.411364	2021-06-21 14:25:13.140185
58adae0b-985d-4c0c-8a80-f5d6e22e6f71	Location	1a5c8784-c197-481a-b081-af89176bfdc0	Emmanuel Togo	ematogo@ug.edu.gh	+233208110248	0	0	2019-08-05 22:17:15.123759	2019-08-05 22:17:15.123759
eedffdd6-1755-4178-9d6e-0f5f0566a3ac	Location	1e977911-197d-4a6a-b78c-d2d4208539ed	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-07 10:21:09.332569	2019-08-07 10:21:09.332569
ae2294d1-7b13-44b1-9f2c-029914041f5b	Location	e99acd89-9982-47de-b1fd-e24bf006721a	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-07 10:23:55.764863	2019-08-07 10:23:55.764863
6a81af18-d5e7-47c3-8142-a57e60ec39fc	Organisation	983c15ee-9a50-4725-bfc0-9e2067ec14fa	Samuel Kelly Brew	kelly_brew@knust.edu.gh	+233 20 736 0545	0	1	2019-08-06 06:36:07.314356	2019-08-06 08:06:19.020908
995f5049-fb0c-4963-a9f4-07d4a16c9840	Location	4a589fb5-6538-49de-932c-c9bd1ec02371	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-06 13:02:55.989817	2019-08-06 13:02:55.989817
0f14bf0a-d2f3-45bf-bd77-a8dbe6c9db94	Location	470853fd-52ca-479b-b2d3-be619f9a18ed	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-06 14:49:30.032648	2019-08-06 14:49:30.032648
73f82aa5-08b1-4c12-94f7-5215e8215f12	Location	17f46ece-0ba6-457d-85ba-09dc37a4c4b0	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-06 14:53:16.553031	2019-08-06 14:53:16.553031
f84939e5-a04d-4859-acf9-bfed51783f72	Location	2712dc28-b453-44de-99bd-adaf85c59081	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-06 14:58:06.510616	2019-08-06 14:58:06.510616
ab5400a9-0e96-4fe9-a635-84b59f0aef59	Location	d8f2a3a7-09ba-4f9a-b3f3-0f4bedc63fcd	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-06 15:00:12.748316	2019-08-06 15:00:12.748316
eedd4cf7-76a8-4812-a080-7eb968c47173	Location	3ea64816-b223-4b6c-a785-e836010f0b83	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-06 15:01:24.02079	2019-08-06 15:01:24.02079
e88824a3-c2cd-4299-9fbc-d53d79b9f191	Location	98192fb7-578b-4e9a-a3a8-9613fc7b856f	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-06 15:03:13.365416	2019-08-06 15:03:13.365416
ecc3a911-0a03-4d08-a061-caee834095b4	Location	c63419fb-7df2-4118-b967-1ff3ebed7a6f	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-06 15:04:53.165767	2019-08-06 15:04:53.165767
0a8942bd-58a8-43ee-be8d-b985a1991523	Location	55e8405c-96af-4004-b7cb-d3c3eb0d3eae	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-06 15:04:54.657664	2019-08-06 15:04:54.657664
1c675eda-3689-4277-8155-005c8d4b597f	Location	8c676cfb-f2f3-4ea3-8e92-3e481ea1e778	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-06 15:04:57.067077	2019-08-06 15:04:57.067077
f3c67901-fd24-4c3c-a1b3-290751df4e55	Location	de281323-cdf2-4098-94c4-76fbcee9cb07	Samuel Kelly Brew	kelly_brew@knust.edu.gh	0207360545	0	0	2019-08-06 15:08:33.104306	2019-08-06 15:08:33.104306
94af60b7-d34d-4bc2-90c9-480b156d8bf3	Location	c6274974-782d-4d86-a2cb-cb0cea017850	Samuel Kelly Brew	kelly_brew@knust.edu.gh	0207360545	0	0	2019-08-06 15:12:59.110392	2019-08-06 15:12:59.110392
4c50c2f7-22de-47ca-8d07-e2cc7aea38fb	Location	c81c1343-38e1-44b7-a4e2-c7bee9181edf	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-06 15:14:59.757757	2019-08-06 15:14:59.757757
21306bec-26b0-4016-bdca-2fa622aa690c	Location	281b8570-0af5-47e5-8850-72650e9bb34b	Samuel Kelly Brew	kelly_brew@knust.edu.gh	0207360545	0	0	2019-08-06 15:15:24.664517	2019-08-06 15:15:24.664517
68ce1dc1-7442-45a8-83c8-a1f6dad35fd9	Location	7ea10b78-2dce-462a-9189-7f740d32a6ce	Samuel Kelly Brew	kelly_brew@knust.edu.gh	0207360545	0	0	2019-08-06 15:28:49.6033	2019-08-06 15:28:49.6033
52b8931b-bfbd-43e7-9e38-49b20b872e9f	Location	c4669900-ca9f-48bd-b400-1337edc3c159	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-06 15:33:47.883991	2019-08-06 15:33:47.883991
10f058c5-c168-4ec5-9245-357261778786	Location	98b68fc7-6643-43df-a77f-33bf7cc14f1d	Samuel Kelly Brew	kelly_brew@knust.edu.gh	0207360545	0	0	2019-08-06 15:34:23.476638	2019-08-06 15:34:23.476638
de73f248-3270-47ed-95b7-4895ba7d1a8d	Location	f189cf9e-c062-4288-9120-99f6e741f0b5	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-06 15:38:07.867264	2019-08-06 15:38:07.867264
45db91f2-d9a2-4f91-9751-d95297352a98	Location	81651cf9-2308-4db2-83e6-1eeb328f1813	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-06 15:46:11.105555	2019-08-06 15:46:11.105555
6ea8edc7-804c-4b3b-8bbf-270484a4ac97	Location	c17fc053-1f50-4940-9fc3-2975991326e8	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-06 15:48:20.46749	2019-08-06 15:48:20.46749
da6ab7b6-f2a1-45f7-ba93-eadaaba459a1	Location	5ea787c1-230b-4b10-8a96-e1daedbb015a	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-06 15:50:07.232899	2019-08-06 15:50:07.232899
316f905e-c681-4306-9122-f48d2262755b	Location	9164f2f5-30e1-46b0-a40b-d630d44bdc2b	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-06 15:52:32.694136	2019-08-06 15:52:32.694136
e25cd3e4-610a-40b1-a7f9-53288456442f	Location	23d0e5bc-dea5-4bd6-9375-7b33403e4f10	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-06 16:08:27.083745	2019-08-06 16:08:27.083745
f23e3b82-93c4-49ce-b977-e38620334387	Location	4f34c792-05ae-48b5-a2e4-8aa7b21d2443	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-06 16:11:58.168022	2019-08-06 16:11:58.168022
d5a901f7-2fc8-478e-a2c5-78109e70a99f	Location	7a535503-e260-4304-b6b5-cd28471b7831	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-06 16:20:12.587315	2019-08-06 16:20:12.587315
039d5e06-3fe4-4a90-a030-558bc49c961d	Location	72a90642-1df4-4099-88ac-7f0c5701d202	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-06 16:30:35.293145	2019-08-06 16:30:35.293145
ba734a80-8d4f-4f7a-a844-ca30fb3264a1	Location	cd4a2e76-7c0c-467c-b72f-479de882224a	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-06 16:32:37.832265	2019-08-06 16:32:37.832265
62c0e5a7-d351-4e93-a651-a381d3e5a2c0	Location	a497f23b-9371-4393-9f52-7ddbec12033f	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-06 16:34:47.506353	2019-08-06 16:34:47.506353
65f968e0-cae8-463c-a6da-436007450c25	Location	fdc2173c-a570-4d34-9f85-fed256350901	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-06 16:39:35.783162	2019-08-06 16:39:35.783162
021bfb91-1fe6-48de-bd18-c83ea72d3308	Location	c496b833-d462-4d21-bf0b-d9dce167be62	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-06 16:43:35.206569	2019-08-06 16:43:35.206569
83d86dd5-100e-4c3f-b6ba-c564ef0e55fe	Location	d2a132df-784c-468c-b006-a0965d0e8a16	NOC	noc@ug.edu.gh	+233302213820	0	1	2019-08-06 16:45:27.155087	2019-08-06 16:45:27.155087
6e431d0d-af16-4cc1-8e08-a81b359103f4	Location	8924369e-94b1-4f7d-8ecd-823396fa3468	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-06 16:52:03.652996	2019-08-06 16:52:03.652996
c98dd885-e788-4f29-b6fc-ec0aacab37b9	Location	a0f66bdc-c12d-47d7-81db-2ab25f2e1282	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-06 16:55:29.204947	2019-08-06 16:55:29.204947
3e2432c5-e1e9-4b55-af4e-dbfef009ef0b	Location	bf722ab4-b455-4b11-8e7d-e8c055f3c6bc	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-06 17:03:05.050419	2019-08-06 17:03:05.050419
c23d6001-2dba-4d38-a2af-35a350e18152	Location	7ee138f9-5af1-46ac-90cb-2113cd252d17	NOC	noc@ug.edu.gh	+233302213820	1	0	2019-08-07 08:46:00.970381	2019-08-07 08:46:00.970381
1e5b06a5-9d80-4d48-aa17-941a426078c8	Location	ac99ea85-6eab-49ce-8b75-c2d254ee64f0	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-07 08:49:06.557691	2019-08-07 08:49:06.557691
065b7375-f66d-450a-b0d7-24af940cbbdd	Location	1d1038e1-0d0a-4027-ad84-ca3856ad6998	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-07 08:53:39.792629	2019-08-07 08:53:39.792629
e84cc7f8-0f97-4a14-ac90-6d7603919571	Location	9c6e6b33-c255-438d-80aa-6cf0f3d790f8	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-07 08:59:29.122017	2019-08-07 08:59:29.122017
cced3790-b905-40b8-976e-fb5037cce408	Location	1e5823f8-96db-4f06-a06e-0e6bbb4c9349	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-07 09:03:02.928288	2019-08-07 09:03:02.928288
90390592-5bb5-4be7-95a0-24c10f682647	Location	fe0c19b7-e4cc-4ed9-9da2-b17d6f1e1abd	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-07 09:07:58.642368	2019-08-07 09:07:58.642368
eafe9ae0-15b3-4ed3-ab07-4ba50ac01d36	Location	1c1638bb-9a7d-49c8-9d87-d9278469920b	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-07 09:13:45.678212	2019-08-07 09:13:45.678212
08b27d3d-7249-47bf-9a19-8a4a65d24172	Location	57b67154-f678-4704-9f0e-ca8350a04f8b	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-07 09:24:27.167429	2019-08-07 09:24:27.167429
58f7a057-5954-40c8-9ae4-8bbc7ed0cd85	Location	40231793-3519-41aa-a01b-6bfa94390118	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-07 09:27:33.277915	2019-08-07 09:27:33.277915
21c0336f-7b30-4f59-bc6c-282f27d51aa4	Location	08d96490-cee3-42fe-a312-0227cc8e1dbe	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-07 09:29:00.336297	2019-08-07 09:29:00.336297
b7e4507a-33ee-4b3b-978a-6960d9cb6175	Location	64d33e90-4154-4366-a482-00b844ee7799	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-07 09:30:20.608456	2019-08-07 09:30:20.608456
bd88438c-19d9-463d-a159-0cdc5b9e3a95	Location	2d85be45-66fc-40ea-bf9e-88b387ad6422	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-07 09:34:04.17511	2019-08-07 09:34:04.17511
72cfdd32-e965-49db-8ef1-76afbff980be	Location	3ecc6c9c-30e1-42a4-a2d4-df69fd0b5e13	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-07 09:51:53.970102	2019-08-07 09:51:53.970102
1f30f99a-0076-4ede-90b8-9071bed23caf	Location	ccc7f73e-4a81-464e-8a93-757ccc450cad	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-07 09:53:13.206997	2019-08-07 09:53:13.206997
521f33bb-75d3-4c4f-94b0-5fd41656d144	Location	544bb5df-170f-48d8-8e0c-dd95955facd7	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-07 10:01:47.048097	2019-08-07 10:01:47.048097
1db76dfd-3f1b-44e1-961a-16cbdd529066	Location	c0a880ec-d563-4189-9be8-fdc968e804df	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-07 10:04:04.362191	2019-08-07 10:04:04.362191
b997d8f5-f40d-4729-ba16-dbae96dfe49d	Location	a81bdaf1-b144-499c-9f92-3232450f8692	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-07 10:32:51.787619	2019-08-07 10:32:51.787619
1fa7ba44-4bcf-496a-b347-6bb23d6aae45	Location	038eed1e-fd13-48ed-9a6f-48326ab4be73	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-07 10:34:46.580103	2019-08-07 10:34:46.580103
9958c8a0-8bab-4efa-bda6-383c7d9ff2a5	Location	da8335fd-5f85-4305-b5dc-576125731eba	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-07 10:37:45.736552	2019-08-07 10:37:45.736552
b57b075f-47f1-455b-8879-bd1d24d6289e	Location	91de73b2-351d-4f09-8929-c51e9f25d2b3	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-07 10:42:52.254225	2019-08-07 10:42:52.254225
30483253-0265-40b8-97aa-4c384d140bce	Location	476d0628-2adb-4ee9-a169-34cbdd8b49db	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-07 11:02:14.285336	2019-08-07 11:02:14.285336
d77efe50-a0b7-45c5-b91e-68618e7c9495	Location	318c3911-1fd3-4856-bcac-d12cbb482ed0	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-07 11:15:24.438943	2019-08-07 11:15:24.438943
0df280de-e52b-4a57-9248-adf083ad682a	Location	f779763a-c926-4b2e-a7c0-48b77fcb9a9d	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-07 11:21:50.778458	2019-08-07 11:21:50.778458
505f730f-9a50-4628-84e4-125a5728baf3	Location	a6a374eb-268d-49d1-bf17-9aa1011970c8	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-07 11:25:17.289546	2019-08-07 11:25:17.289546
dd7b23ef-5894-424a-b663-37057fbda315	Location	a5d32ba3-9631-441f-913b-8f99b58c8aa6	NOC	noc@ug.edu.gh	+233302213820	1	1	2019-08-07 11:32:16.858772	2019-08-07 11:32:16.858772
6bb29bf6-f559-4118-b3de-d2e16788cb25	Organisation	1e4bdaed-2062-439e-8ef3-593bdb2c4701	Ato Yawson	ayawson@ashesi.edu.gh	+233208136172	0	1	2019-08-07 15:27:39.046238	2019-08-07 15:27:39.046238
e93fdfa9-5f2d-4541-963b-6e4230de7937	Location	8e3edbfd-a7ee-4e80-acfc-f7f2505fd23f	Samuel Kelly Brew	kelly_brew@knust.edu.gh	0207360545	0	0	2019-08-08 11:33:08.864019	2019-08-08 11:33:08.864019
248d50c3-5b90-41dc-8e04-0206661d10b1	Location	c509880d-7e70-4b74-86bc-e8fc319d4d90	Samuel Kelly Brew	kelly_brew@knust.edu.gh	0207360545	0	0	2019-08-08 11:46:26.080318	2019-08-08 11:46:26.080318
193eecc8-b33c-45a3-bb76-73a916f401df	Location	11db708a-343e-420e-a975-123db5815fb2	Samuel Kelly Brew	kelly_brew@knust.edu.gh	0207360545	0	0	2019-08-08 11:52:03.007944	2019-08-08 11:52:03.007944
102a9f19-6534-47e1-a3df-fa934d8dccc8	Location	91b1721d-702d-4f35-8fa3-9f9580967c0e	Samuel Kelly Brew	kelly_brew@knust.edu.gh	0207360545	0	0	2019-08-08 11:55:26.645096	2019-08-08 11:55:26.645096
e2f585f7-0325-4e49-94b2-4392caf410bc	Location	b3689bc6-2963-48df-bad0-3a4f90578789	Samuel Kelly Brew	kelly_brew@knust.edu.gh	0207360545	0	0	2019-08-08 11:59:19.454899	2019-08-08 11:59:19.454899
46528dc5-c443-4029-ab87-a377d0663794	Location	b517602d-def9-4fb2-be65-eea3dfacb200	Samuel Kelly Brew	kelly_brew@knust.edu.gh	0207360545	0	0	2019-08-08 12:07:03.099453	2019-08-08 12:07:03.099453
d0f74435-12da-4f6a-a633-56a644157e0d	Location	6014c42d-5f6a-4398-8ba9-639b11f42a49	Samuel Kelly Brew	kelly_brew@knust.edu.gh	0207360545	0	0	2019-08-08 12:12:45.185317	2019-08-08 12:12:45.185317
aa162ede-8686-4399-96e1-848b37ba1aae	Location	4f30f466-cf19-4bd9-96a6-50dae24f9a0c	Anaobi Ishaku	anaobii@unijos.edu.ng	+2348037008529	0	0	2019-08-09 11:58:34.1958	2019-08-09 11:58:34.1958
f9febc73-377b-47a1-851c-63dba1a66b8d	Organisation	1e45e65b-9167-4cc9-bbb7-1f11d63e70d8	Maybin Lweendo	maybin.lweendo@tvtc.ac.zm	+260977948322	0	0	2019-09-23 10:30:58.660563	2019-09-23 10:30:58.660563
2bd9b817-db09-4e12-8e07-8a821a5721f9	Organisation	64f81d4e-7d1a-4a40-b5b8-b1ddd99e5ecc	Victor OYETOLA	victor.oyetola@uac.bj	+22995568551	0	0	2019-10-01 10:48:52.73251	2019-10-01 10:48:52.73251
50622dff-1aee-40dc-8b8f-445361868648	Organisation	549299ce-02f6-4aed-bc57-b8e5131ff7f3	Sidy Soumare	sidy@icermali.org	+223 76408835	0	0	2019-10-04 14:21:02.28712	2019-10-04 14:21:02.28712
dd3cebd4-a725-4532-9783-6ac81ceb3643	Organisation	35d18cea-9f0b-42b3-989d-f9ea84b94ef6	Eric ATTOU	eric.attou@wacren.net	+229 95798641	0	0	2019-10-16 11:12:50.363774	2019-10-16 11:12:50.363774
183b952e-e875-4f8f-927a-4cddb1c3c1f0	Organisation	faddfab4-02d0-45b3-9ac1-351eacfd4efa	Lois Mvula	info@chau.ac.zm	+260977960163	0	0	2019-10-30 13:12:35.952404	2019-10-30 13:12:35.952404
c5ab550d-268c-43bf-910f-c04db5e6e9e0	Organisation	aee1e708-5a8f-4465-a558-97c61110d4bb	Modou DIOUF	modou.diouf@ucad.edu.sn	+221774316578	0	0	2019-10-30 16:04:29.149034	2019-10-30 16:04:29.149034
90ea2256-acdb-472b-86e1-3024ef2b197a	Organisation	d6ec3437-802b-418e-8c40-08fc96e9bcc9	Victor OYETOLA	victor.oyetola@uac.bj	+22995568551	0	0	2019-11-19 11:15:53.827031	2019-11-19 11:15:53.827031
ccd5a20f-739b-4f57-8c60-de5fb15391d1	Organisation	d6ec3437-802b-418e-8c40-08fc96e9bcc9	Eric ATTOU	eric.attou@uac.bj	+22995798641	0	0	2019-11-19 11:15:53.83879	2019-11-19 11:15:53.83879
08315d10-99c1-48ea-8c59-f5392f6aaf08	Organisation	0a67d914-b70f-4970-ad77-6b8caf423852	Nigatu Nigusie 	nigatu.nigusie@ethernet.edu.et	+251911816166	0	1	2018-07-24 15:33:55.191839	2019-12-11 09:24:50.891027
322d751b-b20c-4f79-9ec7-44aa96277333	Organisation	53cd2ce3-bd7b-420c-8802-a4731571da47	Kilongi Kayera	kkayera@ihi.or.tz	+255657320316	0	0	2020-02-27 14:38:46.033595	2020-02-27 14:38:46.033595
4134b5b0-0759-45dc-9207-b30cac31705a	Location	4925482f-825c-4cac-9a1b-625cca95899e	Nigatu Nigusie	nigatu.nigusie@ethernet.edu.et	+251929299164	0	0	2020-02-29 06:47:43.34964	2020-02-29 06:47:43.34964
cc1599d7-9fd9-4357-a7b8-662e7492b96d	Location	6b092ff0-46a5-4ba6-9545-aea2f4e6590b	Igba Priscillia	igbap@unijos.edu.ng	+2348035408895	0	0	2020-03-03 12:45:19.343866	2020-03-03 12:45:19.343866
5926f46a-72cc-4509-a438-9bf68f5105b2	Location	cece05f8-00e5-49ed-a24a-584ebcfcb44f	Igba Priscilla	igbap@unijos.edu.ng	+2348035408895	0	0	2020-03-04 08:53:44.921167	2020-03-04 08:53:44.921167
643972f2-1daf-4401-9d4d-71016a5c1072	Location	3cd7621f-5539-4035-8729-08adbd2e22f0	Igba Priscilla	igbap@unijos.edu.ng	+2348035408895	0	0	2020-03-04 08:55:31.618191	2020-03-04 08:55:31.618191
4d86623d-a3a6-481a-bfc1-5cef33aaa971	Location	ad495a86-dc97-4634-9c38-1c74825fd3ea	Igba Priscilla	igbap@unijos.edu.ng	+2348035408895	0	0	2020-03-04 08:58:08.764838	2020-03-04 08:58:08.764838
e8bd0e40-e9f7-4a28-80df-9612b5c5b8a7	Location	b4fc7f15-99dd-4471-bccb-a2ead832d8c9	Igba Priscilla	igbap@unijos.edu.ng	+2348035408895	0	0	2020-03-04 08:59:15.205316	2020-03-04 08:59:15.205316
298edb69-39cd-44da-81ec-5252638a2bb8	Location	a7181ef6-8df2-4def-9f8b-e2ce2a3100a0	Igba Priscilla	igbap@unijos.edu.ng	+2348035408895	0	0	2020-03-04 09:00:22.531768	2020-03-04 09:00:22.531768
1faa6c12-6aa2-4368-be91-e3e03c879d2f	Location	93d6f58f-efa3-4516-9698-2f04cbea7db0	Igba Priscilla	igbap@unijos.edu.ng	+2348035408895	0	0	2020-03-04 09:02:19.480604	2020-03-04 09:02:19.480604
97a45223-9187-48dc-9751-0008747ab39d	Location	c1c1ba9d-6f90-4e88-9a75-27c4c98a7036	Igba Priscilla	igbap@unijos.edu.ng	+2348035408895	0	0	2020-03-04 09:05:44.514477	2020-03-04 09:05:44.514477
c1995b91-efc2-462a-a602-569b7ac2e5ee	Location	737a1574-e746-4a6d-9b2e-375ab6105b0d	Igba Priscilla	igbap@unijos.edu.ng	+2348035408895	0	0	2020-03-04 09:06:28.125919	2020-03-04 09:06:28.125919
a1f14ba3-b03c-4bdb-a146-71cf05a2985d	Location	2fe4b053-3cd9-491b-987a-4061457e783f	Igba Priscilla	igbap@unijos.edu.ng	+2348035408895	0	0	2020-03-04 09:07:28.557436	2020-03-04 09:07:28.557436
7d0930bd-a42b-4185-80a4-f9ec50974cbd	Location	61d83ad3-01a1-4dc7-a67d-b23548ab5735	Igba Priscilla	igbap@unijos.edu.ng	+2348035408895	0	0	2020-03-04 09:08:07.714296	2020-03-04 09:08:07.714296
3a78c715-904e-42db-9332-605a49bb09d9	Location	6b84c295-0ce8-44aa-8058-154ee9a9d355	Igba Priscilla	igbap@unijos.edu.ng	+2348035408895	0	0	2020-03-04 09:08:48.912715	2020-03-04 09:08:48.912715
bd63d478-bb22-411c-bf6f-9a6960b5f761	Location	c4ba8460-8a81-4c7e-852b-ab8f7515f7ce	Igba Priscilla	igbap@unijos.edu.ng	+2348035408895	0	0	2020-03-04 09:09:37.934564	2020-03-04 09:09:37.934564
4662d960-78f0-4327-a1f5-b83409d45c4d	Location	66083abe-8a10-4b3f-a802-8ac3bb09fe5e	Igba Priscilla	igbap@unijos.edu.ng	+2348035408895	0	0	2020-03-04 09:10:10.410024	2020-03-04 09:10:10.410024
2cb7a515-d477-47d0-85a9-3dda4a9f8e77	Location	4b1e7a68-c0dd-47d2-85f3-4d1857c84fb3	Igba Priscilla	igbap@unijos.edu.ng	+2348035408895	0	0	2020-03-04 09:11:13.784039	2020-03-04 09:11:13.784039
07cb2583-34f1-4fa7-a753-fc7287c38e24	Location	e6701145-1bd2-4da9-a3a7-928ee88dfbba	Igba Priscilla	igbap@unijos.edu.ng	+2348035408895	0	0	2020-03-04 09:14:16.827937	2020-03-04 09:14:16.827937
b739868d-c7cf-4fd2-ae1e-09b692900d43	Location	7e37fe8d-448b-4347-8f5d-13a897b1f28f	Igba Priscilla	igbap@unijos.edu.ng	+2348035408895	0	0	2020-03-04 09:15:09.815261	2020-03-04 09:15:09.815261
4e6a46de-5ea2-4bb3-a727-45179c798cc8	Location	91bf4fd6-b625-4db0-a1d2-907e310d8ba8	Igba Priscilla	igbap@unijos.edu.ng	+2348035408895	0	0	2020-03-04 09:16:29.067845	2020-03-04 09:16:29.067845
5fbdc6fa-10af-4386-a976-86f0de93470a	Location	86e6d2c7-821c-47b6-8bb6-c399978d9b6d	Igba Priscilla	igbap@unijos.edu.ng	+2348035408895	0	0	2020-03-04 09:17:32.040955	2020-03-04 09:17:32.040955
ba3b5479-a8b2-4085-bd4c-0e24d70e934b	Location	61998dba-ce3f-4c24-9051-60d1d581f8ce	Igba Priscilla	igbap@unijos.edu.ng	+2348035408895	0	0	2020-03-04 09:18:10.137678	2020-03-04 09:18:10.137678
d23811a9-1685-4017-897c-a9734517b725	Location	11c87fe6-e931-4453-a29a-4647602dc1b5	Igba Priscilla	igbap@unijos.edu.ng	+2348035408895	0	0	2020-03-04 09:19:20.218407	2020-03-04 09:19:20.218407
ee59c4ce-c47b-432b-af30-d078100eee87	Location	ac431f27-aa43-47b7-a2c2-b9a99a6d5d6e	Igba Priscilla	igbap@unijos.edu.ng	+2348035408895	0	0	2020-03-04 09:20:41.233217	2020-03-04 09:20:41.233217
4d54a418-3e1a-4caf-a40e-6d451ca767fe	Location	61fd7d02-7660-4de9-8f3a-b451499c3db7	Igba Priscilla	igbap@unijos.edu.ng	+2348035408895	0	0	2020-03-04 09:21:54.726157	2020-03-04 09:21:54.726157
bf596f75-8f9e-4720-a2aa-a6ad33402a91	Location	f3bdd6e8-cf26-4984-863c-4f01f47ac359	Igba Priscilla	igbap@unijos.edu.ng	+2348035408895	0	0	2020-03-04 09:22:24.708699	2020-03-04 09:22:24.708699
61ed93fc-2dac-4d7d-a811-c6263757e5f6	Location	f6d749b3-e281-4886-a14d-e63bf8ca4e4d	Igba Priscilla	igbap@unijos.edu.ng	+2348035408895	0	0	2020-03-04 09:23:03.630095	2020-03-04 09:23:03.630095
39a05228-7f12-44bd-b970-a743129caf7e	Location	f2ddd37e-05fc-4514-aaf6-9f0c45660f80	Igba Priscilla	igbap@unijos.edu.ng	+2348035408895	0	0	2020-03-04 09:25:34.412387	2020-03-04 09:25:34.412387
8ef06555-6945-4436-abfc-55459294f5b9	Location	1cb045d8-7d91-40de-a301-70c328dcfb3d	Igba Priscilla	igbap@unijos.edu.ng	+2348035408895	0	0	2020-03-04 09:27:47.00158	2020-03-04 09:27:47.00158
95187058-c483-4c9b-a38e-304c0a1b0380	Location	d960e095-0ac9-4ae5-8a0c-7eb99f1ebaf3	Igba Priscilla	igbap@unijos.edu.ng	+2348035408895	0	0	2020-03-04 09:28:22.1416	2020-03-04 09:28:22.1416
63d7f5df-1690-4d93-9bf4-69b5bb532800	Location	c78502ce-015c-4a83-aa78-750ab2b854a4	Igba Priscilla	igbap@unijos.edu.ng	+2348035408895	0	0	2020-03-04 09:28:59.850219	2020-03-04 09:28:59.850219
2a469663-1e95-4fc0-9d8b-d41437abb550	Location	34e2e556-abe9-412b-8236-40812e006643	Igba Priscilla	igbap@unijos.edu.ng	+2348035408895	0	0	2020-03-04 09:29:49.607249	2020-03-04 09:29:49.607249
8d300633-296c-44a1-96fb-c1d935c8946e	Location	1ed1c43b-9119-4170-9867-54b6620f9b2a	Igba Priscilla	igbap@unijos.edu.ng	+2348035408895	0	0	2020-03-04 09:30:22.334412	2020-03-04 09:30:22.334412
ddf7254b-7c1f-4620-9181-34ad0bfde73b	Location	d34a8c91-c44d-4ce4-8604-c294425f3edc	Igba Priscilla	igbap@unijos.edu.ng	+2348035408895	0	0	2020-03-04 09:30:55.548936	2020-03-04 09:30:55.548936
3fe8a247-9f80-4ef6-bb77-e6ea5c577dd5	Location	76133617-5b79-40fc-81eb-12188b395a58	Igba Priscilla	igbap@unijos.edu.ng	+2348035408895	0	0	2020-03-04 09:31:51.298333	2020-03-04 09:31:51.298333
48fdd74c-c6d3-4ea6-966f-c521cb9457a1	Location	899313e0-730d-4c25-8f2a-fa8e02cdab5e	Igba Priscilla	igbap@unijos.edu.ng	+2348035408895	0	0	2020-03-04 09:32:50.068153	2020-03-04 09:32:50.068153
a3991b7c-8572-484b-92bd-e320cd26257f	Location	e5a6bcec-ab50-4e5f-840d-e75f8e6ca6dd	Lalanirina Jean ANDRIANTSITOHAINA 	lalanirina@irenala.edu.mg	+261 34 30 412 42	0	0	2019-10-16 11:59:36.931363	2021-04-16 08:01:56.472485
73451663-406b-4160-8d4c-65967b2ac0d4	Organisation	bdbce8c6-b4e0-4504-ad5f-d2c5440a7213	Nyasha Nkokera	nkokera@gmail.com	+263 242 741 576	0	0	2020-06-01 13:06:05.995938	2020-06-01 13:06:05.995938
dbfcad84-f0b6-4121-872f-21bc68b1e44c	Organisation	c7b1c506-aaf5-4e61-b7cb-4d4feb85a5bd	Mpande Ntumbo	mntumbo@ru.edu.zm	+260968520315	0	0	2020-09-17 15:32:58.561475	2020-09-17 15:32:58.561475
885bbf3d-a403-44e5-9be0-6ab3758880df	Location	05707278-bf54-4f0a-b85e-d48edce107d4	Samuel Kelly Brew 	kelly_brew@knust.edu.gh	0207360545	0	0	2020-09-25 16:02:24.623977	2020-09-25 16:02:24.623977
e0330e3b-8a96-441c-bfb2-13eaf2acf169	Location	42aeb587-d91b-4665-9b17-9b048f0c14d9	Samuel Kelly Brew	kelly_brew@knust.edu.gh	0207360545	0	0	2020-09-25 16:19:00.594729	2020-09-25 16:19:00.594729
842cf674-511a-4301-af56-3118edc81a34	Location	bf6fbc17-189d-40a8-a40d-fd10fa13cbca	Samuel Kelly Brew	kelly_brew@knust.edu.gh	0207360545	0	0	2020-09-25 16:23:08.736177	2020-09-25 16:23:08.736177
4c773a39-0aff-4163-a3f0-cab34d79de81	Location	280d5af0-eeab-44e0-9d6e-384a6b05be94	Samuel Kelly Brew	kelly_brew@knust.edu.gh	0207360545	0	0	2020-09-25 16:30:04.878993	2020-09-25 16:30:04.878993
25df6de7-c6c6-47bc-9a68-56fcec2f847e	Organisation	d12bcb08-d0c5-4a5f-aedb-e1042a3e866e	Honest Phiri	honest.phiri@nipa.ac.zm	+260978541908	0	0	2020-10-02 07:40:15.460515	2020-10-02 07:40:15.460515
6e93fd71-d0be-4a54-a21f-f4bda07642cc	Organisation	4266f4f5-9131-48d9-9ba4-042b7ed34f8f	Henry Joke	ict@lbtc.ac.zm	+260977111650	0	0	2021-04-08 12:34:57.588048	2021-04-08 12:34:57.588048
d0d40e4d-0f42-4d30-b946-1b23f01e6e8d	Organisation	82797b17-9b81-45ca-b904-24671e521f97	Hazinji Wafer	hazinjiwafer@gmail.com	+260977622898	0	0	2020-11-30 13:14:40.052329	2020-11-30 13:14:40.052329
3b21eac0-0f6c-4902-9134-8d55f3d3df69	Organisation	5392bfa3-cf25-4e13-8528-d42baa9b7e7c	William Sichilima	wsichilima@yahoo.com	+260966821889	0	0	2020-12-14 07:33:44.735965	2020-12-14 07:33:44.735965
075d6318-4938-4d2d-b457-46ee5db0c04f	Organisation	a42b1866-4163-45e2-b093-3edc1e6a71d9	Joseph Mitembo	josephmitembo@gmail.com	+260 969444705	0	0	2020-12-14 15:17:37.123172	2020-12-14 15:17:37.123172
d2899d30-d707-47a9-8acf-e7fb9b9e787b	Organisation	05dab0bd-ad04-4820-a02a-15aa3e255b8f	Chileshe Francis	chileshef@hotmail.com	+260 977561663	0	0	2020-12-14 20:35:04.974031	2020-12-14 20:35:04.974031
736228aa-5130-46cc-b84a-b568a19ce676	Organisation	3a6f9417-4853-4522-863e-9c2e43aea6fa	Robert Theo	theorobert2012@gmail.com	+260 950516465	0	0	2020-12-14 20:45:39.612948	2020-12-14 20:45:39.612948
cceea82f-78bb-44b7-8f16-10d192a37c17	Organisation	48a3cb01-a52f-4f23-bc45-4d0e5a93f77e	Ken Ziyambo	kenzyambo@gmail.com	+260 978506193	0	0	2020-12-14 20:49:45.892268	2020-12-14 20:49:45.892268
6e54c7e9-65f2-4be8-9bcf-646938c16f4c	Organisation	cc373e93-f7d1-424e-9c21-801c6f1f758e	Jacob Funyina	lucninservice@gmail.com	+260 977828650	0	0	2020-12-15 06:52:55.351326	2020-12-15 06:52:55.351326
a5e04c7d-2366-4ec9-8b3a-fc9f5208814c	Organisation	e656e725-44cd-482a-b465-0340255d8ff6	Mubinda Julius	juliusjew@gmail.com	+260 978672575	0	0	2020-12-15 07:00:02.015609	2020-12-15 07:00:02.015609
e488960b-6e30-4863-9009-ca65c5a51fde	Organisation	cb11e742-b109-4f19-8a0f-f14481602895	David	david@dsn.eduzm	+260 966755646	0	0	2020-12-15 07:12:54.928802	2020-12-15 07:12:54.928802
a145cf7a-48a3-4a7f-80dd-1469e9e05c35	Organisation	bf33d3ba-99ba-4c1b-9c33-3310a65f09db	Allan Phiri	allanaangphiri@gmail.com	+260 979598200	0	0	2020-12-15 07:43:38.189356	2020-12-15 07:43:38.189356
035388dd-6df3-44ed-bba0-381cf9992952	Organisation	350d84c1-c277-4363-a6dd-d58256b7b37e	Yohan Sabuni	ysabuni47@gmail.com	+260 973036611 	0	0	2020-12-15 07:53:07.419377	2020-12-15 07:53:07.419377
52b36a4f-973c-4051-bf02-cbe7ab987f2b	Organisation	e89d53a5-d527-4ec0-a588-87e98d8b8148	Fred Samungole	fsamungole@gmail.com	+260 977522417	0	0	2020-12-15 07:59:16.930443	2020-12-15 07:59:16.930443
d4292d8f-946e-4ed4-9e6c-2b48f20930f1	Organisation	dccddb90-cbe6-46cb-a624-14b4dbf7e066	Joseph Ngombo\t\t	ngomboj5@gmail.com	+260 977140281	0	0	2020-12-15 08:02:36.870056	2020-12-15 08:02:36.870056
ab7c6f62-87c2-4c3c-9b04-48517d395e22	Organisation	b3a6cfc1-b91c-485c-a005-4219b90eb83f	Mweetwa Derrick\t	dmweetwad@gmail.com	+260 968445283	0	0	2020-12-15 08:15:31.098811	2020-12-15 08:15:31.098811
5019599e-f17e-4abb-b29d-376ec47de1a1	Organisation	ab836e55-9912-4a2a-a1ab-85df51382ef3	Stainley Mudenda\t	listan04@gmail.com	+260 972461984	0	0	2020-12-15 08:18:48.471611	2020-12-15 08:18:48.471611
c9b448d4-ec9b-4d88-9ee5-dbbcf49aa061	Organisation	5f2139d1-75e0-4ac5-a44f-6381ee9f8c57	Allan chikoto\t	chikotiallen@yahoo.com	+260 975695963	0	0	2020-12-15 08:29:30.317004	2020-12-15 08:29:30.317004
0adc16c8-9c8c-4626-bfb7-7aa6694791ef	Organisation	00b18d3a-29c2-4e6a-bee3-453587844688	Mr Mooka\t	lubindamooka85@gmail.com	+260 978177576	0	0	2020-12-15 08:38:12.254888	2020-12-15 08:38:12.254888
b53fe785-0d6e-40bb-9906-0942b1924ae5	Organisation	b6f60b7d-230f-47e1-9580-11e6d899b539	Mateo\t	matteoraymond@yahoo.com	+260 955097579	0	0	2020-12-15 09:02:58.750714	2020-12-15 09:02:58.750714
b0de9e41-427e-4128-9d14-84dce305b82c	Organisation	cab21e0d-202d-401f-951b-eddad5f148f1	Mr Chileshe\t	chileshepm@gmail.com	+260 971788635	0	0	2020-12-15 09:07:58.961941	2020-12-15 09:07:58.961941
10d52ca4-d04c-4765-98c2-802673a3770c	Organisation	8dfc790e-ad17-467a-bc25-af17f7004c64	Mark Mwale\t	makubalof@gmail.com	+260 955202616	0	0	2020-12-15 09:22:21.690486	2020-12-15 09:22:21.690486
44ed7e11-bb2a-43d9-9faa-f4d55b84f4e4	Organisation	1b7f3dec-e631-4cf3-bdd4-a68074eeefd1	Musonda William Bright\t	musondawilliam@outlook.com	+260 967029980	0	0	2020-12-15 09:27:05.724405	2020-12-15 09:27:05.724405
2a1ae0e8-4450-41d7-86cc-f3bc4fe15598	Organisation	c709dc8e-aecc-4ce0-a1c2-bfe815ff122e	Shadrick Mandumbwa\t	shadmadu@yahoo.com	+260 977692447	0	0	2020-12-15 09:43:34.861977	2020-12-15 09:43:34.861977
3721fc2a-c1fe-48e2-887c-5479a9b1da13	Organisation	bf83777c-f620-42de-aa60-8cb4faf67171	Peter Sampa\t	petersampa9@gmail.com	+260 973697840	0	0	2020-12-15 09:54:48.081463	2020-12-15 09:54:48.081463
8219b71c-44f1-4876-9e81-1955c4a52321	Organisation	293982c4-1b82-4ff0-8cb8-a682a4528582	William\t	edmisumbi@yahoo.com	+260 955222093	0	0	2020-12-15 10:00:56.553145	2020-12-15 10:00:56.553145
e82be8ef-f030-49ff-9d54-eafd6d3dd34a	Organisation	a837afed-9908-4e0c-ade8-56a54d62ea9d	Mr Phiri\t	comdevcollege@Gmail.com	+2609 77724486	0	0	2020-12-15 10:06:58.13166	2020-12-15 10:06:58.13166
ed749bd5-952e-4d91-8054-2d2d764a939f	Organisation	1c72adb6-7fd0-4ac9-86f2-f74a9ad7c895	Adam Phir\t	adamphiri4@gmail.com	+260 964093509	0	0	2020-12-15 10:13:53.5328	2020-12-15 10:13:53.5328
d8fa70ef-9622-4c14-b37c-1cff48107c1e	Organisation	a98028c2-feb2-4129-afb9-3d75cffae1ee	Moses Bwalya	bwalyamoses@gmail.com	+260 975641357	0	0	2020-12-15 10:19:22.05703	2020-12-15 10:19:22.05703
17d3b981-d9d9-4b64-8865-94730ba5c542	Organisation	d70d67d3-5a37-4043-a5c3-0d795c143655	Lufungulo	drmwelwa@gmail.com	+260 97881046	0	0	2020-12-15 10:24:28.571611	2020-12-15 10:24:28.571611
93b0e44d-7e14-4947-8f02-b7a495b14408	Organisation	f4b8dd42-f206-46ca-bb2b-e9a7d1f909a1	Fred	monzenursingschool@yahoo.com	+260 975258900	0	0	2020-12-15 10:43:37.107886	2020-12-15 10:43:37.107886
60acde42-b397-4f27-927e-aade1fb4efaa	Organisation	11612124-c37e-4fca-9a4d-6a4d667c12a4	Mr Nyirenda\t	beganinyirenda89@gmail.com	+260 978511601	0	0	2020-12-15 11:07:00.129853	2020-12-15 11:07:00.129853
d558001d-8fc9-47f8-9445-2f5bd43a3e1b	Organisation	1b548d86-53e2-485e-a124-280a75ca8dcf	Mr Chirwa\t\t	chirwaaric@yahoo.com	+2609 71951785	0	0	2020-12-15 13:13:50.216389	2020-12-15 13:13:50.216389
99e9c210-62c9-4564-83b7-0081283cd3a2	Organisation	4209f2c1-3849-46ae-87d9-004a22ce1a04	Nchimunya Mazuba	mchis1010@gmail.com	+260 955773876	0	0	2020-12-17 16:00:43.597758	2020-12-17 16:00:43.597758
19ae6b7f-83ac-4613-b9c0-c50bb5881526	Organisation	76c1e832-d232-4cd1-b2c6-4d455c48296b	Mr Chiekwa	fortechchilekwa@gmail.com	+260211282496	0	0	2021-02-04 09:16:00.047232	2021-02-04 09:16:00.047232
78150556-0374-4ee9-b0e0-861dab7f11ea	Organisation	e974240c-1ece-4094-8a28-4a220ec0a9e5	Nawa Mwiya	nawa.mwiya@moh.gov.zm	+26055600682	0	0	2021-02-04 09:55:25.375303	2021-02-04 09:55:25.375303
ac7ca1bb-1cdc-41e0-8d91-ee1743ceb6b2	Organisation	12019ea3-124c-48b9-9772-c1c48af39cc9	Captain David Mulenga	dmulenga@dshs.edu.zm	+260979399257	0	0	2021-02-09 09:28:42.729888	2021-02-09 09:28:42.729888
8826a5a1-0074-4692-8a0b-9ff073d19194	Organisation	911a5df1-70bb-43a6-99c3-9138271109ed	Support Services	support@ubuntunet.net	00256772084725	1	1	2018-01-10 15:30:52.31277	2021-04-06 07:49:02.904718
cb0d129a-b0d1-4ff9-9455-e8e9822107b0	Organisation	1ce47b62-7c29-431f-889f-3e2949843b72	Mr Twiza Siwale	tsiwale@zica.co.zm	+260979159619	0	0	2021-04-06 14:46:20.313988	2021-04-06 14:46:20.313988
653ee0dd-2276-40c8-a43b-ab40560c17a8	Location	d0d4e6c4-6d51-448b-b246-4ca16a1ec9b2	Niry Andriambelo	andriambelo.niry@gmail.com	+261 34 02 621 28 	0	0	2021-04-15 05:17:53.964201	2021-04-15 05:17:53.964201
ea9d4aea-cdf4-465b-9949-9e87685dbf47	Location	d0d4e6c4-6d51-448b-b246-4ca16a1ec9b2	Lalanirina Jean ANDRIANTSITOHAINA 	lalanirina@irenala.edu.mg	+261 34 30 412 42	0	0	2021-04-15 05:17:53.966043	2021-04-15 05:17:53.966043
fcfd7683-9b42-409c-8810-c694eacf2ef3	Organisation	f5e8d182-0759-45a2-a54e-8a50a43fbab6	Arnaud AMELINA	noc@togorer.tg	+22890097472	0	0	2021-04-23 12:56:25.887276	2021-04-26 13:00:28.418382
cf7ea21a-73d1-4aa2-8809-7290080f5aa9	Location	5246784b-692e-412f-8488-dae6f22d30d9	Mohamed Ali Ahmed	mohammed.ali@somaliren.org	252615567671	0	0	2021-04-29 08:52:03.872551	2021-04-29 08:52:03.872551
82f418cc-e7fb-4285-be26-6865a7e44b79	Organisation	1c04c719-fda2-49bb-a2e4-82c952394d50	Mohammed Ali Ahmed	mohammed.ali@somaliren.org	00252615567671	0	0	2021-04-07 12:58:15.525919	2021-04-29 14:04:07.591759
626481fe-5d6c-4a59-aeac-2683c636a52f	Organisation	da5423fb-a58d-482f-b81d-a1bb8c3d0413	UNILUS IT Department	it@unilus.ac.zm	+260211258505	1	0	2021-05-03 08:45:08.534782	2021-05-03 08:45:08.534782
6d88d8d8-4f87-4983-9594-de1e8899a4ff	Organisation	f2ec386f-3a4f-4579-b56d-a1e6da1b43aa	Ndabase	ndabase.jere@zamren.zm	+260977979979	0	0	2021-05-24 13:13:04.789042	2021-05-24 13:13:04.789042
cd29661c-93e5-4a4f-ada1-84cd4aac6138	Organisation	86b3926e-5f58-4f34-a48c-e4cd7204bee9	Solomon Dindi	s.dindi@maren.ac.mw	+265995148626	0	0	2021-06-11 09:27:29.949231	2021-06-11 09:27:29.949231
9dcfab74-9ec0-4024-82b4-952300aee5cf	Location	6b61d79d-8a7a-4c6f-b3d4-ff07877bd5ff	Solomon	s.dindi@maren.ac.mw	+265995148626	0	0	2021-06-11 09:52:29.897535	2021-06-11 09:52:29.897535
4a976b15-5467-4266-ac64-85db99085674	Organisation	c379f63a-ef47-491a-98ba-6cb76daa20b0	Dr Patrick Chikumba	pkchikumba@mubas.ac.mw	+265883859869	0	1	2021-06-11 10:08:05.495858	2021-06-20 18:18:41.608196
f6bae50d-1354-4463-926e-f09b100fb97c	Organisation	28694d8e-e7d7-417a-b5b0-cf4815c92234	Cancer Disease Hospital	teddylushinga@gmail.com	09761006222	0	0	2021-08-26 14:04:05.552164	2021-08-26 14:04:05.552164
7a2faeac-4e9d-41c0-813b-57aff707c974	Location	831f7acb-a253-409c-942d-652ec3d21cf0	Arnaud A.	arnaud.amelina@togorer.tg	+22890097472	0	0	2021-10-18 15:30:55.81768	2021-10-18 15:30:55.81768
8c0c6a69-074c-402a-8988-b5f7a2185fbc	Organisation	0bbc71ed-a2e0-4e10-983e-a7fb0ffec5b5	Calvin Swatulani	cscalvins@mukuba.edu.zm	+260967718171	0	0	2021-12-13 09:39:47.351308	2021-12-13 09:39:47.351308
\.


--
-- Data for Name: equipment; Type: TABLE DATA; Schema: public; Owner: switchboarder
--

COPY public.equipment (id, name, location_id, ip4, prefix4, ip6, prefix6, mac, protocol, upstream_secret, monitor_secret, switchboard_secret, require_message_authenticator, nas_type, nas_kind, created_at, updated_at) FROM stdin;
a1d74657-8752-46bf-9a5e-5d766f29f8f2	ubiquiti	a5c0271b-f7a5-4556-8fa3-1e7a213633bd	41.242.99.196	27	\N	128	\N	udp	MvSeBS7VNVlGTigp	+WThrnN2C1c41n+p	NM+zEAcHj9nX7mpT	t	other	ap	2018-07-25 08:33:44.493981	2018-07-25 08:36:46.032204
79eeee16-5510-415d-a4a7-e04ab1a11b4d	AP-Library	f6e71221-a866-4095-99be-dc440dc499ee	192.168.28.1	27	\N	128	\N	udp	37f34bc8a65ad867fc0d0923	0b63e0946231d5802aba9d18	fe613c13660aa4970dbeef62	t	other	ap	2021-06-24 15:13:46.109592	2021-07-02 12:38:26.431266
a3d143ba-61ff-4e9d-a674-fdbb3ae6eb9e	ternet-ub1	24d2c3c3-f970-4b6d-82a1-90d24301fb2d	41.93.48.195	32	\N	128	\N	udp	connect	5a435a404430389d034d119a	ec4d20689b1b23490103dc84	t	other	ap	2019-03-18 08:33:04.448906	2019-03-18 08:38:33.924851
84f0699e-e55e-409f-9454-833984ab9ea5	offic-nas	24d2c3c3-f970-4b6d-82a1-90d24301fb2d	10.10.1.121	32	\N	128	\N	udp	b7a22e09a82e362fdb94f97c	24cba2d54e7177efec461cd1	940b7e52a0d29aa7c24f875e	t	other	ap	2019-04-03 13:28:52.764899	2019-04-03 13:28:52.764899
60e6f7c3-5450-4c0e-b39d-7a76403e154e	Covenant RUCKUS	2c66a0f0-2d5f-4510-acd1-d02365e7c0d7	165.73.192.12	29	\N	128	\N	udp	9c6c8ddb43782e5bb98591af	af34b95386ac68443feb933a	309636a3797d588f792960a5	t	other	other	2019-04-04 11:22:01.020991	2019-04-04 11:22:01.020991
941fb2b1-4df4-4524-a1b0-6607a9888f6e	Covenant RUCKUS	2c66a0f0-2d5f-4510-acd1-d02365e7c0d7	41.203.76.252	29	\N	128	\N	udp	c904f54e31eb6abfa3e8fee0	088b970032e8869e35afec2e	60957e1ef54cae7c5203a3b2	t	other	other	2019-04-04 11:22:41.082198	2019-04-04 11:22:41.082198
81f2d0e6-569b-4b8d-81ea-7b7065f73083	Admin Block Pilot AP	cd5cd203-33cd-4d81-8057-d7f8b5aaf520	196.220.200.11	21	\N	128	\N	udp	eduroampilot	0457b6ef8d27044d700b7352	94aebf7220cc661acd88af6c	t	other	ap	2019-04-04 13:23:49.200614	2019-04-04 13:27:09.549541
8d4bac9d-533b-44bd-99f3-70c292642c62	UDUSOK_Controller	35858a1c-23b2-40f6-8ef1-b47f8efa3010	82.101.148.0	24	\N	128	\N	udp	3dce65787644f6a75e2bd795	ab93a18cd3a1956f1521917a	000d378fc3d062a62266af47	t	other	other	2019-04-05 13:00:25.561399	2019-04-05 13:00:25.561399
c9b81370-66c7-480a-b2eb-38b6ed26dfe0	Wifi Controller	7e6eba79-62c3-4720-93f3-416ea7b363d9	196.45.51.47	32	\N	128	\N	udp	df7b064c751ed48956210c4f	988fd473c93737b55edb3742	68129426091827f1652ef987	t	other	other	2019-04-18 11:35:46.250813	2019-04-18 11:35:46.250813
2cdec5f6-a2f2-4bcc-8b38-a4986318b966	costech01	58b87f31-d441-4e66-a8b1-2aba9e59e38a	41.93.33.0	24	\N	128	\N	udp	f45cea5a57ac4b322ece1b6f	df9c5d0080c64568989a695e	993f410a821a24756e94e51a	t	other	ap	2019-05-03 13:03:30.882241	2019-05-03 13:03:30.882241
fefba35b-5287-4633-8d6b-e187c0493a9f	ICT Directorate	4f30f466-cf19-4bd9-96a6-50dae24f9a0c	102.131.128.0	17	\N	128	\N	udp	90350b0460d161627a2efca8	c4ecd03dbd0bf939742a4342	4bb2c42e3b6dcb3e6fe9a2ef	t	other	ap	2019-08-09 12:02:05.694111	2019-08-09 12:02:05.694111
b47ef1ae-e702-4e73-b515-3d88a892d243	ubiquiti	e5a6bcec-ab50-4e5f-840d-e75f8e6ca6dd	196.49.13.12	28	\N	128	\N	udp	8e6c7d04e6e9d23975d2740b	c32859522a5726c0dee200b0	ff7ec6e244959b98d6a28b1c	t	other	ap	2019-10-16 12:04:56.890123	2019-10-16 12:15:09.58118
48ab295f-1c37-44be-87ad-54c8392f895c	telma	a5c0271b-f7a5-4556-8fa3-1e7a213633bd	41.242.111.10	30	\N	128	\N	udp	4c173c443d06dca69e5f3898	0c704d79bc85135d920bb35f	36c1b95655b0d0f95b4bb5ba	t	other	ap	2019-10-24 07:12:51.660483	2019-10-27 14:46:52.992067
c790dcfc-c585-441d-96f3-f7cce2880f3a	eduroam_AP	4925482f-825c-4cac-9a1b-625cca95899e	192.168.0.115	32	\N	128	\N	udp	a6a7ab6791940843d58a6dbf	ce79bfa9a1c3988101f8e1a7	44dcfb07e53fc946e687eb59	t	other	ap	2020-02-29 06:48:32.881	2020-02-29 06:48:32.881
23bfddef-19df-4cdd-a3b0-dd185f075b46	Wireless Network	4f30f466-cf19-4bd9-96a6-50dae24f9a0c	197.211.36.98	24	\N	128	\N	udp	d05cb586a2ad79f01c2e2a2f	62bdb7b4153dabbb642173c4	9b5c1f3c9faf63846e481b2f	t	other	other	2020-03-02 14:15:37.561335	2020-03-02 14:15:37.561335
feee969c-0fcc-4437-a401-e4f98453a346	AccessPoint_AMU	4925482f-825c-4cac-9a1b-625cca95899e	10.144.13.200	32	\N	128	\N	udp	b1ab49e66198b9fd35007b30	fcb47085c7005bea767a188a	bb8280d5ec83633721284ff6	t	other	ap	2020-03-11 12:52:22.617953	2020-03-11 12:52:22.617953
1a125d1d-7bdc-4619-a55b-326a81a62d15	Secretariat-Access point	baa295b2-d252-4134-ac20-445623abc2a9	197.149.70.166	32	\N	128	\N	udp	2551cbf9e274e45cd2f8d01f	f6ad30815e5c9ef331f9f800	e00c5d3a78933a2440fb87af	t	other	ap	2019-04-04 06:50:14.185102	2021-03-03 09:17:07.284355
2adc721e-7fa7-4fb0-8212-99c9aa38dabb	maren-ap-01	6b61d79d-8a7a-4c6f-b3d4-ff07877bd5ff	41.70.98.1	32	\N	128	\N	udp	b33fe774744ac3d66a0ee51f	09f29a6ed6c43d02453c9118	c6263f87702d575e65b8482f	t	other	ap	2021-06-11 09:52:54.825974	2021-06-11 09:52:54.825974
04b9ba34-4bd6-41cf-a0b7-9faf9f931183	AP-CHIKOWI	f6e71221-a866-4095-99be-dc440dc499ee	192.168.25.1	28	\N	128	\N	udp	2d964eba83748c8f5fbd3019	052c41f1c05174fb9afeff58	3fc017cd3f167ec3d3fdda4b	t	other	ap	2021-06-24 13:13:27.008133	2021-06-24 13:13:27.008133
9abf7231-0008-492c-91fb-4f3975a748d3	AP-Kanjedza	f6e71221-a866-4095-99be-dc440dc499ee	192.168.32.1	29	\N	128	\N	udp	522e3cc0f50f8e52f9178bff	ec17a1ce4a7ab57c34519b3c	1f8d204e9f080091dd294606	t	other	ap	2021-06-29 09:07:28.869434	2021-06-29 09:07:28.869434
047eddff-0787-429a-bae7-7f628c446b41	AP-Mbelwa	f6e71221-a866-4095-99be-dc440dc499ee	192.168.15.1	29	\N	128	\N	udp	4d75eb5732862c60ad8cfb71	341456f4ee651fe051c02bc8	f2036f8872dcf28256d4d7ea	t	other	ap	2021-06-23 00:58:52.074401	2021-06-23 00:58:52.074401
a498756e-1268-4be8-80e9-c08ea4ba5bfe	AP-ICT	f6e71221-a866-4095-99be-dc440dc499ee	192.168.22.1	28	\N	128	\N	udp	171755f40b0f111ddf9b3f21	144d390a41d68e4b871f8915	e912e9fe380129cf6e96ad6a	t	other	ap	2021-06-23 00:22:44.516764	2021-06-23 01:02:36.810711
f56e0d63-3ed0-4fe9-8f89-4ddd62c26be8	AP-MWAMBO	f6e71221-a866-4095-99be-dc440dc499ee	192.168.24.1	28	\N	128	\N	udp	76e294d8413562fbc026575d	d8dd2a6c45b7da6210bd654a	d80c62b8e913d9676cf71c67	t	other	ap	2021-06-24 13:14:45.726957	2021-06-24 13:14:45.726957
f1366904-562f-442a-9ff8-608f31023c95	AP-QUADRANGLE	f6e71221-a866-4095-99be-dc440dc499ee	192.168.27.1	28	\N	128	\N	udp	834aa67fcd476ddc06840ffd	c908b2a6ce263151c11eb1b8	79f5586fab726265ed65a294	t	other	ap	2021-06-24 13:15:55.653391	2021-06-24 13:15:55.653391
5fb71eb3-ffc4-4b2b-9036-05fb730c2a52	AP-Law	f6e71221-a866-4095-99be-dc440dc499ee	192.168.26.1	28	\N	128	\N	udp	f3178b466341ef76e892b319	2dd6060908e566053edf8a6c	2fade8295fcf76fe9f5b8582	t	other	ap	2021-06-24 15:10:50.205191	2021-06-24 15:11:46.695271
72ccbbe1-3d29-4d07-9310-17be4e7c7202	AP-Greathall	f6e71221-a866-4095-99be-dc440dc499ee	192.168.23.1	28	\N	128	\N	udp	c845e63c34150a7b033e0057	1bc0ce39952123d395724ba8	3693cf7df28cf0052eb3606c	t	other	ap	2021-06-24 15:50:55.907099	2021-06-24 15:50:55.907099
a4d0d43f-b43b-4cfa-b5aa-2715c20c0617	AP-History	f6e71221-a866-4095-99be-dc440dc499ee	192.168.32.1	28	\N	128	\N	udp	c3500f8b96560509f886d430	0257d6e88e62476f3499a215	7e2a2f2d9513306296a1e238	t	other	ap	2021-06-24 15:51:59.369546	2021-06-24 15:51:59.369546
43d86065-0729-4887-ae5c-fa2349fca295	AP-Admin	f6e71221-a866-4095-99be-dc440dc499ee	192.168.33.1	28	\N	128	\N	udp	b9042eef860157e8e14a875a	ea6ca59fadc6c667f7d7660a	5a3e18ac0ff50d693095dc5c	t	other	ap	2021-06-24 15:52:59.005043	2021-06-24 15:52:59.005043
5651e397-cf5a-4665-ac98-ce7b0e6e19d6	AP-Umodzi	f6e71221-a866-4095-99be-dc440dc499ee	192.168.21.1	29	\N	128	\N	udp	99c6f358f0855e78df7365f7	aae65c14778fde80bc7597c9	fd676ef38aaf5959b5e6eeae	t	other	ap	2021-06-25 09:49:27.180165	2021-06-25 09:49:27.180165
a0a7950e-c880-4a55-a8a7-5d3e3da91a19	AP-Mumba	f6e71221-a866-4095-99be-dc440dc499ee	192.168.17.1	29	\N	128	\N	udp	1110a34e8128964258d23f6d	fe2524692ee6b7019fe12880	7b53a923d5e6c826b08ef440	t	other	ap	2021-06-25 09:50:19.676231	2021-06-25 09:50:19.676231
a8fcc063-cef8-4960-9390-291bea9237c8	AP-Lubani	f6e71221-a866-4095-99be-dc440dc499ee	192.168.13.1	29	\N	128	\N	udp	9a691f51e6a70ee40a6a9f97	3867f51b915fe31f057cdc1f	956c000801fb34d9c3286ab0	t	other	ap	2021-06-25 11:30:11.145554	2021-06-25 11:30:11.145554
13e7df67-fb4d-4427-add1-b4afe2df7b88	AP-Chilembwe	f6e71221-a866-4095-99be-dc440dc499ee	192.168.1.1	29	\N	128	\N	udp	fadb36bcb89c0181ad8b422b	08ef8fc2ad9d475e202814f7	6327c7fbcbe7e8135159bccd	t	other	ap	2021-06-25 13:39:51.385467	2021-06-25 13:39:51.385467
b8dd224b-67b7-471b-8e37-ddd0e37fb82a	AP-Cafe	f6e71221-a866-4095-99be-dc440dc499ee	192.168.35.1	29	\N	128	\N	udp	47db84dafca0d819271fe7e9	94b0be38ad9e08e31392554e	03dd65ae0e9bf97fe2641324	t	other	ap	2021-06-28 10:11:15.856831	2021-06-28 10:11:15.856831
f5f00fab-c835-49e9-99a7-c4d84e053389	AP-Mulunguzi	f6e71221-a866-4095-99be-dc440dc499ee	192.168.16.1	28	\N	128	\N	udp	aaeeb2dc99fc07226fe87697	7849da67c6dd7aa78719468b	a973044bc20069915ffc7984	t	other	ap	2021-06-28 10:13:42.71921	2021-06-28 10:13:42.71921
fc235382-886a-42d0-85fa-cb5952d8bbc4	AP-Sangala	f6e71221-a866-4095-99be-dc440dc499ee	192.168.18.1	29	\N	128	\N	udp	c3c021b4b513089886dcf54a	a263f6dfa08a6fe783100ea2	b4bf6d71075ac63e6ff33332	t	other	ap	2021-06-29 10:17:55.468248	2021-06-29 10:17:55.468248
531f03c1-9f04-4725-901e-a65b26fa06c4	Chirunga	f6e71221-a866-4095-99be-dc440dc499ee	192.168.3.1	29	\N	128	\N	udp	e518402bbae020317d2a6aca	1c56892500a6b74f8d5e7432	30768d2940eca86e60eed44f	t	other	ap	2021-06-29 12:17:50.052232	2021-06-29 12:17:50.052232
0c7f98b1-dde4-47ea-9b77-55ea5196c74b	AP-Kwacha	f6e71221-a866-4095-99be-dc440dc499ee	192.168.12.1	29	\N	128	\N	udp	aa136852baf1915e022d6026	6f1fb6fbdbf1a7ce3c5ff2ba	2b4b9c36c6f2d5645f4a6f9f	t	other	ap	2021-06-30 14:30:16.178632	2021-06-30 14:30:16.178632
6569f241-45f7-4b1d-9201-aa4cb11eb65d	AP-Khondowe	f6e71221-a866-4095-99be-dc440dc499ee	192.168.10.1	29	\N	128	\N	udp	c3c9f58a06e58e79514e6b75	d2f3f3b5287e2599339ee731	8ad3542bd9475263e86e8a35	t	other	ap	2021-06-30 14:31:35.527938	2021-06-30 14:31:35.527938
c25909b8-a638-4a67-ba99-55bf2f6a0b4d	AP-Kenyatta	f6e71221-a866-4095-99be-dc440dc499ee	192.168.9.1	29	\N	128	\N	udp	092bb9efda1cf23c671bc890	99d8364f88e1ede649efb2a0	6f95b676992178baa0866396	t	other	ap	2021-06-30 14:32:26.751609	2021-06-30 14:32:26.751609
9d94e508-b9bc-4ea4-a751-c618115d57d7	AP-Kamuzu	f6e71221-a866-4095-99be-dc440dc499ee	192.168.7.1	29	\N	128	\N	udp	55880a012767ed9b7a8b24d4	a2a33324cc2e0784ca6e48f3	ecd7021cc1a3498adece076a	t	other	ap	2021-06-30 14:33:03.141779	2021-06-30 14:33:03.141779
b8e8d08c-3105-44f3-aa05-23ba5c608d92	AP-Kachere	f6e71221-a866-4095-99be-dc440dc499ee	192.168.6.1	29	\N	128	\N	udp	2339abdad65ac86a770abbdf	88f58761df7661e11d71cf2d	41567e9a3a2ab0cb11e49948	t	other	ap	2021-06-30 14:34:00.454609	2021-06-30 14:34:00.454609
0db004b4-d0ff-486d-bc78-985dc36f321b	AP-Gweru	f6e71221-a866-4095-99be-dc440dc499ee	192.168.5.1	29	\N	128	\N	udp	377b97035a5c5603cd024ac6	c610239c404ce51c70ba9a2a	435747803e7e5a42c5540bc0	t	other	ap	2021-06-30 14:34:59.321977	2021-06-30 14:34:59.321977
95fdb6c3-01f3-4a4f-9c5a-5a12b90455e8	AP-Dunduzu	f6e71221-a866-4095-99be-dc440dc499ee	192.168.4.1	29	\N	128	\N	udp	80bbad6b5310ebe09eefb54b	92bec1fd7c031c5c8f06a241	ab52ff8cd0bf83450f0d5e21	t	other	ap	2021-06-30 14:35:31.78813	2021-06-30 14:35:31.78813
21c90812-1730-46ea-8798-25dbeb0eafcb	AP-Shakespeare	f6e71221-a866-4095-99be-dc440dc499ee	192.168.19.1	29	\N	128	\N	udp	69191d383e508c1df4a18c1a	1c94cd4cbc8d3e4f841c4339	7af9620b4b720b2052f99fc9	t	other	ap	2021-06-30 14:36:54.92192	2021-06-30 14:36:54.92192
aeb07a33-2b1e-41c9-b9fe-79eee89beb73	AP-Tchaka	f6e71221-a866-4095-99be-dc440dc499ee	192.168.20.1	29	\N	128	\N	udp	9b9e52e1bcd4f30e1a3c899a	f1e8f74643d4a42537bba8ea	c4ce31dddb1cf0e0bdb3a7cc	t	other	ap	2021-06-30 14:37:37.516594	2021-06-30 14:37:37.516594
c7f511b6-686b-41c8-aba0-60cc03f11f2d	AP-Makata	f6e71221-a866-4095-99be-dc440dc499ee	192.168.14.1	29	\N	128	\N	udp	287b0ef63fcd7331a220b851	16f30c05a2d07e026626daac	cda67ea7ec583b2d009514b5	t	other	ap	2021-06-30 14:38:39.305022	2021-06-30 14:38:39.305022
7746e795-2799-4f53-91b6-e1de5abb050f	AP-Chingwe	f6e71221-a866-4095-99be-dc440dc499ee	192.168.2.1	29	\N	128	\N	udp	ef239538f107746caeb3d085	bb2cfb0edb9bc82b88b222f0	72a710f50e15b817925c7be2	t	other	ap	2021-06-30 14:39:38.933347	2021-06-30 14:39:38.933347
422ebeba-0895-4ea7-80a9-fcb7b4bc1cbb	AP-Beit Trust	f6e71221-a866-4095-99be-dc440dc499ee	192.168.0.1	29	\N	128	\N	udp	7ce1809ea0a1a9b6d3806c65	309211d61360008857e842a5	b1bd081ff08fe8ec55ee0ed8	t	other	ap	2021-07-02 14:52:01.41861	2021-07-02 14:52:01.41861
9738e187-72ef-48d1-8bd1-68d63e30b9bb	MAREN External IP	8d4607fb-bc13-4fd6-bd46-128c8796b474	41.70.12.74	32	\N	128	\N	udp	HboaJVjV	a0GrukO03GToRNdY	+ZnMyf9egfaaELLq	t	other	ap	2018-08-31 10:23:45.333103	2021-07-05 12:58:22.210674
55718da6-fde3-4ff4-9776-6bf91d7b9731	IT-ROOM	22a8d18f-3404-4823-ba11-469bb838622c	10.137.80.3	32	\N	128	\N	udp	81b52e8aca162e0ed7e5169e	18548adb45f22cb3579fa719	0d15e995a87358613fd99038	t	other	ap	2021-10-13 14:27:22.04385	2021-10-13 14:27:22.04385
6860629b-7802-45c7-af11-a27a96c5caed	AP UL WIFI	831f7acb-a253-409c-942d-652ec3d21cf0	102.176.253.139	32	\N	128	\N	both	50b4a6c0e8f5e4466c84ce8e	41654f05ddf74e5e47a0a908	0302b9bde5ab3bcc872193a1	t	other	ap	2021-10-18 15:32:29.620165	2021-10-18 15:32:29.620165
d2383e5a-6ca1-450d-9cd3-6f45d692ffa8	maren-events-ap-01	6b61d79d-8a7a-4c6f-b3d4-ff07877bd5ff	41.70.127.253	32	\N	128	\N	udp	14e7bb98665c4a15b93aee2b	6e2327026a221c3a78d4a71c	846942b0afc170e0584d205c	t	other	ap	2021-10-29 10:08:13.271762	2021-10-29 10:08:13.271762
\.


--
-- Data for Name: federations; Type: TABLE DATA; Schema: public; Owner: switchboarder
--

COPY public.federations (id, operator_id, stage, identifier, tld, info_url, policy_url, language, created_at, updated_at, email, confederation_id) FROM stdin;
924256f9-5ed7-4795-9cb9-bfce3ee43abb	7d9384ac-82bf-430e-a5c6-3372970a13d0	1	MZ01	MZ	https://eduroam.ubuntunet.net	https://eduroam.ubuntunet.net/policy	pt	2018-05-24 14:08:37.703931	2018-08-29 06:22:58.829358	morenet.info@morenet.ac.mz	621b2e43-dc2e-4f26-99b4-e126bb4caff6
cc82422e-9475-4354-b40c-c2846af56272	1ae8ed07-9a09-4c42-ba70-45cefae61ac5	1	BR01	BR	https://eduroam.ubuntunet.net	https://eduroam.ubuntunet.net/policy	pt	2018-08-30 14:33:19.803892	2018-08-30 14:36:02.477687	calebe.reis@rnp.br	621b2e43-dc2e-4f26-99b4-e126bb4caff6
4d80c8e1-029a-4622-9159-e76dd83e5ea9	8d2a33be-7230-4c87-b6a3-499b4e18bf63	1	BI01	BI	https://eduroam.ubuntunet.net	https://eduroam.ubuntunet.net/policy	fr	2018-11-22 09:17:44.388234	2018-11-22 13:06:25.452038	eloge.bapfunya@ub.edu.bi	621b2e43-dc2e-4f26-99b4-e126bb4caff6
02b4e345-b851-4428-9531-badf883610aa	f5e8d182-0759-45a2-a54e-8a50a43fbab6	1	TOGORER	TG	https://eduroam.togorer.tg	https://eduroam.togorer.tg/policy	fr	2021-04-23 12:52:47.838548	2021-09-15 16:44:12.343846	arnaud.amelina@togorer.tg	621b2e43-dc2e-4f26-99b4-e126bb4caff6
17626b73-d195-419c-bb01-103754b95897	b7a4f25d-aa72-4812-a1dd-a563d26ba979	0	RITER	CI	https://eduroam.riter.ci	https://eduroam.riter.ci/policy	fr	2018-12-06 07:06:17.914559	2019-01-28 12:04:53.170745	noc@eko-konnect.org.ng	621b2e43-dc2e-4f26-99b4-e126bb4caff6
029b333b-8a8d-4bd1-8c14-284e99e9bbb5	d6ec3437-802b-418e-8c40-08fc96e9bcc9	1	bjFLR	BJ	https://eduroam.ubuntunet.net	https://eduroam.ubuntunet.net/policy	fr	2019-10-01 11:48:03.567336	2020-03-12 10:12:07.479513	victor.oyetola@uac.bj	621b2e43-dc2e-4f26-99b4-e126bb4caff6
c992c12c-7ef5-4914-9138-69c9fb6b74dc	5b033895-13ed-43b3-a21a-62fdb56e38d4	1	GH01	GH	https://eduroam.gh	https://eduroam.gh/policy	en	2019-08-04 19:54:32.163475	2019-10-18 05:04:53.699705	eduroam@garnet.edu.gh	621b2e43-dc2e-4f26-99b4-e126bb4caff6
41d5c67a-f92a-4549-b245-d65abdb5cf90	1b86a4eb-944e-49c3-b183-0c631b1d27bc	1	ZM01	ZM	https://eduroam.ubuntunet.net	https://eduroam.ubuntunet.net/policy	en	2018-05-17 14:35:57.006536	2021-12-13 09:39:47.356423	systems@zamren.zm	621b2e43-dc2e-4f26-99b4-e126bb4caff6
8e95b53d-6101-4287-ba1c-58c3fe6434f3	911a5df1-70bb-43a6-99c3-9138271109ed	0	ls	LS	https://eduroam.ubuntunet.net	https://eduroam.ubuntunet.net/policy	en	2020-03-24 07:58:26.937215	2020-03-24 07:58:26.937215	devops@ubuntunet.net	621b2e43-dc2e-4f26-99b4-e126bb4caff6
29e15a85-bb5f-42e8-a32a-4d9ebfabff75	679f67b6-cf16-4c36-a887-77c06fb2d05b	0	me	ME	https://eduroam.ubuntunet.net	https://eduroam.ubuntunet.net/policy	en	2019-11-04 13:11:06.877219	2019-11-04 13:11:06.877219	roypangani@gmail.com	621b2e43-dc2e-4f26-99b4-e126bb4caff6
a3cc227d-a973-46cb-9ca5-091252342453	aee1e708-5a8f-4465-a558-97c61110d4bb	0	SNRER	SN	https://eduroam.ubuntunet.net	https://eduroam.ubuntunet.net/policy	fr	2019-10-30 16:00:33.519924	2019-11-18 22:35:36.329895	modou.diouf@ucad.edu.sn	621b2e43-dc2e-4f26-99b4-e126bb4caff6
01764a37-a28a-4d11-bf63-df549cf110bd	d785f154-2f0a-4055-be46-e44862c54a67	1	ML01	ML	https://eduroam.maliren.ml	https://eduroam.maliren.ml/policy	fr	2019-07-31 13:29:31.947009	2019-11-18 22:37:17.195767	cyahaya@gmail.com	621b2e43-dc2e-4f26-99b4-e126bb4caff6
49429470-2505-49f1-8d22-052b51a6fe08	7ccfcd5c-da2a-44d2-acff-f7a51ec5b199	1	NG01	NG	https://eduroam.ng	https://eduroam.ng/policy	en	2018-08-27 08:46:49.799365	2021-04-06 12:14:18.280519	federation@ngren.edu.ng	621b2e43-dc2e-4f26-99b4-e126bb4caff6
49d70765-375a-42bf-b267-74eb0f21b617	bdbce8c6-b4e0-4504-ad5f-d2c5440a7213	0	zw	ZW	https://eduroam.ubuntunet.net	https://eduroam.ubuntunet.net/policy	en	2020-06-01 13:01:09.907619	2020-06-05 10:49:53.434862	nkokera@gmail.com	621b2e43-dc2e-4f26-99b4-e126bb4caff6
ef4b85a4-444f-4edd-b31d-b7eb6c28ef6c	cd8a9e52-58b9-4fcc-93ca-e53a81d50383	1	TZ01	TZ	https://eduroam.ubuntunet.net	https://eduroam.ubuntunet.net/policy	sw	2018-05-17 14:54:22.938993	2020-11-02 15:29:34.738658	helpdesk@ternet.or.tz	621b2e43-dc2e-4f26-99b4-e126bb4caff6
0b345644-3cdc-442e-8f7a-1add49e1ed4f	0a67d914-b70f-4970-ad77-6b8caf423852	1	ET01	ET	https://eduroam.ubuntunet.net	https://eduroam.ubuntunet.net/policy	en	2018-07-24 15:31:36.094916	2020-03-03 05:11:02.679906	info@ethernet.edu.et	621b2e43-dc2e-4f26-99b4-e126bb4caff6
a33c9698-a460-40f9-849f-947ecb8fa561	ba395f36-ef32-4db2-8042-0f23c6fccbcb	0	MG01	MG	https://eduroam.ubuntunet.net	https://eduroam.ubuntunet.net/policy	fr	2018-07-24 15:09:19.354858	2021-04-16 05:16:57.354602	lalanirina@irenala.edu.mg	621b2e43-dc2e-4f26-99b4-e126bb4caff6
73fc50f7-0e1d-48fa-b648-040e6d5dd116	1c04c719-fda2-49bb-a2e4-82c952394d50	0	SO	SO	https://eduroam.ubuntunet.net	https://eduroam.ubuntunet.net/policy	en	2021-04-07 12:53:50.317034	2021-06-14 13:05:00.379086	mohammed.ali@somaliren.org	621b2e43-dc2e-4f26-99b4-e126bb4caff6
2da7d3a9-81e9-4ae7-986c-142c690c41f1	86b3926e-5f58-4f34-a48c-e4cd7204bee9	1	MW01	MW	https://www.maren.ac.mw	https://www.maren.ac.mw	en	2018-01-10 15:29:57.996876	2021-06-24 08:11:28.614442	ceo@maren.ac.mw	621b2e43-dc2e-4f26-99b4-e126bb4caff6
\.


--
-- Data for Name: locations; Type: TABLE DATA; Schema: public; Owner: switchboarder
--

COPY public.locations (id, organisation_id, name, identifier, stage, transmission, venue_type, ssid, address_id, contacts_id, wpa_mode, encryption_mode, ap_no, wired_no, port_restrict, transp_proxy, ipv6, nat, hs20, availability, operation_hours, info_url, created_at, updated_at) FROM stdin;
8d4607fb-bc13-4fd6-bd46-128c8796b474	911a5df1-70bb-43a6-99c3-9138271109ed	Onions Office Complex	16c7c9cb-2b42-40e9-8764-d5513ab22b0f	1	0	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	t	f	0	Always	https://ubuntunet.net/contact-us/	2018-03-09 07:44:20.180616	2018-03-09 09:08:13.853053
a5c0271b-f7a5-4556-8fa3-1e7a213633bd	ba395f36-ef32-4db2-8042-0f23c6fccbcb	irenala	1da09e39-d56b-4810-bbc1-4b02ea04e069	1	0	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	f	f	0	Always		2018-07-25 08:33:20.194831	2018-07-25 08:33:20.194831
24d2c3c3-f970-4b6d-82a1-90d24301fb2d	cd8a9e52-58b9-4fcc-93ca-e53a81d50383	Dar es Salaam	50ed405f-b161-472e-8f26-2b525accd785	1	1	3,3	eduroam	\N	\N	wpa2	aes	5	1	f	f	f	f	f	0	Always		2019-03-18 08:32:27.587091	2019-03-18 08:32:27.587091
8c676cfb-f2f3-4ea3-8e92-3e481ea1e778	720b4990-7e36-4d61-83b5-09d2d0c46889	Commonwealth Hall	7885812a-cedd-4b9a-be87-6af30d9201d3	1	1	3,3	eduroam	\N	\N	wpa2	aes	53	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-06 15:04:57.060966	2019-08-07 12:23:24.962527
2c66a0f0-2d5f-4510-acd1-d02365e7c0d7	96f247af-06f8-4c6a-b325-71f89fd65bd5	Diamond ICT	29b56dc2-33dd-43a0-bf9d-22659682e968	1	0	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	t	f	0	Always	https://covenantuniversity.edu.ng/	2019-04-04 11:13:03.10626	2019-04-04 11:13:03.10626
cd5cd203-33cd-4d81-8057-d7f8b5aaf520	6f4462ad-1f14-4e25-be5e-88cf2e42cec1	NAU Main Campus	ddb843f7-2f07-4d8a-b9da-b3e6ef3494b2	1	1	3,3	eduroam	\N	\N	wpa2	aes	5	1	f	f	f	f	f	0	Always	https://unizik.edu.ng	2019-04-04 13:11:48.588935	2019-04-04 13:11:48.588935
35858a1c-23b2-40f6-8ef1-b47f8efa3010	d732f8b8-d167-4dac-b175-724f7188be6a	Dundaye Area, Wamakko	51e4013e-f7e8-46eb-a1b9-701ce0e33ff9	1	1	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	f	f	0	Always	https://udusok.edu.ng	2019-04-04 16:00:47.916075	2019-04-04 16:00:47.916075
7e6eba79-62c3-4720-93f3-416ea7b363d9	9b15ed64-9965-4b8d-8857-98844f2a5e14	Unilag Akoka Yaba	19a3ba4a-c828-48aa-ab3c-ceb1da557dad	1	1	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	f	f	0	Always		2019-04-18 11:24:18.529871	2019-04-18 11:24:18.529871
58b87f31-d441-4e66-a8b1-2aba9e59e38a	991db693-847f-4626-ab05-c4bafd190f92	Kijitonyama	e29d23e4-06ab-40bb-9df6-3e5b1868de64	1	0	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	f	f	0	Always		2019-05-03 13:02:30.101391	2019-05-03 13:02:30.101391
470853fd-52ca-479b-b2d3-be619f9a18ed	720b4990-7e36-4d61-83b5-09d2d0c46889	College of Agriculture and Consumer Science	2782881e-f7c4-42ab-b65d-3e1234fafe89	1	1	3,3	eduroam	\N	\N	wpa2	aes	15	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-06 14:49:29.994957	2019-08-07 12:24:34.970349
baa295b2-d252-4134-ac20-445623abc2a9	94cf650e-540c-4d89-9f69-8891719fb5b5	Lekki Office	01d6d4e5-05f7-4f8b-94c0-35ff23c57b38	1	0	0,0	eduroam	\N	\N	wpa2	aes	1	4	f	f	f	t	f	0	Always	https://eko-konnect.org.ng	2019-04-04 06:44:03.611015	2019-07-09 08:11:41.432918
22a8d18f-3404-4823-ba11-469bb838622c	2bf8127f-b5fa-4f92-a65c-fce09f50114c	IT Department	5425ce8a-71cd-493f-8898-445d50e6b2b6	1	0	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	t	f	0	Always		2018-03-27 11:22:19.285685	2019-07-23 07:42:39.69499
2712dc28-b453-44de-99bd-adaf85c59081	720b4990-7e36-4d61-83b5-09d2d0c46889	Akuafo Hall	755dcc96-9ead-480d-8a8f-c0920acc3ed0	1	1	3,3	eduroam	\N	\N	wpa2	aes	77	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-06 14:58:06.489459	2019-08-07 12:27:16.825974
7244f5ab-baad-47f0-9207-df980e1ca91e	720b4990-7e36-4d61-83b5-09d2d0c46889	International Student Hostel	614fccb9-e0c2-41ec-ae23-4b8ee3c70538	1	1	3,3	eduroam	\N	\N	wpa2	aes	48	1	f	f	f	t	f	0	Always		2019-08-04 21:07:28.293037	2019-08-06 07:40:49.743975
7be519c0-6bce-44a6-bc4b-730933c5b0a8	720b4990-7e36-4d61-83b5-09d2d0c46889	Balme Library	48c93337-8794-438a-ae0a-f200c32fbda7	1	1	3,3	eduroam	\N	\N	wpa2	aes	33	1	f	f	f	f	f	0	Always		2019-08-05 10:33:46.503958	2019-08-06 07:42:20.462255
1a5c8784-c197-481a-b081-af89176bfdc0	720b4990-7e36-4d61-83b5-09d2d0c46889	Guest Centre	8f8a6675-4ea7-4109-8da6-7b0700b2e290	1	0	3,3	eduroam	\N	\N	wpa2	aes	3	1	f	f	f	t	f	0	Always		2019-08-05 22:17:15.111081	2019-08-06 07:43:38.593498
4a589fb5-6538-49de-932c-c9bd1ec02371	720b4990-7e36-4d61-83b5-09d2d0c46889	University Hospital	13bb0a02-1a41-4fdb-adc1-ccff90715515	1	1	3,3	eduroam	\N	\N	wpa2	aes	9	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-06 13:02:55.977834	2019-08-06 13:02:55.99924
f189cf9e-c062-4288-9120-99f6e741f0b5	720b4990-7e36-4d61-83b5-09d2d0c46889	Faculty of Science	70f0c3ed-024b-4305-a238-3f29223712d4	1	1	3,3	eduroam	\N	\N	wpa2	aes	3	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-06 15:38:07.853485	2019-08-07 12:26:24.127829
4f34c792-05ae-48b5-a2e4-8aa7b21d2443	720b4990-7e36-4d61-83b5-09d2d0c46889	Jubilee Hostel	d88d5fa9-395d-46e9-b975-188c5951ef0c	1	1	3,3	eduroam	\N	\N	wpa2	aes	48	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-06 16:11:58.158083	2019-08-07 16:42:46.918596
17f46ece-0ba6-457d-85ba-09dc37a4c4b0	720b4990-7e36-4d61-83b5-09d2d0c46889	Arts_Dept	bb3991eb-0c9d-40ee-a4e9-be4f221b27c0	1	1	3,3	eduroam	\N	\N	wpa2	aes	6	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-06 14:53:16.542274	2019-08-07 13:32:01.48802
d8f2a3a7-09ba-4f9a-b3f3-0f4bedc63fcd	720b4990-7e36-4d61-83b5-09d2d0c46889	Biochem	39ae5a3a-6e86-4955-b438-f8ef977e8bf8	1	1	3,3	eduroam	\N	\N	wpa2	aes	15	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-06 15:00:12.738288	2019-08-06 15:00:12.753722
98192fb7-578b-4e9a-a3a8-9613fc7b856f	720b4990-7e36-4d61-83b5-09d2d0c46889	Centre for Climate Change	aebb3d43-7e42-4655-a7f1-1faaf87d8e07	1	1	3,3	eduroam	\N	\N	wpa2	aes	7	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-06 15:03:13.354099	2019-08-07 12:23:54.398749
de281323-cdf2-4098-94c4-76fbcee9cb07	983c15ee-9a50-4725-bfc0-9e2067ec14fa	KNUST IDL Learning Centre - Accra City Campus Building	36361d93-97c1-4748-9944-c9700a864262	1	1	3,3	eduroam	\N	\N	wpa2	aes	24	1	f	f	f	t	f	0	Always		2019-08-06 15:08:33.0692	2019-08-09 08:23:15.032884
c6274974-782d-4d86-a2cb-cb0cea017850	983c15ee-9a50-4725-bfc0-9e2067ec14fa	University Administration Building	8a71cbc4-948e-4ddb-8ffc-4e35ad85ebf4	1	1	3,3	eduroam	\N	\N	wpa2	aes	13	1	f	f	f	t	f	0	Always		2019-08-06 15:12:59.098005	2019-08-09 08:30:43.395468
7ea10b78-2dce-462a-9189-7f740d32a6ce	983c15ee-9a50-4725-bfc0-9e2067ec14fa	Housing and Planning Building - Ablor Building	8dcef4f2-b589-4eee-9cf6-6c6ab7a6e84f	1	1	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	t	f	0	Always		2019-08-06 15:28:49.581039	2019-08-09 08:37:03.38158
c63419fb-7df2-4118-b967-1ff3ebed7a6f	720b4990-7e36-4d61-83b5-09d2d0c46889	English-Dept	a7f0389a-de38-423b-b499-5b149daf62ce	1	1	3,3	eduroam	\N	\N	wpa2	aes	3	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-06 15:04:53.153343	2019-08-06 15:17:12.222916
c81c1343-38e1-44b7-a4e2-c7bee9181edf	720b4990-7e36-4d61-83b5-09d2d0c46889	Earth-Science	685cb4e8-f1d2-4d65-8ef1-9bde137df9a6	1	1	3,3	eduroam	\N	\N	wpa2	aes	7	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-06 15:04:58.624589	2019-08-06 15:14:59.765309
55e8405c-96af-4004-b7cb-d3c3eb0d3eae	720b4990-7e36-4d61-83b5-09d2d0c46889	ISSER Conference Centre	8a5aaaf5-a5b7-4bb3-a8f7-37e1efe6d651	1	1	3,3	eduroam	\N	\N	wpa2	aes	3	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-06 15:04:54.651149	2019-08-07 16:42:02.313352
98b68fc7-6643-43df-a77f-33bf7cc14f1d	983c15ee-9a50-4725-bfc0-9e2067ec14fa	Studio Block, CABE - Trevallion Block	91e9af8f-75dc-4e1a-b732-7e494165331d	1	0	3,3	eduroam	\N	\N	wpa2	aes	8	1	f	f	f	t	f	0	Always		2019-08-06 15:34:23.466363	2019-08-09 09:04:48.110233
c4669900-ca9f-48bd-b400-1337edc3c159	720b4990-7e36-4d61-83b5-09d2d0c46889	Engineering_Dept	76f82af0-6263-43b4-8220-6eaf3bd48008	1	2	3,3	eduroam	\N	\N	wpa2	aes	9	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-06 15:33:47.873699	2019-08-06 15:33:47.887995
81651cf9-2308-4db2-83e6-1eeb328f1813	720b4990-7e36-4d61-83b5-09d2d0c46889	Fraces_Sey	c88ba204-18a1-4583-ad65-f34bff78a7ce	1	1	3,3	eduroam	\N	\N	wpa2	aes	30	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-06 15:46:11.090987	2019-08-06 15:46:11.113233
c17fc053-1f50-4940-9fc3-2975991326e8	720b4990-7e36-4d61-83b5-09d2d0c46889	Geography	ec52f3d5-57d4-47f8-9c7f-5d50d85e161f	1	1	3,3	eduroam	\N	\N	wpa2	aes	7	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-06 15:48:20.444894	2019-08-06 15:48:20.480914
5ea787c1-230b-4b10-8a96-e1daedbb015a	720b4990-7e36-4d61-83b5-09d2d0c46889	Graduate_School	5b087351-0522-4e21-a651-83855c44db00	1	1	3,3	eduroam	\N	\N	wpa2	aes	12	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-06 15:50:07.219355	2019-08-06 15:50:07.240358
23d0e5bc-dea5-4bd6-9375-7b33403e4f10	720b4990-7e36-4d61-83b5-09d2d0c46889	International Programmes Office (IPO)	a527a54e-fd21-4e22-8a33-1ddd7cb3a32f	1	1	3,3	eduroam	\N	\N	wpa2	aes	9	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-06 16:08:27.057472	2019-08-07 13:35:38.43532
9164f2f5-30e1-46b0-a40b-d630d44bdc2b	720b4990-7e36-4d61-83b5-09d2d0c46889	School of Continuing and Distance Education (SCDE)	64a0e613-f673-494a-bdad-faaadb444470	1	1	3,3	eduroam	\N	\N	wpa2	aes	8	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-06 15:52:32.670976	2019-08-07 13:38:44.072
281b8570-0af5-47e5-8850-72650e9bb34b	983c15ee-9a50-4725-bfc0-9e2067ec14fa	Administration Block 2 - Kojo Botsio Building	56de3ca9-82d8-403d-bbff-b69411d798d3	1	1	3,3	eduroam	\N	\N	wpa2	aes	6	1	f	f	f	t	f	0	Always		2019-08-06 15:15:24.653722	2019-08-09 08:19:11.537839
f6e71221-a866-4095-99be-dc440dc499ee	6461d70e-ebf3-4502-8125-6a4623ec2a9a	ICT Centre	3d5d5b38-62ee-45ed-a53d-ae37527af439	1	0	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	f	f	0	Always		2018-03-27 11:25:26.34411	2021-06-20 18:04:25.908688
3ea64816-b223-4b6c-a785-e836010f0b83	720b4990-7e36-4d61-83b5-09d2d0c46889	Centre for African Wetlands	ea9d2f90-5e3e-4a9b-9ba0-7ee4464bcdb9	1	1	3,3	eduroam	\N	\N	wpa2	aes	4	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-06 15:01:23.998085	2019-08-07 12:22:22.247244
72a90642-1df4-4099-88ac-7f0c5701d202	720b4990-7e36-4d61-83b5-09d2d0c46889	Jean-Nelson	777721ca-76f1-4643-9013-814b2262e761	1	1	3,3	eduroam	\N	\N	wpa2	aes	32	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-06 16:30:35.279253	2019-08-06 16:30:35.301616
a5d32ba3-9631-441f-913b-8f99b58c8aa6	720b4990-7e36-4d61-83b5-09d2d0c46889	West Africa Centre for Crop Improvement (WACCI)	414c1fee-5c89-4071-96bb-22360a1be007	1	1	3,3	eduroam	\N	\N	wpa2	aes	14	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-07 11:32:16.846035	2019-08-07 12:38:22.842731
d2a132df-784c-468c-b006-a0965d0e8a16	720b4990-7e36-4d61-83b5-09d2d0c46889	LAW_Dept	73a67753-5e82-4f7d-b702-d43c08c01a9c	1	1	3,3	eduroam	\N	\N	wpa2	aes	10	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-06 16:45:27.130465	2019-08-07 13:39:12.534879
318c3911-1fd3-4856-bcac-d12cbb482ed0	720b4990-7e36-4d61-83b5-09d2d0c46889	Vice Chancellors Ghana (VCG)	9f295cc9-206f-4edf-b8d6-2a564ec03bc2	1	1	3,3	eduroam	\N	\N	wpa2	aes	3	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-07 11:15:24.418466	2019-08-07 15:24:10.535422
c496b833-d462-4d21-bf0b-d9dce167be62	720b4990-7e36-4d61-83b5-09d2d0c46889	Kwapong_Hall	f30401b8-f2e4-4acc-a32f-208661d2cb74	1	1	3,3	eduroam	\N	\N	wpa2	aes	32	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-06 16:43:35.181144	2019-08-06 16:43:35.22957
ccc7f73e-4a81-464e-8a93-757ccc450cad	720b4990-7e36-4d61-83b5-09d2d0c46889	School of Nuclear and Allied Sciences (SNAS)	6bffa611-8ae8-44a8-8fdd-78233b25503c	1	1	3,3	eduroam	\N	\N	wpa2	aes	9	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-07 09:53:13.185219	2019-08-07 15:13:30.15387
3ecc6c9c-30e1-42a4-a2d4-df69fd0b5e13	720b4990-7e36-4d61-83b5-09d2d0c46889	School of Communication Studies (SCS)-Annex	28fba8e0-729d-49b8-810c-b70276c163fd	1	1	3,3	eduroam	\N	\N	wpa2	aes	3	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-07 09:51:53.948325	2019-08-09 09:39:55.173468
a0f66bdc-c12d-47d7-81db-2ab25f2e1282	720b4990-7e36-4d61-83b5-09d2d0c46889	Liman_Hall	a2d0136b-28d5-4326-9c1a-db8919d3aae3	1	1	3,3	eduroam	\N	\N	wpa2	aes	31	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-06 16:55:29.193168	2019-08-06 16:55:29.21271
bf722ab4-b455-4b11-8e7d-e8c055f3c6bc	720b4990-7e36-4d61-83b5-09d2d0c46889	MATH_DEPT	899a6103-9d32-4afe-ae60-ef74e9ffacb9	1	1	3,3	eduroam	\N	\N	wpa2	aes	7	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-06 17:03:05.036656	2019-08-06 17:03:05.057351
cd4a2e76-7c0c-467c-b72f-479de882224a	720b4990-7e36-4d61-83b5-09d2d0c46889	Jones Quartey Building (JQB) 	6dd2c6e5-8754-4947-86bd-a9baccde2b9f	1	1	3,3	eduroam	\N	\N	wpa2	aes	4	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-06 16:32:37.821365	2019-08-07 12:35:50.345824
9c6e6b33-c255-438d-80aa-6cf0f3d790f8	720b4990-7e36-4d61-83b5-09d2d0c46889	Livestock and Poultry Research Centre, Nungua	0bc0c06e-1ce7-4ada-928e-7b4afe2584ce	1	1	3,3	eduroam	\N	\N	wpa2	aes	9	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-07 08:59:29.109073	2019-08-07 12:30:20.07528
7ee138f9-5af1-46ac-90cb-2113cd252d17	720b4990-7e36-4d61-83b5-09d2d0c46889	Institute of African Studies	9ae5c04f-50b4-44fc-b7a5-c035a7d50330	1	1	3,3	eduroam	\N	\N	wpa2	aes	7	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-07 08:46:00.944901	2019-08-07 12:31:16.36238
1e5823f8-96db-4f06-a06e-0e6bbb4c9349	720b4990-7e36-4d61-83b5-09d2d0c46889	Physical Development and Municipal Services Directorate.(PDMSD)	ccaa920c-8e7d-49f1-9803-0039466f91b1	1	1	3,3	eduroam	\N	\N	wpa2	aes	12	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-07 09:03:02.914117	2019-08-07 12:30:38.896062
ac99ea85-6eab-49ce-8b75-c2d254ee64f0	720b4990-7e36-4d61-83b5-09d2d0c46889	University of Ghana Business School - Graduate Campus	d77937ce-f706-46f2-875c-10e69f087c73	1	1	3,3	eduroam	\N	\N	wpa2	aes	19	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-07 08:49:06.547318	2019-08-07 12:30:49.589563
fe0c19b7-e4cc-4ed9-9da2-b17d6f1e1abd	720b4990-7e36-4d61-83b5-09d2d0c46889	Pentagon	d668ffb7-c2a1-493c-9a6f-742bc5799f18	1	1	3,3	eduroam	\N	\N	wpa2	aes	10	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-07 09:07:58.618259	2019-08-07 09:07:58.666072
c0a880ec-d563-4189-9be8-fdc968e804df	720b4990-7e36-4d61-83b5-09d2d0c46889	School of Performing Arts (SPA)	83ab5e7d-6155-401d-90f3-568c927b2769	1	1	3,3	eduroam	\N	\N	wpa2	aes	6	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-07 10:04:04.350428	2019-08-07 15:14:53.95199
57b67154-f678-4704-9f0e-ca8350a04f8b	720b4990-7e36-4d61-83b5-09d2d0c46889	PHYS-CHEM	8f91da13-cefc-447c-b06b-a5129e0d8d86	1	1	3,3	eduroam	\N	\N	wpa2	aes	7	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-07 09:24:27.147043	2019-08-07 09:24:27.172331
40231793-3519-41aa-a01b-6bfa94390118	720b4990-7e36-4d61-83b5-09d2d0c46889	Registry	cd9f4920-6041-46b8-91a3-759f25d1d9fa	1	1	3,3	eduroam	\N	\N	wpa2	aes	25	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-07 09:27:33.264627	2019-08-07 09:27:33.28759
08d96490-cee3-42fe-a312-0227cc8e1dbe	720b4990-7e36-4d61-83b5-09d2d0c46889	Religion	3048470f-4bab-4457-bbf2-98fd621018ca	1	1	3,3	eduroam	\N	\N	wpa2	aes	15	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-07 09:29:00.324081	2019-08-07 09:29:00.348249
64d33e90-4154-4366-a482-00b844ee7799	720b4990-7e36-4d61-83b5-09d2d0c46889	Residence	305d12b1-a398-4ab1-b793-2d2225823170	1	1	3,3	eduroam	\N	\N	wpa2	aes	16	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-07 09:30:20.59455	2019-08-07 09:30:20.629345
2d85be45-66fc-40ea-bf9e-88b387ad6422	720b4990-7e36-4d61-83b5-09d2d0c46889	Sarbah_Hall	b7b2d098-f932-477d-9242-fe5df4ab8685	1	1	3,3	eduroam	\N	\N	wpa2	aes	93	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-07 09:34:04.165242	2019-08-07 09:34:04.179091
1d1038e1-0d0a-4027-ad84-ca3856ad6998	720b4990-7e36-4d61-83b5-09d2d0c46889	Bookshop Area	2c321e2e-60df-4ce7-9c65-10fb9fa84876	1	1	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-07 08:53:39.776468	2019-08-09 16:45:32.073506
1c1638bb-9a7d-49c8-9d87-d9278469920b	720b4990-7e36-4d61-83b5-09d2d0c46889	Pharmacy_Dept	c4dc1ebc-e049-4289-b235-3d789c948f64	1	1	3,3	eduroam	\N	\N	wpa2	aes	4	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-07 09:13:45.643506	2019-08-07 15:13:57.727002
544bb5df-170f-48d8-8e0c-dd95955facd7	720b4990-7e36-4d61-83b5-09d2d0c46889	Social_Studies	7831564c-a54e-430a-9119-d0a54c530949	1	1	3,3	eduroam	\N	\N	wpa2	aes	11	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-07 10:01:46.999771	2019-08-07 10:01:47.070855
da8335fd-5f85-4305-b5dc-576125731eba	720b4990-7e36-4d61-83b5-09d2d0c46889	University of Ghana Computing Systems (UGCS)	8fa53bc3-d5d3-4b5e-9965-cb93b2994fd6	1	1	3,3	eduroam	\N	\N	wpa2	aes	8	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-07 10:37:45.717426	2019-08-07 15:16:07.869749
91de73b2-351d-4f09-8929-c51e9f25d2b3	720b4990-7e36-4d61-83b5-09d2d0c46889	Valco Hostel	b6feb511-569c-4713-a70e-a0eba15758f9	1	1	3,3	eduroam	\N	\N	wpa2	aes	19	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-07 10:42:52.243075	2019-08-09 16:49:42.42935
e99acd89-9982-47de-b1fd-e24bf006721a	720b4990-7e36-4d61-83b5-09d2d0c46889	Sports_Alumni	ec87b824-660b-48f8-aeed-e9ed9a473fb6	1	1	3,3	eduroam	\N	\N	wpa2	aes	11	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-07 10:23:55.749158	2019-08-07 10:23:55.768935
a81bdaf1-b144-499c-9f92-3232450f8692	720b4990-7e36-4d61-83b5-09d2d0c46889	SRC-Student_Clinic	01081b19-b9ff-4c34-bb62-78b740422f35	1	1	3,3	eduroam	\N	\N	wpa2	aes	2	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-07 10:32:51.772819	2019-08-07 10:32:51.795219
8924369e-94b1-4f7d-8ecd-823396fa3468	720b4990-7e36-4d61-83b5-09d2d0c46889	Legon Hall	05de7bab-6f76-45f8-9cb7-4b93a7684ae8	1	1	3,3	eduroam	\N	\N	wpa2	aes	55	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-06 16:52:03.644632	2019-08-07 16:40:38.889795
fdc2173c-a570-4d34-9f85-fed256350901	720b4990-7e36-4d61-83b5-09d2d0c46889	Soil and Irrigation Research Centre (SIREC), Kpong	f64c267f-02cc-4c2a-8b4c-e1609709bb92	1	1	3,3	eduroam	\N	\N	wpa2	aes	6	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-06 16:39:35.771341	2019-08-07 15:22:58.940006
34e2e556-abe9-412b-8236-40812e006643	f897a4d3-44ca-4543-82aa-b4e502c6463e	Faculty of Management Science	23a50e79-97c4-42d2-87ea-e066a6109dfe	1	0	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	f	f	0	Always		2020-03-04 09:29:49.600829	2020-03-04 09:29:49.611559
476d0628-2adb-4ee9-a169-34cbdd8b49db	720b4990-7e36-4d61-83b5-09d2d0c46889	VC Lodge	db51912b-7077-4bea-aaba-cbb0d1682e02	1	1	3,3	eduroam	\N	\N	wpa2	aes	3	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-07 11:02:14.266671	2019-08-07 11:02:14.29013
038eed1e-fd13-48ed-9a6f-48326ab4be73	720b4990-7e36-4d61-83b5-09d2d0c46889	University of Ghana Business School (UGBS)	c8622c32-3a15-4587-bb04-fd5464e58fbf	1	1	3,3	eduroam	\N	\N	wpa2	aes	20	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-07 10:34:46.556096	2019-08-07 15:25:43.088616
f779763a-c926-4b2e-a7c0-48b77fcb9a9d	720b4990-7e36-4d61-83b5-09d2d0c46889	Veterinary	17f04df8-15f8-4d45-9fc9-392506f44444	1	1	3,3	eduroam	\N	\N	wpa2	aes	3	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-07 11:21:50.754033	2019-08-07 11:21:50.794095
a6a374eb-268d-49d1-bf17-9aa1011970c8	720b4990-7e36-4d61-83b5-09d2d0c46889	Volta_Hall	c6648eac-18bc-40d2-9c9d-c6b034188426	1	1	3,3	eduroam	\N	\N	wpa2	aes	13	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-07 11:25:17.279312	2019-08-07 11:25:17.295037
7a535503-e260-4304-b6b5-cd28471b7831	720b4990-7e36-4d61-83b5-09d2d0c46889	Institute Of Statistical, Social And Economic Research (ISSER)	281e015a-606a-4345-a584-fcdd2a62621d	1	1	3,3	eduroam	\N	\N	wpa2	aes	10	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-06 16:20:12.563438	2019-08-07 13:36:38.088364
a497f23b-9371-4393-9f52-7ddbec12033f	720b4990-7e36-4d61-83b5-09d2d0c46889	UG Forest and Horticultural Research Center (KADE)	24f6998b-02e3-4cac-b4fb-203f9c0d6940	1	1	3,3	eduroam	\N	\N	wpa2	aes	5	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-06 16:34:47.492643	2019-08-07 13:38:19.580194
1e977911-197d-4a6a-b78c-d2d4208539ed	720b4990-7e36-4d61-83b5-09d2d0c46889	School of Public Health (SPH)	bed5bf95-5e52-46e4-b8bf-142796b8917c	1	1	3,3	eduroam	\N	\N	wpa2	aes	21	1	f	f	f	f	f	0	Always	https://www.ug.edu.gh	2019-08-07 10:21:09.318167	2019-08-07 15:26:38.001766
8e3edbfd-a7ee-4e80-acfc-f7f2505fd23f	983c15ee-9a50-4725-bfc0-9e2067ec14fa	Faculty of Architecture and Planning - Postgraduate New Block	2af917c3-c173-447f-8e45-88226e4cb458	1	1	3,3	eduroam	\N	\N	wpa2	aes	4	1	f	f	f	t	f	0	Always		2019-08-08 11:33:08.841575	2019-08-08 11:33:08.872369
c509880d-7e70-4b74-86bc-e8fc319d4d90	983c15ee-9a50-4725-bfc0-9e2067ec14fa	Faculty of Architecture and Planning - Studio 1	bcdb9317-a536-4901-a774-04e07567cfd2	1	1	3,3	eduroam	\N	\N	wpa2	aes	7	1	f	f	f	t	f	0	Always		2019-08-08 11:46:26.066089	2019-08-08 11:46:26.08492
b4fc7f15-99dd-4471-bccb-a2ead832d8c9	f897a4d3-44ca-4543-82aa-b4e502c6463e	Education	6468ee4d-9d99-45b4-bd38-b2f51133019b	1	0	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	f	f	0	Always		2020-03-04 08:59:15.198519	2020-03-04 08:59:15.208935
a7181ef6-8df2-4def-9f8b-e2ce2a3100a0	f897a4d3-44ca-4543-82aa-b4e502c6463e	Faculty of Arts	5b0bc63a-104a-4b87-8c94-8633b35d0830	1	0	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	f	f	0	Always		2020-03-04 09:00:22.522912	2020-03-04 09:00:22.536238
4f30f466-cf19-4bd9-96a6-50dae24f9a0c	f897a4d3-44ca-4543-82aa-b4e502c6463e	ICT Directorate	b5c0b538-0b71-4749-965e-972b1dde4cce	1	0	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	f	f	0	Always	https://www.unijos.edu.ng	2019-08-09 11:58:34.171878	2019-08-09 11:58:34.204319
11db708a-343e-420e-a975-123db5815fb2	983c15ee-9a50-4725-bfc0-9e2067ec14fa	Faculty of Architecture and Planning - Dean's Office	97e0c350-2794-4555-bd0f-e9a609242e8f	1	1	3,3	eduroam	\N	\N	wpa2	aes	8	1	f	f	f	t	f	0	Always		2019-08-08 11:52:02.992496	2019-08-09 16:57:14.948662
6014c42d-5f6a-4398-8ba9-639b11f42a49	983c15ee-9a50-4725-bfc0-9e2067ec14fa	Faculty of Art Studio	8a6b3544-d261-4daa-86b0-ad68e6ebbf6e	1	1	3,3	eduroam	\N	\N	wpa2	aes	9	1	f	f	f	t	f	0	Always		2019-08-08 12:12:45.149986	2019-08-09 16:58:08.304969
91b1721d-702d-4f35-8fa3-9f9580967c0e	983c15ee-9a50-4725-bfc0-9e2067ec14fa	CABE - Art Education Building	5ad8878c-a8b9-4ea9-a777-ca383f08281e	1	1	3,3	eduroam	\N	\N	wpa2	aes	3	1	f	f	f	t	f	0	Always		2019-08-08 11:55:26.635204	2019-08-09 17:03:13.110546
b3689bc6-2963-48df-bad0-3a4f90578789	983c15ee-9a50-4725-bfc0-9e2067ec14fa	Provost Office Blk, CABE - Owusu Addo Building	0116d335-bbd7-49ec-bf91-e61dc16566a8	1	1	3,3	eduroam	\N	\N	wpa2	aes	14	1	f	f	f	t	f	0	Always		2019-08-08 11:59:19.445495	2019-08-09 17:05:56.498613
b517602d-def9-4fb2-be65-eea3dfacb200	983c15ee-9a50-4725-bfc0-9e2067ec14fa	Faculty of Art Building - Adarkwa Building	da2f700b-5384-4c07-bd4f-de89d39b6042	1	1	3,3	eduroam	\N	\N	wpa2	aes	3	1	f	f	f	t	f	0	Always		2019-08-08 12:07:03.088234	2019-08-09 17:06:30.500564
93d6f58f-efa3-4516-9698-2f04cbea7db0	f897a4d3-44ca-4543-82aa-b4e502c6463e	Faculty of Natural Sciences	5548e692-d517-4958-ae7f-dc19e5b515bd	1	0	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	f	f	0	Always		2020-03-04 09:02:19.472947	2020-03-04 09:02:19.485148
e5a6bcec-ab50-4e5f-840d-e75f8e6ca6dd	fad269fb-c5f3-4ab2-b7ce-2d5158df531a	mgix	0b4b520e-3c5d-4cd7-9f43-21972d6dc5bb	1	0	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	f	f	0	Always		2019-10-16 11:59:36.917043	2021-04-16 08:01:56.474341
4925482f-825c-4cac-9a1b-625cca95899e	0a67d914-b70f-4970-ad77-6b8caf423852	EthERNet	02aa2c35-ee7e-4f64-8c65-06b80202cce9	1	0	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	f	f	0	Always		2020-02-29 06:47:43.325022	2020-02-29 06:47:43.354584
6b092ff0-46a5-4ba6-9545-aea2f4e6590b	f897a4d3-44ca-4543-82aa-b4e502c6463e	Senate Building	680b5334-ebae-4436-b8ec-2247f0a80881	1	0	3,3	eduroam	\N	\N	wpa2	aes	5	1	f	f	f	f	f	0	Always		2020-03-03 12:45:19.332321	2020-03-03 12:45:19.348034
cece05f8-00e5-49ed-a24a-584ebcfcb44f	f897a4d3-44ca-4543-82aa-b4e502c6463e	Admin Block	1ad83e63-2727-47a6-a465-afbef97c3821	1	0	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	f	f	0	Always		2020-03-04 08:53:44.908874	2020-03-04 08:53:44.925596
3cd7621f-5539-4035-8729-08adbd2e22f0	f897a4d3-44ca-4543-82aa-b4e502c6463e	Main Library Bauchi Rd.	104b683c-d114-4e6d-9211-7a30a27e516b	1	0	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	f	f	0	Always		2020-03-04 08:55:31.609683	2020-03-04 08:55:31.622376
ad495a86-dc97-4634-9c38-1c74825fd3ea	f897a4d3-44ca-4543-82aa-b4e502c6463e	Pharmacy 	bf270839-0935-4dfa-8598-5acc2d6936f5	1	0	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	f	f	0	Always		2020-03-04 08:58:08.751719	2020-03-04 08:58:08.769576
c1c1ba9d-6f90-4e88-9a75-27c4c98a7036	f897a4d3-44ca-4543-82aa-b4e502c6463e	ICT Complex I	1876323a-dcc2-46a3-a85c-0ea385ef49f3	1	0	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	f	f	0	Always		2020-03-04 09:05:44.50441	2020-03-04 09:05:44.51897
737a1574-e746-4a6d-9b2e-375ab6105b0d	f897a4d3-44ca-4543-82aa-b4e502c6463e	ICT Complex II	36b90c8c-1088-4738-949a-2addef425137	1	0	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	f	f	0	Always		2020-03-04 09:06:28.118619	2020-03-04 09:06:28.12962
2fe4b053-3cd9-491b-987a-4061457e783f	f897a4d3-44ca-4543-82aa-b4e502c6463e	Biochemistry	56de56b3-bd8c-4a9f-bbba-1b7bbe4fc83f	1	0	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	f	f	0	Always		2020-03-04 09:07:28.550443	2020-03-04 09:07:28.561131
61d83ad3-01a1-4dc7-a67d-b23548ab5735	f897a4d3-44ca-4543-82aa-b4e502c6463e	Advancement Office	71588743-1a19-487f-ba00-8d1d528c48e3	1	0	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	f	f	0	Always		2020-03-04 09:08:07.703297	2020-03-04 09:08:07.717887
6b84c295-0ce8-44aa-8058-154ee9a9d355	f897a4d3-44ca-4543-82aa-b4e502c6463e	College of Medicine	725290ca-a295-406e-8b34-c5f29e930201	1	0	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	f	f	0	Always		2020-03-04 09:08:48.905063	2020-03-04 09:08:48.917789
c4ba8460-8a81-4c7e-852b-ab8f7515f7ce	f897a4d3-44ca-4543-82aa-b4e502c6463e	Engineering	b3530263-de10-4996-b8a4-d2aaaf6e976c	1	0	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	f	f	0	Always		2020-03-04 09:09:37.926645	2020-03-04 09:09:37.938421
66083abe-8a10-4b3f-a802-8ac3bb09fe5e	f897a4d3-44ca-4543-82aa-b4e502c6463e	Historical Data	2fafe6ec-6a27-4ff1-8ff0-666375fbc11a	1	0	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	f	f	0	Always		2020-03-04 09:10:10.404676	2020-03-04 09:10:10.413594
4b1e7a68-c0dd-47d2-85f3-4d1857c84fb3	f897a4d3-44ca-4543-82aa-b4e502c6463e	Institute of Education	07327470-2b0d-46b9-b13a-0eb9e914126f	1	0	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	f	f	0	Always		2020-03-04 09:11:13.776343	2020-03-04 09:11:13.787649
e6701145-1bd2-4da9-a3a7-928ee88dfbba	f897a4d3-44ca-4543-82aa-b4e502c6463e	Faculty of Law	08f02855-c885-4504-9ddb-2071be5d4283	1	0	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	f	f	0	Always		2020-03-04 09:14:16.817699	2020-03-04 09:14:16.831995
7e37fe8d-448b-4347-8f5d-13a897b1f28f	f897a4d3-44ca-4543-82aa-b4e502c6463e	Maths	58223ad0-2b2c-46b4-9447-6274bc11c80f	1	0	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	f	f	0	Always		2020-03-04 09:15:09.807778	2020-03-04 09:15:09.819453
91bf4fd6-b625-4db0-a1d2-907e310d8ba8	f897a4d3-44ca-4543-82aa-b4e502c6463e	Nursing Science	03f63954-6c8c-4ea6-9498-4986a3bd9b35	1	0	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	f	f	0	Always		2020-03-04 09:16:29.060932	2020-03-04 09:16:29.071915
86e6d2c7-821c-47b6-8bb6-c399978d9b6d	f897a4d3-44ca-4543-82aa-b4e502c6463e	Peace and Conflict	88fdaca6-747e-49aa-8890-da9ffeeafbd4	1	0	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	f	f	0	Always		2020-03-04 09:17:32.033093	2020-03-04 09:17:32.044701
61998dba-ce3f-4c24-9051-60d1d581f8ce	f897a4d3-44ca-4543-82aa-b4e502c6463e	Physics and Chemistry	86ab50ea-eb11-41d1-aea7-99d8e64ac68a	1	0	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	f	f	0	Always		2020-03-04 09:18:10.129464	2020-03-04 09:18:10.141783
11c87fe6-e931-4453-a29a-4647602dc1b5	f897a4d3-44ca-4543-82aa-b4e502c6463e	Security-Computer Sci	e0e0b0ac-1df1-4445-971e-68cd3a37a363	1	0	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	f	f	0	Always		2020-03-04 09:19:20.209809	2020-03-04 09:19:20.222851
ac431f27-aa43-47b7-a2c2-b9a99a6d5d6e	f897a4d3-44ca-4543-82aa-b4e502c6463e	Zoology-Plant Sci	68ee0296-db4d-4946-8830-1a3e3c553ac2	1	0	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	f	f	0	Always		2020-03-04 09:20:41.222418	2020-03-04 09:20:41.237459
61fd7d02-7660-4de9-8f3a-b451499c3db7	f897a4d3-44ca-4543-82aa-b4e502c6463e	Architecture	ffb0dd09-cf55-4a28-a99d-76c14837a03d	1	0	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	f	f	0	Always		2020-03-04 09:21:54.718505	2020-03-04 09:21:54.730254
f3bdd6e8-cf26-4984-863c-4f01f47ac359	f897a4d3-44ca-4543-82aa-b4e502c6463e	CES	7fce34df-ae60-4ccd-a043-b11934a80f0b	1	0	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	f	f	0	Always		2020-03-04 09:22:24.700743	2020-03-04 09:22:24.712653
f6d749b3-e281-4886-a14d-e63bf8ca4e4d	f897a4d3-44ca-4543-82aa-b4e502c6463e	Environmental	541f7cd2-2e81-46ec-97af-10af5e473f90	1	0	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	f	f	0	Always		2020-03-04 09:23:03.623529	2020-03-04 09:23:03.634019
f2ddd37e-05fc-4514-aaf6-9f0c45660f80	f897a4d3-44ca-4543-82aa-b4e502c6463e	Geo-Mining	34c85ca3-18cf-4f96-86fe-fea6247f4fd4	1	0	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	f	f	0	Always		2020-03-04 09:25:34.40429	2020-03-04 09:25:34.41655
1cb045d8-7d91-40de-a301-70c328dcfb3d	f897a4d3-44ca-4543-82aa-b4e502c6463e	Geography	275f2679-fc1e-4dd4-870f-746d3df62211	1	0	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	f	f	0	Always		2020-03-04 09:27:46.994352	2020-03-04 09:27:47.00515
d960e095-0ac9-4ae5-8a0c-7eb99f1ebaf3	f897a4d3-44ca-4543-82aa-b4e502c6463e	Health Center	3b427a43-f197-4bff-a95e-f2b2bbd2a201	1	0	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	f	f	0	Always		2020-03-04 09:28:22.134886	2020-03-04 09:28:22.145127
c78502ce-015c-4a83-aa78-750ab2b854a4	f897a4d3-44ca-4543-82aa-b4e502c6463e	Law and Diplomacy	af390053-83f1-40b8-b362-71d5dc54a0d7	1	0	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	f	f	0	Always		2020-03-04 09:28:59.844272	2020-03-04 09:28:59.85369
1ed1c43b-9119-4170-9867-54b6620f9b2a	f897a4d3-44ca-4543-82aa-b4e502c6463e	PG School	ddda11ce-67ae-4bce-bf9d-c8b769f7736c	1	0	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	f	f	0	Always		2020-03-04 09:30:22.327738	2020-03-04 09:30:22.338944
d34a8c91-c44d-4ce4-8604-c294425f3edc	f897a4d3-44ca-4543-82aa-b4e502c6463e	URP	ccc1daed-8e25-4808-a48d-780dee399280	1	0	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	f	f	0	Always		2020-03-04 09:30:55.539906	2020-03-04 09:30:55.553102
76133617-5b79-40fc-81eb-12188b395a58	f897a4d3-44ca-4543-82aa-b4e502c6463e	ACEPRD	96fe8fc6-c051-4229-a0a5-7a09b36c98a5	1	0	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	f	f	0	Always		2020-03-04 09:31:51.285777	2020-03-04 09:31:51.304121
899313e0-730d-4c25-8f2a-fa8e02cdab5e	f897a4d3-44ca-4543-82aa-b4e502c6463e	VC's Lodge	a0efc623-9dcc-4495-be3c-cd554ff15388	1	0	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	f	f	0	Always		2020-03-04 09:32:50.061389	2020-03-04 09:32:50.071721
42aeb587-d91b-4665-9b17-9b048f0c14d9	983c15ee-9a50-4725-bfc0-9e2067ec14fa	Great Hall	2804c4e2-793b-496b-a356-1d8437d4d1ed	1	1	3,3	eduroam	\N	\N	wpa2	aes	10	1	f	f	f	t	f	0	Always		2020-09-25 16:19:00.590845	2020-09-25 16:19:00.596216
bf6fbc17-189d-40a8-a40d-fd10fa13cbca	983c15ee-9a50-4725-bfc0-9e2067ec14fa	Casely-Hayford Building (Exams)	f217b8a8-85b7-4e78-9a8c-893f999b79f7	1	1	3,3	eduroam	\N	\N	wpa2	aes	19	1	f	f	f	t	f	0	Always		2020-09-25 16:23:08.733619	2020-09-25 16:23:08.737423
280d5af0-eeab-44e0-9d6e-384a6b05be94	983c15ee-9a50-4725-bfc0-9e2067ec14fa	ICT CENTER	4ce9f2cc-83a5-4d4f-9cde-be1b3f8e38b2	1	1	3,3	eduroam	\N	\N	wpa2	aes	3	1	f	f	f	t	f	0	Always		2020-09-25 16:30:04.875284	2020-09-25 16:30:04.88045
d0d4e6c4-6d51-448b-b246-4ca16a1ec9b2	c6a1da0a-512f-477d-ad3b-4ed3f2cba737	auf	3d2f68f8-59d1-4454-8f56-e62e0da95c8b	1	0	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	f	f	0	Always		2021-04-15 05:17:53.685735	2021-04-15 05:17:53.96709
5246784b-692e-412f-8488-dae6f22d30d9	1c04c719-fda2-49bb-a2e4-82c952394d50	somaliren.org.so	53ad53da-65fd-4053-bd3a-ecbb82073e05	1	0	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	f	f	0	Always		2021-04-29 08:52:03.849737	2021-04-29 08:52:03.874629
05707278-bf54-4f0a-b85e-d48edce107d4	983c15ee-9a50-4725-bfc0-9e2067ec14fa	KATH-SMS - GetFund Hostel	7946ea26-2ef6-493d-99d3-e3acc765b956	1	1	3,3	eduroam	\N	\N	wpa2	aes	43	1	f	f	f	t	f	0	Always		2020-09-25 16:02:24.611192	2021-04-29 11:19:41.040411
6b61d79d-8a7a-4c6f-b3d4-ff07877bd5ff	86b3926e-5f58-4f34-a48c-e4cd7204bee9	Office	44e8d16b-6024-44eb-9d9c-4b2c1c952379	1	0	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	f	f	0	Always		2021-06-11 09:52:29.894599	2021-06-11 09:52:29.898906
831f7acb-a253-409c-942d-652ec3d21cf0	f5e8d182-0759-45a2-a54e-8a50a43fbab6	UL NOC	b1369fd3-b674-405e-a471-d628eee1010a	1	0	3,3	eduroam	\N	\N	wpa2	aes	1	1	f	f	f	f	f	0	Always		2021-10-18 15:30:55.81322	2021-10-18 15:30:55.81915
\.


--
-- Data for Name: memberships; Type: TABLE DATA; Schema: public; Owner: switchboarder
--

COPY public.memberships (id, user_id, organisation_id, operator, created_at, updated_at) FROM stdin;
c2d78c0b-4c45-4c9d-a03a-33df598cec52	3	1b86a4eb-944e-49c3-b183-0c631b1d27bc	t	2018-05-17 14:42:10.409385	2018-07-24 15:00:40.918773
d6e72e31-83f6-4c61-a6a0-b6498a5d30a8	4	cd8a9e52-58b9-4fcc-93ca-e53a81d50383	t	2018-05-17 15:04:22.346255	2018-07-24 15:23:09.482668
8de89e46-6d1f-48a8-824f-2af5ea7d2cb8	5	cd8a9e52-58b9-4fcc-93ca-e53a81d50383	t	2018-07-24 15:23:22.667641	2018-07-24 15:23:28.269132
027c43eb-8f67-4ef3-a743-52dd55b41956	7	ba395f36-ef32-4db2-8042-0f23c6fccbcb	t	2018-07-25 05:57:48.766543	2018-07-25 05:57:48.766543
404eb784-09a2-498c-9333-d8d79b424882	8	7d9384ac-82bf-430e-a5c6-3372970a13d0	t	2018-08-15 07:47:27.862205	2018-08-15 07:47:27.862205
17bdfb75-c486-40fb-af81-62441c7ea4fd	10	7ccfcd5c-da2a-44d2-acff-f7a51ec5b199	t	2018-08-27 10:37:17.466077	2018-08-27 10:37:17.466077
1ddcfa84-6ef2-4553-8a96-87cc7c1a23eb	13	1ae8ed07-9a09-4c42-ba70-45cefae61ac5	t	2018-08-30 14:35:53.045825	2018-08-30 14:37:16.017553
4524eff1-c853-43c8-bd56-4b2c858882e8	12	7ccfcd5c-da2a-44d2-acff-f7a51ec5b199	t	2018-08-30 14:38:02.443602	2018-08-30 14:38:08.638421
f204f4fc-74b5-4c6f-a0f2-b50d98358598	14	ba395f36-ef32-4db2-8042-0f23c6fccbcb	t	2018-08-31 11:20:50.70409	2018-08-31 11:26:32.41228
9e327837-4278-4e20-afa6-c335f1411d4a	15	8d2a33be-7230-4c87-b6a3-499b4e18bf63	f	2018-11-22 09:26:50.123818	2018-11-22 09:26:50.123818
c264405d-39fe-434b-9194-839c54ff503f	14	c6a1da0a-512f-477d-ad3b-4ed3f2cba737	f	2018-11-23 10:12:45.609927	2018-11-23 10:12:45.609927
77c24a38-3d5f-4c3e-bb3c-e4c4ab363e21	7	c6a1da0a-512f-477d-ad3b-4ed3f2cba737	f	2018-11-23 10:22:52.175209	2018-11-23 10:22:52.175209
c2a4ed1e-08a2-4de9-8201-3691b270f56d	2	911a5df1-70bb-43a6-99c3-9138271109ed	t	2018-05-17 15:09:50.53524	2018-05-17 15:09:50.53524
505adfe1-1b78-452f-8f9e-cfb81daa92c1	50	911a5df1-70bb-43a6-99c3-9138271109ed	t	2021-03-13 08:45:19.542338	2021-04-06 10:04:02.949994
a1ed05dd-38e4-4fab-b731-f23a4d6a98d7	54	1c04c719-fda2-49bb-a2e4-82c952394d50	t	2021-04-29 08:48:45.09874	2021-04-29 08:48:59.347367
3ee2fdbe-c653-4009-980b-3543f27b08e6	9	94cf650e-540c-4d89-9f69-8891719fb5b5	f	2019-02-01 04:36:10.387605	2019-02-01 04:36:10.387605
296eda5b-2a92-4c2c-ac86-af499a1602c2	7	fad269fb-c5f3-4ab2-b7ce-2d5158df531a	f	2019-03-27 06:10:46.112613	2019-03-27 06:10:46.112613
0420197b-a5d1-4182-822e-382698ce31ef	9	b7a4f25d-aa72-4812-a1dd-a563d26ba979	t	2019-03-27 10:27:19.329955	2019-03-27 10:27:38.638025
de76a306-778c-437b-a086-d05dc27f5f37	19	6f4462ad-1f14-4e25-be5e-88cf2e42cec1	f	2019-04-02 11:45:32.353818	2019-04-02 11:45:32.353818
03ddb129-24b2-475a-9533-7da321ff0e21	20	f897a4d3-44ca-4543-82aa-b4e502c6463e	f	2019-04-03 08:28:17.046384	2019-04-03 08:28:17.046384
77ca615f-9edb-422b-94ac-ac5c691a01a1	21	96f247af-06f8-4c6a-b325-71f89fd65bd5	f	2019-04-03 14:35:53.503189	2019-04-03 14:35:53.503189
185610ac-9ee0-44aa-90bf-281db9f46d81	22	d732f8b8-d167-4dac-b175-724f7188be6a	f	2019-04-04 15:50:29.985137	2019-04-04 15:50:29.985137
ac63cb95-6274-453d-9cc0-816dd49da493	23	9b15ed64-9965-4b8d-8857-98844f2a5e14	f	2019-04-18 11:13:41.256265	2019-04-18 11:13:41.256265
8d67a5d6-8bde-40ea-9ade-9ac2ad4b8f6d	4	991db693-847f-4626-ab05-c4bafd190f92	f	2019-05-03 10:45:08.018314	2019-05-03 10:45:08.018314
a07c87dc-4f63-48be-b551-55d8222fa897	1	679f67b6-cf16-4c36-a887-77c06fb2d05b	f	2019-05-15 15:12:37.34181	2019-05-15 15:12:37.34181
f2742620-4aa5-4bc1-a88e-ce0d63b615cc	25	b6c4ac4f-b841-48cc-9468-cd3a3e913fa7	f	2019-05-17 13:46:03.162346	2019-05-17 13:46:03.162346
772af1da-4bc6-48ca-84f8-ccbe26d2769d	27	d785f154-2f0a-4055-be46-e44862c54a67	t	2019-07-31 14:05:44.637226	2019-07-31 14:05:44.637226
42f06f14-9b48-462b-9c66-c57cf4132e08	28	d785f154-2f0a-4055-be46-e44862c54a67	t	2019-07-31 14:06:00.682673	2019-07-31 14:06:00.682673
2457c90f-cb3d-485b-aeb5-bbbb9c86b10a	31	720b4990-7e36-4d61-83b5-09d2d0c46889	f	2019-08-04 21:03:10.390174	2019-08-04 21:03:10.390174
b14ca786-58a7-44da-83f2-828d08e47c4f	31	5b033895-13ed-43b3-a21a-62fdb56e38d4	t	2019-08-04 19:57:15.367452	2019-08-06 05:47:08.75072
d4f424c5-5e30-4e10-96ee-5b5a59eb83b7	12	94cf650e-540c-4d89-9f69-8891719fb5b5	f	2019-08-06 06:23:12.352242	2019-08-06 06:23:12.352242
28f03d22-8e26-4aa1-9e52-2b6221fe3e5e	32	983c15ee-9a50-4725-bfc0-9e2067ec14fa	f	2019-08-06 07:20:15.302408	2019-08-06 07:20:15.302408
2ae0875d-d973-47e5-83c6-0d13f2162337	33	720b4990-7e36-4d61-83b5-09d2d0c46889	f	2019-08-06 12:58:47.994056	2019-08-06 12:58:47.994056
8749cba3-8095-47f4-b404-455e3a7c00fa	35	1e4bdaed-2062-439e-8ef3-593bdb2c4701	f	2019-08-07 16:31:27.298019	2019-08-07 16:31:27.298019
7049c6c4-ad77-417d-85d6-dbbd4ff81d22	34	c6235a8c-9c92-43e5-b246-8e46132f22f6	f	2019-08-08 13:52:05.076645	2019-08-08 13:52:05.076645
a73157b2-4033-465a-b139-9c296dfe025b	37	f897a4d3-44ca-4543-82aa-b4e502c6463e	f	2019-09-04 09:05:53.285132	2019-09-04 09:05:53.285132
e15aad48-8d0f-4865-8c97-8a480003e66c	37	f897a4d3-44ca-4543-82aa-b4e502c6463e	f	2019-09-04 09:07:02.752708	2019-09-04 09:07:02.752708
78597dd8-1d2d-4a94-9063-d5be900cf495	29	549299ce-02f6-4aed-bc57-b8e5131ff7f3	f	2019-10-04 14:44:17.521051	2019-10-04 14:44:17.521051
1f9e7d18-b2bb-403a-8565-7fd87d354dda	40	aee1e708-5a8f-4465-a558-97c61110d4bb	f	2019-10-31 14:43:05.943594	2019-10-31 14:43:05.943594
e6c21737-f978-4655-a6be-116b9992f9c0	34	64f81d4e-7d1a-4a40-b5b8-b1ddd99e5ecc	f	2019-11-19 13:25:25.57599	2019-11-19 13:25:25.57599
403263b8-52c6-412a-849c-80c0ad6f28f8	41	0a67d914-b70f-4970-ad77-6b8caf423852	t	2019-12-11 09:26:03.239901	2019-12-11 10:02:09.776359
1fe859d8-701e-4e8a-9249-133d9defdbb6	43	0a67d914-b70f-4970-ad77-6b8caf423852	t	2020-03-06 08:32:46.547668	2020-03-06 08:32:46.547668
13602478-90e5-4b1a-b55b-0e765d5ef69c	52	86b3926e-5f58-4f34-a48c-e4cd7204bee9	t	2021-06-11 09:58:04.982278	2021-06-11 09:58:04.982278
c484d2d6-62a8-4cdb-a64e-c8443a98bb6c	45	bdbce8c6-b4e0-4504-ad5f-d2c5440a7213	t	2020-06-04 15:13:07.49746	2020-06-04 15:13:07.49746
446e433f-70c5-466c-999d-0ecea51f0dc3	11	7ccfcd5c-da2a-44d2-acff-f7a51ec5b199	f	2021-03-09 13:32:01.815277	2021-03-09 13:32:44.962155
81d7dd66-0539-4691-a953-1be878812f81	56	6461d70e-ebf3-4502-8125-6a4623ec2a9a	f	2021-06-21 14:24:36.896299	2021-06-21 14:24:36.896299
7b5fbea1-b112-442d-9277-15e8ebbf795a	57	c379f63a-ef47-491a-98ba-6cb76daa20b0	f	2021-06-22 16:58:46.888335	2021-06-22 16:58:46.888335
0be10761-47f8-46b6-a704-e5860f1d96ce	58	6461d70e-ebf3-4502-8125-6a4623ec2a9a	f	2021-06-22 17:42:43.744021	2021-06-22 17:42:43.744021
a05fbccb-b107-4db2-b9c8-fbf6cb838ff0	59	6461d70e-ebf3-4502-8125-6a4623ec2a9a	f	2021-06-22 17:44:37.669674	2021-06-22 17:44:37.669674
9fa20344-c5ef-4fd2-b772-d88cd2fa8f5d	60	6461d70e-ebf3-4502-8125-6a4623ec2a9a	f	2021-06-22 17:45:07.032695	2021-06-22 17:45:07.032695
d55fc5c6-657e-4603-889d-938ad0ff9697	26	c6a1da0a-512f-477d-ad3b-4ed3f2cba737	f	2021-09-15 12:38:53.872104	2021-09-15 12:38:53.872104
8d793d36-79c7-4fca-9f16-ecb8e1c5b757	63	86b3926e-5f58-4f34-a48c-e4cd7204bee9	t	2021-10-12 13:34:38.779929	2021-10-12 13:35:08.315543
0340cead-f7ec-45e5-8fab-2e7b76386980	62	2bf8127f-b5fa-4f92-a65c-fce09f50114c	f	2021-10-12 13:43:32.343343	2021-10-12 13:43:32.343343
176be309-8c48-4570-bbcc-1ebbafdc508b	48	cd8a9e52-58b9-4fcc-93ca-e53a81d50383	t	2021-10-22 05:59:40.871291	2021-10-22 05:59:48.156975
87deca6f-8fb3-4214-9d02-b0e4e8fb2a30	26	f5e8d182-0759-45a2-a54e-8a50a43fbab6	t	2021-04-23 14:25:46.637624	2021-10-22 12:34:43.887857
9e6efd06-2e11-44a6-adce-0f603c40291a	42	0a67d914-b70f-4970-ad77-6b8caf423852	t	2021-11-02 12:13:30.471115	2021-11-02 12:13:42.612641
b376a680-c1f9-492f-b9f9-f9397dede4e7	64	911a5df1-70bb-43a6-99c3-9138271109ed	f	2021-11-29 09:27:11.316938	2021-11-29 09:27:11.316938
\.


--
-- Data for Name: organisations; Type: TABLE DATA; Schema: public; Owner: switchboarder
--

COPY public.organisations (id, name, federation_id, country_code, identifier, eduroam_type, venue_type, stage, info_url, policy_url, language, created_at, updated_at, domain_name) FROM stdin;
983c15ee-9a50-4725-bfc0-9e2067ec14fa	Kwame Nkrumah University of Science and Technology	c992c12c-7ef5-4914-9138-69c9fb6b74dc	GH	219212d4-783f-4e7a-a1d4-ff085dde870e	idp_sp	3,3	1	http://www.knust.edu.gh	http://www.knust.edu.gh/eduroampolicy	en	2019-08-06 06:36:07.30024	2019-08-06 08:06:19.038966	knust.edu.gh
c6a1da0a-512f-477d-ad3b-4ed3f2cba737	AUF	a33c9698-a460-40f9-849f-947ecb8fa561	MG	5c063488-297e-466a-86a5-ef9e651ebe54	idp	5,0	0	http://www.irenala.edu.mg	http://www.irenala.edu.mg	fr	2018-11-20 13:04:17.484337	2018-11-20 13:04:17.484337	irenala.edu.mg
8d2a33be-7230-4c87-b6a3-499b4e18bf63	BERNET	4d80c8e1-029a-4622-9159-e76dd83e5ea9	BI	c1c1433d-fa2d-43fb-80b2-9ff4e7eb47d4	idp_sp	3,0	0	https://eduroam.africa	https://eduroam.africa	fr	2018-11-22 09:22:21.828055	2018-11-22 09:22:21.828055	eduroam.africa
94cf650e-540c-4d89-9f69-8891719fb5b5	Eko-Konnect Research and Education Initiative	49429470-2505-49f1-8d22-052b51a6fe08	NG	722ae708-5ade-4601-a774-ce99a98f4c22	idp_sp	3,0	1	http://www.eko-konnect.org.ng	http://www.eko-konnect.org.ng/policy	en	2019-02-01 04:35:09.02398	2019-03-15 11:42:41.236568	eko-konnect.org.ng
b6c4ac4f-b841-48cc-9468-cd3a3e913fa7	Chambe Academy of Science and Technology	3bb9b123-b2b7-4456-92f5-aa638feea714	MW	190242f0-e7f4-40e0-8e04-4e8cb1eb247f	idp	3,3	0	https://cast.edu.me/info	https://cast.edu.me/policy.pdf	en	2019-05-17 08:05:24.765201	2019-05-17 08:10:55.022668	cast.edu.me
1786272a-a169-4b8c-b7fa-9f47905733fc	College of Medicine	2da7d3a9-81e9-4ae7-986c-142c690c41f1	MW	b757b655-1900-4841-9dc1-d0956b107244	idp_sp	3,3	1	https://www.medcol.mw	https://www.medcol.mw	en	2018-03-27 10:54:34.721021	2018-03-27 10:54:34.721021	medcol.mw
c0457fb7-fc36-4bac-8e6d-019c5d716cd6	Solwezi Tardes Training Institue	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	f7e816dd-5f8b-4862-b48f-1cdd2fa39c87	idp_sp	3,3	1	https://www.zamren.zm	https://www.zamren.zm	en	2018-11-26 10:26:49.830174	2021-02-04 12:21:10.144076	zamren.zm
7d9384ac-82bf-430e-a5c6-3372970a13d0	MoRENet	924256f9-5ed7-4795-9cb9-bfce3ee43abb	MZ	d97495d2-3913-49de-ad14-1e4eb6dbf7fd	idp_sp	3,0	1	http://www.morenet.ac.mz	http://www.morenet.ac.mz	pt	2018-05-24 14:14:11.34547	2018-05-24 14:14:11.34547	morenet.ac.mz
1b86a4eb-944e-49c3-b183-0c631b1d27bc	ZAMREN	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	64a3c567-d9e7-45e5-af4d-76e6b51e18a4	idp_sp	3,0	1	https://www.zamren.zm/	https://www.zamren.zm/	en	2018-05-17 14:41:52.132948	2018-05-30 12:11:38.794895	zamren.zm
ba395f36-ef32-4db2-8042-0f23c6fccbcb	i RENALA	a33c9698-a460-40f9-849f-947ecb8fa561	MG	ed0aee85-74d3-400c-b92c-014d76e5a18a	idp_sp	3,0	0	http://www.irenala.edu.mg	http://www.irenala.edu.mg	fr	2018-07-24 15:13:52.585933	2020-12-07 07:09:39.586619	irenala.edu.mg
0a67d914-b70f-4970-ad77-6b8caf423852	EthERNet	0b345644-3cdc-442e-8f7a-1add49e1ed4f	ET	90994cb6-e9d2-4334-9166-bc5484dd6815	idp_sp	3,0	1	http://www.ethernet.edu.et/	http://www.ethernet.edu.et/	en	2018-07-24 15:33:55.172092	2020-02-29 07:58:05.41422	ethernet.edu.et
1ae8ed07-9a09-4c42-ba70-45cefae61ac5	RNP	cc82422e-9475-4354-b40c-c2846af56272	BR	9a06b5b0-703e-4175-9bcf-634ceec54a53	idp_sp	3,3	1	https://ubuntunet.net	https://ubuntunet.net	pt	2018-08-30 14:35:42.579815	2018-08-30 14:35:42.579815	ubuntunet.net
b7a4f25d-aa72-4812-a1dd-a563d26ba979	RITER	17626b73-d195-419c-bb01-103754b95897	CI	fcf4fb2b-59b3-4bb3-888c-d6a218df5773	idp_sp	3,0	0	http://www.riter.ci	http://www.riter.ci	fr	2018-12-06 07:03:52.222426	2018-12-06 07:11:53.590811	riter.ci
d785f154-2f0a-4055-be46-e44862c54a67	MaliREN	01764a37-a28a-4d11-bf63-df549cf110bd	ML	ccba44f6-4911-4755-8a90-fccf09fd036e	idp_sp	3,0	1	http://www.maliren.ml/	http://www.maliren.ml/	fr	2019-07-31 14:04:29.961175	2019-07-31 14:05:01.008528	maliren.ml
9b0f1760-1df5-4e5e-8118-a6cef51cf832	University of Zambia	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	efd4bccb-67ed-4f11-ba03-4ccedda13bce	idp_sp	3,3	1	https://www.unza.zm/	https://www.unza.zm/	en	2018-11-20 12:55:33.910424	2018-12-14 07:29:30.797972	unza.zm
408c3c2c-19cf-472e-82e4-9650641ede23	Mulungushi University	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	de0b6a03-8c91-4263-ad86-d57c85a54a08	idp_sp	3,3	1	http://www.mu.ac.zm/	http://www.mu.ac.zm/	en	2018-12-14 07:41:22.520314	2018-12-14 07:41:22.520314	muc.ac.zm
f897a4d3-44ca-4543-82aa-b4e502c6463e	University of Jos	49429470-2505-49f1-8d22-052b51a6fe08	NG	a7a195ba-926d-4278-a648-164bb4675bfa	idp_sp	3,3	0	https://www.unijos.edu.ng/	https://www.unijos.edu.ng/	en	2019-04-01 13:32:57.732752	2021-04-06 08:29:48.55544	unijos.edu.ng
6461d70e-ebf3-4502-8125-6a4623ec2a9a	University of Malawi	2da7d3a9-81e9-4ae7-986c-142c690c41f1	MW	d202aecc-fbba-4a7e-8446-62f30f1e106b	idp_sp	3,3	1	https://www.unima.ac.mw/	https://www.unima.ac.mw/	en	2018-03-13 22:45:27.998322	2021-06-21 14:25:59.040475	unima.ac.mw
4f5825fb-a110-42d5-914b-3d94afd58caa	National Universities Commission	49429470-2505-49f1-8d22-052b51a6fe08	NG	87da66f2-ddcd-4cb6-ac8a-b23e947b5050	idp_sp	3,0	0	http://nuc.edu.ng	http://nuc.edu.ng	en	2018-10-30 10:13:30.710656	2019-02-26 15:55:57.073515	nuc.edu.ng
911a5df1-70bb-43a6-99c3-9138271109ed	UbuntuNet Alliance	2da7d3a9-81e9-4ae7-986c-142c690c41f1	MW	e0701bf4-ad37-4a8d-a26b-9ad61413793c	idp_sp	3,0	1	https://eduroam.ubuntunet.net	http://switchboard.ubuntunet.net	en	2018-01-10 15:30:52.300278	2021-04-06 07:49:02.906616	ubuntunet.net
96f247af-06f8-4c6a-b325-71f89fd65bd5	Covenant University	49429470-2505-49f1-8d22-052b51a6fe08	NG	3447a39e-9836-42a8-8191-14112a73d09c	idp_sp	3,3	0	https://covenantuniversity.edu.ng	https://covenantuniversity.edu.ng	en	2019-03-15 11:49:04.410807	2019-03-15 11:52:10.755736	covenantuniversity.edu.ng
6f4462ad-1f14-4e25-be5e-88cf2e42cec1	Nnamdi Azikiwe University	49429470-2505-49f1-8d22-052b51a6fe08	NG	b9e2664a-bbc0-42ca-87d3-01b4a0927f35	idp_sp	3,3	1	https://unizik.edu.ng	https://unizik.edu.ng	en	2019-04-02 11:45:03.060705	2019-04-04 13:14:04.969898	unizik.edu.ng
d732f8b8-d167-4dac-b175-724f7188be6a	Usmanu Danfodiyo University 	49429470-2505-49f1-8d22-052b51a6fe08	NG	a8e16769-c2b9-499e-88cd-7784bcccd451	idp_sp	3,3	0	https://udusok.edu.ng	https://udusok.edu.ng	en	2019-04-04 15:49:54.819213	2019-04-04 15:49:54.819213	udusok.edu.ng
9b15ed64-9965-4b8d-8857-98844f2a5e14	University of Lagos	49429470-2505-49f1-8d22-052b51a6fe08	NG	e100f9ef-9639-4924-ae9b-9512d649f1f0	idp_sp	3,3	1	https://unilag.edu.ng	https://unilag.edu.ng	en	2019-04-18 11:13:23.646384	2019-04-18 11:13:23.646384	unilag.edu.ng
991db693-847f-4626-ab05-c4bafd190f92	COSTECH	ef4b85a4-444f-4edd-b31d-b7eb6c28ef6c	TZ	d42714f6-b9b9-467e-afd4-00cecd3f2597	idp	5,0	1	http://www.costech.or.tz	http://www.costech.or.tz	en	2019-05-03 10:39:44.936368	2019-05-03 10:39:44.936368	costech.or.tz
679f67b6-cf16-4c36-a887-77c06fb2d05b	Chambe Academy for Science and Technology	c3cc6a00-7930-4709-b54f-ba7d800e1b2c	ME	4eb56079-857c-4e62-927f-e1961c20b893	idp_sp	3,2	0	https://cast.edu.me/info	https://cast.edu.me/policy.pdf	en	2019-05-15 14:56:47.15971	2019-05-15 14:56:47.15971	cast.edu.me
7ccfcd5c-da2a-44d2-acff-f7a51ec5b199	NgREN	49429470-2505-49f1-8d22-052b51a6fe08	NG	6780344a-5867-4da3-85ae-a16a87502808	idp	3,0	0	http://ngren.edu.ng/	http://ngren.edu.ng/	en	2018-08-27 09:04:44.512956	2019-06-14 07:24:41.033546	ngren.edu.ng
5b033895-13ed-43b3-a21a-62fdb56e38d4	GARNET	c992c12c-7ef5-4914-9138-69c9fb6b74dc	GH	ea1eb479-17e6-4480-aa14-0a1ad8f71a1a	idp_sp	3,3	1	http://garnet.edu.gh	http://garnet.edu.gh/policy	en	2019-08-04 19:53:25.334646	2019-08-06 15:50:19.629805	garnet.edu.gh
1e4bdaed-2062-439e-8ef3-593bdb2c4701	Ashesi University	c992c12c-7ef5-4914-9138-69c9fb6b74dc	GH	2fff6356-0f1c-453d-aa81-57ed0b93199d	idp_sp	3,3	1	https://ashesi.edu.gh	https://ashesi.edu.gh/eduroampolicy	en	2019-08-07 15:27:39.02266	2019-08-07 15:27:39.059468	ashesi.edu.gh
720b4990-7e36-4d61-83b5-09d2d0c46889	University of Ghana	c992c12c-7ef5-4914-9138-69c9fb6b74dc	GH	c3a485c8-d767-4c6a-b0c8-7c494a57cd0e	idp_sp	3,3	1	https://www.ug.edu.gh	https://www.ug.edu.gh/eduroampolicy	en	2019-08-04 21:01:25.82681	2019-08-05 06:10:40.47814	ug.edu.gh
fad269fb-c5f3-4ab2-b7ce-2d5158df531a	MGIX	a33c9698-a460-40f9-849f-947ecb8fa561	MG	22d9aa91-8d00-4350-bdca-0b6e62111473	idp	5,0	0	http://www.mgix.mg	http://www.mgix.mg	fr	2019-01-03 05:37:21.527967	2021-04-16 05:16:57.352962	mgix.mg
1e45e65b-9167-4cc9-bbb7-1f11d63e70d8	Technical and Vocational Teachers College 	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	8150e2ae-d615-4ea8-ba4a-a9a90596d574	idp_sp	3,3	1	http://tvtc.ac.zm	http://tvtc.ac.zm	en	2019-09-23 10:30:58.618185	2019-09-23 10:30:58.678501	tvtc.ac.zm
2bf8127f-b5fa-4f92-a65c-fce09f50114c	Malawi Liverpool Wellcome Trust	2da7d3a9-81e9-4ae7-986c-142c690c41f1	MW	7fb7148f-65fd-47a7-9671-fba230c79594	idp_sp	3,0	0	http://www.mlw.medcol.mw/	http://www.mlw.medcol.mw/	en	2018-03-27 10:03:33.468044	2019-10-01 09:29:08.762132	mlw.ubuntunet.net
cd8a9e52-58b9-4fcc-93ca-e53a81d50383	TERNET	ef4b85a4-444f-4edd-b31d-b7eb6c28ef6c	TZ	0d51f121-e23d-4372-8c6c-7527ae86e66c	idp_sp	3,0	1	https://eduroam.ternet.or.tz	https://www.ternet.or.tz/	en	2018-05-17 15:03:32.498353	2020-11-02 15:29:34.734916	ternet.or.tz
549299ce-02f6-4aed-bc57-b8e5131ff7f3	ICERMALI	01764a37-a28a-4d11-bf63-df549cf110bd	ML	8baa09f0-34bd-4279-ae85-1150d5575ee9	idp_sp	3,3	0	https://www.icermali.org	https://www.icermali.org	fr	2019-10-04 14:21:02.274679	2019-10-04 14:21:02.312625	icermali.org
35d18cea-9f0b-42b3-989d-f9ea84b94ef6	testIDP	01764a37-a28a-4d11-bf63-df549cf110bd	ML	c70e99da-bbda-4c39-887a-0451d20ad184	idp	3,3	1	https://www.icermali1.org	https://www.icermali1.org	fr	2019-10-16 11:12:50.332691	2019-10-16 11:12:50.380709	icermali1.org
c6235a8c-9c92-43e5-b246-8e46132f22f6	WACREN	c992c12c-7ef5-4914-9138-69c9fb6b74dc	GH	6a082540-d531-4af6-867b-35609ef07b6c	idp_sp	3,0	0	http://eduroam.wacren.net	http://eduroam.wacren.net/policy	en	2019-03-27 10:37:47.799309	2019-10-18 05:04:53.686015	wacren.net
64f81d4e-7d1a-4a40-b5b8-b1ddd99e5ecc	UAC	029b333b-8a8d-4bd1-8c14-284e99e9bbb5	BJ	2bed825e-898b-4a4a-9d8f-b5748eac65c7	idp	3,3	0	https://www.uac.bj	https://www.uac.bj	fr	2019-10-01 10:48:52.719628	2019-11-19 13:26:40.446695	uac.bj
faddfab4-02d0-45b3-9ac1-351eacfd4efa	Chalimbana University	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	328660e6-eace-4856-9fda-eee8ff0d9cc5	idp_sp	3,3	1	https://www.zamren.zm	https://www.zamren.zm	en	2019-10-30 13:12:35.929841	2019-10-30 13:12:35.957806	chau.ac.zm
aee1e708-5a8f-4465-a558-97c61110d4bb	snRER	a3cc227d-a973-46cb-9ca5-091252342453	SN	71546894-f23c-48a6-9b2d-3563a892c3ec	idp_sp	3,0	0	https://snrer.edu.sn	https://snrer.edu.sn	fr	2019-10-30 16:04:29.139934	2019-11-18 22:35:36.319755	snrer.edu.sn
d6ec3437-802b-418e-8c40-08fc96e9bcc9	RBER	029b333b-8a8d-4bd1-8c14-284e99e9bbb5	BJ	d822737a-d003-457c-ba65-a208f30a1b0c	idp	3,3	0	https://rber.net	https://rber.net	fr	2019-11-19 11:15:53.793971	2019-11-19 11:15:53.846504	rber.net
53cd2ce3-bd7b-420c-8802-a4731571da47	Ifakara Health Institute	ef4b85a4-444f-4edd-b31d-b7eb6c28ef6c	TZ	3d071ea0-de74-4cb9-bb40-162d2f4a6f86	idp_sp	3,3	1	https://ihi.or.tz	https://ihi.or.tz	en	2020-02-27 14:38:46.024618	2020-02-27 14:38:46.042537	ihi.or.ta
bf33d3ba-99ba-4c1b-9c33-3310a65f09db	Mansa College of Nursing and Midwifery	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	58badd00-f673-4e29-a3e0-c9c4ca09c7c8	idp_sp	3,3	1	https://eduroam.zm	https://eduroam.zm	en	2020-12-15 07:43:38.18538	2020-12-15 07:43:38.191982	mansacnm.edu.zm
cb11e742-b109-4f19-8a0f-f14481602895	Dovecot College of Nursing & Health Sciences	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	24c63deb-bed8-4386-9c1e-c77379fdfd6a	idp_sp	3,3	1	https://eduroam.zm	https://eduroam.zm	en	2020-12-15 07:12:54.92296	2021-03-25 10:47:57.353263	dsn.edu.zm
bdbce8c6-b4e0-4504-ad5f-d2c5440a7213	ZIMREN	49d70765-375a-42bf-b267-74eb0f21b617	ZW	f833c539-6a58-4d4c-a48a-e9ad5f50e35f	idp_sp	3,3	1	https://zimren.ac.zw	https://zimren.ac.zw	en	2020-06-01 13:06:05.980627	2020-06-01 13:06:06.007175	zimren.ac.zw
c7b1c506-aaf5-4e61-b7cb-4d4feb85a5bd	Rusangu University	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	857e20d7-0b0d-4eaa-831a-bcfb20de8685	idp_sp	3,3	1	http://ru.edu.zm/	http://ru.edu.zm/	en	2020-09-17 15:32:58.543135	2020-09-17 15:32:58.567	ru.edu.zm
d12bcb08-d0c5-4a5f-aedb-e1042a3e866e	National Institute of Public Administration	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	f592352f-0529-4e13-b860-2cd8495949e6	idp_sp	3,3	1	https://www.nipa.ac.zm	https://www.nipa.ac.zm	en	2020-10-02 07:40:15.456976	2020-10-02 07:40:15.462098	nipa.ac.zm
82797b17-9b81-45ca-b904-24671e521f97	Solwezi College of Education	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	e6ffe478-0a4b-48f9-b13c-addcf4636cee	idp_sp	3,3	1	https://eduroam.zm	https://eduroam.zm	en	2020-11-30 13:14:40.046895	2020-11-30 13:14:40.055119	soce.edu.zm
5392bfa3-cf25-4e13-8528-d42baa9b7e7c	Ndola Schools of Biomedical Sciences	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	4530d4f6-f19c-4b23-8fcd-d79f5df5ed11	idp_sp	3,3	1	https://eduroam.zm	https://eduroam.zm	en	2020-12-14 07:33:44.730875	2020-12-14 07:33:44.739038	ncbs.edu.zm
a42b1866-4163-45e2-b093-3edc1e6a71d9	Roan College of Nursing and Midwifery	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	88e41027-436c-4e44-b64e-fc8b5add6dc2	idp_sp	3,3	1	https://eduroam.zm	https://eduroam.zm	en	2020-12-14 15:17:37.1192	2020-12-14 15:17:37.125263	rcnm.edu.zm
05dab0bd-ad04-4820-a02a-15aa3e255b8f	Chilonga College of Nursing and Midwifery	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	141a05df-e372-46d9-b076-cde302f4f762	idp_sp	3,3	1	https://eduroam.zm	https://eduroam.zm	en	2020-12-14 20:35:04.96863	2020-12-14 20:35:04.976367	ccnm.edu.zm
3a6f9417-4853-4522-863e-9c2e43aea6fa	Chipata College of Nursing and Midwifery	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	ed06e101-1a9a-483f-a549-d49d40dcfac6	idp_sp	3,3	1	https://eduroam.zm	https://eduroam.zm	en	2020-12-14 20:45:39.608646	2020-12-14 20:45:39.615191	chipatanursing.sch.zm
48a3cb01-a52f-4f23-bc45-4d0e5a93f77e	Kabwe College of Nursing and Midwifery	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	c239971c-d45b-434d-be98-7afd68737946	idp_sp	3,3	1	https://eduroam.zm	https://eduroam.zm	en	2020-12-14 20:49:45.888176	2020-12-14 20:49:45.89488	kacnm.edu.zm
cc373e93-f7d1-424e-9c21-801c6f1f758e	Lusaka Schools of Nursing and  Midwifery	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	8809463b-3727-4dc1-a526-cdc2577093c8	idp_sp	3,3	1	https://eduroam.zm	https://eduroam.zm	en	2020-12-15 06:52:55.347445	2020-12-15 06:52:55.353252	lucn.edu.zm
e656e725-44cd-482a-b465-0340255d8ff6	Micheal Chilufya Sata School of Nursing	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	e76650cc-bc86-4822-8fe1-cc169e5b314e	idp_sp	3,3	1	https://eduroam.zm	https://eduroam.zm	en	2020-12-15 07:00:02.011172	2020-12-15 07:00:02.017286	mcscnm.edu.zm
5f2139d1-75e0-4ac5-a44f-6381ee9f8c57	Lusaka Institute of Applied Sciences\t\t\t	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	115b146a-ed60-4689-aadd-fba854008973	idp_sp	3,3	1	https://eduroam.zm	https://eduroam.zm	en	2020-12-15 08:29:30.312143	2020-12-15 08:29:30.319449	lias.edu.zm
dccddb90-cbe6-46cb-a624-14b4dbf7e066	Senanga College of Nursing and Midwifery\t\t\t\t\t\t\t	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	04322357-03b1-48f0-bca3-2ef9fe4ad196	idp_sp	3,3	1	https://eduroam.zm	https://eduroam.zm	en	2020-12-15 08:02:36.864467	2020-12-15 08:06:04.180291	sencnm.edu.zm
e89d53a5-d527-4ec0-a588-87e98d8b8148	Solwezi College of Nursing and Midwifery	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	ef6b2147-34eb-497b-91c2-a504e79e9e62	idp_sp	3,3	1	https://eduroam.zm	https://eduroam.zm	en	2020-12-15 07:59:16.927869	2020-12-15 08:06:31.194408	socnm.edu.zm
350d84c1-c277-4363-a6dd-d58256b7b37e	Mufurila College of Nursing and Midwifery	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	c35654b8-ba9d-41d3-9057-c5332af834ec	idp_sp	3,3	1	https://eduroam.zm	https://eduroam.zm	en	2020-12-15 07:53:07.415286	2020-12-15 08:06:47.541302	ronaldros.edu.zm
ab836e55-9912-4a2a-a1ab-85df51382ef3	Kaoma College of Nursing and Midwifery\t\t	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	39b1c969-b60d-4411-9390-88c314b7fe2e	idp_sp	3,3	1	https://eduroam.zm	https://eduroam.zm	en	2020-12-15 08:18:48.467718	2020-12-15 08:41:40.805554	kacon.edu.zm
1b7f3dec-e631-4cf3-bdd4-a68074eeefd1	Chipata College of Education \t	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	28fcba5e-e28b-466e-8e94-39c470975db9	idp_sp	3,3	1	https://eduroam.zm	https://eduroam.zm	en	2020-12-15 09:27:05.719919	2020-12-15 09:27:05.726926	cce.edu.zm
b3a6cfc1-b91c-485c-a005-4219b90eb83f	Kasama College of Nursing and Midwifery \t	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	4e8382c0-4cee-4042-b656-cd340aea5a44	idp_sp	3,3	1	https://eduroam.zm	https://eduroam.zm	en	2020-12-15 08:15:31.094886	2020-12-15 08:19:44.807533	ksn.edu.zm
00b18d3a-29c2-4e6a-bee3-453587844688	Lewanika Schools of Nursing and Midwifery\t	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	6b2758ab-cba2-4c00-baa6-15e5d17a0e70	idp_sp	3,3	1	https://eduroam.zm	https://eduroam.zm	en	2020-12-15 08:38:12.251214	2020-12-15 08:49:33.5996	lcnm.edu.zm
b6f60b7d-230f-47e1-9580-11e6d899b539	Kasama College of Education\t\t\t	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	d63eedb1-9c3b-4eac-87f0-4312b38f0cfc	idp_sp	3,3	1	https://eduroam.zm	https://eduroam.zm	en	2020-12-15 09:02:58.745679	2020-12-15 09:02:58.754216	kace.edu.zm
cab21e0d-202d-401f-951b-eddad5f148f1	Kitwe College of Education\t	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	b7c6f6bd-4843-49dd-9641-295f2cbe5874	idp_sp	3,3	1	https://eduroam.zm	https://eduroam.zm	en	2020-12-15 09:07:58.959076	2020-12-15 09:07:58.963724	kce.edu.zm
8dfc790e-ad17-467a-bc25-af17f7004c64	Mufulira College of Education\t	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	6e88ae9b-5307-42d8-936d-cf8a284e8345	idp_sp	3,3	1	https://eduroam.zm	https://eduroam.zm	en	2020-12-15 09:22:21.687367	2020-12-15 09:22:21.692303	muce.edu.zm
c709dc8e-aecc-4ce0-a1c2-bfe815ff122e	Mongu College of Education	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	8ea3e8e6-d24d-4c5e-a84f-f7704d68d924	idp_sp	3,3	1	https://eduroam.zm	https://eduroam.zm	en	2020-12-15 09:43:34.857507	2020-12-15 09:43:34.864373	mocce.ac.zm
bf83777c-f620-42de-aa60-8cb4faf67171	St. Mary’s College of Education	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	9108c905-c1e1-4e68-a06b-035386273899	idp_sp	3,3	1	https://eduroam.zm	https://eduroam.zm	en	2020-12-15 09:54:48.078508	2020-12-15 09:54:48.083419	smace.edu.zm
293982c4-1b82-4ff0-8cb8-a682a4528582	Monze College of Agriculture\t	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	9453f451-0656-47f7-8799-29429c8aa537	idp_sp	3,3	1	https://eduroam.zm	https://eduroam.zm	en	2020-12-15 10:00:56.550229	2020-12-15 10:00:56.555386	zcamonze.edu.zm
a837afed-9908-4e0c-ade8-56a54d62ea9d	Monze Community Development College	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	72cb1971-3718-4d74-b746-d5a5b377c133	idp_sp	3,3	1	https://eduroam.zm	https://eduroam.zm	en	2020-12-15 10:06:58.128117	2020-12-15 10:06:58.133842	comdevcollege.edu.zm
1c72adb6-7fd0-4ac9-86f2-f74a9ad7c895	Malcom Moffat College of Education	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	f0d4ff3d-50da-4b92-9158-27a7507ce809	idp_sp	3,3	1	https://eduroam.zm	https://eduroam.zm	en	2020-12-15 10:13:53.529709	2020-12-15 10:13:53.535168	mamoce.edu.zm
a98028c2-feb2-4129-afb9-3d75cffae1ee	Mansa College of Education	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	eae1577d-3ecb-4afd-8d03-20e5cefe62bc	idp_sp	3,3	1	https://eduroam.zm	https://eduroam.zm	en	2020-12-15 10:19:22.053603	2020-12-15 10:19:22.059155	mace.edu.zm
d70d67d3-5a37-4043-a5c3-0d795c143655	Zambia College Agriculture Mpika	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	caca7e6d-6898-459a-b989-45b1a14ce150	idp_sp	3,3	1	https://eduroam.zm	https://eduroam.zm	en	2020-12-15 10:24:28.567126	2020-12-15 10:26:54.315836	zcampika.edu.zm
f4b8dd42-f206-46ca-bb2b-e9a7d1f909a1	Monze College of Nursing and Midwifery	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	fb08c532-65a9-40a2-9ce7-8833b3fa26f6	idp_sp	3,3	1	https://eduroam.zm	https://eduroam.zm	en	2020-12-15 10:43:37.104096	2020-12-15 10:43:37.109832	monzecnm.edu.zm
11612124-c37e-4fca-9a4d-6a4d667c12a4	Kasiya College 	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	cd2cb4fb-b0d7-4a7c-916e-213933de89af	idp_sp	3,3	1	https://eduroam.zm	https://eduroam.zm	en	2020-12-15 11:07:00.125637	2020-12-15 11:07:00.132217	kasiya.edu.zm
1b548d86-53e2-485e-a124-280a75ca8dcf	Popota Ariculture College 	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	398d1834-e69e-4a5c-ba6a-537392811777	idp_sp	3,3	1	https://eduroam.zm	https://eduroam.zm	en	2020-12-15 13:13:50.21162	2020-12-15 13:14:46.168808	paco.edu.zm
4209f2c1-3849-46ae-87d9-004a22ce1a04	Nchanga College of Nursing and Midwifery	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	44ff54d4-dc76-48b5-88b3-1784c1018a11	idp_sp	3,3	1	https://eduroam.zm	https://eduroam.zm	en	2020-12-17 16:00:43.591683	2020-12-17 16:00:43.600763	nchangacnm.edu.zm
76c1e832-d232-4cd1-b2c6-4d455c48296b	Natural Resources Development College	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	ab238bb8-2731-4de7-9268-7ac7687d5dfd	idp_sp	3,3	1	https://nrdc.ac.zm	http://nrdc.ac.zm	en	2021-02-04 09:16:00.028116	2021-02-04 09:16:00.049737	nrdc.ac.zm
e974240c-1ece-4094-8a28-4a220ec0a9e5	Kitwe College of Nursing and Midwifery	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	3e8c2a58-21a2-4733-8ddc-0d95e7b2378b	idp_sp	3,3	1	https://eduroam.zm	https://eduroam.zm	en	2021-02-04 09:55:25.37062	2021-02-04 09:55:25.377942	ksnm.edu.zm
12019ea3-124c-48b9-9772-c1c48af39cc9	Defence School of Health Sciences	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	d7845e71-56ee-4966-a47b-585c64936773	idp_sp	3,3	1	https://dshs.edu.zm	https://dshs.edu.zm	en	2021-02-09 09:28:42.725874	2021-02-09 09:28:42.732189	dshs.edu.zm
1c04c719-fda2-49bb-a2e4-82c952394d50	Somali Research and Education Network	73fc50f7-0e1d-48fa-b648-040e6d5dd116	SO	4101a1ce-a867-4a1b-86c7-9bad4f321acf	idp_sp	3,3	1	https://somaliren.org	https://somaliren.org	en	2021-04-07 12:58:15.521901	2021-06-14 13:05:00.37716	somaliren.org
c379f63a-ef47-491a-98ba-6cb76daa20b0	Malawi University of Business and Applied Sciences	2da7d3a9-81e9-4ae7-986c-142c690c41f1	MW	87500404-1734-4364-b31d-49b19cd7057f	idp_sp	3,3	1	https://www.mubas.ac.mw	https://www.mubas.ac.mw	en	2021-06-11 10:08:05.493335	2021-06-20 18:18:41.627015	mubas.ac.mw
1ce47b62-7c29-431f-889f-3e2949843b72	Zambia Institute of Chartered Accountants	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	dbc25011-e4c2-4067-b6ad-1190195942ec	idp_sp	0,0	1	https://eduroam.zm	https://eduroam.zm	en	2021-04-06 14:46:20.310097	2021-04-06 14:46:20.315822	zica.co.zm
86b3926e-5f58-4f34-a48c-e4cd7204bee9	Malawi Research and Education Network	2da7d3a9-81e9-4ae7-986c-142c690c41f1	MW	0c2d495e-7652-4fbe-8887-cd5b2e7174d9	idp_sp	3,3	1	https://maren.ac.mw	https://maren.ac.mw	en	2021-06-11 09:27:29.945383	2021-06-24 08:11:28.612256	maren.ac.mw
4266f4f5-9131-48d9-9ba4-042b7ed34f8f	Lusaka Business and Technical College	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	a72fa989-cd2f-4e3e-99b4-94b7afe4206f	idp_sp	3,3	1	https://eduroam.zm	https://eduroam.zm	en	2021-04-08 12:34:57.563202	2021-04-08 12:34:57.589998	lbtc.ac.zm
28694d8e-e7d7-417a-b5b0-cf4815c92234	Cancer Disease Hospital	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	5f6bd189-09f3-47c1-8f6d-81ba8e9f125b	idp_sp	3,3	1	http://cdh.org.zm	http://cdh.org.zm	en	2021-08-26 14:04:05.280704	2021-08-26 14:04:05.55384	cdh.org.zm
f5e8d182-0759-45a2-a54e-8a50a43fbab6	TOGORER	02b4e345-b851-4428-9531-badf883610aa	TG	e17148bc-3d91-41be-8563-2c1685fc1096	idp_sp	3,0	1	https://eduroam.togorer.tg	https://eduroam.togorer.tg/policy	fr	2021-04-23 12:56:25.88424	2021-09-15 16:44:12.341547	togorer.tg
da5423fb-a58d-482f-b81d-a1bb8c3d0413	University of Lusaka	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	37b8e045-8ea2-4e98-9898-3260ea70dc01	idp_sp	3,3	1	https://www.unilus.ac.zm/	https://www.unilus.ac.zm/	en	2021-05-03 08:45:08.461516	2021-05-03 08:55:53.917245	unilus.ac.zm
f2ec386f-3a4f-4579-b56d-a1e6da1b43aa	Zambia College of Open Learning	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	4a384ffd-a941-4ed0-b801-5ad4184d2bc2	idp_sp	3,3	1	https://eduroam.zm	https://eduroam.zm	en	2021-05-24 13:13:04.617284	2021-05-24 13:13:04.791059	zamcol.edu.zm
0bbc71ed-a2e0-4e10-983e-a7fb0ffec5b5	Mukuba University	41d5c67a-f92a-4549-b245-d65abdb5cf90	ZM	78092d5e-5fa7-49aa-99ff-1ff03e78be29	idp_sp	3,3	1	https://mukuba.edu.zm/	https://mukuba.edu.zm/	en	2021-12-13 09:39:47.347327	2021-12-13 09:39:47.353039	mukuba.edu.zm
\.


--
-- Data for Name: radius_servers; Type: TABLE DATA; Schema: public; Owner: switchboarder
--

COPY public.radius_servers (id, radiusable_type, radiusable_id, name, server_type, product, ip4, ip6, mac, protocol, upstream_secret, monitor_secret, switchboard_secret, require_message_authenticator, auth, acct, auth_port, acct_port, created_at, updated_at) FROM stdin;
cc0fec53-bfbb-470a-909b-abeeb557c030	\N	\N	etlr.dk	tlr	radiator	130.225.242.109	\N	\N	udp	Rywz8wiMQaS1p4bi	FFjgCzRmO9SHQ7J6	fOye4yY7veP6ri+c	t	t	t	1812	1813	2018-08-29 13:43:15.642497	2018-08-29 13:43:15.642497
70126a30-b759-44ac-b0ad-3d5105d362ff	Confederation	621b2e43-dc2e-4f26-99b4-e126bb4caff6	monitoring	monitor	other	161.53.2.204	\N	\N	udp	VR/+uygPcgUcNpQl	e/d7kf3qdn4Bqayd	/nDL6k/FdS4NXxs4	t	t	f	1812	1813	2018-06-15 15:10:56.35418	2018-06-15 15:10:56.35418
30ee653c-eda0-488c-8d41-0d2d73479479	Federation	41d5c67a-f92a-4549-b245-d65abdb5cf90	flr1.eduraom.zm	fp	radsecproxy	41.63.0.19	\N	\N	udp	t/kucIe6YVHKbtN0	tTeoP40WM+IM0iVa	T6gGzk6aHHjPG9jT	t	t	t	1812	1813	2018-10-25 09:27:07.029222	2020-09-23 16:13:13.870311
d58abe61-90c1-4f01-9967-bab3f64d74e1	Organisation	c6a1da0a-512f-477d-ad3b-4ed3f2cba737	auth1.mg.auf.org	idp	fr3	41.242.100.212	\N	\N	udp	CNwp7i1d6W7Q6LXI	VzhZFGoNdFwXHO6G	CKvfSqmAhE1Bw7+E	t	t	t	1812	1813	2018-11-28 07:52:52.999966	2018-11-28 07:52:52.999966
87d85bf8-8c26-4902-816c-d6f4c2fa2e99	Confederation	621b2e43-dc2e-4f26-99b4-e126bb4caff6	switchboard	switchboard	other	196.223.215.165	\N	\N	udp	MEcO3johNuhMfOQf	l/6pkbyYwl/AQc6Y	2l3TWsWpnzo7TDDq	t	t	f	1812	1813	2018-06-15 15:10:56.383139	2018-06-15 15:10:56.383139
c5b76174-9d8f-4dc8-a418-1f01d5bc96d3	Organisation	0a67d914-b70f-4970-ad77-6b8caf423852	et-fp2	fp	fr3	213.55.77.157	\N	\N	udp	6S2N1kOowkulSe11	AY/0U5aAhz+CPlEh	hhrWoizsKv/V/2si	t	t	t	1812	1813	2018-08-28 14:59:11.617782	2018-08-28 14:59:11.617782
fe2f4ea3-e1da-48bb-88d7-c6b35397a899	\N	\N	etlr.nl	tlr	radiator	192.87.106.34	\N	\N	udp	SX+wIHOMCPXzTNso	WxLeuqETRY0fGee9	rFrPjF685WYPy4TT	t	t	t	1812	1813	2018-08-29 13:43:15.573099	2018-08-29 13:43:15.573099
867d59e1-8eeb-4122-9b66-fa3bbbf677ae	Organisation	9b0f1760-1df5-4e5e-8118-a6cef51cf832	unza	idp_sp	fr2	41.63.24.226	\N	\N	both	WCKhYBvBlyF5AtyO	AWN31umaAHOthyrw	aGDeUa/fiOE8J+Ax	t	t	t	1812	1813	2018-12-14 07:32:20.692592	2018-12-14 07:33:00.12937
e175c20b-fcd7-46ad-8575-a902a0f3fa42	Organisation	408c3c2c-19cf-472e-82e4-9650641ede23	MU-2	idp_sp	fr2	41.63.16.58	\N	\N	both	KwAjhBarsc/1kW/i	xQCS/GjaVEuW77Xv	IXIv5bmX5dWulFIF	t	t	t	1812	1813	2018-12-14 08:18:11.217808	2018-12-14 08:18:11.217808
4b176af6-dbb5-4584-8864-9867a04a5f89	Organisation	ba395f36-ef32-4db2-8042-0f23c6fccbcb	radius.irenala.edu.mg	idp	fr3	41.242.96.38	\N	\N	udp	GctzcHcDCM/vjWn1	xaCiDnPtbiZMuxk1	16UbsyBdG+o+M45x	t	t	t	1812	1813	2018-07-25 06:32:22.620354	2021-10-22 11:58:26.812902
53292585-fe47-4434-a401-11f21d04cf65	Organisation	7ccfcd5c-da2a-44d2-acff-f7a51ec5b199	NgREN Secretariat 	idp_sp	fr3	154.68.224.50	\N	\N	udp	J3H7/C5DkRBQLUN+	5rpK6pDdzgjA/nhh	n4WsKiqVmW90PCkI	t	t	t	1812	1813	2018-11-13 09:23:57.375642	2018-11-13 09:23:57.375642
439f96a4-4630-4149-bd4d-4c5a6e400b01	Organisation	8d2a33be-7230-4c87-b6a3-499b4e18bf63	UB idP	idp	fr3	154.119.7.34	\N	\N	udp	AAAMk7ec46xCPfio	l/RiolVqCVaOwqPz	C3SHFT10XkQpqtw5	t	t	t	1812	1813	2018-11-22 13:10:59.640065	2018-11-22 13:12:05.867527
7220d004-463d-4268-8c48-c69b5e4bb8e9	Federation	a33c9698-a460-40f9-849f-947ecb8fa561	nrps.irenala.edu.mg	fp	radsecproxy	41.242.96.39	\N	\N	udp	fOfMZrqY4NPuK8Nq	Xwo17nMYbz89sh+Y	69fslBGiAGdd5XWC	t	t	t	1812	1813	2018-11-23 08:14:11.419458	2018-11-23 08:31:36.898407
1654171b-fa26-4677-aa7c-c8b6cb23e489	Organisation	1b86a4eb-944e-49c3-b183-0c631b1d27bc	zamren	idp_sp	fr2	41.63.32.25	\N	\N	both	Muching@2012	e5Xp7yZQwGaCk3ji	Muching@2012	t	t	t	1812	1813	2018-09-05 12:05:09.241327	2018-11-25 20:38:52.253796
a6959910-388b-4d04-8dc0-56249c7a45c4	Confederation	621b2e43-dc2e-4f26-99b4-e126bb4caff6	rp.ua.ip4	rp	fr3	196.32.213.90	\N	52:54:00:92:31:69	udp	4MuWqYSMNlOGSfpcjWX4lroL	dvzxt0CybfZL6/8L	vXCt9pNhiAHKqeVB	t	t	t	1812	1813	2018-06-15 15:10:56.258682	2018-06-15 15:10:56.258682
efd4ef10-1be4-4787-9e6b-5a4dd316bb94	Organisation	c0457fb7-fc36-4bac-8e6d-019c5d716cd6	soltech	idp_sp	fr3	41.63.0.127	\N	\N	both	Yvyqn4lefE5oZ4Fm	YrFzSMCUzgEU74yt	gFE+9I4iLE0+ABhr	t	t	t	1812	1813	2018-12-14 10:03:10.832422	2018-12-14 10:03:10.832422
9a9c5f77-c348-4eaf-8f8d-674c98d4f6e5	Organisation	408c3c2c-19cf-472e-82e4-9650641ede23	MU	idp_sp	fr2	41.63.16.38	\N	\N	both	A4uX96k9wCS82lQr	ySQtbBa6Nf21J2KY	52U61UiDgwBPW00X	t	t	t	1812	1813	2018-12-14 08:17:30.681812	2018-12-14 08:25:03.944719
a163282b-de78-4e4b-8b21-05deae5141b5	Organisation	fad269fb-c5f3-4ab2-b7ce-2d5158df531a	radius.mgix.mg	idp	fr3	196.49.13.109	\N	\N	udp	RR7cgTFiWs4Bmitg	YazFM3sLc6pRISBC	zufm/YMRjJsp65Oc	t	t	t	1812	1813	2019-01-03 05:38:12.844535	2019-01-03 05:38:12.844535
6fd87320-b776-4d4a-bb9c-1df7dad0294b	Federation	17626b73-d195-419c-bb01-103754b95897	flr.riter.ci	idp	fr3	196.216.209.53	2001:43f8:6c0:2:a800:ff:fed3:3ce6	\N	udp	sUzQEfmdaIvqrnL	DSwXezNJQYuH47fs	/5JDdvgdZo5/WXRf	t	t	t	1812	1813	2018-12-06 07:21:15.924246	2019-02-08 12:39:12.969575
ebdd833a-1cd4-4ea6-a52d-306eb82e884c	Organisation	94cf650e-540c-4d89-9f69-8891719fb5b5	Eko-konnect_Secretariat	idp	fr3	196.216.209.48	\N	\N	udp	86641e75920f2caf8012cca5	048c194bd3455dabe25d03c8	058cf62f92b874083fbc1ec4	t	t	t	1812	1813	2019-03-14 09:58:53.542435	2019-03-14 09:58:53.542435
7796ada1-966a-4668-9149-504a755e571b	Federation	41d5c67a-f92a-4549-b245-d65abdb5cf90	flr2.eduroam.zm	fp	radsecproxy	41.63.0.20	\N	\N	udp	e4kHlNkJH4YLlZck	DZqbCDS6//Rzg6oD	O2pHfqVUWx8d9uud	t	t	t	1812	1813	2018-10-25 09:40:23.015469	2020-09-23 16:14:19.254076
10f91efe-3824-4c3a-be99-3ae8cca7c26b	Organisation	4f5825fb-a110-42d5-914b-3d94afd58caa	idp.nuc.edu.ng	idp_sp	fr3	154.68.224.66	\N	\N	udp	eAUGqRJV5EK5Byyp	8a02f6ac77b37dd4bce4ddd4	79467dca954b8ad649007adc	t	t	t	1812	1813	2019-03-14 13:41:57.051915	2019-03-14 13:42:12.601471
b8ada1d6-9bb0-48cc-9eaa-e74e0304dc32	Organisation	cd8a9e52-58b9-4fcc-93ca-e53a81d50383	ternet-office	idp	fr3	41.93.33.77	\N	\N	udp	fd7870082b1de374a8e8f211	eaec98d1aea43b9109a59dbf	0bfa755c555dfd5dd43ae468	t	t	t	1812	1813	2019-03-15 09:22:29.757592	2019-03-15 14:07:45.891815
53deb8c7-c500-4d4f-b2e1-d0b30d2f5d1a	Organisation	cd8a9e52-58b9-4fcc-93ca-e53a81d50383	ternet-eduid	idp	fr3	196.223.215.185	\N	\N	udp	1d91c2eadaaf5b0a47bf7677	d2824448c833376e9bcaffa2	d2900a3f76d537a71b2e8828	t	t	t	1812	1813	2019-03-15 15:23:58.140581	2019-03-15 15:23:58.140581
38265b2d-4e00-4329-ad8b-0f854af37f8b	Organisation	b7a4f25d-aa72-4812-a1dd-a563d26ba979	RITER-IdP	idp	fr3	196.216.209.65	\N	\N	udp	f273d3472134e08b7f365260	703dd92785b320eb0521b23c	534fbd653cff2b63c684067f	t	t	t	1812	1813	2019-03-27 11:00:07.130605	2019-03-27 11:00:07.130605
27eff5d0-010e-4319-b194-d2b5a9199518	Organisation	f897a4d3-44ca-4543-82aa-b4e502c6463e	University of Jos	idp	fr3	196.216.209.66	\N	\N	udp	d9278d9c443021048be181ac	05e87979199b48133cc3585a	c80ddcbb8ccfeb6ac0e0223a	t	t	t	1812	1813	2019-04-01 13:35:35.181668	2019-04-01 13:35:35.181668
1ef40719-4d45-46a7-b237-0bb9e5725330	Organisation	6f4462ad-1f14-4e25-be5e-88cf2e42cec1	UNIZIK-WACREN Donated Server	idp_sp	fr3	196.216.209.70	\N	\N	udp	6a043f2c083d286f3d9caae7	fda7c24edb6f1a87f906840d	58fb3c773e6460bb5de4e3df	t	t	t	1812	1813	2019-04-02 11:50:52.286429	2019-04-03 22:49:30.228962
2f59baa5-57e5-49de-9ead-21077857e738	Federation	49429470-2505-49f1-8d22-052b51a6fe08	flr2.ngren.edu.ng	fp	fr3	154.68.224.64	\N	\N	udp	o6VQ1NKcN4Bg6s8L	Dd2HjK5aLz7TT	vHUmSwLFwkjZCPXf	t	t	t	1812	1813	2018-08-27 13:01:33.436983	2019-08-06 19:59:54.594507
4d72f117-b397-4dfe-a3f2-e5501c4ee17b	Federation	ef4b85a4-444f-4edd-b31d-b7eb6c28ef6c	tz-fp_tenet	fp	fr3	41.93.32.98	\N	\N	udp	FMeqkENwGJCMwBnk	PFBhumWMJdOyYvSU	MMqQrhhRLt0sV4H+	t	t	t	1812	1813	2018-07-24 09:36:12.531363	2021-10-22 06:39:20.175932
b6806796-7653-40d7-bf1a-acf2c58b4a7d	Organisation	96f247af-06f8-4c6a-b325-71f89fd65bd5	Covenant University IdP	idp	fr3	196.216.209.88	\N	\N	udp	29c5812dba4d90f3beaabcfb	d27c38789f7d45a2ff5b8484	244e8beb4947e6eb34da0337	t	t	t	1812	1813	2019-03-15 11:50:42.163168	2019-04-03 14:55:54.767559
41f6d203-74c6-42de-bde1-cd8b5ac3239d	Organisation	d732f8b8-d167-4dac-b175-724f7188be6a	Usmanu Danfodiyo University	idp	fr3	41.78.224.59	\N	\N	udp	828a2b95b0031c689c5c93b7	a4b613a4b86fb9a5222f8e91	b142c6a96ede5a8047ce1228	t	t	t	1812	1813	2019-04-04 15:54:00.74705	2019-04-04 15:54:00.74705
81e2666c-4e22-4ed8-8ac4-ee07ad52e0dd	Organisation	9b15ed64-9965-4b8d-8857-98844f2a5e14	Unilag IdP server	idp_sp	fr3	196.220.241.216	\N	\N	udp	a6dce49f63808740695cd56f	70ad0b35c503948269e27364	d6e0ad49e96adfad90ef26e1	t	t	t	1812	1813	2019-04-20 21:53:27.780763	2019-04-20 21:53:27.780763
45c32e4d-4992-4117-bc2a-d3a9ced86037	Organisation	991db693-847f-4626-ab05-c4bafd190f92	costech-idp	idp	fr3	41.93.32.106	\N	\N	udp	cb563d50211a98cba529b876	8cfdca0312f0d82ec63d31c4	7020591c60a48b68b595a52b	t	t	t	1812	1813	2019-05-03 10:40:25.013039	2019-05-03 10:40:25.013039
0873846b-e787-411a-ad3e-3e4dd8f40d7e	Organisation	cd8a9e52-58b9-4fcc-93ca-e53a81d50383	costech-idp	idp	fr3	41.93.32.68	\N	\N	udp	45fed81381fb4ab718486540	8f9b5ac4c300b994309a4a22	973cf61431cfdc6e67833319	t	t	t	1812	1813	2019-05-03 09:53:09.332339	2019-06-12 15:05:45.350735
f224e031-623a-4a28-8259-eedbcd69a4ab	Federation	c992c12c-7ef5-4914-9138-69c9fb6b74dc	ghflr.garnet.edu.gh	fp	radsecproxy	197.255.124.73	\N	\N	udp	8tRz0!wVG%Km	100141cd7710ce38d454a091	6b3b6fd6cb64b7adbe17cbfd	t	t	t	1812	1813	2019-08-06 06:24:18.306722	2019-11-18 10:22:46.290085
d226fc01-2225-44ab-a1dd-c3eaad7b5b28	Organisation	720b4990-7e36-4d61-83b5-09d2d0c46889	ugradius.ug.edu.gh	idp_sp	fr3	197.255.124.13	\N	\N	udp	f1d14df98c98638f05b2b9d6	9444ed78fc2d31f2d0c847c1	53688d18c1af1e9f87d954f1	t	t	t	1812	1813	2019-08-05 20:00:21.429313	2019-08-05 22:11:44.685438
822b932e-9cb6-4282-aeed-78829295c866	Organisation	983c15ee-9a50-4725-bfc0-9e2067ec14fa	radius.knust.edu.gh	idp	fr3	129.122.31.251	\N	\N	udp	269226897a7d12f11ce56398	60285a0af5fb0ff2412d9baf	55bff0d934bc790760cf5037	t	t	t	1812	1813	2019-08-06 06:43:09.265938	2019-08-06 06:43:09.265938
d9ba1e3b-9797-48df-a67f-c40af3b81dd6	Organisation	1e4bdaed-2062-439e-8ef3-593bdb2c4701	maopopo.ashesi.edu.gh	idp	other	41.79.97.21	\N	\N	udp	8b6cdfd151f968ae41790444	3fd96199e8701e1005a5fa58	5778c1fc9acab0d391090474	t	t	t	1812	1813	2019-08-07 16:33:06.0063	2019-08-08 11:36:59.98338
ce740c3b-55f5-4841-8113-b4d459f4bd48	Organisation	f897a4d3-44ca-4543-82aa-b4e502c6463e	Unijos-IdP	idp_sp	fr3	140.105.46.145	\N	\N	udp	77c588391182bca5f100688b	a2b1f1699b2bcea7196f8613	3f30f868529815b61108e49e	t	t	t	1812	1813	2019-08-09 12:04:37.151336	2019-08-09 12:04:37.151336
d9975d0e-46ce-4b22-a64b-99b5ad01b6b2	Organisation	5b033895-13ed-43b3-a21a-62fdb56e38d4	ghflr.garnet.edu.gh	idp_sp	radsecproxy	197.255.124.73	\N	\N	udp	4p8PrkKG3nvB	100141cd7710ce38d454a091	6b3b6fd6cb64b7adbe17cbfd	t	t	t	1812	1813	2019-08-05 11:26:27.162013	2020-03-18 11:38:29.002838
0453ff38-4bb9-42bd-83f1-46f5e9564098	Organisation	6f4462ad-1f14-4e25-be5e-88cf2e42cec1	eduroam.unizik.edu.ng	idp_sp	fr3	196.220.192.73	\N	\N	udp	267d68de1434eb692da5122c	2d20c0ea695d0c71fd3047e2	9e614e688e848b52bb1792e5	t	t	t	1812	1813	2019-09-16 15:08:12.5953	2019-09-16 15:08:12.5953
9cf44eef-1d5c-49fb-94bb-1a9249ed970c	Organisation	1e45e65b-9167-4cc9-bbb7-1f11d63e70d8	TVTC1	idp_sp	fr2	155.0.32.12	\N	\N	both	c23527e23f31c0db67bab518	f75b6a64ab84bdd1b81373b6	39917e4ef5a03613061b1561	t	t	t	1812	1813	2019-09-23 10:35:37.660377	2019-09-23 10:36:55.767955
9d2d5be1-613d-421b-bed8-522adcc0fb98	Organisation	64f81d4e-7d1a-4a40-b5b8-b1ddd99e5ecc	uacIDP	idp	fr2	196.192.16.10	\N	\N	udp	943061756d13c615b4884711	a8be9b791a85308e0a174a79	1e74ff3e83eed4fb0cb7fc97	t	t	t	1812	1813	2019-10-01 10:51:24.58352	2019-10-01 10:51:24.58352
688c3769-3daa-401f-bafb-e929a194a1f9	Federation	01764a37-a28a-4d11-bf63-df549cf110bd	mlflr.wacren.net	fp	fr3	196.216.209.101	2001:43f8:6c0:2:a800:ff:fe50:4db1	\N	udp	5945787b112685ae82a3d927	917e7a9fcf9db35af137e57d	84817c65e93cc0a2d3d8399f	t	t	t	1812	1813	2019-10-04 10:05:15.227436	2019-10-04 10:05:15.227436
dea3cac2-7983-4675-b7d9-079907af876d	Organisation	549299ce-02f6-4aed-bc57-b8e5131ff7f3	int.icermali.org	idp_sp	fr3	196.200.61.241	\N	\N	udp	560ef27c512d356d3937ee07	6418c14a9df4b6770a17ba0b	a67af3de8c714d8c5bf3f9e3	t	t	t	1812	1813	2019-10-04 16:45:40.900199	2019-10-04 16:45:40.900199
c32e3c7f-dbc7-4d12-9503-2f482319b82b	Organisation	35d18cea-9f0b-42b3-989d-f9ea84b94ef6	int.icermali1.org	idp	fr3	196.216.209.102	2001:43f8:6c0:2:a800:ff:fec3:ae57	\N	udp	7272f0c4c1ac7e13f01dbba2	acebc99cd8bb892c3326fc85	c90189ceb823ce64b8270544	t	t	t	1812	1813	2019-10-16 11:14:05.344601	2019-10-16 11:14:05.344601
b6bee9bd-5342-41cd-b3ee-c3fa2070417e	Organisation	faddfab4-02d0-45b3-9ac1-351eacfd4efa	chau	idp_sp	fr3	41.63.0.136	\N	\N	udp	1dbcf919b12f8e3ddfed159f	97c4baf4d0842ef99eb061a6	c86cd98985e8429e9bf75173	t	t	t	1812	1813	2019-10-30 13:14:29.391188	2019-10-30 13:14:29.391188
845a1e08-c161-4e46-b1ea-17fe1747c8c6	Federation	29e15a85-bb5f-42e8-a32a-4d9ebfabff75	flr-test1	fp	fr3	196.223.219.91	\N	\N	udp	13798f5243e4c57e03438694	71c3d07b1a626bd1507cd1c7	bbe2bb17e6623a18c266121d	t	t	t	1812	1813	2019-11-04 13:12:35.760586	2019-11-04 13:12:35.760586
f604fe02-2d1e-417d-986e-608c233dc7fa	Federation	4d80c8e1-029a-4622-9159-e76dd83e5ea9	BI-FLR2	fp	fr3	154.119.7.65	\N	\N	udp	502d38198200f8125d8a307b	a051236bf342d3ac6d14baed	33f0c53fd62f358490387087	t	t	t	1812	1813	2020-01-23 07:23:47.336703	2020-01-23 07:23:47.336703
4550ff3d-00d9-425e-ad50-84796b78c1de	Organisation	0a67d914-b70f-4970-ad77-6b8caf423852	eduroam_AMU	sp	fr3	10.144.5.35	\N	\N	udp	76a0d51ce8fd2ca401056fd8	687b83669138d1344712ca25	c80d24fe09df7dce10adea37	t	t	t	1812	1813	2020-03-04 07:34:45.147655	2020-03-04 07:34:45.147655
8deea443-e176-45ee-8d50-28a1ec4c7d77	Federation	029b333b-8a8d-4bd1-8c14-284e99e9bbb5	BJFLR	fp	radsecproxy	196.192.16.19	\N	\N	udp	8899be723691dfc2ad42bc3c	5a1d2ddd27dcd34162fc62a2	d74156e8b8d12b228dca48cc	t	t	t	1812	1813	2019-11-19 11:28:05.256907	2020-03-11 10:09:14.899278
da7d2b4d-52b0-41ef-b962-92596e146637	Organisation	0a67d914-b70f-4970-ad77-6b8caf423852	eduroamAMU	sp	fr3	197.156.124.15	\N	\N	udp	864b7efe059f21613d8384a5	2e77006d3dc52956aa605d0f	c01014f79259c22685ac996b	t	t	t	1812	1813	2020-03-12 07:04:19.538584	2020-03-12 07:04:19.538584
1648565d-d94e-4846-a63b-85084b642a07	Organisation	0a67d914-b70f-4970-ad77-6b8caf423852	EthERNet_IDP	idp	fr3	196.189.149.14	\N	\N	udp	a0f7049422f46cf7bbbb81f1	211bb6e699ab99022d85f69a	0a5fe2e00fdc7e2ed8622428	t	t	t	1812	1813	2020-03-17 12:57:44.883046	2020-03-17 12:57:44.883046
576bfe81-cc36-4186-9d0b-472e8d5a16a2	Organisation	0a67d914-b70f-4970-ad77-6b8caf423852	freeRadius	idp	fr3	196.189.45.88	\N	\N	tcp	eduroam@ethernet	683e9cef857539ea624158af	a8fcea2d437c7ae266020359	t	t	t	1812	1813	2020-01-01 07:25:13.76084	2020-12-04 05:13:12.148006
e27419e0-e3d4-4b9f-bbec-6447ed81d7dc	Federation	8e95b53d-6101-4287-ba1c-58c3fe6434f3	ls-flr1	fp	fr3	196.223.217.126	\N	\N	udp	c5951cfe0ef473f743ea563a	91c3ad9f74cf1c5bcea906b6	041afbf2db3ffc24477bc0b6	t	t	t	1812	1813	2020-03-24 07:59:08.94055	2020-03-24 07:59:08.94055
aa667809-6a76-4783-ba63-c9e03f43f782	Organisation	d6ec3437-802b-418e-8c40-08fc96e9bcc9	rber.net	fp	radsecproxy	196.192.16.19	\N	\N	udp	cd28385d21c5a81c5d4a7981	6851a17646d7eea14e72faf7	cf72521b3509fb47f1671d24	t	t	t	1812	1813	2019-11-19 13:02:01.638639	2020-04-10 11:15:56.018988
6de56128-5cd9-45bf-b5b6-267ae12fef4d	Federation	49d70765-375a-42bf-b267-74eb0f21b617	zimren-flr-siliconsky	fp	fr3	41.198.128.64	\N	\N	udp	646298d54feca5d1aabcbe7c	7a2d36c94e00002bc4502c36	79c921efab976d0eae3f7f22	t	t	t	1812	1813	2020-06-01 13:07:35.099715	2020-06-01 13:07:35.099715
e42dd008-67ce-4cc1-9156-4b04bdc9fa8e	Confederation	621b2e43-dc2e-4f26-99b4-e126bb4caff6	rp.wacren.ip4	rp	fr3	196.216.191.12	\N	52:54:00:82:07:64	udp	4MuWqYSMNlOGSfpcjWX4lroL	647a4ff7c27c0f9411666099	23dfadbe82e8ec11e84fe95f	t	t	t	1812	1813	2020-05-20 15:27:03.504209	2020-05-20 15:27:03.504209
0eaf3c21-0f0b-4ac1-bdd2-f17654077e76	Federation	a33c9698-a460-40f9-849f-947ecb8fa561	irenala-flr1-ubuntunet	fp	fr3	41.198.128.65	\N	\N	udp	b3f0eaa6be7468d7bd2afcb5	1956b59486c0bc2d73e45cc9	9329c44351537ab05af5d7b3	t	t	t	1812	1813	2020-06-01 20:26:32.85989	2021-10-22 11:56:45.15135
86aa625d-06f8-4dcd-af63-d76306efe495	Organisation	2bf8127f-b5fa-4f92-a65c-fce09f50114c	mlw.mw	idp_sp	fr3	41.70.97.1	\N	\N	udp	73971d36c5bde1fbca641af9	7bacdef8ccb7d98120db5936	4d1a969437b4ad42e25d358e	t	t	t	1812	1813	2019-11-26 08:43:16.756235	2021-10-14 10:05:51.371146
067e5b7c-be9e-464a-9e0b-7ff9afd6e1c1	Organisation	c7b1c506-aaf5-4e61-b7cb-4d4feb85a5bd	rusangu-zamren	idp_sp	fr3	41.63.0.129	\N	\N	udp	6374af0afe16ec681cc4d82c	d607c20b422107e5c261a36a	1a9061d0cf0e29e5fd4e095f	t	t	t	1812	1813	2020-09-17 15:34:47.128971	2020-09-17 15:34:47.128971
766f9e6e-ff73-4619-bd4e-77fcf449544d	Organisation	94cf650e-540c-4d89-9f69-8891719fb5b5	Eko-Konnect IdP	idp_sp	fr3	178.79.161.199	\N	\N	udp	ab3eb4b3a3d47d948dec4589	38b745f31007c0deb9dce360	4025e4578a748eb29ba1754d	t	t	t	1812	1813	2020-09-24 10:03:48.681666	2020-09-24 10:03:48.681666
54f14874-258d-49d9-8051-e9a94d30dfd7	Organisation	d12bcb08-d0c5-4a5f-aedb-e1042a3e866e	nipa-radius	idp_sp	fr3	41.63.60.50	\N	\N	udp	3dadcc69d7d5f4d7cb88bdb2	58652bf0ebe5031d32b7c197	17d71b18258c3c8037c90b95	t	t	t	1812	1813	2020-10-02 07:41:19.223033	2020-10-02 07:41:19.223033
83770f2e-5467-4dd2-b14c-6ec74b8fd93a	Organisation	0a67d914-b70f-4970-ad77-6b8caf423852	Ethernet_FLR_new	fp	fr3	196.189.149.10	\N	\N	udp	807476c3ce0e2d855e3dc90d	1048ff9cc59fc7a1fe0449b0	62fda0b7e55fd9ce1faf98fe	t	t	t	1812	1813	2020-11-07 12:01:58.477019	2020-11-07 12:01:58.477019
7c6239e7-9430-4c64-9e52-a317f3a2e243	Organisation	cab21e0d-202d-401f-951b-eddad5f148f1	Kitwe College of Education	idp_sp	fr3	41.63.0.190	\N	\N	udp	76e924976316a18a3193aa4c	cf212b8ec18fb5b8786389be	4c9a191e0d384bf71011ba9c	t	t	t	1812	1813	2020-12-15 09:19:14.997219	2020-12-15 09:19:14.997219
63ab129a-32a0-415e-9667-63525a37ef0d	Organisation	82797b17-9b81-45ca-b904-24671e521f97	eduauth.soce.edu.zm	idp_sp	fr3	41.63.0.138	\N	\N	udp	6f979a98fc4a789b69ef283b	218254569dee12b9106380e5	a41835d7b8d33cf34622d0e8	t	t	t	1812	1813	2020-11-30 13:16:53.568926	2020-11-30 13:16:53.568926
51d96eb5-b7aa-4648-8c9d-a49a7241c25d	Federation	0b345644-3cdc-442e-8f7a-1add49e1ed4f	Ethernet_FLR_new	fp	fr3	196.189.149.10	\N	\N	both	eduroam@ethernet	8e699dc3ac496aa7a61518b5	adb50c5a6a1446e3b23d45de	t	t	t	1812	1813	2020-11-09 11:45:19.539697	2020-12-02 13:27:54.416828
82eaa31b-2d63-4872-8a0d-a9aefdfe3b0c	Organisation	5392bfa3-cf25-4e13-8528-d42baa9b7e7c	eduauth.ncbs.edu.zm	idp_sp	fr3	41.63.0.126	\N	\N	udp	7df317db629266e27ce07767	982b945685d7562034d1b671	a06c2dfaa74f03b7e6133dbb	t	t	t	1812	1813	2020-12-14 07:35:14.429729	2020-12-14 07:35:14.429729
4a0b2900-c9da-4507-8fe2-068887f611ea	Organisation	a42b1866-4163-45e2-b093-3edc1e6a71d9	eduauth.rcnm.edu.zm	idp_sp	fr3	41.63.0.171	\N	\N	udp	54d8ba2a171e526c81852dc2	4eb83a3794ea5fe2d0f21090	0cff66f12f3ab29081af2a8f	t	t	t	1812	1813	2020-12-14 15:18:24.611813	2020-12-14 15:18:24.611813
37eeedc0-9d42-4338-9367-e02e380c1f35	Organisation	05dab0bd-ad04-4820-a02a-15aa3e255b8f	Chilonga College of Nursing	idp_sp	fr3	41.63.0.172	\N	\N	udp	c178991983ffcd2295164f16	ec7c673e32df008ddcdd0c44	b3196c7270be295a1444eeab	t	t	t	1812	1813	2020-12-14 20:36:36.555439	2020-12-14 20:36:36.555439
69f49826-0804-40d3-bf05-57d3c9123bba	Organisation	3a6f9417-4853-4522-863e-9c2e43aea6fa	Chipata College of Nursing and Midwifery	idp	fr3	41.63.0.174	\N	\N	udp	4a8ba9702fef1d9b1b769cbe	fc6e5cdcf99e24889dcd554e	22e98a3217ebdfb75df398c9	t	t	t	1812	1813	2020-12-14 20:46:40.262773	2020-12-14 20:46:40.262773
a64d6996-44eb-4d17-b7a8-0194b00a6ad6	Organisation	48a3cb01-a52f-4f23-bc45-4d0e5a93f77e	Kabwe College  of Nursing and Midwifery	idp_sp	fr3	41.63.0.175	\N	\N	udp	c41496a231819d9213a608c9	590cfd9f31bc6c6c1dcb4274	bb063635e34696b83e2a6048	t	t	t	1812	1813	2020-12-14 20:52:43.446967	2020-12-14 20:52:43.446967
0c72bef8-66cb-4df2-8191-acdf20411a33	Organisation	cc373e93-f7d1-424e-9c21-801c6f1f758e	Lusaka Schools of Nursing and Midwifery	idp_sp	fr3	41.63.0.177	\N	\N	udp	f464b0af8cced193b418bb48	9b6b870712719309e1e63ade	2c0c45215dc4ab52ce00f44e	t	t	t	1812	1813	2020-12-15 06:53:47.307795	2020-12-15 06:53:47.307795
dd418e51-d7a7-478e-a5bf-0da57e25cb2b	Organisation	e656e725-44cd-482a-b465-0340255d8ff6	Micheal Chilufya Sata School of Nursing	idp_sp	fr3	41.63.0.178	\N	\N	udp	747e43173694d59392d54e73	39d96451de9cbf9540eb2154	8ff028e8c88e7adbe4d0a728	t	t	t	1812	1813	2020-12-15 07:01:25.933573	2020-12-15 07:01:38.684265
7478cadc-5028-4770-ba7e-7917725aa5a7	Organisation	bf33d3ba-99ba-4c1b-9c33-3310a65f09db	Mansa College of Nursing and Midwifery	idp_sp	fr3	41.63.0.180	\N	\N	udp	a01001d0376648ef0ae93258	5b1098e3a0290bafddad3b49	5bf23ea1935d11c02c6b37b4	t	t	t	1812	1813	2020-12-15 07:44:45.258528	2020-12-15 07:44:45.258528
3758eb31-3c61-4b10-93e5-7faae312c16b	Organisation	e89d53a5-d527-4ec0-a588-87e98d8b8148	Solwezi College of Nursing and Mid-wifery	idp_sp	fr3	41.63.0.182	\N	\N	udp	10d457b1f0533ea495192c93	73dfaab4ae5102297c39b4d7	92f202ee1bf0ef2992e3f1aa	t	t	t	1812	1813	2020-12-15 08:00:03.385846	2020-12-15 08:00:03.385846
442937c8-4113-4fdc-a973-2d4460d7562f	Organisation	dccddb90-cbe6-46cb-a624-14b4dbf7e066	Senanga College of Nursing and Midwifery	idp	fr3	41.63.0.183	\N	\N	udp	eeb4b06e136cc3ac3dbcbbe1	91f411c2da23c62eb34f6934	27f87c78e4ed8d312d1740cd	t	t	t	1812	1813	2020-12-15 08:05:31.988062	2020-12-15 08:05:31.988062
be7ad1a6-7b49-4db9-8e60-04fe54d006c4	Organisation	b3a6cfc1-b91c-485c-a005-4219b90eb83f	Kasama College of Nursing and Midwifery 	idp	fr3	41.63.0.184	\N	\N	udp	546aa6f32bc6fbc9a385d7c0	f801be4fa704dbdaec6a0d26	4ce556935727f12253d7aa8c	t	t	t	1812	1813	2020-12-15 08:16:21.103623	2020-12-15 08:16:21.103623
433a0081-5f2c-4a40-8f3b-3483767657ce	Organisation	5f2139d1-75e0-4ac5-a44f-6381ee9f8c57	Lusaka Institute of Applied Sciences	idp	fr3	41.63.0.186	\N	\N	udp	eaf043704ed7e8ea86b80dce	ac960a47e34aadcd667a5410	2da82259c6121cab4b8f4be3	t	t	t	1812	1813	2020-12-15 08:30:07.854316	2020-12-15 08:30:07.854316
e8d18525-cafc-4338-84a4-d6d38f54fac6	Organisation	ab836e55-9912-4a2a-a1ab-85df51382ef3	Kaoma College of Nursing	idp_sp	fr3	41.63.0.185	\N	\N	udp	49cff46f3e870a013437e4c1	0dd183afd691b8d510a4ebc3	2d14be7da5646bd56c061770	t	t	t	1812	1813	2020-12-15 08:19:21.000228	2020-12-15 08:39:29.183338
b601cb8c-c8ef-43de-9f30-728a508d8e1a	Organisation	350d84c1-c277-4363-a6dd-d58256b7b37e	Mufurila College of Nursing and Mid-wifery	idp_sp	fr3	41.63.0.181	\N	\N	udp	a0ca31c99ee0d03a20bbfed4	ca3aa03d702350ab900e3ec7	506f3581f4edd610526bbdd3	t	t	t	1812	1813	2020-12-15 07:56:18.540875	2020-12-15 08:39:50.737621
4330ef27-8fd7-4544-b968-4dae8faa8b53	Organisation	00b18d3a-29c2-4e6a-bee3-453587844688	Lewanika Schools of Nursing and Midwifery	idp_sp	fr3	41.63.0.187	\N	\N	udp	7b2c547ae02cd8f7e7760ce7	67c674de6c5641f082a025cb	cd4a1f278fa96784614973f7	t	t	t	1812	1813	2020-12-15 08:39:11.523842	2020-12-15 08:42:21.460141
b9678097-6d0f-4704-9906-dfe9bc4cc23a	Organisation	b6f60b7d-230f-47e1-9580-11e6d899b539	Kasama College of Education	idp_sp	fr3	41.63.0.189	\N	\N	udp	949a00affe28c7ec27c6a596	20dfe76abf86e8aa05d70512	e3b591725db9c2404056a081	t	t	t	1812	1813	2020-12-15 09:04:13.070808	2020-12-15 09:19:37.812756
9baad382-6f6c-4a51-ac1f-170f852daceb	Organisation	8dfc790e-ad17-467a-bc25-af17f7004c64	Mufulira College of Education	idp_sp	fr3	41.63.0.191	\N	\N	udp	0ebfdc38200e7944585baac5	aae3c43279953d567b89cf8b	63b2339ed58ef25d2f978aff	t	t	t	1812	1813	2020-12-15 09:23:22.521963	2020-12-15 09:23:22.521963
4d7814a0-6974-4f03-8e4c-47193f895050	Organisation	c709dc8e-aecc-4ce0-a1c2-bfe815ff122e	Mongu College of Education	idp_sp	fr3	41.63.0.193	\N	\N	udp	4755df72593824682f2a6b28	ed4c9da29ecd33cfbe71995c	12b13644a13cef26a3b48d26	t	t	t	1812	1813	2020-12-15 09:46:20.670158	2020-12-15 09:46:20.670158
07344306-758a-4bba-b7ca-3d4a7a04de0f	Organisation	bf83777c-f620-42de-aa60-8cb4faf67171	St. Mary’s College of Education	idp_sp	fr3	41.63.0.194	\N	\N	udp	d48ab8dc85baf2ccb68e4a68	5fbc7f175adfe6db3bea915e	ab5d0a5a822ef9c5953b96d0	t	t	t	1812	1813	2020-12-15 09:56:23.014686	2020-12-15 09:56:23.014686
923ce178-3eef-4d5f-a651-58c667e2c0ff	Organisation	293982c4-1b82-4ff0-8cb8-a682a4528582	Monze College of Agriculture	idp_sp	fr3	41.63.0.196	\N	\N	udp	c622c3b88e782b521cf7ebd5	f261a9aadfa7fb3388681a65	9205cd584f986715822ce765	t	t	t	1812	1813	2020-12-15 10:03:49.172971	2020-12-15 10:03:49.172971
39a1a213-63bd-4529-98e1-52015685dcd2	Organisation	a837afed-9908-4e0c-ade8-56a54d62ea9d	Monze Community Development College	idp_sp	fr3	41.63.0.197	\N	\N	udp	e8f8d177a46f8444444a847c	2122bb5ce52cd5baf63213b1	7d3df804c59e40b7263327ad	t	t	t	1812	1813	2020-12-15 10:08:21.540108	2020-12-15 10:08:21.540108
bd038296-6ba5-4c5f-85fa-994ab10b9896	Organisation	1c72adb6-7fd0-4ac9-86f2-f74a9ad7c895	Malcom Moffat College of Education	idp_sp	fr3	41.63.0.199	\N	\N	udp	a20b3f4a450d8182f06ae672	d94a0adfcd656056b7d91e93	4596347d20b89e639a840275	t	t	t	1812	1813	2020-12-15 10:15:27.539245	2020-12-15 10:15:27.539245
15dc8bc7-e89e-4753-9670-518c07088245	Organisation	a98028c2-feb2-4129-afb9-3d75cffae1ee	Mansa College of Education	idp_sp	fr3	41.63.0.200	\N	\N	udp	73f2b696de48fe935eeb7c39	2f9575cbce0febd14d9c339c	51564e95997f0dbaa563ee45	t	t	t	1812	1813	2020-12-15 10:19:58.691255	2020-12-15 10:19:58.691255
92282b8e-5a13-434a-bf8b-c288e4f99fe3	Organisation	d70d67d3-5a37-4043-a5c3-0d795c143655	Zambia College of Agriculture Mpika	idp_sp	fr3	41.63.0.201	\N	\N	udp	1e1a5d6492dd9f50c16cd59d	444d91abd211f7ac46541dd4	1185dbfe5591a20a63e4eed8	t	t	t	1812	1813	2020-12-15 10:26:01.678957	2020-12-15 10:26:01.678957
3ca9abe6-43a4-4036-a490-c36e80cd9088	Organisation	f4b8dd42-f206-46ca-bb2b-e9a7d1f909a1	Monze College of Nursing 	idp_sp	fr3	41.63.0.188	\N	\N	udp	ba0c9872818592cc7f59eeeb	51bba33c32e7468b520a7d67	02fabac13fc2113115415037	t	t	t	1812	1813	2020-12-15 10:44:27.65386	2020-12-15 10:44:27.65386
01fa16e0-7026-4ebe-bbbd-455e5887341e	Organisation	1b548d86-53e2-485e-a124-280a75ca8dcf	Popota Ariculture College 	idp_sp	fr3	41.63.0.197	\N	\N	udp	0e5e60965b2525837111d8ba	17cfa25126d042370aedba7c	0943da1ee8d26cc8ccb87a4d	t	t	t	1812	1813	2020-12-15 13:14:33.394293	2020-12-15 13:14:33.394293
e9680af1-971b-4db8-b05d-72adf1b55bdb	Organisation	4209f2c1-3849-46ae-87d9-004a22ce1a04	Nchanga College of Nursing and Midwifery	idp_sp	fr3	41.63.0.173	\N	\N	udp	710685f30e2947808529162e	bb519c0cbf34f2c537da3d9a	19a0abda1204ca1b396f036f	t	t	t	1812	1813	2020-12-17 16:01:45.879146	2020-12-17 16:01:45.879146
46f12d76-53bc-40e9-9658-f7d24d2de87d	Organisation	11612124-c37e-4fca-9a4d-6a4d667c12a4	Kasiya College	idp_sp	fr3	41.63.0.195	\N	\N	udp	670326e0c63e7215e22b94f8	d8fbfc2bdc2258f270bf2db1	50c18e9ce84a26f9b376da56	t	t	t	1812	1813	2020-12-21 07:36:34.385595	2020-12-21 07:36:34.385595
80bbb999-8367-4d51-a6c4-8ce6b5c42c07	Organisation	1b7f3dec-e631-4cf3-bdd4-a68074eeefd1	Chipata College of Education	idp_sp	fr3	41.63.0.192	\N	\N	udp	d5a47b5b665096585049f2bb	bb98eccf116231b82f810e73	3be73a2f4a1d06a934ffe0cd	t	t	t	1812	1813	2020-12-21 09:51:24.940298	2020-12-21 09:51:24.940298
df046c00-5e53-49d3-ba0f-625bb6d44ce4	Organisation	76c1e832-d232-4cd1-b2c6-4d455c48296b	nrdc-radius	idp_sp	fr3	41.63.0.203	\N	\N	both	f8a5be809ee1d26dae7b9420	59e2af0d9ac59eb3a43cf4c0	91842153bc8f40a5b545fe20	t	t	t	1812	1813	2021-02-04 09:16:50.936051	2021-02-04 09:59:53.560354
a1d87a61-f115-42f0-b642-3ab305bee4e7	Organisation	e974240c-1ece-4094-8a28-4a220ec0a9e5	ksnm-radius	idp_sp	fr3	41.63.0.202	\N	\N	both	bae07dca61920bb0619a0e6c	9d029dc3ea7394c46181db4d	3b46a93ebf2d0083c4e6eb0f	t	t	t	1812	1813	2021-02-04 09:58:34.096372	2021-02-04 10:00:19.77737
5de2bc56-bf3d-42b9-97d5-fd58fcdf1919	Organisation	12019ea3-124c-48b9-9772-c1c48af39cc9	dshs-radius	idp_sp	fr3	41.63.0.204	\N	\N	both	7e209af773d1cfd16c77bcc4	b55f5476b5680e16ba00d2ac	8c7bd3eb1117c9afed0885c5	t	t	t	1812	1813	2021-02-09 09:30:13.245101	2021-02-09 09:30:13.245101
1f9af2c4-2df9-4780-be76-204c9642b4a0	Organisation	cb11e742-b109-4f19-8a0f-f14481602895	Dovecot College of Nursing & Health Sciences	idp_sp	fr3	41.63.0.179	\N	\N	udp	18977dfc8c3ccc8f9dc9a87d	3a1a78f8288b063659ce8b62	a55ac27f1ffaf59b697ef249	t	t	t	1812	1813	2020-12-15 07:14:26.956281	2021-03-25 10:48:16.639208
abce97b1-2122-466c-ac22-c733e635968c	Organisation	1ce47b62-7c29-431f-889f-3e2949843b72	ZICA Eduru	idp_sp	fr3	41.63.13.135	\N	\N	both	d6ea9ccfb80d84d311f7472b	af5c71674073a01b06541614	47d156c97e8c61ed410a4bc3	t	t	t	1812	1813	2021-04-06 14:47:15.21328	2021-04-06 14:47:15.21328
ef4eaa1a-a96c-4cd3-bf05-dca191652d5c	Organisation	1c04c719-fda2-49bb-a2e4-82c952394d50	SomaliREN_Radius	idp_sp	fr3	154.73.25.73	\N	\N	udp	192b989e891bb5a13cf2cc73	9e172d402ed575176c0000b2	71f9c06496c445f26b880b2b	t	t	t	18121	18131	2021-04-29 08:53:50.79777	2021-04-29 08:53:50.79777
8145cbdf-f671-40aa-bc6b-10a09807edd8	Federation	73fc50f7-0e1d-48fa-b648-040e6d5dd116	SomaliREN_FLR	fp	radsecproxy	154.73.25.73	\N	\N	udp	03e5a4e3dfcf6738da43c684	6300f1eeb212764d7559b84f	f9d4aa536332a080f94bc0e8	t	t	t	1812	1813	2021-04-29 08:58:14.054104	2021-04-29 08:58:14.054104
e3af0463-8bf5-494e-ade3-34aa5ef63fe1	Organisation	911a5df1-70bb-43a6-99c3-9138271109ed	ua-radius-zm1	idp	fr3	196.32.215.153	\N	\N	udp	e8db5e26cbd76a6e2c5f1421	3b128f0746e219175dd050b0	24f0caa8dc1fec4bfef25baa	t	t	t	18128	18138	2021-04-07 12:04:32.929936	2021-04-07 12:04:32.929936
8b122322-5f7c-4fff-96b4-d4bf9cc67eda	Organisation	da5423fb-a58d-482f-b81d-a1bb8c3d0413	UNILUS Radius	idp_sp	fr3	41.63.13.40	\N	\N	both	3cabaa00f32258c88ecaca77	482d503a48142fd28d10cfea	49c2d47312d980c2b1d01e6e	t	t	t	1812	1813	2021-05-03 08:45:52.86078	2021-05-03 08:45:52.86078
3eecacd2-68ea-45d2-82e1-a950fbce6155	Organisation	911a5df1-70bb-43a6-99c3-9138271109ed	ua-radius-zm2	idp_sp	fr3	196.32.215.154	\N	\N	udp	e8db5e26cbd76a6e2c5f1421	3b128f0746e219175dd050b0	24f0caa8dc1fec4bfef25baa	t	t	t	18128	18138	2021-04-07 12:05:19.932421	2021-04-07 17:28:32.652321
541ab42f-b712-4763-8d60-31be44c3f579	Organisation	4266f4f5-9131-48d9-9ba4-042b7ed34f8f	LBTC Radius	idp_sp	fr2	41.63.38.19	\N	\N	both	9a43bb5e91ea29a9dff6ed91	bd4de090b30a9d45b95f019a	e94c24dc3f48bc287c8f8e99	t	t	t	1812	1813	2021-04-08 12:35:56.636431	2021-04-08 12:35:56.636431
397a598e-8a02-4073-807c-9e7e41387187	Federation	2da7d3a9-81e9-4ae7-986c-142c690c41f1	mw-maren-flr1	fp	fr3	41.70.11.5	\N	\N	udp	fd58f2a548f581c154277662	615324bda6c12bcc68f92d47	dd1ad4308f62d0e0f0fc9897	t	t	t	1812	1813	2021-04-07 11:57:47.73168	2021-04-19 04:23:11.367864
d43ef27f-e2c4-4c4b-8f5a-c64cd5e2becf	Federation	02b4e345-b851-4428-9531-badf883610aa	flr1.eduroam.togorer.tg	fp	fr3	102.176.252.71	\N	\N	both	92b98260f84b4d28a530d6f2	585f26799d1c46cdb7c3f408	5eb7c518964c3e6b8e2d45f0	t	t	t	1812	1813	2021-04-26 12:59:37.320036	2021-05-05 11:00:05.085705
e5e73070-5e45-40d4-97f5-bdb837b25e19	Organisation	f2ec386f-3a4f-4579-b56d-a1e6da1b43aa	Zambia College Open University	idp_sp	fr3	41.63.0.205	\N	\N	udp	1d9decea8d1b39a2c91f4675	e73c93643600445bf656d852	cee132560278cd08389d5f4c	t	t	t	1812	1813	2021-05-24 13:25:35.826862	2021-05-24 13:25:35.826862
b22586c1-7ced-48f0-b214-3eb67e4801ff	Federation	2da7d3a9-81e9-4ae7-986c-142c690c41f1	mw-maren-flr2	fp	fr3	41.70.1.5	\N	\N	udp	ff95c3aac69045be9a56c644	52ac89231668cb65c7cc8d92	769ae7afdca72909f5296b78	t	t	t	1812	1813	2021-06-11 09:30:43.60305	2021-06-11 09:30:43.60305
3b3f349d-d86f-4b3e-8d3c-1eeb98f1b971	Organisation	86b3926e-5f58-4f34-a48c-e4cd7204bee9	maren-radius-1	idp_sp	fr3	41.70.11.9	\N	\N	udp	33f36ea1c519450f15bc0787	92a2e0d5c81968cc8960dd90	7711ee84056f6d3ee1a0807e	t	t	t	1812	1813	2021-06-11 09:37:16.541548	2021-06-11 09:37:16.541548
4cde49fa-1160-4f11-9b28-11c5f3bca80b	Organisation	c379f63a-ef47-491a-98ba-6cb76daa20b0	mubas-radius-01	idp	fr3	41.70.48.22	\N	\N	udp	21b405af4f93e90b3fe3e419	9ea66161bbb829c7b52f177e	734d489ddd014c89fa182d75	t	t	t	1812	1813	2021-06-11 10:09:30.255729	2021-06-11 10:09:30.255729
28f5acbd-0bb9-4c62-af34-0904d02cd5c9	Organisation	6461d70e-ebf3-4502-8125-6a4623ec2a9a	UNIMA-RADIUS-1	idp_sp	fr3	41.70.32.75	\N	\N	udp	af3edf02a323dd0854f2a1b8	32ca027ee8adbc6a0aa9fb0e	1e7f642a646e787de70d2c51	t	t	t	1812	1813	2021-06-22 17:09:33.73874	2021-06-22 17:09:33.73874
c674e083-9eb7-4504-ac95-ffa2fff9d707	Organisation	28694d8e-e7d7-417a-b5b0-cf4815c92234	Cancer Disease Hospital	idp_sp	fr3	41.63.0.239	\N	\N	both	d3c421dfd041300c85b9a986	c81370fdb02eb6b46a692f25	89f9f78b225190d17dc0caf9	t	t	t	1812	1813	2021-08-26 14:27:36.337657	2021-08-26 14:27:36.337657
87e6c676-7ab1-4e07-ab7f-a53f40bea1dd	Organisation	f5e8d182-0759-45a2-a54e-8a50a43fbab6	eduroam.togorer.tg	idp_sp	fr3	102.176.252.71	\N	\N	both	3e46224bb5bc90cf37c08e2d	d989f884005474193e736a52	f9c10f7beee26ef1d044c5ad	t	t	t	1812	1813	2021-09-15 16:47:44.939504	2021-10-19 11:02:07.508132
653c2b0d-a0fd-45c2-9852-0127b768c986	Organisation	0bbc71ed-a2e0-4e10-983e-a7fb0ffec5b5	mukuba-radius	idp_sp	fr3	41.63.34.237	\N	\N	both	ce3d6ffc31428d2dc634b3c3	9edb5286634a8265a913714c	07a3a2c536c9c97376fddccf	t	t	t	1812	1813	2021-12-13 09:42:10.084844	2021-12-13 09:42:10.084844
\.


--
-- Data for Name: realms; Type: TABLE DATA; Schema: public; Owner: switchboarder
--

COPY public.realms (id, domain_name, organisation_id, test_user, test_password, generic, created_at, updated_at, allow_subdomains) FROM stdin;
54649e67-904b-45f2-b820-f288413e9e0c	ubuntunet.net	911a5df1-70bb-43a6-99c3-9138271109ed	sepp	ciao	t	2018-03-09 07:41:26.060115	2018-03-09 07:41:26.060115	f
d52d6472-9f0f-4b98-b272-734bd7ae6980	ubuntunet.mw	911a5df1-70bb-43a6-99c3-9138271109ed	sepp	ciao	f	2018-03-09 07:41:41.785019	2018-03-09 07:41:41.785019	f
4f0934f0-9561-4857-8bf9-5a85af09c107	medcol.mw	1786272a-a169-4b8c-b7fa-9f47905733fc	doctor	zhivago	f	2018-03-27 11:14:01.387564	2018-03-27 11:14:01.387564	f
dbed0c71-0c2d-4549-802f-64e136eebd43	zamren.zm	1b86a4eb-944e-49c3-b183-0c631b1d27bc	test.two	zam&2018	f	2018-05-21 09:09:47.337409	2018-05-21 09:09:47.337409	f
37ab9692-4183-46a4-bb7a-5bbdbf57ce6a	irenala.edu.mg	ba395f36-ef32-4db2-8042-0f23c6fccbcb	eduroam	bonjour	f	2018-07-25 06:31:45.415961	2018-07-25 06:31:45.415961	f
0432f576-24b3-4735-9f68-806ea2545256	ub.edu.bi	8d2a33be-7230-4c87-b6a3-499b4e18bf63	eloge.bapfunya	Letacla237Afc#	f	2018-11-22 13:19:51.406796	2018-11-22 13:19:51.406796	f
8898eb46-68e9-43ab-8007-4961e6b62ca3	mg.auf.org	c6a1da0a-512f-477d-ad3b-4ed3f2cba737			t	2018-11-30 11:58:35.732408	2018-11-30 11:58:35.732408	f
edd4b993-3fe9-4f01-b6ed-714e1cb472b3	mu.edu.zm	408c3c2c-19cf-472e-82e4-9650641ede23			f	2018-12-14 08:20:16.691376	2018-12-14 08:20:16.691376	f
b4b565fc-2ed6-4f6f-a1d8-89541b0f11a1	unza.zm	9b0f1760-1df5-4e5e-8118-a6cef51cf832			f	2018-12-14 08:23:04.161194	2018-12-14 08:23:04.161194	f
74b4eb4c-e6cc-40c8-8ba5-e5a1bbc0cc64	solwezitrades.edu.zm	c0457fb7-fc36-4bac-8e6d-019c5d716cd6	zamnrotest	z@mnr0218	f	2018-12-14 10:04:49.555529	2018-12-14 10:04:49.555529	f
7fa206ff-a2d2-46e1-a17e-f599e92ec5a8	mu.ac.zm	408c3c2c-19cf-472e-82e4-9650641ede23	zamnrotest	z@mnr0218	f	2018-12-14 08:18:52.248352	2018-12-14 13:01:32.40614	f
7d01ffd6-829b-40fe-9354-cc2666b898ba	eko-konnect.org.ng	94cf650e-540c-4d89-9f69-8891719fb5b5	pius@eko-konnect.org.ng	5445cran	f	2019-03-14 09:59:39.47364	2019-03-14 09:59:39.47364	t
7eb9d16a-fbae-4c25-9ffc-7f78dd70a397	covenantuniversity.edu.ng	96f247af-06f8-4c6a-b325-71f89fd65bd5	fabetor	743592bedf41170ccdd3c9c5	f	2019-03-15 11:58:24.57427	2019-03-15 11:58:24.57427	t
3707c2b5-7e51-4e77-8d1b-c2f74e2c0393	ternet.or.tz	cd8a9e52-58b9-4fcc-93ca-e53a81d50383	algulus	a15cde73bf6c0b90170216c9	f	2019-03-18 14:53:40.977313	2019-03-18 14:53:40.977313	f
0886536b-2d80-411c-a9d3-b74a1debcb63	mgix.mg	fad269fb-c5f3-4ab2-b7ce-2d5158df531a	biguscus	261478a8ab462ebca4e64a0f	f	2019-03-27 06:09:48.369797	2019-03-27 06:09:48.369797	f
0c11ad9f-9698-4c85-95ca-5ae726f5e844	riter.ci	b7a4f25d-aa72-4812-a1dd-a563d26ba979	beguslius	df7872b4a580deff08d815b9	f	2019-03-27 11:01:07.862518	2019-03-27 11:01:07.862518	t
3f2292f2-4275-48e1-92e0-0dbbb2b9228d	unijos.edu.ng	f897a4d3-44ca-4543-82aa-b4e502c6463e	annules	31d1ddf5a971a926cdb2a513	f	2019-04-01 13:37:28.555757	2019-04-01 13:37:28.555757	t
22da3b26-dc75-4ad0-bd9b-248130023282	unizik.edu.ng	6f4462ad-1f14-4e25-be5e-88cf2e42cec1	babolus	31a1d30ec7792ccc54a34f14	f	2019-04-02 11:51:24.539195	2019-04-02 11:51:24.539195	t
a82ad577-9b94-48a2-ae9f-6ecbac6c301b	udusok.edu.ng	d732f8b8-d167-4dac-b175-724f7188be6a	bebitin	48914c000a1d08dda9973821	f	2019-04-04 15:55:33.435755	2019-04-04 15:55:33.435755	t
cd602347-f140-4ea6-8ce5-004781314b19	unilag.edu.ng	9b15ed64-9965-4b8d-8857-98844f2a5e14	bebetus	4abd5d55fabaeedd88ffa8ff	f	2019-04-18 11:16:08.461094	2019-04-18 11:16:08.461094	t
cc0fbe35-535d-454f-939f-ca1677edaf8b	students.unilag.edu.ng	9b15ed64-9965-4b8d-8857-98844f2a5e14	andatin	9c2b17de8fee987b3896f3b5	f	2019-04-18 14:58:55.472497	2019-04-18 14:58:55.472497	f
d2d27941-b503-4806-b69c-d36a6a04a2af	pg.unilag.edu.ng	9b15ed64-9965-4b8d-8857-98844f2a5e14	braunus	89ad324cde62594d605b05f2	f	2019-04-18 14:59:23.835683	2019-04-18 14:59:23.835683	f
759f5b56-1580-4b3b-8852-c86ef6c528c0	costech.or.tz	991db693-847f-4626-ab05-c4bafd190f92	eubetor	572874cf13bd8e1074920be4	f	2019-05-03 10:40:54.281772	2019-05-03 10:40:54.281772	f
ab38a96f-b951-4e27-8a67-4bc9741c0fcb	ubuntunet.org	911a5df1-70bb-43a6-99c3-9138271109ed	abues	87c401472c28fbff0558b07b	t	2019-06-16 06:28:50.850704	2019-06-16 06:28:50.850704	t
59f84b50-19dc-4da3-a839-d76dba9b4857	ug.edu.gh	720b4990-7e36-4d61-83b5-09d2d0c46889	ebitin	a9f8806d59a9cbb0f75a54f1	f	2019-08-05 22:12:17.968639	2019-08-05 22:12:17.968639	f
8bafa89e-c576-4f35-9caa-cca98e60f970	knust.edu.gh	983c15ee-9a50-4725-bfc0-9e2067ec14fa	anbutus	bff244450674cfbeb5ac5726	f	2019-08-06 06:43:23.770974	2019-08-06 07:46:39.556634	t
6ea7e663-f4a8-44f4-aba2-111f725c2741	ashesi.edu.gh	1e4bdaed-2062-439e-8ef3-593bdb2c4701	fafritin	84034bc47292b811fdd91c20	f	2019-08-07 16:33:18.454467	2019-08-07 16:33:18.454467	f
9b75f9a4-1b40-4b67-93b7-7c28cb8487b7	tvtc.ac.zm	1e45e65b-9167-4cc9-bbb7-1f11d63e70d8	ebilius	ea51951e5ce77324eb8e4eff	f	2019-09-23 10:51:38.479768	2019-09-23 10:51:38.479768	f
fecedd6b-714e-4ba4-ab1c-7c9f1fe7276a	tvtc.edu.zm	1e45e65b-9167-4cc9-bbb7-1f11d63e70d8	dugusnus	3bf9a5118dccf05cb58b3361	f	2019-09-23 10:51:55.604579	2019-09-23 10:51:55.604579	f
631e37cd-b341-40c4-9ca3-68429136c1e6	int.icermali.org	549299ce-02f6-4aed-bc57-b8e5131ff7f3	fagulius	02b6e0d216dc607e0a143cf8	t	2019-10-14 13:57:18.389156	2019-10-14 13:57:18.389156	t
15631ea2-46af-49aa-821a-57a4a143041c	wacren.net	35d18cea-9f0b-42b3-989d-f9ea84b94ef6	egunus	997ff614667d8ee2a2a6db9e	t	2019-10-20 08:06:30.332064	2019-11-18 22:42:01.611188	t
d3fe85c4-f68f-4b8b-a20d-c78dd8a855e0	wacren.org	35d18cea-9f0b-42b3-989d-f9ea84b94ef6	efrilus	8d0cc440ad566a7b0cb07db6	t	2019-11-18 22:42:44.200399	2019-11-18 22:42:44.200399	f
88cc799b-1b8a-46b6-87c6-c45d2fe8a7d4	lucn.edu.zm	cc373e93-f7d1-424e-9c21-801c6f1f758e	fanulius	51091d69262a98d3cfe7a21a	f	2021-02-04 12:26:36.777252	2021-02-04 12:26:36.777252	t
2bec8531-ec1f-4af8-a4a7-b736ba4c7a85	uac.bj	64f81d4e-7d1a-4a40-b5b8-b1ddd99e5ecc	dobicio	838dfc8053cf99fdc35feb58	f	2019-11-19 13:59:01.487076	2019-11-19 13:59:01.487076	f
cf5ddc83-5bf0-41ea-9e61-672454629f32	mlw.mw	2bf8127f-b5fa-4f92-a65c-fce09f50114c	dabolius	3b518ef9da0c508f3bab5337	f	2019-11-26 08:29:33.862244	2019-11-26 08:29:33.862244	f
1f006ece-91a7-4a2a-8d7e-0ddc2a7ba2fc	ethernet.edu.et	0a67d914-b70f-4970-ad77-6b8caf423852	eugunus	039adfab72dd7d0532b60b03	f	2020-03-17 13:48:54.162399	2020-03-17 13:48:54.162399	f
dc70d6cd-bb0e-474e-ba89-55500cc1d343	ru.edu.zm	c7b1c506-aaf5-4e61-b7cb-4d4feb85a5bd	agucus	b624d155d6096b19fa34e5a9	f	2020-09-17 16:09:23.650237	2020-09-17 16:09:23.650237	f
064606cb-083e-4f00-a773-960cc1225978	nipa.ac.zm	d12bcb08-d0c5-4a5f-aedb-e1042a3e866e	braunus	b9f2512664c1505a4e567b48	f	2020-10-02 07:41:38.994403	2020-10-02 07:41:45.137131	t
4e7fe741-9b19-425d-914a-142e75d008b9	nrdc.ac.zm	76c1e832-d232-4cd1-b2c6-4d455c48296b	dibies	4b315234ee25ec8e10a5ef73	f	2021-02-04 09:59:35.34346	2021-02-04 09:59:35.34346	t
f94d934e-4ad6-4679-9b48-9f1207117752	ksnm.edu.zm	e974240c-1ece-4094-8a28-4a220ec0a9e5	aunulius	beb5184a973c952b15acf11c	f	2021-02-04 10:00:42.558454	2021-02-04 10:00:50.097883	t
979576ae-6118-4066-bd93-513e8c833a3e	dsn.edu.zm	cb11e742-b109-4f19-8a0f-f14481602895	augutor	49bb76065b8420a7e27e08e7	f	2021-02-04 10:03:37.898892	2021-02-04 10:03:49.104219	t
833b0613-a503-4281-ac4b-b7c5b990a43a	mansacnm.edu.zm	bf33d3ba-99ba-4c1b-9c33-3310a65f09db	alfritin	4edfa76281504ae135c906c7	f	2021-02-04 10:04:41.81322	2021-02-04 10:04:41.81322	f
5637b9ea-c7db-4ad7-aa31-53b3ef57199f	rcnm.edu.zm	a42b1866-4163-45e2-b093-3edc1e6a71d9	bibucio	fb483706efd65e56fdf5617a	f	2021-02-04 10:07:13.041555	2021-02-04 10:07:28.151094	t
7cbe70f8-44cb-4360-9b52-3dcc3c1b54d9	ncbs.edu.zm	5392bfa3-cf25-4e13-8528-d42baa9b7e7c	fabucus	86e35f6198e2138a17646fa1	f	2021-02-04 12:22:22.7517	2021-02-04 12:22:22.7517	t
6ce7f108-c6de-434c-8bcd-7458afd2d56e	ccnm.edu.zm	05dab0bd-ad04-4820-a02a-15aa3e255b8f	anautor	2cba63cc5c8057a22172d1cf	f	2021-02-04 12:23:11.748868	2021-02-04 12:23:11.748868	f
54cc2665-af7a-4a94-b484-eab3f7baa755	chipatanursing.sch.zm	3a6f9417-4853-4522-863e-9c2e43aea6fa	eubunus	16c288acb1291ee041b12d1a	f	2021-02-04 12:23:58.595825	2021-02-04 12:23:58.595825	t
99589b76-368e-47d8-82b7-adf5576b0b6f	kacnm.edu.zm	48a3cb01-a52f-4f23-bc45-4d0e5a93f77e	bifricio	85b946e26cc1033c636a110a	f	2021-02-04 12:25:20.960375	2021-02-04 12:25:20.960375	t
14510376-95b4-4665-8241-925c0ca0260d	mcscnm.edu.zm	e656e725-44cd-482a-b465-0340255d8ff6	dinulius	2a3c45b5a093368e81e74f9f	f	2021-02-04 12:27:27.146975	2021-02-04 12:27:27.146975	t
6d1ff319-0304-48e6-8089-31e466a09263	lias.edu.zm	5f2139d1-75e0-4ac5-a44f-6381ee9f8c57	bigustus	088dd8fd8cb83835a33f1436	f	2021-02-04 12:30:34.099293	2021-02-04 12:30:34.099293	t
91e4d7cb-57d4-4ca0-9612-e2306c420ede	sencnm.edu.zm	dccddb90-cbe6-46cb-a624-14b4dbf7e066	abitin	dd0556fbd576a3670f04ad63	f	2021-02-04 12:32:12.847139	2021-02-04 12:32:12.847139	t
5acfb51c-f2fd-4f71-89b7-acd44b44af0b	socnm.edu.zm	e89d53a5-d527-4ec0-a588-87e98d8b8148	fagulus	f81b15475a0b05a6d82b2d36	f	2021-02-04 12:33:13.441088	2021-02-04 12:33:13.441088	t
3e4cf8f9-d8a7-47fe-9051-ccca19b770f8	kacon.edu.zm	ab836e55-9912-4a2a-a1ab-85df51382ef3	bidaes	63d37259e5cd470a7de3688c	f	2021-02-04 12:35:59.735168	2021-02-04 12:35:59.735168	t
c00a8f33-c135-4f77-950f-0f21a492bc04	cce.edu.zm	1b7f3dec-e631-4cf3-bdd4-a68074eeefd1	braucus	7cc6a2961ca9a666f010efb2	f	2021-02-04 12:36:57.118178	2021-02-04 12:36:57.118178	t
555e3ac5-61da-485f-9304-6fbb06c1112e	lcnm.edu.zm	00b18d3a-29c2-4e6a-bee3-453587844688	dobetor	b39f4a8a021323378f0870a0	f	2021-02-04 12:38:58.977501	2021-02-04 12:38:58.977501	t
f40ba255-6f1f-4efa-a9d6-9f3e8a983473	ksn.edu.zm	b3a6cfc1-b91c-485c-a005-4219b90eb83f	eudacus	00544e93d0e09290600f4ffa	f	2021-02-04 12:37:59.228625	2021-02-04 12:40:42.938469	t
f63aee7d-e23d-4807-8cb2-04b1d212f363	kace.edu.zm	b6f60b7d-230f-47e1-9580-11e6d899b539	faguslus	74d8d669df4b9567fa5b38f8	f	2021-02-04 12:41:51.222153	2021-02-04 12:41:51.222153	t
0dad3cb7-63ea-4d50-97f0-d5a08b250a76	kce.edu.zm	cab21e0d-202d-401f-951b-eddad5f148f1	dabelus	a920a78a7bc472c667dc2865	f	2021-02-04 12:45:16.675229	2021-02-04 12:45:16.675229	t
b9d628ee-6485-400e-9f4b-bdc29b263045	unima.ac.mw	6461d70e-ebf3-4502-8125-6a4623ec2a9a	angela	merkel	f	2018-03-27 11:23:38.769587	2021-06-11 10:03:38.067118	t
2ae6aa2e-c358-4a21-9c07-8f2ffceb22c4	ronaldros.edu.zm	350d84c1-c277-4363-a6dd-d58256b7b37e	bagucus	af5a042d0554b2b87b115167	f	2021-02-04 12:35:11.343761	2021-02-04 12:47:31.444127	t
706bba76-70d6-42cf-963d-63296a285a68	muce.edu.zm	8dfc790e-ad17-467a-bc25-af17f7004c64	bedatin	4f06ccc9c7dc6298d5afda8d	f	2021-02-04 12:48:42.285729	2021-02-04 12:48:42.285729	t
0e7daf02-6c9d-4cf3-9556-2e2f46ec738f	mocce.ac.zm	c709dc8e-aecc-4ce0-a1c2-bfe815ff122e	braunus	15416cf6d0aeff18f6080817	f	2021-02-04 12:50:11.521928	2021-02-04 12:50:18.652537	t
2fd66cc5-18de-4c87-a09c-186ee4dae421	smace.edu.zm	bf83777c-f620-42de-aa60-8cb4faf67171	dugutus	cb64870625a7cb0ff3833881	f	2021-02-04 15:04:23.630211	2021-02-04 15:04:23.630211	t
be801965-ea26-45db-afa0-e3dce8bfd313	zcamonze.edu.zm	293982c4-1b82-4ff0-8cb8-a682a4528582	begucus	1f0545e89c3cfb75074f3e3b	f	2021-02-04 15:05:21.902983	2021-02-04 15:05:21.902983	t
0074434e-3ca4-4f7a-8487-5b6bf0b894aa	comdevcollege.edu.zm	a837afed-9908-4e0c-ade8-56a54d62ea9d	befrilius	de2120d7ea9628d25405da7c	f	2021-02-04 15:06:16.673281	2021-02-04 15:06:16.673281	t
266ed6b5-89a5-4de3-acc3-36ed1ccaea94	mamoce.edu.zm	1c72adb6-7fd0-4ac9-86f2-f74a9ad7c895	dobetin	c74b5874e6484ac91a3f3d9d	f	2021-02-04 15:06:54.292926	2021-02-04 15:06:54.292926	t
65632ce3-198d-4f3c-913e-ff61d1afb6df	mace.edu.zm	a98028c2-feb2-4129-afb9-3d75cffae1ee	dabotus	6ca43ad3a23a315889d2fba8	f	2021-02-04 15:07:40.12854	2021-02-04 15:07:40.12854	t
cc700ece-b9c7-4d20-b11f-d40187f5133b	zcampika.edu.zm	d70d67d3-5a37-4043-a5c3-0d795c143655	dibutus	aa2bc4f691f0112907390aab	f	2021-02-04 15:09:24.193481	2021-02-04 15:09:24.193481	t
9fe750a1-ad31-46e6-b7d2-a97b30118506	monzecnm.edu.zm	f4b8dd42-f206-46ca-bb2b-e9a7d1f909a1	befrilus	76bed365dce415401c934d70	f	2021-02-04 15:10:14.932381	2021-02-04 15:10:14.932381	t
8d687741-07a6-48ad-93af-39d6b05584f4	kasiya.edu.zm	11612124-c37e-4fca-9a4d-6a4d667c12a4	ebitor	261c2cb45ac0407b3a7cadf0	f	2021-02-04 15:11:04.201827	2021-02-04 15:11:04.201827	t
edfada75-218d-400b-94b3-a07860e8e14f	nchangacnm.edu.zm	4209f2c1-3849-46ae-87d9-004a22ce1a04	dogustin	372d383890c847486a8474c8	f	2021-02-04 15:11:57.531889	2021-02-04 15:11:57.531889	t
f9c92132-d031-43f2-b76c-fddf50452bf8	chau.ac.zm	faddfab4-02d0-45b3-9ac1-351eacfd4efa	bigutus	03e1beabbd372177bf4710dd	f	2021-02-04 15:14:24.130901	2021-02-04 15:14:24.130901	t
5e33cd41-2a71-4ac9-ae5f-d6d608eb5fc9	dshs.edu.zm	12019ea3-124c-48b9-9772-c1c48af39cc9	braunus	02b5668baff0a7326d2b00c9	f	2021-02-09 09:30:30.167322	2021-02-09 09:30:30.167322	t
c5d3bd3f-225e-423b-b87e-c0aa6b1d2736	zica.co.zm	1ce47b62-7c29-431f-889f-3e2949843b72	aubilus	ca15e10e4af14afed2fe4ed4	f	2021-04-06 14:47:43.740482	2021-04-06 14:47:43.740482	t
887001aa-0ee8-44cd-9f70-af54875bc26f	lbtc.ac.zm	4266f4f5-9131-48d9-9ba4-042b7ed34f8f	aguscio	d49a94466b724411a0a74465	f	2021-04-08 12:36:17.040571	2021-04-08 12:36:31.467371	t
397aedbd-7915-48e3-aad9-f4345c3266bc	togorer.tg	f5e8d182-0759-45a2-a54e-8a50a43fbab6	banules	686331b3914851043e89e747	f	2021-04-23 17:28:19.729563	2021-04-23 17:28:19.729563	f
f849beaa-9ded-44c3-8c97-6bacefc9720b	somaliren.org.so	1c04c719-fda2-49bb-a2e4-82c952394d50	fagunus	a12ee945dca5938372ab8d2f	f	2021-04-29 08:56:22.372194	2021-04-29 08:56:22.372194	t
ff12a147-6484-4097-ba8c-c85ddb2caec2	unilus.ac.zm	da5423fb-a58d-482f-b81d-a1bb8c3d0413	ebolus	1dc8df9c256a3f8c0872b84d	f	2021-05-03 08:46:08.662516	2021-05-03 08:46:08.662516	f
9f476429-bceb-4f82-a4fd-9a59c704a839	zamcol.edu.zm	f2ec386f-3a4f-4579-b56d-a1e6da1b43aa	eubolus	1bada4d2f8f24c4cba7b2188	f	2021-06-03 15:36:00.125749	2021-06-03 15:36:00.125749	f
e78834f8-c25a-4162-9895-1e9723b5cbcb	maren.ac.mw	86b3926e-5f58-4f34-a48c-e4cd7204bee9	augusius	639055ec22315a9bbb9b73be	f	2021-06-11 09:44:07.118085	2021-06-11 09:44:07.118085	t
2860321c-7f6d-48dc-a010-120143b24fd5	mubas.ac.mw	c379f63a-ef47-491a-98ba-6cb76daa20b0	doboes	d29b74c933f28877cc0130b2	f	2021-06-20 18:00:35.180392	2021-06-20 18:00:35.180392	t
b0179870-0efc-49f0-a8e9-9d8bd1d0f336	poly.ac.mw	c379f63a-ef47-491a-98ba-6cb76daa20b0	enulius	30dee16db1dbfa19fb62d962	f	2021-06-20 18:01:03.347405	2021-06-20 18:01:03.347405	t
8d2f5d45-a754-4235-b17a-187d725c4302	cc.ac.mw	6461d70e-ebf3-4502-8125-6a4623ec2a9a	albues	07fd0565a63941200a6b4be2	f	2021-06-25 07:41:27.652181	2021-06-25 07:41:27.652181	t
0b16f84e-4699-43b6-bc0a-e9eef0d7a74f	unima.mw	6461d70e-ebf3-4502-8125-6a4623ec2a9a	fafrilus	42c42cfbe72cda3bf02592b1	f	2021-06-25 07:41:40.21731	2021-06-25 07:41:40.21731	t
014b4888-83c3-4ecc-b1f6-d1335e9dbcbe	mukuba.edu.zm	0bbc71ed-a2e0-4e10-983e-a7fb0ffec5b5	andatin	1325c91e1db153e76fb86668	f	2021-12-13 09:42:31.836084	2021-12-13 09:42:31.836084	t
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: switchboarder
--

COPY public.schema_migrations (version) FROM stdin;
20171109122533
20171130140038
20171117033234
20171117092153
20171110104953
20171124130831
20171127054019
20171201093953
20171218073648
20180308115846
20180423095158
20180821092418
20180828134605
20180829060010
20190301220702
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: switchboarder
--

COPY public.users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, confirmation_token, confirmed_at, confirmation_sent_at, unconfirmed_email, admin, first_name, last_name, created_at, updated_at) FROM stdin;
5	abmsangi@ternet.or.tz	$2a$11$TY/87afF2klH87v0dBYPX.iMYltYsfT8/aqbj831GLMeuLPy9RzE2	\N	\N	\N	0	\N	\N	\N	\N	TECNTyTYJ_wL4fCPCYdB	\N	2018-05-18 04:40:09.673974	\N	f	Abdulkarim	Msangi	2018-05-18 04:40:09.673358	2018-05-18 04:40:09.673358
7	lalanirina@irenala.edu.mg	$2a$11$bkdaLn.YSrKiGJ8UMLJd1OguKs/V.C2vF2n/Rw3Ap3dk0EENJk4MC	\N	\N	\N	130	2021-11-29 08:30:07.726386	2021-11-18 10:16:07.391513	41.242.99.245	41.242.99.245	WMKyMaai_C6qvvtwNx9z	2018-07-25 05:12:41.984324	2018-07-25 05:10:18.616529	\N	f	Lalanirina Jean	ANDRIANTSITOHAINA	2018-07-25 05:10:18.615824	2021-11-29 08:30:07.727888
6	nosiku.sikanyika@zamren.zm	$2a$11$o9EWPMTERibpysKb3tU5zO0c0.zI6DnmGp3Op63gfDGw438LCCpZW	\N	\N	\N	2	2018-07-10 08:01:04.98453	2018-05-31 07:30:59.209385	41.63.32.100	154.126.110.188	ydKxgsQxvdz9WNrPRLob	2018-05-31 07:30:43.838794	2018-05-31 07:26:37.338314	\N	f	Nosiku	Sikanyika	2018-05-31 07:26:37.337585	2020-09-07 15:25:46.44593
3	henry.simfukwe@zamren.zm	$2a$11$KD/C87YX4RsH.mTzidD0xObtJav7P40vFB3tomSDOeNpIMh/oWRHS	\N	\N	\N	97	2021-12-13 11:37:59.732669	2021-12-13 10:30:33.876676	41.63.32.201	41.63.32.201	Tay3419ptRPEmyv8Y8Dm	2018-03-27 20:37:29.777151	2018-03-27 20:36:05.818644	\N	f	Henry	Simfukwe	2018-03-27 20:36:05.818163	2021-12-13 11:37:59.734031
25	roypangani@gmail.com	$2a$11$SrPsq3n576ZOdU0kwx882ebP6op9rTtfZTRXCApm0.tIYiqwHEqJ2	\N	\N	\N	1	2019-05-17 13:44:14.612113	2019-05-17 13:44:14.612113	41.216.228.242	41.216.228.242	rAVw6ut_6Qti3vt_jMam	2019-05-17 13:40:50.400535	2019-05-17 13:39:07.949952	\N	f	Roy	Pan	2019-05-17 13:39:07.949496	2019-05-17 13:44:14.621317
26	arnaud.amelina@togorer.tg	$2a$11$LlnnYM6zFL8sHwDk6R0J4uF0pd.LL1GrGx5J2I6b2xEhBQwKD0KpK	\N	\N	\N	34	2021-10-24 16:16:25.653344	2021-10-23 00:11:39.26031	41.207.188.2	196.170.213.163	pzkMejfLZhs334dPtSQ1	2019-05-28 13:24:04.373888	2019-05-28 13:19:20.707446	\N	f	Arnaud A. A.	AMELINA	2019-05-28 13:19:20.706912	2021-10-24 16:16:25.654813
8	rogerio.muhate@morenet.ac.mz	$2a$11$mReQMTeBSUw15GMSkCLvAeNul/AXTMzUFKOR5Wu.Ta/F8XpVnhXpO	\N	\N	\N	3	2018-08-29 15:11:10.37317	2018-08-20 14:52:42.632123	200.130.254.179	197.249.4.153	Qavy_YotJAAZZ-8Cyd8G	2018-08-15 11:59:46.805663	2018-08-15 07:18:14.825036	\N	f	Rogério	Muhate	2018-08-15 07:18:14.82411	2018-08-29 15:11:10.387196
21	cunoc@covenantuniversity.edu.ng	$2a$11$n1OYkjGT11Ybfeq641VOi.puvR.YJPOWtKQNRNH8mbriYuwInunXm	\N	\N	\N	4	2019-04-04 11:05:50.195022	2019-04-03 14:57:35.795412	165.73.192.12	41.203.76.252	_1CNz6KdPRn3sVmZ3s4A	2019-04-03 14:34:00.923369	2019-04-03 14:29:44.281756	\N	f	David	Afolayan	2019-04-03 14:29:44.271472	2019-04-04 11:05:50.240845
14	andriambelo.niry@gmail.com	$2a$11$Qw2hq3BHYHRZ4gYnusEP7.V8QUjyXbowDmorwRd.0naIxtg9TPwy6	\N	\N	\N	12	2018-11-30 11:56:14.8365	2018-11-30 06:35:37.654938	41.242.100.194	41.242.100.194	hoG8eMZiaUzLrghBou7m	2018-08-31 07:18:10.560401	2018-08-31 07:17:40.918091	\N	f	Niry	Andriambelo	2018-08-31 07:17:40.917574	2018-11-30 11:56:14.856754
9	pius.effiom@eko-konnect.org.ng	$2a$11$jMVHaDBeJSHwSKRO7T0HZO4Ao/VVbGFDRgMDKmbazK1vWEO1pe44m	\N	\N	\N	117	2021-03-05 07:35:04.171793	2021-03-03 09:14:49.091698	41.217.74.147	41.184.171.198	x1mN1vJHSW3KZ4dqGeqs	2018-08-27 09:00:36.785184	2018-08-27 09:00:02.620547	\N	f	Pius	Effiom	2018-08-27 09:00:02.619819	2021-03-05 07:35:04.173311
28	pcbako.traore@usttb.edu.ml	$2a$11$ZFlBeT97AATXvBwB8fusIep5J/tpDpng0HJeA0AFHziSlR5sjvVo2	\N	\N	2019-05-30 10:51:32.189805	1	2019-05-30 10:51:32.205529	2019-05-30 10:51:32.205529	197.155.154.65	197.155.154.65	mQKhz3kbM_L-h1zWu8ct	2019-05-30 10:51:01.630472	2019-05-30 10:50:14.242347	\N	f	Pierre Claver B	Traore	2019-05-30 10:50:14.242167	2019-05-30 10:51:32.209208
13	calebe.reis@rnp.br	$2a$11$zekzjIEIp6vQTjz21doF3eZbb/h9PlB/tqorPSqYY8IobGsMSh8jG	\N	\N	\N	3	2018-08-31 14:57:30.211709	2018-08-30 14:51:34.233126	200.130.78.33	200.130.78.33	TFHTtUUunYUTSTGNot48	2018-08-30 14:31:30.192452	2018-08-30 14:27:47.380782	\N	f	Calebe	Reis	2018-08-30 14:27:47.380175	2018-08-31 14:57:30.225803
32	kelly_brew@knust.edu.gh	$2a$11$1ysJXQm6u0FKmjuHsiRmJu5Q/afaO13qTx3OaSz.RQGMmxU0/UC82	\N	\N	\N	26	2021-04-29 11:13:41.976378	2020-11-10 16:41:30.336469	129.122.18.231	129.122.30.21	ULwiuDxmQTJ-cngsWgop	2019-08-06 07:19:00.231642	2019-08-06 07:18:31.510424	\N	f	Samuel Kelly 	Brew	2019-08-06 07:18:31.509861	2021-04-29 11:13:41.978032
31	ematogo@garnet.edu.gh	$2a$11$213T5NxGU4v4EXY5.xcOOeJixq9vW9CW/S8VpttmWBi88JAGODI0.	\N	\N	\N	46	2021-05-12 14:04:29.628547	2021-05-12 13:09:02.406681	197.255.118.148	197.255.118.148	GP9DvrXygRc3FVKsJgfY	2019-08-05 22:43:04.138421	2019-08-05 22:41:02.485867	\N	f	Emmanuel	Togo	2019-08-04 16:31:41.282447	2021-05-12 14:04:29.629968
16	roy.pangani@ubuntunet.net	$2a$11$tV6tQiUG.e9lCZIzIsgFzOvZkvPxG0QbFjTuFN2YifZfyMDMQxQ5.	\N	\N	\N	147	2020-08-13 11:24:49.502462	2020-07-15 08:35:58.14556	41.216.228.242	41.216.228.242	mb66nCS8TLxkS4by22Vg	2018-12-20 14:24:59.948367	2018-12-20 14:24:38.958437	\N	f	Roy	Pangani	2018-12-20 14:24:38.95733	2020-08-13 11:24:49.504269
27	cyahaya@agetic.gouv.ml	$2a$11$guxIRbrArq6IRBMANGB/U.gBBSUgJoa0gFEUioilxKCuMftnAkR2G	\N	\N	\N	4	2019-06-27 15:08:09.483332	2019-06-27 14:42:40.720795	196.10.216.30	217.64.102.81	TxgsMmgpPwUZFpExCFkY	2019-05-29 17:20:31.680048	2019-05-29 17:20:01.562282	\N	f	Yahaya	COULIBALY	2019-05-29 17:20:01.562093	2019-06-27 15:08:09.490481
11	aaadejumo@ngren.edu.ng	$2a$11$toeaXM1NEZ8wv/xDHU5ouOblUD0ljyMaI.j3iZMwCPDRwZaWj8216	\N	\N	\N	23	2020-05-18 11:36:36.416509	2020-03-17 15:43:18.322852	154.68.226.26	105.112.81.102	qSjJXTLQLNsvtJ4FvJzC	2018-08-27 11:24:08.681801	2018-08-27 11:23:34.531124	\N	f	Anthony	Adejumo	2018-08-27 11:23:34.530255	2020-05-18 11:36:36.420352
24	eletta.ao@unilorin.edu.ng	$2a$11$Z4GDcrvFkRixTNURe1thuuEqVzEqBF6qK0qTiPktj6D3TPG29wiMa	\N	\N	\N	2	2019-08-02 13:24:15.064638	2019-05-03 13:51:30.257445	197.211.32.243	197.211.32.243	4KLFqfb3RFszX1yvPx2H	2019-05-03 13:50:39.333047	2019-05-03 13:50:10.763138	\N	f	Adeola	Eletta	2019-05-03 13:50:10.762594	2019-08-02 13:24:15.070665
12	owen@eko-konnect.org.ng	$2a$11$WmOsa0/jOL2Z9EwB8E7G1u4GYJ/FDJoqgpm55ur81u6xoDO.xgjd2	\N	\N	\N	4	2019-05-09 12:23:49.249494	2019-03-29 10:24:32.123634	197.149.70.166	197.149.70.166	JBGA71qzbxW7b1ib3sN8	2018-08-27 12:00:29.217189	2018-08-27 11:59:39.194074	\N	f	Owen	Iyoha	2018-08-27 11:59:39.193484	2019-05-09 12:23:49.256441
2	hydra@gmx.ch	$2a$11$spiBJxteZzNS3rLSOh..0OmWs4u7jQ8rGkJMFPp7Rc/noWBYOrNnu	\N	\N	\N	17	2019-05-17 13:32:53.780989	2019-04-03 13:59:14.352248	41.216.228.242	41.216.228.242	hp6hykHNGsq_XSNtuNh2	2018-03-06 08:06:23.438911	2018-03-06 08:05:00.936826	\N	f	Ciao	Sepp	2018-03-06 08:05:00.93617	2019-05-17 13:32:53.784456
29	sidy@icermali.org	$2a$11$gyVSeuiQT8MMHIW2C0iEf.ExffWpjenMnhTr8LQDPmO2sf0gJFViG	\N	\N	2019-06-06 14:29:23.875646	1	2019-06-06 14:29:23.895151	2019-06-06 14:29:23.895151	196.200.54.106	196.200.54.106	U1JsybuuNkh_ZRFNFLWA	2019-06-06 14:29:12.308104	2019-06-06 14:28:33.776779	\N	f	sidy	soumare	2019-06-06 14:28:33.77635	2019-06-06 14:29:23.898479
1	chris.rohrer@ubuntunet.net	$2a$11$NdIE8aRwqIf1eM1NedI2ZeGVU0yMu6hS758X.BQDQ4wPGwgIQPuaK	\N	\N	\N	161	2020-09-07 15:18:31.768453	2020-09-07 13:51:05.899661	102.165.20.132	102.165.20.132	_Usyyd_yTzPfL8UCUoTd	2018-01-10 15:29:06.038415	2018-01-10 15:28:46.57577	\N	t	Chris	Rohrer	2018-01-10 15:28:46.575507	2020-09-07 15:18:31.770042
33	gmkissi@ug.edu.gh	$2a$11$.fKKwwkKuZTpYpJpnyW6QuTz9kCNk.2R2TGncbtvxcEQ5.7vwCuwi	\N	\N	\N	8	2019-08-09 07:45:43.656601	2019-08-08 14:46:01.834157	197.255.118.148	197.255.118.148	neUAztiUH9LY5oKJZwGo	2019-08-06 13:09:54.403117	2019-08-06 12:58:18.342981	\N	f	Georgette 	Kissi	2019-08-06 12:58:18.342124	2019-08-09 07:45:43.663079
23	fazeez@unilag.edu.ng	$2a$11$7y7ogakScvIPjLiV0jgF9O714Ma4H22Ty6Dx4wRuP0aOhmMe9DXIK	\N	\N	\N	11	2020-09-13 15:56:29.032234	2020-02-25 16:38:38.281693	196.220.240.201	105.112.50.39	s1DHSFUQA9pdstzmRMoE	2019-04-18 11:11:40.809462	2019-04-18 11:10:15.923367	\N	f	Faisal	Azeez	2019-04-18 11:10:15.922965	2020-09-13 15:56:29.033854
15	eloge.bapfunya@ub.edu.bi	$2a$11$di552rDLuSqXRN2jYg/bgupQCiNvwy/M3ohrqo2THhfmHkW1Hv2QW	\N	\N	2020-01-24 09:42:32.534507	6	2020-01-24 09:42:32.552483	2020-01-15 10:18:07.281759	154.117.217.140	154.119.7.3	eq611JoxTBcizzFct8TW	2018-11-22 09:32:10.24632	2018-11-22 09:24:49.619407	\N	f	Eloge	Bapfunya	2018-11-22 09:24:49.618645	2020-01-24 09:42:32.555848
20	anaobii@unijos.edu.ng	$2a$11$b1HtEKJwl2t/GNILdQMir.LT2RiFRquZ4WsaxL0gc4WXihH0l6yy.	\N	\N	\N	11	2019-09-04 09:06:27.820411	2019-09-04 08:03:39.852968	102.131.167.55	102.131.167.55	5TYtexFMmxk1tFAxGqnS	2019-04-03 08:22:38.188397	2019-04-03 08:21:03.536984	\N	f	Ishaku	Anaobi	2019-04-03 08:21:03.535821	2019-09-04 09:06:27.8274
19	ezeasor.ekene@unizik.edu.ng	$2a$11$luGxXTKujbrsOqSGOH3gM.xHEY0L9D1mI6ugkutDJe3rN89Qf2zu.	\N	\N	\N	16	2020-02-28 12:26:31.810366	2020-02-28 11:49:07.922168	197.210.226.184	197.210.227.229	XPz4vuccnt1UYqDH54tr	2019-02-28 10:06:57.209623	2019-02-28 10:06:33.319213	\N	f	Ekene	Ezeasor	2019-02-28 10:06:33.318797	2020-02-28 12:26:31.814796
4	kkayera@ternet.or.tz	$2a$11$0I204g9XNohqQRvaJ7t7NOWdeSAPBsfZ6t4N8vEdAmKR/MAqyLyD2	\N	\N	\N	24	2020-02-27 14:15:53.328667	2020-02-27 14:15:38.771359	196.249.68.130	196.249.68.130	2xYBKKVyzMbzvtxKMVyh	2018-04-11 06:20:55.114049	2018-04-11 06:20:02.976026	\N	f	Kilongi	Kayera	2018-04-11 06:20:02.966966	2020-02-27 14:15:53.332075
35	ayawson@ashesi.edu.gh	$2a$11$4/Tnv77KSoGWk41O4riOqeDSAFPkGwIEMoF4ced45ekbdiy9fWnT2	\N	\N	\N	1	2019-08-07 16:04:18.091072	2019-08-07 16:04:18.091072	41.189.179.165	41.189.179.165	p95GxbttjdEP5PNNTYY1	2019-08-07 16:02:30.099361	2019-08-07 16:02:05.899493	\N	f	Ato	Yawson	2019-08-07 16:02:05.898465	2019-08-07 16:04:18.09938
41	nigatu.nigusie@ethernet.edu.et	$2a$11$iSbu6ZPasKBi9uua7mmgTuVvI35lD7qLVV0MRdOwqD2x2Nm/V/swm	48af6966704f552c53a5902de834e20aa898c51cb5d4ac32bc56ad25e78a51dc	2020-10-30 11:38:57.326743	\N	71	2021-11-02 12:19:43.086494	2020-12-08 08:13:50.753413	213.55.77.138	213.55.77.138	Wo-qtVe91usbZcgn_FcL	2019-12-11 10:17:51.06556	2019-12-10 13:10:41.111972	\N	f	Nigatu	Nigusie	2019-12-10 13:10:41.111101	2021-11-02 12:19:43.088214
36	mabedalla56@gmail.com	$2a$11$RqsPz.o2dxGPENrDqWWHveeFkM.hFEIICTDqOGgAxxAguZt6.EFcS	\N	\N	2019-08-08 10:11:20.541999	1	2019-08-08 10:11:20.574524	2019-08-08 10:11:20.574524	62.149.118.150	62.149.118.150	nBkRPyrHXbimvjwNyhDH	2019-08-08 10:11:15.342748	2019-08-08 10:06:53.407334	\N	f	Mohamed	Abdulla	2019-08-08 10:06:53.406622	2019-08-08 10:11:20.577339
52	s.dindi@maren.ac.mw	$2a$11$PZVTWTY7As67de9ztPzoielapST.PLRlAiBV9EzBKqBnKTi/mAu4q	\N	\N	\N	12	2021-10-29 10:07:09.199567	2021-10-13 06:42:23.913486	41.70.44.170	41.70.98.15	yEp-zEXZDc4-9AeQRyLa	2021-04-07 11:58:24.345913	2021-04-07 11:57:42.988767	\N	f	Solomon	Dindi	2021-04-07 11:57:42.988619	2021-10-29 10:07:09.201047
44	alain.aina@wacren.net	$2a$11$qM6IwBKBOF7WcTiCT0qIr.O6D247GQ6qKvAz3Qa1Za/51CBMRU06O	\N	\N	\N	1	2020-05-12 13:11:09.974199	2020-05-12 13:11:09.974199	196.170.27.236	196.170.27.236	HXzc-zxM4tChXbCAQoCA	2020-05-12 13:11:04.100332	2020-05-12 13:10:40.227974	\N	f	Alain Patrick 	AINA	2020-05-12 13:10:40.2275	2020-05-12 13:11:09.978179
34	eric.attou@wacren.net	$2a$11$rc/1uw7uHYDrzxw1dVByCe437H./CerqKEi2ppSbxgb4WceVCGKLO	\N	\N	\N	91	2021-11-29 13:07:49.103043	2021-11-26 09:16:31.502791	196.216.191.17	41.216.47.106	iN9R8NaH19gHUsruo1UE	2019-08-07 10:21:51.667767	2019-08-07 10:21:25.975048	\N	t	Eric	ATTOU	2019-08-07 10:21:25.97474	2021-11-29 13:07:49.104497
38	kodion@gmail.com	$2a$11$TeQOJjigtNhT4lh9i1Q0OugJvFLWcprb6.JrbRPvoejeNNNmt9SWi	\N	\N	\N	1	2019-09-11 15:12:26.753229	2019-09-11 15:12:26.753229	105.112.66.197	105.112.66.197	WsoW1puGy3qzis-9ZVZp	2019-09-11 15:12:20.165756	2019-09-11 15:11:50.954997	\N	f	Omo	Oaiya	2019-09-11 15:11:50.954324	2019-09-11 15:12:51.772563
39	lloyd@rhsp.org	$2a$11$ONp1HK02xJViKWvyFcpYF.j6dghkTSK/wdunFiYBLgjZg.h4JHjTm	\N	\N	\N	2	2019-10-07 13:32:32.453214	2019-10-07 07:15:22.390759	196.43.137.4	196.43.137.4	ZABDyYzLbyzSkQzNKQtz	2019-10-07 07:15:18.813967	2019-10-07 06:55:04.711544	\N	f	lloyd	Ssentongo	2019-10-07 06:55:04.71028	2019-10-07 13:32:32.45998
40	modou.diouf@ucad.edu.sn	$2a$11$N9MIhQhh3FYttsQi46TI4.vROFqfL6lemqm8Kzuq00qgUYgVB8yoS	\N	\N	\N	0	\N	\N	\N	\N	7x2Lzxup3KBC757qqeJq	\N	2019-10-31 12:14:49.970089	\N	f	Modou	Diouf	2019-10-31 12:14:49.969409	2019-10-31 12:14:49.969409
43	eyobmulualem906@gmail.com	$2a$11$hEpjmZftmfDKQ.DvNk1B.ew0uHqunMhRlFyJQX4jfAcoRQ7I9/52y	\N	\N	\N	3	2020-03-12 11:41:23.367674	2020-03-09 07:07:14.927709	213.55.77.138	213.55.77.138	DsPxVK7V2sdDsmYvxGM8	2020-02-07 14:18:59.046859	2020-02-07 14:18:16.019025	\N	f	Eyob	Mulualem	2020-02-07 14:18:16.018692	2020-03-12 11:41:23.373226
42	eyob.mulualem@ethernet.edu.et	$2a$11$XI/EicIgxfEP/ykwf.2w.OWiNriVXmU5bddKAA0/X6kp0H98Zs1pC	\N	\N	\N	0	\N	\N	\N	\N	JTnwg8zAhg36wJPDV5xz	\N	2019-12-12 08:43:12.174264	\N	f	Eyob	Mulualem	2019-12-12 08:43:12.173456	2019-12-12 08:43:12.173456
45	nkokera@gmail.com	$2a$11$VYhYtCdTx0p6EGora5Rlo.vACchCYzhXzcMpTjJAzDEL2qltxNMsC	\N	\N	2020-06-04 14:53:56.379906	1	2020-06-04 14:53:56.398385	2020-06-04 14:53:56.398385	41.60.69.36	41.60.69.36	Y_qeMygJ6326LMMR1a_q	2020-06-04 14:53:49.919465	2020-06-04 14:52:41.572733	\N	f	Nyasha 	Kokera	2020-06-04 14:52:41.572006	2020-06-04 14:53:56.40129
22	abdulkadir.danmaigoro@udusok.edu.ng	$2a$11$PR6UCPVXW/ygMTANbi.RHOpiI0t.nVyXfID4b2C0oMXaZEd22sN8q	\N	\N	\N	12	2020-04-23 11:08:15.457248	2020-04-08 10:13:49.353254	41.78.224.55	41.78.224.55	JwYEsXezyvssgSTCic33	2019-04-04 10:42:50.786679	2019-04-04 10:42:08.254676	\N	f	Abdulkadir	Danmaigoro	2019-04-04 10:42:08.253872	2020-04-23 11:08:15.462588
57	eduroam@mubas.ac.mw	$2a$11$c8x0xrvImWDuTcNAO2xeBe0JrXDFKpvrL4gRPzi3CWHddbfl49CoG	\N	\N	\N	2	2021-06-22 10:04:55.197169	2021-06-22 10:00:33.312604	41.70.50.190	41.70.50.190	k3T_hsWqLWgL8ssv4pyS	2021-06-22 09:59:45.280215	2021-06-22 09:59:07.478351	\N	f	Malawi University of Business and 	Applied Science	2021-06-22 09:59:07.478209	2021-06-22 10:10:35.661996
49	fadhilishabanikadogholo@gmail.com	$2a$11$A/wzXZ/h6au4Si.lGOrMbuUAZ8PVcF/m99A3gRS7P3t52VzV0UBWO	\N	\N	\N	0	\N	\N	\N	\N	yw_VeDfZTG7ce8XKZQuX	\N	2020-11-03 05:27:16.922245	\N	f	fadhili	kadogholo	2020-11-03 05:27:16.92214	2020-11-03 05:27:16.92214
47	guy@tenet.ac.za	$2a$11$zXvvASgBzr5IbzSNr7NRw.IuPjJmVxnMTTc.w.xsk0fBRblSghaS.	67808171274ef233c6490c77f8d89f387ddd6977932b36cca89e7a1396f47025	2020-11-24 07:02:31.79807	\N	0	\N	\N	\N	\N	6BpQi2H3z5-syyvzcx3S	\N	2020-09-07 08:36:37.184045	\N	f	Guy	Halse	2020-09-07 08:36:37.183777	2020-11-24 07:02:31.798917
46	nosiku.sikanyika@ubuntunet.net	$2a$11$jFOucxLCGxsZ/.fWBxC8we0IgpB9BMMmJxqnH0KVVk8gpx2pdwSDS	\N	\N	\N	29	2021-04-06 11:06:59.415294	2021-04-06 09:57:59.832282	137.63.159.150	137.63.159.150	KgtErLkAUmJT1bxrz5wq	2020-09-07 14:51:32.289747	2020-08-13 13:43:46.108448	\N	f	nosiku 	sikanyika	2020-08-13 13:43:46.108227	2021-04-06 11:06:59.416779
51	sami@marwan.ma	$2a$11$ilH95K7cu6WdNb1UnMBFgudHqo4IkiLFkdE0gtCawZ6esHOazwZ/C	\N	\N	\N	0	\N	\N	\N	\N	dTLfg71FfqtUMzi2tsL8	\N	2021-02-15 08:03:44.773903	\N	f	Sami	Ait Ali Oulahcen	2021-02-15 08:03:44.773765	2021-02-15 08:03:44.773765
53	tiwonge.banda@ubuntunet.net	$2a$11$0NxZp2WdeleUUkbvixD1seaIZN6Kr01bt2B736SKvAkbL5nhGYGMC	\N	\N	\N	1	2021-04-07 12:08:42.45808	2021-04-07 12:08:42.45808	41.216.228.242	41.216.228.242	VZuYtzRsfuUzQCZUmNxH	2021-04-07 12:08:39.436707	2021-04-07 12:06:27.737525	\N	f	Tiwonge	Banda	2021-04-07 12:06:27.737414	2021-04-07 12:08:42.459694
56	bnyirongo@cc.ac.mw	$2a$11$sA3/yyklrgKT/kRcxVRRKeVUWjQ78PhNTLK52xdLWAtNm4EaOrjoS	\N	\N	\N	15	2021-07-12 13:54:53.993522	2021-07-02 13:13:47.092484	41.70.33.9	41.70.33.9	2nmirUnoZsrb438CD-z4	2021-06-21 14:21:27.486085	2021-06-21 14:21:08.986871	\N	f	Bridget 	Nyirongo	2021-06-21 14:21:08.986704	2021-07-12 13:54:53.995128
60	ssiyanimbuto@cc.ac.mw	$2a$11$ae2.WdhTGcTT5ecdz7.nregL3s1wZgFZwYK34YRcmiZrx9EmtjJBm	\N	\N	\N	6	2021-06-25 14:56:57.63712	2021-06-25 12:28:13.60116	41.70.33.28	41.70.33.28	QKdWhy--22psDe_scg8U	2021-06-22 17:44:15.995271	2021-06-22 17:43:52.722453	\N	f	Stonald	Siyanimbuto	2021-06-22 17:43:52.722359	2021-06-25 14:56:57.638648
55	hillary.chituwu@liquidtelecom.com	$2a$11$DyRpre4Y8WDUpU17QBCKh.BOMesjNDe7xNeK7T.erR.cBjULbV57q	\N	\N	\N	2	2021-05-20 12:20:28.7261	2021-05-20 11:01:58.821472	196.27.103.254	196.27.103.254	x4hZpxTzgg95owHDsys5	2021-05-20 11:01:54.862676	2021-05-20 10:59:37.203294	\N	f	Hillary	Chituwu	2021-05-20 10:59:37.203187	2021-05-20 12:20:28.727686
37	igbap@unijos.edu.ng	$2a$11$jW48dBaY/HAyocBrV0B7RuqbZoWH7Yz5y3zx3tS7a.ZDVFs69cTdC	\N	\N	\N	13	2021-04-15 12:53:54.505325	2021-04-15 12:36:41.448977	197.210.179.234	154.68.226.14	L5cV7Cwo3KVHLjbxMnkr	2019-09-04 09:01:46.997904	2019-09-04 08:52:30.332404	\N	f	Priscillia	Igba	2019-09-04 08:52:30.331808	2021-04-15 12:53:54.50696
63	z.chimombo@maren.ac.mw	$2a$11$tMoEinquNoncGElriPqis.3Iw2tTtqZbUrpqCErsjFGoLhk5PyN.a	\N	\N	2021-10-12 14:04:16.447188	3	2021-10-19 14:44:22.268116	2021-10-12 14:04:16.452	102.70.49.100	102.70.3.210	QVfisudYczcYAHi-JZ3J	2021-10-12 11:36:10.196441	2021-10-12 11:35:44.781193	\N	f	Zanga	Chimombo	2021-10-12 11:35:44.781065	2021-10-19 14:44:22.269475
59	mngalande@cc.ac.mw	$2a$11$pHY1wAeZwq2MUDjkCKt7IOT85t5kcvHsHVPHxUGkBTbtvqwHavIsq	\N	\N	\N	11	2021-07-16 09:38:51.935907	2021-07-16 08:54:38.589649	41.70.33.21	41.70.33.21	Wjys4hAS8XfCns2fX_Ex	2021-06-22 17:43:57.591533	2021-06-22 17:43:31.644478	\N	f	Martin	Ngalande	2021-06-22 17:43:31.644377	2021-07-16 09:38:51.937532
58	dchiphazi@cc.ac.mw	$2a$11$OmdPGQJQiorZRvnACzn47.IiHvC/ZVzMTOYUORO2DH9R51ccHJj3K	\N	\N	\N	31	2021-07-21 09:57:53.77514	2021-07-21 08:00:15.629251	41.70.44.216	41.70.44.28	TPbbGqUc3yRkAHvbBwhb	2021-06-22 17:33:06.880146	2021-06-22 17:30:01.287678	\N	f	Daniel	Chiphazi	2021-06-22 17:30:01.287534	2021-07-21 09:57:53.77664
61	eduroam@mlw.mw	$2a$11$7WhA7ITNmhB6MvVO4hyaHOKjoHEikhwYTGjyG1O4tOsHaDK0D9926	\N	\N	\N	0	\N	\N	\N	\N	jHzHQdDrcXs9WwaJ6iim	\N	2021-09-29 08:33:57.289312	\N	f	Malawi Liverpool Wellcome Trust	Eduroam MLW	2021-09-29 08:33:57.289147	2021-09-29 08:33:57.289147
54	mohammed.ali@somaliren.org	$2a$11$WnmaSKxRePMHVbk16FAMqeNAc/apXbsyCYl29ZTwDO7tYQ/rwK006	\N	\N	2021-09-06 08:35:21.199378	4	2021-09-06 08:35:21.203485	2021-06-14 12:56:17.694597	154.73.27.2	154.73.27.2	fCaCEs6NP4KixZyL9xSz	2021-04-12 15:33:39.496191	2021-04-12 15:31:42.840467	\N	f	Mohamed Ali	Ahmed	2021-04-12 15:31:42.840331	2021-09-06 08:35:21.204299
10	omo.oaiya@wacren.net	$2a$11$OjRpiASjaFnrxSgIslJC1.uFBYClU/rCPXFgRMHUOJq1WUID7fuz2	\N	\N	2021-04-22 17:56:34.236915	78	2021-10-21 15:36:28.891183	2021-06-10 15:55:47.405326	41.207.188.2	82.32.240.127	zswWroi5F5hEr_ZXRAmc	2018-08-27 10:31:17.963884	2018-08-27 10:30:53.964435	\N	t	Omo	Oaiya	2018-08-27 10:30:53.963655	2021-10-21 15:36:28.892597
48	fkadogholo@ternet.or.tz	$2a$11$eGyMof2uZq1Vz424qFhjTeNJBHHsiGUuAm2XaHbjJET4l.Utxenku	\N	\N	\N	1	2021-10-22 06:11:34.118994	2021-10-22 06:11:34.118994	41.93.53.5	41.93.53.5	o-HPAH2_Nr9_2czn5mye	2021-10-22 06:11:20.397286	2020-11-02 12:24:00.190744	\N	f	Fadhili	Kadogholo	2020-11-02 12:24:00.190612	2021-10-22 06:11:34.120358
62	sibrahim@mlw.mw	$2a$11$oAQUvCMul90wm9oz4rrdhOEPGiWt0Bv8EEXjvjvrmXtdMs1YbI9K.	\N	\N	\N	12	2021-10-20 07:18:46.914962	2021-10-14 10:22:59.400351	41.77.11.187	41.70.97.1	zy4gBjJTnS4Bb9_PGt5c	2021-09-30 14:40:39.915313	2021-09-30 14:37:50.874843	\N	f	Samad	Ibrahim	2021-09-30 14:37:50.874664	2021-10-20 07:18:46.916908
50	alex.mwotil@ubuntunet.net	$2a$11$zJZe.Aed3WkuCVkLSzTh6O/1.yxIp.7YPnkqdLHKhb4XdtSakxWFa	5c1bd16d6a5bc4ce58ecf03c19a1fee26e4df04ae9070e5e29f7723d3e3ebf99	2021-10-22 10:56:26.880835	\N	43	2021-11-29 12:03:43.063654	2021-11-29 09:26:11.190165	102.34.0.249	102.34.0.249	hgx-AHMX8yGabaj2z-ei	2021-04-06 10:00:51.846389	2021-04-06 10:00:15.482895	\N	t	Alex	Mwotil	2020-11-26 07:58:51.056936	2021-11-29 12:03:43.065223
64	nasser.ssessaazi@ubuntunet.net	$2a$11$0n.X8AOptyte50fsGqPq3Oa8hOupUeqssqHzE8omJZQ6LeUi.U5R2	\N	\N	\N	4	2021-12-09 11:24:53.684242	2021-12-09 09:28:19.63358	41.210.147.203	41.210.147.203	9SKNA1ukxazGAGZAHmEZ	2021-10-22 12:47:57.072359	2021-10-22 06:28:27.359366	\N	f	nasser	ssessaazi	2021-10-22 06:28:27.359248	2021-12-09 11:24:53.685684
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: switchboarder
--

SELECT pg_catalog.setval('public.users_id_seq', 64, true);


--
-- Name: addresses addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: switchboarder
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: switchboarder
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: confederations confederations_pkey; Type: CONSTRAINT; Schema: public; Owner: switchboarder
--

ALTER TABLE ONLY public.confederations
    ADD CONSTRAINT confederations_pkey PRIMARY KEY (id);


--
-- Name: contacts contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: switchboarder
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: equipment equipment_pkey; Type: CONSTRAINT; Schema: public; Owner: switchboarder
--

ALTER TABLE ONLY public.equipment
    ADD CONSTRAINT equipment_pkey PRIMARY KEY (id);


--
-- Name: federations federations_pkey; Type: CONSTRAINT; Schema: public; Owner: switchboarder
--

ALTER TABLE ONLY public.federations
    ADD CONSTRAINT federations_pkey PRIMARY KEY (id);


--
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: switchboarder
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: memberships memberships_pkey; Type: CONSTRAINT; Schema: public; Owner: switchboarder
--

ALTER TABLE ONLY public.memberships
    ADD CONSTRAINT memberships_pkey PRIMARY KEY (id);


--
-- Name: organisations organisations_pkey; Type: CONSTRAINT; Schema: public; Owner: switchboarder
--

ALTER TABLE ONLY public.organisations
    ADD CONSTRAINT organisations_pkey PRIMARY KEY (id);


--
-- Name: radius_servers radius_servers_pkey; Type: CONSTRAINT; Schema: public; Owner: switchboarder
--

ALTER TABLE ONLY public.radius_servers
    ADD CONSTRAINT radius_servers_pkey PRIMARY KEY (id);


--
-- Name: realms realms_pkey; Type: CONSTRAINT; Schema: public; Owner: switchboarder
--

ALTER TABLE ONLY public.realms
    ADD CONSTRAINT realms_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: switchboarder
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: switchboarder
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_addresses_on_addressable_type_and_addressable_id; Type: INDEX; Schema: public; Owner: switchboarder
--

CREATE INDEX index_addresses_on_addressable_type_and_addressable_id ON public.addresses USING btree (addressable_type, addressable_id);


--
-- Name: index_confederations_on_operator_id; Type: INDEX; Schema: public; Owner: switchboarder
--

CREATE INDEX index_confederations_on_operator_id ON public.confederations USING btree (operator_id);


--
-- Name: index_contacts_on_contactable_type_and_contactable_id; Type: INDEX; Schema: public; Owner: switchboarder
--

CREATE INDEX index_contacts_on_contactable_type_and_contactable_id ON public.contacts USING btree (contactable_type, contactable_id);


--
-- Name: index_equipment_on_location_id; Type: INDEX; Schema: public; Owner: switchboarder
--

CREATE INDEX index_equipment_on_location_id ON public.equipment USING btree (location_id);


--
-- Name: index_federations_on_confederation_id; Type: INDEX; Schema: public; Owner: switchboarder
--

CREATE INDEX index_federations_on_confederation_id ON public.federations USING btree (confederation_id);


--
-- Name: index_federations_on_operator_id; Type: INDEX; Schema: public; Owner: switchboarder
--

CREATE INDEX index_federations_on_operator_id ON public.federations USING btree (operator_id);


--
-- Name: index_locations_on_address_id; Type: INDEX; Schema: public; Owner: switchboarder
--

CREATE INDEX index_locations_on_address_id ON public.locations USING btree (address_id);


--
-- Name: index_locations_on_contacts_id; Type: INDEX; Schema: public; Owner: switchboarder
--

CREATE INDEX index_locations_on_contacts_id ON public.locations USING btree (contacts_id);


--
-- Name: index_locations_on_organisation_id; Type: INDEX; Schema: public; Owner: switchboarder
--

CREATE INDEX index_locations_on_organisation_id ON public.locations USING btree (organisation_id);


--
-- Name: index_memberships_on_organisation_id; Type: INDEX; Schema: public; Owner: switchboarder
--

CREATE INDEX index_memberships_on_organisation_id ON public.memberships USING btree (organisation_id);


--
-- Name: index_memberships_on_user_id; Type: INDEX; Schema: public; Owner: switchboarder
--

CREATE INDEX index_memberships_on_user_id ON public.memberships USING btree (user_id);


--
-- Name: index_organisations_on_federation_id; Type: INDEX; Schema: public; Owner: switchboarder
--

CREATE INDEX index_organisations_on_federation_id ON public.organisations USING btree (federation_id);


--
-- Name: index_radius_servers_on_radiusable_type_and_radiusable_id; Type: INDEX; Schema: public; Owner: switchboarder
--

CREATE INDEX index_radius_servers_on_radiusable_type_and_radiusable_id ON public.radius_servers USING btree (radiusable_type, radiusable_id);


--
-- Name: index_realms_on_organisation_id; Type: INDEX; Schema: public; Owner: switchboarder
--

CREATE INDEX index_realms_on_organisation_id ON public.realms USING btree (organisation_id);


--
-- Name: index_users_on_confirmation_token; Type: INDEX; Schema: public; Owner: switchboarder
--

CREATE UNIQUE INDEX index_users_on_confirmation_token ON public.users USING btree (confirmation_token);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: switchboarder
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: switchboarder
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: memberships fk_rails_023b8c2508; Type: FK CONSTRAINT; Schema: public; Owner: switchboarder
--

ALTER TABLE ONLY public.memberships
    ADD CONSTRAINT fk_rails_023b8c2508 FOREIGN KEY (organisation_id) REFERENCES public.organisations(id);


--
-- Name: realms fk_rails_49cdb86653; Type: FK CONSTRAINT; Schema: public; Owner: switchboarder
--

ALTER TABLE ONLY public.realms
    ADD CONSTRAINT fk_rails_49cdb86653 FOREIGN KEY (organisation_id) REFERENCES public.organisations(id);


--
-- Name: locations fk_rails_578138d58c; Type: FK CONSTRAINT; Schema: public; Owner: switchboarder
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT fk_rails_578138d58c FOREIGN KEY (contacts_id) REFERENCES public.contacts(id);


--
-- Name: federations fk_rails_7ff39eba2d; Type: FK CONSTRAINT; Schema: public; Owner: switchboarder
--

ALTER TABLE ONLY public.federations
    ADD CONSTRAINT fk_rails_7ff39eba2d FOREIGN KEY (confederation_id) REFERENCES public.confederations(id);


--
-- Name: locations fk_rails_8f6b1eb5eb; Type: FK CONSTRAINT; Schema: public; Owner: switchboarder
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT fk_rails_8f6b1eb5eb FOREIGN KEY (organisation_id) REFERENCES public.organisations(id);


--
-- Name: memberships fk_rails_99326fb65d; Type: FK CONSTRAINT; Schema: public; Owner: switchboarder
--

ALTER TABLE ONLY public.memberships
    ADD CONSTRAINT fk_rails_99326fb65d FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: equipment fk_rails_a354984e53; Type: FK CONSTRAINT; Schema: public; Owner: switchboarder
--

ALTER TABLE ONLY public.equipment
    ADD CONSTRAINT fk_rails_a354984e53 FOREIGN KEY (location_id) REFERENCES public.locations(id);


--
-- Name: federations fk_rails_b30ee0aeb4; Type: FK CONSTRAINT; Schema: public; Owner: switchboarder
--

ALTER TABLE ONLY public.federations
    ADD CONSTRAINT fk_rails_b30ee0aeb4 FOREIGN KEY (operator_id) REFERENCES public.organisations(id);


--
-- Name: confederations fk_rails_e011daadd8; Type: FK CONSTRAINT; Schema: public; Owner: switchboarder
--

ALTER TABLE ONLY public.confederations
    ADD CONSTRAINT fk_rails_e011daadd8 FOREIGN KEY (operator_id) REFERENCES public.organisations(id);


--
-- Name: locations fk_rails_fd0acb3830; Type: FK CONSTRAINT; Schema: public; Owner: switchboarder
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT fk_rails_fd0acb3830 FOREIGN KEY (address_id) REFERENCES public.addresses(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

