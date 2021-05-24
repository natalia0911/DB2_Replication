-------------------------------------------------------------------------
--- Creado por: Natalia Vargas
--- Fecha creación: 15/05/2021
--- Descripción: Llenar la tabla DimDurationLoan del modelo estrella 
--------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE SP_LlenarDimDurationLoan() 
AS $$
BEGIN 
	INSERT INTO public."DimDurationLoan"
	(
		"rental_duration_days"
	)
	SELECT DISTINCT
		COALESCE((date_part ('day',  R."return_date" - R."rental_date" )) +
		CEILING(date_part ('hour', R."return_date" -R. "rental_date" ) /24),0)

	FROM public."rental" as R
	ORDER BY(1);  -- Order by duration
	

END;
$$
LANGUAGE plpgsql 


--CALL SP_LlenarDimDurationLoan();

--DELETE FROM public."DimDurationLoan";
--TRUNCATE public."DimDurationLoan" RESTART IDENTITY;

