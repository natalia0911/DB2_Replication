
-------------------------------------------------------------------------
--- Created by: Natalia Vargas
--- Creation date: 20/05/2021
--- Description: Insert a new fill and copies
--------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION SP_InsertFillAndCopies(
	 ptitle CHARACTER VARYING
	,pdescription TEXT
	,prelease_year INT --YEAR
	,planguage CHARACTER VARYING
	,prental_duration INT --
	,prental_rate NUMERIC
	,plength INT --
	,replacement_cost NUMERIC
	,pfulltext TSVECTOR
	,pcategory CHARACTER VARYING
	,pquantityDVDs INT
	,pstore_id INT
	 ) returns void

AS $$
BEGIN 
	--------------Insert just if the film doesn't exist--------------
	IF (NOT EXISTS(SELECT title FROM public.film WHERE title=ptitle)) THEN
	
		----------Insert film----------
		INSERT INTO public.film(

			  title
			, description
			, release_year
			, language_id
			, rental_duration
			, rental_rate
			, length
			, replacement_cost
			, last_update
			, fulltext
			)
			SELECT
			  ptitle
			, pdescription
			, prelease_year
			, L."language_id" 
			, prental_duration 
			, prental_rate
			, plength 
			, replacement_cost 
			, now()::timestamp -- Without time zone
			, pfulltext 

			FROM public."language" AS L
			WHERE L."name" = planguage;
	
		
		----------Insert film category----------
		INSERT INTO public.film_category(
			  film_id
			, category_id
			, last_update
			)
			SELECT
			  F."film_id"
			, C."category_id"
			, now()::timestamp  -- Without time zone
			FROM public."category" AS C, public."film" AS F
			WHERE C."name" = pcategory AND F."title" = ptitle;
	
	
		----------Insert copies----------
		FOR i in 1..pquantityDVDs LOOP

			INSERT INTO public.inventory(
			  film_id
			, store_id
			, last_update
			)
			SELECT
			  F."film_id"
			, pstore_id
			, now()::timestamp  -- Without time zone
			FROM public."film" AS F
			WHERE F."title" = ptitle;
		END LOOP;
		
	END IF;


END;
$$
LANGUAGE plpgsql 
SECURITY DEFINER


--SELECT SP_InsertFillAndCopies('Titanic','The titanic sinks',1997,'English',6,0.99,85,20.9,to_tsvector('english','just a sentence here'),'Drama',3,2);






















--DO $$
--begin
--Codigo prueba
--end;
--$$;



