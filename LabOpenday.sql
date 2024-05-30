-- 1. CREAR TABLAS SIN RESTRICCIONES

CREATE TABLE programa(
    pid INTEGER,
    actividad VARCHAR(100),
    carrera VARCHAR(100),
    lugar VARCHAR(100)
);

CREATE TABLE asistencia(
    pid INTEGER,
    dni VARCHAR(50),
    hora TIMESTAMP
);

CREATE TABLE interesado(
    dni VARCHAR(50),
    nombre VARCHAR(100),
    email VARCHAR(100),
    edad INTEGER,
    sexo VARCHAR(10),
    colegio VARCHAR (100)
);

-- 2 LLAVES PRIMARIAS Y FORANEAS

ALTER TABLE programa ADD CONSTRAINT programa_pk PRIMARY KEY (pid);
ALTER TABLE interesado ADD CONSTRAINT interesado_pk PRIMARY KEY (dni);
ALTER TABLE asistencia ADD CONSTRAINT asistencia_pk PRIMARY KEY (pid,dni);
ALTER TABLE asistencia ADD CONSTRAINT asistencia_fk1 FOREIGN KEY (pid) REFERENCES programa(pid);
ALTER TABLE asistencia ADD CONSTRAINT asistencia_fk2 FOREIGN KEY (dni) REFERENCES interesado(dni);

-- 3 RESTRICCIONES

ALTER TABLE interesado ADD CONSTRAINT email_unico UNIQUE (email);
ALTER TABLE interesado ALTER COLUMN nombre SET NOT NULL;
ALTER TABLE interesado ALTER COLUMN colegio SET NOT NULL;
ALTER TABLE interesado ADD CONSTRAINT edad_verificar CHECK (edad BETWEEN 12 AND 85);

-- 4 INSERTAR VALORES

INSERT INTO programa (pid, actividad, carrera, lugar) VALUES (1, 'Futbol', 'Data Science', 'Chipoco') ,
                                                             (2, 'Programacion', 'Computer Science', 'Auditorio');

INSERT INTO interesado (dni, nombre, email, edad, sexo, colegio) VALUES ('72766813', 'Leonardo', 'leonardo.0414@hotmail.com',19,'Masculino','Leonardo Euler'),
                                                                        ('73189137', 'Pedro','pedro.garcia@gmail.com',23,'Masculino','Saco Oliveros');

INSERT INTO asistencia (pid, dni, hora) VALUES (1,'72766813','2023-05-30 10:20:00'),
                                               (2,'73189137','2023-05-30 12:00:00');

-- 5 USUARIOS

CREATE USER user1 WITH PASSWORD 'user1_2024';
CREATE USER user2 WITH PASSWORD 'user2_2024';
CREATE USER user3 WITH PASSWORD 'user3_2024';

GRANT USAGE ON SCHEMA ejercicio4 TO user1;
GRANT ALL PRIVILEGES ON ejercicio4.asistencia TO user2;

-- 6

SELECT pid, actividad, COUNT(*)
FROM asistencia
JOIN (SELECT pid,actividad
FROM programa
WHERE actividad = 'RoboRally')AS tbl1 USING (pid)
GROUP BY pid, actividad;

-- 7
SELECT dni,nombre
FROM interesado
WHERE dni IN (SELECT dni
    FROM interesado
    EXCEPT
    SELECT DISTINCT dni
    FROM asistencia
    JOIN (SELECT pid, carrera
            FROM programa
            WHERE carrera = 'Ciencia Computacion')
        AS tbl_2 USING (pid)
    );

-- 8

ALTER TABLE interesado ADD COLUMN fecha_nacimiento DATE;

ALTER TABLE interesado ADD CONSTRAINT fecha_edad CHECK ( extract(YEAR FROM interesado.fecha_nacimiento) BETWEEN 12 AND 85);
