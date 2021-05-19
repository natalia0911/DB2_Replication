
-------------------------------------------------------------------------
--- Creado por: Natalia Vargas
--- Fecha creación: 15/05/2021
--- Descripción: Llenar la tabla DimDate del modelo estrella 
--------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE SP_LlenarDimDate() 
AS $$
BEGIN 
INSERT INTO public."DimDate"
(
	  "year"
	, "month"
	, "day"
)
SELECT
	 EXTRACT(YEAR FROM R."rental_date")
	,EXTRACT(MONTH FROM R."rental_date")
	,EXTRACT(DAY FROM R."rental_date")

FROM public."rental" as R
GROUP BY (EXTRACT(YEAR FROM R."rental_date"),EXTRACT(MONTH FROM R."rental_date"),EXTRACT(DAY FROM R."rental_date"));
END;
$$
LANGUAGE plpgsql 



--CALL SP_LlenarDimDate();

