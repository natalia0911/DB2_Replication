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
	-- Puede ser así o where return_date = NOT NULL
	COALESCE(DATE_PART('day', R."return_date"::timestamp - R."rental_date"::timestamp),0)  
	 
FROM public."rental" as R;

END;
$$
LANGUAGE plpgsql 


--CALL SP_LlenarDimDurationLoan();