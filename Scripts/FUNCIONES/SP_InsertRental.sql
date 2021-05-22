

-------------------------------------------------------------------------
--- Created by: Natalia Vargas
--- Creation date: 18/05/2021
--- Description: Insert a new rental
--------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION SP_InsertRental(
	   prental_date TIMESTAMP WITHOUT TIME ZONE,
	   pinventory_id INT,
	   pcustomer_id INT,
	   pstaff_id INT,
	   plast_update TIMESTAMP WITHOUT TIME ZONE
	   ) returns void

AS $$
BEGIN 

	INSERT INTO public.rental(
		 rental_date
		,inventory_id
		,customer_id
		,staff_id
		,last_update
	)
	VALUES (
	     prental_date
		,pinventory_id
		,pcustomer_id
		,pstaff_id
		,plast_update
	);
	
END;
$$
LANGUAGE plpgsql 
SECURITY DEFINER

--SELECT SP_InsertRental('2021-08-23 22:50:12',74,418,2,'2006-02-16 02:30:53');
