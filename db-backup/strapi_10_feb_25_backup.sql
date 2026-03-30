--
-- PostgreSQL database dump
--

-- Dumped from database version 15.9 (Homebrew)
-- Dumped by pg_dump version 15.9 (Homebrew)

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
-- Name: admin_permissions; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.admin_permissions (
    id integer NOT NULL,
    document_id character varying(255),
    action character varying(255),
    action_parameters jsonb,
    subject character varying(255),
    properties jsonb,
    conditions jsonb,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.admin_permissions OWNER TO root;

--
-- Name: admin_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.admin_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admin_permissions_id_seq OWNER TO root;

--
-- Name: admin_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.admin_permissions_id_seq OWNED BY public.admin_permissions.id;


--
-- Name: admin_permissions_role_lnk; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.admin_permissions_role_lnk (
    id integer NOT NULL,
    permission_id integer,
    role_id integer,
    permission_ord double precision
);


ALTER TABLE public.admin_permissions_role_lnk OWNER TO root;

--
-- Name: admin_permissions_role_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.admin_permissions_role_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admin_permissions_role_lnk_id_seq OWNER TO root;

--
-- Name: admin_permissions_role_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.admin_permissions_role_lnk_id_seq OWNED BY public.admin_permissions_role_lnk.id;


--
-- Name: admin_roles; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.admin_roles (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    code character varying(255),
    description character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.admin_roles OWNER TO root;

--
-- Name: admin_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.admin_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admin_roles_id_seq OWNER TO root;

--
-- Name: admin_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.admin_roles_id_seq OWNED BY public.admin_roles.id;


--
-- Name: admin_users; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.admin_users (
    id integer NOT NULL,
    document_id character varying(255),
    firstname character varying(255),
    lastname character varying(255),
    username character varying(255),
    email character varying(255),
    password character varying(255),
    reset_password_token character varying(255),
    registration_token character varying(255),
    is_active boolean,
    blocked boolean,
    prefered_language character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.admin_users OWNER TO root;

--
-- Name: admin_users_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.admin_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admin_users_id_seq OWNER TO root;

--
-- Name: admin_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.admin_users_id_seq OWNED BY public.admin_users.id;


--
-- Name: admin_users_roles_lnk; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.admin_users_roles_lnk (
    id integer NOT NULL,
    user_id integer,
    role_id integer,
    role_ord double precision,
    user_ord double precision
);


ALTER TABLE public.admin_users_roles_lnk OWNER TO root;

--
-- Name: admin_users_roles_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.admin_users_roles_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admin_users_roles_lnk_id_seq OWNER TO root;

--
-- Name: admin_users_roles_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.admin_users_roles_lnk_id_seq OWNED BY public.admin_users_roles_lnk.id;


--
-- Name: bids; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.bids (
    id integer NOT NULL,
    document_id character varying(255),
    amount numeric(10,2),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.bids OWNER TO root;

--
-- Name: bids_biduser_lnk; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.bids_biduser_lnk (
    id integer NOT NULL,
    bid_id integer,
    biduser_id integer,
    bid_ord double precision
);


ALTER TABLE public.bids_biduser_lnk OWNER TO root;

--
-- Name: bids_biduser_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.bids_biduser_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bids_biduser_lnk_id_seq OWNER TO root;

--
-- Name: bids_biduser_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.bids_biduser_lnk_id_seq OWNED BY public.bids_biduser_lnk.id;


--
-- Name: bids_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.bids_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bids_id_seq OWNER TO root;

--
-- Name: bids_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.bids_id_seq OWNED BY public.bids.id;


--
-- Name: bids_product_lnk; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.bids_product_lnk (
    id integer NOT NULL,
    bid_id integer,
    product_id integer,
    bid_ord double precision
);


ALTER TABLE public.bids_product_lnk OWNER TO root;

--
-- Name: bids_product_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.bids_product_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bids_product_lnk_id_seq OWNER TO root;

--
-- Name: bids_product_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.bids_product_lnk_id_seq OWNED BY public.bids_product_lnk.id;


--
-- Name: bidusers; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.bidusers (
    id integer NOT NULL,
    document_id character varying(255),
    email character varying(255),
    name character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255),
    active boolean
);


ALTER TABLE public.bidusers OWNER TO root;

--
-- Name: bidusers_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.bidusers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bidusers_id_seq OWNER TO root;

--
-- Name: bidusers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.bidusers_id_seq OWNED BY public.bidusers.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    document_id character varying(255),
    category_name character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255),
    slug character varying(255)
);


ALTER TABLE public.categories OWNER TO root;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO root;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: files; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.files (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    alternative_text character varying(255),
    caption character varying(255),
    width integer,
    height integer,
    formats jsonb,
    hash character varying(255),
    ext character varying(255),
    mime character varying(255),
    size numeric(10,2),
    url character varying(255),
    preview_url character varying(255),
    provider character varying(255),
    provider_metadata jsonb,
    folder_path character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.files OWNER TO root;

--
-- Name: files_folder_lnk; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.files_folder_lnk (
    id integer NOT NULL,
    file_id integer,
    folder_id integer,
    file_ord double precision
);


ALTER TABLE public.files_folder_lnk OWNER TO root;

--
-- Name: files_folder_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.files_folder_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.files_folder_lnk_id_seq OWNER TO root;

--
-- Name: files_folder_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.files_folder_lnk_id_seq OWNED BY public.files_folder_lnk.id;


--
-- Name: files_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.files_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.files_id_seq OWNER TO root;

--
-- Name: files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.files_id_seq OWNED BY public.files.id;


--
-- Name: files_related_mph; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.files_related_mph (
    id integer NOT NULL,
    file_id integer,
    related_id integer,
    related_type character varying(255),
    field character varying(255),
    "order" double precision
);


ALTER TABLE public.files_related_mph OWNER TO root;

--
-- Name: files_related_mph_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.files_related_mph_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.files_related_mph_id_seq OWNER TO root;

--
-- Name: files_related_mph_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.files_related_mph_id_seq OWNED BY public.files_related_mph.id;


--
-- Name: i18n_locale; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.i18n_locale (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    code character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.i18n_locale OWNER TO root;

--
-- Name: i18n_locale_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.i18n_locale_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.i18n_locale_id_seq OWNER TO root;

--
-- Name: i18n_locale_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.i18n_locale_id_seq OWNED BY public.i18n_locale.id;


--
-- Name: lottery_users; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.lottery_users (
    id integer NOT NULL,
    document_id character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.lottery_users OWNER TO root;

--
-- Name: lottery_users_biduser_lnk; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.lottery_users_biduser_lnk (
    id integer NOT NULL,
    lottery_user_id integer,
    biduser_id integer,
    lottery_user_ord double precision
);


ALTER TABLE public.lottery_users_biduser_lnk OWNER TO root;

--
-- Name: lottery_users_biduser_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.lottery_users_biduser_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lottery_users_biduser_lnk_id_seq OWNER TO root;

--
-- Name: lottery_users_biduser_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.lottery_users_biduser_lnk_id_seq OWNED BY public.lottery_users_biduser_lnk.id;


--
-- Name: lottery_users_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.lottery_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lottery_users_id_seq OWNER TO root;

--
-- Name: lottery_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.lottery_users_id_seq OWNED BY public.lottery_users.id;


--
-- Name: lottery_users_products_lnk; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.lottery_users_products_lnk (
    id integer NOT NULL,
    lottery_user_id integer,
    product_id integer,
    lottery_user_ord double precision,
    product_ord double precision
);


ALTER TABLE public.lottery_users_products_lnk OWNER TO root;

--
-- Name: lottery_users_products_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.lottery_users_products_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lottery_users_products_lnk_id_seq OWNER TO root;

--
-- Name: lottery_users_products_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.lottery_users_products_lnk_id_seq OWNED BY public.lottery_users_products_lnk.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.products (
    id integer NOT NULL,
    document_id character varying(255),
    title character varying(255),
    description text,
    price numeric(10,2),
    ending_date timestamp(6) without time zone,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255),
    lottery_product boolean,
    lottery_winner character varying(255),
    manual_lottery boolean
);


ALTER TABLE public.products OWNER TO root;

--
-- Name: products_biduser_lnk; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.products_biduser_lnk (
    id integer NOT NULL,
    product_id integer,
    biduser_id integer,
    product_ord double precision
);


ALTER TABLE public.products_biduser_lnk OWNER TO root;

--
-- Name: products_biduser_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.products_biduser_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_biduser_lnk_id_seq OWNER TO root;

--
-- Name: products_biduser_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.products_biduser_lnk_id_seq OWNED BY public.products_biduser_lnk.id;


--
-- Name: products_categories_lnk; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.products_categories_lnk (
    id integer NOT NULL,
    product_id integer,
    category_id integer,
    category_ord double precision
);


ALTER TABLE public.products_categories_lnk OWNER TO root;

--
-- Name: products_categories_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.products_categories_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_categories_lnk_id_seq OWNER TO root;

--
-- Name: products_categories_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.products_categories_lnk_id_seq OWNED BY public.products_categories_lnk.id;


--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_id_seq OWNER TO root;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: strapi_api_token_permissions; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.strapi_api_token_permissions (
    id integer NOT NULL,
    document_id character varying(255),
    action character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.strapi_api_token_permissions OWNER TO root;

--
-- Name: strapi_api_token_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.strapi_api_token_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_api_token_permissions_id_seq OWNER TO root;

--
-- Name: strapi_api_token_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.strapi_api_token_permissions_id_seq OWNED BY public.strapi_api_token_permissions.id;


--
-- Name: strapi_api_token_permissions_token_lnk; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.strapi_api_token_permissions_token_lnk (
    id integer NOT NULL,
    api_token_permission_id integer,
    api_token_id integer,
    api_token_permission_ord double precision
);


ALTER TABLE public.strapi_api_token_permissions_token_lnk OWNER TO root;

--
-- Name: strapi_api_token_permissions_token_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.strapi_api_token_permissions_token_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_api_token_permissions_token_lnk_id_seq OWNER TO root;

--
-- Name: strapi_api_token_permissions_token_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.strapi_api_token_permissions_token_lnk_id_seq OWNED BY public.strapi_api_token_permissions_token_lnk.id;


--
-- Name: strapi_api_tokens; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.strapi_api_tokens (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    description character varying(255),
    type character varying(255),
    access_key character varying(255),
    last_used_at timestamp(6) without time zone,
    expires_at timestamp(6) without time zone,
    lifespan bigint,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.strapi_api_tokens OWNER TO root;

--
-- Name: strapi_api_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.strapi_api_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_api_tokens_id_seq OWNER TO root;

--
-- Name: strapi_api_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.strapi_api_tokens_id_seq OWNED BY public.strapi_api_tokens.id;


--
-- Name: strapi_core_store_settings; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.strapi_core_store_settings (
    id integer NOT NULL,
    key character varying(255),
    value text,
    type character varying(255),
    environment character varying(255),
    tag character varying(255)
);


ALTER TABLE public.strapi_core_store_settings OWNER TO root;

--
-- Name: strapi_core_store_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.strapi_core_store_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_core_store_settings_id_seq OWNER TO root;

--
-- Name: strapi_core_store_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.strapi_core_store_settings_id_seq OWNED BY public.strapi_core_store_settings.id;


--
-- Name: strapi_database_schema; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.strapi_database_schema (
    id integer NOT NULL,
    schema json,
    "time" timestamp without time zone,
    hash character varying(255)
);


ALTER TABLE public.strapi_database_schema OWNER TO root;

--
-- Name: strapi_database_schema_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.strapi_database_schema_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_database_schema_id_seq OWNER TO root;

--
-- Name: strapi_database_schema_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.strapi_database_schema_id_seq OWNED BY public.strapi_database_schema.id;


--
-- Name: strapi_history_versions; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.strapi_history_versions (
    id integer NOT NULL,
    content_type character varying(255) NOT NULL,
    related_document_id character varying(255),
    locale character varying(255),
    status character varying(255),
    data jsonb,
    schema jsonb,
    created_at timestamp(6) without time zone,
    created_by_id integer
);


ALTER TABLE public.strapi_history_versions OWNER TO root;

--
-- Name: strapi_history_versions_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.strapi_history_versions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_history_versions_id_seq OWNER TO root;

--
-- Name: strapi_history_versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.strapi_history_versions_id_seq OWNED BY public.strapi_history_versions.id;


--
-- Name: strapi_migrations; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.strapi_migrations (
    id integer NOT NULL,
    name character varying(255),
    "time" timestamp without time zone
);


ALTER TABLE public.strapi_migrations OWNER TO root;

--
-- Name: strapi_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.strapi_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_migrations_id_seq OWNER TO root;

--
-- Name: strapi_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.strapi_migrations_id_seq OWNED BY public.strapi_migrations.id;


--
-- Name: strapi_migrations_internal; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.strapi_migrations_internal (
    id integer NOT NULL,
    name character varying(255),
    "time" timestamp without time zone
);


ALTER TABLE public.strapi_migrations_internal OWNER TO root;

--
-- Name: strapi_migrations_internal_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.strapi_migrations_internal_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_migrations_internal_id_seq OWNER TO root;

--
-- Name: strapi_migrations_internal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.strapi_migrations_internal_id_seq OWNED BY public.strapi_migrations_internal.id;


--
-- Name: strapi_release_actions; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.strapi_release_actions (
    id integer NOT NULL,
    document_id character varying(255),
    type character varying(255),
    content_type character varying(255),
    entry_document_id character varying(255),
    locale character varying(255),
    is_entry_valid boolean,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.strapi_release_actions OWNER TO root;

--
-- Name: strapi_release_actions_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.strapi_release_actions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_release_actions_id_seq OWNER TO root;

--
-- Name: strapi_release_actions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.strapi_release_actions_id_seq OWNED BY public.strapi_release_actions.id;


--
-- Name: strapi_release_actions_release_lnk; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.strapi_release_actions_release_lnk (
    id integer NOT NULL,
    release_action_id integer,
    release_id integer,
    release_action_ord double precision
);


ALTER TABLE public.strapi_release_actions_release_lnk OWNER TO root;

--
-- Name: strapi_release_actions_release_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.strapi_release_actions_release_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_release_actions_release_lnk_id_seq OWNER TO root;

--
-- Name: strapi_release_actions_release_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.strapi_release_actions_release_lnk_id_seq OWNED BY public.strapi_release_actions_release_lnk.id;


--
-- Name: strapi_releases; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.strapi_releases (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    released_at timestamp(6) without time zone,
    scheduled_at timestamp(6) without time zone,
    timezone character varying(255),
    status character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.strapi_releases OWNER TO root;

--
-- Name: strapi_releases_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.strapi_releases_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_releases_id_seq OWNER TO root;

--
-- Name: strapi_releases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.strapi_releases_id_seq OWNED BY public.strapi_releases.id;


--
-- Name: strapi_transfer_token_permissions; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.strapi_transfer_token_permissions (
    id integer NOT NULL,
    document_id character varying(255),
    action character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.strapi_transfer_token_permissions OWNER TO root;

--
-- Name: strapi_transfer_token_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.strapi_transfer_token_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_transfer_token_permissions_id_seq OWNER TO root;

--
-- Name: strapi_transfer_token_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.strapi_transfer_token_permissions_id_seq OWNED BY public.strapi_transfer_token_permissions.id;


--
-- Name: strapi_transfer_token_permissions_token_lnk; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.strapi_transfer_token_permissions_token_lnk (
    id integer NOT NULL,
    transfer_token_permission_id integer,
    transfer_token_id integer,
    transfer_token_permission_ord double precision
);


ALTER TABLE public.strapi_transfer_token_permissions_token_lnk OWNER TO root;

--
-- Name: strapi_transfer_token_permissions_token_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.strapi_transfer_token_permissions_token_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_transfer_token_permissions_token_lnk_id_seq OWNER TO root;

--
-- Name: strapi_transfer_token_permissions_token_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.strapi_transfer_token_permissions_token_lnk_id_seq OWNED BY public.strapi_transfer_token_permissions_token_lnk.id;


--
-- Name: strapi_transfer_tokens; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.strapi_transfer_tokens (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    description character varying(255),
    access_key character varying(255),
    last_used_at timestamp(6) without time zone,
    expires_at timestamp(6) without time zone,
    lifespan bigint,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.strapi_transfer_tokens OWNER TO root;

--
-- Name: strapi_transfer_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.strapi_transfer_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_transfer_tokens_id_seq OWNER TO root;

--
-- Name: strapi_transfer_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.strapi_transfer_tokens_id_seq OWNED BY public.strapi_transfer_tokens.id;


--
-- Name: strapi_webhooks; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.strapi_webhooks (
    id integer NOT NULL,
    name character varying(255),
    url text,
    headers jsonb,
    events jsonb,
    enabled boolean
);


ALTER TABLE public.strapi_webhooks OWNER TO root;

--
-- Name: strapi_webhooks_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.strapi_webhooks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_webhooks_id_seq OWNER TO root;

--
-- Name: strapi_webhooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.strapi_webhooks_id_seq OWNED BY public.strapi_webhooks.id;


--
-- Name: strapi_workflows; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.strapi_workflows (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    content_types jsonb,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.strapi_workflows OWNER TO root;

--
-- Name: strapi_workflows_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.strapi_workflows_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_workflows_id_seq OWNER TO root;

--
-- Name: strapi_workflows_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.strapi_workflows_id_seq OWNED BY public.strapi_workflows.id;


--
-- Name: strapi_workflows_stage_required_to_publish_lnk; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.strapi_workflows_stage_required_to_publish_lnk (
    id integer NOT NULL,
    workflow_id integer,
    workflow_stage_id integer
);


ALTER TABLE public.strapi_workflows_stage_required_to_publish_lnk OWNER TO root;

--
-- Name: strapi_workflows_stage_required_to_publish_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.strapi_workflows_stage_required_to_publish_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_workflows_stage_required_to_publish_lnk_id_seq OWNER TO root;

--
-- Name: strapi_workflows_stage_required_to_publish_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.strapi_workflows_stage_required_to_publish_lnk_id_seq OWNED BY public.strapi_workflows_stage_required_to_publish_lnk.id;


--
-- Name: strapi_workflows_stages; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.strapi_workflows_stages (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    color character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.strapi_workflows_stages OWNER TO root;

--
-- Name: strapi_workflows_stages_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.strapi_workflows_stages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_workflows_stages_id_seq OWNER TO root;

--
-- Name: strapi_workflows_stages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.strapi_workflows_stages_id_seq OWNED BY public.strapi_workflows_stages.id;


--
-- Name: strapi_workflows_stages_permissions_lnk; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.strapi_workflows_stages_permissions_lnk (
    id integer NOT NULL,
    workflow_stage_id integer,
    permission_id integer,
    permission_ord double precision
);


ALTER TABLE public.strapi_workflows_stages_permissions_lnk OWNER TO root;

--
-- Name: strapi_workflows_stages_permissions_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.strapi_workflows_stages_permissions_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_workflows_stages_permissions_lnk_id_seq OWNER TO root;

--
-- Name: strapi_workflows_stages_permissions_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.strapi_workflows_stages_permissions_lnk_id_seq OWNED BY public.strapi_workflows_stages_permissions_lnk.id;


--
-- Name: strapi_workflows_stages_workflow_lnk; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.strapi_workflows_stages_workflow_lnk (
    id integer NOT NULL,
    workflow_stage_id integer,
    workflow_id integer,
    workflow_stage_ord double precision
);


ALTER TABLE public.strapi_workflows_stages_workflow_lnk OWNER TO root;

--
-- Name: strapi_workflows_stages_workflow_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.strapi_workflows_stages_workflow_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_workflows_stages_workflow_lnk_id_seq OWNER TO root;

--
-- Name: strapi_workflows_stages_workflow_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.strapi_workflows_stages_workflow_lnk_id_seq OWNED BY public.strapi_workflows_stages_workflow_lnk.id;


--
-- Name: up_permissions; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.up_permissions (
    id integer NOT NULL,
    document_id character varying(255),
    action character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.up_permissions OWNER TO root;

--
-- Name: up_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.up_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.up_permissions_id_seq OWNER TO root;

--
-- Name: up_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.up_permissions_id_seq OWNED BY public.up_permissions.id;


--
-- Name: up_permissions_role_lnk; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.up_permissions_role_lnk (
    id integer NOT NULL,
    permission_id integer,
    role_id integer,
    permission_ord double precision
);


ALTER TABLE public.up_permissions_role_lnk OWNER TO root;

--
-- Name: up_permissions_role_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.up_permissions_role_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.up_permissions_role_lnk_id_seq OWNER TO root;

--
-- Name: up_permissions_role_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.up_permissions_role_lnk_id_seq OWNED BY public.up_permissions_role_lnk.id;


--
-- Name: up_roles; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.up_roles (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    description character varying(255),
    type character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.up_roles OWNER TO root;

--
-- Name: up_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.up_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.up_roles_id_seq OWNER TO root;

--
-- Name: up_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.up_roles_id_seq OWNED BY public.up_roles.id;


--
-- Name: up_users; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.up_users (
    id integer NOT NULL,
    document_id character varying(255),
    username character varying(255),
    email character varying(255),
    provider character varying(255),
    password character varying(255),
    reset_password_token character varying(255),
    confirmation_token character varying(255),
    confirmed boolean,
    blocked boolean,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.up_users OWNER TO root;

--
-- Name: up_users_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.up_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.up_users_id_seq OWNER TO root;

--
-- Name: up_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.up_users_id_seq OWNED BY public.up_users.id;


--
-- Name: up_users_role_lnk; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.up_users_role_lnk (
    id integer NOT NULL,
    user_id integer,
    role_id integer,
    user_ord double precision
);


ALTER TABLE public.up_users_role_lnk OWNER TO root;

--
-- Name: up_users_role_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.up_users_role_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.up_users_role_lnk_id_seq OWNER TO root;

--
-- Name: up_users_role_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.up_users_role_lnk_id_seq OWNED BY public.up_users_role_lnk.id;


--
-- Name: upload_folders; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.upload_folders (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    path_id integer,
    path character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.upload_folders OWNER TO root;

--
-- Name: upload_folders_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.upload_folders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.upload_folders_id_seq OWNER TO root;

--
-- Name: upload_folders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.upload_folders_id_seq OWNED BY public.upload_folders.id;


--
-- Name: upload_folders_parent_lnk; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.upload_folders_parent_lnk (
    id integer NOT NULL,
    folder_id integer,
    inv_folder_id integer,
    folder_ord double precision
);


ALTER TABLE public.upload_folders_parent_lnk OWNER TO root;

--
-- Name: upload_folders_parent_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.upload_folders_parent_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.upload_folders_parent_lnk_id_seq OWNER TO root;

--
-- Name: upload_folders_parent_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.upload_folders_parent_lnk_id_seq OWNED BY public.upload_folders_parent_lnk.id;


--
-- Name: admin_permissions id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.admin_permissions ALTER COLUMN id SET DEFAULT nextval('public.admin_permissions_id_seq'::regclass);


--
-- Name: admin_permissions_role_lnk id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.admin_permissions_role_lnk ALTER COLUMN id SET DEFAULT nextval('public.admin_permissions_role_lnk_id_seq'::regclass);


--
-- Name: admin_roles id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.admin_roles ALTER COLUMN id SET DEFAULT nextval('public.admin_roles_id_seq'::regclass);


--
-- Name: admin_users id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.admin_users ALTER COLUMN id SET DEFAULT nextval('public.admin_users_id_seq'::regclass);


--
-- Name: admin_users_roles_lnk id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.admin_users_roles_lnk ALTER COLUMN id SET DEFAULT nextval('public.admin_users_roles_lnk_id_seq'::regclass);


--
-- Name: bids id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.bids ALTER COLUMN id SET DEFAULT nextval('public.bids_id_seq'::regclass);


--
-- Name: bids_biduser_lnk id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.bids_biduser_lnk ALTER COLUMN id SET DEFAULT nextval('public.bids_biduser_lnk_id_seq'::regclass);


--
-- Name: bids_product_lnk id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.bids_product_lnk ALTER COLUMN id SET DEFAULT nextval('public.bids_product_lnk_id_seq'::regclass);


--
-- Name: bidusers id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.bidusers ALTER COLUMN id SET DEFAULT nextval('public.bidusers_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: files id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.files ALTER COLUMN id SET DEFAULT nextval('public.files_id_seq'::regclass);


--
-- Name: files_folder_lnk id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.files_folder_lnk ALTER COLUMN id SET DEFAULT nextval('public.files_folder_lnk_id_seq'::regclass);


--
-- Name: files_related_mph id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.files_related_mph ALTER COLUMN id SET DEFAULT nextval('public.files_related_mph_id_seq'::regclass);


--
-- Name: i18n_locale id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.i18n_locale ALTER COLUMN id SET DEFAULT nextval('public.i18n_locale_id_seq'::regclass);


--
-- Name: lottery_users id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.lottery_users ALTER COLUMN id SET DEFAULT nextval('public.lottery_users_id_seq'::regclass);


--
-- Name: lottery_users_biduser_lnk id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.lottery_users_biduser_lnk ALTER COLUMN id SET DEFAULT nextval('public.lottery_users_biduser_lnk_id_seq'::regclass);


--
-- Name: lottery_users_products_lnk id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.lottery_users_products_lnk ALTER COLUMN id SET DEFAULT nextval('public.lottery_users_products_lnk_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: products_biduser_lnk id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.products_biduser_lnk ALTER COLUMN id SET DEFAULT nextval('public.products_biduser_lnk_id_seq'::regclass);


--
-- Name: products_categories_lnk id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.products_categories_lnk ALTER COLUMN id SET DEFAULT nextval('public.products_categories_lnk_id_seq'::regclass);


--
-- Name: strapi_api_token_permissions id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_api_token_permissions ALTER COLUMN id SET DEFAULT nextval('public.strapi_api_token_permissions_id_seq'::regclass);


--
-- Name: strapi_api_token_permissions_token_lnk id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_api_token_permissions_token_lnk ALTER COLUMN id SET DEFAULT nextval('public.strapi_api_token_permissions_token_lnk_id_seq'::regclass);


--
-- Name: strapi_api_tokens id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_api_tokens ALTER COLUMN id SET DEFAULT nextval('public.strapi_api_tokens_id_seq'::regclass);


--
-- Name: strapi_core_store_settings id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_core_store_settings ALTER COLUMN id SET DEFAULT nextval('public.strapi_core_store_settings_id_seq'::regclass);


--
-- Name: strapi_database_schema id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_database_schema ALTER COLUMN id SET DEFAULT nextval('public.strapi_database_schema_id_seq'::regclass);


--
-- Name: strapi_history_versions id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_history_versions ALTER COLUMN id SET DEFAULT nextval('public.strapi_history_versions_id_seq'::regclass);


--
-- Name: strapi_migrations id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_migrations ALTER COLUMN id SET DEFAULT nextval('public.strapi_migrations_id_seq'::regclass);


--
-- Name: strapi_migrations_internal id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_migrations_internal ALTER COLUMN id SET DEFAULT nextval('public.strapi_migrations_internal_id_seq'::regclass);


--
-- Name: strapi_release_actions id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_release_actions ALTER COLUMN id SET DEFAULT nextval('public.strapi_release_actions_id_seq'::regclass);


--
-- Name: strapi_release_actions_release_lnk id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_release_actions_release_lnk ALTER COLUMN id SET DEFAULT nextval('public.strapi_release_actions_release_lnk_id_seq'::regclass);


--
-- Name: strapi_releases id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_releases ALTER COLUMN id SET DEFAULT nextval('public.strapi_releases_id_seq'::regclass);


--
-- Name: strapi_transfer_token_permissions id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions ALTER COLUMN id SET DEFAULT nextval('public.strapi_transfer_token_permissions_id_seq'::regclass);


--
-- Name: strapi_transfer_token_permissions_token_lnk id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_lnk ALTER COLUMN id SET DEFAULT nextval('public.strapi_transfer_token_permissions_token_lnk_id_seq'::regclass);


--
-- Name: strapi_transfer_tokens id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_transfer_tokens ALTER COLUMN id SET DEFAULT nextval('public.strapi_transfer_tokens_id_seq'::regclass);


--
-- Name: strapi_webhooks id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_webhooks ALTER COLUMN id SET DEFAULT nextval('public.strapi_webhooks_id_seq'::regclass);


--
-- Name: strapi_workflows id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_workflows ALTER COLUMN id SET DEFAULT nextval('public.strapi_workflows_id_seq'::regclass);


--
-- Name: strapi_workflows_stage_required_to_publish_lnk id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_workflows_stage_required_to_publish_lnk ALTER COLUMN id SET DEFAULT nextval('public.strapi_workflows_stage_required_to_publish_lnk_id_seq'::regclass);


--
-- Name: strapi_workflows_stages id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_workflows_stages ALTER COLUMN id SET DEFAULT nextval('public.strapi_workflows_stages_id_seq'::regclass);


--
-- Name: strapi_workflows_stages_permissions_lnk id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_workflows_stages_permissions_lnk ALTER COLUMN id SET DEFAULT nextval('public.strapi_workflows_stages_permissions_lnk_id_seq'::regclass);


--
-- Name: strapi_workflows_stages_workflow_lnk id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_workflows_stages_workflow_lnk ALTER COLUMN id SET DEFAULT nextval('public.strapi_workflows_stages_workflow_lnk_id_seq'::regclass);


--
-- Name: up_permissions id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.up_permissions ALTER COLUMN id SET DEFAULT nextval('public.up_permissions_id_seq'::regclass);


--
-- Name: up_permissions_role_lnk id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.up_permissions_role_lnk ALTER COLUMN id SET DEFAULT nextval('public.up_permissions_role_lnk_id_seq'::regclass);


--
-- Name: up_roles id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.up_roles ALTER COLUMN id SET DEFAULT nextval('public.up_roles_id_seq'::regclass);


--
-- Name: up_users id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.up_users ALTER COLUMN id SET DEFAULT nextval('public.up_users_id_seq'::regclass);


--
-- Name: up_users_role_lnk id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.up_users_role_lnk ALTER COLUMN id SET DEFAULT nextval('public.up_users_role_lnk_id_seq'::regclass);


--
-- Name: upload_folders id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.upload_folders ALTER COLUMN id SET DEFAULT nextval('public.upload_folders_id_seq'::regclass);


--
-- Name: upload_folders_parent_lnk id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.upload_folders_parent_lnk ALTER COLUMN id SET DEFAULT nextval('public.upload_folders_parent_lnk_id_seq'::regclass);


--
-- Data for Name: admin_permissions; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.admin_permissions (id, document_id, action, action_parameters, subject, properties, conditions, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	r8wuvwg0yf0f6u1055so4vd3	plugin::content-manager.explorer.create	{}	api::biduser.biduser	{"fields": ["email", "Name"]}	[]	2024-11-21 13:00:39.651	2024-11-21 13:00:39.651	2024-11-21 13:00:39.651	\N	\N	\N
2	qli466lapwbbic6wwupzznju	plugin::content-manager.explorer.create	{}	api::category.category	{"fields": ["category_name"]}	[]	2024-11-21 13:00:39.657	2024-11-21 13:00:39.657	2024-11-21 13:00:39.657	\N	\N	\N
3	mdnd46kbmpceptdbg5gm5nlo	plugin::content-manager.explorer.create	{}	api::product.product	{"fields": ["title", "description", "categories", "main_picture", "gallery", "price", "ending_date"]}	[]	2024-11-21 13:00:39.661	2024-11-21 13:00:39.661	2024-11-21 13:00:39.661	\N	\N	\N
4	pk9zr1bauwtwbrdif2hr9kaw	plugin::content-manager.explorer.read	{}	api::biduser.biduser	{"fields": ["email", "Name"]}	[]	2024-11-21 13:00:39.665	2024-11-21 13:00:39.665	2024-11-21 13:00:39.665	\N	\N	\N
5	orf9jkruam9cjwu9ukst31t5	plugin::content-manager.explorer.read	{}	api::category.category	{"fields": ["category_name"]}	[]	2024-11-21 13:00:39.668	2024-11-21 13:00:39.668	2024-11-21 13:00:39.668	\N	\N	\N
6	kod8fjny3y1vt5z0geuqeeb8	plugin::content-manager.explorer.read	{}	api::product.product	{"fields": ["title", "description", "categories", "main_picture", "gallery", "price", "ending_date"]}	[]	2024-11-21 13:00:39.672	2024-11-21 13:00:39.672	2024-11-21 13:00:39.672	\N	\N	\N
7	ysbjcm4ivp5rl7w0wv9dkdfs	plugin::content-manager.explorer.update	{}	api::biduser.biduser	{"fields": ["email", "Name"]}	[]	2024-11-21 13:00:39.675	2024-11-21 13:00:39.675	2024-11-21 13:00:39.676	\N	\N	\N
8	nk1ekx922y8ju7k0f1yxeqbw	plugin::content-manager.explorer.update	{}	api::category.category	{"fields": ["category_name"]}	[]	2024-11-21 13:00:39.679	2024-11-21 13:00:39.679	2024-11-21 13:00:39.679	\N	\N	\N
9	kdg9nksfb0ux50eoxdtia4lm	plugin::content-manager.explorer.update	{}	api::product.product	{"fields": ["title", "description", "categories", "main_picture", "gallery", "price", "ending_date"]}	[]	2024-11-21 13:00:39.682	2024-11-21 13:00:39.682	2024-11-21 13:00:39.682	\N	\N	\N
10	ouqh1wp81z96qksikhasn1ps	plugin::content-manager.explorer.delete	{}	api::biduser.biduser	{}	[]	2024-11-21 13:00:39.686	2024-11-21 13:00:39.686	2024-11-21 13:00:39.686	\N	\N	\N
11	lppw6mdx3sd8zqzfkuz5x7vq	plugin::content-manager.explorer.delete	{}	api::category.category	{}	[]	2024-11-21 13:00:39.689	2024-11-21 13:00:39.689	2024-11-21 13:00:39.689	\N	\N	\N
12	t194l8mi4vrj5e4rspf084vu	plugin::content-manager.explorer.delete	{}	api::product.product	{}	[]	2024-11-21 13:00:39.693	2024-11-21 13:00:39.693	2024-11-21 13:00:39.693	\N	\N	\N
13	xbap3sawik35n2ia2j99go2a	plugin::content-manager.explorer.publish	{}	api::biduser.biduser	{}	[]	2024-11-21 13:00:39.696	2024-11-21 13:00:39.696	2024-11-21 13:00:39.697	\N	\N	\N
14	ptzf8mu8shgvry1j14psuu00	plugin::content-manager.explorer.publish	{}	api::category.category	{}	[]	2024-11-21 13:00:39.7	2024-11-21 13:00:39.7	2024-11-21 13:00:39.7	\N	\N	\N
15	pnhu41ew5vahnkiij50d8q49	plugin::content-manager.explorer.publish	{}	api::product.product	{}	[]	2024-11-21 13:00:39.703	2024-11-21 13:00:39.703	2024-11-21 13:00:39.703	\N	\N	\N
16	fhemrp9ib4l5z0yzjp26t9x1	plugin::upload.read	{}	\N	{}	[]	2024-11-21 13:00:39.706	2024-11-21 13:00:39.706	2024-11-21 13:00:39.706	\N	\N	\N
17	k460ok8k2agmf0p423m0s0v4	plugin::upload.configure-view	{}	\N	{}	[]	2024-11-21 13:00:39.709	2024-11-21 13:00:39.709	2024-11-21 13:00:39.71	\N	\N	\N
18	kncjhdlvgc7oie8fy2tqf8m5	plugin::upload.assets.create	{}	\N	{}	[]	2024-11-21 13:00:39.714	2024-11-21 13:00:39.714	2024-11-21 13:00:39.714	\N	\N	\N
19	n2qx8hskcp1vw4ix8lscq7r1	plugin::upload.assets.update	{}	\N	{}	[]	2024-11-21 13:00:39.718	2024-11-21 13:00:39.718	2024-11-21 13:00:39.719	\N	\N	\N
20	ahrjyy6xbjegc15uzqtxrju6	plugin::upload.assets.download	{}	\N	{}	[]	2024-11-21 13:00:39.722	2024-11-21 13:00:39.722	2024-11-21 13:00:39.722	\N	\N	\N
21	tlbbpl9pzd5lltmw9j1ao0gn	plugin::upload.assets.copy-link	{}	\N	{}	[]	2024-11-21 13:00:39.726	2024-11-21 13:00:39.726	2024-11-21 13:00:39.726	\N	\N	\N
22	ylut2oapdxf6lf8nayzl3vz9	plugin::content-manager.explorer.create	{}	api::biduser.biduser	{"fields": ["email", "Name"]}	["admin::is-creator"]	2024-11-21 13:00:39.732	2024-11-21 13:00:39.732	2024-11-21 13:00:39.732	\N	\N	\N
23	fxbj2gvueq4odf31c9o74zdg	plugin::content-manager.explorer.create	{}	api::category.category	{"fields": ["category_name"]}	["admin::is-creator"]	2024-11-21 13:00:39.735	2024-11-21 13:00:39.735	2024-11-21 13:00:39.735	\N	\N	\N
24	jrmftkt69abnvqmid70w1gcf	plugin::content-manager.explorer.create	{}	api::product.product	{"fields": ["title", "description", "categories", "main_picture", "gallery", "price", "ending_date"]}	["admin::is-creator"]	2024-11-21 13:00:39.739	2024-11-21 13:00:39.739	2024-11-21 13:00:39.739	\N	\N	\N
25	wljvu7dveaiihkibptci5hb2	plugin::content-manager.explorer.read	{}	api::biduser.biduser	{"fields": ["email", "Name"]}	["admin::is-creator"]	2024-11-21 13:00:39.742	2024-11-21 13:00:39.742	2024-11-21 13:00:39.742	\N	\N	\N
26	qvvut2c0zoig3wvsghcv1hw9	plugin::content-manager.explorer.read	{}	api::category.category	{"fields": ["category_name"]}	["admin::is-creator"]	2024-11-21 13:00:39.745	2024-11-21 13:00:39.745	2024-11-21 13:00:39.745	\N	\N	\N
27	bz1svabb8tn7l8sjh7qw5dky	plugin::content-manager.explorer.read	{}	api::product.product	{"fields": ["title", "description", "categories", "main_picture", "gallery", "price", "ending_date"]}	["admin::is-creator"]	2024-11-21 13:00:39.748	2024-11-21 13:00:39.748	2024-11-21 13:00:39.748	\N	\N	\N
28	p3vc531bds1ql4yk3qqom4wv	plugin::content-manager.explorer.update	{}	api::biduser.biduser	{"fields": ["email", "Name"]}	["admin::is-creator"]	2024-11-21 13:00:39.751	2024-11-21 13:00:39.751	2024-11-21 13:00:39.751	\N	\N	\N
29	p1y2i2xtqatbiztb8io1trj4	plugin::content-manager.explorer.update	{}	api::category.category	{"fields": ["category_name"]}	["admin::is-creator"]	2024-11-21 13:00:39.754	2024-11-21 13:00:39.754	2024-11-21 13:00:39.754	\N	\N	\N
30	kf7z7wy5rjtxirmad745qw7l	plugin::content-manager.explorer.update	{}	api::product.product	{"fields": ["title", "description", "categories", "main_picture", "gallery", "price", "ending_date"]}	["admin::is-creator"]	2024-11-21 13:00:39.757	2024-11-21 13:00:39.757	2024-11-21 13:00:39.758	\N	\N	\N
31	er0rt2yvadamzp3rzv04js0a	plugin::content-manager.explorer.delete	{}	api::biduser.biduser	{}	["admin::is-creator"]	2024-11-21 13:00:39.76	2024-11-21 13:00:39.76	2024-11-21 13:00:39.761	\N	\N	\N
32	kks3phk3upd9xip13kkh1w62	plugin::content-manager.explorer.delete	{}	api::category.category	{}	["admin::is-creator"]	2024-11-21 13:00:39.765	2024-11-21 13:00:39.765	2024-11-21 13:00:39.765	\N	\N	\N
33	wew2s796wb4m9kmqeje9k764	plugin::content-manager.explorer.delete	{}	api::product.product	{}	["admin::is-creator"]	2024-11-21 13:00:39.768	2024-11-21 13:00:39.768	2024-11-21 13:00:39.768	\N	\N	\N
34	vpcaqb0hbt1jm25fy19u163g	plugin::upload.read	{}	\N	{}	["admin::is-creator"]	2024-11-21 13:00:39.771	2024-11-21 13:00:39.771	2024-11-21 13:00:39.771	\N	\N	\N
35	sk4jboay8iu01hkuh4yzzz5u	plugin::upload.configure-view	{}	\N	{}	[]	2024-11-21 13:00:39.774	2024-11-21 13:00:39.774	2024-11-21 13:00:39.774	\N	\N	\N
36	nziyzy57z9mkcltqaqidccss	plugin::upload.assets.create	{}	\N	{}	[]	2024-11-21 13:00:39.776	2024-11-21 13:00:39.776	2024-11-21 13:00:39.777	\N	\N	\N
37	ii1fmkwmg4tddwuqcm0txkvu	plugin::upload.assets.update	{}	\N	{}	["admin::is-creator"]	2024-11-21 13:00:39.779	2024-11-21 13:00:39.779	2024-11-21 13:00:39.779	\N	\N	\N
38	wgz6kwch8g8ctjew04us7ubh	plugin::upload.assets.download	{}	\N	{}	[]	2024-11-21 13:00:39.783	2024-11-21 13:00:39.783	2024-11-21 13:00:39.783	\N	\N	\N
39	pvlkv3k0x440boh1ti363bf8	plugin::upload.assets.copy-link	{}	\N	{}	[]	2024-11-21 13:00:39.786	2024-11-21 13:00:39.786	2024-11-21 13:00:39.786	\N	\N	\N
40	t0te8hnbxc5gcqpfulszadt0	plugin::content-manager.explorer.create	{}	plugin::users-permissions.user	{"fields": ["username", "email", "provider", "password", "resetPasswordToken", "confirmationToken", "confirmed", "blocked", "role"]}	[]	2024-11-21 13:00:39.813	2024-11-21 13:00:39.813	2024-11-21 13:00:39.813	\N	\N	\N
233	q9vwizxldy3acb19pk91ofif	plugin::content-manager.explorer.create	{}	api::lottery-user.lottery-user	{"fields": ["biduser", "products"]}	[]	2024-12-16 14:45:16.427	2024-12-16 14:45:16.427	2024-12-16 14:45:16.427	\N	\N	\N
198	npo2gcqcg9espd5klfljy4vd	plugin::content-manager.explorer.create	{}	api::biduser.biduser	{"fields": ["email", "Name", "bids", "active", "favourites", "lottery_users"]}	[]	2024-12-09 11:39:08.551	2024-12-09 11:39:08.551	2024-12-09 11:39:08.552	\N	\N	\N
44	lkf2n5vbjiiq8yljieakojze	plugin::content-manager.explorer.read	{}	plugin::users-permissions.user	{"fields": ["username", "email", "provider", "password", "resetPasswordToken", "confirmationToken", "confirmed", "blocked", "role"]}	[]	2024-11-21 13:00:39.828	2024-11-21 13:00:39.828	2024-11-21 13:00:39.828	\N	\N	\N
48	tbrs0oycpashovaxaqg63ieg	plugin::content-manager.explorer.update	{}	plugin::users-permissions.user	{"fields": ["username", "email", "provider", "password", "resetPasswordToken", "confirmationToken", "confirmed", "blocked", "role"]}	[]	2024-11-21 13:00:39.84	2024-11-21 13:00:39.84	2024-11-21 13:00:39.84	\N	\N	\N
201	hduu4y2vz1oq2ww9v1fiz5dh	plugin::content-manager.explorer.read	{}	api::biduser.biduser	{"fields": ["email", "Name", "bids", "active", "favourites", "lottery_users"]}	[]	2024-12-09 11:39:08.566	2024-12-09 11:39:08.566	2024-12-09 11:39:08.567	\N	\N	\N
52	ypaf907i13vc42qukgkqzf6u	plugin::content-manager.explorer.delete	{}	plugin::users-permissions.user	{}	[]	2024-11-21 13:00:39.854	2024-11-21 13:00:39.854	2024-11-21 13:00:39.854	\N	\N	\N
53	ttf6ggfjeim34ims6we1ne18	plugin::content-manager.explorer.delete	{}	api::biduser.biduser	{}	[]	2024-11-21 13:00:39.857	2024-11-21 13:00:39.857	2024-11-21 13:00:39.857	\N	\N	\N
54	fn5b45i6lgnbgqiek7rwz33w	plugin::content-manager.explorer.delete	{}	api::category.category	{}	[]	2024-11-21 13:00:39.86	2024-11-21 13:00:39.86	2024-11-21 13:00:39.86	\N	\N	\N
55	hb1zfuh3u2mfyagubmshvwai	plugin::content-manager.explorer.delete	{}	api::product.product	{}	[]	2024-11-21 13:00:39.864	2024-11-21 13:00:39.864	2024-11-21 13:00:39.864	\N	\N	\N
56	i361uas29y8h2lzul3868nk8	plugin::content-manager.explorer.publish	{}	plugin::users-permissions.user	{}	[]	2024-11-21 13:00:39.868	2024-11-21 13:00:39.868	2024-11-21 13:00:39.869	\N	\N	\N
57	f0wexdpkzdmdxm8t07mnses8	plugin::content-manager.explorer.publish	{}	api::biduser.biduser	{}	[]	2024-11-21 13:00:39.872	2024-11-21 13:00:39.872	2024-11-21 13:00:39.872	\N	\N	\N
58	ziq19dpbomt7kafnsbag21du	plugin::content-manager.explorer.publish	{}	api::category.category	{}	[]	2024-11-21 13:00:39.875	2024-11-21 13:00:39.875	2024-11-21 13:00:39.875	\N	\N	\N
59	z4lu0r3jbjr32lyieiw1z8zs	plugin::content-manager.explorer.publish	{}	api::product.product	{}	[]	2024-11-21 13:00:39.878	2024-11-21 13:00:39.878	2024-11-21 13:00:39.878	\N	\N	\N
60	vcibgubnqo6gtb04ndwxdh5q	plugin::content-manager.single-types.configure-view	{}	\N	{}	[]	2024-11-21 13:00:39.882	2024-11-21 13:00:39.882	2024-11-21 13:00:39.882	\N	\N	\N
61	tq4f1ix4hu56zhkyfz5le7i8	plugin::content-manager.collection-types.configure-view	{}	\N	{}	[]	2024-11-21 13:00:39.885	2024-11-21 13:00:39.885	2024-11-21 13:00:39.886	\N	\N	\N
62	m42f9p97iz5lcfmb2c55i21u	plugin::content-manager.components.configure-layout	{}	\N	{}	[]	2024-11-21 13:00:39.888	2024-11-21 13:00:39.888	2024-11-21 13:00:39.889	\N	\N	\N
63	palgulb4ih8pmbn3lnhmwup5	plugin::content-type-builder.read	{}	\N	{}	[]	2024-11-21 13:00:39.892	2024-11-21 13:00:39.892	2024-11-21 13:00:39.892	\N	\N	\N
64	uaiw76vsyrsjd1ji7094kvkx	plugin::email.settings.read	{}	\N	{}	[]	2024-11-21 13:00:39.895	2024-11-21 13:00:39.895	2024-11-21 13:00:39.895	\N	\N	\N
65	bljnvv2soo49odx08umyv8ey	plugin::upload.read	{}	\N	{}	[]	2024-11-21 13:00:39.898	2024-11-21 13:00:39.898	2024-11-21 13:00:39.898	\N	\N	\N
66	r3y73jzjztmz0gye9rkd7yzm	plugin::upload.assets.create	{}	\N	{}	[]	2024-11-21 13:00:39.901	2024-11-21 13:00:39.901	2024-11-21 13:00:39.901	\N	\N	\N
67	tfn5v95mcvyj26dfxvl052gh	plugin::upload.assets.update	{}	\N	{}	[]	2024-11-21 13:00:39.904	2024-11-21 13:00:39.904	2024-11-21 13:00:39.904	\N	\N	\N
68	oqgi156j1fot8uu7p7kwu4o4	plugin::upload.assets.download	{}	\N	{}	[]	2024-11-21 13:00:39.907	2024-11-21 13:00:39.907	2024-11-21 13:00:39.907	\N	\N	\N
69	e99jg321js7kwc40g1z3jtqw	plugin::upload.assets.copy-link	{}	\N	{}	[]	2024-11-21 13:00:39.91	2024-11-21 13:00:39.91	2024-11-21 13:00:39.91	\N	\N	\N
70	oupy8ppda616ogv8495tqbgl	plugin::upload.configure-view	{}	\N	{}	[]	2024-11-21 13:00:39.912	2024-11-21 13:00:39.912	2024-11-21 13:00:39.912	\N	\N	\N
71	mj8f6hqr8vx40r674gui1h8p	plugin::upload.settings.read	{}	\N	{}	[]	2024-11-21 13:00:39.915	2024-11-21 13:00:39.915	2024-11-21 13:00:39.915	\N	\N	\N
72	vuuojdo6w0e2rz96rf5dwxki	plugin::i18n.locale.create	{}	\N	{}	[]	2024-11-21 13:00:39.918	2024-11-21 13:00:39.918	2024-11-21 13:00:39.918	\N	\N	\N
73	u7mdv5fs0yqtpsck5qtgtwe0	plugin::i18n.locale.read	{}	\N	{}	[]	2024-11-21 13:00:39.921	2024-11-21 13:00:39.921	2024-11-21 13:00:39.921	\N	\N	\N
74	mxqunvtfjccuz06ykzgbj056	plugin::i18n.locale.update	{}	\N	{}	[]	2024-11-21 13:00:39.923	2024-11-21 13:00:39.923	2024-11-21 13:00:39.923	\N	\N	\N
75	woqp7m8orwuzggagh4rsea0x	plugin::i18n.locale.delete	{}	\N	{}	[]	2024-11-21 13:00:39.927	2024-11-21 13:00:39.927	2024-11-21 13:00:39.927	\N	\N	\N
76	qf8lo3ek4x7jsseqen3djzyk	plugin::users-permissions.roles.create	{}	\N	{}	[]	2024-11-21 13:00:39.931	2024-11-21 13:00:39.931	2024-11-21 13:00:39.931	\N	\N	\N
77	nuwbnb5hfz4fls4hsdc5xsgz	plugin::users-permissions.roles.read	{}	\N	{}	[]	2024-11-21 13:00:39.934	2024-11-21 13:00:39.934	2024-11-21 13:00:39.935	\N	\N	\N
78	h0leobgwnlu9fj0ttdce39kq	plugin::users-permissions.roles.update	{}	\N	{}	[]	2024-11-21 13:00:39.937	2024-11-21 13:00:39.937	2024-11-21 13:00:39.938	\N	\N	\N
79	gjshukkgkg7itzuutchb4rn7	plugin::users-permissions.roles.delete	{}	\N	{}	[]	2024-11-21 13:00:39.94	2024-11-21 13:00:39.94	2024-11-21 13:00:39.941	\N	\N	\N
80	qnit598zp9lwy9ef09vjg22c	plugin::users-permissions.providers.read	{}	\N	{}	[]	2024-11-21 13:00:39.943	2024-11-21 13:00:39.943	2024-11-21 13:00:39.943	\N	\N	\N
81	uqjn7dji9hlynxnif7bfm4mm	plugin::users-permissions.providers.update	{}	\N	{}	[]	2024-11-21 13:00:39.946	2024-11-21 13:00:39.946	2024-11-21 13:00:39.947	\N	\N	\N
82	ong871jb92n5dm7317xdrzfo	plugin::users-permissions.email-templates.read	{}	\N	{}	[]	2024-11-21 13:00:39.949	2024-11-21 13:00:39.949	2024-11-21 13:00:39.95	\N	\N	\N
83	uqascvxhn9xclc45tjrh13a1	plugin::users-permissions.email-templates.update	{}	\N	{}	[]	2024-11-21 13:00:39.953	2024-11-21 13:00:39.953	2024-11-21 13:00:39.953	\N	\N	\N
84	j0586e0hhcaci138z755y6h7	plugin::users-permissions.advanced-settings.read	{}	\N	{}	[]	2024-11-21 13:00:39.957	2024-11-21 13:00:39.957	2024-11-21 13:00:39.957	\N	\N	\N
85	razqml6b2vdolgah2vq2eusp	plugin::users-permissions.advanced-settings.update	{}	\N	{}	[]	2024-11-21 13:00:39.96	2024-11-21 13:00:39.96	2024-11-21 13:00:39.96	\N	\N	\N
86	i8m1tqeyqtybo7q25h4ij71a	admin::marketplace.read	{}	\N	{}	[]	2024-11-21 13:00:39.964	2024-11-21 13:00:39.964	2024-11-21 13:00:39.964	\N	\N	\N
87	wj9wj4jnho11md7vwbqekowj	admin::webhooks.create	{}	\N	{}	[]	2024-11-21 13:00:39.967	2024-11-21 13:00:39.967	2024-11-21 13:00:39.967	\N	\N	\N
88	snjsxpxodpsfy2tenradcatt	admin::webhooks.read	{}	\N	{}	[]	2024-11-21 13:00:39.97	2024-11-21 13:00:39.97	2024-11-21 13:00:39.97	\N	\N	\N
89	xobm9wh05wvo7hm3hhnxxsr8	admin::webhooks.update	{}	\N	{}	[]	2024-11-21 13:00:39.974	2024-11-21 13:00:39.974	2024-11-21 13:00:39.974	\N	\N	\N
90	yjjrx5k5nyjdn4p45qrbprri	admin::webhooks.delete	{}	\N	{}	[]	2024-11-21 13:00:39.977	2024-11-21 13:00:39.977	2024-11-21 13:00:39.977	\N	\N	\N
91	a233jmnjazgysku8nf8rz83l	admin::users.create	{}	\N	{}	[]	2024-11-21 13:00:39.98	2024-11-21 13:00:39.98	2024-11-21 13:00:39.98	\N	\N	\N
92	e2f7s4u1sao6x2spmhjd1t5m	admin::users.read	{}	\N	{}	[]	2024-11-21 13:00:39.984	2024-11-21 13:00:39.984	2024-11-21 13:00:39.984	\N	\N	\N
93	wtrksq4mu96n3220q3y3pdp5	admin::users.update	{}	\N	{}	[]	2024-11-21 13:00:39.987	2024-11-21 13:00:39.987	2024-11-21 13:00:39.987	\N	\N	\N
94	w321ri18ibf5b171032nh98l	admin::users.delete	{}	\N	{}	[]	2024-11-21 13:00:39.99	2024-11-21 13:00:39.99	2024-11-21 13:00:39.99	\N	\N	\N
95	uqe90dil91086lbry6fcstnu	admin::roles.create	{}	\N	{}	[]	2024-11-21 13:00:39.993	2024-11-21 13:00:39.993	2024-11-21 13:00:39.993	\N	\N	\N
96	xp1h96ipi5guykanbfb57ljn	admin::roles.read	{}	\N	{}	[]	2024-11-21 13:00:39.996	2024-11-21 13:00:39.996	2024-11-21 13:00:39.996	\N	\N	\N
97	p7spho5cu4uieqpzd7uh73e5	admin::roles.update	{}	\N	{}	[]	2024-11-21 13:00:39.999	2024-11-21 13:00:39.999	2024-11-21 13:00:40	\N	\N	\N
98	q4hmxhlgi6k4go6h6k8pp5js	admin::roles.delete	{}	\N	{}	[]	2024-11-21 13:00:40.002	2024-11-21 13:00:40.002	2024-11-21 13:00:40.002	\N	\N	\N
99	mfxfcwohyqjc24gupo2u3jfi	admin::api-tokens.access	{}	\N	{}	[]	2024-11-21 13:00:40.005	2024-11-21 13:00:40.005	2024-11-21 13:00:40.005	\N	\N	\N
100	iaq1gaw6fb2nbv0bp24cjvju	admin::api-tokens.create	{}	\N	{}	[]	2024-11-21 13:00:40.01	2024-11-21 13:00:40.01	2024-11-21 13:00:40.01	\N	\N	\N
101	x6mowya553pf6athlwosvfri	admin::api-tokens.read	{}	\N	{}	[]	2024-11-21 13:00:40.013	2024-11-21 13:00:40.013	2024-11-21 13:00:40.013	\N	\N	\N
102	vghgmraqlbs5xxp2shgvky5y	admin::api-tokens.update	{}	\N	{}	[]	2024-11-21 13:00:40.016	2024-11-21 13:00:40.016	2024-11-21 13:00:40.016	\N	\N	\N
103	sfh5kdwhrl2zrt19dpt70ugs	admin::api-tokens.regenerate	{}	\N	{}	[]	2024-11-21 13:00:40.019	2024-11-21 13:00:40.019	2024-11-21 13:00:40.019	\N	\N	\N
104	i4agv23a0712cr2dhq6anx4k	admin::api-tokens.delete	{}	\N	{}	[]	2024-11-21 13:00:40.021	2024-11-21 13:00:40.021	2024-11-21 13:00:40.022	\N	\N	\N
105	sn88qmsnw7k8k83459hv7b93	admin::project-settings.update	{}	\N	{}	[]	2024-11-21 13:00:40.024	2024-11-21 13:00:40.024	2024-11-21 13:00:40.024	\N	\N	\N
106	fdph5e54yl1ur2a071whydnk	admin::project-settings.read	{}	\N	{}	[]	2024-11-21 13:00:40.027	2024-11-21 13:00:40.027	2024-11-21 13:00:40.027	\N	\N	\N
107	z5s1tiyskif3d572yhr9ebsy	admin::transfer.tokens.access	{}	\N	{}	[]	2024-11-21 13:00:40.03	2024-11-21 13:00:40.03	2024-11-21 13:00:40.03	\N	\N	\N
108	fg5si6yq61jzo4vftc8czsab	admin::transfer.tokens.create	{}	\N	{}	[]	2024-11-21 13:00:40.033	2024-11-21 13:00:40.033	2024-11-21 13:00:40.033	\N	\N	\N
109	ndiz3z1z4akkyvqmp2k7huvi	admin::transfer.tokens.read	{}	\N	{}	[]	2024-11-21 13:00:40.035	2024-11-21 13:00:40.035	2024-11-21 13:00:40.035	\N	\N	\N
110	paieqfki96i0d3ng2866vi60	admin::transfer.tokens.update	{}	\N	{}	[]	2024-11-21 13:00:40.038	2024-11-21 13:00:40.038	2024-11-21 13:00:40.038	\N	\N	\N
111	y6k0p2o8q8hx0lua3q8mfpgs	admin::transfer.tokens.regenerate	{}	\N	{}	[]	2024-11-21 13:00:40.041	2024-11-21 13:00:40.041	2024-11-21 13:00:40.041	\N	\N	\N
112	y0lb1rhonmizsjqm6vn3goxc	admin::transfer.tokens.delete	{}	\N	{}	[]	2024-11-21 13:00:40.044	2024-11-21 13:00:40.044	2024-11-21 13:00:40.044	\N	\N	\N
113	p3qjtgww4g8ippfnk6rg5wyf	plugin::content-manager.explorer.create	{}	api::bid.bid	{"fields": ["Amount", "biduser", "product"]}	[]	2024-11-21 15:02:01.099	2024-11-21 15:02:01.099	2024-11-21 15:02:01.1	\N	\N	\N
116	db7oa8gt7gzose594ie42fa1	plugin::content-manager.explorer.read	{}	api::bid.bid	{"fields": ["Amount", "biduser", "product"]}	[]	2024-11-21 15:02:01.116	2024-11-21 15:02:01.116	2024-11-21 15:02:01.116	\N	\N	\N
204	pjdw9twrpppbukgrc7wh3hct	plugin::content-manager.explorer.update	{}	api::biduser.biduser	{"fields": ["email", "Name", "bids", "active", "favourites", "lottery_users"]}	[]	2024-12-09 11:39:08.579	2024-12-09 11:39:08.579	2024-12-09 11:39:08.579	\N	\N	\N
119	axg8utoqlpl5xpwco60t0a02	plugin::content-manager.explorer.update	{}	api::bid.bid	{"fields": ["Amount", "biduser", "product"]}	[]	2024-11-21 15:02:01.129	2024-11-21 15:02:01.129	2024-11-21 15:02:01.129	\N	\N	\N
207	sotycy8wnbksk2i8uvi7ydp4	plugin::content-manager.explorer.delete	{}	api::lottery-user.lottery-user	{}	[]	2024-12-09 11:39:08.59	2024-12-09 11:39:08.59	2024-12-09 11:39:08.59	\N	\N	\N
122	f87hmm6x8sml7ittb1feexll	plugin::content-manager.explorer.delete	{}	api::bid.bid	{}	[]	2024-11-21 15:02:01.14	2024-11-21 15:02:01.14	2024-11-21 15:02:01.14	\N	\N	\N
123	m1dtk0qb4jc1pb1g1ocfjo5w	plugin::content-manager.explorer.publish	{}	api::bid.bid	{}	[]	2024-11-21 15:02:01.144	2024-11-21 15:02:01.144	2024-11-21 15:02:01.144	\N	\N	\N
208	jsmu503p5j2ppi2kojvejxxx	plugin::content-manager.explorer.publish	{}	api::lottery-user.lottery-user	{}	[]	2024-12-09 11:39:08.593	2024-12-09 11:39:08.593	2024-12-09 11:39:08.593	\N	\N	\N
235	tw1wywzxyne5dpfqnd1fq8g8	plugin::content-manager.explorer.read	{}	api::lottery-user.lottery-user	{"fields": ["biduser", "products"]}	[]	2024-12-16 14:45:16.44	2024-12-16 14:45:16.44	2024-12-16 14:45:16.44	\N	\N	\N
237	qsntyqfe4w62phaikf5ierj0	plugin::content-manager.explorer.update	{}	api::lottery-user.lottery-user	{"fields": ["biduser", "products"]}	[]	2024-12-16 14:45:16.449	2024-12-16 14:45:16.449	2024-12-16 14:45:16.449	\N	\N	\N
242	eqadbod01mnz8tf0p2jlrt5f	plugin::content-manager.explorer.create	{}	api::category.category	{"fields": ["category_name", "slug"]}	[]	2024-12-17 14:05:11.417	2024-12-17 14:05:11.417	2024-12-17 14:05:11.418	\N	\N	\N
243	lw35zqe2qmae0oqbili3wlz3	plugin::content-manager.explorer.read	{}	api::category.category	{"fields": ["category_name", "slug"]}	[]	2024-12-17 14:05:11.425	2024-12-17 14:05:11.425	2024-12-17 14:05:11.426	\N	\N	\N
244	xjlmbxr0x6ggaxrvjo8mt0dg	plugin::content-manager.explorer.update	{}	api::category.category	{"fields": ["category_name", "slug"]}	[]	2024-12-17 14:05:11.431	2024-12-17 14:05:11.431	2024-12-17 14:05:11.431	\N	\N	\N
245	bn8pxb0hw0rs4dnw45ufqwyq	plugin::content-manager.explorer.create	{}	api::product.product	{"fields": ["title", "description", "categories", "main_picture", "gallery", "price", "ending_date", "bids", "biduser", "lottery_product", "lottery_users", "lottery_winner", "manual_lottery"]}	[]	2025-01-08 15:21:38.666	2025-01-08 15:21:38.666	2025-01-08 15:21:38.667	\N	\N	\N
246	f8e3u5iqs20pxdex6xlvd2us	plugin::content-manager.explorer.read	{}	api::product.product	{"fields": ["title", "description", "categories", "main_picture", "gallery", "price", "ending_date", "bids", "biduser", "lottery_product", "lottery_users", "lottery_winner", "manual_lottery"]}	[]	2025-01-08 15:21:38.675	2025-01-08 15:21:38.675	2025-01-08 15:21:38.676	\N	\N	\N
247	v7f8tpa1kafxj5pyq0eow7vs	plugin::content-manager.explorer.update	{}	api::product.product	{"fields": ["title", "description", "categories", "main_picture", "gallery", "price", "ending_date", "bids", "biduser", "lottery_product", "lottery_users", "lottery_winner", "manual_lottery"]}	[]	2025-01-08 15:21:38.68	2025-01-08 15:21:38.68	2025-01-08 15:21:38.681	\N	\N	\N
\.


--
-- Data for Name: admin_permissions_role_lnk; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.admin_permissions_role_lnk (id, permission_id, role_id, permission_ord) FROM stdin;
1	1	2	1
2	2	2	2
3	3	2	3
4	4	2	4
5	5	2	5
6	6	2	6
7	7	2	7
8	8	2	8
9	9	2	9
10	10	2	10
11	11	2	11
12	12	2	12
13	13	2	13
14	14	2	14
15	15	2	15
16	16	2	16
17	17	2	17
18	18	2	18
19	19	2	19
20	20	2	20
21	21	2	21
22	22	3	1
23	23	3	2
24	24	3	3
25	25	3	4
26	26	3	5
27	27	3	6
28	28	3	7
29	29	3	8
30	30	3	9
31	31	3	10
32	32	3	11
33	33	3	12
34	34	3	13
35	35	3	14
36	36	3	15
37	37	3	16
38	38	3	17
39	39	3	18
40	40	1	1
198	198	1	85
44	44	1	5
201	201	1	88
48	48	1	9
52	52	1	13
53	53	1	14
54	54	1	15
55	55	1	16
56	56	1	17
57	57	1	18
58	58	1	19
59	59	1	20
60	60	1	21
61	61	1	22
62	62	1	23
63	63	1	24
64	64	1	25
65	65	1	26
66	66	1	27
67	67	1	28
68	68	1	29
69	69	1	30
70	70	1	31
71	71	1	32
72	72	1	33
73	73	1	34
74	74	1	35
75	75	1	36
76	76	1	37
77	77	1	38
78	78	1	39
79	79	1	40
80	80	1	41
81	81	1	42
82	82	1	43
83	83	1	44
84	84	1	45
85	85	1	46
86	86	1	47
87	87	1	48
88	88	1	49
89	89	1	50
90	90	1	51
91	91	1	52
92	92	1	53
93	93	1	54
94	94	1	55
95	95	1	56
96	96	1	57
97	97	1	58
98	98	1	59
99	99	1	60
100	100	1	61
101	101	1	62
102	102	1	63
103	103	1	64
104	104	1	65
105	105	1	66
106	106	1	67
107	107	1	68
108	108	1	69
109	109	1	70
110	110	1	71
111	111	1	72
112	112	1	73
113	113	1	74
204	204	1	91
116	116	1	77
207	207	1	94
119	119	1	80
208	208	1	95
122	122	1	83
123	123	1	84
233	233	1	96
235	235	1	98
237	237	1	100
242	242	1	104
243	243	1	105
244	244	1	106
245	245	1	107
246	246	1	108
247	247	1	109
\.


--
-- Data for Name: admin_roles; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.admin_roles (id, document_id, name, code, description, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	lqi6u5bib8fbpazpuq3f70n1	Super Admin	strapi-super-admin	Super Admins can access and manage all features and settings.	2024-11-21 13:00:39.632	2024-11-21 13:00:39.632	2024-11-21 13:00:39.632	\N	\N	\N
2	qmh1d2zdnbfc1k272i3yg02e	Editor	strapi-editor	Editors can manage and publish contents including those of other users.	2024-11-21 13:00:39.638	2024-11-21 13:00:39.638	2024-11-21 13:00:39.639	\N	\N	\N
3	wx80hvyoad2fxjs3p5qyr2dp	Author	strapi-author	Authors can manage the content they have created.	2024-11-21 13:00:39.642	2024-11-21 13:00:39.642	2024-11-21 13:00:39.642	\N	\N	\N
\.


--
-- Data for Name: admin_users; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.admin_users (id, document_id, firstname, lastname, username, email, password, reset_password_token, registration_token, is_active, blocked, prefered_language, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	dwtdpkda5b78yzkbjiwdswvr	Ozay	Ozdemir	ozay	ozay.ozdemir@gmail.com	$2a$10$i/LE1mAXzmNdLlutxj6YheNrmYxE7reib8fv5AwlZYV/X7f8BNXNq	\N	\N	t	f	\N	2024-11-21 13:01:14.956	2024-12-03 13:41:19.352	2024-11-21 13:01:14.957	\N	\N	\N
3	h3k1qjprcg9788fcfsl7oltz	Jesper	Gradin	jesper	jesper.gradin@bouvet.se	$2a$10$M5fIbKao6J4WrpHF7fxWtu.Fc1EPdA27f2ynciy548dfeD3xSgzVS	\N	\N	t	f	\N	2025-02-10 12:57:49.34	2025-02-10 13:00:03.048	2025-02-10 12:57:49.341	\N	\N	\N
\.


--
-- Data for Name: admin_users_roles_lnk; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.admin_users_roles_lnk (id, user_id, role_id, role_ord, user_ord) FROM stdin;
1	1	1	1	1
4	3	1	1	3
\.


--
-- Data for Name: bids; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.bids (id, document_id, amount, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	ax355dp4jozf6vq4dwl0r3v3	250.00	2024-11-21 15:04:01.517	2024-11-21 15:04:01.517	\N	1	1	\N
2	ax355dp4jozf6vq4dwl0r3v3	250.00	2024-11-21 15:04:01.517	2024-11-21 15:04:01.517	2024-11-21 15:04:01.541	1	1	\N
3	qr0y8wwm1qs19qtrwluwf62e	300.00	2024-11-21 15:05:43.109	2024-11-21 15:05:43.109	\N	1	1	\N
4	qr0y8wwm1qs19qtrwluwf62e	300.00	2024-11-21 15:05:43.109	2024-11-21 15:05:43.109	2024-11-21 15:05:43.125	1	1	\N
5	pajeimwog6sh3gemdzjmojt5	850.00	2024-11-21 15:17:43.912	2024-11-21 15:17:43.912	\N	1	1	\N
6	pajeimwog6sh3gemdzjmojt5	850.00	2024-11-21 15:17:43.912	2024-11-21 15:17:43.912	2024-11-21 15:17:43.99	1	1	\N
73	ocixjtfu7oely881c4picokg	1600.00	2024-12-12 12:26:41.514	2024-12-12 12:26:41.514	\N	\N	\N	\N
74	ocixjtfu7oely881c4picokg	1600.00	2024-12-12 12:26:41.514	2024-12-12 12:26:41.514	2024-12-12 12:26:41.526	\N	\N	\N
7	akn8ugzlyi338tfshqxsf967	500.00	2024-11-22 16:32:09.266	2024-11-22 16:33:12.714	\N	1	1	\N
10	akn8ugzlyi338tfshqxsf967	500.00	2024-11-22 16:32:09.266	2024-11-22 16:33:12.714	2024-11-22 16:33:12.737	1	1	\N
11	miiu280rsl6qrjmppenhppq6	550.00	2024-11-25 15:06:22.6	2024-11-25 15:06:22.6	\N	1	1	\N
12	miiu280rsl6qrjmppenhppq6	550.00	2024-11-25 15:06:22.6	2024-11-25 15:06:22.6	2024-11-25 15:06:22.67	1	1	\N
13	pey5jmjfd683or1wgw5lczwl	600.00	2024-11-25 15:07:00.688	2024-11-25 15:07:00.688	\N	1	1	\N
14	pey5jmjfd683or1wgw5lczwl	600.00	2024-11-25 15:07:00.688	2024-11-25 15:07:00.688	2024-11-25 15:07:00.748	1	1	\N
15	k13jhptescm9x6cv14ldgbq5	900.00	2024-11-25 15:08:33.648	2024-11-25 15:08:33.648	\N	1	1	\N
16	k13jhptescm9x6cv14ldgbq5	900.00	2024-11-25 15:08:33.648	2024-11-25 15:08:33.648	2024-11-25 15:08:33.706	1	1	\N
17	gztvvac4wgjjtvnhprwshabg	1000.00	2024-11-25 15:15:23.359	2024-11-25 15:15:23.359	\N	1	1	\N
18	gztvvac4wgjjtvnhprwshabg	1000.00	2024-11-25 15:15:23.359	2024-11-25 15:15:23.359	2024-11-25 15:15:23.383	1	1	\N
19	h0wdbgab4ygybrh05hmjjq2h	1100.00	2024-11-25 15:23:14.448	2024-11-25 15:23:14.448	\N	1	1	\N
20	h0wdbgab4ygybrh05hmjjq2h	1100.00	2024-11-25 15:23:14.448	2024-11-25 15:23:14.448	2024-11-25 15:23:14.479	1	1	\N
21	xonbsnw9pf1ie6ugau1wxiex	1200.00	2024-11-25 15:35:28.217	2024-11-25 15:35:28.217	\N	1	1	\N
22	xonbsnw9pf1ie6ugau1wxiex	1200.00	2024-11-25 15:35:28.217	2024-11-25 15:35:28.217	2024-11-25 15:35:28.244	1	1	\N
23	ztjdhuz2roqyft882moc8llv	650.00	2024-11-26 15:12:18.441	2024-11-26 15:12:18.441	\N	\N	\N	\N
24	ztjdhuz2roqyft882moc8llv	650.00	2024-11-26 15:12:18.441	2024-11-26 15:12:18.441	2024-11-26 15:12:18.448	\N	\N	\N
25	j0he9w7406mqnn82q9i0jo4q	700.00	2024-11-26 15:13:26.358	2024-11-26 15:13:26.358	\N	\N	\N	\N
26	j0he9w7406mqnn82q9i0jo4q	700.00	2024-11-26 15:13:26.358	2024-11-26 15:13:26.358	2024-11-26 15:13:26.375	\N	\N	\N
27	ea5etrlh3cmc5hcg28vugoz9	500.00	2024-11-26 15:59:54.98	2024-11-26 15:59:54.98	\N	\N	\N	\N
28	ea5etrlh3cmc5hcg28vugoz9	500.00	2024-11-26 15:59:54.98	2024-11-26 15:59:54.98	2024-11-26 15:59:54.992	\N	\N	\N
29	ljlapkpkz87p4jay9thafdjr	800.00	2024-11-26 16:00:05.088	2024-11-26 16:00:05.088	\N	\N	\N	\N
30	ljlapkpkz87p4jay9thafdjr	800.00	2024-11-26 16:00:05.088	2024-11-26 16:00:05.088	2024-11-26 16:00:05.099	\N	\N	\N
31	zdewwv4ycdyg6ad0nb7ccqt3	850.00	2024-11-26 16:05:32.861	2024-11-26 16:05:32.861	\N	\N	\N	\N
32	zdewwv4ycdyg6ad0nb7ccqt3	850.00	2024-11-26 16:05:32.861	2024-11-26 16:05:32.861	2024-11-26 16:05:32.869	\N	\N	\N
33	fm8ue1cr8r5s4vtyioq1vm99	750.00	2024-11-27 12:58:24.469	2024-11-27 12:58:24.469	\N	\N	\N	\N
34	fm8ue1cr8r5s4vtyioq1vm99	750.00	2024-11-27 12:58:24.469	2024-11-27 12:58:24.469	2024-11-27 12:58:24.486	\N	\N	\N
35	zjncvjs90pfrimfgjoa9r4x0	800.00	2024-11-27 12:59:07.055	2024-11-27 12:59:07.055	\N	\N	\N	\N
36	zjncvjs90pfrimfgjoa9r4x0	800.00	2024-11-27 12:59:07.055	2024-11-27 12:59:07.055	2024-11-27 12:59:07.061	\N	\N	\N
37	ojffmevhzg0omz3jctqxhc7v	2050.00	2024-11-28 10:30:59.128	2024-11-28 10:30:59.128	\N	\N	\N	\N
38	ojffmevhzg0omz3jctqxhc7v	2050.00	2024-11-28 10:30:59.128	2024-11-28 10:30:59.128	2024-11-28 10:30:59.14	\N	\N	\N
39	qq5gtcd3y905l924qo5g1as2	2100.00	2024-11-28 16:24:42.315	2024-11-28 16:24:42.315	\N	\N	\N	\N
40	qq5gtcd3y905l924qo5g1as2	2100.00	2024-11-28 16:24:42.315	2024-11-28 16:24:42.315	2024-11-28 16:24:42.326	\N	\N	\N
41	ue4ftyaut7pe72pqaalr06xj	2200.00	2024-11-28 16:27:55.391	2024-11-28 16:27:55.391	\N	\N	\N	\N
42	ue4ftyaut7pe72pqaalr06xj	2200.00	2024-11-28 16:27:55.391	2024-11-28 16:27:55.391	2024-11-28 16:27:55.444	\N	\N	\N
43	kyls5o14isa8s9kuqidgzpr5	2250.00	2024-11-29 12:47:19.56	2024-11-29 12:47:19.56	\N	\N	\N	\N
44	kyls5o14isa8s9kuqidgzpr5	2250.00	2024-11-29 12:47:19.56	2024-11-29 12:47:19.56	2024-11-29 12:47:19.575	\N	\N	\N
45	mte66lijl5917on2amudytdb	9999.00	2024-12-03 09:55:20.605	2024-12-03 09:55:20.605	\N	\N	\N	\N
46	mte66lijl5917on2amudytdb	9999.00	2024-12-03 09:55:20.605	2024-12-03 09:55:20.605	2024-12-03 09:55:20.632	\N	\N	\N
47	nagg5kt06lmvyed7hvwh1nar	2300.00	2024-12-05 14:40:05.535	2024-12-05 14:40:05.535	\N	\N	\N	\N
48	nagg5kt06lmvyed7hvwh1nar	2300.00	2024-12-05 14:40:05.535	2024-12-05 14:40:05.535	2024-12-05 14:40:05.594	\N	\N	\N
49	r59omxdmyb7v7a8xbp5t91sj	1250.00	2024-12-05 16:16:06.515	2024-12-05 16:16:06.515	\N	\N	\N	\N
50	r59omxdmyb7v7a8xbp5t91sj	1250.00	2024-12-05 16:16:06.515	2024-12-05 16:16:06.515	2024-12-05 16:16:06.523	\N	\N	\N
51	jbhlmumhlosb3srxue2m44uu	2500.00	2024-12-09 14:45:08.244	2024-12-09 14:45:08.244	\N	\N	\N	\N
52	jbhlmumhlosb3srxue2m44uu	2500.00	2024-12-09 14:45:08.244	2024-12-09 14:45:08.244	2024-12-09 14:45:08.305	\N	\N	\N
53	ibihndd9ppdbf0vaacwgb42l	3000.00	2024-12-09 15:48:50.83	2024-12-09 15:48:50.83	\N	\N	\N	\N
54	ibihndd9ppdbf0vaacwgb42l	3000.00	2024-12-09 15:48:50.83	2024-12-09 15:48:50.83	2024-12-09 15:48:50.84	\N	\N	\N
55	mik6lwtw5uq733ef5ltpor1m	1300.00	2024-12-09 15:50:06.454	2024-12-09 15:50:06.454	\N	\N	\N	\N
56	mik6lwtw5uq733ef5ltpor1m	1300.00	2024-12-09 15:50:06.454	2024-12-09 15:50:06.454	2024-12-09 15:50:06.461	\N	\N	\N
57	xcii8py3zg8asc6bpnies9ff	10100.00	2024-12-09 15:54:42.151	2024-12-09 15:54:42.151	\N	\N	\N	\N
58	xcii8py3zg8asc6bpnies9ff	10100.00	2024-12-09 15:54:42.151	2024-12-09 15:54:42.151	2024-12-09 15:54:42.158	\N	\N	\N
59	r32fzth5atnx9y2zu3m68xrv	1400.00	2024-12-10 10:18:23.987	2024-12-10 10:18:23.987	\N	\N	\N	\N
60	r32fzth5atnx9y2zu3m68xrv	1400.00	2024-12-10 10:18:23.987	2024-12-10 10:18:23.987	2024-12-10 10:18:24	\N	\N	\N
61	s6bj9cbw8bqo5lnlvkxsf3df	10200.00	2024-12-10 10:24:18.795	2024-12-10 10:24:18.795	\N	\N	\N	\N
62	s6bj9cbw8bqo5lnlvkxsf3df	10200.00	2024-12-10 10:24:18.795	2024-12-10 10:24:18.795	2024-12-10 10:24:18.802	\N	\N	\N
63	y9fdmjnamdtrerkdeeue4sm5	1500.00	2024-12-10 10:26:52.487	2024-12-10 10:26:52.487	\N	\N	\N	\N
64	y9fdmjnamdtrerkdeeue4sm5	1500.00	2024-12-10 10:26:52.487	2024-12-10 10:26:52.487	2024-12-10 10:26:52.493	\N	\N	\N
65	zww3lpfoo5z1q6fjhm9ucxn2	10300.00	2024-12-11 10:57:47.014	2024-12-11 10:57:47.014	\N	\N	\N	\N
66	zww3lpfoo5z1q6fjhm9ucxn2	10300.00	2024-12-11 10:57:47.014	2024-12-11 10:57:47.014	2024-12-11 10:57:47.025	\N	\N	\N
67	nuayavmyjfjgk79qnsdydcak	10400.00	2024-12-11 13:00:31.027	2024-12-11 13:00:31.027	\N	\N	\N	\N
68	nuayavmyjfjgk79qnsdydcak	10400.00	2024-12-11 13:00:31.027	2024-12-11 13:00:31.027	2024-12-11 13:00:31.035	\N	\N	\N
69	o91dwfhrfd0g1xwwk1yxyxll	10500.00	2024-12-12 10:25:45.552	2024-12-12 10:25:45.552	\N	\N	\N	\N
70	o91dwfhrfd0g1xwwk1yxyxll	10500.00	2024-12-12 10:25:45.552	2024-12-12 10:25:45.552	2024-12-12 10:25:45.607	\N	\N	\N
71	ydb65drz6v2d7uxwusl32g60	10600.00	2024-12-12 11:44:04.338	2024-12-12 11:44:04.338	\N	\N	\N	\N
72	ydb65drz6v2d7uxwusl32g60	10600.00	2024-12-12 11:44:04.338	2024-12-12 11:44:04.338	2024-12-12 11:44:04.348	\N	\N	\N
75	kb0ky2iuaxxjecvt60sz844e	10800.00	2024-12-16 10:10:37.456	2024-12-16 10:10:37.456	\N	\N	\N	\N
76	kb0ky2iuaxxjecvt60sz844e	10800.00	2024-12-16 10:10:37.456	2024-12-16 10:10:37.456	2024-12-16 10:10:37.464	\N	\N	\N
77	tilxmwon6i6ganwa1tlpt9fx	10900.00	2024-12-16 15:42:19.885	2024-12-16 15:42:19.885	\N	\N	\N	\N
78	tilxmwon6i6ganwa1tlpt9fx	10900.00	2024-12-16 15:42:19.885	2024-12-16 15:42:19.885	2024-12-16 15:42:19.894	\N	\N	\N
79	a6h302e5z9xd0dc0pdcd0s7s	3500.00	2024-12-18 12:20:33.737	2024-12-18 12:20:33.737	\N	\N	\N	\N
80	a6h302e5z9xd0dc0pdcd0s7s	3500.00	2024-12-18 12:20:33.737	2024-12-18 12:20:33.737	2024-12-18 12:20:33.746	\N	\N	\N
81	kv6f91malsx7qw8bgppoh2oq	100.00	2024-12-19 09:43:23.13	2024-12-19 09:43:23.13	\N	\N	\N	\N
82	kv6f91malsx7qw8bgppoh2oq	100.00	2024-12-19 09:43:23.13	2024-12-19 09:43:23.13	2024-12-19 09:43:23.235	\N	\N	\N
83	z2hq70oqec187b8gwi7k4n4d	200.00	2025-01-07 11:12:03.579	2025-01-07 11:12:03.579	\N	\N	\N	\N
84	z2hq70oqec187b8gwi7k4n4d	200.00	2025-01-07 11:12:03.579	2025-01-07 11:12:03.579	2025-01-07 11:12:03.619	\N	\N	\N
85	k3i0fpfoa6su7ffzd43fifjt	1650.00	2025-01-20 16:07:49.467	2025-01-20 16:07:49.467	\N	\N	\N	\N
86	k3i0fpfoa6su7ffzd43fifjt	1650.00	2025-01-20 16:07:49.467	2025-01-20 16:07:49.467	2025-01-20 16:07:49.585	\N	\N	\N
87	j1ornjec7zrf1abpgal79v36	11000.00	2025-01-21 13:56:03.279	2025-01-21 13:56:03.279	\N	\N	\N	\N
88	j1ornjec7zrf1abpgal79v36	11000.00	2025-01-21 13:56:03.279	2025-01-21 13:56:03.279	2025-01-21 13:56:03.335	\N	\N	\N
89	gx0sj8aw72eh4e293u9sga7f	12000.00	2025-01-27 13:48:02.238	2025-01-27 13:48:02.238	\N	\N	\N	\N
90	gx0sj8aw72eh4e293u9sga7f	12000.00	2025-01-27 13:48:02.238	2025-01-27 13:48:02.238	2025-01-27 13:48:02.342	\N	\N	\N
91	qy8cg47swl2f6e5uux4tf4qx	200.00	2025-01-27 14:34:26.581	2025-01-27 14:34:26.581	\N	\N	\N	\N
92	qy8cg47swl2f6e5uux4tf4qx	200.00	2025-01-27 14:34:26.581	2025-01-27 14:34:26.581	2025-01-27 14:34:26.606	\N	\N	\N
93	o0n5wdbqgukzz4mjlflw3wms	300.00	2025-01-29 11:18:43.903	2025-01-29 11:18:43.903	\N	\N	\N	\N
94	o0n5wdbqgukzz4mjlflw3wms	300.00	2025-01-29 11:18:43.903	2025-01-29 11:18:43.903	2025-01-29 11:18:43.962	\N	\N	\N
95	muw604ymojbr4p2zsyjrhtqx	400.00	2025-01-31 09:15:16.798	2025-01-31 09:15:16.798	\N	\N	\N	\N
96	muw604ymojbr4p2zsyjrhtqx	400.00	2025-01-31 09:15:16.798	2025-01-31 09:15:16.798	2025-01-31 09:15:16.85	\N	\N	\N
97	af1waixhlhb0vnqlmnhzwg2x	300.00	2025-02-03 10:33:16.366	2025-02-03 10:33:16.366	\N	\N	\N	\N
98	af1waixhlhb0vnqlmnhzwg2x	300.00	2025-02-03 10:33:16.366	2025-02-03 10:33:16.366	2025-02-03 10:33:16.375	\N	\N	\N
99	pfcwcar1vsdblz0h27c1666d	350.00	2025-02-04 10:15:58.696	2025-02-04 10:15:58.696	\N	\N	\N	\N
100	pfcwcar1vsdblz0h27c1666d	350.00	2025-02-04 10:15:58.696	2025-02-04 10:15:58.696	2025-02-04 10:15:58.747	\N	\N	\N
101	ia3rfwf9zvixqyua3yx85q0c	400.00	2025-02-04 10:33:06.682	2025-02-04 10:33:06.682	\N	\N	\N	\N
102	ia3rfwf9zvixqyua3yx85q0c	400.00	2025-02-04 10:33:06.682	2025-02-04 10:33:06.682	2025-02-04 10:33:06.691	\N	\N	\N
103	lsbje598h6za4xve1ukb1bkq	450.00	2025-02-04 14:29:32.342	2025-02-04 14:29:32.342	\N	\N	\N	\N
104	lsbje598h6za4xve1ukb1bkq	450.00	2025-02-04 14:29:32.342	2025-02-04 14:29:32.342	2025-02-04 14:29:32.357	\N	\N	\N
105	vlp01h2p5yecpimk97xt9bgh	100.00	2025-02-05 14:32:56.621	2025-02-05 14:32:56.621	\N	\N	\N	\N
106	vlp01h2p5yecpimk97xt9bgh	100.00	2025-02-05 14:32:56.621	2025-02-05 14:32:56.621	2025-02-05 14:32:56.673	\N	\N	\N
107	le0r3rawg5oa6yd0kadd4g40	1250.00	2025-02-05 14:33:40.226	2025-02-05 14:33:40.226	\N	\N	\N	\N
108	le0r3rawg5oa6yd0kadd4g40	1250.00	2025-02-05 14:33:40.226	2025-02-05 14:33:40.226	2025-02-05 14:33:40.234	\N	\N	\N
109	rnw651a9omn10yajto262v4l	200.00	2025-02-05 14:33:53.598	2025-02-05 14:33:53.598	\N	\N	\N	\N
110	rnw651a9omn10yajto262v4l	200.00	2025-02-05 14:33:53.598	2025-02-05 14:33:53.598	2025-02-05 14:33:53.606	\N	\N	\N
111	gazn3x4mgnptsh69tkl0scaz	550.00	2025-02-05 14:34:06.168	2025-02-05 14:34:06.168	\N	\N	\N	\N
112	gazn3x4mgnptsh69tkl0scaz	550.00	2025-02-05 14:34:06.168	2025-02-05 14:34:06.168	2025-02-05 14:34:06.174	\N	\N	\N
113	v0t8on7cqjglnbir5ezq374j	850.00	2025-02-05 14:34:20.75	2025-02-05 14:34:20.75	\N	\N	\N	\N
114	v0t8on7cqjglnbir5ezq374j	850.00	2025-02-05 14:34:20.75	2025-02-05 14:34:20.75	2025-02-05 14:34:20.756	\N	\N	\N
115	rl6hurk1nn2fux08hdclh482	1300.00	2025-02-06 10:55:18.001	2025-02-06 10:55:18.001	\N	\N	\N	\N
116	rl6hurk1nn2fux08hdclh482	1300.00	2025-02-06 10:55:18.001	2025-02-06 10:55:18.001	2025-02-06 10:55:18.015	\N	\N	\N
117	bua0q46tzqoeld6a41vzgjvm	200.00	2025-02-06 11:05:13.407	2025-02-06 11:05:13.407	\N	\N	\N	\N
118	bua0q46tzqoeld6a41vzgjvm	200.00	2025-02-06 11:05:13.407	2025-02-06 11:05:13.407	2025-02-06 11:05:13.416	\N	\N	\N
119	ytd09yu0g2td0lrjw4cbrugm	250.00	2025-02-08 16:00:10.948	2025-02-08 16:00:10.948	\N	\N	\N	\N
120	ytd09yu0g2td0lrjw4cbrugm	250.00	2025-02-08 16:00:10.948	2025-02-08 16:00:10.948	2025-02-08 16:00:11.065	\N	\N	\N
\.


--
-- Data for Name: bids_biduser_lnk; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.bids_biduser_lnk (id, bid_id, biduser_id, bid_ord) FROM stdin;
1	1	1	1
1396	83	3	11
3	3	3	1
5	5	1	2
7	7	1	3
1605	87	5	6
1803	93	12	4
2201	95	5	8
12	2	9	1
13	6	9	2
14	10	9	3
15	11	3	2
17	13	1	4
18	14	9	4
19	15	5	1
2761	117	12	6
21	17	3	3
1482	64	183	1
23	19	5	2
25	21	1	5
26	22	9	5
27	23	1	6
28	24	9	6
29	25	1	7
30	26	9	7
31	27	1	8
32	28	9	8
33	29	1	9
34	30	9	9
35	31	1	10
36	32	9	10
37	33	1	11
38	34	9	11
39	35	1	12
40	36	9	12
41	37	1	13
42	38	9	13
43	39	12	1
45	41	12	2
47	43	1	14
48	44	9	14
49	45	1	15
50	46	9	15
51	47	1	16
52	48	9	16
53	49	1	17
54	50	9	17
55	51	1	18
56	52	9	18
57	53	5	3
59	55	5	4
61	57	5	5
63	59	3	4
1483	85	3	12
65	61	3	5
67	63	14	1
2805	119	12	7
69	65	3	6
2806	120	309	7
71	67	3	7
73	69	1	19
74	70	9	19
75	71	1	20
76	72	9	20
77	73	1	21
78	74	9	21
79	75	1	22
80	76	9	22
1619	89	5	7
1621	91	12	3
2590	101	5	10
2716	16	294	1
2717	20	294	2
1044	81	3	10
2718	54	294	3
2719	56	294	4
2720	58	294	5
2721	88	294	6
2722	90	294	7
2723	96	294	8
2724	98	294	9
2725	102	294	10
2726	104	294	11
123	77	3	8
853	79	3	9
2235	97	5	9
2592	103	5	11
2616	105	3	14
2618	107	3	15
2622	111	3	17
2624	113	3	18
2588	99	3	13
2698	4	293	1
2699	12	293	2
2700	18	293	3
2701	60	293	4
2702	62	293	5
2703	66	293	6
2704	68	293	7
2705	78	293	8
2706	80	293	9
2707	82	293	10
2708	84	293	11
2709	86	293	12
2710	100	293	13
2711	106	293	14
2712	108	293	15
2713	110	293	16
2714	112	293	17
2715	114	293	18
2620	109	3	16
2759	115	12	5
2799	40	309	1
2800	42	309	2
2801	92	309	3
2802	94	309	4
2803	116	309	5
2804	118	309	6
\.


--
-- Data for Name: bids_product_lnk; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.bids_product_lnk (id, bid_id, product_id, bid_ord) FROM stdin;
1	1	1	1
295	85	3	11
3	3	1	2
296	86	148	11
5	5	3	1
297	87	1	19
7	7	1	3
298	88	147	19
299	89	1	20
11	11	1	4
300	90	147	20
13	13	1	5
301	91	139	1
15	15	3	2
302	92	142	1
17	17	3	3
303	93	139	2
19	19	3	4
304	94	142	2
21	21	3	5
305	95	139	3
306	96	142	3
315	38	425	1
316	40	425	2
317	42	425	3
318	44	425	4
201	47	19	5
319	48	425	5
203	49	3	6
320	52	425	6
205	51	19	6
321	54	425	7
207	53	19	7
322	80	425	8
209	55	3	7
323	97	426	1
211	57	1	11
324	98	427	1
213	59	3	8
325	99	426	2
215	61	1	12
326	100	427	2
217	63	3	9
327	101	426	3
328	102	427	3
329	103	426	4
330	104	427	4
331	105	455	1
58	23	1	6
332	106	456	1
60	25	1	7
333	107	439	1
62	27	12	1
334	108	441	1
64	29	12	2
335	109	437	1
336	110	438	1
337	111	435	1
338	112	436	1
339	113	433	1
70	31	12	3
340	114	434	1
341	115	439	2
342	116	441	2
343	117	455	2
344	118	456	2
345	119	455	3
346	120	456	3
78	33	1	8
80	35	1	9
231	65	1	13
85	37	19	1
233	67	1	14
87	39	19	2
89	41	19	3
235	69	1	15
91	43	19	4
93	45	1	10
237	71	1	16
239	73	3	10
241	75	1	17
250	77	1	18
109	28	23	1
110	30	23	2
111	32	23	3
252	79	19	8
254	81	135	1
256	82	143	1
257	83	135	2
258	84	143	2
267	2	147	1
268	4	147	2
269	10	147	3
270	12	147	4
271	14	147	5
272	24	147	6
273	26	147	7
274	34	147	8
275	36	147	9
276	46	147	10
277	58	147	11
278	62	147	12
279	66	147	13
280	68	147	14
281	70	147	15
282	72	147	16
283	76	147	17
284	78	147	18
285	6	148	1
286	16	148	2
287	18	148	3
288	20	148	4
289	22	148	5
290	50	148	6
291	56	148	7
292	60	148	8
293	64	148	9
294	74	148	10
\.


--
-- Data for Name: bidusers; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.bidusers (id, document_id, email, name, created_at, updated_at, published_at, created_by_id, updated_by_id, locale, active) FROM stdin;
1	o8eiugglctv5azit1bn7jtcv	ozay.ozdemir@chasacademy.se	Ozay	2024-11-21 13:48:56.787	2024-11-25 10:21:25.315	\N	1	1	\N	t
9	o8eiugglctv5azit1bn7jtcv	ozay.ozdemir@chasacademy.se	Ozay	2024-11-21 13:48:56.787	2024-11-25 10:21:25.315	2024-11-25 10:21:25.338	1	1	\N	t
12	danpxmcht9yqoz3wekjt53dw	user3@test.com	User3	2024-11-28 16:24:28.301	2025-02-06 14:26:02.535	\N	\N	1	\N	t
309	danpxmcht9yqoz3wekjt53dw	user3@test.com	User3	2024-11-28 16:24:28.301	2025-02-06 14:26:02.535	2025-02-06 14:26:02.549	\N	1	\N	t
3	rfw87y9d0sw9f7gnk5u5c2wx	user1@test.com	User1	2024-11-21 15:04:46.006	2025-02-05 16:40:57.224	\N	1	1	\N	t
10	vqltkvt9ugsg874s03m6d31b	user4@test.com	User4	2024-11-25 16:28:55.542	2025-01-11 13:04:25.561	\N	\N	1	\N	t
293	rfw87y9d0sw9f7gnk5u5c2wx	user1@test.com	User1	2024-11-21 15:04:46.006	2025-02-05 16:40:57.224	2025-02-05 16:40:57.236	1	1	\N	t
177	vqltkvt9ugsg874s03m6d31b	user4@test.com	User4	2024-11-25 16:28:55.542	2025-01-11 13:04:25.561	2025-01-11 13:04:25.594	\N	1	\N	t
5	gtsn4022m9giwgu0ofcyps2w	user2@test.com	User2	2024-11-21 15:05:07.097	2025-02-06 09:43:04.735	\N	1	1	\N	t
294	gtsn4022m9giwgu0ofcyps2w	user2@test.com	User2	2024-11-21 15:05:07.097	2025-02-06 09:43:04.735	2025-02-06 09:43:04.754	1	1	\N	t
14	k6gz6nystbdn6xyfd8l9d09o	user5@test.com	User5	2024-12-10 10:26:41.213	2025-01-11 17:34:44.008	\N	\N	\N	\N	t
183	k6gz6nystbdn6xyfd8l9d09o	user5@test.com	User5	2024-12-10 10:26:41.213	2025-01-11 17:34:44.008	2025-01-11 17:34:44.017	\N	\N	\N	t
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.categories (id, document_id, category_name, created_at, updated_at, published_at, created_by_id, updated_by_id, locale, slug) FROM stdin;
3	xagcnowlh4roduy27un3g1zv	Telefon	2024-11-21 13:48:16.154	2024-12-17 14:05:55.057	\N	1	1	\N	telefon
5	xagcnowlh4roduy27un3g1zv	Telefon	2024-11-21 13:48:16.154	2024-12-17 14:05:55.057	2024-12-17 14:05:55.07	1	1	\N	telefon
1	g0rwwn759bs8ohbb56nifj3k	Dator	2024-11-21 13:47:37.142	2024-12-17 14:06:06.344	\N	1	1	\N	dator
6	g0rwwn759bs8ohbb56nifj3k	Dator	2024-11-21 13:47:37.142	2024-12-17 14:06:06.344	2024-12-17 14:06:06.354	1	1	\N	dator
7	uxpkg6l3mmouosj0o2um5bjb	Accessories	2024-12-17 14:51:16.215	2025-02-05 12:21:05.903	\N	1	1	\N	accessories
10	uxpkg6l3mmouosj0o2um5bjb	Accessories	2024-12-17 14:51:16.215	2025-02-05 12:21:05.903	2025-02-05 12:21:05.926	1	1	\N	accessories
11	npy8b0u4hhcdu02i78562aw6	Datorskärm	2025-02-05 12:23:15.418	2025-02-05 12:23:15.418	\N	1	1	\N	datorskarm
12	npy8b0u4hhcdu02i78562aw6	Datorskärm	2025-02-05 12:23:15.418	2025-02-05 12:23:15.418	2025-02-05 12:23:15.427	1	1	\N	datorskarm
13	jwsgbrwn7ykbtys79wgiqw3s	Annan	2025-02-05 12:25:15.94	2025-02-05 12:25:15.94	\N	1	1	\N	annan
14	jwsgbrwn7ykbtys79wgiqw3s	Annan	2025-02-05 12:25:15.94	2025-02-05 12:25:15.94	2025-02-05 12:25:15.948	1	1	\N	annan
\.


--
-- Data for Name: files; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.files (id, document_id, name, alternative_text, caption, width, height, formats, hash, ext, mime, size, url, preview_url, provider, provider_metadata, folder_path, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
2	wp1rqsh19holit0ugqek8yt4	pexels-bob-price-252175-764880.jpg	\N	\N	1280	854	{"large": {"ext": ".jpg", "url": "/uploads/large_pexels_bob_price_252175_764880_5839d81733.jpg", "hash": "large_pexels_bob_price_252175_764880_5839d81733", "mime": "image/jpeg", "name": "large_pexels-bob-price-252175-764880.jpg", "path": null, "size": 44.48, "width": 1000, "height": 667, "sizeInBytes": 44479}, "small": {"ext": ".jpg", "url": "/uploads/small_pexels_bob_price_252175_764880_5839d81733.jpg", "hash": "small_pexels_bob_price_252175_764880_5839d81733", "mime": "image/jpeg", "name": "small_pexels-bob-price-252175-764880.jpg", "path": null, "size": 12.94, "width": 500, "height": 334, "sizeInBytes": 12944}, "medium": {"ext": ".jpg", "url": "/uploads/medium_pexels_bob_price_252175_764880_5839d81733.jpg", "hash": "medium_pexels_bob_price_252175_764880_5839d81733", "mime": "image/jpeg", "name": "medium_pexels-bob-price-252175-764880.jpg", "path": null, "size": 26.75, "width": 750, "height": 500, "sizeInBytes": 26748}, "thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_pexels_bob_price_252175_764880_5839d81733.jpg", "hash": "thumbnail_pexels_bob_price_252175_764880_5839d81733", "mime": "image/jpeg", "name": "thumbnail_pexels-bob-price-252175-764880.jpg", "path": null, "size": 3.66, "width": 234, "height": 156, "sizeInBytes": 3662}}	pexels_bob_price_252175_764880_5839d81733	.jpg	image/jpeg	54.83	/uploads/pexels_bob_price_252175_764880_5839d81733.jpg	\N	local	\N	/	2024-11-21 13:51:34.16	2024-11-21 13:51:34.16	2024-11-21 13:51:34.16	1	1	\N
3	be56xfedrary2oh9b9zp9oun	pexels-apasaric-2602132.jpg	\N	\N	1280	853	{"large": {"ext": ".jpg", "url": "/uploads/large_pexels_apasaric_2602132_a3c18b0f15.jpg", "hash": "large_pexels_apasaric_2602132_a3c18b0f15", "mime": "image/jpeg", "name": "large_pexels-apasaric-2602132.jpg", "path": null, "size": 89.93, "width": 1000, "height": 666, "sizeInBytes": 89928}, "small": {"ext": ".jpg", "url": "/uploads/small_pexels_apasaric_2602132_a3c18b0f15.jpg", "hash": "small_pexels_apasaric_2602132_a3c18b0f15", "mime": "image/jpeg", "name": "small_pexels-apasaric-2602132.jpg", "path": null, "size": 21.65, "width": 500, "height": 333, "sizeInBytes": 21650}, "medium": {"ext": ".jpg", "url": "/uploads/medium_pexels_apasaric_2602132_a3c18b0f15.jpg", "hash": "medium_pexels_apasaric_2602132_a3c18b0f15", "mime": "image/jpeg", "name": "medium_pexels-apasaric-2602132.jpg", "path": null, "size": 48.49, "width": 750, "height": 500, "sizeInBytes": 48489}, "thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_pexels_apasaric_2602132_a3c18b0f15.jpg", "hash": "thumbnail_pexels_apasaric_2602132_a3c18b0f15", "mime": "image/jpeg", "name": "thumbnail_pexels-apasaric-2602132.jpg", "path": null, "size": 6.35, "width": 234, "height": 156, "sizeInBytes": 6350}}	pexels_apasaric_2602132_a3c18b0f15	.jpg	image/jpeg	125.20	/uploads/pexels_apasaric_2602132_a3c18b0f15.jpg	\N	local	\N	/	2024-11-21 13:51:34.172	2024-11-21 13:51:34.172	2024-11-21 13:51:34.173	1	1	\N
4	wbaiov8g3ajoufy5465cu331	pexels-bakr-magrabi-928159-3203659.jpg	\N	\N	1280	720	{"large": {"ext": ".jpg", "url": "/uploads/large_pexels_bakr_magrabi_928159_3203659_5d2bc2b361.jpg", "hash": "large_pexels_bakr_magrabi_928159_3203659_5d2bc2b361", "mime": "image/jpeg", "name": "large_pexels-bakr-magrabi-928159-3203659.jpg", "path": null, "size": 51.15, "width": 1000, "height": 563, "sizeInBytes": 51149}, "small": {"ext": ".jpg", "url": "/uploads/small_pexels_bakr_magrabi_928159_3203659_5d2bc2b361.jpg", "hash": "small_pexels_bakr_magrabi_928159_3203659_5d2bc2b361", "mime": "image/jpeg", "name": "small_pexels-bakr-magrabi-928159-3203659.jpg", "path": null, "size": 11.57, "width": 500, "height": 281, "sizeInBytes": 11568}, "medium": {"ext": ".jpg", "url": "/uploads/medium_pexels_bakr_magrabi_928159_3203659_5d2bc2b361.jpg", "hash": "medium_pexels_bakr_magrabi_928159_3203659_5d2bc2b361", "mime": "image/jpeg", "name": "medium_pexels-bakr-magrabi-928159-3203659.jpg", "path": null, "size": 27.37, "width": 750, "height": 422, "sizeInBytes": 27372}, "thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_pexels_bakr_magrabi_928159_3203659_5d2bc2b361.jpg", "hash": "thumbnail_pexels_bakr_magrabi_928159_3203659_5d2bc2b361", "mime": "image/jpeg", "name": "thumbnail_pexels-bakr-magrabi-928159-3203659.jpg", "path": null, "size": 3.28, "width": 245, "height": 138, "sizeInBytes": 3277}}	pexels_bakr_magrabi_928159_3203659_5d2bc2b361	.jpg	image/jpeg	64.25	/uploads/pexels_bakr_magrabi_928159_3203659_5d2bc2b361.jpg	\N	local	\N	/	2024-11-21 13:51:34.158	2024-11-21 13:51:34.158	2024-11-21 13:51:34.158	1	1	\N
7	y5012hszx5kazkj6fddljrud	mac-04.jpg	\N	\N	1082	960	{"thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_mac_04_5967e9518c.jpg", "hash": "thumbnail_mac_04_5967e9518c", "mime": "image/jpeg", "name": "thumbnail_mac-04.jpg", "path": null, "size": 36.47, "width": 176, "height": 156, "sizeInBytes": 36473}}	mac_04_5967e9518c	.jpg	image/jpeg	188.03	/uploads/mac_04_5967e9518c.jpg	\N	local	\N	/	2024-11-26 12:41:45.785	2024-11-26 12:41:45.785	2024-11-26 12:41:45.786	1	1	\N
8	pudh79dqbv1b6pfyhfz97v0b	mac-05.jpg	\N	\N	1232	960	{"thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_mac_05_2c7b76528a.jpg", "hash": "thumbnail_mac_05_2c7b76528a", "mime": "image/jpeg", "name": "thumbnail_mac-05.jpg", "path": null, "size": 43.1, "width": 200, "height": 156, "sizeInBytes": 43100}}	mac_05_2c7b76528a	.jpg	image/jpeg	225.02	/uploads/mac_05_2c7b76528a.jpg	\N	local	\N	/	2024-11-26 12:41:45.791	2024-11-26 12:41:45.791	2024-11-26 12:41:45.791	1	1	\N
5	x2xyq7p9siey3ws3e7fuvzh4	samsungs20.jpeg	\N	\N	310	163	{"thumbnail": {"ext": ".jpeg", "url": "/uploads/thumbnail_samsungs20_7a0deacf69.jpeg", "hash": "thumbnail_samsungs20_7a0deacf69", "mime": "image/jpeg", "name": "thumbnail_samsungs20.jpeg", "path": null, "size": 8.5, "width": 245, "height": 129, "sizeInBytes": 8497}}	samsungs20_7a0deacf69	.jpeg	image/jpeg	11.80	/uploads/samsungs20_7a0deacf69.jpeg	\N	local	\N	/	2024-11-21 15:15:36.85	2024-12-16 14:07:54.867	2024-11-21 15:15:36.85	1	1	\N
6	ed7ivtrx5uiekdzonxmkb1tc	mac-03.jpg	\N	\N	1044	960	{"thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_mac_03_a05b126b05.jpg", "hash": "thumbnail_mac_03_a05b126b05", "mime": "image/jpeg", "name": "thumbnail_mac-03.jpg", "path": null, "size": 37.3, "width": 170, "height": 156, "sizeInBytes": 37295}}	mac_03_a05b126b05	.jpg	image/jpeg	189.42	/uploads/mac_03_a05b126b05.jpg	\N	local	\N	/	2024-11-26 12:41:45.784	2024-11-26 12:41:45.784	2024-11-26 12:41:45.785	1	1	\N
10	ckj6z3g7l8vaccy0gut62ris	mac-01.jpg	\N	\N	1161	960	{"thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_mac_01_b87b7f4ea1.jpg", "hash": "thumbnail_mac_01_b87b7f4ea1", "mime": "image/jpeg", "name": "thumbnail_mac-01.jpg", "path": null, "size": 55.53, "width": 189, "height": 156, "sizeInBytes": 55534}}	mac_01_b87b7f4ea1	.jpg	image/jpeg	303.19	/uploads/mac_01_b87b7f4ea1.jpg	\N	local	\N	/	2024-11-26 12:41:46.54	2024-11-26 12:42:37.173	2024-11-26 12:41:46.541	1	1	\N
11	alhd2x2z4bf1h3zm7oyydp6w	81mJ-Mdc-OL._AC_SL1500_.jpg	\N	\N	1448	1500	{"thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_81m_J_Mdc_OL_AC_SL_1500_ba9b7ff143.jpg", "hash": "thumbnail_81m_J_Mdc_OL_AC_SL_1500_ba9b7ff143", "mime": "image/jpeg", "name": "thumbnail_81mJ-Mdc-OL._AC_SL1500_.jpg", "path": null, "size": 2.82, "width": 151, "height": 156, "sizeInBytes": 2822}}	81m_J_Mdc_OL_AC_SL_1500_ba9b7ff143	.jpg	image/jpeg	104.56	/uploads/81m_J_Mdc_OL_AC_SL_1500_ba9b7ff143.jpg	\N	local	\N	/	2024-11-26 14:20:30.023	2024-11-26 14:20:30.023	2024-11-26 14:20:30.024	1	1	\N
13	s7o0ttvx9ydhoky2xo053mgx	91GsCwayBPL._AC_SL1500_.jpg	\N	\N	1500	1331	{"thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_91_Gs_Cway_BPL_AC_SL_1500_96900aa3eb.jpg", "hash": "thumbnail_91_Gs_Cway_BPL_AC_SL_1500_96900aa3eb", "mime": "image/jpeg", "name": "thumbnail_91GsCwayBPL._AC_SL1500_.jpg", "path": null, "size": 5.35, "width": 176, "height": 156, "sizeInBytes": 5354}}	91_Gs_Cway_BPL_AC_SL_1500_96900aa3eb	.jpg	image/jpeg	291.12	/uploads/91_Gs_Cway_BPL_AC_SL_1500_96900aa3eb.jpg	\N	local	\N	/	2024-11-26 14:20:30.096	2024-11-26 14:20:30.096	2024-11-26 14:20:30.096	1	1	\N
14	ebiaujm2t1rfw906dz2v5qhx	91GRfDGDJIL._AC_SL1500_.jpg	\N	\N	1500	1331	{"thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_91_G_Rf_DGDJIL_AC_SL_1500_60bfb7f367.jpg", "hash": "thumbnail_91_G_Rf_DGDJIL_AC_SL_1500_60bfb7f367", "mime": "image/jpeg", "name": "thumbnail_91GRfDGDJIL._AC_SL1500_.jpg", "path": null, "size": 5.44, "width": 176, "height": 156, "sizeInBytes": 5441}}	91_G_Rf_DGDJIL_AC_SL_1500_60bfb7f367	.jpg	image/jpeg	299.18	/uploads/91_G_Rf_DGDJIL_AC_SL_1500_60bfb7f367.jpg	\N	local	\N	/	2024-11-26 14:20:30.131	2024-11-26 14:20:30.131	2024-11-26 14:20:30.132	1	1	\N
12	rkhi29kkugi5iktkghmc2h02	81aot0jAfFL._AC_SL1500_.jpg	\N	\N	1500	1395	{"thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_81aot0j_Af_FL_AC_SL_1500_200a16e5f9.jpg", "hash": "thumbnail_81aot0j_Af_FL_AC_SL_1500_200a16e5f9", "mime": "image/jpeg", "name": "thumbnail_81aot0jAfFL._AC_SL1500_.jpg", "path": null, "size": 6.36, "width": 168, "height": 156, "sizeInBytes": 6357}}	81aot0j_Af_FL_AC_SL_1500_200a16e5f9	.jpg	image/jpeg	170.36	/uploads/81aot0j_Af_FL_AC_SL_1500_200a16e5f9.jpg	\N	local	\N	/	2024-11-26 14:20:30.054	2024-11-26 15:59:15.739	2024-11-26 14:20:30.054	1	1	\N
15	jbzz7kq65c8bzzygsqixr7tg	518BDtLVKCL.jpg	\N	\N	973	1000	{"thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_518_B_Dt_LVKCL_6f27ad4900.jpg", "hash": "thumbnail_518_B_Dt_LVKCL_6f27ad4900", "mime": "image/jpeg", "name": "thumbnail_518BDtLVKCL.jpg", "path": null, "size": 2.83, "width": 152, "height": 156, "sizeInBytes": 2827}}	518_B_Dt_LVKCL_6f27ad4900	.jpg	image/jpeg	53.85	/uploads/518_B_Dt_LVKCL_6f27ad4900.jpg	\N	local	\N	/	2024-11-28 09:59:42.865	2024-11-28 09:59:42.865	2024-11-28 09:59:42.866	1	1	\N
17	kbcebeamutli84ci12zgsmbb	tp1400.jpg	\N	\N	1976	1284	{"thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_tp1400_7937f9999f.jpg", "hash": "thumbnail_tp1400_7937f9999f", "mime": "image/jpeg", "name": "thumbnail_tp1400.jpg", "path": null, "size": 8.42, "width": 240, "height": 156, "sizeInBytes": 8419}}	tp1400_7937f9999f	.jpg	image/jpeg	303.14	/uploads/tp1400_7937f9999f.jpg	\N	local	\N	/	2024-11-28 09:59:43.005	2024-11-28 09:59:43.005	2024-11-28 09:59:43.005	1	1	\N
9	qn80f9c97enm4yxqercse1pf	mac-02.jpg	\N	\N	1280	960	{"thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_mac_02_b535bdb301.jpg", "hash": "thumbnail_mac_02_b535bdb301", "mime": "image/jpeg", "name": "thumbnail_mac-02.jpg", "path": null, "size": 69.62, "width": 208, "height": 156, "sizeInBytes": 69619}}	mac_02_b535bdb301	.jpg	image/jpeg	571.32	/uploads/mac_02_b535bdb301.jpg	\N	local	\N	/	2024-11-26 12:41:46.476	2024-12-03 14:13:10.86	2024-11-26 12:41:46.476	1	1	\N
1	jp8cfdeoehl2uqwrr0dgtg7x	blog-image-02.jpg	\N	\N	800	600	{"small": {"ext": ".jpg", "url": "/uploads/small_blog_image_02_a7bf799d4d.jpg", "hash": "small_blog_image_02_a7bf799d4d", "mime": "image/jpeg", "name": "small_blog-image-02.jpg", "path": null, "size": 20.08, "width": 500, "height": 375, "sizeInBytes": 20078}, "medium": {"ext": ".jpg", "url": "/uploads/medium_blog_image_02_a7bf799d4d.jpg", "hash": "medium_blog_image_02_a7bf799d4d", "mime": "image/jpeg", "name": "medium_blog-image-02.jpg", "path": null, "size": 44.07, "width": 750, "height": 563, "sizeInBytes": 44071}, "thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_blog_image_02_a7bf799d4d.jpg", "hash": "thumbnail_blog_image_02_a7bf799d4d", "mime": "image/jpeg", "name": "thumbnail_blog-image-02.jpg", "path": null, "size": 3.9, "width": 208, "height": 156, "sizeInBytes": 3901}}	blog_image_02_a7bf799d4d	.jpg	image/jpeg	49.28	/uploads/blog_image_02_a7bf799d4d.jpg	\N	local	\N	/	2024-11-21 13:50:54.666	2024-12-05 13:48:40.075	2024-11-21 13:50:54.666	1	1	\N
18	m5vx88o24k0oqk5uzuv4s0ra	hp-probook-440-g6-8145u-14-1680260518.jpg	\N	\N	1500	981	{"thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_hp_probook_440_g6_8145u_14_1680260518_446fa68c0b.jpg", "hash": "thumbnail_hp_probook_440_g6_8145u_14_1680260518_446fa68c0b", "mime": "image/jpeg", "name": "thumbnail_hp-probook-440-g6-8145u-14-1680260518.jpg", "path": null, "size": 6.56, "width": 239, "height": 156, "sizeInBytes": 6556}}	hp_probook_440_g6_8145u_14_1680260518_446fa68c0b	.jpg	image/jpeg	132.06	/uploads/hp_probook_440_g6_8145u_14_1680260518_446fa68c0b.jpg	\N	local	\N	/	2024-12-17 15:57:34.791	2025-01-14 16:58:18.632	2024-12-17 15:57:34.792	1	1	\N
16	oyimdyajchmp812uvtghah5n	tp1400-3.jpg	\N	\N	1992	1212	{"thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_tp1400_3_f701383a42.jpg", "hash": "thumbnail_tp1400_3_f701383a42", "mime": "image/jpeg", "name": "thumbnail_tp1400-3.jpg", "path": null, "size": 4.25, "width": 245, "height": 149, "sizeInBytes": 4252}}	tp1400_3_f701383a42	.jpg	image/jpeg	107.53	/uploads/tp1400_3_f701383a42.jpg	\N	local	\N	/	2024-11-28 09:59:42.992	2025-01-29 14:11:02.126	2024-11-28 09:59:42.993	1	1	\N
19	ibtppx5pe0t8n34gpblyn4l0	phone-sample-img.avif	\N	\N	\N	\N	\N	phone_sample_img_2d53c12542	.avif	image/avif	96.81	/uploads/phone_sample_img_2d53c12542.avif	\N	local	\N	/	2025-02-03 10:32:32.104	2025-02-03 10:32:32.104	2025-02-03 10:32:32.105	1	1	\N
21	ka6nc9qwso45hty5oyvmzjes	BEST-40-TO-49-INCH-TV-2048px-samsungqn90Dhero-3x2-1.jpg	\N	\N	2048	1365	{"thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_BEST_40_TO_49_INCH_TV_2048px_samsungqn90_Dhero_3x2_1_442d3375c1.jpg", "hash": "thumbnail_BEST_40_TO_49_INCH_TV_2048px_samsungqn90_Dhero_3x2_1_442d3375c1", "mime": "image/jpeg", "name": "thumbnail_BEST-40-TO-49-INCH-TV-2048px-samsungqn90Dhero-3x2-1.jpg", "path": null, "size": 8.5, "width": 234, "height": 156, "sizeInBytes": 8497}}	BEST_40_TO_49_INCH_TV_2048px_samsungqn90_Dhero_3x2_1_442d3375c1	.jpg	image/jpeg	279.64	/uploads/BEST_40_TO_49_INCH_TV_2048px_samsungqn90_Dhero_3x2_1_442d3375c1.jpg	\N	local	\N	/	2025-02-05 12:26:58.738	2025-02-05 12:26:58.738	2025-02-05 12:26:58.738	1	1	\N
20	ej9ryzeca4qjcy4p8cydngxq	BEST-LAPTOPS-PHOTO-VIDEO-EDITING-2048px-asus3.jpg	\N	\N	2048	1366	{"thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_BEST_LAPTOPS_PHOTO_VIDEO_EDITING_2048px_asus3_e16810cdbf.jpg", "hash": "thumbnail_BEST_LAPTOPS_PHOTO_VIDEO_EDITING_2048px_asus3_e16810cdbf", "mime": "image/jpeg", "name": "thumbnail_BEST-LAPTOPS-PHOTO-VIDEO-EDITING-2048px-asus3.jpg", "path": null, "size": 5.63, "width": 234, "height": 156, "sizeInBytes": 5630}}	BEST_LAPTOPS_PHOTO_VIDEO_EDITING_2048px_asus3_e16810cdbf	.jpg	image/jpeg	150.90	/uploads/BEST_LAPTOPS_PHOTO_VIDEO_EDITING_2048px_asus3_e16810cdbf.jpg	\N	local	\N	/	2025-02-05 12:26:58.723	2025-02-05 12:26:58.723	2025-02-05 12:26:58.725	1	1	\N
23	sr9j4c66cu1j7jsgzxz6asst	cheapgaminglaptops-2048px-7981.webp	\N	\N	2048	1366	{"thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_cheapgaminglaptops_2048px_7981_0572b4454f.webp", "hash": "thumbnail_cheapgaminglaptops_2048px_7981_0572b4454f", "mime": "image/webp", "name": "thumbnail_cheapgaminglaptops-2048px-7981.webp", "path": null, "size": 3.36, "width": 234, "height": 156, "sizeInBytes": 3364}}	cheapgaminglaptops_2048px_7981_0572b4454f	.webp	image/webp	71.59	/uploads/cheapgaminglaptops_2048px_7981_0572b4454f.webp	\N	local	\N	/	2025-02-05 12:26:59.052	2025-02-05 12:26:59.052	2025-02-05 12:26:59.052	1	1	\N
24	w6dl2tth2cqbtcx1shtr89yn	laptops-2048px-8826.webp	\N	\N	2048	1366	{"thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_laptops_2048px_8826_ff5491d925.webp", "hash": "thumbnail_laptops_2048px_8826_ff5491d925", "mime": "image/webp", "name": "thumbnail_laptops-2048px-8826.webp", "path": null, "size": 2.53, "width": 234, "height": 156, "sizeInBytes": 2528}}	laptops_2048px_8826_ff5491d925	.webp	image/webp	81.38	/uploads/laptops_2048px_8826_ff5491d925.webp	\N	local	\N	/	2025-02-05 12:26:59.109	2025-02-05 12:26:59.109	2025-02-05 12:26:59.109	1	1	\N
25	yr9cvatmdkcbnebi8a4slfv1	BEST-WINDOWS-ULTRABOOKS-2048px-5681.jpg	\N	\N	2048	1365	{"thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_BEST_WINDOWS_ULTRABOOKS_2048px_5681_7306389002.jpg", "hash": "thumbnail_BEST_WINDOWS_ULTRABOOKS_2048px_5681_7306389002", "mime": "image/jpeg", "name": "thumbnail_BEST-WINDOWS-ULTRABOOKS-2048px-5681.jpg", "path": null, "size": 3.97, "width": 234, "height": 156, "sizeInBytes": 3974}}	BEST_WINDOWS_ULTRABOOKS_2048px_5681_7306389002	.jpg	image/jpeg	232.95	/uploads/BEST_WINDOWS_ULTRABOOKS_2048px_5681_7306389002.jpg	\N	local	\N	/	2025-02-05 12:26:59.277	2025-02-05 12:26:59.277	2025-02-05 12:26:59.277	1	1	\N
27	n7frxwzcsjuax44nxp8ds5gt	timg-laptops-notebooks.jpg	\N	\N	1000	674	{"thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_timg_laptops_notebooks_987b7a7094.jpg", "hash": "thumbnail_timg_laptops_notebooks_987b7a7094", "mime": "image/jpeg", "name": "thumbnail_timg-laptops-notebooks.jpg", "path": null, "size": 6.86, "width": 231, "height": 156, "sizeInBytes": 6859}}	timg_laptops_notebooks_987b7a7094	.jpg	image/jpeg	54.86	/uploads/timg_laptops_notebooks_987b7a7094.jpg	\N	local	\N	/	2025-02-05 12:26:59.44	2025-02-05 12:26:59.44	2025-02-05 12:26:59.44	1	1	\N
30	jjfky16f7h62ly9gw32eg9h7	razer-blade-15-OLED-01.webp	\N	\N	1500	1000	{"thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_razer_blade_15_OLED_01_5cd982fe16.webp", "hash": "thumbnail_razer_blade_15_OLED_01_5cd982fe16", "mime": "image/webp", "name": "thumbnail_razer-blade-15-OLED-01.webp", "path": null, "size": 4.75, "width": 234, "height": 156, "sizeInBytes": 4750}}	razer_blade_15_OLED_01_5cd982fe16	.webp	image/webp	54.55	/uploads/razer_blade_15_OLED_01_5cd982fe16.webp	\N	local	\N	/	2025-02-05 12:26:59.794	2025-02-05 12:26:59.794	2025-02-05 12:26:59.794	1	1	\N
33	yrjl5gh1tnnsjzd648a59n27	6537436_sd.webp	\N	\N	1501	1104	{"thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_6537436_sd_1e2240f4e2.webp", "hash": "thumbnail_6537436_sd_1e2240f4e2", "mime": "image/webp", "name": "thumbnail_6537436_sd.webp", "path": null, "size": 4.23, "width": 212, "height": 156, "sizeInBytes": 4226}}	6537436_sd_1e2240f4e2	.webp	image/webp	64.22	/uploads/6537436_sd_1e2240f4e2.webp	\N	local	\N	/	2025-02-05 12:27:00.27	2025-02-05 12:27:00.27	2025-02-05 12:27:00.27	1	1	\N
22	hgw1ehwnk4d0ct1u4p85y5su	BVEST-32-INCH-TVS-2048px-2870-3x2-1.jpg	\N	\N	2048	1536	{"thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_BVEST_32_INCH_TVS_2048px_2870_3x2_1_1afb5c7ae2.jpg", "hash": "thumbnail_BVEST_32_INCH_TVS_2048px_2870_3x2_1_1afb5c7ae2", "mime": "image/jpeg", "name": "thumbnail_BVEST-32-INCH-TVS-2048px-2870-3x2-1.jpg", "path": null, "size": 6.41, "width": 208, "height": 156, "sizeInBytes": 6411}}	BVEST_32_INCH_TVS_2048px_2870_3x2_1_1afb5c7ae2	.jpg	image/jpeg	560.84	/uploads/BVEST_32_INCH_TVS_2048px_2870_3x2_1_1afb5c7ae2.jpg	\N	local	\N	/	2025-02-05 12:26:58.739	2025-02-05 12:51:38.817	2025-02-05 12:26:58.74	1	1	\N
26	j3psr5jfls3pjnfu9e9ii7ok	ultrabooks-2048px-0883.jpg	\N	\N	2048	1365	{"thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_ultrabooks_2048px_0883_7dd44c19d2.jpg", "hash": "thumbnail_ultrabooks_2048px_0883_7dd44c19d2", "mime": "image/jpeg", "name": "thumbnail_ultrabooks-2048px-0883.jpg", "path": null, "size": 4.46, "width": 234, "height": 156, "sizeInBytes": 4462}}	ultrabooks_2048px_0883_7dd44c19d2	.jpg	image/jpeg	139.35	/uploads/ultrabooks_2048px_0883_7dd44c19d2.jpg	\N	local	\N	/	2025-02-05 12:26:59.28	2025-02-05 12:26:59.28	2025-02-05 12:26:59.281	1	1	\N
29	cf19fv1z5ahpabjra7a72jo9	bestlaptops-2048px-9765.webp	\N	\N	2048	1366	{"thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_bestlaptops_2048px_9765_a8e289f3ac.webp", "hash": "thumbnail_bestlaptops_2048px_9765_a8e289f3ac", "mime": "image/webp", "name": "thumbnail_bestlaptops-2048px-9765.webp", "path": null, "size": 3.31, "width": 234, "height": 156, "sizeInBytes": 3310}}	bestlaptops_2048px_9765_a8e289f3ac	.webp	image/webp	54.81	/uploads/bestlaptops_2048px_9765_a8e289f3ac.webp	\N	local	\N	/	2025-02-05 12:26:59.754	2025-02-05 12:26:59.754	2025-02-05 12:26:59.755	1	1	\N
31	u3uvo0q7bh15ysfibitnqxd3	mac-mini-2023-angled-side-920x613.avif	\N	\N	\N	\N	\N	mac_mini_2023_angled_side_920x613_4c72d68b74	.avif	image/avif	17.07	/uploads/mac_mini_2023_angled_side_920x613_4c72d68b74.avif	\N	local	\N	/	2025-02-05 12:26:59.855	2025-02-05 12:26:59.855	2025-02-05 12:26:59.855	1	1	\N
37	tp1yzqushr04ck31000quvtu	4kmonitors-2048px-9794.jpg	\N	\N	2048	1365	{"thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_4kmonitors_2048px_9794_d1173116ca.jpg", "hash": "thumbnail_4kmonitors_2048px_9794_d1173116ca", "mime": "image/jpeg", "name": "thumbnail_4kmonitors-2048px-9794.jpg", "path": null, "size": 4.74, "width": 234, "height": 156, "sizeInBytes": 4737}}	4kmonitors_2048px_9794_d1173116ca	.jpg	image/jpeg	96.94	/uploads/4kmonitors_2048px_9794_d1173116ca.jpg	\N	local	\N	/	2025-02-05 12:27:00.446	2025-02-05 12:27:00.446	2025-02-05 12:27:00.447	1	1	\N
38	z5x03uwdbedy7xu6sairlf20	BEST-LAPTOPS-UNDER-500-2048px-aceraspire3.png	\N	\N	2048	1365	{"thumbnail": {"ext": ".png", "url": "/uploads/thumbnail_BEST_LAPTOPS_UNDER_500_2048px_aceraspire3_71ad811af9.png", "hash": "thumbnail_BEST_LAPTOPS_UNDER_500_2048px_aceraspire3_71ad811af9", "mime": "image/png", "name": "thumbnail_BEST-LAPTOPS-UNDER-500-2048px-aceraspire3.png", "path": null, "size": 44, "width": 234, "height": 156, "sizeInBytes": 43996}}	BEST_LAPTOPS_UNDER_500_2048px_aceraspire3_71ad811af9	.png	image/png	531.94	/uploads/BEST_LAPTOPS_UNDER_500_2048px_aceraspire3_71ad811af9.png	\N	local	\N	/	2025-02-05 12:27:01.507	2025-02-05 12:27:01.507	2025-02-05 12:27:01.508	1	1	\N
35	h3vn68y796e0gzr8da6kgcgr	27-inch-monitor-2048px-1572.jpg	\N	\N	2048	1365	{"thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_27_inch_monitor_2048px_1572_ac481a0a49.jpg", "hash": "thumbnail_27_inch_monitor_2048px_1572_ac481a0a49", "mime": "image/jpeg", "name": "thumbnail_27-inch-monitor-2048px-1572.jpg", "path": null, "size": 4.48, "width": 234, "height": 156, "sizeInBytes": 4479}}	27_inch_monitor_2048px_1572_ac481a0a49	.jpg	image/jpeg	100.91	/uploads/27_inch_monitor_2048px_1572_ac481a0a49.jpg	\N	local	\N	/	2025-02-05 12:27:00.289	2025-02-05 12:39:06.196	2025-02-05 12:27:00.289	1	1	\N
28	jdtbij8gg6d4xgsx41x15t58	9ea6043b-b559-45fb-9a92-93a619859402.webp	\N	\N	1239	808	{"thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_9ea6043b_b559_45fb_9a92_93a619859402_9b20fb1b54.webp", "hash": "thumbnail_9ea6043b_b559_45fb_9a92_93a619859402_9b20fb1b54", "mime": "image/webp", "name": "thumbnail_9ea6043b-b559-45fb-9a92-93a619859402.webp", "path": null, "size": 2.54, "width": 239, "height": 156, "sizeInBytes": 2540}}	9ea6043b_b559_45fb_9a92_93a619859402_9b20fb1b54	.webp	image/webp	36.94	/uploads/9ea6043b_b559_45fb_9a92_93a619859402_9b20fb1b54.webp	\N	local	\N	/	2025-02-05 12:26:59.753	2025-02-05 12:26:59.753	2025-02-05 12:26:59.754	1	1	\N
32	nyjbehg7r50iybztfba6r610	surface-laptop-7-06.webp	\N	\N	1000	600	{"thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_surface_laptop_7_06_55e25e376c.webp", "hash": "thumbnail_surface_laptop_7_06_55e25e376c", "mime": "image/webp", "name": "thumbnail_surface-laptop-7-06.webp", "path": null, "size": 3.28, "width": 245, "height": 147, "sizeInBytes": 3278}}	surface_laptop_7_06_55e25e376c	.webp	image/webp	19.31	/uploads/surface_laptop_7_06_55e25e376c.webp	\N	local	\N	/	2025-02-05 12:26:59.949	2025-02-05 12:26:59.949	2025-02-05 12:26:59.949	1	1	\N
34	z5qfzdhz8i0uwdetkjwnyzud	U7W9NSAcbpRPYGv7VZetiV-1200-80.jpg	\N	\N	1200	675	{"thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_U7_W9_NS_Acbp_RPY_Gv7_V_Zeti_V_1200_80_205179b22c.jpg", "hash": "thumbnail_U7_W9_NS_Acbp_RPY_Gv7_V_Zeti_V_1200_80_205179b22c", "mime": "image/jpeg", "name": "thumbnail_U7W9NSAcbpRPYGv7VZetiV-1200-80.jpg", "path": null, "size": 4.56, "width": 245, "height": 138, "sizeInBytes": 4555}}	U7_W9_NS_Acbp_RPY_Gv7_V_Zeti_V_1200_80_205179b22c	.jpg	image/jpeg	36.90	/uploads/U7_W9_NS_Acbp_RPY_Gv7_V_Zeti_V_1200_80_205179b22c.jpg	\N	local	\N	/	2025-02-05 12:27:00.272	2025-02-05 12:27:22.057	2025-02-05 12:27:00.272	1	1	\N
39	hyezi7166tx237n8uxu7i7c3	iphonese.webp	\N	\N	710	473	{"thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_iphonese_17d200a48d.webp", "hash": "thumbnail_iphonese_17d200a48d", "mime": "image/webp", "name": "thumbnail_iphonese.webp", "path": null, "size": 4.26, "width": 234, "height": 156, "sizeInBytes": 4260}}	iphonese_17d200a48d	.webp	image/webp	16.24	/uploads/iphonese_17d200a48d.webp	\N	local	\N	/	2025-02-05 12:37:06.686	2025-02-05 12:37:06.686	2025-02-05 12:37:06.686	1	1	\N
40	huiw0tkiv83qu6bwgm5qktlo	dell-s2722dc-27-tums-ips-skarm-med-65w-usb-c-power-delivery-ergonomisk-fot (2).jpg	\N	\N	800	800	{"thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_dell_s2722dc_27_tums_ips_skarm_med_65w_usb_c_power_delivery_ergonomisk_fot_2_d923e9f235.jpg", "hash": "thumbnail_dell_s2722dc_27_tums_ips_skarm_med_65w_usb_c_power_delivery_ergonomisk_fot_2_d923e9f235", "mime": "image/jpeg", "name": "thumbnail_dell-s2722dc-27-tums-ips-skarm-med-65w-usb-c-power-delivery-ergonomisk-fot (2).jpg", "path": null, "size": 1.51, "width": 156, "height": 156, "sizeInBytes": 1506}}	dell_s2722dc_27_tums_ips_skarm_med_65w_usb_c_power_delivery_ergonomisk_fot_2_d923e9f235	.jpg	image/jpeg	17.28	/uploads/dell_s2722dc_27_tums_ips_skarm_med_65w_usb_c_power_delivery_ergonomisk_fot_2_d923e9f235.jpg	\N	local	\N	/	2025-02-05 12:40:58.879	2025-02-05 12:40:58.879	2025-02-05 12:40:58.879	1	1	\N
41	w4ae50pedodexkij774fp0yy	dell-s2722dc-27-tums-ips-skarm-med-65w-usb-c-power-delivery-ergonomisk-fot (1).jpg	\N	\N	800	800	{"thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_dell_s2722dc_27_tums_ips_skarm_med_65w_usb_c_power_delivery_ergonomisk_fot_1_561fd22116.jpg", "hash": "thumbnail_dell_s2722dc_27_tums_ips_skarm_med_65w_usb_c_power_delivery_ergonomisk_fot_1_561fd22116", "mime": "image/jpeg", "name": "thumbnail_dell-s2722dc-27-tums-ips-skarm-med-65w-usb-c-power-delivery-ergonomisk-fot (1).jpg", "path": null, "size": 1.99, "width": 156, "height": 156, "sizeInBytes": 1991}}	dell_s2722dc_27_tums_ips_skarm_med_65w_usb_c_power_delivery_ergonomisk_fot_1_561fd22116	.jpg	image/jpeg	54.98	/uploads/dell_s2722dc_27_tums_ips_skarm_med_65w_usb_c_power_delivery_ergonomisk_fot_1_561fd22116.jpg	\N	local	\N	/	2025-02-05 12:40:58.886	2025-02-05 12:40:58.886	2025-02-05 12:40:58.886	1	1	\N
42	v7h7uonc9vuum6n9jlhdak0l	dell-s2722dc-27-tums-ips-skarm-med-65w-usb-c-power-delivery-ergonomisk-fot.jpg	\N	\N	800	800	{"thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_dell_s2722dc_27_tums_ips_skarm_med_65w_usb_c_power_delivery_ergonomisk_fot_863b355b1f.jpg", "hash": "thumbnail_dell_s2722dc_27_tums_ips_skarm_med_65w_usb_c_power_delivery_ergonomisk_fot_863b355b1f", "mime": "image/jpeg", "name": "thumbnail_dell-s2722dc-27-tums-ips-skarm-med-65w-usb-c-power-delivery-ergonomisk-fot.jpg", "path": null, "size": 4.24, "width": 156, "height": 156, "sizeInBytes": 4235}}	dell_s2722dc_27_tums_ips_skarm_med_65w_usb_c_power_delivery_ergonomisk_fot_863b355b1f	.jpg	image/jpeg	67.75	/uploads/dell_s2722dc_27_tums_ips_skarm_med_65w_usb_c_power_delivery_ergonomisk_fot_863b355b1f.jpg	\N	local	\N	/	2025-02-05 12:40:58.897	2025-02-05 12:40:58.897	2025-02-05 12:40:58.897	1	1	\N
36	yizpx5nk2j6twrxihrut5cdf	2BCok7KHhx2WmNGn4DJooZ.jpg	\N	\N	1920	1080	{"thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_2_B_Cok7_K_Hhx2_Wm_N_Gn4_D_Joo_Z_00da6ba06b.jpg", "hash": "thumbnail_2_B_Cok7_K_Hhx2_Wm_N_Gn4_D_Joo_Z_00da6ba06b", "mime": "image/jpeg", "name": "thumbnail_2BCok7KHhx2WmNGn4DJooZ.jpg", "path": null, "size": 8.61, "width": 245, "height": 138, "sizeInBytes": 8610}}	2_B_Cok7_K_Hhx2_Wm_N_Gn4_D_Joo_Z_00da6ba06b	.jpg	image/jpeg	209.59	/uploads/2_B_Cok7_K_Hhx2_Wm_N_Gn4_D_Joo_Z_00da6ba06b.jpg	\N	local	\N	/	2025-02-05 12:27:00.291	2025-02-05 12:43:38.708	2025-02-05 12:27:00.291	1	1	\N
43	m4dq00j28swpjnqrn34i3dgw	apple-ipad-5th-gen-32gb-space-grey-med-1-ars-garanti-beg.jpg	\N	\N	800	800	{"thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_apple_ipad_5th_gen_32gb_space_grey_med_1_ars_garanti_beg_4cea59cb42.jpg", "hash": "thumbnail_apple_ipad_5th_gen_32gb_space_grey_med_1_ars_garanti_beg_4cea59cb42", "mime": "image/jpeg", "name": "thumbnail_apple-ipad-5th-gen-32gb-space-grey-med-1-ars-garanti-beg.jpg", "path": null, "size": 2.07, "width": 156, "height": 156, "sizeInBytes": 2070}}	apple_ipad_5th_gen_32gb_space_grey_med_1_ars_garanti_beg_4cea59cb42	.jpg	image/jpeg	20.85	/uploads/apple_ipad_5th_gen_32gb_space_grey_med_1_ars_garanti_beg_4cea59cb42.jpg	\N	local	\N	/	2025-02-05 13:31:55.44	2025-02-05 13:31:55.44	2025-02-05 13:31:55.44	1	1	\N
\.


--
-- Data for Name: files_folder_lnk; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.files_folder_lnk (id, file_id, folder_id, file_ord) FROM stdin;
\.


--
-- Data for Name: files_related_mph; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.files_related_mph (id, file_id, related_id, related_type, field, "order") FROM stdin;
171	9	36	api::product.product	main_picture	1
631	8	211	api::product.product	main_picture	1
5	1	2	api::product.product	main_picture	1
6	2	2	api::product.product	gallery	1
7	3	2	api::product.product	gallery	2
8	4	2	api::product.product	gallery	3
639	8	215	api::product.product	main_picture	1
10	5	4	api::product.product	main_picture	1
16	10	5	api::product.product	main_picture	1
17	9	5	api::product.product	gallery	1
18	8	5	api::product.product	gallery	2
19	7	5	api::product.product	gallery	3
20	6	5	api::product.product	gallery	4
183	10	39	api::product.product	main_picture	1
184	9	39	api::product.product	gallery	1
185	8	39	api::product.product	gallery	2
27	10	6	api::product.product	main_picture	1
28	9	6	api::product.product	gallery	1
29	8	6	api::product.product	gallery	2
30	7	6	api::product.product	gallery	3
31	6	6	api::product.product	gallery	4
32	10	6	api::product.product	gallery	5
43	10	7	api::product.product	main_picture	1
44	9	7	api::product.product	gallery	1
45	8	7	api::product.product	gallery	2
46	7	7	api::product.product	gallery	3
47	6	7	api::product.product	gallery	4
53	10	8	api::product.product	main_picture	1
54	9	8	api::product.product	gallery	1
55	8	8	api::product.product	gallery	2
56	7	8	api::product.product	gallery	3
57	6	8	api::product.product	gallery	4
354	10	46	api::product.product	main_picture	1
355	9	46	api::product.product	gallery	1
356	8	46	api::product.product	gallery	2
357	7	46	api::product.product	gallery	3
358	6	46	api::product.product	gallery	4
63	10	9	api::product.product	main_picture	1
64	9	9	api::product.product	gallery	1
65	8	9	api::product.product	gallery	2
66	7	9	api::product.product	gallery	3
67	6	9	api::product.product	gallery	4
359	11	46	api::product.product	gallery	5
360	12	46	api::product.product	gallery	6
361	13	46	api::product.product	gallery	7
362	14	46	api::product.product	gallery	8
73	10	10	api::product.product	main_picture	1
74	9	10	api::product.product	gallery	1
75	8	10	api::product.product	gallery	2
76	7	10	api::product.product	gallery	3
77	6	10	api::product.product	gallery	4
382	4	48	api::product.product	main_picture	1
388	4	51	api::product.product	main_picture	1
392	4	53	api::product.product	main_picture	1
396	4	55	api::product.product	main_picture	1
400	9	58	api::product.product	main_picture	1
87	10	11	api::product.product	main_picture	1
88	9	11	api::product.product	gallery	1
89	8	11	api::product.product	gallery	2
90	7	11	api::product.product	gallery	3
91	6	11	api::product.product	gallery	4
92	11	11	api::product.product	gallery	5
93	12	11	api::product.product	gallery	6
94	13	11	api::product.product	gallery	7
95	14	11	api::product.product	gallery	8
403	16	60	api::product.product	main_picture	1
97	12	13	api::product.product	main_picture	1
404	16	61	api::product.product	main_picture	1
99	12	14	api::product.product	main_picture	1
101	12	15	api::product.product	main_picture	1
103	12	16	api::product.product	main_picture	1
105	12	17	api::product.product	main_picture	1
107	12	18	api::product.product	main_picture	1
111	16	20	api::product.product	main_picture	1
112	17	20	api::product.product	gallery	1
113	15	20	api::product.product	gallery	2
117	16	21	api::product.product	main_picture	1
118	17	21	api::product.product	gallery	1
119	15	21	api::product.product	gallery	2
129	10	22	api::product.product	main_picture	1
130	9	22	api::product.product	gallery	1
131	8	22	api::product.product	gallery	2
132	7	22	api::product.product	gallery	3
133	6	22	api::product.product	gallery	4
134	11	22	api::product.product	gallery	5
135	12	22	api::product.product	gallery	6
136	13	22	api::product.product	gallery	7
137	14	22	api::product.product	gallery	8
138	12	12	api::product.product	main_picture	1
139	12	23	api::product.product	main_picture	1
141	5	24	api::product.product	main_picture	1
143	9	26	api::product.product	main_picture	1
145	9	33	api::product.product	main_picture	1
155	10	34	api::product.product	main_picture	1
156	9	34	api::product.product	gallery	1
157	8	34	api::product.product	gallery	2
158	7	34	api::product.product	gallery	3
159	6	34	api::product.product	gallery	4
160	11	34	api::product.product	gallery	5
161	12	34	api::product.product	gallery	6
162	13	34	api::product.product	gallery	7
163	14	34	api::product.product	gallery	8
633	8	212	api::product.product	main_picture	1
167	16	35	api::product.product	main_picture	1
168	17	35	api::product.product	gallery	1
169	15	35	api::product.product	gallery	2
408	9	63	api::product.product	main_picture	1
173	9	38	api::product.product	main_picture	1
186	7	39	api::product.product	gallery	3
187	6	39	api::product.product	gallery	4
188	11	39	api::product.product	gallery	5
189	12	39	api::product.product	gallery	6
190	13	39	api::product.product	gallery	7
191	14	39	api::product.product	gallery	8
635	8	213	api::product.product	main_picture	1
410	9	64	api::product.product	main_picture	1
412	9	65	api::product.product	main_picture	1
641	8	216	api::product.product	main_picture	1
414	9	66	api::product.product	main_picture	1
416	9	67	api::product.product	main_picture	1
645	8	218	api::product.product	main_picture	1
201	10	40	api::product.product	main_picture	1
202	9	40	api::product.product	gallery	1
203	8	40	api::product.product	gallery	2
204	7	40	api::product.product	gallery	3
205	6	40	api::product.product	gallery	4
206	11	40	api::product.product	gallery	5
207	12	40	api::product.product	gallery	6
208	13	40	api::product.product	gallery	7
209	14	40	api::product.product	gallery	8
418	9	68	api::product.product	main_picture	1
420	9	69	api::product.product	main_picture	1
649	8	220	api::product.product	main_picture	1
422	9	70	api::product.product	main_picture	1
653	8	222	api::product.product	main_picture	1
425	9	71	api::product.product	main_picture	1
661	8	226	api::product.product	main_picture	1
665	13	233	api::product.product	main_picture	1
668	8	235	api::product.product	main_picture	1
670	8	237	api::product.product	main_picture	1
673	8	239	api::product.product	main_picture	1
674	8	240	api::product.product	main_picture	1
675	8	241	api::product.product	main_picture	1
237	10	43	api::product.product	main_picture	1
238	9	43	api::product.product	gallery	1
239	8	43	api::product.product	gallery	2
240	7	43	api::product.product	gallery	3
241	6	43	api::product.product	gallery	4
242	11	43	api::product.product	gallery	5
243	12	43	api::product.product	gallery	6
244	13	43	api::product.product	gallery	7
245	14	43	api::product.product	gallery	8
255	10	44	api::product.product	main_picture	1
256	9	44	api::product.product	gallery	1
257	8	44	api::product.product	gallery	2
258	7	44	api::product.product	gallery	3
259	6	44	api::product.product	gallery	4
260	11	44	api::product.product	gallery	5
261	12	44	api::product.product	gallery	6
262	13	44	api::product.product	gallery	7
263	14	44	api::product.product	gallery	8
372	10	47	api::product.product	main_picture	1
373	9	47	api::product.product	gallery	1
374	8	47	api::product.product	gallery	2
375	7	47	api::product.product	gallery	3
376	6	47	api::product.product	gallery	4
377	11	47	api::product.product	gallery	5
378	12	47	api::product.product	gallery	6
379	13	47	api::product.product	gallery	7
380	14	47	api::product.product	gallery	8
282	10	45	api::product.product	main_picture	1
283	9	45	api::product.product	gallery	1
284	8	45	api::product.product	gallery	2
285	7	45	api::product.product	gallery	3
286	6	45	api::product.product	gallery	4
287	11	45	api::product.product	gallery	5
288	12	45	api::product.product	gallery	6
289	13	45	api::product.product	gallery	7
290	14	45	api::product.product	gallery	8
384	4	49	api::product.product	main_picture	1
386	4	50	api::product.product	main_picture	1
390	4	52	api::product.product	main_picture	1
394	4	54	api::product.product	main_picture	1
398	9	56	api::product.product	main_picture	1
402	9	59	api::product.product	main_picture	1
406	9	62	api::product.product	main_picture	1
444	10	72	api::product.product	main_picture	1
445	9	72	api::product.product	gallery	1
446	8	72	api::product.product	gallery	2
447	7	72	api::product.product	gallery	3
448	6	72	api::product.product	gallery	4
449	11	72	api::product.product	gallery	5
450	12	72	api::product.product	gallery	6
451	13	72	api::product.product	gallery	7
452	14	72	api::product.product	gallery	8
454	4	73	api::product.product	main_picture	1
456	4	74	api::product.product	main_picture	1
458	9	75	api::product.product	main_picture	1
460	9	76	api::product.product	main_picture	1
462	9	77	api::product.product	main_picture	1
464	9	78	api::product.product	main_picture	1
466	9	79	api::product.product	main_picture	1
468	9	80	api::product.product	main_picture	1
470	9	81	api::product.product	main_picture	1
472	9	83	api::product.product	main_picture	1
474	9	84	api::product.product	main_picture	1
476	9	85	api::product.product	main_picture	1
480	16	86	api::product.product	main_picture	1
481	17	86	api::product.product	gallery	1
482	15	86	api::product.product	gallery	2
484	9	87	api::product.product	main_picture	1
486	4	88	api::product.product	main_picture	1
488	4	89	api::product.product	main_picture	1
490	4	90	api::product.product	main_picture	1
492	4	91	api::product.product	main_picture	1
494	5	93	api::product.product	main_picture	1
496	12	95	api::product.product	main_picture	1
498	8	97	api::product.product	main_picture	1
500	8	98	api::product.product	main_picture	1
502	12	99	api::product.product	main_picture	1
504	11	137	api::product.product	main_picture	1
506	11	138	api::product.product	main_picture	1
508	18	140	api::product.product	main_picture	1
509	18	139	api::product.product	main_picture	1
510	18	142	api::product.product	main_picture	1
511	11	135	api::product.product	main_picture	1
512	11	143	api::product.product	main_picture	1
514	8	144	api::product.product	main_picture	1
516	12	145	api::product.product	main_picture	1
520	16	146	api::product.product	main_picture	1
521	17	146	api::product.product	gallery	1
522	15	146	api::product.product	gallery	2
523	10	1	api::product.product	main_picture	1
524	9	1	api::product.product	gallery	1
525	8	1	api::product.product	gallery	2
526	7	1	api::product.product	gallery	3
527	6	1	api::product.product	gallery	4
528	11	1	api::product.product	gallery	5
529	12	1	api::product.product	gallery	6
530	13	1	api::product.product	gallery	7
531	14	1	api::product.product	gallery	8
532	10	147	api::product.product	main_picture	1
533	9	147	api::product.product	gallery	1
534	8	147	api::product.product	gallery	2
535	7	147	api::product.product	gallery	3
536	6	147	api::product.product	gallery	4
537	11	147	api::product.product	gallery	5
538	12	147	api::product.product	gallery	6
539	13	147	api::product.product	gallery	7
540	14	147	api::product.product	gallery	8
541	5	3	api::product.product	main_picture	1
542	5	148	api::product.product	main_picture	1
544	5	149	api::product.product	main_picture	1
546	9	155	api::product.product	main_picture	1
548	9	156	api::product.product	main_picture	1
550	9	157	api::product.product	main_picture	1
552	9	158	api::product.product	main_picture	1
554	9	165	api::product.product	main_picture	1
556	4	166	api::product.product	main_picture	1
558	5	167	api::product.product	main_picture	1
560	12	168	api::product.product	main_picture	1
562	8	169	api::product.product	main_picture	1
564	9	171	api::product.product	main_picture	1
565	8	172	api::product.product	main_picture	1
566	12	173	api::product.product	main_picture	1
567	9	25	api::product.product	main_picture	1
568	9	175	api::product.product	main_picture	1
569	4	41	api::product.product	main_picture	1
570	4	176	api::product.product	main_picture	1
571	5	92	api::product.product	main_picture	1
572	5	177	api::product.product	main_picture	1
574	12	178	api::product.product	main_picture	1
576	8	179	api::product.product	main_picture	1
577	9	181	api::product.product	main_picture	1
578	4	182	api::product.product	main_picture	1
579	5	183	api::product.product	main_picture	1
580	12	184	api::product.product	main_picture	1
581	8	185	api::product.product	main_picture	1
637	8	214	api::product.product	main_picture	1
583	8	187	api::product.product	main_picture	1
585	8	188	api::product.product	main_picture	1
643	8	217	api::product.product	main_picture	1
587	8	189	api::product.product	main_picture	1
589	8	190	api::product.product	main_picture	1
647	8	219	api::product.product	main_picture	1
591	8	191	api::product.product	main_picture	1
593	8	192	api::product.product	main_picture	1
651	8	221	api::product.product	main_picture	1
595	8	193	api::product.product	main_picture	1
597	8	194	api::product.product	main_picture	1
655	8	223	api::product.product	main_picture	1
599	8	195	api::product.product	main_picture	1
601	8	196	api::product.product	main_picture	1
657	8	224	api::product.product	main_picture	1
603	8	197	api::product.product	main_picture	1
605	8	198	api::product.product	main_picture	1
659	8	225	api::product.product	main_picture	1
607	8	199	api::product.product	main_picture	1
609	8	200	api::product.product	main_picture	1
663	5	231	api::product.product	main_picture	1
611	8	201	api::product.product	main_picture	1
666	8	234	api::product.product	main_picture	1
613	8	202	api::product.product	main_picture	1
669	8	236	api::product.product	main_picture	1
615	8	203	api::product.product	main_picture	1
617	8	204	api::product.product	main_picture	1
672	8	238	api::product.product	main_picture	1
619	8	205	api::product.product	main_picture	1
621	8	206	api::product.product	main_picture	1
677	8	242	api::product.product	main_picture	1
623	8	207	api::product.product	main_picture	1
679	8	243	api::product.product	main_picture	1
625	8	208	api::product.product	main_picture	1
627	8	209	api::product.product	main_picture	1
629	8	210	api::product.product	main_picture	1
681	8	244	api::product.product	main_picture	1
683	8	245	api::product.product	main_picture	1
684	8	246	api::product.product	main_picture	1
686	8	247	api::product.product	main_picture	1
687	8	248	api::product.product	main_picture	1
688	8	249	api::product.product	main_picture	1
690	8	250	api::product.product	main_picture	1
691	8	251	api::product.product	main_picture	1
692	8	252	api::product.product	main_picture	1
694	8	253	api::product.product	main_picture	1
695	8	254	api::product.product	main_picture	1
696	8	255	api::product.product	main_picture	1
698	8	256	api::product.product	main_picture	1
699	8	257	api::product.product	main_picture	1
700	8	258	api::product.product	main_picture	1
702	8	259	api::product.product	main_picture	1
703	8	260	api::product.product	main_picture	1
704	8	261	api::product.product	main_picture	1
705	8	262	api::product.product	main_picture	1
707	8	263	api::product.product	main_picture	1
708	8	264	api::product.product	main_picture	1
710	8	265	api::product.product	main_picture	1
711	8	266	api::product.product	main_picture	1
712	8	267	api::product.product	main_picture	1
713	8	268	api::product.product	main_picture	1
714	8	269	api::product.product	main_picture	1
715	8	270	api::product.product	main_picture	1
716	8	271	api::product.product	main_picture	1
717	8	272	api::product.product	main_picture	1
718	8	273	api::product.product	main_picture	1
719	8	274	api::product.product	main_picture	1
720	8	275	api::product.product	main_picture	1
722	8	276	api::product.product	main_picture	1
723	8	277	api::product.product	main_picture	1
725	8	278	api::product.product	main_picture	1
726	13	279	api::product.product	main_picture	1
727	13	280	api::product.product	main_picture	1
728	13	281	api::product.product	main_picture	1
729	13	282	api::product.product	main_picture	1
731	13	283	api::product.product	main_picture	1
732	13	284	api::product.product	main_picture	1
733	13	285	api::product.product	main_picture	1
734	8	286	api::product.product	main_picture	1
735	8	287	api::product.product	main_picture	1
736	8	288	api::product.product	main_picture	1
737	8	289	api::product.product	main_picture	1
738	8	290	api::product.product	main_picture	1
739	8	291	api::product.product	main_picture	1
740	8	292	api::product.product	main_picture	1
741	8	293	api::product.product	main_picture	1
742	8	294	api::product.product	main_picture	1
743	8	295	api::product.product	main_picture	1
744	8	296	api::product.product	main_picture	1
745	8	297	api::product.product	main_picture	1
747	13	298	api::product.product	main_picture	1
749	8	299	api::product.product	main_picture	1
750	8	300	api::product.product	main_picture	1
751	13	301	api::product.product	main_picture	1
752	8	302	api::product.product	main_picture	1
753	13	303	api::product.product	main_picture	1
754	8	304	api::product.product	main_picture	1
756	13	305	api::product.product	main_picture	1
758	8	306	api::product.product	main_picture	1
759	13	307	api::product.product	main_picture	1
760	8	308	api::product.product	main_picture	1
762	8	309	api::product.product	main_picture	1
763	8	310	api::product.product	main_picture	1
765	13	311	api::product.product	main_picture	1
767	8	312	api::product.product	main_picture	1
768	8	313	api::product.product	main_picture	1
769	8	314	api::product.product	main_picture	1
771	8	315	api::product.product	main_picture	1
772	8	316	api::product.product	main_picture	1
773	8	317	api::product.product	main_picture	1
774	8	318	api::product.product	main_picture	1
775	8	319	api::product.product	main_picture	1
776	8	320	api::product.product	main_picture	1
777	8	321	api::product.product	main_picture	1
779	8	322	api::product.product	main_picture	1
780	8	323	api::product.product	main_picture	1
781	8	324	api::product.product	main_picture	1
782	8	325	api::product.product	main_picture	1
783	8	326	api::product.product	main_picture	1
784	8	327	api::product.product	main_picture	1
785	8	328	api::product.product	main_picture	1
786	13	329	api::product.product	main_picture	1
787	13	330	api::product.product	main_picture	1
788	8	331	api::product.product	main_picture	1
789	8	332	api::product.product	main_picture	1
790	8	333	api::product.product	main_picture	1
791	8	334	api::product.product	main_picture	1
792	13	335	api::product.product	main_picture	1
794	13	336	api::product.product	main_picture	1
796	8	337	api::product.product	main_picture	1
797	13	338	api::product.product	main_picture	1
798	8	339	api::product.product	main_picture	1
799	8	340	api::product.product	main_picture	1
800	8	341	api::product.product	main_picture	1
802	13	342	api::product.product	main_picture	1
804	8	343	api::product.product	main_picture	1
805	8	344	api::product.product	main_picture	1
807	8	345	api::product.product	main_picture	1
808	8	346	api::product.product	main_picture	1
809	5	347	api::product.product	main_picture	1
810	13	348	api::product.product	main_picture	1
812	5	349	api::product.product	main_picture	1
813	5	350	api::product.product	main_picture	1
814	5	351	api::product.product	main_picture	1
815	5	352	api::product.product	main_picture	1
816	5	353	api::product.product	main_picture	1
817	5	354	api::product.product	main_picture	1
819	5	355	api::product.product	main_picture	1
820	5	356	api::product.product	main_picture	1
821	5	357	api::product.product	main_picture	1
822	5	358	api::product.product	main_picture	1
823	5	359	api::product.product	main_picture	1
824	5	360	api::product.product	main_picture	1
826	5	361	api::product.product	main_picture	1
827	5	362	api::product.product	main_picture	1
828	5	363	api::product.product	main_picture	1
829	5	364	api::product.product	main_picture	1
830	5	365	api::product.product	main_picture	1
831	5	366	api::product.product	main_picture	1
832	5	367	api::product.product	main_picture	1
834	5	368	api::product.product	main_picture	1
836	5	369	api::product.product	main_picture	1
838	13	370	api::product.product	main_picture	1
839	13	232	api::product.product	main_picture	1
840	13	371	api::product.product	main_picture	1
842	8	372	api::product.product	main_picture	1
843	8	373	api::product.product	main_picture	1
844	8	374	api::product.product	main_picture	1
845	8	375	api::product.product	main_picture	1
847	8	376	api::product.product	main_picture	1
848	8	377	api::product.product	main_picture	1
849	8	96	api::product.product	main_picture	1
850	8	378	api::product.product	main_picture	1
851	5	379	api::product.product	main_picture	1
853	5	380	api::product.product	main_picture	1
854	5	381	api::product.product	main_picture	1
855	5	382	api::product.product	main_picture	1
856	5	383	api::product.product	main_picture	1
857	5	384	api::product.product	main_picture	1
858	5	385	api::product.product	main_picture	1
859	5	386	api::product.product	main_picture	1
860	5	387	api::product.product	main_picture	1
861	5	388	api::product.product	main_picture	1
862	5	389	api::product.product	main_picture	1
863	5	390	api::product.product	main_picture	1
864	5	391	api::product.product	main_picture	1
865	5	392	api::product.product	main_picture	1
866	5	393	api::product.product	main_picture	1
867	5	394	api::product.product	main_picture	1
868	5	395	api::product.product	main_picture	1
869	5	396	api::product.product	main_picture	1
870	5	397	api::product.product	main_picture	1
871	5	398	api::product.product	main_picture	1
873	12	399	api::product.product	main_picture	1
875	12	400	api::product.product	main_picture	1
877	12	401	api::product.product	main_picture	1
878	8	402	api::product.product	main_picture	1
879	13	403	api::product.product	main_picture	1
881	12	404	api::product.product	main_picture	1
882	12	94	api::product.product	main_picture	1
883	12	405	api::product.product	main_picture	1
885	5	406	api::product.product	main_picture	1
886	5	407	api::product.product	main_picture	1
887	5	408	api::product.product	main_picture	1
888	17	412	api::product.product	main_picture	1
889	17	413	api::product.product	main_picture	1
891	18	415	api::product.product	main_picture	1
893	5	416	api::product.product	main_picture	1
894	5	417	api::product.product	main_picture	1
895	5	418	api::product.product	main_picture	1
896	5	419	api::product.product	main_picture	1
897	5	420	api::product.product	main_picture	1
898	5	230	api::product.product	main_picture	1
899	5	421	api::product.product	main_picture	1
900	5	422	api::product.product	main_picture	1
901	5	423	api::product.product	main_picture	1
905	16	424	api::product.product	main_picture	1
906	17	424	api::product.product	gallery	1
907	15	424	api::product.product	gallery	2
908	16	19	api::product.product	main_picture	1
909	17	19	api::product.product	gallery	1
910	15	19	api::product.product	gallery	2
911	16	425	api::product.product	main_picture	1
912	17	425	api::product.product	gallery	1
913	15	425	api::product.product	gallery	2
914	19	426	api::product.product	main_picture	1
915	19	427	api::product.product	main_picture	1
917	18	428	api::product.product	main_picture	1
918	18	429	api::product.product	main_picture	1
919	18	430	api::product.product	main_picture	1
921	18	431	api::product.product	main_picture	1
923	18	432	api::product.product	main_picture	1
924	34	433	api::product.product	main_picture	1
925	34	434	api::product.product	main_picture	1
926	20	435	api::product.product	main_picture	1
927	20	436	api::product.product	main_picture	1
928	39	437	api::product.product	main_picture	1
929	39	438	api::product.product	main_picture	1
931	35	440	api::product.product	main_picture	1
932	35	439	api::product.product	main_picture	1
933	41	439	api::product.product	gallery	1
934	40	439	api::product.product	gallery	2
935	42	439	api::product.product	gallery	3
936	35	441	api::product.product	main_picture	1
937	41	441	api::product.product	gallery	1
938	40	441	api::product.product	gallery	2
939	42	441	api::product.product	gallery	3
941	36	443	api::product.product	main_picture	1
943	37	444	api::product.product	main_picture	1
945	37	445	api::product.product	main_picture	1
947	37	446	api::product.product	main_picture	1
949	31	448	api::product.product	main_picture	1
951	22	450	api::product.product	main_picture	1
952	31	447	api::product.product	main_picture	1
953	31	451	api::product.product	main_picture	1
954	37	442	api::product.product	main_picture	1
955	37	452	api::product.product	main_picture	1
957	36	454	api::product.product	main_picture	1
958	23	455	api::product.product	main_picture	1
959	23	456	api::product.product	main_picture	1
960	43	457	api::product.product	main_picture	1
961	43	458	api::product.product	main_picture	1
963	36	459	api::product.product	main_picture	1
964	18	460	api::product.product	main_picture	1
966	36	461	api::product.product	main_picture	1
968	36	462	api::product.product	main_picture	1
970	18	463	api::product.product	main_picture	1
971	22	464	api::product.product	main_picture	1
972	22	449	api::product.product	main_picture	1
973	22	465	api::product.product	main_picture	1
975	36	466	api::product.product	main_picture	1
977	18	467	api::product.product	main_picture	1
978	18	468	api::product.product	main_picture	1
979	36	469	api::product.product	main_picture	1
981	36	470	api::product.product	main_picture	1
982	17	471	api::product.product	main_picture	1
983	18	414	api::product.product	main_picture	1
984	18	472	api::product.product	main_picture	1
985	36	453	api::product.product	main_picture	1
986	36	473	api::product.product	main_picture	1
\.


--
-- Data for Name: i18n_locale; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.i18n_locale (id, document_id, name, code, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	a5b5pd5cdktruhhd6otk90lk	English (en)	en	2024-11-21 13:00:39.384	2024-11-21 13:00:39.384	2024-11-21 13:00:39.385	\N	\N	\N
\.


--
-- Data for Name: lottery_users; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.lottery_users (id, document_id, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
388	z34x1xl7frtzw8akdhuqditd	2025-01-09 16:08:08.224	2025-01-09 16:08:08.224	\N	\N	\N	\N
389	z34x1xl7frtzw8akdhuqditd	2025-01-09 16:08:08.224	2025-01-09 16:08:08.224	2025-01-09 16:08:08.23	\N	\N	\N
390	qgfdmsj6df7kgkqnrwa77ekj	2025-01-11 13:14:42.29	2025-01-11 13:14:42.29	\N	\N	\N	\N
391	qgfdmsj6df7kgkqnrwa77ekj	2025-01-11 13:14:42.29	2025-01-11 13:14:42.29	2025-01-11 13:14:42.342	\N	\N	\N
392	gdocc39oj259px84jjmh3zx0	2025-01-11 13:14:52.096	2025-01-11 13:14:52.096	\N	\N	\N	\N
393	gdocc39oj259px84jjmh3zx0	2025-01-11 13:14:52.096	2025-01-11 13:14:52.096	2025-01-11 13:14:52.104	\N	\N	\N
394	kd2qvxeyflnaxf2a9p7t464b	2025-01-11 13:15:01.912	2025-01-11 13:15:01.912	\N	\N	\N	\N
395	kd2qvxeyflnaxf2a9p7t464b	2025-01-11 13:15:01.912	2025-01-11 13:15:01.912	2025-01-11 13:15:01.921	\N	\N	\N
396	hlhd12t9t2hzrhj4xenhqu6u	2025-01-11 13:15:10.344	2025-01-11 13:15:10.344	\N	\N	\N	\N
397	hlhd12t9t2hzrhj4xenhqu6u	2025-01-11 13:15:10.344	2025-01-11 13:15:10.344	2025-01-11 13:15:10.393	\N	\N	\N
398	ru8tdf4g4jh6khmeu916u75p	2025-01-11 13:15:20.071	2025-01-11 13:15:20.071	\N	\N	\N	\N
399	ru8tdf4g4jh6khmeu916u75p	2025-01-11 13:15:20.071	2025-01-11 13:15:20.071	2025-01-11 13:15:20.077	\N	\N	\N
400	c1b13vg32kol1zhe5kifqdxl	2025-01-11 13:16:32.399	2025-01-11 13:16:32.399	\N	\N	\N	\N
401	c1b13vg32kol1zhe5kifqdxl	2025-01-11 13:16:32.399	2025-01-11 13:16:32.399	2025-01-11 13:16:32.407	\N	\N	\N
402	m30bnw3z12clybbym4w2woom	2025-01-11 13:16:41.864	2025-01-11 13:16:41.864	\N	\N	\N	\N
403	m30bnw3z12clybbym4w2woom	2025-01-11 13:16:41.864	2025-01-11 13:16:41.864	2025-01-11 13:16:41.915	\N	\N	\N
404	svkhdxjh8qw7pio44munewwo	2025-01-11 13:17:43.922	2025-01-11 13:17:43.922	\N	\N	\N	\N
405	svkhdxjh8qw7pio44munewwo	2025-01-11 13:17:43.922	2025-01-11 13:17:43.922	2025-01-11 13:17:43.93	\N	\N	\N
406	m0czc9zvm0mbdwzf1t8on8dn	2025-01-11 13:17:51.834	2025-01-11 13:17:51.834	\N	\N	\N	\N
407	m0czc9zvm0mbdwzf1t8on8dn	2025-01-11 13:17:51.834	2025-01-11 13:17:51.834	2025-01-11 13:17:51.843	\N	\N	\N
408	ne3nz1s9l3xpt4nbeqxr78hd	2025-01-11 13:17:58.288	2025-01-11 13:17:58.288	\N	\N	\N	\N
409	ne3nz1s9l3xpt4nbeqxr78hd	2025-01-11 13:17:58.288	2025-01-11 13:17:58.288	2025-01-11 13:17:58.296	\N	\N	\N
410	z0xmkta0y3cx3m3t9r60a7jx	2025-01-11 13:19:13.12	2025-01-11 13:19:13.12	\N	\N	\N	\N
411	z0xmkta0y3cx3m3t9r60a7jx	2025-01-11 13:19:13.12	2025-01-11 13:19:13.12	2025-01-11 13:19:13.215	\N	\N	\N
412	zhx43v5n5p6azd7gkt0jvu2j	2025-01-11 13:19:19.824	2025-01-11 13:19:19.824	\N	\N	\N	\N
413	zhx43v5n5p6azd7gkt0jvu2j	2025-01-11 13:19:19.824	2025-01-11 13:19:19.824	2025-01-11 13:19:19.874	\N	\N	\N
354	uppmwr707o430p2u92pbyab9	2024-12-19 16:19:10.174	2024-12-19 16:19:10.174	\N	\N	\N	\N
355	uppmwr707o430p2u92pbyab9	2024-12-19 16:19:10.174	2024-12-19 16:19:10.174	2024-12-19 16:19:10.183	\N	\N	\N
356	p65i03my96perp4f2dp0tqe2	2025-01-07 11:28:48.414	2025-01-07 11:28:48.414	\N	\N	\N	\N
357	p65i03my96perp4f2dp0tqe2	2025-01-07 11:28:48.414	2025-01-07 11:28:48.414	2025-01-07 11:28:48.468	\N	\N	\N
278	i6a79n60mfjltylwe0biuhe1	2024-12-16 11:58:00.659	2024-12-16 11:58:00.659	\N	\N	\N	\N
279	i6a79n60mfjltylwe0biuhe1	2024-12-16 11:58:00.659	2024-12-16 11:58:00.659	2024-12-16 11:58:00.668	\N	\N	\N
358	knsjtmzza1f0naxs7329xwz1	2025-01-07 11:29:10.489	2025-01-07 11:29:10.489	\N	\N	\N	\N
359	knsjtmzza1f0naxs7329xwz1	2025-01-07 11:29:10.489	2025-01-07 11:29:10.489	2025-01-07 11:29:10.497	\N	\N	\N
414	s8363cgp7ay9q5nggzltex7e	2025-01-11 13:19:24.434	2025-01-11 13:19:24.434	\N	\N	\N	\N
415	s8363cgp7ay9q5nggzltex7e	2025-01-11 13:19:24.434	2025-01-11 13:19:24.434	2025-01-11 13:19:24.443	\N	\N	\N
284	u4wl0haykcpmwd99xi9rh8x8	2024-12-16 12:18:55.948	2024-12-16 12:18:55.948	\N	\N	\N	\N
285	u4wl0haykcpmwd99xi9rh8x8	2024-12-16 12:18:55.948	2024-12-16 12:18:55.948	2024-12-16 12:18:55.957	\N	\N	\N
286	diitkq2umok9mugr3smpzdsy	2024-12-16 12:19:01.547	2024-12-16 12:19:01.547	\N	\N	\N	\N
287	diitkq2umok9mugr3smpzdsy	2024-12-16 12:19:01.547	2024-12-16 12:19:01.547	2024-12-16 12:19:01.554	\N	\N	\N
288	frt3e8ti71cthh67aihv8iit	2024-12-16 12:20:40.279	2024-12-16 12:20:40.279	\N	\N	\N	\N
289	frt3e8ti71cthh67aihv8iit	2024-12-16 12:20:40.279	2024-12-16 12:20:40.279	2024-12-16 12:20:40.29	\N	\N	\N
290	ld5hf76oijnrhna2ykd49jum	2024-12-16 12:20:45.629	2024-12-16 12:20:45.629	\N	\N	\N	\N
291	ld5hf76oijnrhna2ykd49jum	2024-12-16 12:20:45.629	2024-12-16 12:20:45.629	2024-12-16 12:20:45.638	\N	\N	\N
416	yafsdytiphvzehtu7b5l3y4u	2025-01-11 13:20:10.457	2025-01-11 13:20:10.457	\N	\N	\N	\N
417	yafsdytiphvzehtu7b5l3y4u	2025-01-11 13:20:10.457	2025-01-11 13:20:10.457	2025-01-11 13:20:10.465	\N	\N	\N
418	fq7nxh5gph8bwnwqbdrjts88	2025-01-11 13:20:14.905	2025-01-11 13:20:14.905	\N	\N	\N	\N
419	fq7nxh5gph8bwnwqbdrjts88	2025-01-11 13:20:14.905	2025-01-11 13:20:14.905	2025-01-11 13:20:14.913	\N	\N	\N
420	zbzt727tew888o8lt9n8m0hl	2025-01-11 13:20:24.321	2025-01-11 13:20:24.321	\N	\N	\N	\N
421	zbzt727tew888o8lt9n8m0hl	2025-01-11 13:20:24.321	2025-01-11 13:20:24.321	2025-01-11 13:20:24.329	\N	\N	\N
422	rc2xiw9474rj0flmbrawsmta	2025-01-11 13:20:31.311	2025-01-11 13:20:31.311	\N	\N	\N	\N
423	rc2xiw9474rj0flmbrawsmta	2025-01-11 13:20:31.311	2025-01-11 13:20:31.311	2025-01-11 13:20:31.317	\N	\N	\N
424	b6jf5oocey0yxlzbp7oyb3ko	2025-01-11 16:41:44.298	2025-01-11 16:41:44.298	\N	\N	\N	\N
425	b6jf5oocey0yxlzbp7oyb3ko	2025-01-11 16:41:44.298	2025-01-11 16:41:44.298	2025-01-11 16:41:44.353	\N	\N	\N
302	tqd3bt5j7ll498p1b3tda3o7	2024-12-16 13:12:09.426	2024-12-16 13:12:09.426	\N	\N	\N	\N
303	tqd3bt5j7ll498p1b3tda3o7	2024-12-16 13:12:09.426	2024-12-16 13:12:09.426	2024-12-16 13:12:09.434	\N	\N	\N
426	os0zmrj7nivr97e2d76oar6q	2025-01-16 13:38:30.328	2025-01-16 13:38:30.328	\N	\N	\N	\N
427	os0zmrj7nivr97e2d76oar6q	2025-01-16 13:38:30.328	2025-01-16 13:38:30.328	2025-01-16 13:38:30.433	\N	\N	\N
306	yyshq2zwloclwtyjebusx9is	2024-12-16 13:12:51.132	2024-12-16 13:12:51.132	\N	\N	\N	\N
307	yyshq2zwloclwtyjebusx9is	2024-12-16 13:12:51.132	2024-12-16 13:12:51.132	2024-12-16 13:12:51.139	\N	\N	\N
308	vybieo7th8l24vmv1na6uwh4	2024-12-16 13:13:22.802	2024-12-16 13:13:22.802	\N	\N	\N	\N
309	vybieo7th8l24vmv1na6uwh4	2024-12-16 13:13:22.802	2024-12-16 13:13:22.802	2024-12-16 13:13:22.811	\N	\N	\N
434	j7lj22eaokgt2xlshtz6exq3	2025-01-16 17:08:05.967	2025-01-16 17:08:05.967	\N	\N	\N	\N
435	j7lj22eaokgt2xlshtz6exq3	2025-01-16 17:08:05.967	2025-01-16 17:08:05.967	2025-01-16 17:08:05.975	\N	\N	\N
436	byyyp3qlywnf3aaftjvjknxu	2025-01-16 17:08:19.805	2025-01-16 17:08:19.805	\N	\N	\N	\N
437	byyyp3qlywnf3aaftjvjknxu	2025-01-16 17:08:19.805	2025-01-16 17:08:19.805	2025-01-16 17:08:19.813	\N	\N	\N
438	kk8eqbsq1hytn9ao1sig0zvq	2025-01-16 17:08:33.89	2025-01-16 17:08:33.89	\N	\N	\N	\N
439	kk8eqbsq1hytn9ao1sig0zvq	2025-01-16 17:08:33.89	2025-01-16 17:08:33.89	2025-01-16 17:08:33.942	\N	\N	\N
440	ap6mb35cmqkn94ucc6704o3o	2025-01-16 17:08:57.132	2025-01-16 17:08:57.132	\N	\N	\N	\N
441	ap6mb35cmqkn94ucc6704o3o	2025-01-16 17:08:57.132	2025-01-16 17:08:57.132	2025-01-16 17:08:57.14	\N	\N	\N
382	a7a00s2nfbj413yrewox08r4	2025-01-09 16:01:12.029	2025-01-09 16:01:12.029	\N	\N	\N	\N
383	a7a00s2nfbj413yrewox08r4	2025-01-09 16:01:12.029	2025-01-09 16:01:12.029	2025-01-09 16:01:12.038	\N	\N	\N
442	egu9mfb0obwagxoijqw2inl4	2025-01-20 11:01:23.246	2025-01-20 11:01:23.246	\N	\N	\N	\N
443	egu9mfb0obwagxoijqw2inl4	2025-01-20 11:01:23.246	2025-01-20 11:01:23.246	2025-01-20 11:01:23.295	\N	\N	\N
444	rxby6nh7va67efb903tdqcx1	2025-01-20 11:01:59.837	2025-01-20 11:01:59.837	\N	\N	\N	\N
445	rxby6nh7va67efb903tdqcx1	2025-01-20 11:01:59.837	2025-01-20 11:01:59.837	2025-01-20 11:01:59.844	\N	\N	\N
464	oe6nuudok6ax5y80p2io50vd	2025-01-27 13:21:24.988	2025-01-27 13:21:24.988	\N	\N	\N	\N
465	oe6nuudok6ax5y80p2io50vd	2025-01-27 13:21:24.988	2025-01-27 13:21:24.988	2025-01-27 13:21:24.997	\N	\N	\N
466	qkojkkkn25uuobv6q1a4487b	2025-01-29 14:13:24.969	2025-01-29 14:13:24.969	\N	\N	\N	\N
467	qkojkkkn25uuobv6q1a4487b	2025-01-29 14:13:24.969	2025-01-29 14:13:24.969	2025-01-29 14:13:25.024	\N	\N	\N
468	yd30nb80wmbmlhg38qh3kgeq	2025-01-29 14:13:36.777	2025-01-29 14:13:36.777	\N	\N	\N	\N
469	yd30nb80wmbmlhg38qh3kgeq	2025-01-29 14:13:36.777	2025-01-29 14:13:36.777	2025-01-29 14:13:36.79	\N	\N	\N
472	kjeqfy42gwlpw7dx0n7jeczd	2025-01-31 10:42:29.229	2025-01-31 10:42:29.229	\N	\N	\N	\N
473	kjeqfy42gwlpw7dx0n7jeczd	2025-01-31 10:42:29.229	2025-01-31 10:42:29.229	2025-01-31 10:42:29.241	\N	\N	\N
478	aa1n7f7c53n5jcd4lwp71vzw	2025-02-04 10:00:12.338	2025-02-04 10:00:12.338	\N	\N	\N	\N
479	aa1n7f7c53n5jcd4lwp71vzw	2025-02-04 10:00:12.338	2025-02-04 10:00:12.338	2025-02-04 10:00:12.349	\N	\N	\N
480	sz0mintxrblis5t6pwz69k1r	2025-02-04 10:00:34.777	2025-02-04 10:00:34.777	\N	\N	\N	\N
481	sz0mintxrblis5t6pwz69k1r	2025-02-04 10:00:34.777	2025-02-04 10:00:34.777	2025-02-04 10:00:34.785	\N	\N	\N
484	ewpvv8ns9h98zkb3n6cufmgc	2025-02-04 14:30:54.625	2025-02-04 14:30:54.625	\N	\N	\N	\N
485	ewpvv8ns9h98zkb3n6cufmgc	2025-02-04 14:30:54.625	2025-02-04 14:30:54.625	2025-02-04 14:30:54.635	\N	\N	\N
486	c7idsnvbzw40wxg0eqm1kdbj	2025-02-04 14:31:07.704	2025-02-04 14:31:07.704	\N	\N	\N	\N
487	c7idsnvbzw40wxg0eqm1kdbj	2025-02-04 14:31:07.704	2025-02-04 14:31:07.704	2025-02-04 14:31:07.711	\N	\N	\N
488	uhc4oa2jvddk05hbpz32nvhr	2025-02-05 14:33:09.051	2025-02-05 14:33:09.051	\N	\N	\N	\N
489	uhc4oa2jvddk05hbpz32nvhr	2025-02-05 14:33:09.051	2025-02-05 14:33:09.051	2025-02-05 14:33:09.104	\N	\N	\N
490	pasv5p46poa9yndqp4i04k4v	2025-02-05 14:34:51.458	2025-02-05 14:34:51.458	\N	\N	\N	\N
491	pasv5p46poa9yndqp4i04k4v	2025-02-05 14:34:51.458	2025-02-05 14:34:51.458	2025-02-05 14:34:51.466	\N	\N	\N
492	il6omntteol6f6ekaww1zkcd	2025-02-05 14:35:04.271	2025-02-05 14:35:04.271	\N	\N	\N	\N
493	il6omntteol6f6ekaww1zkcd	2025-02-05 14:35:04.271	2025-02-05 14:35:04.271	2025-02-05 14:35:04.277	\N	\N	\N
496	f8dj80vo91j7jwlrzrywv87n	2025-02-06 09:38:49.479	2025-02-06 09:38:49.479	\N	\N	\N	\N
497	f8dj80vo91j7jwlrzrywv87n	2025-02-06 09:38:49.479	2025-02-06 09:38:49.479	2025-02-06 09:38:49.558	\N	\N	\N
498	w9zroreujsrz4vi80fw5zgli	2025-02-06 09:52:19.127	2025-02-06 09:52:19.127	\N	\N	\N	\N
499	w9zroreujsrz4vi80fw5zgli	2025-02-06 09:52:19.127	2025-02-06 09:52:19.127	2025-02-06 09:52:19.182	\N	\N	\N
500	gf8z1yiv1k3e3fx5z91jfwy9	2025-02-06 10:29:38.203	2025-02-06 10:29:38.203	\N	\N	\N	\N
501	gf8z1yiv1k3e3fx5z91jfwy9	2025-02-06 10:29:38.203	2025-02-06 10:29:38.203	2025-02-06 10:29:38.212	\N	\N	\N
502	rlj634rs8ezn3exum7nfj90g	2025-02-06 10:30:17.785	2025-02-06 10:30:17.785	\N	\N	\N	\N
503	rlj634rs8ezn3exum7nfj90g	2025-02-06 10:30:17.785	2025-02-06 10:30:17.785	2025-02-06 10:30:17.793	\N	\N	\N
510	cl1ih1jqx09gk5oqkdj0qpe3	2025-02-06 10:32:06.495	2025-02-06 10:32:06.495	\N	\N	\N	\N
511	cl1ih1jqx09gk5oqkdj0qpe3	2025-02-06 10:32:06.495	2025-02-06 10:32:06.495	2025-02-06 10:32:06.503	\N	\N	\N
514	gaafjuoz5v2r0nijnl6ji0n7	2025-02-08 16:00:56.49	2025-02-08 16:00:56.49	\N	\N	\N	\N
515	gaafjuoz5v2r0nijnl6ji0n7	2025-02-08 16:00:56.49	2025-02-08 16:00:56.49	2025-02-08 16:00:56.548	\N	\N	\N
\.


--
-- Data for Name: lottery_users_biduser_lnk; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.lottery_users_biduser_lnk (id, lottery_user_id, biduser_id, lottery_user_ord) FROM stdin;
1691	466	3	9
1348	382	3	4
1693	468	3	10
1354	388	12	1
1356	285	177	1
1296	354	3	1
1357	287	177	2
1358	309	177	3
1359	390	12	2
1361	392	12	3
1363	394	12	4
1365	396	12	5
1306	356	3	2
1308	358	3	3
1367	398	12	6
1369	400	3	5
288	278	5	1
1371	402	3	6
1373	404	5	4
294	284	10	1
296	286	10	2
298	288	14	1
300	290	14	2
2547	500	12	10
1375	406	5	5
1377	408	5	6
2549	502	12	11
1379	410	10	4
1380	411	177	4
1381	412	10	5
1382	413	177	5
1383	414	10	6
1384	415	177	6
312	302	1	1
313	303	9	1
1569	464	5	8
1385	416	14	3
316	306	5	2
318	308	10	3
2043	472	5	10
1387	418	14	4
1389	420	14	5
1391	422	14	6
1393	424	14	7
2557	510	12	15
2463	355	293	1
2464	357	293	2
2465	359	293	3
2466	383	293	4
2467	401	293	5
2468	403	293	6
2377	478	12	9
2379	480	10	8
2380	481	177	8
2469	427	293	7
2470	445	293	8
2383	484	5	11
2471	467	293	9
2385	486	5	12
2472	469	293	10
2473	489	293	11
2474	491	293	12
2475	493	293	13
2478	496	5	14
2480	279	294	1
2481	307	294	2
2482	405	294	3
1430	289	183	1
1431	291	183	2
1432	417	183	3
1433	419	183	4
1434	421	183	5
1435	423	183	6
1436	425	183	7
1437	426	3	7
2405	488	3	11
2483	407	294	4
2407	490	3	12
2484	409	294	5
1445	434	12	7
1447	436	14	8
1448	437	183	8
1449	438	10	7
1450	439	177	7
1451	440	1	2
1452	441	9	2
1453	442	1	3
1454	443	9	3
1455	444	3	8
2409	492	3	13
2485	465	294	6
2486	473	294	7
2487	485	294	8
2488	487	294	9
2490	497	294	11
2491	498	5	15
2492	499	294	12
2659	389	309	1
2660	391	309	2
2661	393	309	3
2662	395	309	4
2663	397	309	5
2664	399	309	6
2665	435	309	7
2666	479	309	8
2667	501	309	9
2668	503	309	10
2670	511	309	12
2673	514	12	16
2674	515	309	13
\.


--
-- Data for Name: lottery_users_products_lnk; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.lottery_users_products_lnk (id, lottery_user_id, product_id, lottery_user_ord, product_ord) FROM stdin;
418	357	186	1	1
419	409	186	2	1
420	411	186	3	1
421	417	186	4	1
320	390	25	5	0
762	426	232	1	0
322	392	41	5	0
1109	442	227	1	0
324	394	92	1	0
1355	472	230	6	0
326	396	94	2	0
1111	444	227	2	0
328	398	96	2	0
1451	514	453	3	0
330	400	92	2	0
332	402	41	6	0
334	404	92	3	0
336	406	94	3	0
338	408	100	2	0
340	410	100	3	0
1362	435	423	1	1
342	412	96	3	0
1363	437	423	2	1
344	414	94	4	0
289	382	27	4	0
146	278	25	1	0
1364	439	423	3	1
346	416	100	4	0
1365	441	423	4	1
348	418	96	4	0
1366	473	423	5	1
350	420	94	5	0
153	284	25	3	0
1287	443	409	1	1
155	286	27	2	0
352	422	92	4	0
157	288	25	4	0
1288	445	409	2	1
159	290	27	3	0
1459	467	471	1	1
1460	487	471	2	1
1461	503	471	3	1
301	388	27	6	0
231	354	96	1	0
1462	469	472	1	1
1463	479	472	2	1
234	356	100	1	0
1373	478	414	3	0
236	358	94	1	0
985	434	230	2	0
171	302	41	1	0
1464	481	472	3	1
987	436	230	3	0
1375	480	414	4	0
175	306	41	3	0
1465	485	472	4	1
177	308	41	4	0
1466	491	473	1	1
1467	499	473	2	1
1468	515	473	3	1
989	438	230	4	0
991	440	230	5	0
1395	484	414	5	0
1312	464	27	7	0
1314	287	411	1	1
1315	291	411	2	1
1316	383	411	3	1
1317	389	411	4	1
1318	465	411	5	1
1319	466	412	1	0
1321	468	414	1	0
1397	486	412	3	0
1399	488	457	1	0
1400	489	458	1	1
1401	490	453	1	0
1403	492	447	1	0
393	424	41	7	0
1257	355	402	1	1
395	279	181	1	1
396	285	181	2	1
397	289	181	3	1
398	391	181	4	1
399	303	182	1	1
400	307	182	2	1
401	309	182	3	1
402	393	182	4	1
403	403	182	5	1
404	425	182	6	1
405	395	183	1	1
406	401	183	2	1
407	405	183	3	1
408	423	183	4	1
1404	493	451	1	1
1407	496	449	1	0
1258	399	402	2	1
1259	413	402	3	1
1260	419	402	4	1
1261	427	403	1	1
1267	359	405	1	1
1268	397	405	2	1
1269	407	405	3	1
1270	415	405	4	1
1271	421	405	5	1
1419	498	453	2	0
1426	497	465	1	1
1433	500	449	2	0
1434	501	465	2	1
1435	502	412	4	0
1443	510	442	1	0
1444	511	452	1	1
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.products (id, document_id, title, description, price, ending_date, created_at, updated_at, published_at, created_by_id, updated_by_id, locale, lottery_product, lottery_winner, manual_lottery) FROM stdin;
92	tlrfl3vmqqvhd5248v3zzsju	Lottery Product 4 18:00	lottery product number 4	\N	2025-01-11 18:00:00	2024-12-16 14:08:09.824	2025-01-11 18:00:00.02	\N	1	1	\N	t	rfw87y9d0sw9f7gnk5u5c2wx	f
96	tjws3c566vjhlp1arabqghtj	Lottery Product 6 fun manuel lottery test	Lottery Product number 6	200.00	2025-01-14 08:30:00	2024-12-16 14:09:41.516	2025-01-21 12:11:24.139	\N	1	1	\N	t	danpxmcht9yqoz3wekjt53dw	t
405	xd659reoebr967f82ui3kozd	Lottery Product 5 18:00	Lottery Product number 5 	3000.00	2025-01-20 18:00:00	2024-12-16 14:08:56.116	2025-01-21 12:13:39.789	2025-01-21 12:13:39.831	1	1	\N	t	rfw87y9d0sw9f7gnk5u5c2wx	f
23	yj0tr1fwzzlc8hjdsx86b88c	Old Product Test 	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. \n	300.00	2024-11-26 16:13:00	2024-11-26 15:59:24.776	2024-12-03 14:00:37.46	2024-12-03 14:00:37.501	1	1	\N	f	\N	\N
143	ka8ivki3yjskiw71ex7pspy6	Auto ending date test	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	\N	2025-01-07 11:15:00	2024-12-17 13:35:29.818	2025-01-07 11:11:37.511	2025-01-07 11:11:37.569	1	1	\N	f	\N	\N
147	ze7z8otenwlnoqzkynjjymjj	MAC BOOK PRO 16“, 8GB Ram, Intel I7	Lorem ipsum dolor sit amet, consectetur adipiscinsg elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. \n\n- Lorem ipsum dolor sit amet\n- Ut enim ad minim veniam\n- Lorem ipsum dolor sit.	0.00	2025-01-31 00:00:00	2024-11-21 13:51:44.962	2025-01-07 11:17:16.753	2025-01-07 11:17:16.807	1	1	\N	f	\N	\N
25	rd1hsfgp7lvgmo5fk6dxhla6	Lottery test 17:00	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.	\N	2025-01-11 17:00:00	2024-12-03 14:13:35.413	2025-01-11 17:00:00.021	\N	1	1	\N	t	k6gz6nystbdn6xyfd8l9d09o	f
181	rd1hsfgp7lvgmo5fk6dxhla6	Lottery test 17:00	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.	\N	2025-01-11 17:00:00	2024-12-03 14:13:35.413	2025-01-11 17:00:00.021	2025-01-11 17:00:00.075	1	1	\N	t	k6gz6nystbdn6xyfd8l9d09o	f
182	x3dhbk6990no9j1mnhpr121t	Lottery Product 17:30	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. \n\nUt enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	\N	2025-01-11 17:30:00	2024-12-05 11:47:14.269	2025-01-11 17:30:00.028	2025-01-11 17:30:00.042	1	1	\N	t	danpxmcht9yqoz3wekjt53dw	f
227	fh9tk5codimluv5t2rf7si3w	Manuel Lottery test 01	Manuel Lottery test 01\n- ending date not exp. test\n- no lottery users	2000.00	2025-01-23 15:34:02.783	2025-01-14 16:55:24.213	2025-01-23 15:34:04.669	\N	1	1	\N	t	o8eiugglctv5azit1bn7jtcv	t
409	fh9tk5codimluv5t2rf7si3w	Manuel Lottery test 01	Manuel Lottery test 01\n- ending date not exp. test\n- no lottery users	2000.00	2025-01-23 15:34:02.783	2025-01-14 16:55:24.213	2025-01-23 15:34:04.669	2025-01-23 15:34:05.342	1	1	\N	t	o8eiugglctv5azit1bn7jtcv	t
12	yj0tr1fwzzlc8hjdsx86b88c	Old Product Test 	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. \n	300.00	2024-11-26 16:13:00	2024-11-26 15:59:24.776	2024-12-03 14:00:37.46	\N	1	1	\N	f	\N	\N
27	zi66srj06xabgstr59q7tqxq	New lottery product.	New lottery product for testing test	1000.00	2025-01-29 09:30:00	2024-12-03 14:40:34.422	2025-01-29 09:42:10.067	\N	1	1	\N	t	gtsn4022m9giwgu0ofcyps2w	f
135	ka8ivki3yjskiw71ex7pspy6	Auto ending date test	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	\N	2025-01-07 11:15:00	2024-12-17 13:35:29.818	2025-01-07 11:11:37.511	\N	1	1	\N	f	\N	\N
3	ifnhjm24k05k5lxpww1wbogv	Samsung S20	Samsung S20, 256gb, tested	800.00	2025-01-31 00:00:00	2024-11-21 15:16:28.374	2025-01-07 11:28:18.578	\N	1	1	\N	f	\N	\N
230	ajw3hyur5nxut5qazwpn1av6	Manuel Lottery test 02	Manuel Lottery test 02\n- ending date not exp. test\n- with lottery users	\N	2025-01-31 10:54:50.036	2025-01-14 16:58:46.464	2025-01-31 11:15:02.685	\N	1	1	\N	t	vqltkvt9ugsg874s03m6d31b	t
1	ze7z8otenwlnoqzkynjjymjj	MAC BOOK PRO 16“, 8GB Ram, Intel I7	Lorem ipsum dolor sit amet, consectetur adipiscinsg elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. \n\n- Lorem ipsum dolor sit amet\n- Ut enim ad minim veniam\n- Lorem ipsum dolor sit.	0.00	2025-01-31 00:00:00	2024-11-21 13:51:44.962	2025-01-07 11:17:16.753	\N	1	1	\N	f	\N	\N
426	fn2kciz7bhq3i7l38t63c4ln	New bidding product	Lorem ipsum dolor sit amet. Hic suscipit quisquam est voluptatem velit id similique maiores cum enim assumenda ut aliquam consequuntur qui adipisci internos sed libero provident. Et similique reiciendis et obcaecati soluta sit excepturi fugit.\n\nEt aspernatur eveniet eum culpa optio?\nEst possimus pariatur qui nihil consequatur.\nCum cumque voluptatum sit saepe perferendis.\nUt velit minima ab ipsa iusto.\nEst dolor facere id ducimus aspernatur et nisi ipsa non eius autem.\nEa distinctio nesciunt ad libero voluptatem qui commodi excepturi eos minus iusto.\nEt tempore galisum sed rerum quam et voluptatem necessitatibus. Sit blanditiis atque aut exercitationem laboriosam rem maiores laudantium a architecto tenetur qui excepturi placeat.\n\nEst molestias quibusdam nam nulla autem sit vitae porro sit quos distinctio. Quo voluptas libero qui ipsum praesentium qui minus beatae non sequi nobis. Aut repellat voluptas non minus nostrum sed voluptate ducimus ut praesentium eius.	300.00	2025-02-13 10:32:43.807	2025-02-03 10:32:43.807	2025-02-03 10:32:43.807	\N	1	1	\N	f	\N	f
425	byrrau8ru3txrayeru5lvmsy	Asus Vivobook Flip TP1400KA-EC040WS) 14”	Utforska världen med Vivobook 14 Flip – den vändbara bärbara datorn som ger dig 360 grader av frihet! Med en tjocklek på bara 16,9 mm och en vikt på bara 1,5 kg är den enkel att ta med sig vart som helst, och dess Intel® Celeron® processor gör att det går, oavsett om det gäller arbete eller fritid. Med sin trendiga Quiet Blue-färg och hållbara 360-gradiga gångjärn är den mångsidiga Vivobook 14 Flip din bärbara dator, din surfplatta – eller något däremellan!\n\nVivoBook 14 Flip är utformad för den optimala pekupplevelsen, med en responsiv pekskärm som känner av även de minsta fingertoppsrörelserna.\n\nOm du vill produktivitet eller underhållning i farten så behöver du inte leta längre än Vivobook 14 Flip. Dess lätta chassi på 1,5 kg och den ultratunna profilen gör att du enkelt kan lägga den i vilken ryggsäck som helst. Ta med dig din Vivobook 14 Flip, vart du än är på väg!	2000.00	2025-02-27 00:00:00	2024-11-28 10:00:09.61	2025-02-03 09:54:06.697	2025-02-03 09:54:06.802	1	1	\N	f	\N	\N
100	ct90tmnqyxlh1b6yoeked3nh	lottery7 19:00	\N	\N	2025-01-11 19:00:00	2024-12-16 14:33:12.541	2025-01-11 19:00:00.024	\N	1	1	\N	t	gtsn4022m9giwgu0ofcyps2w	\N
186	ct90tmnqyxlh1b6yoeked3nh	lottery7 19:00	\N	\N	2025-01-11 19:00:00	2024-12-16 14:33:12.541	2025-01-11 19:00:00.024	2025-01-11 19:00:00.043	1	1	\N	t	gtsn4022m9giwgu0ofcyps2w	\N
148	ifnhjm24k05k5lxpww1wbogv	Samsung S20	Samsung S20, 256gb, tested	800.00	2025-01-31 00:00:00	2024-11-21 15:16:28.374	2025-01-07 11:28:18.578	2025-01-07 11:28:18.639	1	1	\N	f	\N	\N
94	xd659reoebr967f82ui3kozd	Lottery Product 5 18:00	Lottery Product number 5 	3000.00	2025-01-20 18:00:00	2024-12-16 14:08:56.116	2025-01-21 12:13:39.789	\N	1	1	\N	t	rfw87y9d0sw9f7gnk5u5c2wx	f
402	tjws3c566vjhlp1arabqghtj	Lottery Product 6 fun manuel lottery test	Lottery Product number 6	200.00	2025-01-14 08:30:00	2024-12-16 14:09:41.516	2025-01-21 12:11:24.139	2025-01-21 12:11:24.196	1	1	\N	t	danpxmcht9yqoz3wekjt53dw	t
232	kjr2o4gmb8qy15zd54jw4gs3	Manuel Lottery test 03 - single user	Manuel Lottery test 03\n- ending date is exp.\n- with single lottery users	\N	2025-01-16 17:10:41.041	2025-01-14 17:00:09.25	2025-01-21 12:12:08.996	\N	1	1	\N	t	rfw87y9d0sw9f7gnk5u5c2wx	t
41	x3dhbk6990no9j1mnhpr121t	Lottery Product 17:30	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. \n\nUt enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	\N	2025-01-11 17:30:00	2024-12-05 11:47:14.269	2025-01-11 17:30:00.028	\N	1	1	\N	t	danpxmcht9yqoz3wekjt53dw	f
139	fsvrszcalkunrm7ujjkj5fyi	HP ProBook 440 G6	HP ProBook 440 G6,intel core i5, 8GB, 256GB SSD,500GbHDD\nSkärm 14 tum\nWindows 10 pro 64bit Original License \nLaddare ingår \nAllt funkar Bra , \nBatteriet funkar bra\nProcessor  Intel Core i5 1.60 GHz\nROM 8GB\n256GB SSD\n500GB HDD	100.00	2025-01-31 15:57:00	2024-12-17 15:57:40.783	2025-01-07 11:09:49.521	\N	1	1	\N	f	\N	\N
183	tlrfl3vmqqvhd5248v3zzsju	Lottery Product 4 18:00	lottery product number 4	\N	2025-01-11 18:00:00	2024-12-16 14:08:09.824	2025-01-11 18:00:00.02	2025-01-11 18:00:00.036	1	1	\N	t	rfw87y9d0sw9f7gnk5u5c2wx	f
142	fsvrszcalkunrm7ujjkj5fyi	HP ProBook 440 G6	HP ProBook 440 G6,intel core i5, 8GB, 256GB SSD,500GbHDD\nSkärm 14 tum\nWindows 10 pro 64bit Original License \nLaddare ingår \nAllt funkar Bra , \nBatteriet funkar bra\nProcessor  Intel Core i5 1.60 GHz\nROM 8GB\n256GB SSD\n500GB HDD	100.00	2025-01-31 15:57:00	2024-12-17 15:57:40.783	2025-01-07 11:09:49.521	2025-01-07 11:09:49.727	1	1	\N	f	\N	\N
403	kjr2o4gmb8qy15zd54jw4gs3	Manuel Lottery test 03 - single user	Manuel Lottery test 03\n- ending date is exp.\n- with single lottery users	\N	2025-01-16 17:10:41.041	2025-01-14 17:00:09.25	2025-01-21 12:12:08.996	2025-01-21 12:12:09.016	1	1	\N	t	rfw87y9d0sw9f7gnk5u5c2wx	t
411	zi66srj06xabgstr59q7tqxq	New lottery product.	New lottery product for testing test	1000.00	2025-01-29 09:30:00	2024-12-03 14:40:34.422	2025-01-29 09:42:10.067	2025-01-29 09:42:10.636	1	1	\N	t	gtsn4022m9giwgu0ofcyps2w	f
423	ajw3hyur5nxut5qazwpn1av6	Manuel Lottery test 02	Manuel Lottery test 02\n- ending date not exp. test\n- with lottery users	\N	2025-01-31 10:54:50.036	2025-01-14 16:58:46.464	2025-01-31 11:15:02.685	2025-01-31 11:15:02.699	1	1	\N	t	vqltkvt9ugsg874s03m6d31b	t
19	byrrau8ru3txrayeru5lvmsy	Asus Vivobook Flip TP1400KA-EC040WS) 14”	Utforska världen med Vivobook 14 Flip – den vändbara bärbara datorn som ger dig 360 grader av frihet! Med en tjocklek på bara 16,9 mm och en vikt på bara 1,5 kg är den enkel att ta med sig vart som helst, och dess Intel® Celeron® processor gör att det går, oavsett om det gäller arbete eller fritid. Med sin trendiga Quiet Blue-färg och hållbara 360-gradiga gångjärn är den mångsidiga Vivobook 14 Flip din bärbara dator, din surfplatta – eller något däremellan!\n\nVivoBook 14 Flip är utformad för den optimala pekupplevelsen, med en responsiv pekskärm som känner av även de minsta fingertoppsrörelserna.\n\nOm du vill produktivitet eller underhållning i farten så behöver du inte leta längre än Vivobook 14 Flip. Dess lätta chassi på 1,5 kg och den ultratunna profilen gör att du enkelt kan lägga den i vilken ryggsäck som helst. Ta med dig din Vivobook 14 Flip, vart du än är på väg!	2000.00	2025-02-27 00:00:00	2024-11-28 10:00:09.61	2025-02-03 09:54:06.697	\N	1	1	\N	f	\N	\N
435	wilz7xntizp4z6az2tcdhmx6	HP EliteBook 840 G7 14" Full HD i5 (gen 10) 8GB 256GB SSD Windows 11 Pro	Portabel och lätt 14-tums laptop för företagaren eller hemanvändaren med höga krav. Utmärkt prestanda genom den fyrkärniga Intel i5-processorn och en snabb SSD på 256 GB. Bra anslutningsmöjligheter med dubbla Thunderbolt 4-portar och WiFi 6 för ultrasnabba trådlösa överföringar. Kommer med Windows 11 Pro.	500.00	2025-03-30 00:00:00	2025-02-05 12:33:40.887	2025-02-05 12:33:40.887	\N	1	1	\N	f	\N	f
436	wilz7xntizp4z6az2tcdhmx6	HP EliteBook 840 G7 14" Full HD i5 (gen 10) 8GB 256GB SSD Windows 11 Pro	Portabel och lätt 14-tums laptop för företagaren eller hemanvändaren med höga krav. Utmärkt prestanda genom den fyrkärniga Intel i5-processorn och en snabb SSD på 256 GB. Bra anslutningsmöjligheter med dubbla Thunderbolt 4-portar och WiFi 6 för ultrasnabba trådlösa överföringar. Kommer med Windows 11 Pro.	500.00	2025-03-30 00:00:00	2025-02-05 12:33:40.887	2025-02-05 12:33:40.887	2025-02-05 12:33:40.915	1	1	\N	f	\N	f
433	r2tqnnds3j5z0pe60qsl9bep	Mac Mini 8.1 Late 2018 i5 16GB 512GB SSD	Tunna och kompakta Mac Mini med bra prestanda genom sexkärnig Intel i5, 16GB RAM och snabb och rymlig SSD på 512 GB! Har stöd för senaste versionen av macOS.\n\nProcessor: Intel Core i5-8500B 3 GHz (4.1 GHz Turbo)\nProcessorkärnor: 6 kärnor\nCacheminne: 9 MB L3-cache\nMinne: 16 GB DDR4 RAM-minne\nLagringsutrymme: 512 GB SSD-hårddisk	800.00	2025-03-31 00:00:00	2025-02-05 12:30:21.156	2025-02-05 12:30:21.156	\N	1	1	\N	f	\N	f
434	r2tqnnds3j5z0pe60qsl9bep	Mac Mini 8.1 Late 2018 i5 16GB 512GB SSD	Tunna och kompakta Mac Mini med bra prestanda genom sexkärnig Intel i5, 16GB RAM och snabb och rymlig SSD på 512 GB! Har stöd för senaste versionen av macOS.\n\nProcessor: Intel Core i5-8500B 3 GHz (4.1 GHz Turbo)\nProcessorkärnor: 6 kärnor\nCacheminne: 9 MB L3-cache\nMinne: 16 GB DDR4 RAM-minne\nLagringsutrymme: 512 GB SSD-hårddisk	800.00	2025-03-31 00:00:00	2025-02-05 12:30:21.156	2025-02-05 12:30:21.156	2025-02-05 12:30:21.186	1	1	\N	f	\N	f
427	fn2kciz7bhq3i7l38t63c4ln	New bidding product	Lorem ipsum dolor sit amet. Hic suscipit quisquam est voluptatem velit id similique maiores cum enim assumenda ut aliquam consequuntur qui adipisci internos sed libero provident. Et similique reiciendis et obcaecati soluta sit excepturi fugit.\n\nEt aspernatur eveniet eum culpa optio?\nEst possimus pariatur qui nihil consequatur.\nCum cumque voluptatum sit saepe perferendis.\nUt velit minima ab ipsa iusto.\nEst dolor facere id ducimus aspernatur et nisi ipsa non eius autem.\nEa distinctio nesciunt ad libero voluptatem qui commodi excepturi eos minus iusto.\nEt tempore galisum sed rerum quam et voluptatem necessitatibus. Sit blanditiis atque aut exercitationem laboriosam rem maiores laudantium a architecto tenetur qui excepturi placeat.\n\nEst molestias quibusdam nam nulla autem sit vitae porro sit quos distinctio. Quo voluptas libero qui ipsum praesentium qui minus beatae non sequi nobis. Aut repellat voluptas non minus nostrum sed voluptate ducimus ut praesentium eius.	300.00	2025-02-13 10:32:43.807	2025-02-03 10:32:43.807	2025-02-03 10:32:43.807	2025-02-03 10:32:43.837	1	1	\N	f	\N	f
437	wjnm6u8zyrrlqpxa4r4v6fou	Apple iPhone SE (2020) 64GB (2nd Generation) Svart	Fantastiska iPhone SE 64GB (2nd Generation) med fantastisk vatten- och dammtät design i glas och utrustad med det kraftfulla A13 Bionic-chippet. Har stöd för trådlös laddning och stödjer det senaste iOS 18 (2024) som gör din iPhone ännu bättre!	100.00	2025-02-15 12:37:09.655	2025-02-05 12:37:09.655	2025-02-05 12:37:09.655	\N	1	1	\N	f	\N	f
438	wjnm6u8zyrrlqpxa4r4v6fou	Apple iPhone SE (2020) 64GB (2nd Generation) Svart	Fantastiska iPhone SE 64GB (2nd Generation) med fantastisk vatten- och dammtät design i glas och utrustad med det kraftfulla A13 Bionic-chippet. Har stöd för trådlös laddning och stödjer det senaste iOS 18 (2024) som gör din iPhone ännu bättre!	100.00	2025-02-15 12:37:09.655	2025-02-05 12:37:09.655	2025-02-05 12:37:09.655	2025-02-05 12:37:09.683	1	1	\N	f	\N	f
439	jwk393srey787lgo50o9m0w3	Dell S2722DC 27-tums IPS-skärm med 65W USB-C Power Delivery & Ergonomisk fot	Ergonomisk IPS-skärm med utmärkt bild, klara färger och mycket bra betraktningsvinkel. Den har 2 HDMI-portar, 65W USB-C Power Delivery och stöd för AMD FreeSync. Fantastisk 2560 x 1440 pixlars upplösning. Höj & sänkbar samt pivot!	1200.00	2025-03-15 00:00:00	2025-02-05 12:39:32.058	2025-02-05 12:41:03.061	\N	1	1	\N	f	\N	f
441	jwk393srey787lgo50o9m0w3	Dell S2722DC 27-tums IPS-skärm med 65W USB-C Power Delivery & Ergonomisk fot	Ergonomisk IPS-skärm med utmärkt bild, klara färger och mycket bra betraktningsvinkel. Den har 2 HDMI-portar, 65W USB-C Power Delivery och stöd för AMD FreeSync. Fantastisk 2560 x 1440 pixlars upplösning. Höj & sänkbar samt pivot!	1200.00	2025-03-15 00:00:00	2025-02-05 12:39:32.058	2025-02-05 12:41:03.061	2025-02-05 12:41:03.091	1	1	\N	f	\N	f
447	kcoqsy1a9xidpilst3fia6kl	Mac Mini 2017 i5 8GB 512GB SSD	Tunna och kompakta Mac Mini med bra prestanda genom sexkärnig Intel i5 och snabb och rymlig SSD på 512 GB! Har stöd för senaste versionen av macOS.	\N	2025-02-28 12:48:00	2025-02-05 12:48:52.806	2025-02-05 12:56:36.699	\N	1	1	\N	t	\N	f
451	kcoqsy1a9xidpilst3fia6kl	Mac Mini 2017 i5 8GB 512GB SSD	Tunna och kompakta Mac Mini med bra prestanda genom sexkärnig Intel i5 och snabb och rymlig SSD på 512 GB! Har stöd för senaste versionen av macOS.	\N	2025-02-28 12:48:00	2025-02-05 12:48:52.806	2025-02-05 12:56:36.699	2025-02-05 12:56:36.724	1	1	\N	t	\N	f
456	erh1tm78336v93vjpqmd7q03	Thinkpad T14 G1 14" Full HD i7 (10th Gen) 32GB 512GB SSD W11P	Högkvalitativ och kraftfull 14-tums företagsdator med snabb fyrkärnig i7-processor av tionde generationen, hela 32 GB RAM, en SSD-hårddisk på 512 GB och Windows 11 Pro som operativsystem. Här får du mycket god prestanda i en portabel dator med en utmärkt Full HD-upplöst IPS-skärm - helt enkelt ett riktigt kraftpaket i precis lagom storlek!	\N	2025-03-14 00:00:00	2025-02-05 13:15:29.675	2025-02-05 13:15:29.675	2025-02-05 13:15:29.704	1	1	\N	f	\N	f
442	l0n23816p1ncsnd3kbh6idlg	Philips 242G5D 24-tums Full HD 144 Hz LED-skärm	Begagnad utan monitorfot - fot kan köpas separat! Snabb 24-tums gaming-bildskärm med 144 Hz uppdatering (vid användning av Dual-Link DVI eller DisplayPort) och 1 millisekunds responstid. Har också en inbyggd 4-portars USB 3.0-hubb!	300.00	2025-03-23 12:43:00	2025-02-05 12:43:58.536	2025-02-05 12:57:06.136	\N	1	1	\N	t	\N	f
452	l0n23816p1ncsnd3kbh6idlg	Philips 242G5D 24-tums Full HD 144 Hz LED-skärm	Begagnad utan monitorfot - fot kan köpas separat! Snabb 24-tums gaming-bildskärm med 144 Hz uppdatering (vid användning av Dual-Link DVI eller DisplayPort) och 1 millisekunds responstid. Har också en inbyggd 4-portars USB 3.0-hubb!	300.00	2025-03-23 12:43:00	2025-02-05 12:43:58.536	2025-02-05 12:57:06.136	2025-02-05 12:57:06.16	1	1	\N	t	\N	f
455	erh1tm78336v93vjpqmd7q03	Thinkpad T14 G1 14" Full HD i7 (10th Gen) 32GB 512GB SSD W11P	Högkvalitativ och kraftfull 14-tums företagsdator med snabb fyrkärnig i7-processor av tionde generationen, hela 32 GB RAM, en SSD-hårddisk på 512 GB och Windows 11 Pro som operativsystem. Här får du mycket god prestanda i en portabel dator med en utmärkt Full HD-upplöst IPS-skärm - helt enkelt ett riktigt kraftpaket i precis lagom storlek!	\N	2025-03-14 00:00:00	2025-02-05 13:15:29.675	2025-02-05 13:15:29.675	\N	1	1	\N	f	\N	f
457	bu59j8s39rmsaoxhg0283si2	Apple iPad 5th Gen. 32GB Space Grey	Denna iPad 5th generation har fantastisk retinaskärm, Touch ID och det kraftfulla A9-chippet. Detta är 32 GB WiFi-versionen i Space Grey!	\N	2025-03-06 00:00:00	2025-02-05 13:32:17.947	2025-02-05 13:32:17.947	\N	1	1	\N	t	\N	f
458	bu59j8s39rmsaoxhg0283si2	Apple iPad 5th Gen. 32GB Space Grey	Denna iPad 5th generation har fantastisk retinaskärm, Touch ID och det kraftfulla A9-chippet. Detta är 32 GB WiFi-versionen i Space Grey!	\N	2025-03-06 00:00:00	2025-02-05 13:32:17.947	2025-02-05 13:32:17.947	2025-02-05 13:32:17.977	1	1	\N	t	\N	f
449	dfmyi9vi27izj0uqhdbwkv78	43" Smart LED-TV med HD-upplösning Man-Lot-Test	Toshiba 43LA2E63DG är en Smart LED-TV som är fullpackad med underhållning. Det du inte hittar direkt i TV:n kan du streama från din smartphone tack vare dess inbyggda Google Chromecast. Dolby Atmos ger dig en förbättrad ljudupplevelse oavsett vad du tittar på, och med HDR blir bilden alltid bra. TV:n erbjuder dessutom flera anslutningsmöjligheter med HDMI- och USB-portar och stöd för både WiFi, Bluetooth och Ethernet. Skräddarsy TV:n efter behov och luta dig tillbaka – och njut av just din favoritunderhållning.	\N	2025-02-28 09:54:00	2025-02-05 12:55:02.853	2025-02-06 09:59:55.041	\N	1	1	\N	t	\N	t
453	n51a1ssb0y6sly61giclf3jd	Lenovo ThinkCentre TIO22Gen4 22" IPS-skärm	22-tums skärm som är perfekt för smidiga videosamtal tack vare sin inbyggda 720p-webbkamera, mikrofon och högtalare och som ger bra bild med den Full HD-upplösta IPS-panelen. Skärmen har en inbyggd 3-i-1 kabel för anslutning av DisplayPort, USB och ström och även en USB-port för anslutning av tillbehör direkt i skärmen.	100.00	2025-02-28 16:02:00	2025-02-05 13:00:39.677	2025-02-10 13:34:12.177	\N	1	1	\N	t	\N	t
465	dfmyi9vi27izj0uqhdbwkv78	43" Smart LED-TV med HD-upplösning Man-Lot-Test	Toshiba 43LA2E63DG är en Smart LED-TV som är fullpackad med underhållning. Det du inte hittar direkt i TV:n kan du streama från din smartphone tack vare dess inbyggda Google Chromecast. Dolby Atmos ger dig en förbättrad ljudupplevelse oavsett vad du tittar på, och med HDR blir bilden alltid bra. TV:n erbjuder dessutom flera anslutningsmöjligheter med HDMI- och USB-portar och stöd för både WiFi, Bluetooth och Ethernet. Skräddarsy TV:n efter behov och luta dig tillbaka – och njut av just din favoritunderhållning.	\N	2025-02-28 09:54:00	2025-02-05 12:55:02.853	2025-02-06 09:59:55.041	2025-02-06 09:59:55.155	1	1	\N	t	\N	t
412	rqrvc9d3vx4yjd4l4zcmsvo6	Lottery Product for Jan25 - Auto	Lotttery test product for January.\nLotttery type: Auto	1000.00	2025-02-08 14:11:29.766	2025-01-29 14:11:29.766	2025-02-10 06:14:27.437	\N	1	1	\N	t	danpxmcht9yqoz3wekjt53dw	f
471	rqrvc9d3vx4yjd4l4zcmsvo6	Lottery Product for Jan25 - Auto	Lotttery test product for January.\nLotttery type: Auto	1000.00	2025-02-08 14:11:29.766	2025-01-29 14:11:29.766	2025-02-10 06:14:27.437	2025-02-10 06:14:27.699	1	1	\N	t	danpxmcht9yqoz3wekjt53dw	f
414	xo3wuctpn8aukndnasuf1gc1	Lottery Product for Feb25 - Manual	Lottery test product for feb.\nLottery type: Manual	\N	2025-02-25 09:41:00	2025-01-29 14:12:51.518	2025-02-10 13:10:06.121	\N	1	1	\N	t	\N	t
472	xo3wuctpn8aukndnasuf1gc1	Lottery Product for Feb25 - Manual	Lottery test product for feb.\nLottery type: Manual	\N	2025-02-25 09:41:00	2025-01-29 14:12:51.518	2025-02-10 13:10:06.121	2025-02-10 13:10:06.189	1	1	\N	t	\N	t
473	n51a1ssb0y6sly61giclf3jd	Lenovo ThinkCentre TIO22Gen4 22" IPS-skärm	22-tums skärm som är perfekt för smidiga videosamtal tack vare sin inbyggda 720p-webbkamera, mikrofon och högtalare och som ger bra bild med den Full HD-upplösta IPS-panelen. Skärmen har en inbyggd 3-i-1 kabel för anslutning av DisplayPort, USB och ström och även en USB-port för anslutning av tillbehör direkt i skärmen.	100.00	2025-02-28 16:02:00	2025-02-05 13:00:39.677	2025-02-10 13:34:12.177	2025-02-10 13:34:12.202	1	1	\N	t	\N	t
\.


--
-- Data for Name: products_biduser_lnk; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.products_biduser_lnk (id, product_id, biduser_id, product_ord) FROM stdin;
2789	436	12	1
2792	427	12	2
2797	434	12	3
2871	456	12	5
2882	465	12	6
2895	438	12	7
2910	458	12	8
2928	436	309	1
2929	427	309	2
2930	434	309	3
2932	456	309	5
2933	465	309	6
2934	438	309	7
2935	458	309	8
1275	183	3	1
1486	148	3	2
2754	183	293	1
2755	148	293	2
1973	143	5	1
1984	142	5	2
1997	423	5	3
2012	147	5	4
2029	182	5	5
2048	23	5	6
2069	405	5	7
2383	425	5	8
2446	186	5	10
2471	411	5	11
2498	402	5	12
2527	403	5	13
2774	143	294	1
2775	142	294	2
2776	423	294	3
2777	147	294	4
2778	182	294	5
2779	23	294	6
2780	405	294	7
2781	425	294	8
2783	186	294	10
2784	411	294	11
2785	402	294	12
2786	403	294	13
\.


--
-- Data for Name: products_categories_lnk; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.products_categories_lnk (id, product_id, category_id, category_ord) FROM stdin;
1	1	1	0
432	465	14	1
3	3	3	0
438	471	6	1
439	472	6	1
440	473	6	1
12	12	1	0
363	402	5	1
364	403	6	1
366	405	6	1
19	19	1	0
193	227	7	0
25	25	1	0
196	230	3	0
27	27	1	0
198	232	1	0
372	411	6	1
373	412	1	0
92	92	3	0
147	181	6	1
148	182	6	1
94	94	1	0
149	183	5	1
375	414	1	0
41	41	1	0
152	186	6	1
100	100	1	1
201	96	3	1
23	23	6	1
384	423	5	1
386	425	6	1
387	426	3	0
388	427	5	1
102	135	7	1
105	139	1	0
370	409	10	1
109	143	10	1
108	142	6	1
394	433	1	0
395	434	6	1
113	147	6	1
114	148	5	1
396	435	1	0
397	436	6	1
398	437	3	0
399	438	5	1
400	439	11	0
402	441	12	1
403	442	11	1
411	447	1	0
413	449	13	0
415	451	6	1
416	452	12	1
419	455	1	0
420	456	6	1
421	457	13	0
422	458	14	1
423	453	1	1
\.


--
-- Data for Name: strapi_api_token_permissions; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.strapi_api_token_permissions (id, document_id, action, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: strapi_api_token_permissions_token_lnk; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.strapi_api_token_permissions_token_lnk (id, api_token_permission_id, api_token_id, api_token_permission_ord) FROM stdin;
\.


--
-- Data for Name: strapi_api_tokens; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.strapi_api_tokens (id, document_id, name, description, type, access_key, last_used_at, expires_at, lifespan, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: strapi_core_store_settings; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.strapi_core_store_settings (id, key, value, type, environment, tag) FROM stdin;
2	plugin_content_manager_configuration_content_types::plugin::i18n.locale	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"code":{"edit":{"label":"code","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"code","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","code","createdAt"],"edit":[[{"name":"name","size":6},{"name":"code","size":6}]]},"uid":"plugin::i18n.locale"}	object	\N	\N
3	plugin_content_manager_configuration_content_types::plugin::upload.folder	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"pathId":{"edit":{"label":"pathId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"pathId","searchable":true,"sortable":true}},"parent":{"edit":{"label":"parent","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"parent","searchable":true,"sortable":true}},"children":{"edit":{"label":"children","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"children","searchable":false,"sortable":false}},"files":{"edit":{"label":"files","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"files","searchable":false,"sortable":false}},"path":{"edit":{"label":"path","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"path","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","pathId","parent"],"edit":[[{"name":"name","size":6},{"name":"pathId","size":4}],[{"name":"parent","size":6},{"name":"children","size":6}],[{"name":"files","size":6},{"name":"path","size":6}]]},"uid":"plugin::upload.folder"}	object	\N	\N
4	plugin_content_manager_configuration_content_types::plugin::content-releases.release	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"releasedAt":{"edit":{"label":"releasedAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"releasedAt","searchable":true,"sortable":true}},"scheduledAt":{"edit":{"label":"scheduledAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"scheduledAt","searchable":true,"sortable":true}},"timezone":{"edit":{"label":"timezone","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"timezone","searchable":true,"sortable":true}},"status":{"edit":{"label":"status","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"status","searchable":true,"sortable":true}},"actions":{"edit":{"label":"actions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"contentType"},"list":{"label":"actions","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","releasedAt","scheduledAt"],"edit":[[{"name":"name","size":6},{"name":"releasedAt","size":6}],[{"name":"scheduledAt","size":6},{"name":"timezone","size":6}],[{"name":"status","size":6},{"name":"actions","size":6}]]},"uid":"plugin::content-releases.release"}	object	\N	\N
5	plugin_content_manager_configuration_content_types::plugin::review-workflows.workflow	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"stages":{"edit":{"label":"stages","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"stages","searchable":false,"sortable":false}},"stageRequiredToPublish":{"edit":{"label":"stageRequiredToPublish","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"stageRequiredToPublish","searchable":true,"sortable":true}},"contentTypes":{"edit":{"label":"contentTypes","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"contentTypes","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","stages","stageRequiredToPublish"],"edit":[[{"name":"name","size":6},{"name":"stages","size":6}],[{"name":"stageRequiredToPublish","size":6}],[{"name":"contentTypes","size":12}]]},"uid":"plugin::review-workflows.workflow"}	object	\N	\N
6	plugin_content_manager_configuration_content_types::plugin::upload.file	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"alternativeText":{"edit":{"label":"alternativeText","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"alternativeText","searchable":true,"sortable":true}},"caption":{"edit":{"label":"caption","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"caption","searchable":true,"sortable":true}},"width":{"edit":{"label":"width","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"width","searchable":true,"sortable":true}},"height":{"edit":{"label":"height","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"height","searchable":true,"sortable":true}},"formats":{"edit":{"label":"formats","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"formats","searchable":false,"sortable":false}},"hash":{"edit":{"label":"hash","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"hash","searchable":true,"sortable":true}},"ext":{"edit":{"label":"ext","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"ext","searchable":true,"sortable":true}},"mime":{"edit":{"label":"mime","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"mime","searchable":true,"sortable":true}},"size":{"edit":{"label":"size","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"size","searchable":true,"sortable":true}},"url":{"edit":{"label":"url","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"url","searchable":true,"sortable":true}},"previewUrl":{"edit":{"label":"previewUrl","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"previewUrl","searchable":true,"sortable":true}},"provider":{"edit":{"label":"provider","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"provider","searchable":true,"sortable":true}},"provider_metadata":{"edit":{"label":"provider_metadata","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"provider_metadata","searchable":false,"sortable":false}},"folder":{"edit":{"label":"folder","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"folder","searchable":true,"sortable":true}},"folderPath":{"edit":{"label":"folderPath","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"folderPath","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","alternativeText","caption"],"edit":[[{"name":"name","size":6},{"name":"alternativeText","size":6}],[{"name":"caption","size":6},{"name":"width","size":4}],[{"name":"height","size":4}],[{"name":"formats","size":12}],[{"name":"hash","size":6},{"name":"ext","size":6}],[{"name":"mime","size":6},{"name":"size","size":4}],[{"name":"url","size":6},{"name":"previewUrl","size":6}],[{"name":"provider","size":6}],[{"name":"provider_metadata","size":12}],[{"name":"folder","size":6},{"name":"folderPath","size":6}]]},"uid":"plugin::upload.file"}	object	\N	\N
7	plugin_content_manager_configuration_content_types::plugin::review-workflows.workflow-stage	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"color":{"edit":{"label":"color","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"color","searchable":true,"sortable":true}},"workflow":{"edit":{"label":"workflow","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"workflow","searchable":true,"sortable":true}},"permissions":{"edit":{"label":"permissions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"action"},"list":{"label":"permissions","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","color","workflow"],"edit":[[{"name":"name","size":6},{"name":"color","size":6}],[{"name":"workflow","size":6},{"name":"permissions","size":6}]]},"uid":"plugin::review-workflows.workflow-stage"}	object	\N	\N
9	plugin_content_manager_configuration_content_types::plugin::users-permissions.user	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"username","defaultSortBy":"username","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"username":{"edit":{"label":"username","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"username","searchable":true,"sortable":true}},"email":{"edit":{"label":"email","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"email","searchable":true,"sortable":true}},"provider":{"edit":{"label":"provider","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"provider","searchable":true,"sortable":true}},"password":{"edit":{"label":"password","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"password","searchable":true,"sortable":true}},"resetPasswordToken":{"edit":{"label":"resetPasswordToken","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"resetPasswordToken","searchable":true,"sortable":true}},"confirmationToken":{"edit":{"label":"confirmationToken","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"confirmationToken","searchable":true,"sortable":true}},"confirmed":{"edit":{"label":"confirmed","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"confirmed","searchable":true,"sortable":true}},"blocked":{"edit":{"label":"blocked","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"blocked","searchable":true,"sortable":true}},"role":{"edit":{"label":"role","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"role","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","username","email","confirmed"],"edit":[[{"name":"username","size":6},{"name":"email","size":6}],[{"name":"password","size":6},{"name":"confirmed","size":4}],[{"name":"blocked","size":4},{"name":"role","size":6}]]},"uid":"plugin::users-permissions.user"}	object	\N	\N
10	plugin_content_manager_configuration_content_types::plugin::users-permissions.role	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"type":{"edit":{"label":"type","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"type","searchable":true,"sortable":true}},"permissions":{"edit":{"label":"permissions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"action"},"list":{"label":"permissions","searchable":false,"sortable":false}},"users":{"edit":{"label":"users","description":"","placeholder":"","visible":true,"editable":true,"mainField":"username"},"list":{"label":"users","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","description","type"],"edit":[[{"name":"name","size":6},{"name":"description","size":6}],[{"name":"type","size":6},{"name":"permissions","size":6}],[{"name":"users","size":6}]]},"uid":"plugin::users-permissions.role"}	object	\N	\N
1	strapi_content_types_schema	{"plugin::upload.file":{"collectionName":"files","info":{"singularName":"file","pluralName":"files","displayName":"File","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","configurable":false,"required":true},"alternativeText":{"type":"string","configurable":false},"caption":{"type":"string","configurable":false},"width":{"type":"integer","configurable":false},"height":{"type":"integer","configurable":false},"formats":{"type":"json","configurable":false},"hash":{"type":"string","configurable":false,"required":true},"ext":{"type":"string","configurable":false},"mime":{"type":"string","configurable":false,"required":true},"size":{"type":"decimal","configurable":false,"required":true},"url":{"type":"string","configurable":false,"required":true},"previewUrl":{"type":"string","configurable":false},"provider":{"type":"string","configurable":false,"required":true},"provider_metadata":{"type":"json","configurable":false},"related":{"type":"relation","relation":"morphToMany","configurable":false},"folder":{"type":"relation","relation":"manyToOne","target":"plugin::upload.folder","inversedBy":"files","private":true},"folderPath":{"type":"string","minLength":1,"required":true,"private":true,"searchable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::upload.file","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"files"}}},"indexes":[{"name":"upload_files_folder_path_index","columns":["folder_path"],"type":null},{"name":"upload_files_created_at_index","columns":["created_at"],"type":null},{"name":"upload_files_updated_at_index","columns":["updated_at"],"type":null},{"name":"upload_files_name_index","columns":["name"],"type":null},{"name":"upload_files_size_index","columns":["size"],"type":null},{"name":"upload_files_ext_index","columns":["ext"],"type":null}],"plugin":"upload","globalId":"UploadFile","uid":"plugin::upload.file","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"files","info":{"singularName":"file","pluralName":"files","displayName":"File","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","configurable":false,"required":true},"alternativeText":{"type":"string","configurable":false},"caption":{"type":"string","configurable":false},"width":{"type":"integer","configurable":false},"height":{"type":"integer","configurable":false},"formats":{"type":"json","configurable":false},"hash":{"type":"string","configurable":false,"required":true},"ext":{"type":"string","configurable":false},"mime":{"type":"string","configurable":false,"required":true},"size":{"type":"decimal","configurable":false,"required":true},"url":{"type":"string","configurable":false,"required":true},"previewUrl":{"type":"string","configurable":false},"provider":{"type":"string","configurable":false,"required":true},"provider_metadata":{"type":"json","configurable":false},"related":{"type":"relation","relation":"morphToMany","configurable":false},"folder":{"type":"relation","relation":"manyToOne","target":"plugin::upload.folder","inversedBy":"files","private":true},"folderPath":{"type":"string","minLength":1,"required":true,"private":true,"searchable":false}},"kind":"collectionType"},"modelName":"file"},"plugin::upload.folder":{"collectionName":"upload_folders","info":{"singularName":"folder","pluralName":"folders","displayName":"Folder"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"required":true},"pathId":{"type":"integer","unique":true,"required":true},"parent":{"type":"relation","relation":"manyToOne","target":"plugin::upload.folder","inversedBy":"children"},"children":{"type":"relation","relation":"oneToMany","target":"plugin::upload.folder","mappedBy":"parent"},"files":{"type":"relation","relation":"oneToMany","target":"plugin::upload.file","mappedBy":"folder"},"path":{"type":"string","minLength":1,"required":true},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::upload.folder","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"upload_folders"}}},"indexes":[{"name":"upload_folders_path_id_index","columns":["path_id"],"type":"unique"},{"name":"upload_folders_path_index","columns":["path"],"type":"unique"}],"plugin":"upload","globalId":"UploadFolder","uid":"plugin::upload.folder","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"upload_folders","info":{"singularName":"folder","pluralName":"folders","displayName":"Folder"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"required":true},"pathId":{"type":"integer","unique":true,"required":true},"parent":{"type":"relation","relation":"manyToOne","target":"plugin::upload.folder","inversedBy":"children"},"children":{"type":"relation","relation":"oneToMany","target":"plugin::upload.folder","mappedBy":"parent"},"files":{"type":"relation","relation":"oneToMany","target":"plugin::upload.file","mappedBy":"folder"},"path":{"type":"string","minLength":1,"required":true}},"kind":"collectionType"},"modelName":"folder"},"plugin::i18n.locale":{"info":{"singularName":"locale","pluralName":"locales","collectionName":"locales","displayName":"Locale","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","min":1,"max":50,"configurable":false},"code":{"type":"string","unique":true,"configurable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::i18n.locale","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"i18n_locale"}}},"plugin":"i18n","collectionName":"i18n_locale","globalId":"I18NLocale","uid":"plugin::i18n.locale","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"i18n_locale","info":{"singularName":"locale","pluralName":"locales","collectionName":"locales","displayName":"Locale","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","min":1,"max":50,"configurable":false},"code":{"type":"string","unique":true,"configurable":false}},"kind":"collectionType"},"modelName":"locale"},"plugin::content-releases.release":{"collectionName":"strapi_releases","info":{"singularName":"release","pluralName":"releases","displayName":"Release"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","required":true},"releasedAt":{"type":"datetime"},"scheduledAt":{"type":"datetime"},"timezone":{"type":"string"},"status":{"type":"enumeration","enum":["ready","blocked","failed","done","empty"],"required":true},"actions":{"type":"relation","relation":"oneToMany","target":"plugin::content-releases.release-action","mappedBy":"release"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::content-releases.release","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_releases"}}},"plugin":"content-releases","globalId":"ContentReleasesRelease","uid":"plugin::content-releases.release","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_releases","info":{"singularName":"release","pluralName":"releases","displayName":"Release"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","required":true},"releasedAt":{"type":"datetime"},"scheduledAt":{"type":"datetime"},"timezone":{"type":"string"},"status":{"type":"enumeration","enum":["ready","blocked","failed","done","empty"],"required":true},"actions":{"type":"relation","relation":"oneToMany","target":"plugin::content-releases.release-action","mappedBy":"release"}},"kind":"collectionType"},"modelName":"release"},"plugin::content-releases.release-action":{"collectionName":"strapi_release_actions","info":{"singularName":"release-action","pluralName":"release-actions","displayName":"Release Action"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"type":{"type":"enumeration","enum":["publish","unpublish"],"required":true},"contentType":{"type":"string","required":true},"entryDocumentId":{"type":"string"},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"release":{"type":"relation","relation":"manyToOne","target":"plugin::content-releases.release","inversedBy":"actions"},"isEntryValid":{"type":"boolean"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::content-releases.release-action","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_release_actions"}}},"plugin":"content-releases","globalId":"ContentReleasesReleaseAction","uid":"plugin::content-releases.release-action","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_release_actions","info":{"singularName":"release-action","pluralName":"release-actions","displayName":"Release Action"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"type":{"type":"enumeration","enum":["publish","unpublish"],"required":true},"contentType":{"type":"string","required":true},"entryDocumentId":{"type":"string"},"locale":{"type":"string"},"release":{"type":"relation","relation":"manyToOne","target":"plugin::content-releases.release","inversedBy":"actions"},"isEntryValid":{"type":"boolean"}},"kind":"collectionType"},"modelName":"release-action"},"plugin::review-workflows.workflow":{"collectionName":"strapi_workflows","info":{"name":"Workflow","description":"","singularName":"workflow","pluralName":"workflows","displayName":"Workflow"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","required":true,"unique":true},"stages":{"type":"relation","target":"plugin::review-workflows.workflow-stage","relation":"oneToMany","mappedBy":"workflow"},"stageRequiredToPublish":{"type":"relation","target":"plugin::review-workflows.workflow-stage","relation":"oneToOne","required":false},"contentTypes":{"type":"json","required":true,"default":"[]"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::review-workflows.workflow","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_workflows"}}},"plugin":"review-workflows","globalId":"ReviewWorkflowsWorkflow","uid":"plugin::review-workflows.workflow","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_workflows","info":{"name":"Workflow","description":"","singularName":"workflow","pluralName":"workflows","displayName":"Workflow"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","required":true,"unique":true},"stages":{"type":"relation","target":"plugin::review-workflows.workflow-stage","relation":"oneToMany","mappedBy":"workflow"},"stageRequiredToPublish":{"type":"relation","target":"plugin::review-workflows.workflow-stage","relation":"oneToOne","required":false},"contentTypes":{"type":"json","required":true,"default":"[]"}},"kind":"collectionType"},"modelName":"workflow"},"plugin::review-workflows.workflow-stage":{"collectionName":"strapi_workflows_stages","info":{"name":"Workflow Stage","description":"","singularName":"workflow-stage","pluralName":"workflow-stages","displayName":"Stages"},"options":{"version":"1.1.0","draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","configurable":false},"color":{"type":"string","configurable":false,"default":"#4945FF"},"workflow":{"type":"relation","target":"plugin::review-workflows.workflow","relation":"manyToOne","inversedBy":"stages","configurable":false},"permissions":{"type":"relation","target":"admin::permission","relation":"manyToMany","configurable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::review-workflows.workflow-stage","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_workflows_stages"}}},"plugin":"review-workflows","globalId":"ReviewWorkflowsWorkflowStage","uid":"plugin::review-workflows.workflow-stage","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_workflows_stages","info":{"name":"Workflow Stage","description":"","singularName":"workflow-stage","pluralName":"workflow-stages","displayName":"Stages"},"options":{"version":"1.1.0"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","configurable":false},"color":{"type":"string","configurable":false,"default":"#4945FF"},"workflow":{"type":"relation","target":"plugin::review-workflows.workflow","relation":"manyToOne","inversedBy":"stages","configurable":false},"permissions":{"type":"relation","target":"admin::permission","relation":"manyToMany","configurable":false}},"kind":"collectionType"},"modelName":"workflow-stage"},"plugin::users-permissions.permission":{"collectionName":"up_permissions","info":{"name":"permission","description":"","singularName":"permission","pluralName":"permissions","displayName":"Permission"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","required":true,"configurable":false},"role":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.role","inversedBy":"permissions","configurable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.permission","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"up_permissions"}}},"plugin":"users-permissions","globalId":"UsersPermissionsPermission","uid":"plugin::users-permissions.permission","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"up_permissions","info":{"name":"permission","description":"","singularName":"permission","pluralName":"permissions","displayName":"Permission"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","required":true,"configurable":false},"role":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.role","inversedBy":"permissions","configurable":false}},"kind":"collectionType"},"modelName":"permission","options":{"draftAndPublish":false}},"plugin::users-permissions.role":{"collectionName":"up_roles","info":{"name":"role","description":"","singularName":"role","pluralName":"roles","displayName":"Role"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":3,"required":true,"configurable":false},"description":{"type":"string","configurable":false},"type":{"type":"string","unique":true,"configurable":false},"permissions":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.permission","mappedBy":"role","configurable":false},"users":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.user","mappedBy":"role","configurable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.role","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"up_roles"}}},"plugin":"users-permissions","globalId":"UsersPermissionsRole","uid":"plugin::users-permissions.role","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"up_roles","info":{"name":"role","description":"","singularName":"role","pluralName":"roles","displayName":"Role"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":3,"required":true,"configurable":false},"description":{"type":"string","configurable":false},"type":{"type":"string","unique":true,"configurable":false},"permissions":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.permission","mappedBy":"role","configurable":false},"users":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.user","mappedBy":"role","configurable":false}},"kind":"collectionType"},"modelName":"role","options":{"draftAndPublish":false}},"plugin::users-permissions.user":{"collectionName":"up_users","info":{"name":"user","description":"","singularName":"user","pluralName":"users","displayName":"User"},"options":{"timestamps":true,"draftAndPublish":false},"attributes":{"username":{"type":"string","minLength":3,"unique":true,"configurable":false,"required":true},"email":{"type":"email","minLength":6,"configurable":false,"required":true},"provider":{"type":"string","configurable":false},"password":{"type":"password","minLength":6,"configurable":false,"private":true,"searchable":false},"resetPasswordToken":{"type":"string","configurable":false,"private":true,"searchable":false},"confirmationToken":{"type":"string","configurable":false,"private":true,"searchable":false},"confirmed":{"type":"boolean","default":false,"configurable":false},"blocked":{"type":"boolean","default":false,"configurable":false},"role":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.role","inversedBy":"users","configurable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.user","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"up_users"}}},"config":{"attributes":{"resetPasswordToken":{"hidden":true},"confirmationToken":{"hidden":true},"provider":{"hidden":true}}},"plugin":"users-permissions","globalId":"UsersPermissionsUser","uid":"plugin::users-permissions.user","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"up_users","info":{"name":"user","description":"","singularName":"user","pluralName":"users","displayName":"User"},"options":{"timestamps":true},"attributes":{"username":{"type":"string","minLength":3,"unique":true,"configurable":false,"required":true},"email":{"type":"email","minLength":6,"configurable":false,"required":true},"provider":{"type":"string","configurable":false},"password":{"type":"password","minLength":6,"configurable":false,"private":true,"searchable":false},"resetPasswordToken":{"type":"string","configurable":false,"private":true,"searchable":false},"confirmationToken":{"type":"string","configurable":false,"private":true,"searchable":false},"confirmed":{"type":"boolean","default":false,"configurable":false},"blocked":{"type":"boolean","default":false,"configurable":false},"role":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.role","inversedBy":"users","configurable":false}},"kind":"collectionType"},"modelName":"user"},"api::bid.bid":{"kind":"collectionType","collectionName":"bids","info":{"singularName":"bid","pluralName":"bids","displayName":"Bid","description":""},"options":{"draftAndPublish":true},"pluginOptions":{},"attributes":{"Amount":{"type":"decimal","required":true},"biduser":{"type":"relation","relation":"manyToOne","target":"api::biduser.biduser","inversedBy":"bids"},"product":{"type":"relation","relation":"manyToOne","target":"api::product.product","inversedBy":"bids"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::bid.bid","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"bids"}}},"apiName":"bid","globalId":"Bid","uid":"api::bid.bid","modelType":"contentType","__schema__":{"collectionName":"bids","info":{"singularName":"bid","pluralName":"bids","displayName":"Bid","description":""},"options":{"draftAndPublish":true},"pluginOptions":{},"attributes":{"Amount":{"type":"decimal","required":true},"biduser":{"type":"relation","relation":"manyToOne","target":"api::biduser.biduser","inversedBy":"bids"},"product":{"type":"relation","relation":"manyToOne","target":"api::product.product","inversedBy":"bids"}},"kind":"collectionType"},"modelName":"bid","actions":{},"lifecycles":{}},"api::biduser.biduser":{"kind":"collectionType","collectionName":"bidusers","info":{"singularName":"biduser","pluralName":"bidusers","displayName":"biduser","description":""},"options":{"draftAndPublish":true},"pluginOptions":{},"attributes":{"email":{"type":"email","required":true,"unique":true},"Name":{"type":"string"},"bids":{"type":"relation","relation":"oneToMany","target":"api::bid.bid","mappedBy":"biduser"},"active":{"type":"boolean","default":true},"favourites":{"type":"relation","relation":"oneToMany","target":"api::product.product","mappedBy":"biduser"},"lottery_users":{"type":"relation","relation":"oneToMany","target":"api::lottery-user.lottery-user","mappedBy":"biduser"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::biduser.biduser","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"bidusers"}}},"apiName":"biduser","globalId":"Biduser","uid":"api::biduser.biduser","modelType":"contentType","__schema__":{"collectionName":"bidusers","info":{"singularName":"biduser","pluralName":"bidusers","displayName":"biduser","description":""},"options":{"draftAndPublish":true},"pluginOptions":{},"attributes":{"email":{"type":"email","required":true,"unique":true},"Name":{"type":"string"},"bids":{"type":"relation","relation":"oneToMany","target":"api::bid.bid","mappedBy":"biduser"},"active":{"type":"boolean","default":true},"favourites":{"type":"relation","relation":"oneToMany","target":"api::product.product","mappedBy":"biduser"},"lottery_users":{"type":"relation","relation":"oneToMany","target":"api::lottery-user.lottery-user","mappedBy":"biduser"}},"kind":"collectionType"},"modelName":"biduser","actions":{},"lifecycles":{}},"api::category.category":{"kind":"collectionType","collectionName":"categories","info":{"singularName":"category","pluralName":"categories","displayName":"Category","description":""},"options":{"draftAndPublish":true},"pluginOptions":{},"attributes":{"category_name":{"type":"string"},"slug":{"type":"uid","targetField":"category_name"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::category.category","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"categories"}}},"apiName":"category","globalId":"Category","uid":"api::category.category","modelType":"contentType","__schema__":{"collectionName":"categories","info":{"singularName":"category","pluralName":"categories","displayName":"Category","description":""},"options":{"draftAndPublish":true},"pluginOptions":{},"attributes":{"category_name":{"type":"string"},"slug":{"type":"uid","targetField":"category_name"}},"kind":"collectionType"},"modelName":"category","actions":{},"lifecycles":{}},"api::lottery-user.lottery-user":{"kind":"collectionType","collectionName":"lottery_users","info":{"singularName":"lottery-user","pluralName":"lottery-users","displayName":"Lottery Users","description":""},"options":{"draftAndPublish":true},"pluginOptions":{},"attributes":{"biduser":{"type":"relation","relation":"manyToOne","target":"api::biduser.biduser","inversedBy":"lottery_users"},"products":{"type":"relation","relation":"manyToMany","target":"api::product.product","inversedBy":"lottery_users"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::lottery-user.lottery-user","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"lottery_users"}}},"apiName":"lottery-user","globalId":"LotteryUser","uid":"api::lottery-user.lottery-user","modelType":"contentType","__schema__":{"collectionName":"lottery_users","info":{"singularName":"lottery-user","pluralName":"lottery-users","displayName":"Lottery Users","description":""},"options":{"draftAndPublish":true},"pluginOptions":{},"attributes":{"biduser":{"type":"relation","relation":"manyToOne","target":"api::biduser.biduser","inversedBy":"lottery_users"},"products":{"type":"relation","relation":"manyToMany","target":"api::product.product","inversedBy":"lottery_users"}},"kind":"collectionType"},"modelName":"lottery-user","actions":{},"lifecycles":{}},"api::product.product":{"kind":"collectionType","collectionName":"products","info":{"singularName":"product","pluralName":"products","displayName":"Product","description":""},"options":{"draftAndPublish":true},"pluginOptions":{},"attributes":{"title":{"type":"string","required":true},"description":{"type":"text"},"categories":{"type":"relation","relation":"oneToMany","target":"api::category.category"},"main_picture":{"type":"media","multiple":false,"required":false,"allowedTypes":["images","files"]},"gallery":{"type":"media","multiple":true,"required":false,"allowedTypes":["images","files"]},"price":{"type":"decimal"},"ending_date":{"type":"datetime"},"bids":{"type":"relation","relation":"oneToMany","target":"api::bid.bid","mappedBy":"product"},"biduser":{"type":"relation","relation":"manyToOne","target":"api::biduser.biduser","inversedBy":"favourites"},"lottery_product":{"type":"boolean","default":false},"lottery_users":{"type":"relation","relation":"manyToMany","target":"api::lottery-user.lottery-user","mappedBy":"products"},"lottery_winner":{"type":"string"},"manual_lottery":{"type":"boolean","default":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::product.product","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"products"}}},"apiName":"product","globalId":"Product","uid":"api::product.product","modelType":"contentType","__schema__":{"collectionName":"products","info":{"singularName":"product","pluralName":"products","displayName":"Product","description":""},"options":{"draftAndPublish":true},"pluginOptions":{},"attributes":{"title":{"type":"string","required":true},"description":{"type":"text"},"categories":{"type":"relation","relation":"oneToMany","target":"api::category.category"},"main_picture":{"type":"media","multiple":false,"required":false,"allowedTypes":["images","files"]},"gallery":{"type":"media","multiple":true,"required":false,"allowedTypes":["images","files"]},"price":{"type":"decimal"},"ending_date":{"type":"datetime"},"bids":{"type":"relation","relation":"oneToMany","target":"api::bid.bid","mappedBy":"product"},"biduser":{"type":"relation","relation":"manyToOne","target":"api::biduser.biduser","inversedBy":"favourites"},"lottery_product":{"type":"boolean","default":false},"lottery_users":{"type":"relation","relation":"manyToMany","target":"api::lottery-user.lottery-user","mappedBy":"products"},"lottery_winner":{"type":"string"},"manual_lottery":{"type":"boolean","default":false}},"kind":"collectionType"},"modelName":"product","actions":{},"lifecycles":{}},"admin::permission":{"collectionName":"admin_permissions","info":{"name":"Permission","description":"","singularName":"permission","pluralName":"permissions","displayName":"Permission"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"actionParameters":{"type":"json","configurable":false,"required":false,"default":{}},"subject":{"type":"string","minLength":1,"configurable":false,"required":false},"properties":{"type":"json","configurable":false,"required":false,"default":{}},"conditions":{"type":"json","configurable":false,"required":false,"default":[]},"role":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::role"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"admin::permission","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"admin_permissions"}}},"plugin":"admin","globalId":"AdminPermission","uid":"admin::permission","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"admin_permissions","info":{"name":"Permission","description":"","singularName":"permission","pluralName":"permissions","displayName":"Permission"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"actionParameters":{"type":"json","configurable":false,"required":false,"default":{}},"subject":{"type":"string","minLength":1,"configurable":false,"required":false},"properties":{"type":"json","configurable":false,"required":false,"default":{}},"conditions":{"type":"json","configurable":false,"required":false,"default":[]},"role":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::role"}},"kind":"collectionType"},"modelName":"permission"},"admin::user":{"collectionName":"admin_users","info":{"name":"User","description":"","singularName":"user","pluralName":"users","displayName":"User"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"firstname":{"type":"string","unique":false,"minLength":1,"configurable":false,"required":false},"lastname":{"type":"string","unique":false,"minLength":1,"configurable":false,"required":false},"username":{"type":"string","unique":false,"configurable":false,"required":false},"email":{"type":"email","minLength":6,"configurable":false,"required":true,"unique":true,"private":true},"password":{"type":"password","minLength":6,"configurable":false,"required":false,"private":true,"searchable":false},"resetPasswordToken":{"type":"string","configurable":false,"private":true,"searchable":false},"registrationToken":{"type":"string","configurable":false,"private":true,"searchable":false},"isActive":{"type":"boolean","default":false,"configurable":false,"private":true},"roles":{"configurable":false,"private":true,"type":"relation","relation":"manyToMany","inversedBy":"users","target":"admin::role","collectionName":"strapi_users_roles"},"blocked":{"type":"boolean","default":false,"configurable":false,"private":true},"preferedLanguage":{"type":"string","configurable":false,"required":false,"searchable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"admin::user","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"admin_users"}}},"config":{"attributes":{"resetPasswordToken":{"hidden":true},"registrationToken":{"hidden":true}}},"plugin":"admin","globalId":"AdminUser","uid":"admin::user","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"admin_users","info":{"name":"User","description":"","singularName":"user","pluralName":"users","displayName":"User"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"firstname":{"type":"string","unique":false,"minLength":1,"configurable":false,"required":false},"lastname":{"type":"string","unique":false,"minLength":1,"configurable":false,"required":false},"username":{"type":"string","unique":false,"configurable":false,"required":false},"email":{"type":"email","minLength":6,"configurable":false,"required":true,"unique":true,"private":true},"password":{"type":"password","minLength":6,"configurable":false,"required":false,"private":true,"searchable":false},"resetPasswordToken":{"type":"string","configurable":false,"private":true,"searchable":false},"registrationToken":{"type":"string","configurable":false,"private":true,"searchable":false},"isActive":{"type":"boolean","default":false,"configurable":false,"private":true},"roles":{"configurable":false,"private":true,"type":"relation","relation":"manyToMany","inversedBy":"users","target":"admin::role","collectionName":"strapi_users_roles"},"blocked":{"type":"boolean","default":false,"configurable":false,"private":true},"preferedLanguage":{"type":"string","configurable":false,"required":false,"searchable":false}},"kind":"collectionType"},"modelName":"user","options":{"draftAndPublish":false}},"admin::role":{"collectionName":"admin_roles","info":{"name":"Role","description":"","singularName":"role","pluralName":"roles","displayName":"Role"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"unique":true,"configurable":false,"required":true},"code":{"type":"string","minLength":1,"unique":true,"configurable":false,"required":true},"description":{"type":"string","configurable":false},"users":{"configurable":false,"type":"relation","relation":"manyToMany","mappedBy":"roles","target":"admin::user"},"permissions":{"configurable":false,"type":"relation","relation":"oneToMany","mappedBy":"role","target":"admin::permission"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"admin::role","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"admin_roles"}}},"plugin":"admin","globalId":"AdminRole","uid":"admin::role","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"admin_roles","info":{"name":"Role","description":"","singularName":"role","pluralName":"roles","displayName":"Role"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"unique":true,"configurable":false,"required":true},"code":{"type":"string","minLength":1,"unique":true,"configurable":false,"required":true},"description":{"type":"string","configurable":false},"users":{"configurable":false,"type":"relation","relation":"manyToMany","mappedBy":"roles","target":"admin::user"},"permissions":{"configurable":false,"type":"relation","relation":"oneToMany","mappedBy":"role","target":"admin::permission"}},"kind":"collectionType"},"modelName":"role"},"admin::api-token":{"collectionName":"strapi_api_tokens","info":{"name":"Api Token","singularName":"api-token","pluralName":"api-tokens","displayName":"Api Token","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"configurable":false,"required":true,"unique":true},"description":{"type":"string","minLength":1,"configurable":false,"required":false,"default":""},"type":{"type":"enumeration","enum":["read-only","full-access","custom"],"configurable":false,"required":true,"default":"read-only"},"accessKey":{"type":"string","minLength":1,"configurable":false,"required":true,"searchable":false},"lastUsedAt":{"type":"datetime","configurable":false,"required":false},"permissions":{"type":"relation","target":"admin::api-token-permission","relation":"oneToMany","mappedBy":"token","configurable":false,"required":false},"expiresAt":{"type":"datetime","configurable":false,"required":false},"lifespan":{"type":"biginteger","configurable":false,"required":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"admin::api-token","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_api_tokens"}}},"plugin":"admin","globalId":"AdminApiToken","uid":"admin::api-token","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_api_tokens","info":{"name":"Api Token","singularName":"api-token","pluralName":"api-tokens","displayName":"Api Token","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"configurable":false,"required":true,"unique":true},"description":{"type":"string","minLength":1,"configurable":false,"required":false,"default":""},"type":{"type":"enumeration","enum":["read-only","full-access","custom"],"configurable":false,"required":true,"default":"read-only"},"accessKey":{"type":"string","minLength":1,"configurable":false,"required":true,"searchable":false},"lastUsedAt":{"type":"datetime","configurable":false,"required":false},"permissions":{"type":"relation","target":"admin::api-token-permission","relation":"oneToMany","mappedBy":"token","configurable":false,"required":false},"expiresAt":{"type":"datetime","configurable":false,"required":false},"lifespan":{"type":"biginteger","configurable":false,"required":false}},"kind":"collectionType"},"modelName":"api-token"},"admin::api-token-permission":{"collectionName":"strapi_api_token_permissions","info":{"name":"API Token Permission","description":"","singularName":"api-token-permission","pluralName":"api-token-permissions","displayName":"API Token Permission"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"token":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::api-token"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"admin::api-token-permission","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_api_token_permissions"}}},"plugin":"admin","globalId":"AdminApiTokenPermission","uid":"admin::api-token-permission","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_api_token_permissions","info":{"name":"API Token Permission","description":"","singularName":"api-token-permission","pluralName":"api-token-permissions","displayName":"API Token Permission"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"token":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::api-token"}},"kind":"collectionType"},"modelName":"api-token-permission"},"admin::transfer-token":{"collectionName":"strapi_transfer_tokens","info":{"name":"Transfer Token","singularName":"transfer-token","pluralName":"transfer-tokens","displayName":"Transfer Token","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"configurable":false,"required":true,"unique":true},"description":{"type":"string","minLength":1,"configurable":false,"required":false,"default":""},"accessKey":{"type":"string","minLength":1,"configurable":false,"required":true},"lastUsedAt":{"type":"datetime","configurable":false,"required":false},"permissions":{"type":"relation","target":"admin::transfer-token-permission","relation":"oneToMany","mappedBy":"token","configurable":false,"required":false},"expiresAt":{"type":"datetime","configurable":false,"required":false},"lifespan":{"type":"biginteger","configurable":false,"required":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"admin::transfer-token","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_transfer_tokens"}}},"plugin":"admin","globalId":"AdminTransferToken","uid":"admin::transfer-token","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_transfer_tokens","info":{"name":"Transfer Token","singularName":"transfer-token","pluralName":"transfer-tokens","displayName":"Transfer Token","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"configurable":false,"required":true,"unique":true},"description":{"type":"string","minLength":1,"configurable":false,"required":false,"default":""},"accessKey":{"type":"string","minLength":1,"configurable":false,"required":true},"lastUsedAt":{"type":"datetime","configurable":false,"required":false},"permissions":{"type":"relation","target":"admin::transfer-token-permission","relation":"oneToMany","mappedBy":"token","configurable":false,"required":false},"expiresAt":{"type":"datetime","configurable":false,"required":false},"lifespan":{"type":"biginteger","configurable":false,"required":false}},"kind":"collectionType"},"modelName":"transfer-token"},"admin::transfer-token-permission":{"collectionName":"strapi_transfer_token_permissions","info":{"name":"Transfer Token Permission","description":"","singularName":"transfer-token-permission","pluralName":"transfer-token-permissions","displayName":"Transfer Token Permission"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"token":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::transfer-token"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"admin::transfer-token-permission","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_transfer_token_permissions"}}},"plugin":"admin","globalId":"AdminTransferTokenPermission","uid":"admin::transfer-token-permission","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_transfer_token_permissions","info":{"name":"Transfer Token Permission","description":"","singularName":"transfer-token-permission","pluralName":"transfer-token-permissions","displayName":"Transfer Token Permission"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"token":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::transfer-token"}},"kind":"collectionType"},"modelName":"transfer-token-permission"}}	object	\N	\N
8	plugin_content_manager_configuration_content_types::plugin::users-permissions.permission	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"action","defaultSortBy":"action","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"action":{"edit":{"label":"action","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"action","searchable":true,"sortable":true}},"role":{"edit":{"label":"role","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"role","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","action","role","createdAt"],"edit":[[{"name":"action","size":6},{"name":"role","size":6}]]},"uid":"plugin::users-permissions.permission"}	object	\N	\N
13	plugin_content_manager_configuration_content_types::admin::permission	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"action","defaultSortBy":"action","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"action":{"edit":{"label":"action","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"action","searchable":true,"sortable":true}},"actionParameters":{"edit":{"label":"actionParameters","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"actionParameters","searchable":false,"sortable":false}},"subject":{"edit":{"label":"subject","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"subject","searchable":true,"sortable":true}},"properties":{"edit":{"label":"properties","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"properties","searchable":false,"sortable":false}},"conditions":{"edit":{"label":"conditions","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"conditions","searchable":false,"sortable":false}},"role":{"edit":{"label":"role","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"role","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","action","subject","role"],"edit":[[{"name":"action","size":6}],[{"name":"actionParameters","size":12}],[{"name":"subject","size":6}],[{"name":"properties","size":12}],[{"name":"conditions","size":12}],[{"name":"role","size":6}]]},"uid":"admin::permission"}	object	\N	\N
14	plugin_content_manager_configuration_content_types::admin::user	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"firstname","defaultSortBy":"firstname","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"firstname":{"edit":{"label":"firstname","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"firstname","searchable":true,"sortable":true}},"lastname":{"edit":{"label":"lastname","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lastname","searchable":true,"sortable":true}},"username":{"edit":{"label":"username","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"username","searchable":true,"sortable":true}},"email":{"edit":{"label":"email","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"email","searchable":true,"sortable":true}},"password":{"edit":{"label":"password","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"password","searchable":true,"sortable":true}},"resetPasswordToken":{"edit":{"label":"resetPasswordToken","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"resetPasswordToken","searchable":true,"sortable":true}},"registrationToken":{"edit":{"label":"registrationToken","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"registrationToken","searchable":true,"sortable":true}},"isActive":{"edit":{"label":"isActive","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"isActive","searchable":true,"sortable":true}},"roles":{"edit":{"label":"roles","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"roles","searchable":false,"sortable":false}},"blocked":{"edit":{"label":"blocked","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"blocked","searchable":true,"sortable":true}},"preferedLanguage":{"edit":{"label":"preferedLanguage","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"preferedLanguage","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","firstname","lastname","username"],"edit":[[{"name":"firstname","size":6},{"name":"lastname","size":6}],[{"name":"username","size":6},{"name":"email","size":6}],[{"name":"password","size":6},{"name":"isActive","size":4}],[{"name":"roles","size":6},{"name":"blocked","size":4}],[{"name":"preferedLanguage","size":6}]]},"uid":"admin::user"}	object	\N	\N
17	plugin_content_manager_configuration_content_types::admin::api-token-permission	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"action","defaultSortBy":"action","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"action":{"edit":{"label":"action","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"action","searchable":true,"sortable":true}},"token":{"edit":{"label":"token","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"token","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","action","token","createdAt"],"edit":[[{"name":"action","size":6},{"name":"token","size":6}]]},"uid":"admin::api-token-permission"}	object	\N	\N
29	core_admin_auth	{"providers":{"autoRegister":false,"defaultRole":null,"ssoLockedRoles":null}}	object	\N	\N
15	plugin_content_manager_configuration_content_types::plugin::content-releases.release-action	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"contentType","defaultSortBy":"contentType","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"type":{"edit":{"label":"type","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"type","searchable":true,"sortable":true}},"contentType":{"edit":{"label":"contentType","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"contentType","searchable":true,"sortable":true}},"entryDocumentId":{"edit":{"label":"entryDocumentId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"entryDocumentId","searchable":true,"sortable":true}},"release":{"edit":{"label":"release","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"release","searchable":true,"sortable":true}},"isEntryValid":{"edit":{"label":"isEntryValid","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"isEntryValid","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","type","contentType","entryDocumentId"],"edit":[[{"name":"type","size":6},{"name":"contentType","size":6}],[{"name":"entryDocumentId","size":6},{"name":"release","size":6}],[{"name":"isEntryValid","size":4}]]},"uid":"plugin::content-releases.release-action"}	object	\N	\N
19	plugin_content_manager_configuration_content_types::admin::transfer-token	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"accessKey":{"edit":{"label":"accessKey","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"accessKey","searchable":true,"sortable":true}},"lastUsedAt":{"edit":{"label":"lastUsedAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lastUsedAt","searchable":true,"sortable":true}},"permissions":{"edit":{"label":"permissions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"action"},"list":{"label":"permissions","searchable":false,"sortable":false}},"expiresAt":{"edit":{"label":"expiresAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"expiresAt","searchable":true,"sortable":true}},"lifespan":{"edit":{"label":"lifespan","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lifespan","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","description","accessKey"],"edit":[[{"name":"name","size":6},{"name":"description","size":6}],[{"name":"accessKey","size":6},{"name":"lastUsedAt","size":6}],[{"name":"permissions","size":6},{"name":"expiresAt","size":6}],[{"name":"lifespan","size":4}]]},"uid":"admin::transfer-token"}	object	\N	\N
18	plugin_content_manager_configuration_content_types::admin::api-token	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"type":{"edit":{"label":"type","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"type","searchable":true,"sortable":true}},"accessKey":{"edit":{"label":"accessKey","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"accessKey","searchable":true,"sortable":true}},"lastUsedAt":{"edit":{"label":"lastUsedAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lastUsedAt","searchable":true,"sortable":true}},"permissions":{"edit":{"label":"permissions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"action"},"list":{"label":"permissions","searchable":false,"sortable":false}},"expiresAt":{"edit":{"label":"expiresAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"expiresAt","searchable":true,"sortable":true}},"lifespan":{"edit":{"label":"lifespan","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lifespan","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","description","type"],"edit":[[{"name":"name","size":6},{"name":"description","size":6}],[{"name":"type","size":6},{"name":"accessKey","size":6}],[{"name":"lastUsedAt","size":6},{"name":"permissions","size":6}],[{"name":"expiresAt","size":6},{"name":"lifespan","size":4}]]},"uid":"admin::api-token"}	object	\N	\N
20	plugin_content_manager_configuration_content_types::admin::role	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"code":{"edit":{"label":"code","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"code","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"users":{"edit":{"label":"users","description":"","placeholder":"","visible":true,"editable":true,"mainField":"firstname"},"list":{"label":"users","searchable":false,"sortable":false}},"permissions":{"edit":{"label":"permissions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"action"},"list":{"label":"permissions","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","code","description"],"edit":[[{"name":"name","size":6},{"name":"code","size":6}],[{"name":"description","size":6},{"name":"users","size":6}],[{"name":"permissions","size":6}]]},"uid":"admin::role"}	object	\N	\N
22	plugin_upload_settings	{"sizeOptimization":true,"responsiveDimensions":false,"autoOrientation":false}	object	\N	\N
16	plugin_content_manager_configuration_content_types::api::product.product	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":20,"mainField":"title","defaultSortBy":"id","defaultSortOrder":"DESC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"title":{"edit":{"label":"title","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"title","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"categories":{"edit":{"label":"categories","description":"","placeholder":"","visible":true,"editable":true,"mainField":"category_name"},"list":{"label":"categories","searchable":false,"sortable":false}},"main_picture":{"edit":{"label":"main_picture","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"main_picture","searchable":false,"sortable":false}},"gallery":{"edit":{"label":"gallery","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"gallery","searchable":false,"sortable":false}},"price":{"edit":{"label":"price","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"price","searchable":true,"sortable":true}},"ending_date":{"edit":{"label":"ending_date","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"ending_date","searchable":true,"sortable":true}},"bids":{"edit":{"label":"bids","description":"","placeholder":"","visible":true,"editable":false,"mainField":"id"},"list":{"label":"bids","searchable":false,"sortable":false}},"biduser":{"edit":{"label":"biduser","description":"","placeholder":"","visible":true,"editable":false,"mainField":"Name"},"list":{"label":"biduser","searchable":true,"sortable":true}},"lottery_product":{"edit":{"label":"lottery_product","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lottery_product","searchable":true,"sortable":true}},"lottery_users":{"edit":{"label":"lottery_users","description":"","placeholder":"","visible":true,"editable":false,"mainField":"id"},"list":{"label":"lottery_users","searchable":false,"sortable":false}},"lottery_winner":{"edit":{"label":"lottery_winner","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lottery_winner","searchable":true,"sortable":true}},"manual_lottery":{"edit":{"label":"manual_lottery","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"manual_lottery","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"edit":[[{"name":"title","size":12}],[{"name":"description","size":12}],[{"name":"categories","size":8}],[{"name":"price","size":8}],[{"name":"main_picture","size":8}],[{"name":"gallery","size":8}],[{"name":"ending_date","size":8}],[{"name":"lottery_product","size":12}],[{"name":"manual_lottery","size":12}],[{"name":"bids","size":12}],[{"name":"biduser","size":12},{"name":"lottery_users","size":6}],[{"name":"lottery_winner","size":6}]],"list":["id","title","categories","lottery_product","manual_lottery","lottery_winner","ending_date","lottery_users"]},"uid":"api::product.product"}	object	\N	\N
23	plugin_upload_view_configuration	{"pageSize":50,"sort":"createdAt:DESC"}	object	\N	\N
24	plugin_upload_metrics	{"weeklySchedule":"21 35 9 * * 2","lastWeeklyUpdate":1738658121062}	object	\N	\N
21	plugin_content_manager_configuration_content_types::admin::transfer-token-permission	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"action","defaultSortBy":"action","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"action":{"edit":{"label":"action","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"action","searchable":true,"sortable":true}},"token":{"edit":{"label":"token","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"token","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","action","token","createdAt"],"edit":[[{"name":"action","size":6},{"name":"token","size":6}]]},"uid":"admin::transfer-token-permission"}	object	\N	\N
25	plugin_i18n_default_locale	"en"	string	\N	\N
26	plugin_users-permissions_grant	{"email":{"icon":"envelope","enabled":true},"discord":{"icon":"discord","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/discord/callback","scope":["identify","email"]},"facebook":{"icon":"facebook-square","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/facebook/callback","scope":["email"]},"google":{"icon":"google","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/google/callback","scope":["email"]},"github":{"icon":"github","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/github/callback","scope":["user","user:email"]},"microsoft":{"icon":"windows","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/microsoft/callback","scope":["user.read"]},"twitter":{"icon":"twitter","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/twitter/callback"},"instagram":{"icon":"instagram","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/instagram/callback","scope":["user_profile"]},"vk":{"icon":"vk","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/vk/callback","scope":["email"]},"twitch":{"icon":"twitch","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/twitch/callback","scope":["user:read:email"]},"linkedin":{"icon":"linkedin","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/linkedin/callback","scope":["r_liteprofile","r_emailaddress"]},"cognito":{"icon":"aws","enabled":false,"key":"","secret":"","subdomain":"my.subdomain.com","callback":"api/auth/cognito/callback","scope":["email","openid","profile"]},"reddit":{"icon":"reddit","enabled":false,"key":"","secret":"","callback":"api/auth/reddit/callback","scope":["identity"]},"auth0":{"icon":"","enabled":false,"key":"","secret":"","subdomain":"my-tenant.eu","callback":"api/auth/auth0/callback","scope":["openid","email","profile"]},"cas":{"icon":"book","enabled":false,"key":"","secret":"","callback":"api/auth/cas/callback","scope":["openid email"],"subdomain":"my.subdomain.com/cas"},"patreon":{"icon":"","enabled":false,"key":"","secret":"","callback":"api/auth/patreon/callback","scope":["identity","identity[email]"]},"keycloak":{"icon":"","enabled":false,"key":"","secret":"","subdomain":"myKeycloakProvider.com/realms/myrealm","callback":"api/auth/keycloak/callback","scope":["openid","email","profile"]}}	object	\N	\N
27	plugin_users-permissions_email	{"reset_password":{"display":"Email.template.reset_password","icon":"sync","options":{"from":{"name":"Administration Panel","email":"no-reply@strapi.io"},"response_email":"","object":"Reset password","message":"<p>We heard that you lost your password. Sorry about that!</p>\\n\\n<p>But don’t worry! You can use the following link to reset your password:</p>\\n<p><%= URL %>?code=<%= TOKEN %></p>\\n\\n<p>Thanks.</p>"}},"email_confirmation":{"display":"Email.template.email_confirmation","icon":"check-square","options":{"from":{"name":"Administration Panel","email":"no-reply@strapi.io"},"response_email":"","object":"Account confirmation","message":"<p>Thank you for registering!</p>\\n\\n<p>You have to confirm your email address. Please click on the link below.</p>\\n\\n<p><%= URL %>?confirmation=<%= CODE %></p>\\n\\n<p>Thanks.</p>"}}}	object	\N	\N
28	plugin_users-permissions_advanced	{"unique_email":true,"allow_register":true,"email_confirmation":false,"email_reset_password":null,"email_confirmation_redirection":null,"default_role":"authenticated"}	object	\N	\N
30	plugin_content_manager_configuration_content_types::api::bid.bid	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"id","defaultSortBy":"id","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"Amount":{"edit":{"label":"Amount","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Amount","searchable":true,"sortable":true}},"biduser":{"edit":{"label":"biduser","description":"","placeholder":"","visible":true,"editable":true,"mainField":"Name"},"list":{"label":"biduser","searchable":true,"sortable":true}},"product":{"edit":{"label":"product","description":"","placeholder":"","visible":true,"editable":true,"mainField":"title"},"list":{"label":"product","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","Amount","biduser","product"],"edit":[[{"name":"Amount","size":4},{"name":"biduser","size":6}],[{"name":"product","size":6}]]},"uid":"api::bid.bid"}	object	\N	\N
11	plugin_content_manager_configuration_content_types::api::biduser.biduser	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":20,"mainField":"Name","defaultSortBy":"Name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"email":{"edit":{"label":"email","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"email","searchable":true,"sortable":true}},"Name":{"edit":{"label":"Name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Name","searchable":true,"sortable":true}},"bids":{"edit":{"label":"bids","description":"","placeholder":"","visible":true,"editable":true,"mainField":"id"},"list":{"label":"bids","searchable":false,"sortable":false}},"active":{"edit":{"label":"active","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"active","searchable":true,"sortable":true}},"favourites":{"edit":{"label":"favourites","description":"","placeholder":"","visible":true,"editable":true,"mainField":"title"},"list":{"label":"favourites","searchable":false,"sortable":false}},"lottery_users":{"edit":{"label":"lottery_users","description":"","placeholder":"","visible":true,"editable":true,"mainField":"id"},"list":{"label":"lottery_users","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"edit":[[{"name":"Name","size":6},{"name":"email","size":6}],[{"name":"active","size":6}],[{"name":"favourites","size":6}],[{"name":"bids","size":6},{"name":"lottery_users","size":6}]],"list":["id","email","Name","createdAt","lottery_users","bids"]},"uid":"api::biduser.biduser"}	object	\N	\N
32	plugin_content_manager_configuration_content_types::api::lottery-user.lottery-user	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"id","defaultSortBy":"id","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"biduser":{"edit":{"label":"biduser","description":"","placeholder":"","visible":true,"editable":true,"mainField":"Name"},"list":{"label":"biduser","searchable":true,"sortable":true}},"products":{"edit":{"label":"products","description":"","placeholder":"","visible":true,"editable":true,"mainField":"id"},"list":{"label":"products","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","biduser","products"],"edit":[[{"name":"biduser","size":6}],[{"name":"products","size":6}]]},"uid":"api::lottery-user.lottery-user"}	object	\N	\N
12	plugin_content_manager_configuration_content_types::api::category.category	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"category_name","defaultSortBy":"category_name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"category_name":{"edit":{"label":"category_name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"category_name","searchable":true,"sortable":true}},"slug":{"edit":{"label":"slug","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"slug","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"edit":[[{"name":"category_name","size":6},{"name":"slug","size":6}]],"list":["id","category_name","slug","createdAt","updatedAt"]},"uid":"api::category.category"}	object	\N	\N
\.


--
-- Data for Name: strapi_database_schema; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.strapi_database_schema (id, schema, "time", hash) FROM stdin;
38	{"tables":[{"name":"files","indexes":[{"name":"upload_files_folder_path_index","columns":["folder_path"],"type":null},{"name":"upload_files_created_at_index","columns":["created_at"],"type":null},{"name":"upload_files_updated_at_index","columns":["updated_at"],"type":null},{"name":"upload_files_name_index","columns":["name"],"type":null},{"name":"upload_files_size_index","columns":["size"],"type":null},{"name":"upload_files_ext_index","columns":["ext"],"type":null},{"name":"files_documents_idx","columns":["document_id","locale","published_at"]},{"name":"files_created_by_id_fk","columns":["created_by_id"]},{"name":"files_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"files_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"files_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"alternative_text","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"caption","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"width","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"height","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"formats","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"hash","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"ext","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"mime","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"size","type":"decimal","args":[10,2],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"url","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"preview_url","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"provider","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"provider_metadata","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"folder_path","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"upload_folders","indexes":[{"name":"upload_folders_path_id_index","columns":["path_id"],"type":"unique"},{"name":"upload_folders_path_index","columns":["path"],"type":"unique"},{"name":"upload_folders_documents_idx","columns":["document_id","locale","published_at"]},{"name":"upload_folders_created_by_id_fk","columns":["created_by_id"]},{"name":"upload_folders_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"upload_folders_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"upload_folders_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"path_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"path","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"i18n_locale","indexes":[{"name":"i18n_locale_documents_idx","columns":["document_id","locale","published_at"]},{"name":"i18n_locale_created_by_id_fk","columns":["created_by_id"]},{"name":"i18n_locale_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"i18n_locale_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"i18n_locale_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"code","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_releases","indexes":[{"name":"strapi_releases_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_releases_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_releases_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_releases_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_releases_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"released_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"scheduled_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"timezone","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"status","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_release_actions","indexes":[{"name":"strapi_release_actions_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_release_actions_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_release_actions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_release_actions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_release_actions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"content_type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"entry_document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"is_entry_valid","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_workflows","indexes":[{"name":"strapi_workflows_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_workflows_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_workflows_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_workflows_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_workflows_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"content_types","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_workflows_stages","indexes":[{"name":"strapi_workflows_stages_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_workflows_stages_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_workflows_stages_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_workflows_stages_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_workflows_stages_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"color","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"up_permissions","indexes":[{"name":"up_permissions_documents_idx","columns":["document_id","locale","published_at"]},{"name":"up_permissions_created_by_id_fk","columns":["created_by_id"]},{"name":"up_permissions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"up_permissions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"up_permissions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"action","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"up_roles","indexes":[{"name":"up_roles_documents_idx","columns":["document_id","locale","published_at"]},{"name":"up_roles_created_by_id_fk","columns":["created_by_id"]},{"name":"up_roles_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"up_roles_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"up_roles_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"up_users","indexes":[{"name":"up_users_documents_idx","columns":["document_id","locale","published_at"]},{"name":"up_users_created_by_id_fk","columns":["created_by_id"]},{"name":"up_users_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"up_users_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"up_users_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"username","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"email","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"provider","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"password","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"reset_password_token","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"confirmation_token","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"confirmed","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"blocked","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"bids","indexes":[{"name":"bids_documents_idx","columns":["document_id","locale","published_at"]},{"name":"bids_created_by_id_fk","columns":["created_by_id"]},{"name":"bids_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"bids_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"bids_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"amount","type":"decimal","args":[10,2],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"bidusers","indexes":[{"name":"bidusers_documents_idx","columns":["document_id","locale","published_at"]},{"name":"bidusers_created_by_id_fk","columns":["created_by_id"]},{"name":"bidusers_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"bidusers_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"bidusers_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"email","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"active","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"categories","indexes":[{"name":"categories_documents_idx","columns":["document_id","locale","published_at"]},{"name":"categories_created_by_id_fk","columns":["created_by_id"]},{"name":"categories_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"categories_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"categories_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"category_name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"slug","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"lottery_users","indexes":[{"name":"lottery_users_documents_idx","columns":["document_id","locale","published_at"]},{"name":"lottery_users_created_by_id_fk","columns":["created_by_id"]},{"name":"lottery_users_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"lottery_users_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"lottery_users_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"products","indexes":[{"name":"products_documents_idx","columns":["document_id","locale","published_at"]},{"name":"products_created_by_id_fk","columns":["created_by_id"]},{"name":"products_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"products_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"products_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"title","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"price","type":"decimal","args":[10,2],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"ending_date","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"lottery_product","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"lottery_winner","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"manual_lottery","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"admin_permissions","indexes":[{"name":"admin_permissions_documents_idx","columns":["document_id","locale","published_at"]},{"name":"admin_permissions_created_by_id_fk","columns":["created_by_id"]},{"name":"admin_permissions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"admin_permissions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"admin_permissions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"action","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"action_parameters","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"subject","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"properties","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"conditions","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"admin_users","indexes":[{"name":"admin_users_documents_idx","columns":["document_id","locale","published_at"]},{"name":"admin_users_created_by_id_fk","columns":["created_by_id"]},{"name":"admin_users_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"admin_users_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"admin_users_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"firstname","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"lastname","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"username","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"email","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"password","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"reset_password_token","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"registration_token","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"is_active","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"blocked","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"prefered_language","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"admin_roles","indexes":[{"name":"admin_roles_documents_idx","columns":["document_id","locale","published_at"]},{"name":"admin_roles_created_by_id_fk","columns":["created_by_id"]},{"name":"admin_roles_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"admin_roles_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"admin_roles_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"code","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_api_tokens","indexes":[{"name":"strapi_api_tokens_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_api_tokens_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_api_tokens_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_api_tokens_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_api_tokens_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"access_key","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"last_used_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"expires_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"lifespan","type":"bigInteger","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_api_token_permissions","indexes":[{"name":"strapi_api_token_permissions_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_api_token_permissions_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_api_token_permissions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_api_token_permissions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_api_token_permissions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"action","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_transfer_tokens","indexes":[{"name":"strapi_transfer_tokens_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_transfer_tokens_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_transfer_tokens_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_transfer_tokens_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_transfer_tokens_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"access_key","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"last_used_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"expires_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"lifespan","type":"bigInteger","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_transfer_token_permissions","indexes":[{"name":"strapi_transfer_token_permissions_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_transfer_token_permissions_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_transfer_token_permissions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_transfer_token_permissions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_transfer_token_permissions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"action","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_core_store_settings","indexes":[],"foreignKeys":[],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"key","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"value","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"environment","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"tag","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_webhooks","indexes":[],"foreignKeys":[],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"url","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"headers","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"events","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"enabled","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_history_versions","indexes":[{"name":"strapi_history_versions_created_by_id_fk","columns":["created_by_id"]}],"foreignKeys":[{"name":"strapi_history_versions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"content_type","type":"string","args":[],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"related_document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"status","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"data","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"schema","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"files_related_mph","indexes":[{"name":"files_related_mph_fk","columns":["file_id"]},{"name":"files_related_mph_oidx","columns":["order"]},{"name":"files_related_mph_idix","columns":["related_id"]}],"foreignKeys":[{"name":"files_related_mph_fk","columns":["file_id"],"referencedColumns":["id"],"referencedTable":"files","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"file_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"related_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"related_type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"field","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"files_folder_lnk","indexes":[{"name":"files_folder_lnk_fk","columns":["file_id"]},{"name":"files_folder_lnk_ifk","columns":["folder_id"]},{"name":"files_folder_lnk_uq","columns":["file_id","folder_id"],"type":"unique"},{"name":"files_folder_lnk_oifk","columns":["file_ord"]}],"foreignKeys":[{"name":"files_folder_lnk_fk","columns":["file_id"],"referencedColumns":["id"],"referencedTable":"files","onDelete":"CASCADE"},{"name":"files_folder_lnk_ifk","columns":["folder_id"],"referencedColumns":["id"],"referencedTable":"upload_folders","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"file_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"folder_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"file_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"upload_folders_parent_lnk","indexes":[{"name":"upload_folders_parent_lnk_fk","columns":["folder_id"]},{"name":"upload_folders_parent_lnk_ifk","columns":["inv_folder_id"]},{"name":"upload_folders_parent_lnk_uq","columns":["folder_id","inv_folder_id"],"type":"unique"},{"name":"upload_folders_parent_lnk_oifk","columns":["folder_ord"]}],"foreignKeys":[{"name":"upload_folders_parent_lnk_fk","columns":["folder_id"],"referencedColumns":["id"],"referencedTable":"upload_folders","onDelete":"CASCADE"},{"name":"upload_folders_parent_lnk_ifk","columns":["inv_folder_id"],"referencedColumns":["id"],"referencedTable":"upload_folders","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"folder_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"inv_folder_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"folder_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_release_actions_release_lnk","indexes":[{"name":"strapi_release_actions_release_lnk_fk","columns":["release_action_id"]},{"name":"strapi_release_actions_release_lnk_ifk","columns":["release_id"]},{"name":"strapi_release_actions_release_lnk_uq","columns":["release_action_id","release_id"],"type":"unique"},{"name":"strapi_release_actions_release_lnk_oifk","columns":["release_action_ord"]}],"foreignKeys":[{"name":"strapi_release_actions_release_lnk_fk","columns":["release_action_id"],"referencedColumns":["id"],"referencedTable":"strapi_release_actions","onDelete":"CASCADE"},{"name":"strapi_release_actions_release_lnk_ifk","columns":["release_id"],"referencedColumns":["id"],"referencedTable":"strapi_releases","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"release_action_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"release_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"release_action_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_workflows_stage_required_to_publish_lnk","indexes":[{"name":"strapi_workflows_stage_required_to_publish_lnk_fk","columns":["workflow_id"]},{"name":"strapi_workflows_stage_required_to_publish_lnk_ifk","columns":["workflow_stage_id"]},{"name":"strapi_workflows_stage_required_to_publish_lnk_uq","columns":["workflow_id","workflow_stage_id"],"type":"unique"}],"foreignKeys":[{"name":"strapi_workflows_stage_required_to_publish_lnk_fk","columns":["workflow_id"],"referencedColumns":["id"],"referencedTable":"strapi_workflows","onDelete":"CASCADE"},{"name":"strapi_workflows_stage_required_to_publish_lnk_ifk","columns":["workflow_stage_id"],"referencedColumns":["id"],"referencedTable":"strapi_workflows_stages","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"workflow_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"workflow_stage_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_workflows_stages_workflow_lnk","indexes":[{"name":"strapi_workflows_stages_workflow_lnk_fk","columns":["workflow_stage_id"]},{"name":"strapi_workflows_stages_workflow_lnk_ifk","columns":["workflow_id"]},{"name":"strapi_workflows_stages_workflow_lnk_uq","columns":["workflow_stage_id","workflow_id"],"type":"unique"},{"name":"strapi_workflows_stages_workflow_lnk_oifk","columns":["workflow_stage_ord"]}],"foreignKeys":[{"name":"strapi_workflows_stages_workflow_lnk_fk","columns":["workflow_stage_id"],"referencedColumns":["id"],"referencedTable":"strapi_workflows_stages","onDelete":"CASCADE"},{"name":"strapi_workflows_stages_workflow_lnk_ifk","columns":["workflow_id"],"referencedColumns":["id"],"referencedTable":"strapi_workflows","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"workflow_stage_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"workflow_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"workflow_stage_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_workflows_stages_permissions_lnk","indexes":[{"name":"strapi_workflows_stages_permissions_lnk_fk","columns":["workflow_stage_id"]},{"name":"strapi_workflows_stages_permissions_lnk_ifk","columns":["permission_id"]},{"name":"strapi_workflows_stages_permissions_lnk_uq","columns":["workflow_stage_id","permission_id"],"type":"unique"},{"name":"strapi_workflows_stages_permissions_lnk_ofk","columns":["permission_ord"]}],"foreignKeys":[{"name":"strapi_workflows_stages_permissions_lnk_fk","columns":["workflow_stage_id"],"referencedColumns":["id"],"referencedTable":"strapi_workflows_stages","onDelete":"CASCADE"},{"name":"strapi_workflows_stages_permissions_lnk_ifk","columns":["permission_id"],"referencedColumns":["id"],"referencedTable":"admin_permissions","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"workflow_stage_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"permission_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"up_permissions_role_lnk","indexes":[{"name":"up_permissions_role_lnk_fk","columns":["permission_id"]},{"name":"up_permissions_role_lnk_ifk","columns":["role_id"]},{"name":"up_permissions_role_lnk_uq","columns":["permission_id","role_id"],"type":"unique"},{"name":"up_permissions_role_lnk_oifk","columns":["permission_ord"]}],"foreignKeys":[{"name":"up_permissions_role_lnk_fk","columns":["permission_id"],"referencedColumns":["id"],"referencedTable":"up_permissions","onDelete":"CASCADE"},{"name":"up_permissions_role_lnk_ifk","columns":["role_id"],"referencedColumns":["id"],"referencedTable":"up_roles","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"permission_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"up_users_role_lnk","indexes":[{"name":"up_users_role_lnk_fk","columns":["user_id"]},{"name":"up_users_role_lnk_ifk","columns":["role_id"]},{"name":"up_users_role_lnk_uq","columns":["user_id","role_id"],"type":"unique"},{"name":"up_users_role_lnk_oifk","columns":["user_ord"]}],"foreignKeys":[{"name":"up_users_role_lnk_fk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"up_users","onDelete":"CASCADE"},{"name":"up_users_role_lnk_ifk","columns":["role_id"],"referencedColumns":["id"],"referencedTable":"up_roles","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"bids_biduser_lnk","indexes":[{"name":"bids_biduser_lnk_fk","columns":["bid_id"]},{"name":"bids_biduser_lnk_ifk","columns":["biduser_id"]},{"name":"bids_biduser_lnk_uq","columns":["bid_id","biduser_id"],"type":"unique"},{"name":"bids_biduser_lnk_oifk","columns":["bid_ord"]}],"foreignKeys":[{"name":"bids_biduser_lnk_fk","columns":["bid_id"],"referencedColumns":["id"],"referencedTable":"bids","onDelete":"CASCADE"},{"name":"bids_biduser_lnk_ifk","columns":["biduser_id"],"referencedColumns":["id"],"referencedTable":"bidusers","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"bid_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"biduser_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"bid_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"bids_product_lnk","indexes":[{"name":"bids_product_lnk_fk","columns":["bid_id"]},{"name":"bids_product_lnk_ifk","columns":["product_id"]},{"name":"bids_product_lnk_uq","columns":["bid_id","product_id"],"type":"unique"},{"name":"bids_product_lnk_oifk","columns":["bid_ord"]}],"foreignKeys":[{"name":"bids_product_lnk_fk","columns":["bid_id"],"referencedColumns":["id"],"referencedTable":"bids","onDelete":"CASCADE"},{"name":"bids_product_lnk_ifk","columns":["product_id"],"referencedColumns":["id"],"referencedTable":"products","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"bid_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"product_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"bid_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"lottery_users_biduser_lnk","indexes":[{"name":"lottery_users_biduser_lnk_fk","columns":["lottery_user_id"]},{"name":"lottery_users_biduser_lnk_ifk","columns":["biduser_id"]},{"name":"lottery_users_biduser_lnk_uq","columns":["lottery_user_id","biduser_id"],"type":"unique"},{"name":"lottery_users_biduser_lnk_oifk","columns":["lottery_user_ord"]}],"foreignKeys":[{"name":"lottery_users_biduser_lnk_fk","columns":["lottery_user_id"],"referencedColumns":["id"],"referencedTable":"lottery_users","onDelete":"CASCADE"},{"name":"lottery_users_biduser_lnk_ifk","columns":["biduser_id"],"referencedColumns":["id"],"referencedTable":"bidusers","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"lottery_user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"biduser_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"lottery_user_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"lottery_users_products_lnk","indexes":[{"name":"lottery_users_products_lnk_fk","columns":["lottery_user_id"]},{"name":"lottery_users_products_lnk_ifk","columns":["product_id"]},{"name":"lottery_users_products_lnk_uq","columns":["lottery_user_id","product_id"],"type":"unique"},{"name":"lottery_users_products_lnk_ofk","columns":["product_ord"]},{"name":"lottery_users_products_lnk_oifk","columns":["lottery_user_ord"]}],"foreignKeys":[{"name":"lottery_users_products_lnk_fk","columns":["lottery_user_id"],"referencedColumns":["id"],"referencedTable":"lottery_users","onDelete":"CASCADE"},{"name":"lottery_users_products_lnk_ifk","columns":["product_id"],"referencedColumns":["id"],"referencedTable":"products","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"lottery_user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"product_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"product_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"lottery_user_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"products_categories_lnk","indexes":[{"name":"products_categories_lnk_fk","columns":["product_id"]},{"name":"products_categories_lnk_ifk","columns":["category_id"]},{"name":"products_categories_lnk_uq","columns":["product_id","category_id"],"type":"unique"},{"name":"products_categories_lnk_ofk","columns":["category_ord"]}],"foreignKeys":[{"name":"products_categories_lnk_fk","columns":["product_id"],"referencedColumns":["id"],"referencedTable":"products","onDelete":"CASCADE"},{"name":"products_categories_lnk_ifk","columns":["category_id"],"referencedColumns":["id"],"referencedTable":"categories","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"product_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"category_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"category_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"products_biduser_lnk","indexes":[{"name":"products_biduser_lnk_fk","columns":["product_id"]},{"name":"products_biduser_lnk_ifk","columns":["biduser_id"]},{"name":"products_biduser_lnk_uq","columns":["product_id","biduser_id"],"type":"unique"},{"name":"products_biduser_lnk_oifk","columns":["product_ord"]}],"foreignKeys":[{"name":"products_biduser_lnk_fk","columns":["product_id"],"referencedColumns":["id"],"referencedTable":"products","onDelete":"CASCADE"},{"name":"products_biduser_lnk_ifk","columns":["biduser_id"],"referencedColumns":["id"],"referencedTable":"bidusers","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"product_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"biduser_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"product_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"admin_permissions_role_lnk","indexes":[{"name":"admin_permissions_role_lnk_fk","columns":["permission_id"]},{"name":"admin_permissions_role_lnk_ifk","columns":["role_id"]},{"name":"admin_permissions_role_lnk_uq","columns":["permission_id","role_id"],"type":"unique"},{"name":"admin_permissions_role_lnk_oifk","columns":["permission_ord"]}],"foreignKeys":[{"name":"admin_permissions_role_lnk_fk","columns":["permission_id"],"referencedColumns":["id"],"referencedTable":"admin_permissions","onDelete":"CASCADE"},{"name":"admin_permissions_role_lnk_ifk","columns":["role_id"],"referencedColumns":["id"],"referencedTable":"admin_roles","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"permission_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"admin_users_roles_lnk","indexes":[{"name":"admin_users_roles_lnk_fk","columns":["user_id"]},{"name":"admin_users_roles_lnk_ifk","columns":["role_id"]},{"name":"admin_users_roles_lnk_uq","columns":["user_id","role_id"],"type":"unique"},{"name":"admin_users_roles_lnk_ofk","columns":["role_ord"]},{"name":"admin_users_roles_lnk_oifk","columns":["user_ord"]}],"foreignKeys":[{"name":"admin_users_roles_lnk_fk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"admin_users","onDelete":"CASCADE"},{"name":"admin_users_roles_lnk_ifk","columns":["role_id"],"referencedColumns":["id"],"referencedTable":"admin_roles","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_api_token_permissions_token_lnk","indexes":[{"name":"strapi_api_token_permissions_token_lnk_fk","columns":["api_token_permission_id"]},{"name":"strapi_api_token_permissions_token_lnk_ifk","columns":["api_token_id"]},{"name":"strapi_api_token_permissions_token_lnk_uq","columns":["api_token_permission_id","api_token_id"],"type":"unique"},{"name":"strapi_api_token_permissions_token_lnk_oifk","columns":["api_token_permission_ord"]}],"foreignKeys":[{"name":"strapi_api_token_permissions_token_lnk_fk","columns":["api_token_permission_id"],"referencedColumns":["id"],"referencedTable":"strapi_api_token_permissions","onDelete":"CASCADE"},{"name":"strapi_api_token_permissions_token_lnk_ifk","columns":["api_token_id"],"referencedColumns":["id"],"referencedTable":"strapi_api_tokens","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"api_token_permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"api_token_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"api_token_permission_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_transfer_token_permissions_token_lnk","indexes":[{"name":"strapi_transfer_token_permissions_token_lnk_fk","columns":["transfer_token_permission_id"]},{"name":"strapi_transfer_token_permissions_token_lnk_ifk","columns":["transfer_token_id"]},{"name":"strapi_transfer_token_permissions_token_lnk_uq","columns":["transfer_token_permission_id","transfer_token_id"],"type":"unique"},{"name":"strapi_transfer_token_permissions_token_lnk_oifk","columns":["transfer_token_permission_ord"]}],"foreignKeys":[{"name":"strapi_transfer_token_permissions_token_lnk_fk","columns":["transfer_token_permission_id"],"referencedColumns":["id"],"referencedTable":"strapi_transfer_token_permissions","onDelete":"CASCADE"},{"name":"strapi_transfer_token_permissions_token_lnk_ifk","columns":["transfer_token_id"],"referencedColumns":["id"],"referencedTable":"strapi_transfer_tokens","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"transfer_token_permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"transfer_token_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"transfer_token_permission_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]}]}	2025-01-08 15:21:38.228	a42b6b508b44b010200b066389f8c734
\.


--
-- Data for Name: strapi_history_versions; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.strapi_history_versions (id, content_type, related_document_id, locale, status, data, schema, created_at, created_by_id) FROM stdin;
\.


--
-- Data for Name: strapi_migrations; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.strapi_migrations (id, name, "time") FROM stdin;
\.


--
-- Data for Name: strapi_migrations_internal; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.strapi_migrations_internal (id, name, "time") FROM stdin;
1	5.0.0-rename-identifiers-longer-than-max-length	2024-11-21 13:00:38.458
2	5.0.0-02-created-document-id	2024-11-21 13:00:38.493
3	5.0.0-03-created-locale	2024-11-21 13:00:38.527
4	5.0.0-04-created-published-at	2024-11-21 13:00:38.557
5	5.0.0-05-drop-slug-fields-index	2024-11-21 13:00:38.589
6	core::5.0.0-discard-drafts	2024-11-21 13:00:38.62
\.


--
-- Data for Name: strapi_release_actions; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.strapi_release_actions (id, document_id, type, content_type, entry_document_id, locale, is_entry_valid, created_at, updated_at, published_at, created_by_id, updated_by_id) FROM stdin;
\.


--
-- Data for Name: strapi_release_actions_release_lnk; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.strapi_release_actions_release_lnk (id, release_action_id, release_id, release_action_ord) FROM stdin;
\.


--
-- Data for Name: strapi_releases; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.strapi_releases (id, document_id, name, released_at, scheduled_at, timezone, status, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: strapi_transfer_token_permissions; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.strapi_transfer_token_permissions (id, document_id, action, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: strapi_transfer_token_permissions_token_lnk; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.strapi_transfer_token_permissions_token_lnk (id, transfer_token_permission_id, transfer_token_id, transfer_token_permission_ord) FROM stdin;
\.


--
-- Data for Name: strapi_transfer_tokens; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.strapi_transfer_tokens (id, document_id, name, description, access_key, last_used_at, expires_at, lifespan, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: strapi_webhooks; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.strapi_webhooks (id, name, url, headers, events, enabled) FROM stdin;
\.


--
-- Data for Name: strapi_workflows; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.strapi_workflows (id, document_id, name, content_types, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: strapi_workflows_stage_required_to_publish_lnk; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.strapi_workflows_stage_required_to_publish_lnk (id, workflow_id, workflow_stage_id) FROM stdin;
\.


--
-- Data for Name: strapi_workflows_stages; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.strapi_workflows_stages (id, document_id, name, color, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: strapi_workflows_stages_permissions_lnk; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.strapi_workflows_stages_permissions_lnk (id, workflow_stage_id, permission_id, permission_ord) FROM stdin;
\.


--
-- Data for Name: strapi_workflows_stages_workflow_lnk; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.strapi_workflows_stages_workflow_lnk (id, workflow_stage_id, workflow_id, workflow_stage_ord) FROM stdin;
\.


--
-- Data for Name: up_permissions; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.up_permissions (id, document_id, action, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	z94eg90mdm8whnsajkbakael	plugin::users-permissions.user.me	2024-11-21 13:00:39.588	2024-11-21 13:00:39.588	2024-11-21 13:00:39.589	\N	\N	\N
2	ret8zgmi11gr7huiqj88lrn9	plugin::users-permissions.auth.changePassword	2024-11-21 13:00:39.588	2024-11-21 13:00:39.588	2024-11-21 13:00:39.589	\N	\N	\N
3	s87nifsgf19lmhhaw71wz0v5	plugin::users-permissions.auth.callback	2024-11-21 13:00:39.598	2024-11-21 13:00:39.598	2024-11-21 13:00:39.598	\N	\N	\N
4	jrmcdhnqrpeze3sbi2whcwby	plugin::users-permissions.auth.connect	2024-11-21 13:00:39.598	2024-11-21 13:00:39.598	2024-11-21 13:00:39.599	\N	\N	\N
5	gec1fc7ouolba2a2ypwkwpq7	plugin::users-permissions.auth.forgotPassword	2024-11-21 13:00:39.598	2024-11-21 13:00:39.598	2024-11-21 13:00:39.599	\N	\N	\N
6	ry8uq8jbti3e554b1p34jcfa	plugin::users-permissions.auth.resetPassword	2024-11-21 13:00:39.598	2024-11-21 13:00:39.598	2024-11-21 13:00:39.599	\N	\N	\N
8	yzqw3a0cuzzpewers0hrb219	plugin::users-permissions.auth.emailConfirmation	2024-11-21 13:00:39.598	2024-11-21 13:00:39.598	2024-11-21 13:00:39.599	\N	\N	\N
7	vn8gpywr338du9gx6kfu9e1b	plugin::users-permissions.auth.register	2024-11-21 13:00:39.598	2024-11-21 13:00:39.598	2024-11-21 13:00:39.599	\N	\N	\N
9	fomgwb2t5fhcx4yash7w85qq	plugin::users-permissions.auth.sendEmailConfirmation	2024-11-21 13:00:39.598	2024-11-21 13:00:39.598	2024-11-21 13:00:39.6	\N	\N	\N
10	zl564upm07z9e2pegi8vly4u	api::biduser.biduser.find	2024-11-21 13:52:40.59	2024-11-21 13:52:40.59	2024-11-21 13:52:40.591	\N	\N	\N
11	ovrtxf0wdulrmymxmowmv872	api::biduser.biduser.findOne	2024-11-21 13:52:40.59	2024-11-21 13:52:40.59	2024-11-21 13:52:40.591	\N	\N	\N
12	qza4vrf4531bc387npngn9v8	api::category.category.find	2024-11-21 13:52:40.59	2024-11-21 13:52:40.59	2024-11-21 13:52:40.591	\N	\N	\N
13	jwz8zmdsrwm8mjrzquzvjqhc	api::category.category.findOne	2024-11-21 13:52:40.59	2024-11-21 13:52:40.59	2024-11-21 13:52:40.591	\N	\N	\N
14	lzt4v18b0p16hhr0a1fhowzs	api::product.product.find	2024-11-21 13:52:40.59	2024-11-21 13:52:40.59	2024-11-21 13:52:40.592	\N	\N	\N
15	ylbikg3r2w0tak1xbsin7dfh	api::product.product.findOne	2024-11-21 13:52:40.59	2024-11-21 13:52:40.59	2024-11-21 13:52:40.592	\N	\N	\N
16	a8ujshl5bijih903as09dp32	plugin::upload.content-api.find	2024-11-21 13:52:40.59	2024-11-21 13:52:40.59	2024-11-21 13:52:40.592	\N	\N	\N
17	fm74uk8z8gd4nxq9tvm8rywx	plugin::upload.content-api.findOne	2024-11-21 13:52:40.59	2024-11-21 13:52:40.59	2024-11-21 13:52:40.592	\N	\N	\N
18	ye277krf3pvor9xbe6ugvhm1	api::bid.bid.find	2024-11-21 15:06:38.056	2024-11-21 15:06:38.056	2024-11-21 15:06:38.057	\N	\N	\N
19	wzpyj4a3u1a4b1j4kk3p91iv	api::bid.bid.findOne	2024-11-21 15:06:38.056	2024-11-21 15:06:38.056	2024-11-21 15:06:38.057	\N	\N	\N
20	se76mua1gvl1rg52ykonduex	api::biduser.biduser.create	2024-11-25 16:28:49.412	2024-11-25 16:28:49.412	2024-11-25 16:28:49.412	\N	\N	\N
21	ooj8lno9gf3oxgs1ur1abtlp	api::biduser.biduser.update	2024-11-25 16:28:49.412	2024-11-25 16:28:49.412	2024-11-25 16:28:49.413	\N	\N	\N
22	o8zawqmerutdykig88y4j0dg	api::bid.bid.create	2024-11-26 15:11:30.182	2024-11-26 15:11:30.182	2024-11-26 15:11:30.183	\N	\N	\N
23	nmr0j0mffqa9fdpqvjqhwlgi	api::bid.bid.update	2024-11-26 15:11:30.182	2024-11-26 15:11:30.182	2024-11-26 15:11:30.183	\N	\N	\N
29	cvemb8144gjnodbltmkwicxj	api::lottery-user.lottery-user.find	2024-12-09 11:41:04.941	2024-12-09 11:41:04.941	2024-12-09 11:41:04.941	\N	\N	\N
30	x48zrrj82v3qbulg1grnik53	api::lottery-user.lottery-user.findOne	2024-12-09 11:41:04.941	2024-12-09 11:41:04.941	2024-12-09 11:41:04.942	\N	\N	\N
31	j60vcou2wfqczcodjvaky0ey	api::lottery-user.lottery-user.create	2024-12-09 11:41:04.941	2024-12-09 11:41:04.941	2024-12-09 11:41:04.942	\N	\N	\N
32	tjffpsm977m1enkun4e00dr0	api::lottery-user.lottery-user.update	2024-12-09 11:41:04.941	2024-12-09 11:41:04.941	2024-12-09 11:41:04.942	\N	\N	\N
33	xdqo3kbpqaq10h9h5n6w2nyu	api::lottery-user.lottery-user.delete	2024-12-09 11:41:04.941	2024-12-09 11:41:04.941	2024-12-09 11:41:04.942	\N	\N	\N
34	a4v4toqgrgzvy3ybzyxr9m2d	api::product.product.update	2024-12-10 10:04:07.09	2024-12-10 10:04:07.09	2024-12-10 10:04:07.091	\N	\N	\N
35	wf9tdtvhgrkp3iolequ7j65e	api::product.product.delete	2024-12-10 10:04:07.09	2024-12-10 10:04:07.09	2024-12-10 10:04:07.092	\N	\N	\N
\.


--
-- Data for Name: up_permissions_role_lnk; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.up_permissions_role_lnk (id, permission_id, role_id, permission_ord) FROM stdin;
1	1	1	1
2	2	1	1
3	3	2	1
4	4	2	1
5	6	2	2
6	8	2	2
7	7	2	2
8	5	2	2
9	9	2	2
10	10	2	3
11	13	2	3
12	11	2	3
13	12	2	3
14	14	2	3
15	15	2	3
16	16	2	3
17	17	2	4
18	18	2	5
19	19	2	6
20	20	2	7
21	21	2	7
22	22	2	8
23	23	2	8
29	29	2	9
30	32	2	10
31	30	2	10
32	31	2	10
33	33	2	11
34	34	2	12
35	35	2	12
\.


--
-- Data for Name: up_roles; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.up_roles (id, document_id, name, description, type, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	lnieh5s7mbapwgqajdndbltq	Authenticated	Default role given to authenticated user.	authenticated	2024-11-21 13:00:39.579	2024-11-21 13:00:39.579	2024-11-21 13:00:39.579	\N	\N	\N
2	bzfb3yus5pl38o5ti6zd944i	Public	Default role given to unauthenticated user.	public	2024-11-21 13:00:39.583	2024-12-10 10:04:07.085	2024-11-21 13:00:39.583	\N	\N	\N
\.


--
-- Data for Name: up_users; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.up_users (id, document_id, username, email, provider, password, reset_password_token, confirmation_token, confirmed, blocked, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
2	kwadfywzoat8wrgr9yjbf291	ulf.floden@chasacademy.se	ulf.floden@chasacademy.se	local	$2a$10$R3le9JUPDa.9uBFDL0uPZuiqiq0uOOzF7hRyaSKZe6ZbqpjTFbi.a	\N	\N	t	t	2024-11-22 09:50:53.226	2024-11-22 13:49:12.489	2024-11-22 13:49:12.448	1	1	\N
\.


--
-- Data for Name: up_users_role_lnk; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.up_users_role_lnk (id, user_id, role_id, user_ord) FROM stdin;
2	2	1	1
\.


--
-- Data for Name: upload_folders; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.upload_folders (id, document_id, name, path_id, path, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: upload_folders_parent_lnk; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.upload_folders_parent_lnk (id, folder_id, inv_folder_id, folder_ord) FROM stdin;
\.


--
-- Name: admin_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.admin_permissions_id_seq', 247, true);


--
-- Name: admin_permissions_role_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.admin_permissions_role_lnk_id_seq', 247, true);


--
-- Name: admin_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.admin_roles_id_seq', 3, true);


--
-- Name: admin_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.admin_users_id_seq', 3, true);


--
-- Name: admin_users_roles_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.admin_users_roles_lnk_id_seq', 5, true);


--
-- Name: bids_biduser_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.bids_biduser_lnk_id_seq', 2806, true);


--
-- Name: bids_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.bids_id_seq', 120, true);


--
-- Name: bids_product_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.bids_product_lnk_id_seq', 346, true);


--
-- Name: bidusers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.bidusers_id_seq', 309, true);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.categories_id_seq', 14, true);


--
-- Name: files_folder_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.files_folder_lnk_id_seq', 1, false);


--
-- Name: files_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.files_id_seq', 43, true);


--
-- Name: files_related_mph_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.files_related_mph_id_seq', 986, true);


--
-- Name: i18n_locale_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.i18n_locale_id_seq', 1, true);


--
-- Name: lottery_users_biduser_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.lottery_users_biduser_lnk_id_seq', 2674, true);


--
-- Name: lottery_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.lottery_users_id_seq', 515, true);


--
-- Name: lottery_users_products_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.lottery_users_products_lnk_id_seq', 1468, true);


--
-- Name: products_biduser_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.products_biduser_lnk_id_seq', 2936, true);


--
-- Name: products_categories_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.products_categories_lnk_id_seq', 440, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.products_id_seq', 473, true);


--
-- Name: strapi_api_token_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.strapi_api_token_permissions_id_seq', 1, false);


--
-- Name: strapi_api_token_permissions_token_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.strapi_api_token_permissions_token_lnk_id_seq', 1, false);


--
-- Name: strapi_api_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.strapi_api_tokens_id_seq', 1, false);


--
-- Name: strapi_core_store_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.strapi_core_store_settings_id_seq', 32, true);


--
-- Name: strapi_database_schema_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.strapi_database_schema_id_seq', 38, true);


--
-- Name: strapi_history_versions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.strapi_history_versions_id_seq', 1, false);


--
-- Name: strapi_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.strapi_migrations_id_seq', 1, false);


--
-- Name: strapi_migrations_internal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.strapi_migrations_internal_id_seq', 6, true);


--
-- Name: strapi_release_actions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.strapi_release_actions_id_seq', 1, false);


--
-- Name: strapi_release_actions_release_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.strapi_release_actions_release_lnk_id_seq', 1, false);


--
-- Name: strapi_releases_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.strapi_releases_id_seq', 1, false);


--
-- Name: strapi_transfer_token_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.strapi_transfer_token_permissions_id_seq', 1, false);


--
-- Name: strapi_transfer_token_permissions_token_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.strapi_transfer_token_permissions_token_lnk_id_seq', 1, false);


--
-- Name: strapi_transfer_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.strapi_transfer_tokens_id_seq', 1, false);


--
-- Name: strapi_webhooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.strapi_webhooks_id_seq', 1, false);


--
-- Name: strapi_workflows_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.strapi_workflows_id_seq', 1, false);


--
-- Name: strapi_workflows_stage_required_to_publish_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.strapi_workflows_stage_required_to_publish_lnk_id_seq', 1, false);


--
-- Name: strapi_workflows_stages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.strapi_workflows_stages_id_seq', 1, false);


--
-- Name: strapi_workflows_stages_permissions_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.strapi_workflows_stages_permissions_lnk_id_seq', 1, false);


--
-- Name: strapi_workflows_stages_workflow_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.strapi_workflows_stages_workflow_lnk_id_seq', 1, false);


--
-- Name: up_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.up_permissions_id_seq', 35, true);


--
-- Name: up_permissions_role_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.up_permissions_role_lnk_id_seq', 35, true);


--
-- Name: up_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.up_roles_id_seq', 2, true);


--
-- Name: up_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.up_users_id_seq', 2, true);


--
-- Name: up_users_role_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.up_users_role_lnk_id_seq', 2, true);


--
-- Name: upload_folders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.upload_folders_id_seq', 1, false);


--
-- Name: upload_folders_parent_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.upload_folders_parent_lnk_id_seq', 1, false);


--
-- Name: admin_permissions admin_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.admin_permissions
    ADD CONSTRAINT admin_permissions_pkey PRIMARY KEY (id);


--
-- Name: admin_permissions_role_lnk admin_permissions_role_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.admin_permissions_role_lnk
    ADD CONSTRAINT admin_permissions_role_lnk_pkey PRIMARY KEY (id);


--
-- Name: admin_permissions_role_lnk admin_permissions_role_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.admin_permissions_role_lnk
    ADD CONSTRAINT admin_permissions_role_lnk_uq UNIQUE (permission_id, role_id);


--
-- Name: admin_roles admin_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.admin_roles
    ADD CONSTRAINT admin_roles_pkey PRIMARY KEY (id);


--
-- Name: admin_users admin_users_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_pkey PRIMARY KEY (id);


--
-- Name: admin_users_roles_lnk admin_users_roles_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.admin_users_roles_lnk
    ADD CONSTRAINT admin_users_roles_lnk_pkey PRIMARY KEY (id);


--
-- Name: admin_users_roles_lnk admin_users_roles_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.admin_users_roles_lnk
    ADD CONSTRAINT admin_users_roles_lnk_uq UNIQUE (user_id, role_id);


--
-- Name: bids_biduser_lnk bids_biduser_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.bids_biduser_lnk
    ADD CONSTRAINT bids_biduser_lnk_pkey PRIMARY KEY (id);


--
-- Name: bids_biduser_lnk bids_biduser_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.bids_biduser_lnk
    ADD CONSTRAINT bids_biduser_lnk_uq UNIQUE (bid_id, biduser_id);


--
-- Name: bids bids_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.bids
    ADD CONSTRAINT bids_pkey PRIMARY KEY (id);


--
-- Name: bids_product_lnk bids_product_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.bids_product_lnk
    ADD CONSTRAINT bids_product_lnk_pkey PRIMARY KEY (id);


--
-- Name: bids_product_lnk bids_product_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.bids_product_lnk
    ADD CONSTRAINT bids_product_lnk_uq UNIQUE (bid_id, product_id);


--
-- Name: bidusers bidusers_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.bidusers
    ADD CONSTRAINT bidusers_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: files_folder_lnk files_folder_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.files_folder_lnk
    ADD CONSTRAINT files_folder_lnk_pkey PRIMARY KEY (id);


--
-- Name: files_folder_lnk files_folder_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.files_folder_lnk
    ADD CONSTRAINT files_folder_lnk_uq UNIQUE (file_id, folder_id);


--
-- Name: files files_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_pkey PRIMARY KEY (id);


--
-- Name: files_related_mph files_related_mph_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.files_related_mph
    ADD CONSTRAINT files_related_mph_pkey PRIMARY KEY (id);


--
-- Name: i18n_locale i18n_locale_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.i18n_locale
    ADD CONSTRAINT i18n_locale_pkey PRIMARY KEY (id);


--
-- Name: lottery_users_biduser_lnk lottery_users_biduser_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.lottery_users_biduser_lnk
    ADD CONSTRAINT lottery_users_biduser_lnk_pkey PRIMARY KEY (id);


--
-- Name: lottery_users_biduser_lnk lottery_users_biduser_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.lottery_users_biduser_lnk
    ADD CONSTRAINT lottery_users_biduser_lnk_uq UNIQUE (lottery_user_id, biduser_id);


--
-- Name: lottery_users lottery_users_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.lottery_users
    ADD CONSTRAINT lottery_users_pkey PRIMARY KEY (id);


--
-- Name: lottery_users_products_lnk lottery_users_products_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.lottery_users_products_lnk
    ADD CONSTRAINT lottery_users_products_lnk_pkey PRIMARY KEY (id);


--
-- Name: lottery_users_products_lnk lottery_users_products_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.lottery_users_products_lnk
    ADD CONSTRAINT lottery_users_products_lnk_uq UNIQUE (lottery_user_id, product_id);


--
-- Name: products_biduser_lnk products_biduser_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.products_biduser_lnk
    ADD CONSTRAINT products_biduser_lnk_pkey PRIMARY KEY (id);


--
-- Name: products_biduser_lnk products_biduser_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.products_biduser_lnk
    ADD CONSTRAINT products_biduser_lnk_uq UNIQUE (product_id, biduser_id);


--
-- Name: products_categories_lnk products_categories_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.products_categories_lnk
    ADD CONSTRAINT products_categories_lnk_pkey PRIMARY KEY (id);


--
-- Name: products_categories_lnk products_categories_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.products_categories_lnk
    ADD CONSTRAINT products_categories_lnk_uq UNIQUE (product_id, category_id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: strapi_api_token_permissions strapi_api_token_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_api_token_permissions
    ADD CONSTRAINT strapi_api_token_permissions_pkey PRIMARY KEY (id);


--
-- Name: strapi_api_token_permissions_token_lnk strapi_api_token_permissions_token_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_api_token_permissions_token_lnk
    ADD CONSTRAINT strapi_api_token_permissions_token_lnk_pkey PRIMARY KEY (id);


--
-- Name: strapi_api_token_permissions_token_lnk strapi_api_token_permissions_token_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_api_token_permissions_token_lnk
    ADD CONSTRAINT strapi_api_token_permissions_token_lnk_uq UNIQUE (api_token_permission_id, api_token_id);


--
-- Name: strapi_api_tokens strapi_api_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_api_tokens
    ADD CONSTRAINT strapi_api_tokens_pkey PRIMARY KEY (id);


--
-- Name: strapi_core_store_settings strapi_core_store_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_core_store_settings
    ADD CONSTRAINT strapi_core_store_settings_pkey PRIMARY KEY (id);


--
-- Name: strapi_database_schema strapi_database_schema_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_database_schema
    ADD CONSTRAINT strapi_database_schema_pkey PRIMARY KEY (id);


--
-- Name: strapi_history_versions strapi_history_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_history_versions
    ADD CONSTRAINT strapi_history_versions_pkey PRIMARY KEY (id);


--
-- Name: strapi_migrations_internal strapi_migrations_internal_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_migrations_internal
    ADD CONSTRAINT strapi_migrations_internal_pkey PRIMARY KEY (id);


--
-- Name: strapi_migrations strapi_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_migrations
    ADD CONSTRAINT strapi_migrations_pkey PRIMARY KEY (id);


--
-- Name: strapi_release_actions strapi_release_actions_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_release_actions
    ADD CONSTRAINT strapi_release_actions_pkey PRIMARY KEY (id);


--
-- Name: strapi_release_actions_release_lnk strapi_release_actions_release_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_release_actions_release_lnk
    ADD CONSTRAINT strapi_release_actions_release_lnk_pkey PRIMARY KEY (id);


--
-- Name: strapi_release_actions_release_lnk strapi_release_actions_release_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_release_actions_release_lnk
    ADD CONSTRAINT strapi_release_actions_release_lnk_uq UNIQUE (release_action_id, release_id);


--
-- Name: strapi_releases strapi_releases_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_releases
    ADD CONSTRAINT strapi_releases_pkey PRIMARY KEY (id);


--
-- Name: strapi_transfer_token_permissions strapi_transfer_token_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions
    ADD CONSTRAINT strapi_transfer_token_permissions_pkey PRIMARY KEY (id);


--
-- Name: strapi_transfer_token_permissions_token_lnk strapi_transfer_token_permissions_token_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_lnk
    ADD CONSTRAINT strapi_transfer_token_permissions_token_lnk_pkey PRIMARY KEY (id);


--
-- Name: strapi_transfer_token_permissions_token_lnk strapi_transfer_token_permissions_token_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_lnk
    ADD CONSTRAINT strapi_transfer_token_permissions_token_lnk_uq UNIQUE (transfer_token_permission_id, transfer_token_id);


--
-- Name: strapi_transfer_tokens strapi_transfer_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_transfer_tokens
    ADD CONSTRAINT strapi_transfer_tokens_pkey PRIMARY KEY (id);


--
-- Name: strapi_webhooks strapi_webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_webhooks
    ADD CONSTRAINT strapi_webhooks_pkey PRIMARY KEY (id);


--
-- Name: strapi_workflows strapi_workflows_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_workflows
    ADD CONSTRAINT strapi_workflows_pkey PRIMARY KEY (id);


--
-- Name: strapi_workflows_stage_required_to_publish_lnk strapi_workflows_stage_required_to_publish_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_workflows_stage_required_to_publish_lnk
    ADD CONSTRAINT strapi_workflows_stage_required_to_publish_lnk_pkey PRIMARY KEY (id);


--
-- Name: strapi_workflows_stage_required_to_publish_lnk strapi_workflows_stage_required_to_publish_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_workflows_stage_required_to_publish_lnk
    ADD CONSTRAINT strapi_workflows_stage_required_to_publish_lnk_uq UNIQUE (workflow_id, workflow_stage_id);


--
-- Name: strapi_workflows_stages_permissions_lnk strapi_workflows_stages_permissions_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_workflows_stages_permissions_lnk
    ADD CONSTRAINT strapi_workflows_stages_permissions_lnk_pkey PRIMARY KEY (id);


--
-- Name: strapi_workflows_stages_permissions_lnk strapi_workflows_stages_permissions_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_workflows_stages_permissions_lnk
    ADD CONSTRAINT strapi_workflows_stages_permissions_lnk_uq UNIQUE (workflow_stage_id, permission_id);


--
-- Name: strapi_workflows_stages strapi_workflows_stages_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_workflows_stages
    ADD CONSTRAINT strapi_workflows_stages_pkey PRIMARY KEY (id);


--
-- Name: strapi_workflows_stages_workflow_lnk strapi_workflows_stages_workflow_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_workflows_stages_workflow_lnk
    ADD CONSTRAINT strapi_workflows_stages_workflow_lnk_pkey PRIMARY KEY (id);


--
-- Name: strapi_workflows_stages_workflow_lnk strapi_workflows_stages_workflow_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_workflows_stages_workflow_lnk
    ADD CONSTRAINT strapi_workflows_stages_workflow_lnk_uq UNIQUE (workflow_stage_id, workflow_id);


--
-- Name: up_permissions up_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.up_permissions
    ADD CONSTRAINT up_permissions_pkey PRIMARY KEY (id);


--
-- Name: up_permissions_role_lnk up_permissions_role_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.up_permissions_role_lnk
    ADD CONSTRAINT up_permissions_role_lnk_pkey PRIMARY KEY (id);


--
-- Name: up_permissions_role_lnk up_permissions_role_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.up_permissions_role_lnk
    ADD CONSTRAINT up_permissions_role_lnk_uq UNIQUE (permission_id, role_id);


--
-- Name: up_roles up_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.up_roles
    ADD CONSTRAINT up_roles_pkey PRIMARY KEY (id);


--
-- Name: up_users up_users_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.up_users
    ADD CONSTRAINT up_users_pkey PRIMARY KEY (id);


--
-- Name: up_users_role_lnk up_users_role_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.up_users_role_lnk
    ADD CONSTRAINT up_users_role_lnk_pkey PRIMARY KEY (id);


--
-- Name: up_users_role_lnk up_users_role_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.up_users_role_lnk
    ADD CONSTRAINT up_users_role_lnk_uq UNIQUE (user_id, role_id);


--
-- Name: upload_folders_parent_lnk upload_folders_parent_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.upload_folders_parent_lnk
    ADD CONSTRAINT upload_folders_parent_lnk_pkey PRIMARY KEY (id);


--
-- Name: upload_folders_parent_lnk upload_folders_parent_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.upload_folders_parent_lnk
    ADD CONSTRAINT upload_folders_parent_lnk_uq UNIQUE (folder_id, inv_folder_id);


--
-- Name: upload_folders upload_folders_path_id_index; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_path_id_index UNIQUE (path_id);


--
-- Name: upload_folders upload_folders_path_index; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_path_index UNIQUE (path);


--
-- Name: upload_folders upload_folders_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_pkey PRIMARY KEY (id);


--
-- Name: admin_permissions_created_by_id_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX admin_permissions_created_by_id_fk ON public.admin_permissions USING btree (created_by_id);


--
-- Name: admin_permissions_documents_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX admin_permissions_documents_idx ON public.admin_permissions USING btree (document_id, locale, published_at);


--
-- Name: admin_permissions_role_lnk_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX admin_permissions_role_lnk_fk ON public.admin_permissions_role_lnk USING btree (permission_id);


--
-- Name: admin_permissions_role_lnk_ifk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX admin_permissions_role_lnk_ifk ON public.admin_permissions_role_lnk USING btree (role_id);


--
-- Name: admin_permissions_role_lnk_oifk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX admin_permissions_role_lnk_oifk ON public.admin_permissions_role_lnk USING btree (permission_ord);


--
-- Name: admin_permissions_updated_by_id_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX admin_permissions_updated_by_id_fk ON public.admin_permissions USING btree (updated_by_id);


--
-- Name: admin_roles_created_by_id_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX admin_roles_created_by_id_fk ON public.admin_roles USING btree (created_by_id);


--
-- Name: admin_roles_documents_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX admin_roles_documents_idx ON public.admin_roles USING btree (document_id, locale, published_at);


--
-- Name: admin_roles_updated_by_id_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX admin_roles_updated_by_id_fk ON public.admin_roles USING btree (updated_by_id);


--
-- Name: admin_users_created_by_id_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX admin_users_created_by_id_fk ON public.admin_users USING btree (created_by_id);


--
-- Name: admin_users_documents_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX admin_users_documents_idx ON public.admin_users USING btree (document_id, locale, published_at);


--
-- Name: admin_users_roles_lnk_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX admin_users_roles_lnk_fk ON public.admin_users_roles_lnk USING btree (user_id);


--
-- Name: admin_users_roles_lnk_ifk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX admin_users_roles_lnk_ifk ON public.admin_users_roles_lnk USING btree (role_id);


--
-- Name: admin_users_roles_lnk_ofk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX admin_users_roles_lnk_ofk ON public.admin_users_roles_lnk USING btree (role_ord);


--
-- Name: admin_users_roles_lnk_oifk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX admin_users_roles_lnk_oifk ON public.admin_users_roles_lnk USING btree (user_ord);


--
-- Name: admin_users_updated_by_id_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX admin_users_updated_by_id_fk ON public.admin_users USING btree (updated_by_id);


--
-- Name: bids_biduser_lnk_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX bids_biduser_lnk_fk ON public.bids_biduser_lnk USING btree (bid_id);


--
-- Name: bids_biduser_lnk_ifk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX bids_biduser_lnk_ifk ON public.bids_biduser_lnk USING btree (biduser_id);


--
-- Name: bids_biduser_lnk_oifk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX bids_biduser_lnk_oifk ON public.bids_biduser_lnk USING btree (bid_ord);


--
-- Name: bids_created_by_id_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX bids_created_by_id_fk ON public.bids USING btree (created_by_id);


--
-- Name: bids_documents_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX bids_documents_idx ON public.bids USING btree (document_id, locale, published_at);


--
-- Name: bids_product_lnk_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX bids_product_lnk_fk ON public.bids_product_lnk USING btree (bid_id);


--
-- Name: bids_product_lnk_ifk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX bids_product_lnk_ifk ON public.bids_product_lnk USING btree (product_id);


--
-- Name: bids_product_lnk_oifk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX bids_product_lnk_oifk ON public.bids_product_lnk USING btree (bid_ord);


--
-- Name: bids_updated_by_id_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX bids_updated_by_id_fk ON public.bids USING btree (updated_by_id);


--
-- Name: bidusers_created_by_id_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX bidusers_created_by_id_fk ON public.bidusers USING btree (created_by_id);


--
-- Name: bidusers_documents_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX bidusers_documents_idx ON public.bidusers USING btree (document_id, locale, published_at);


--
-- Name: bidusers_updated_by_id_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX bidusers_updated_by_id_fk ON public.bidusers USING btree (updated_by_id);


--
-- Name: categories_created_by_id_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX categories_created_by_id_fk ON public.categories USING btree (created_by_id);


--
-- Name: categories_documents_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX categories_documents_idx ON public.categories USING btree (document_id, locale, published_at);


--
-- Name: categories_updated_by_id_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX categories_updated_by_id_fk ON public.categories USING btree (updated_by_id);


--
-- Name: files_created_by_id_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX files_created_by_id_fk ON public.files USING btree (created_by_id);


--
-- Name: files_documents_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX files_documents_idx ON public.files USING btree (document_id, locale, published_at);


--
-- Name: files_folder_lnk_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX files_folder_lnk_fk ON public.files_folder_lnk USING btree (file_id);


--
-- Name: files_folder_lnk_ifk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX files_folder_lnk_ifk ON public.files_folder_lnk USING btree (folder_id);


--
-- Name: files_folder_lnk_oifk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX files_folder_lnk_oifk ON public.files_folder_lnk USING btree (file_ord);


--
-- Name: files_related_mph_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX files_related_mph_fk ON public.files_related_mph USING btree (file_id);


--
-- Name: files_related_mph_idix; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX files_related_mph_idix ON public.files_related_mph USING btree (related_id);


--
-- Name: files_related_mph_oidx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX files_related_mph_oidx ON public.files_related_mph USING btree ("order");


--
-- Name: files_updated_by_id_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX files_updated_by_id_fk ON public.files USING btree (updated_by_id);


--
-- Name: i18n_locale_created_by_id_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX i18n_locale_created_by_id_fk ON public.i18n_locale USING btree (created_by_id);


--
-- Name: i18n_locale_documents_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX i18n_locale_documents_idx ON public.i18n_locale USING btree (document_id, locale, published_at);


--
-- Name: i18n_locale_updated_by_id_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX i18n_locale_updated_by_id_fk ON public.i18n_locale USING btree (updated_by_id);


--
-- Name: lottery_users_biduser_lnk_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX lottery_users_biduser_lnk_fk ON public.lottery_users_biduser_lnk USING btree (lottery_user_id);


--
-- Name: lottery_users_biduser_lnk_ifk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX lottery_users_biduser_lnk_ifk ON public.lottery_users_biduser_lnk USING btree (biduser_id);


--
-- Name: lottery_users_biduser_lnk_oifk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX lottery_users_biduser_lnk_oifk ON public.lottery_users_biduser_lnk USING btree (lottery_user_ord);


--
-- Name: lottery_users_created_by_id_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX lottery_users_created_by_id_fk ON public.lottery_users USING btree (created_by_id);


--
-- Name: lottery_users_documents_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX lottery_users_documents_idx ON public.lottery_users USING btree (document_id, locale, published_at);


--
-- Name: lottery_users_products_lnk_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX lottery_users_products_lnk_fk ON public.lottery_users_products_lnk USING btree (lottery_user_id);


--
-- Name: lottery_users_products_lnk_ifk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX lottery_users_products_lnk_ifk ON public.lottery_users_products_lnk USING btree (product_id);


--
-- Name: lottery_users_products_lnk_ofk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX lottery_users_products_lnk_ofk ON public.lottery_users_products_lnk USING btree (product_ord);


--
-- Name: lottery_users_products_lnk_oifk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX lottery_users_products_lnk_oifk ON public.lottery_users_products_lnk USING btree (lottery_user_ord);


--
-- Name: lottery_users_updated_by_id_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX lottery_users_updated_by_id_fk ON public.lottery_users USING btree (updated_by_id);


--
-- Name: products_biduser_lnk_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX products_biduser_lnk_fk ON public.products_biduser_lnk USING btree (product_id);


--
-- Name: products_biduser_lnk_ifk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX products_biduser_lnk_ifk ON public.products_biduser_lnk USING btree (biduser_id);


--
-- Name: products_biduser_lnk_oifk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX products_biduser_lnk_oifk ON public.products_biduser_lnk USING btree (product_ord);


--
-- Name: products_categories_lnk_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX products_categories_lnk_fk ON public.products_categories_lnk USING btree (product_id);


--
-- Name: products_categories_lnk_ifk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX products_categories_lnk_ifk ON public.products_categories_lnk USING btree (category_id);


--
-- Name: products_categories_lnk_ofk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX products_categories_lnk_ofk ON public.products_categories_lnk USING btree (category_ord);


--
-- Name: products_created_by_id_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX products_created_by_id_fk ON public.products USING btree (created_by_id);


--
-- Name: products_documents_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX products_documents_idx ON public.products USING btree (document_id, locale, published_at);


--
-- Name: products_updated_by_id_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX products_updated_by_id_fk ON public.products USING btree (updated_by_id);


--
-- Name: strapi_api_token_permissions_created_by_id_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX strapi_api_token_permissions_created_by_id_fk ON public.strapi_api_token_permissions USING btree (created_by_id);


--
-- Name: strapi_api_token_permissions_documents_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX strapi_api_token_permissions_documents_idx ON public.strapi_api_token_permissions USING btree (document_id, locale, published_at);


--
-- Name: strapi_api_token_permissions_token_lnk_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX strapi_api_token_permissions_token_lnk_fk ON public.strapi_api_token_permissions_token_lnk USING btree (api_token_permission_id);


--
-- Name: strapi_api_token_permissions_token_lnk_ifk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX strapi_api_token_permissions_token_lnk_ifk ON public.strapi_api_token_permissions_token_lnk USING btree (api_token_id);


--
-- Name: strapi_api_token_permissions_token_lnk_oifk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX strapi_api_token_permissions_token_lnk_oifk ON public.strapi_api_token_permissions_token_lnk USING btree (api_token_permission_ord);


--
-- Name: strapi_api_token_permissions_updated_by_id_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX strapi_api_token_permissions_updated_by_id_fk ON public.strapi_api_token_permissions USING btree (updated_by_id);


--
-- Name: strapi_api_tokens_created_by_id_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX strapi_api_tokens_created_by_id_fk ON public.strapi_api_tokens USING btree (created_by_id);


--
-- Name: strapi_api_tokens_documents_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX strapi_api_tokens_documents_idx ON public.strapi_api_tokens USING btree (document_id, locale, published_at);


--
-- Name: strapi_api_tokens_updated_by_id_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX strapi_api_tokens_updated_by_id_fk ON public.strapi_api_tokens USING btree (updated_by_id);


--
-- Name: strapi_history_versions_created_by_id_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX strapi_history_versions_created_by_id_fk ON public.strapi_history_versions USING btree (created_by_id);


--
-- Name: strapi_release_actions_created_by_id_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX strapi_release_actions_created_by_id_fk ON public.strapi_release_actions USING btree (created_by_id);


--
-- Name: strapi_release_actions_documents_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX strapi_release_actions_documents_idx ON public.strapi_release_actions USING btree (document_id, locale, published_at);


--
-- Name: strapi_release_actions_release_lnk_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX strapi_release_actions_release_lnk_fk ON public.strapi_release_actions_release_lnk USING btree (release_action_id);


--
-- Name: strapi_release_actions_release_lnk_ifk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX strapi_release_actions_release_lnk_ifk ON public.strapi_release_actions_release_lnk USING btree (release_id);


--
-- Name: strapi_release_actions_release_lnk_oifk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX strapi_release_actions_release_lnk_oifk ON public.strapi_release_actions_release_lnk USING btree (release_action_ord);


--
-- Name: strapi_release_actions_updated_by_id_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX strapi_release_actions_updated_by_id_fk ON public.strapi_release_actions USING btree (updated_by_id);


--
-- Name: strapi_releases_created_by_id_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX strapi_releases_created_by_id_fk ON public.strapi_releases USING btree (created_by_id);


--
-- Name: strapi_releases_documents_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX strapi_releases_documents_idx ON public.strapi_releases USING btree (document_id, locale, published_at);


--
-- Name: strapi_releases_updated_by_id_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX strapi_releases_updated_by_id_fk ON public.strapi_releases USING btree (updated_by_id);


--
-- Name: strapi_transfer_token_permissions_created_by_id_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX strapi_transfer_token_permissions_created_by_id_fk ON public.strapi_transfer_token_permissions USING btree (created_by_id);


--
-- Name: strapi_transfer_token_permissions_documents_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX strapi_transfer_token_permissions_documents_idx ON public.strapi_transfer_token_permissions USING btree (document_id, locale, published_at);


--
-- Name: strapi_transfer_token_permissions_token_lnk_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX strapi_transfer_token_permissions_token_lnk_fk ON public.strapi_transfer_token_permissions_token_lnk USING btree (transfer_token_permission_id);


--
-- Name: strapi_transfer_token_permissions_token_lnk_ifk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX strapi_transfer_token_permissions_token_lnk_ifk ON public.strapi_transfer_token_permissions_token_lnk USING btree (transfer_token_id);


--
-- Name: strapi_transfer_token_permissions_token_lnk_oifk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX strapi_transfer_token_permissions_token_lnk_oifk ON public.strapi_transfer_token_permissions_token_lnk USING btree (transfer_token_permission_ord);


--
-- Name: strapi_transfer_token_permissions_updated_by_id_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX strapi_transfer_token_permissions_updated_by_id_fk ON public.strapi_transfer_token_permissions USING btree (updated_by_id);


--
-- Name: strapi_transfer_tokens_created_by_id_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX strapi_transfer_tokens_created_by_id_fk ON public.strapi_transfer_tokens USING btree (created_by_id);


--
-- Name: strapi_transfer_tokens_documents_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX strapi_transfer_tokens_documents_idx ON public.strapi_transfer_tokens USING btree (document_id, locale, published_at);


--
-- Name: strapi_transfer_tokens_updated_by_id_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX strapi_transfer_tokens_updated_by_id_fk ON public.strapi_transfer_tokens USING btree (updated_by_id);


--
-- Name: strapi_workflows_created_by_id_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX strapi_workflows_created_by_id_fk ON public.strapi_workflows USING btree (created_by_id);


--
-- Name: strapi_workflows_documents_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX strapi_workflows_documents_idx ON public.strapi_workflows USING btree (document_id, locale, published_at);


--
-- Name: strapi_workflows_stage_required_to_publish_lnk_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX strapi_workflows_stage_required_to_publish_lnk_fk ON public.strapi_workflows_stage_required_to_publish_lnk USING btree (workflow_id);


--
-- Name: strapi_workflows_stage_required_to_publish_lnk_ifk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX strapi_workflows_stage_required_to_publish_lnk_ifk ON public.strapi_workflows_stage_required_to_publish_lnk USING btree (workflow_stage_id);


--
-- Name: strapi_workflows_stages_created_by_id_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX strapi_workflows_stages_created_by_id_fk ON public.strapi_workflows_stages USING btree (created_by_id);


--
-- Name: strapi_workflows_stages_documents_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX strapi_workflows_stages_documents_idx ON public.strapi_workflows_stages USING btree (document_id, locale, published_at);


--
-- Name: strapi_workflows_stages_permissions_lnk_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX strapi_workflows_stages_permissions_lnk_fk ON public.strapi_workflows_stages_permissions_lnk USING btree (workflow_stage_id);


--
-- Name: strapi_workflows_stages_permissions_lnk_ifk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX strapi_workflows_stages_permissions_lnk_ifk ON public.strapi_workflows_stages_permissions_lnk USING btree (permission_id);


--
-- Name: strapi_workflows_stages_permissions_lnk_ofk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX strapi_workflows_stages_permissions_lnk_ofk ON public.strapi_workflows_stages_permissions_lnk USING btree (permission_ord);


--
-- Name: strapi_workflows_stages_updated_by_id_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX strapi_workflows_stages_updated_by_id_fk ON public.strapi_workflows_stages USING btree (updated_by_id);


--
-- Name: strapi_workflows_stages_workflow_lnk_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX strapi_workflows_stages_workflow_lnk_fk ON public.strapi_workflows_stages_workflow_lnk USING btree (workflow_stage_id);


--
-- Name: strapi_workflows_stages_workflow_lnk_ifk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX strapi_workflows_stages_workflow_lnk_ifk ON public.strapi_workflows_stages_workflow_lnk USING btree (workflow_id);


--
-- Name: strapi_workflows_stages_workflow_lnk_oifk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX strapi_workflows_stages_workflow_lnk_oifk ON public.strapi_workflows_stages_workflow_lnk USING btree (workflow_stage_ord);


--
-- Name: strapi_workflows_updated_by_id_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX strapi_workflows_updated_by_id_fk ON public.strapi_workflows USING btree (updated_by_id);


--
-- Name: up_permissions_created_by_id_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX up_permissions_created_by_id_fk ON public.up_permissions USING btree (created_by_id);


--
-- Name: up_permissions_documents_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX up_permissions_documents_idx ON public.up_permissions USING btree (document_id, locale, published_at);


--
-- Name: up_permissions_role_lnk_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX up_permissions_role_lnk_fk ON public.up_permissions_role_lnk USING btree (permission_id);


--
-- Name: up_permissions_role_lnk_ifk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX up_permissions_role_lnk_ifk ON public.up_permissions_role_lnk USING btree (role_id);


--
-- Name: up_permissions_role_lnk_oifk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX up_permissions_role_lnk_oifk ON public.up_permissions_role_lnk USING btree (permission_ord);


--
-- Name: up_permissions_updated_by_id_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX up_permissions_updated_by_id_fk ON public.up_permissions USING btree (updated_by_id);


--
-- Name: up_roles_created_by_id_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX up_roles_created_by_id_fk ON public.up_roles USING btree (created_by_id);


--
-- Name: up_roles_documents_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX up_roles_documents_idx ON public.up_roles USING btree (document_id, locale, published_at);


--
-- Name: up_roles_updated_by_id_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX up_roles_updated_by_id_fk ON public.up_roles USING btree (updated_by_id);


--
-- Name: up_users_created_by_id_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX up_users_created_by_id_fk ON public.up_users USING btree (created_by_id);


--
-- Name: up_users_documents_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX up_users_documents_idx ON public.up_users USING btree (document_id, locale, published_at);


--
-- Name: up_users_role_lnk_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX up_users_role_lnk_fk ON public.up_users_role_lnk USING btree (user_id);


--
-- Name: up_users_role_lnk_ifk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX up_users_role_lnk_ifk ON public.up_users_role_lnk USING btree (role_id);


--
-- Name: up_users_role_lnk_oifk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX up_users_role_lnk_oifk ON public.up_users_role_lnk USING btree (user_ord);


--
-- Name: up_users_updated_by_id_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX up_users_updated_by_id_fk ON public.up_users USING btree (updated_by_id);


--
-- Name: upload_files_created_at_index; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX upload_files_created_at_index ON public.files USING btree (created_at);


--
-- Name: upload_files_ext_index; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX upload_files_ext_index ON public.files USING btree (ext);


--
-- Name: upload_files_folder_path_index; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX upload_files_folder_path_index ON public.files USING btree (folder_path);


--
-- Name: upload_files_name_index; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX upload_files_name_index ON public.files USING btree (name);


--
-- Name: upload_files_size_index; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX upload_files_size_index ON public.files USING btree (size);


--
-- Name: upload_files_updated_at_index; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX upload_files_updated_at_index ON public.files USING btree (updated_at);


--
-- Name: upload_folders_created_by_id_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX upload_folders_created_by_id_fk ON public.upload_folders USING btree (created_by_id);


--
-- Name: upload_folders_documents_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX upload_folders_documents_idx ON public.upload_folders USING btree (document_id, locale, published_at);


--
-- Name: upload_folders_parent_lnk_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX upload_folders_parent_lnk_fk ON public.upload_folders_parent_lnk USING btree (folder_id);


--
-- Name: upload_folders_parent_lnk_ifk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX upload_folders_parent_lnk_ifk ON public.upload_folders_parent_lnk USING btree (inv_folder_id);


--
-- Name: upload_folders_parent_lnk_oifk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX upload_folders_parent_lnk_oifk ON public.upload_folders_parent_lnk USING btree (folder_ord);


--
-- Name: upload_folders_updated_by_id_fk; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX upload_folders_updated_by_id_fk ON public.upload_folders USING btree (updated_by_id);


--
-- Name: admin_permissions admin_permissions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.admin_permissions
    ADD CONSTRAINT admin_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: admin_permissions_role_lnk admin_permissions_role_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.admin_permissions_role_lnk
    ADD CONSTRAINT admin_permissions_role_lnk_fk FOREIGN KEY (permission_id) REFERENCES public.admin_permissions(id) ON DELETE CASCADE;


--
-- Name: admin_permissions_role_lnk admin_permissions_role_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.admin_permissions_role_lnk
    ADD CONSTRAINT admin_permissions_role_lnk_ifk FOREIGN KEY (role_id) REFERENCES public.admin_roles(id) ON DELETE CASCADE;


--
-- Name: admin_permissions admin_permissions_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.admin_permissions
    ADD CONSTRAINT admin_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: admin_roles admin_roles_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.admin_roles
    ADD CONSTRAINT admin_roles_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: admin_roles admin_roles_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.admin_roles
    ADD CONSTRAINT admin_roles_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: admin_users admin_users_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: admin_users_roles_lnk admin_users_roles_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.admin_users_roles_lnk
    ADD CONSTRAINT admin_users_roles_lnk_fk FOREIGN KEY (user_id) REFERENCES public.admin_users(id) ON DELETE CASCADE;


--
-- Name: admin_users_roles_lnk admin_users_roles_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.admin_users_roles_lnk
    ADD CONSTRAINT admin_users_roles_lnk_ifk FOREIGN KEY (role_id) REFERENCES public.admin_roles(id) ON DELETE CASCADE;


--
-- Name: admin_users admin_users_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: bids_biduser_lnk bids_biduser_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.bids_biduser_lnk
    ADD CONSTRAINT bids_biduser_lnk_fk FOREIGN KEY (bid_id) REFERENCES public.bids(id) ON DELETE CASCADE;


--
-- Name: bids_biduser_lnk bids_biduser_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.bids_biduser_lnk
    ADD CONSTRAINT bids_biduser_lnk_ifk FOREIGN KEY (biduser_id) REFERENCES public.bidusers(id) ON DELETE CASCADE;


--
-- Name: bids bids_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.bids
    ADD CONSTRAINT bids_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: bids_product_lnk bids_product_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.bids_product_lnk
    ADD CONSTRAINT bids_product_lnk_fk FOREIGN KEY (bid_id) REFERENCES public.bids(id) ON DELETE CASCADE;


--
-- Name: bids_product_lnk bids_product_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.bids_product_lnk
    ADD CONSTRAINT bids_product_lnk_ifk FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: bids bids_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.bids
    ADD CONSTRAINT bids_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: bidusers bidusers_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.bidusers
    ADD CONSTRAINT bidusers_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: bidusers bidusers_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.bidusers
    ADD CONSTRAINT bidusers_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: categories categories_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: categories categories_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: files files_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: files_folder_lnk files_folder_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.files_folder_lnk
    ADD CONSTRAINT files_folder_lnk_fk FOREIGN KEY (file_id) REFERENCES public.files(id) ON DELETE CASCADE;


--
-- Name: files_folder_lnk files_folder_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.files_folder_lnk
    ADD CONSTRAINT files_folder_lnk_ifk FOREIGN KEY (folder_id) REFERENCES public.upload_folders(id) ON DELETE CASCADE;


--
-- Name: files_related_mph files_related_mph_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.files_related_mph
    ADD CONSTRAINT files_related_mph_fk FOREIGN KEY (file_id) REFERENCES public.files(id) ON DELETE CASCADE;


--
-- Name: files files_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: i18n_locale i18n_locale_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.i18n_locale
    ADD CONSTRAINT i18n_locale_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: i18n_locale i18n_locale_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.i18n_locale
    ADD CONSTRAINT i18n_locale_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: lottery_users_biduser_lnk lottery_users_biduser_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.lottery_users_biduser_lnk
    ADD CONSTRAINT lottery_users_biduser_lnk_fk FOREIGN KEY (lottery_user_id) REFERENCES public.lottery_users(id) ON DELETE CASCADE;


--
-- Name: lottery_users_biduser_lnk lottery_users_biduser_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.lottery_users_biduser_lnk
    ADD CONSTRAINT lottery_users_biduser_lnk_ifk FOREIGN KEY (biduser_id) REFERENCES public.bidusers(id) ON DELETE CASCADE;


--
-- Name: lottery_users lottery_users_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.lottery_users
    ADD CONSTRAINT lottery_users_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: lottery_users_products_lnk lottery_users_products_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.lottery_users_products_lnk
    ADD CONSTRAINT lottery_users_products_lnk_fk FOREIGN KEY (lottery_user_id) REFERENCES public.lottery_users(id) ON DELETE CASCADE;


--
-- Name: lottery_users_products_lnk lottery_users_products_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.lottery_users_products_lnk
    ADD CONSTRAINT lottery_users_products_lnk_ifk FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: lottery_users lottery_users_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.lottery_users
    ADD CONSTRAINT lottery_users_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: products_biduser_lnk products_biduser_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.products_biduser_lnk
    ADD CONSTRAINT products_biduser_lnk_fk FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: products_biduser_lnk products_biduser_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.products_biduser_lnk
    ADD CONSTRAINT products_biduser_lnk_ifk FOREIGN KEY (biduser_id) REFERENCES public.bidusers(id) ON DELETE CASCADE;


--
-- Name: products_categories_lnk products_categories_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.products_categories_lnk
    ADD CONSTRAINT products_categories_lnk_fk FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: products_categories_lnk products_categories_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.products_categories_lnk
    ADD CONSTRAINT products_categories_lnk_ifk FOREIGN KEY (category_id) REFERENCES public.categories(id) ON DELETE CASCADE;


--
-- Name: products products_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: products products_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_api_token_permissions strapi_api_token_permissions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_api_token_permissions
    ADD CONSTRAINT strapi_api_token_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_api_token_permissions_token_lnk strapi_api_token_permissions_token_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_api_token_permissions_token_lnk
    ADD CONSTRAINT strapi_api_token_permissions_token_lnk_fk FOREIGN KEY (api_token_permission_id) REFERENCES public.strapi_api_token_permissions(id) ON DELETE CASCADE;


--
-- Name: strapi_api_token_permissions_token_lnk strapi_api_token_permissions_token_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_api_token_permissions_token_lnk
    ADD CONSTRAINT strapi_api_token_permissions_token_lnk_ifk FOREIGN KEY (api_token_id) REFERENCES public.strapi_api_tokens(id) ON DELETE CASCADE;


--
-- Name: strapi_api_token_permissions strapi_api_token_permissions_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_api_token_permissions
    ADD CONSTRAINT strapi_api_token_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_api_tokens strapi_api_tokens_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_api_tokens
    ADD CONSTRAINT strapi_api_tokens_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_api_tokens strapi_api_tokens_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_api_tokens
    ADD CONSTRAINT strapi_api_tokens_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_history_versions strapi_history_versions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_history_versions
    ADD CONSTRAINT strapi_history_versions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_release_actions strapi_release_actions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_release_actions
    ADD CONSTRAINT strapi_release_actions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_release_actions_release_lnk strapi_release_actions_release_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_release_actions_release_lnk
    ADD CONSTRAINT strapi_release_actions_release_lnk_fk FOREIGN KEY (release_action_id) REFERENCES public.strapi_release_actions(id) ON DELETE CASCADE;


--
-- Name: strapi_release_actions_release_lnk strapi_release_actions_release_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_release_actions_release_lnk
    ADD CONSTRAINT strapi_release_actions_release_lnk_ifk FOREIGN KEY (release_id) REFERENCES public.strapi_releases(id) ON DELETE CASCADE;


--
-- Name: strapi_release_actions strapi_release_actions_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_release_actions
    ADD CONSTRAINT strapi_release_actions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_releases strapi_releases_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_releases
    ADD CONSTRAINT strapi_releases_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_releases strapi_releases_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_releases
    ADD CONSTRAINT strapi_releases_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_transfer_token_permissions strapi_transfer_token_permissions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions
    ADD CONSTRAINT strapi_transfer_token_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_transfer_token_permissions_token_lnk strapi_transfer_token_permissions_token_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_lnk
    ADD CONSTRAINT strapi_transfer_token_permissions_token_lnk_fk FOREIGN KEY (transfer_token_permission_id) REFERENCES public.strapi_transfer_token_permissions(id) ON DELETE CASCADE;


--
-- Name: strapi_transfer_token_permissions_token_lnk strapi_transfer_token_permissions_token_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_lnk
    ADD CONSTRAINT strapi_transfer_token_permissions_token_lnk_ifk FOREIGN KEY (transfer_token_id) REFERENCES public.strapi_transfer_tokens(id) ON DELETE CASCADE;


--
-- Name: strapi_transfer_token_permissions strapi_transfer_token_permissions_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions
    ADD CONSTRAINT strapi_transfer_token_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_transfer_tokens strapi_transfer_tokens_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_transfer_tokens
    ADD CONSTRAINT strapi_transfer_tokens_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_transfer_tokens strapi_transfer_tokens_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_transfer_tokens
    ADD CONSTRAINT strapi_transfer_tokens_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_workflows strapi_workflows_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_workflows
    ADD CONSTRAINT strapi_workflows_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_workflows_stage_required_to_publish_lnk strapi_workflows_stage_required_to_publish_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_workflows_stage_required_to_publish_lnk
    ADD CONSTRAINT strapi_workflows_stage_required_to_publish_lnk_fk FOREIGN KEY (workflow_id) REFERENCES public.strapi_workflows(id) ON DELETE CASCADE;


--
-- Name: strapi_workflows_stage_required_to_publish_lnk strapi_workflows_stage_required_to_publish_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_workflows_stage_required_to_publish_lnk
    ADD CONSTRAINT strapi_workflows_stage_required_to_publish_lnk_ifk FOREIGN KEY (workflow_stage_id) REFERENCES public.strapi_workflows_stages(id) ON DELETE CASCADE;


--
-- Name: strapi_workflows_stages strapi_workflows_stages_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_workflows_stages
    ADD CONSTRAINT strapi_workflows_stages_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_workflows_stages_permissions_lnk strapi_workflows_stages_permissions_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_workflows_stages_permissions_lnk
    ADD CONSTRAINT strapi_workflows_stages_permissions_lnk_fk FOREIGN KEY (workflow_stage_id) REFERENCES public.strapi_workflows_stages(id) ON DELETE CASCADE;


--
-- Name: strapi_workflows_stages_permissions_lnk strapi_workflows_stages_permissions_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_workflows_stages_permissions_lnk
    ADD CONSTRAINT strapi_workflows_stages_permissions_lnk_ifk FOREIGN KEY (permission_id) REFERENCES public.admin_permissions(id) ON DELETE CASCADE;


--
-- Name: strapi_workflows_stages strapi_workflows_stages_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_workflows_stages
    ADD CONSTRAINT strapi_workflows_stages_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_workflows_stages_workflow_lnk strapi_workflows_stages_workflow_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_workflows_stages_workflow_lnk
    ADD CONSTRAINT strapi_workflows_stages_workflow_lnk_fk FOREIGN KEY (workflow_stage_id) REFERENCES public.strapi_workflows_stages(id) ON DELETE CASCADE;


--
-- Name: strapi_workflows_stages_workflow_lnk strapi_workflows_stages_workflow_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_workflows_stages_workflow_lnk
    ADD CONSTRAINT strapi_workflows_stages_workflow_lnk_ifk FOREIGN KEY (workflow_id) REFERENCES public.strapi_workflows(id) ON DELETE CASCADE;


--
-- Name: strapi_workflows strapi_workflows_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.strapi_workflows
    ADD CONSTRAINT strapi_workflows_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_permissions up_permissions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.up_permissions
    ADD CONSTRAINT up_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_permissions_role_lnk up_permissions_role_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.up_permissions_role_lnk
    ADD CONSTRAINT up_permissions_role_lnk_fk FOREIGN KEY (permission_id) REFERENCES public.up_permissions(id) ON DELETE CASCADE;


--
-- Name: up_permissions_role_lnk up_permissions_role_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.up_permissions_role_lnk
    ADD CONSTRAINT up_permissions_role_lnk_ifk FOREIGN KEY (role_id) REFERENCES public.up_roles(id) ON DELETE CASCADE;


--
-- Name: up_permissions up_permissions_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.up_permissions
    ADD CONSTRAINT up_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_roles up_roles_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.up_roles
    ADD CONSTRAINT up_roles_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_roles up_roles_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.up_roles
    ADD CONSTRAINT up_roles_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_users up_users_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.up_users
    ADD CONSTRAINT up_users_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_users_role_lnk up_users_role_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.up_users_role_lnk
    ADD CONSTRAINT up_users_role_lnk_fk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;


--
-- Name: up_users_role_lnk up_users_role_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.up_users_role_lnk
    ADD CONSTRAINT up_users_role_lnk_ifk FOREIGN KEY (role_id) REFERENCES public.up_roles(id) ON DELETE CASCADE;


--
-- Name: up_users up_users_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.up_users
    ADD CONSTRAINT up_users_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: upload_folders upload_folders_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: upload_folders_parent_lnk upload_folders_parent_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.upload_folders_parent_lnk
    ADD CONSTRAINT upload_folders_parent_lnk_fk FOREIGN KEY (folder_id) REFERENCES public.upload_folders(id) ON DELETE CASCADE;


--
-- Name: upload_folders_parent_lnk upload_folders_parent_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.upload_folders_parent_lnk
    ADD CONSTRAINT upload_folders_parent_lnk_ifk FOREIGN KEY (inv_folder_id) REFERENCES public.upload_folders(id) ON DELETE CASCADE;


--
-- Name: upload_folders upload_folders_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

