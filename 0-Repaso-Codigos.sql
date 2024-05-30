-- SELECT : SELECCION

SELECT *
FROM users;

SELECT name
FROM users;

SELECT user_id, name
FROM users;

-- DISTINCT : TRAE LOS VALORES DISTINTOS

SELECT DISTINCT *
FROM users;

SELECT DISTINCT age
FROM users;

-- WHERE : CONDICION (SIGMA)

SELECT *
FROM users
WHERE age = 19;

SELECT DISTINCT *
FROM users
WHERE age = 25;

-- ORDER BY  (ORDENAR DEF:ASC DESC:DESCENDENTE)

SELECT *
FROM users
ORDER BY age;

SELECT *
FROM users
ORDER BY name DESC;

-- LIKE

SELECT *
FROM users
WHERE name LIKE 'L%';

-- AND, OR, NOT

SELECT *
FROM users
WHERE NOT name LIKE 'L%'
AND age<30;

SELECT *
FROM users
WHERE NOT name LIKE 'L%'
OR age>30;

-- LIMIT

SELECT *
FROM users
LIMIT 2;

SELECT *
FROM users
WHERE name LIKE 'L%'
LIMIT 1;

-- NULL

SELECT *
FROM users
WHERE email IS NOT NULL;

-- MIN AND MAX

SELECT MAX(age)
FROM users;

SELECT MIN(age)
FROM users;

SELECT *
FROM users
WHERE age IN(
    SELECT MAX(age)
    FROM users
);

-- COUNT : CUENTA CUANTOS VALORES HAY EN ESA COLUMNA

SELECT COUNT(*)
FROM users;

SELECT DISTINCT COUNT(age)
FROM users;

-- SUM : SUMAR TODA UNA COLUMNA (SOLO NUMEROS ENTEROS O DECIMALES)

SELECT SUM(age)
FROM users;

-- AVG : CONSIGUE LA MEDIA DE UNA COLUMNA (SOLO NUMEROS ENTEROS O DECIMALES)

SELECT AVG(age)
FROM users;

-- IN

SELECT *
FROM users
WHERE age IN (SELECT MAX(age) FROM users);

SELECT *
FROM users
WHERE name IN ('Leonardo', 'Pedro', 'Luis');

-- BETWEEN

SELECT *
FROM users
WHERE age BETWEEN 19 AND 25;

SELECT *
FROM users
WHERE name BETWEEN 'A%' AND 'L%';

-- ALIAS

SELECT name AS nombre, age AS edad
FROM users;

SELECT AVG(age) AS promedio
FROM users;

-- CONCAT

SELECT CONCAT(name, ' ',surname) AS Nombre_y_Apellidos
FROM users;

-- GROUP BY

SELECT age, count(age)
FROM users
WHERE age>25
GROUP BY age;

-- HAVING

SELECT COUNT(age)
FROM users
HAVING COUNT(age) > 0;

-- CASE

SELECT
    name,
    age,
    CASE
        WHEN age < 25 THEN 'Menor de 25'
        ELSE 'Es mayor de 25'
    END AS categoria_edad
FROM
    users;

-- COALESCE

SELECT name,  COALESCE(age, 0) AS age
FROM users;

-- INSERT
INSERT INTO users VALUES (13, 'Ariana', 'Gutierrez', 21, '2019-07-12','ariana.gutierrez@gmail.com');
INSERT INTO users (user_id, name, surname, age, init_date,email) VALUES (12, 'Lorena', 'Mendez', 18, '2021-12-25','lorena.mendez@gmail.com');
SELECT *
FROM users
WHERE name = 'Lorena';
