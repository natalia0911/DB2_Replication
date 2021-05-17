
-------------------------------------------------------------------------
--- Creado por: Natalia Vargas
--- Fecha creación: 15/05/2021
--- Descripción: Llenar la tabla rentals del modelo estrella 
--------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE SP_LlenarRentals() 
AS $$
BEGIN 


	CREATE TEMP TABLE tempRentals AS (
	SELECT 
		  DD."date_id"      AS "DimDate_id"         --- Pk de DimDate, es identity
		, F."film_id"       AS "DimFilms_id"        --- Pk de Film, no es identity
		, DP."store_id"     AS "DimPlace_id"        --- Pk de DimPlace, es identity con place_id   --- De momento sí es por store_id ENTONCES NO TOCA COMPARAR CON DIMPLACE, DE LO CONTRARIO SÍ
		, L."language_id"   AS "DimLanguagues_id"   --- Pk de Languages, no es identity
		, DDl."duration_id" AS "DimDurationLoan_id" --- Pk de DimDurationLoan, es identity
		, PY."amount"		AS "amount_charged"     --- Monto de un alquiler
		--- Creo que las unidades no existe, es alquiler por cada una


	FROM public."rental" as R, public."film" as F,public."language" as L, public."country" AS CO, public."city" AS CI, 
		public."address" AS AD, public."DimDate" AS DD, public."DimDurationLoan" AS DDL, public."DimPlace" AS DP,
		public."payment" AS PY,public."inventory" AS I, public."customer" CU, public."store" AS ST
		
		    --Que la fecha de rental y DD sean la misma
	WHERE (DD."year"=EXTRACT(YEAR FROM R."rental_date") AND DD."month"=EXTRACT(MONTH FROM R."rental_date") AND DD."day"=EXTRACT(DAY FROM R."rental_date"))
		AND (F."film_id"=I."film_id" AND R."inventory_id"=I."inventory_id") AND (R."customer_id"=CU."customer_id" AND CU."address_id"=AD."address_id" AND
		ST."address_id"=AD."address_id" AND AD."city_id"=CI."city_id" AND CI."country_id"=CO."country_id") AND (F."language_id"=L."language_id") AND 
		(COALESCE(DATE_PART('day', R."return_date"::timestamp - R."rental_date"::timestamp),0)=DDL."rental_duration_days") AND (R."rental_id"=PY."rental_id")

	);


	INSERT INTO public."Rentals"
	(
		  "DimDate_id"
		, "DimFilms_id"
		, "DimPlace_id"
		, "DimLanguagues_id"
		, "DimDurationLoan_id"
		, "amount_charged"
		, "loaned_units"
	)
	SELECT 
		  TP."DimDate_id"
		, TP."DimFilms_id"
		, TP."DimPlace_id"
		, TP."DimLanguagues_id"
		, TP."DimDurationLoan_id"
		, SUM("amount_charged")
		, COUNT(1)   -- CANTIDAD DE ALQUILERES
	FROM tempRentals AS TP
	GROUP BY(TP."DimDate_id",TP."DimFilms_id",TP."DimPlace_id",TP."DimLanguagues_id",TP."DimDurationLoan_id");

END;
$$
LANGUAGE plpgsql 




--DROP TABLE temprentals;

--CALL SP_LlenarRentals();

