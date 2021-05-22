
-------------------------------------------------------------------------
--- Created by: Natalia Vargas
--- Creation date: 21/03/2021
--- Description: Insert a new customer
--------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION SP_InsertCustomer(
       pstore_id INT,
       pfirst_name CHARACTER VARYING,
       plast_name CHARACTER VARYING,
       pemail CHARACTER VARYING,
       paddress_id INT,
	   pactive_bool BOOLEAN,
       pcreate_date DATE,
	   plast_update TIMESTAMP WITHOUT TIME ZONE,
	   active INT 
	   ) returns void

AS $$
BEGIN 
INSERT INTO public.customer(
	 --customer_id
	 store_id
	,first_name
	,last_name
	,email
	,address_id
	,activebool
	,create_date
	,last_update
	,active
)
	VALUES 
	(
	 pstore_id
	,pfirst_name
	,plast_name
	,pemail
	,paddress_id
	,pactive_bool
	,pcreate_date
	,plast_update
	,active
	);

END;
$$
LANGUAGE plpgsql 
SECURITY DEFINER



--SELECT SP_InsertCustomer(1,'Natalia','Vargas','nat024vargas@gmail.com',90,true,'2021-05-19','2021-05-26 14:49:45.738',1);


