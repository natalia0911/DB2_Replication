

---------------------See roles and bases-------------
SELECT * FROM pg_catalog.pg_roles;
SELECT * FROM pg_catalog.pg_database;

---------------------Create roles---------------------
CREATE ROLE EMP;
CREATE ROLE ADMIN;

---------------------Create users---------------------
CREATE USER empleado1 WITH PASSWORD 'empleado1pw';

CREATE USER administrador1 WITH PASSWORD 'administrador1pw';

CREATE USER video WITH
	LOGIN      -- Then NOLOGIN
	SUPERUSER
	CREATEDB
	CREATEROLE
	INHERIT
	NOREPLICATION
	CONNECTION LIMIT -1;

----------------------Assign roles----------------------

GRANT EXECUTE ON FUNCTION SP_InsertCustomer TO EMP;         -- Insert new customer
GRANT EXECUTE ON FUNCTION SP_InsertRental TO EMP;           -- register rental
GRANT EXECUTE ON FUNCTION SP_UpdateRental TO EMP;           -- register return
GRANT EXECUTE ON FUNCTION SP_SelectFilm TO EMP;             -- Search movie

GRANT EXECUTE ON FUNCTION SP_InsertCustomer TO ADMIN;        -- Insert new customer
GRANT EXECUTE ON FUNCTION SP_InsertRental TO ADMIN;          -- register rental
GRANT EXECUTE ON FUNCTION SP_UpdateRental TO ADMIN;          -- register return
GRANT EXECUTE ON FUNCTION SP_SelectFilm TO ADMIN;            -- Search movie
GRANT EXECUTE ON FUNCTION SP_InsertFillAndCopies TO ADMIN;   -- Insert new film and it inventory

GRANT EMP TO empleado1;
GRANT ADMIN TO administrador1;
GRANT ALL ON SCHEMA public TO video;



