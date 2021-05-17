
-------------------------------------------------------------------------
--- Creado por: Natalia Vargas
--- Fecha creación: 15/05/2021
--- Descripción: Llenar la tabla DimLanguages del modelo estrella 
--------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE SP_LlenarDimLanguages() 
AS $$
BEGIN 
INSERT INTO public."DimLanguages"
(
	 "language_id"
	,"language_name"
)
SELECT DISTINCT 
	 L."language_id"
	,L."name"
	 
FROM public."language" as L;
END;
$$
LANGUAGE plpgsql 

--CALL SP_LlenarDimLanguages();