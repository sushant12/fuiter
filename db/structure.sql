SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: fb_page_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.fb_page_status AS ENUM (
    'online',
    'in progress',
    'expired'
);


--
-- Name: subscription_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.subscription_type AS ENUM (
    'monthly',
    'yearly'
);


--
-- Name: user_category; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.user_category AS ENUM (
    'normal',
    'reseller',
    'admin'
);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: fb_page_templates; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fb_page_templates (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    properties jsonb,
    fb_page_id uuid,
    template_id uuid,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    logo character varying,
    email character varying,
    location character varying,
    contact character varying,
    email_enable boolean,
    location_enable boolean,
    contact_enable boolean,
    map_enable boolean
);


--
-- Name: fb_pages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fb_pages (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    token character varying,
    content jsonb,
    sub_domain character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id uuid,
    name character varying,
    fb_page_id character varying,
    status public.fb_page_status,
    category character varying,
    picture character varying
);


--
-- Name: pages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pages (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    title character varying,
    "position" integer,
    seo jsonb,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    fb_page_template_id uuid,
    uri character varying,
    ancestry character varying,
    setting jsonb,
    about_image character varying
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.settings (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    socail_media jsonb,
    legal_info jsonb,
    domain character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    fb_page_template_id uuid,
    subdomain character varying
);


--
-- Name: subscriptions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.subscriptions (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    amount numeric(8,2),
    due_date timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    fb_pages_id uuid,
    category public.subscription_type
);


--
-- Name: templates; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.templates (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    name character varying,
    image character varying,
    properties jsonb,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    name character varying,
    image character varying,
    token character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    category public.user_category DEFAULT 'normal'::public.user_category,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    provider character varying,
    uid character varying
);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: fb_page_templates fb_page_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fb_page_templates
    ADD CONSTRAINT fb_page_templates_pkey PRIMARY KEY (id);


--
-- Name: fb_pages fb_pages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fb_pages
    ADD CONSTRAINT fb_pages_pkey PRIMARY KEY (id);


--
-- Name: pages pages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: settings settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (id);


--
-- Name: subscriptions subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT subscriptions_pkey PRIMARY KEY (id);


--
-- Name: templates templates_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.templates
    ADD CONSTRAINT templates_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_fb_page_templates_on_fb_page_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_fb_page_templates_on_fb_page_id ON public.fb_page_templates USING btree (fb_page_id);


--
-- Name: index_fb_page_templates_on_template_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_fb_page_templates_on_template_id ON public.fb_page_templates USING btree (template_id);


--
-- Name: index_fb_pages_on_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_fb_pages_on_status ON public.fb_pages USING btree (status);


--
-- Name: index_fb_pages_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_fb_pages_on_user_id ON public.fb_pages USING btree (user_id);


--
-- Name: index_pages_on_ancestry; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pages_on_ancestry ON public.pages USING btree (ancestry);


--
-- Name: index_pages_on_fb_page_template_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pages_on_fb_page_template_id ON public.pages USING btree (fb_page_template_id);


--
-- Name: index_settings_on_fb_page_template_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_settings_on_fb_page_template_id ON public.settings USING btree (fb_page_template_id);


--
-- Name: index_subscriptions_on_fb_pages_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_subscriptions_on_fb_pages_id ON public.subscriptions USING btree (fb_pages_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: fb_page_templates fk_rails_06be5d9913; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fb_page_templates
    ADD CONSTRAINT fk_rails_06be5d9913 FOREIGN KEY (template_id) REFERENCES public.templates(id);


--
-- Name: fb_page_templates fk_rails_5f15bf73e3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fb_page_templates
    ADD CONSTRAINT fk_rails_5f15bf73e3 FOREIGN KEY (fb_page_id) REFERENCES public.fb_pages(id);


--
-- Name: pages fk_rails_6d637dbd7c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT fk_rails_6d637dbd7c FOREIGN KEY (fb_page_template_id) REFERENCES public.fb_page_templates(id);


--
-- Name: settings fk_rails_7a17b389a8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT fk_rails_7a17b389a8 FOREIGN KEY (fb_page_template_id) REFERENCES public.fb_page_templates(id);


--
-- Name: subscriptions fk_rails_c157bf4149; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT fk_rails_c157bf4149 FOREIGN KEY (fb_pages_id) REFERENCES public.fb_pages(id);


--
-- Name: fb_pages fk_rails_e769b85a3f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fb_pages
    ADD CONSTRAINT fk_rails_e769b85a3f FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20181224133228'),
('20181226141917'),
('20181226142332'),
('20181226142454'),
('20181226142546'),
('20181226143319'),
('20181226144035'),
('20181229060022'),
('20181229065313'),
('20181230042123'),
('20181230044059'),
('20181230070956'),
('20190104105809'),
('20190116064224'),
('20190119103402'),
('20190121153950'),
('20190210043740'),
('20190216083432'),
('20190223052352'),
('20190223083718'),
('20190316053932');


