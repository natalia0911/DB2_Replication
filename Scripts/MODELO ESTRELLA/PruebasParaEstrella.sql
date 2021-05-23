

select count("rental_id") from public."rental";

select * from public."rental" where "rental_id"=4591;

select count("payment_id") from public."payment";

select * from public."payment" where "rental_id"=4591;

SELECT COUNT(1) FROM ( SELECT COUNT(1) AS SU FROM public."payment" AS P GROUP BY (P."rental_id") ) AS CONSULTA

(SELECT P."rental_id" FROM public."payment" AS P GROUP BY (P."rental_id") AS ALGO