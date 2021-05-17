
-------------------------------------------------------------------------
--- Creado por: Natalia Vargas
--- Fecha creación: 15/05/2021
--- Descripción: Llenar la tabla DimPlace del modelo estrella 
--------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE SP_LlenarDimPlace() 
AS $$
BEGIN 
INSERT INTO public."DimPlace"
(
	 "district_name"
	,"country_name"
	,"store_id"
	,"city_name"
	,"postal_code"
)
SELECT DISTINCT
	 AD."district"
	,CO."country"
	,ST."store_id"  -- este hace que se convierta en 2 unicas filas, así que no sé.
	,CI."city"
	,AD."postal_code" 
	 
FROM public."country" AS CO, public."city" AS CI, public."address" AS AD, public."store" AS ST
WHERE AD."city_id"=CI."city_id" and CI."country_id"=CO."country_id" and AD."address_id"=ST."address_id";

END;
$$
LANGUAGE plpgsql 

--CALL SP_LlenarDimPlace();