--Obtener total de hombre y mujeres
SELECT COUNT(CASE gender WHEN 'H' THEN 'H' END) AS h, COUNT(CASE gender WHEN  'M' THEN 'M' END) AS m FROM customers;

--Obtener total de tipos de clientes
SELECT COUNT(CASE type WHEN 'A' THEN 'A' END) as a, COUNT(CASE type WHEN 'B' THEN 'B' END) AS b, COUNT(CASE type WHEN 'C' THEN 'C' END) as c FROM customers;

--Obtener el total de nivel de educacion de los clientes
SELECT
COUNT(CASE school WHEN 1 THEN 1 END) as ninguna,
COUNT(CASE school WHEN 2 THEN 2 END) as primaria,
COUNT(CASE school WHEN 3 THEN 3 END) as secundaria,
COUNT(CASE school WHEN 4 THEN 5 END) as preparatoria,
COUNT(CASE school WHEN 5 THEN 5 END) as licenciatura,
COUNT(CASE school WHEN 6 THEN 6 END) as maestria
FROM customers;

--Obtener el total de nivel de ocupacion de los clientes
SELECT
COUNT(CASE job WHEN 1 THEN 1 END) as estudiante,
COUNT(CASE job WHEN 2 THEN 2 END) as labores_hogar,
COUNT(CASE job WHEN 3 THEN 3 END) as profesional_cuenta_ajena,
COUNT(CASE job WHEN 4 THEN 4 END) as profesional_cuenta_propia,
COUNT(CASE job WHEN 5 THEN 5 END) as desempleado,
COUNT(CASE job WHEN 6 THEN 6 END) as directivo,
COUNT(CASE job WHEN 7 THEN 7 END) as cargos_intermedios,
COUNT(CASE job WHEN 8 THEN 8 END) as trabajadores_gobierno,
COUNT(CASE job WHEN 9 THEN 9 END) as trabajadores_educacion,
COUNT(CASE job WHEN 10 THEN 10 END) as trabajadores_salud,
COUNT(CASE job WHEN 11 THEN 11 END) as fuerzas_armadas,
COUNT(CASE job WHEN 12 THEN 12 END)  as otros
FROM customers;

--Obtener el total de los estados civil de los clientes
SELECT
COUNT(CASE status_civil WHEN 1 THEN 1 END) as soltero,
COUNT(CASE status_civil WHEN 2 THEN 2 END) as union_libre,
COUNT(CASE status_civil WHEN 3 THEN 3 END) as casado,
COUNT(CASE status_civil WHEN 4 THEN 4 END) as divorciado,
COUNT(CASE status_civil WHEN 5 THEN 5 END) as viudo
FROM customers;

SELECT DATE_FORMAT(FROM_DAYS(TO_DAYS(NOW())-TO_DAYS(birthdate)), '%Y')+0 AS age FROM customers
SELECT date_part('year',age( birthdate )) AS age FROM customers;

