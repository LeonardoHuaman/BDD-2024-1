-- 1. Averigue la suma total de el valor de las mediciones con unidad ”Pa” y el sensor se ubique geográficamente en ”Barranco”.

SELECT sum(valor)
FROM sensor
JOIN (SELECT id, valor
FROM medicion
WHERE unidad = 'Pa')AS tbl1 USING (id)
WHERE ubicacion = 'Barranco';

-- 2. Busque cuál es el técnico que ha dado mantenimiento al sensor instalado más recientemente, y en caso existan varios técnicos, aquel de mayor edad.

SELECT t.codigo, t.empresa, t.genero, t.nacimiento
FROM tecnico t
INNER JOIN mantenimiento m USING (codigo)
ORDER BY t.nacimiento ASC
LIMIT 1;

-- 3. Calcule el porcentaje de tipos de sensor instalados en el rango de años de 2020 al 2024, ordenado descendentemente.

SELECT tipo, (count(*) * 1.0)/(SELECT count(*) FROM sensor WHERE anho BETWEEN 2020 AND 2024) AS porcentaje
FROM sensor
WHERE anho BETWEEN 2020 AND 2024
GROUP BY tipo
ORDER BY porcentaje DESC;

-- 4. Disponga de manera ordenada los sensores de manera ascendente por cantidad de mantenimientos y en caso de
-- empate de manera descendente por cantidad de mediciones.

SELECT *
FROM (SELECT id, count(*) AS mantenimiento
FROM mantenimiento
GROUP BY id) AS tbl1
INNER JOIN (SELECT id, count(*) AS mediciones
FROM medicion
GROUP BY id) AS tbl2 USING (id)
ORDER BY mantenimiento, mediciones DESC;

-- 5. El código de las técnicas mujeres cuya edad sea mayor al promedio de todas las edades de las técnicas mujeres.
-- (Obs: utilice la función AGE para hallar la edad y EXTRACT para obtener los años).

SELECT codigo, nacimiento
FROM tecnico
WHERE EXTRACT(year FROM AGE(nacimiento)) > (SELECT AVG(EXTRACT(year FROM AGE(nacimiento)))
                                            FROM tecnico
                                            WHERE genero = 'F')
AND genero = 'F';

-- 6. Fecha de instalación y id de todos los sensores que han recibido entre 3 y 5 mantenimientos y tengan más de 3 mediciones.

SELECT anho, id, mantenimiento, mediciones
FROM sensor
INNER JOIN (SELECT *
FROM (SELECT id, count(*) AS mantenimiento
FROM mantenimiento
GROUP BY id) AS tbl1
INNER JOIN (SELECT id, count(*) AS mediciones
FROM medicion
GROUP BY id) AS tbl2 USING (id)
WHERE mantenimiento BETWEEN 3 AND 5
AND mediciones>3) AS tbl_3 USING (id);

-- 7. Cantidad de mantenimientos que han hecho por año los técnicos, ordenado descendentemente por la cantidad.

SELECT id, count(extract(YEAR FROM fecha)) AS conteo
FROM mantenimiento
GROUP BY id
ORDER BY conteo DESC;

-- 8. Halla el top 3 de tipo de sensor que ha recibido mayor cantidad de mantenimiento durante el año 2023 por técnicos
-- que trabajan para la empresa ReparacionesSYV. El resultado debe mostrar el tipo y la cantidad de forma descendente.

SELECT tipo, count(*)
FROM sensor
JOIN (SELECT codigo, id, fecha
      FROM mantenimiento
          JOIN (SELECT codigo
                FROM tecnico
                WHERE empresa = 'ReparacionesSYV') AS tbl1
          USING (codigo)) AS tbl2
USING (id)
GROUP BY tipo;

SELECT tipo, count(*) AS cantidad
FROM sensor
JOIN
(SELECT codigo, id, extract(YEAR FROM fecha) AS fecha_mant
FROM mantenimiento
JOIN (SELECT codigo
      FROM tecnico
      WHERE empresa = 'ReparacionesSYV') AS tbl1 USING (codigo)
WHERE extract(YEAR FROM fecha)  = 2023) AS tbl2 USING (id)
GROUP BY tipo
ORDER BY cantidad DESC
LIMIT 3;

-- 9. Investigue todos los sensores que hayan tenido al menos una medición y un mantenimiento
-- la misma fecha (solo considere día, mes y año).



-- 10. Encuentre la cantidad total de sensores instalados y la
-- suma total de los valores de las mediciones de los sensores por cada género.