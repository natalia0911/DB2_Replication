

--------------------------------------------------------------------------------------------------------------------------------------------------
--- Created by: Natalia Vargas
--- Creation date: 21/03/2021
--- Description: Para un mes dado, sin importar el año, dar para cada categoría de película el número de alquileres realizados
---------------------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION SP_RentalsNumber(
       pmonth_num INT
	   ) 
	   returns TABLE
		(  
	    category_name  CHARACTER VARYING
       ,month INT
       ,sum NUMERIC 
	   )

AS $$
BEGIN 
	RETURN QUERY
	SELECT 
		 DF."category_name"
		,DD."month"
		,SUM(loaned_units)

		FROM public."Rentals" AS R INNER JOIN public."DimDate" AS DD ON R."DimDate_id"=DD."date_id" and DD."month"=pmonth_num
		INNER JOIN public."DimFilms" AS DF ON R."DimFilms_id"=DF."film_id"
		GROUP BY(DF."category_name",DD."month");

END;
$$
LANGUAGE plpgsql 




--SELECT SP_RentalsNumber(7);


-- para un mes dado, sin importar el año, dar para cada categoría de película el número de alquileres realizados

select  date_part('month',rental_date) as mes, c.name,
        count(*) as num_alquileres
from rental r inner join inventory i      on r.inventory_id = i.inventory_id
              inner join film_category fc on i.film_id = fc.film_id
              inner join category c       on fc.category_id = c.category_id
where date_part('month',rental_date)=7
group by mes, c.name
order by mes, c.name;


