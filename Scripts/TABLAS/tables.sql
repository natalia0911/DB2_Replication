

-- Table: public.DimDate

-- DROP TABLE public."DimDate";

CREATE TABLE public."DimDate"
(
    date_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    year integer NOT NULL,
    month integer NOT NULL,
    day integer NOT NULL,
    CONSTRAINT "DimDate_pkey" PRIMARY KEY (date_id)
)

TABLESPACE pg_default;

ALTER TABLE public."DimDate"
    OWNER to postgres;
	
	
	
	
	-- Table: public.DimDurationLoan

-- DROP TABLE public."DimDurationLoan";

CREATE TABLE public."DimDurationLoan"
(
    duration_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    rental_duration_days integer NOT NULL,
    CONSTRAINT "DimDurationLoan_pkey" PRIMARY KEY (duration_id)
)

TABLESPACE pg_default;

ALTER TABLE public."DimDurationLoan"
    OWNER to postgres;
	
	

-- Table: public.DimFilms

-- DROP TABLE public."DimFilms";

CREATE TABLE public."DimFilms"
(
    film_id integer NOT NULL,
    title character varying COLLATE pg_catalog."default" NOT NULL,
    category_name character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "DimFilms_pkey" PRIMARY KEY (film_id)
)

TABLESPACE pg_default;

ALTER TABLE public."DimFilms"
    OWNER to postgres;
	
	
	
-- Table: public.DimLanguages

-- DROP TABLE public."DimLanguages";

CREATE TABLE public."DimLanguages"
(
    language_id integer NOT NULL,
    language_name character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "DimLanguages_pkey" PRIMARY KEY (language_id)
)

TABLESPACE pg_default;

ALTER TABLE public."DimLanguages"
    OWNER to postgres;
	
	

-- Table: public.DimPlace

-- DROP TABLE public."DimPlace";

CREATE TABLE public."DimPlace"
(
    district_name character varying COLLATE pg_catalog."default" NOT NULL,
    country_name character varying COLLATE pg_catalog."default" NOT NULL,
    store_id integer NOT NULL,
    city_name character varying COLLATE pg_catalog."default" NOT NULL,
    postal_code character varying COLLATE pg_catalog."default",
    CONSTRAINT "DimPlace_pkey" PRIMARY KEY (store_id)
)

TABLESPACE pg_default;

ALTER TABLE public."DimPlace"
    OWNER to postgres;
	
	
-- Table: public.Rentals

-- DROP TABLE public."Rentals";

CREATE TABLE public."Rentals"
(
    rentals_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "DimDate_id" integer NOT NULL,
    "DimFilms_id" integer NOT NULL,
    "DimPlace_id" integer NOT NULL,
    "DimLanguagues_id" integer NOT NULL,
    "DimDurationLoan_id" integer NOT NULL,
    amount_charged numeric NOT NULL,
    loaned_units bigint NOT NULL,
    CONSTRAINT "Rentals_pkey" PRIMARY KEY (rentals_id),
    CONSTRAINT "DimDate_id_fk" FOREIGN KEY ("DimDate_id")
        REFERENCES public."DimDate" (date_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "DimDurationLoan_id" FOREIGN KEY ("DimDurationLoan_id")
        REFERENCES public."DimDurationLoan" (duration_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "DimFilms_id_fk" FOREIGN KEY ("DimFilms_id")
        REFERENCES public."DimFilms" (film_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "DimLanguaguesid_fk" FOREIGN KEY ("DimLanguagues_id")
        REFERENCES public."DimLanguages" (language_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "DimPlaceid_fk" FOREIGN KEY ("DimPlace_id")
        REFERENCES public."DimPlace" (store_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE public."Rentals"
    OWNER to postgres;