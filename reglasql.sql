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

--Obtener las ventas de un año
SELECT COUNT(*) FROM sales,times WHERE sales.id_time = times.id AND times.year = '2015';
--Obtener las ventas de un mes determinado
SELECT COUNT(*) FROM sales,times WHERE sales.id_time = times.id AND times.month = '1';
--Obtener las ventas por dia y mes
SELECT COUNT(*) FROM sales,times WHERE sales.id_time = times.id AND times.day = '1' AND times.month = '1';

--Obtener las ventas de cada mes:
SELECT
COUNT(CASE times.month WHEN 1 THEN 1 END) as enero,
COUNT(CASE times.month WHEN 2 THEN 2 END) as febrero,
COUNT(CASE times.month WHEN 3 THEN 3 END) as marzo,
COUNT(CASE times.month WHEN 4 THEN 4 END) as abril,
COUNT(CASE times.month WHEN 5 THEN 5 END) as mayo
FROM sales,times
WHERE sales.id_time = times.id;

--Obtener los emails archivados y los enviados
SELECT
COUNT(*) as totales,
COUNT(CASE status WHEN 'Archivado' THEN 'Archivado' END) as archivados,
COUNT(CASE status WHEN 'Enviado' THEN 'Enviado' END) as enviados,
COUNT(CASE status WHEN 'Fallido' THEN 'Fallido' END) as fallidos
FROM emails;

--Obtener las campañas activas, finalizadas y en espera
SELECT
COUNT(*) as totales,
COUNT(CASE status WHEN 'Activa' THEN 'Activa' END) as activas,
COUNT(CASE status WHEN 'Finalizada' THEN 'Finalizada' END) as finalizadas,
COUNT(CASE status WHEN 'En espera' THEN 'En espera' END) as en_espera
FROM campaings;

--Obtener los clientes actuales y contacto
SELECT
COUNT(*) as totales,
COUNT(CASE status WHEN 'Actual' THEN 'Actual' END) as clientes
FROM customers;

--Obtener las ventas de cada cliente
SELECT DISTINCT products.name,products.img FROM sales,customers,products WHERE sales.id_customer = customers.id AND sales.id_product = products.id AND customers.id = 32;

--Obtiene las categorias que mas compra un cliente
SELECT DISTINCT categories.name FROM sales,customers,products,categories WHERE sales.id_customer = customers.id AND sales.id_product = products.id AND products.category = categories.id AND customers.id = 32;

--Segmentación ABC
--Obtengo el ID de los clientes
SELECT id FROM customers;
--Cuento las ventas de cada cliente
SELECT COUNT(*) FROM sales WHERE id_customer = 1;
--Si sus ventas son 0
UPDATE customers SET status = 'Potencial' WHERE id = 1;
--Si no es cliente actual
UPDATE customers SET status = 'Actual' WHERE id = 1;
--Obtener todos los clientes actuales que ha hecho compras //AND status = 'Actual'
SELECT customers.id, customers.name, SUM(sales.sub_total) AS sales FROM customers,sales WHERE sales.id_customer = customers.id GROUP BY customers.id;

SELECT SUM(sub_total) AS total FROM sales;

SELECT
  t1.id,
  t1.year,
  t1.name,
  t1.sales
FROM(
    SELECT
        customers.id AS id,
        times.year AS year,
        customers.name,
        SUM(sales.sub_total) sales
    FROM sales,customers,times
        WHERE sales.id_customer = customers.id
        AND sales.id_time = times.id
    GROUP BY
        customers.id,
        times.year
) t1
  GROUP BY
    t1.year,
    t1.name,
    t1.sales
  ORDER BY
    t1.sales DESC;

--Obtener las edades /MYSQL
SELECT
  t1.id,
  t1.age
FROM(
    SELECT
      DATE_FORMAT(FROM_DAYS(TO_DAYS(NOW())-TO_DAYS(birthdate)), '%Y')+0 AS age,
      id
    FROM
      customers
) t1
  ORDER BY
    t1.age DESC;

--Obtener las edades /PGSQL
SELECT
  t1.id,
  t1.age
FROM(
    SELECT
      date_part('year',age( birthdate )) AS age,
      id
    FROM
      customers
) t1
  ORDER BY
    t1.age DESC;

--Obtener la segmetación por edad /MYSQL
SELECT
  COUNT(*) as total,
  COUNT(CASE WHEN (t1.age BETWEEN 1 AND 12) THEN 1 END) as ninez,
  COUNT(CASE WHEN (t1.age BETWEEN 13 AND 18) THEN 2 END) as jovenes,
  COUNT(CASE WHEN (t1.age BETWEEN 18 AND 35) THEN 3 END) as jovenes_adultos,
  COUNT(CASE WHEN (t1.age BETWEEN 35 AND 60) THEN 4 END) as adultos,
  COUNT(CASE WHEN (t1.age > 60) THEN 5 END) as vejez
FROM(
    SELECT
      DATE_FORMAT(FROM_DAYS(TO_DAYS(NOW())-TO_DAYS(birthdate)), '%Y')+0 AS age
    FROM
      customers
) t1;


--Obtener la segmetación por edad /PGSQL
SELECT
  COUNT(*) as total,
  COUNT(CASE WHEN (t1.age BETWEEN 1 AND 12) THEN 1 END) as ninez,
  COUNT(CASE WHEN (t1.age BETWEEN 13 AND 18) THEN 2 END) as jovenes,
  COUNT(CASE WHEN (t1.age BETWEEN 18 AND 35) THEN 3 END) as jovenes_adultos,
  COUNT(CASE WHEN (t1.age BETWEEN 35 AND 60) THEN 4 END) as adultos,
  COUNT(CASE WHEN (t1.age > 60) THEN 5 END) as vejez
FROM(
    SELECT
      date_part('year',age( birthdate )) AS age
    FROM
      customers
) t1;
