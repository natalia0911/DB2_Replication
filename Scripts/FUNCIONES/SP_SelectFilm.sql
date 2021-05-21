
-------------------------------------------------------------------------
--- Created by: Natalia Vargas
--- Cratetion date: 20/05/2021
--- Description: Search for a film with a word
--------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION SP_SelectFilm (
	pword CHARACTER VARYING
	)
	returns setof public."film"
	
AS $$
BEGIN 
	RETURN QUERY
	SELECT 
	film_id
	, title
	, description
	, release_year
	, language_id
	, rental_duration
	, rental_rate
	, length
	, replacement_cost
	, rating
	, last_update
	, special_features
	, fulltext
	FROM public.film
	where "title" Ilike  '%'|| pword ||'%';
END;
$$
LANGUAGE plpgsql


--Nota lo devuelve en tupla para ser leído desde la capa de acceso a datos
--SELECT SP_SelectFilm('egg');

