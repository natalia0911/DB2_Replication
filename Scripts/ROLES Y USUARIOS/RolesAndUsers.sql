

SELECT * FROM pg_catalog.pg_roles;
SELECT * FROM pg_catalog.pg_database;

---------------------Create roles---------------------
CREATE ROLE EMP;
CREATE ROLE ADMIN;

---------------------Create users---------------------
CREATE USER empleado1 WITH PASSWORD 'empleado1pw';
CREATE USER administrador1 WITH PASSWORD 'administrador1pw';

----------------------Assign roles----------------------
GRANT EMP TO empleado1;
GRANT ADMIN TO administrador1;




GRANT SELECT, UPDATE, INSERT ON mitabla TO pedro; 



-------------------------------------------------------------
CREATE USER EJEMPLO WITH PASSWORD 'EJEMPLOPW';
CREATE ROLE EJEMPLO2;
GRANT ALL ON rental2 TO EJEMPLO;
