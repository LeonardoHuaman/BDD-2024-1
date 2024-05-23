-- 1. Los arrendatarios de la casa que queda en Calle ’714-8965 Sem Avenue’ y ditrito ’Iqaluit’.


SELECT *
FROM arrendatario
WHERE dni_a IN (
    SELECT dni_a
    FROM arrienda
    WHERE id_casa IN (
            SELECT id_casa
            FROM casa
            WHERE calle='714-8965 Sem Avenue' AND distrito = 'Iqaluit'));

-- LIKE NO ES LO MISMO QUE IGUAL, LIKE NO ES LO MISMO QUE EL IGUAL, SIEMPRE ES RECOMEDABLE EL USO DE IGUAL POR ENCIMA DEL LIKE

-- 2. La deuda total que tienen los arrendatarios con Ignacia Fletcher.

SELECT sum(deuda) AS suma_deuda_Ignacia
FROM arrienda
WHERE id_casa IN
    (SELECT id_casa
     FROM casa
     WHERE dni_d IN
      (SELECT dni_d
       FROM dueno
       WHERE nombre LIKE '%Ignacia%' AND apellidos LIKE '%Fletcher%'));

-- 3. Segundo dueño que tiene más dueda

SELECT *
FROM
(SELECT deuda, dni_d, nombre, apellidos
FROM dueno
INNER JOIN
(SELECT dni_d, deuda
FROM casa C
INNER JOIN
    (SELECT id_casa , sum(deuda) AS deuda
    FROM arrienda
    GROUP BY id_casa) AS tb_1 USING (id_casa)) AS tb_2 USING(dni_d)
ORDER BY deuda DESC
Limit 2) AS tbl_3
ORDER BY deuda
LIMIT 1;

-- 4. Lista de todas las personas en la base de datos.

SELECT nombre, apellidos
FROM arrendatario
UNION
SELECT nombre, apellidos
FROM dueno;

-- 5. Indique los dueños que poseen tres o más casas

SELECT dni_d, nombre, apellidos
FROM dueno
JOIN (
    SELECT dni_d
    FROM casa
    GROUP BY dni_d
    HAVING count(dni_d)>=3) AS tbl_4
USING(dni_d);

-- 6. Lista de los dueños que no tengan deudores en ninguna de sus casas.

SELECT dni_d, nombre, apellidos
FROM Dueno d
LEFT JOIN Casa c USING (dni_d)
LEFT JOIN Arrienda a ON c.id_casa = a.id_casa AND a.deuda > 0
WHERE a.id_casa IS NULL;

-- 7. El promedio de arrendatarios por casa.

SELECT AVG(num_arrendatarios) AS promedio_arrendatarios
FROM (
    SELECT id_casa, COUNT(dni_a) AS num_arrendatarios
    FROM Arrienda
    GROUP BY id_casa
) AS tbl_7;



-- 8. El máximo número de arrendatarios en una casa.

SELECT MAX(num_arrendatarios) AS max_arrendatarios
FROM (
    SELECT id_casa, COUNT(dni_a) AS num_arrendatarios
    FROM Arrienda
    GROUP BY id_casa
) AS tbl8;

-- 9. El número de casas de cada dueño.

SELECT *
FROM (
    SELECT dni_d, COUNT(id_casa) AS num_casas
    FROM casa
    GROUP BY dni_d
) AS tbl_9;

-- 10. El total de tel ́efonos de cada arrendador.

SELECT dni_d, num_telefonos
FROM dueno
JOIN

(SELECT dni, COUNT(telefonos) AS num_telefonos
    FROM telefonos
    GROUP BY dni
) AS tbl_10 ON dni = dueno.dni_d;


-- 11. El dueño/s que posee más casas.

SELECT *
FROM dueno
JOIN(SELECT *
     FROM
         (SELECT dni_d, COUNT(id_casa) AS num_casas
          FROM casa
          GROUP BY dni_d
          ) AS tbl_11
     ORDER BY num_casas desc
     LIMIT 2) AS tbl_12 USING (dni_d);