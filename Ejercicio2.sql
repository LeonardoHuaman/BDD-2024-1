-- 1. ¿Cuáles son los nombres de todos los artistas masculinos?

SELECT nombre
FROM artista
WHERE sexo = 'M';

-- 2. ¿Qué canciones fueron lanzadas antes de 1985?

SELECT *
FROM cancion
WHERE fecha < '1985-01-01';

-- 3. ¿Cuál es la duración de la canción "gertrude hamlet"?

SELECT titulo, duracion
FROM cancion
WHERE titulo = 'gertrude hamlet';

-- 4. ¿Quiénes son los artistas que participaron en la canción "hasten just"?

SELECT nombre
FROM participa
WHERE titulo = 'hasten just';

-- 5. ¿Cuál es la fecha de nacimiento del artista(s) que participó en la canción "rend region"?

SELECT nombre, nacimiento
FROM artista
WHERE nombre IN
      (SELECT nombre
       FROM participa
       WHERE titulo = 'rend region');

-- 6. ¿Cuáles son los títulos de todas las canciones en las que participó el artista "Jennifer"?

SELECT titulo
FROM participa
WHERE nombre = 'Jennifer';

-- 7. ¿Cuántos artistas participaron en la canción "defective remainder"?

SELECT titulo, count(nombre)
FROM participa
WHERE titulo = 'defective remainder'
GROUP BY titulo;

-- 8. ¿Cuál es el título del álbum en el que aparece la canción "profit hope"?

SELECT album
FROM cancion
WHERE titulo = 'profit hope';

-- 9. ¿Cuáles son todas las canciones que pertenecen al album al que pertenece la cancion "hasten just"?

SELECT titulo, album
FROM cancion
WHERE album IN
      (SELECT album
       FROM cancion
       WHERE titulo = 'hasten just');

-- 10. ¿Quiénes son los artistas que no participaron en ninguna canción?

SELECT nombre
FROM artista
EXCEPT
SELECT DISTINCT nombre
FROM participa;

-- 11. ¿Cuál es la duración total de todas las canciones?

SELECT sum(duracion) AS suma_duracion
FROM cancion;

-- 12. ¿Cuál es la fecha más reciente de lanzamiento de todas las canciones?

SELECT fecha AS reciente_lanzamiento
FROM cancion
ORDER BY fecha DESC
LIMIT 1;

-- 13. ¿Cuántos artistas participaron en total en todas las canciones?

SELECT COUNT(DISTINCT nombre)
FROM participa;

-- 14. ¿Cuál es el número máximo de canciones en las que un artista ha participado?

SELECT count(titulo) AS num_canciones
FROM participa
GROUP BY nombre
ORDER BY num_canciones DESC
LIMIT 1;

-- 15. ¿Cuál es la edad promedio de los artistas al momento del lanzamiento de sus canciones?

SELECT EXTRACT(YEAR FROM AVG(AGE(nacimiento)))
FROM artista;

-- 16. Edad promedio de los artistas al dia de hoy

SELECT EXTRACT(YEAR FROM AVG(AGE(nacimiento, fecha)))
FROM artista NATURAL JOIN participa NATURAL JOIN cancion;