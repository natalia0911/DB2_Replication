
--------------------------------------------------------------------------------------------------------------------------------------------------
--- Created by: Natalia Vargas
--- Creation date: 21/03/2021
--- Description: Dar el número de alquileres y el monto cobrado, por duración del préstamo
---------------------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION SP_RentalNumerByLoan() 
	   returns TABLE
		(  
	    duration int
       ,quantity BIGINT
       ,totalSum NUMERIC 
	   )

AS $$
BEGIN 
	RETURN QUERY
	SELECT 
	     DDL."rental_duration_days"
		,COUNT(1)
		,SUM(amount_charged)
		
		FROM public."Rentals" AS R INNER JOIN public."DimDurationLoan" AS DDL ON R."DimDurationLoan_id"=DDL."duration_id"
		GROUP BY(DDL."rental_duration_days")
		ORDER BY (DDL."rental_duration_days");

END;
$$
LANGUAGE plpgsql 

--SELECT SP_RentalNumerByLoan();

-- 	dar el número de alquileres y el monto cobrado, por duración del préstamo
select (date_part ('day',  return_date - rental_date )) +
        ceiling(date_part ('hour', return_date - rental_date ) /24) as duracion,
        count(*), sum(amount)
from rental r inner join payment p on r.rental_id = p.rental_id
where return_date is not null
group by duracion
order by duracion;



