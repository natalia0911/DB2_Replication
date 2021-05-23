


--------------------------------------------------------------------------------------------------------------------------------------------------
--- Created by: Natalia Vargas
--- Creation date: 22/03/2021
--- Description: Hacer un rollup por año y mes para el monto cobrado por alquileres
---------------------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION SP_RollUpMonthYear() 
	   returns TABLE
		(  
	    year  INT
       ,month INT
       ,sum NUMERIC 
	   )

AS $$
BEGIN 
	RETURN QUERY
	SELECT 
		 DD."year"
		,DD."month"
		,SUM(amount_charged)

		FROM public."Rentals" AS R INNER JOIN public."DimDate" AS DD ON R."DimDate_id"=DD."date_id" 
		GROUP BY ROLLUP(DD."year",DD."month");

END;
$$
LANGUAGE plpgsql 




--SELECT SP_RollUpMonthYear();

-- hacer un rollup por año y mes para el monto cobrado por alquileres
-- 2005	 5	 0   Da esta fila distinta

select date_part('year',  rental_date) as anno,
       date_part('month', rental_date) as mes,
       sum(amount)
from rental r inner join payment p on r.rental_id = p.rental_id
group by rollup (anno, mes)
order by anno, mes

