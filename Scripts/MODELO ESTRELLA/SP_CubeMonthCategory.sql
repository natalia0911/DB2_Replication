
--------------------------------------------------------------------------------------------------------------------------------------------------
--- Created by: Natalia Vargas
--- Creation date: 22/03/2021
--- Description: Hacer un cubo por año y categoría de película para el número de alquileres y el monto cobrado
---------------------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION SP_CubeMonthCategory()
    RETURNS TABLE
	(
	   year integer
	 , category_name character varying
	 , count_loans bigint
	 , sum_amount numeric
	) 
    

AS $$
BEGIN 
	RETURN QUERY
	SELECT 
		 DD."year"
		,DF."category_name"
		,COUNT(1)
		,SUM(R."amount_charged")

		FROM public."Rentals" AS R INNER JOIN public."DimDate" AS DD ON R."DimDate_id"=DD."date_id" 
		INNER JOIN public."DimFilms" AS DF ON R."DimFilms_id"=DF."film_id"
		GROUP BY CUBE(DD."year",DF."category_name")
		ORDER BY (DD."year",DF."category_name");

END;
$$
LANGUAGE plpgsql 

-- SELECT SP_CubeMonthCategory()
--	hacer un cubo por año y categoría de película para el número de alquileres y el monto cobrado
 
select  date_part('year',rental_date) as anno, c.name,
        count(*) as num_alquileres,
        sum(p.amount) as monto_cobrado
       --, r.rental_id, i.inventory_id, i.film_id, fc.category_id, rental_date
from rental r inner join inventory i      on r.inventory_id = i.inventory_id
              inner join film_category fc on i.film_id = fc.film_id
              inner join category c       on fc.category_id = c.category_id
              inner join payment  p       on r.rental_id = p.rental_id
group by cube (anno, c.name)
order by anno, c.name;

