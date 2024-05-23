-- 1

SELECT *
FROM pokemon
WHERE hp = 0 AND defensa=0 AND ataque=0
UNION
SELECT *
FROM pokemon
WHERE hp = 15 AND defensa = 15 AND ataque=15;

-- 2

SELECT DISTINCT codigo
FROM pokemon
WHERE EXTRACT(YEAR FROM pokemon.fecha) BETWEEN 2016 AND 2018
ORDER BY codigo desc ;

-- 3
SELECT apodo, nro
FROM pokemon
WHERE codigo IN
      (SELECT codigo
       FROM pokemon
       WHERE EXTRACT(YEAR FROM fecha) = 2016)
ORDER BY nro, apodo DESC;

-- 4

SELECT AVG(nivel)
FROM entrenador
WHERE codigo IN
      (SELECT DISTINCT codigo
       FROM pokemon
       WHERE sexo='N');

-- 5

SELECT tipo, COUNT(tipo)
FROM tiene
JOIN (SELECT nro
FROM pokedex
EXCEPT
SELECT DISTINCT nro
FROM pokemon ORDER BY nro)AS tbl1 USING (nro)
GROUP BY tipo
ORDER BY count(tipo) DESC
LIMIT 5;

-- 6

SELECT p2.codigo, p1.codigo, count(*)
FROM pokemon p1, pokemon p2
WHERE p1.codigo>p2.codigo
AND p1.nro = p2.nro
GROUP BY (p1.codigo, p2.codigo)
HAVING COUNT(*) > 5
ORDER BY p1.codigo desc ;
