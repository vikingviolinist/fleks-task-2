--
-- PostgreSQL database dump
--

-- Dumped from database version 10.x
-- Dumped by pg_dump version 10.x

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
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


CREATE TYPE public."enum_Plans_lockBehaviour" AS ENUM (
    'none',
    'locked',
    'upgrade'
);


--
-- Name: enum_Plans_market; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."enum_Plans_market" AS ENUM (
    'private',
    'business'
);


--
-- Name: enum_Plans_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."enum_Plans_type" AS ENUM (
    'recurring',
    'metered'
);



SET default_tablespace = '';

SET default_with_oids = false;


--
-- Name: Plans; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Plans" (
    id integer NOT NULL,
    name character varying(255),
    alias character varying(255),
    description text,
    price integer,
    type public."enum_Plans_type",
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    "sortOrder" integer,
    "maxDistance" integer DEFAULT '-1'::integer,
    "archivedAt" timestamp with time zone,
    market public."enum_Plans_market" DEFAULT 'private'::public."enum_Plans_market" NOT NULL
);


--
-- Name: Plans_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Plans_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Plans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Plans_id_seq" OWNED BY public."Plans".id;


--
-- Name: SequelizeMeta; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."SequelizeMeta" (
    name character varying(255) NOT NULL
);

--
-- Name: SubscriptionPeriods; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."SubscriptionPeriods" (
    id integer NOT NULL,
    "periodFrom" timestamp with time zone NOT NULL,
    "periodTo" timestamp with time zone NOT NULL,
    distance integer,
    fuel integer,
    paid boolean,
    "subscriptionId" integer NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    "lastSynced" timestamp with time zone DEFAULT now(),
    "paidUsage" boolean DEFAULT false
);


--
-- Name: SubscriptionPeriods_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."SubscriptionPeriods_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: SubscriptionPeriods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."SubscriptionPeriods_id_seq" OWNED BY public."SubscriptionPeriods".id;


--
-- Name: SubscriptionPlans; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."SubscriptionPlans" (
    id integer NOT NULL,
    "subscriptionId" integer NOT NULL,
    "planId" integer NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    "startedAt" timestamp with time zone NOT NULL,
    "endedAt" timestamp with time zone
);


--
-- Name: SubscriptionPlans_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."SubscriptionPlans_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: SubscriptionPlans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."SubscriptionPlans_id_seq" OWNED BY public."SubscriptionPlans".id;

--
-- Name: SubscriptionVehicles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."SubscriptionVehicles" (
    id integer NOT NULL,
    "subscriptionId" integer NOT NULL,
    "vehicleId" integer NOT NULL,
    "startedAt" timestamp with time zone NOT NULL,
    "endedAt" timestamp with time zone,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone
);


--
-- Name: SubscriptionVehicles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."SubscriptionVehicles_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: SubscriptionVehicles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."SubscriptionVehicles_id_seq" OWNED BY public."SubscriptionVehicles".id;


--
-- Name: Subscriptions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Subscriptions" (
    id integer NOT NULL,
    "userId" integer NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    "cancellationDate" timestamp with time zone
);


--
-- Name: Subscriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Subscriptions_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Subscriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Subscriptions_id_seq" OWNED BY public."Subscriptions".id;


--
-- Name: Plans id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Plans" ALTER COLUMN id SET DEFAULT nextval('public."Plans_id_seq"'::regclass);


--
-- Name: SubscriptionPeriods id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."SubscriptionPeriods" ALTER COLUMN id SET DEFAULT nextval('public."SubscriptionPeriods_id_seq"'::regclass);


--
-- Name: SubscriptionPlans id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."SubscriptionPlans" ALTER COLUMN id SET DEFAULT nextval('public."SubscriptionPlans_id_seq"'::regclass);


--
-- Name: SubscriptionVehicles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."SubscriptionVehicles" ALTER COLUMN id SET DEFAULT nextval('public."SubscriptionVehicles_id_seq"'::regclass);


--
-- Name: Subscriptions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Subscriptions" ALTER COLUMN id SET DEFAULT nextval('public."Subscriptions_id_seq"'::regclass);


--
-- Name: Plans Plans_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Plans"
    ADD CONSTRAINT "Plans_pkey" PRIMARY KEY (id);


--
-- Name: SequelizeMeta SequelizeMeta_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."SequelizeMeta"
    ADD CONSTRAINT "SequelizeMeta_pkey" PRIMARY KEY (name);


--
-- Name: SubscriptionPeriods SubscriptionPeriods_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."SubscriptionPeriods"
    ADD CONSTRAINT "SubscriptionPeriods_pkey" PRIMARY KEY (id);


--
-- Name: SubscriptionPlans SubscriptionPlans_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."SubscriptionPlans"
    ADD CONSTRAINT "SubscriptionPlans_pkey" PRIMARY KEY (id);


--
-- Name: SubscriptionVehicles SubscriptionVehicles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."SubscriptionVehicles"
    ADD CONSTRAINT "SubscriptionVehicles_pkey" PRIMARY KEY (id);


--
-- Name: Subscriptions Subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Subscriptions"
    ADD CONSTRAINT "Subscriptions_pkey" PRIMARY KEY (id);


--
-- Name: subscription_periods_subscription_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX subscription_periods_subscription_id ON public."SubscriptionPeriods" USING btree ("subscriptionId");


--
-- Name: subscription_plans_plan_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX subscription_plans_plan_id ON public."SubscriptionPlans" USING btree ("planId");


--
-- Name: subscription_plans_subscription_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX subscription_plans_subscription_id ON public."SubscriptionPlans" USING btree ("subscriptionId");


--
-- Name: subscription_vehicles_ended_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX subscription_vehicles_ended_at ON public."SubscriptionVehicles" USING btree ("endedAt");


--
-- Name: subscription_vehicles_started_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX subscription_vehicles_started_at ON public."SubscriptionVehicles" USING btree ("startedAt");


--
-- Name: subscription_vehicles_subscription_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX subscription_vehicles_subscription_id ON public."SubscriptionVehicles" USING btree ("subscriptionId");


--
-- Name: subscription_vehicles_vehicle_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX subscription_vehicles_vehicle_id ON public."SubscriptionVehicles" USING btree ("vehicleId");


--
-- Name: SubscriptionPeriods SubscriptionPeriods_subscriptionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."SubscriptionPeriods"
    ADD CONSTRAINT "SubscriptionPeriods_subscriptionId_fkey" FOREIGN KEY ("subscriptionId") REFERENCES public."Subscriptions"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SubscriptionPlans SubscriptionPlans_planId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."SubscriptionPlans"
    ADD CONSTRAINT "SubscriptionPlans_planId_fkey" FOREIGN KEY ("planId") REFERENCES public."Plans"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SubscriptionPlans SubscriptionPlans_subscriptionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."SubscriptionPlans"
    ADD CONSTRAINT "SubscriptionPlans_subscriptionId_fkey" FOREIGN KEY ("subscriptionId") REFERENCES public."Subscriptions"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SubscriptionVehicles SubscriptionVehicles_subscriptionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."SubscriptionVehicles"
    ADD CONSTRAINT "SubscriptionVehicles_subscriptionId_fkey" FOREIGN KEY ("subscriptionId") REFERENCES public."Subscriptions"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

