
-------------------------------------------------------------------------
--- Creado por: Natalia Vargas
--- Fecha creación: 15/05/2021
--- Descripción: Llenar la tabla rentals del modelo estrella 
--------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE SP_LlenarRentals() 
AS $$
BEGIN 

	--Agrupar los pagos y sus montos, pues se trata de la misma renta
	CREATE TEMP TABLE tempPayment AS(
	SELECT
		  PY."rental_id"
		, SUM(PY."amount") AS amount
	FROM public."payment" AS PY
	GROUP BY(PY."rental_id")
		
	);

	CREATE TEMP TABLE tempRentals AS (
	SELECT 
		  DD."date_id"      AS "DimDate_id"         --- Pk de DimDate, es identity
		, F."film_id"       AS "DimFilms_id"        --- Pk de Film, no es identity
		, DP."store_id"     AS "DimPlace_id"        --- Pk de DimPlace, es identity con place_id   --- De momento sí es por store_id ENTONCES NO TOCA COMPARAR CON DIMPLACE, DE LO CONTRARIO SÍ
		, L."language_id"   AS "DimLanguagues_id"   --- Pk de Languages, no es identity
		, DDl."duration_id" AS "DimDurationLoan_id" --- Pk de DimDurationLoan, es identity
		, PY."amount"		AS "amount_charged"     --- Monto de un alquiler
		--- Creo que las unidades no existe, es alquiler por cada una


	FROM public."rental" as R INNER JOIN public."DimDate" AS DD ON (DD."year"=EXTRACT(YEAR FROM R."rental_date") AND DD."month"=EXTRACT(MONTH FROM R."rental_date")
	AND DD."day"=EXTRACT(DAY FROM R."rental_date"))  ---DD."date_id"
	INNER JOIN public."inventory" AS I ON R."inventory_id"=I."inventory_id" INNER JOIN  public."film" as F ON F."film_id"=I."film_id" --F."film_id"
	INNER JOIN public."store" AS ST ON I."store_id"=ST."store_id" INNER JOIN public."DimPlace" AS DP ON DP."store_id"=ST."store_id"  --DP."store_id"
	INNER JOIN public."language" as L ON F."language_id"=L."language_id" INNER JOIN public."DimLanguages" AS DL ON L."language_id"=DL."language_id" --L."language_id"
	INNER JOIN public."DimDurationLoan" AS DDL ON 
		COALESCE((date_part ('day',R."return_date" - R."rental_date"))
	    +CEILING(date_part ('hour',R."return_date" -R. "rental_date" )/24),0)=DDL."rental_duration_days"  --L."language_id" --DDl."duration_id"
	LEFT JOIN tempPayment AS PY ON R."rental_id"=PY."rental_id"  --PY."amount"

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
		, COALESCE(SUM("amount_charged"),0)
		, COUNT(1)   -- CANTIDAD DE ALQUILERES
	FROM tempRentals AS TP
	GROUP BY(TP."DimDate_id",TP."DimFilms_id",TP."DimPlace_id",TP."DimLanguagues_id",TP."DimDurationLoan_id");

END;
$$
LANGUAGE plpgsql 




--DROP TABLE temprentals;
--DROP TABLE tempPayment;

--DELETE FROM public."Rentals";
--TRUNCATE TABLE public."Rentals" RESTART IDENTITY;

--CALL SP_LlenarRentals();



