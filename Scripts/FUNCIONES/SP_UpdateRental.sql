


-------------------------------------------------------------------------
--- Created by: Natalia Vargas
--- Creation date: 20/05/2021
--- Description: Update a rental, puting the return date
--------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION SP_UpdateRental(
	   prental_id   INT,
       preturn_date TIMESTAMP WITHOUT TIME ZONE
	   )returns void

AS $$
BEGIN 
--START TRANSACTION 

    UPDATE public."rental" AS R
    SET
            return_date = preturn_date
           
    WHERE R.rental_id = prental_id;
	
--COMMIT;
--EXCEPTION WHEN OTHERS THEN
--ROLLBACK;

END;
$$
LANGUAGE plpgsql 
SECURITY DEFINER

--SELECT SP_UpdateRental(16050,'2022-08-31 16:42:22');