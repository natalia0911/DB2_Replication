
-------------------------------------------------------------------------
--- Creado por: Natalia Vargas
--- Fecha creación: 15/05/2021
--- Descripción: Llenar la tabla DimFilms del modelo estrella 
--------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE SP_LlenarDimFilms() 
AS $$
BEGIN 
INSERT INTO public."DimFilms"
(
	 "film_id"
	,"title"
	,"category_name"
)
SELECT --DISTINCT
	 F."film_id"
	,F."title"
	,CA."name"
	 
FROM public."film" as F, public."category" AS CA, public."film_category" AS FC
WHERE F."film_id"=FC."film_id" AND CA."category_id"=FC."category_id"
order by (F."film_id");

END;
$$
LANGUAGE plpgsql 

--CALL SP_LlenarDimFilms();