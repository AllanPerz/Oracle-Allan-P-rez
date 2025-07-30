SELECT
    first_name,
    last_name,
    LOWER(first_name) AS nombre_en_minusculas,
    LOWER(last_name) AS apellido_en_minusculas
FROM
    employees
LIMIT 5;

SELECT
    department_name,
    UPPER(department_name) AS departamento_en_mayusculas
FROM
    departments
LIMIT 5;

SELECT
    first_name,
    last_name,
    INITCAP(first_name) AS nombre_formato_titulo,
    INITCAP(last_name) AS apellido_formato_titulo
FROM
    employees
LIMIT 5;

SELECT
    first_name,
    last_name,
    CONCAT(first_name, ' ', last_name) AS nombre_completo_con_concat,
    first_name || ' ' || last_name AS nombre_completo_con_operador
FROM
    employees
LIMIT 5;

SELECT
    department_name,
    SUBSTR(department_name, 1, 3) AS codigo_departamento
FROM
    departments
LIMIT 5;

SELECT
    first_name,
    LENGTH(first_name) AS longitud_nombre,
    last_name,
    LENGTH(last_name) AS longitud_apellido
FROM
    employees
LIMIT 5;

SELECT
    department_name,
    STRPOS(department_name, 'a') AS posicion_de_la_a_strpos,
    POSITION('a' IN department_name) AS posicion_de_la_a_position
FROM
    departments
LIMIT 5;

SELECT
    id,
    LPAD(id::text, 5, '0') AS id_empleado_rellenado
FROM
    employees
LIMIT 5;

SELECT
    department_name,
    RPAD(department_name, 20, '*') AS nombre_departamento_rellenado
FROM
    departments
LIMIT 5;

SELECT
    '   Ventas   ' AS cadena_original,
    TRIM('   Ventas   ') AS cadena_recortada_ambos,
    TRIM(LEADING FROM '   Ventas   ') AS cadena_recortada_izquierda,
    TRIM(TRAILING FROM '   Ventas   ') AS cadena_recortada_derecha;

SELECT
    department_name,
    TRIM(LEADING 'S' FROM department_name) AS departamento_sin_S_inicial
FROM
    departments
WHERE department_name LIKE 'S%'
LIMIT 5;

SELECT
    department_name,
    REPLACE(department_name, 'Sales', 'Ventas') AS departamento_con_nombre_reemplazado
FROM
    departments
WHERE department_name LIKE '%Sales%'
LIMIT 5;

SELECT
    salary AS salario_original,
    ROUND(salary) AS salario_redondeado_entero,
    ROUND(salary, 2) AS salario_redondeado_dos_decimales
FROM
    employees
LIMIT 5;

SELECT
    salary AS salario_original,
    TRUNC(salary) AS salario_truncado_entero,
    TRUNC(salary, 1) AS salario_truncado_un_decimal
FROM
    employees
LIMIT 5;

SELECT
    id AS id_empleado,
    salary AS salario,
    MOD(salary, 1000) AS modulo_salario_entre_mil,
    MOD(id, 2) AS id_modulo_dos
FROM
    employees
LIMIT 5;

SELECT
    hire_date AS fecha_contratacion_original,
    DATE_TRUNC('month', hire_date) AS fecha_truncada_a_mes,
    DATE_TRUNC('year', hire_date) AS fecha_truncada_a_anio
FROM
    employees
LIMIT 5;

SELECT
    hire_date AS fecha_contratacion_original,
    CASE
        WHEN EXTRACT(DAY FROM hire_date) >= 15 THEN DATE_TRUNC('month', hire_date) + INTERVAL '1 month'
        ELSE DATE_TRUNC('month', hire_date)
    END AS fecha_redondeada_ejemplo
FROM
    employees
LIMIT 5;

SELECT
    e1.first_name,
    e1.hire_date AS fecha_contratacion_empleado1,
    e2.first_name,
    e2.hire_date AS fecha_contratacion_empleado2,
    EXTRACT(YEAR FROM AGE(e1.hire_date, e2.hire_date)) * 12 + EXTRACT(MONTH FROM AGE(e1.hire_date, e2.hire_date)) AS meses_entre_fechas
FROM
    employees e1, employees e2
WHERE
    e1.id = 101 AND e2.id = 102;

SELECT
    hire_date AS fecha_original,
    hire_date + INTERVAL '1 month' AS un_mes_despues,
    hire_date + INTERVAL '3 months' AS tres_meses_despues
FROM
    employees
LIMIT 5;

SELECT
    hire_date AS fecha_original,
    (hire_date + INTERVAL '1 day')::date + CASE
        WHEN EXTRACT(DOW FROM hire_date) = 1 THEN INTERVAL '0 day'
        WHEN EXTRACT(DOW FROM hire_date) = 2 THEN INTERVAL '6 day'
        WHEN EXTRACT(DOW FROM hire_date) = 3 THEN INTERVAL '5 day'
        WHEN EXTRACT(DOW FROM hire_date) = 4 THEN INTERVAL '4 day'
        WHEN EXTRACT(DOW FROM hire_date) = 5 THEN INTERVAL '3 day'
        WHEN EXTRACT(DOW FROM hire_date) = 6 THEN INTERVAL '2 day'
        WHEN EXTRACT(DOW FROM hire_date) = 0 THEN INTERVAL '1 day'
    END AS proximo_lunes_desde_contratacion
FROM
    employees
LIMIT 5;

SELECT
    hire_date AS fecha_original,
    (DATE_TRUNC('month', hire_date) + INTERVAL '1 month' - INTERVAL '1 day')::date AS ultimo_dia_del_mes
FROM
    employees
LIMIT 5;

SELECT
    salary AS salario_original,
    TO_CHAR(salary, 'FM999G999D00') AS salario_formato_moneda,
    TO_CHAR(salary, 'FM999G999') AS salario_sin_decimales
FROM
    employees
LIMIT 5;

SELECT
    hire_date AS fecha_original,
    TO_CHAR(hire_date, 'YYYY-MM-DD') AS fecha_formato_iso,
    TO_CHAR(hire_date, 'DD/MM/YYYY HH24:MI:SS') AS fecha_hora_completa,
    TO_CHAR(hire_date, 'Month DD, YYYY') AS fecha_formato_largo
FROM
    employees
LIMIT 5;

SELECT
    '12345.67' AS cadena_numero,
    TO_NUMBER('12345.67', 'FM99999D99') AS numero_convertido,
    '$1,234.50' AS cadena_moneda,
    TO_NUMBER('$1,234.50', 'FML9G999D00') AS moneda_convertida;

SELECT
    '2023-10-26' AS cadena_fecha_iso,
    TO_DATE('2023-10-26', 'YYYY-MM-DD') AS fecha_convertida_iso,
    '26/10/2023 14:30:00' AS cadena_fecha_hora,
    TO_DATE('26/10/2023 14:30:00', 'DD/MM/YYYY HH24:MI:SS') AS fecha_hora_convertida;

SELECT
    id,
    first_name,
    commission_pct AS comision_original,
    COALESCE(commission_pct, 0) AS comision_si_es_nula -- Equivalente a NVL(commission_pct, 0)
FROM
    employees
LIMIT 5;

SELECT
    id,
    first_name,
    salary AS salario_original,
    bonus AS bono_original,
    CASE
        WHEN bonus IS NOT NULL THEN salary + bonus
        ELSE salary * 0.9 -- Ejemplo: si no hay bono, reduce el salario un 10%
    END AS salario_ajustado -- Equivalente a NVL2(bonus, salary + bonus, salary * 0.9)
FROM
    employees
LIMIT 5;

SELECT
    id,
    first_name,
    manager_id AS id_jefe,
    -- NULLIF devuelve NULL si expr1 = expr2, de lo contrario devuelve expr1.
    -- Aquí, si el manager_id del empleado es 100, se muestra NULL.
    NULLIF(manager_id, 100) AS id_jefe_no_es_cien
FROM
    employees
LIMIT 5;

SELECT
    id,
    first_name,
    commission_pct AS comision_pct_original,
    bonus AS bono_original,
    -- COALESCE devuelve la primera expresión no nula de la lista.
    COALESCE(commission_pct, bonus, 0.05) AS primera_no_nula
FROM
    employees
LIMIT 5;

SELECT
    id,
    first_name,
    job_id AS id_puesto,
    -- Simula la funcionalidad de DECODE usando CASE
    CASE job_id
        WHEN 'IT_PROG' THEN 'Programador TI'
        WHEN 'SA_REP' THEN 'Representante de Ventas'
        WHEN 'AD_PRES' THEN 'Presidente'
        ELSE 'Otro Puesto'
    END AS descripcion_puesto
FROM
    employees
LIMIT 5;

SELECT
    id,
    first_name,
    salary AS salario_original,
    -- Ejemplo de CASE simple para categorizar salarios
    CASE
        WHEN salary < 5000 THEN 'Salario Bajo'
        WHEN salary >= 5000 AND salary < 10000 THEN 'Salario Medio'
        ELSE 'Salario Alto'
    END AS categoria_salario
FROM
    employees
LIMIT 5;

SELECT
    e.first_name,
    e.salary,
    d.department_name,
  
      CASE
        WHEN d.department_name = 'Sales' AND e.salary > 8000 THEN 'Ventas Alto Salario'
        WHEN d.department_name = 'IT' AND e.salary > 6000 THEN 'TI Alto Salario'
        WHEN e.commission_pct IS NOT NULL THEN 'Tiene Comisión'
        ELSE 'Sin Comisión ni Puesto Específico'
    END AS observacion_empleado
FROM
    employees e
JOIN
    departments d ON e.department_id = d.department_id
LIMIT 5;

SELECT
    e.last_name,
    d.department_name
FROM
    employees e
CROSS JOIN
    departments d
LIMIT 5;

SELECT
    id, 
    last_name,
    department_name
FROM
    employees
NATURAL JOIN
    departments
LIMIT 5;

SELECT
    e.id AS id,
    e.last_name,
    e.salary,
    d.department_name
FROM
    employees e
JOIN
    departments d ON e.department_id = d.department_id
LIMIT 5;

SELECT
    id AS employee_id, 
    last_name,
    department_name
FROM
    employees
JOIN
    departments USING (department_id)
LIMIT 5;

SELECT
    e.id AS employee_id, 
    e.last_name,
    d.department_id,
    d.location_id
FROM
    employees e
JOIN
    departments d ON (e.department_id = d.department_id)
LIMIT 5;

SELECT
    e.id AS employee_id,
    e.last_name,
    d.department_id,
    d.department_name
FROM
    employees e
RIGHT OUTER JOIN
    departments d ON (e.department_id = d.department_id)
LIMIT 5;

SELECT
    e.id AS employee_id,
    e.last_name,
    d.department_id,
    d.department_name
FROM
    employees e
LEFT OUTER JOIN
    departments d ON (e.department_id = d.department_id)
LIMIT 5;

SELECT
    e.id AS employee_id,
    e.last_name,
    d.department_id,
    d.department_name
FROM
    employees e
FULL OUTER JOIN
    departments d ON (e.department_id = d.department_id)
LIMIT 5;

SELECT
    department_id,
    AVG(salary) AS salario_promedio,
    COUNT(id) AS total_empleados,
    MIN(salary) AS salario_minimo,
    MAX(salary) AS salario_maximo,
    SUM(salary) AS salario_total
FROM
    employees
GROUP BY
    department_id
ORDER BY
    department_id
LIMIT 5;

SELECT
    department_id,
    VAR_SAMP(salary) AS varianza_salario,
    STDDEV_SAMP(salary) AS desviacion_estandar_salario
FROM
    employees
GROUP BY
    department_id
ORDER BY
    department_id
LIMIT 5;

SELECT
    department_id,
    AVG(salary) AS salario_promedio_alto
FROM
    employees
GROUP BY
    department_id
HAVING
    AVG(salary) > 8000
ORDER BY
    department_id;

SELECT
    department_id,
    job_id,
    SUM(salary) AS salario_total_agrupado
FROM
    employees
GROUP BY ROLLUP (department_id, job_id)
ORDER BY
    department_id NULLS FIRST, job_id NULLS FIRST
LIMIT 10;

SELECT
    department_id,
    job_id,
    SUM(salary) AS salario_total_agrupado
FROM
    employees
GROUP BY CUBE (department_id, job_id)
ORDER BY
    department_id NULLS FIRST, job_id NULLS FIRST
LIMIT 10;

SELECT
    department_id,
    job_id,
    SUM(salary) AS salario_total_agrupado
FROM
    employees
GROUP BY GROUPING SETS (department_id, job_id, ())
ORDER BY
    department_id NULLS FIRST, job_id NULLS FIRST
LIMIT 10; 

SELECT
    first_name,
    last_name,
    salary
FROM
    employees
WHERE
    salary = (SELECT MIN(salary) FROM employees WHERE job_id = 'IT_PROG')
LIMIT 5;

SELECT
    first_name,
    last_name,
    department_id
FROM
    employees
WHERE
    department_id IN (SELECT department_id FROM departments WHERE location_id = 1700)
LIMIT 5;

SELECT
    first_name,
    last_name,
    salary
FROM
    employees
WHERE
    salary > ANY (SELECT salary FROM employees WHERE department_id = 60)
LIMIT 5;

SELECT
    first_name,
    last_name,
    salary
FROM
    employees
WHERE
    salary > ALL (SELECT salary FROM employees WHERE department_id = 50)
LIMIT 5;

-- Subconsulta Pareada
SELECT
    e.first_name,
    e.last_name,
    e.salary,
    e.department_id
FROM
    employees e
WHERE
    (e.department_id, e.salary) IN (
        SELECT
            e2.department_id,
            MAX(e2.salary)
        FROM
            employees e2
        WHERE
            e2.department_id = e.department_id 
        GROUP BY
            e2.department_id
    )
LIMIT 5;

SELECT
    first_name,
    last_name,
    department_id,
    salary
FROM
    employees
WHERE
    department_id = (SELECT department_id FROM departments WHERE department_name = 'IT')
AND
    salary = (SELECT MAX(salary) FROM employees WHERE job_id = 'IT_PROG')
LIMIT 5;

SELECT
    e.first_name,
    e.last_name,
    e.salary,
    e.department_id
FROM
    employees e
WHERE
    e.salary > (
        SELECT
            AVG(e2.salary)
        FROM
            employees e2
        WHERE
            e2.department_id = e.department_id 
    )
LIMIT 5;

INSERT INTO employees (id, first_name, last_name, salary, job_id, commission_pct, department_id, hire_date, bonus, manager_id)
VALUES (9001, 'Juan', 'Perez', 7500, 'IT_PROG', NULL, 60, '2023-01-15', NULL, 103);

INSERT INTO departments (department_id, department_name, manager_id, location_id)
VALUES (900, 'Investigacion y Desarrollo', 200, 1700);

UPDATE employees
SET salary = 8000
WHERE id = 9001;

DELETE FROM employees
WHERE id = 9001;

DELETE FROM departments
WHERE department_id = 900;

INSERT INTO employees (id, first_name, last_name, salary, job_id, commission_pct, department_id, hire_date, bonus, manager_id)
SELECT
    9002 AS id,
    'Ana' AS first_name,
    'Gomez' AS last_name,
    8000 AS salary,
    CASE
        WHEN 8000 > 7000 THEN 'FI_ACCOUNT' 
        ELSE 'SA_REP' 
    END AS job_id,
    NULL AS commission_pct,
    80 AS department_id,
    '2024-03-01' AS hire_date,
    NULL AS bonus,
    100 AS manager_id
WHERE
    NOT EXISTS (SELECT 1 FROM employees WHERE id = 9002); 

DROP TABLE IF EXISTS log_actividades;

CREATE TABLE log_actividades (
    id SERIAL PRIMARY KEY,
    descripcion VARCHAR(255),
    fecha_registro TIMESTAMP DEFAULT NOW()
);

INSERT INTO log_actividades (descripcion)
VALUES ('Actividad A realizada');

INSERT INTO log_actividades (descripcion, fecha_registro)
VALUES ('Actividad B realizada', DEFAULT);

SELECT * FROM log_actividades;

DROP TABLE IF EXISTS log_actividades;

DROP TABLE IF EXISTS empleados_salarios_actuales;
CREATE TABLE empleados_salarios_actuales (
    id INT PRIMARY KEY,
    salary DECIMAL(10, 2),
    ultima_actualizacion TIMESTAMP DEFAULT NOW()
);

INSERT INTO empleados_salarios_actuales (id, salary) VALUES (100, 10000);
INSERT INTO empleados_salarios_actuales (id, salary) VALUES (101, 15000);

DROP TABLE IF EXISTS fuente_datos_salarios;
CREATE TEMPORARY TABLE fuente_datos_salarios (
    id_fuente INT,
    nuevo_salario DECIMAL(10, 2)
);

INSERT INTO fuente_datos_salarios (id_fuente, nuevo_salario) VALUES (100, 10500); -- Actualizar existente
INSERT INTO fuente_datos_salarios (id_fuente, nuevo_salario) VALUES (102, 12000); -- Insertar nuevo
INSERT INTO fuente_datos_salarios (id_fuente, nuevo_salario) VALUES (103, 9000);  -- Insertar nuevo

INSERT INTO empleados_salarios_actuales AS esa (id, salary)
SELECT
    f.id_fuente,
    f.nuevo_salario
FROM
    fuente_datos_salarios f
ON CONFLICT (id) DO UPDATE SET
    salary = EXCLUDED.salary,
    ultima_actualizacion = NOW();

SELECT * FROM empleados_salarios_actuales ORDER BY id;

DROP TABLE IF EXISTS empleados_salarios_actuales;

DROP TABLE IF EXISTS clientes_web;
CREATE TABLE clientes_web (
    cliente_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    fecha_registro TIMESTAMP DEFAULT NOW()
);

INSERT INTO clientes_web (nombre, email) VALUES ('Carlos', 'carlos@ejemplo.com');
SELECT * FROM clientes_web;

DROP TABLE IF EXISTS empleados_salarios_altos;
CREATE TABLE empleados_salarios_altos AS
SELECT
    id,
    first_name,
    last_name,
    salary,
    department_id
FROM
    employees
WHERE
    salary > 10000;

SELECT * FROM empleados_salarios_altos LIMIT 5;

DROP TABLE IF EXISTS clientes_web;
DROP TABLE IF EXISTS empleados_salarios_altos;

DROP TABLE IF EXISTS ejemplo_tipos_datos;
CREATE TABLE ejemplo_tipos_datos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50),
    cantidad NUMERIC(10, 2),
    fecha DATE,
    momento TIMESTAMP,
    zona_horaria_momento TIMESTAMP WITH TIME ZONE,
    duracion INTERVAL DAY TO SECOND
);

INSERT INTO ejemplo_tipos_datos (nombre, cantidad, fecha, momento, zona_horaria_momento, duracion)
VALUES ('Item A', 123.45, '2023-07-20', '2023-07-20 10:30:00', '2023-07-20 10:30:00+02', '1 day 05 hours');

SELECT * FROM ejemplo_tipos_datos;

DROP TABLE IF EXISTS ejemplo_tipos_datos;

DROP TABLE IF EXISTS empleados_temporal;
CREATE TABLE empleados_temporal (
    id INT PRIMARY KEY,
    nombre VARCHAR(50),
    salario DECIMAL(10, 2)
);

INSERT INTO empleados_temporal (id, nombre, salario) VALUES (1, 'Ana', 5000);
INSERT INTO empleados_temporal (id, nombre, salario) VALUES (2, 'Luis', 6000);

ALTER TABLE empleados_temporal
ADD COLUMN fecha_contratacion DATE DEFAULT CURRENT_DATE;

ALTER TABLE empleados_temporal
ALTER COLUMN nombre TYPE VARCHAR(100);

-- Eliminar una columna
ALTER TABLE empleados_temporal
DROP COLUMN salario;

SELECT * FROM empleados_temporal;

DROP TABLE IF EXISTS empleados_temporal;

DROP TABLE IF EXISTS departamentos_ejemplo CASCADE; -- CASCADE para limpiar FKs que dependan de ella
DROP TABLE IF EXISTS empleados_con_restricciones;

CREATE TABLE departamentos_ejemplo (
    id_departamento SERIAL PRIMARY KEY,
    nombre_departamento VARCHAR(50) UNIQUE NOT NULL
);

INSERT INTO departamentos_ejemplo (nombre_departamento) VALUES ('Ventas');
INSERT INTO departamentos_ejemplo (nombre_departamento) VALUES ('TI');


CREATE TABLE empleados_con_restricciones (
    empleado_id INT CONSTRAINT pk_empleado PRIMARY KEY,
    nombre VARCHAR(100) CONSTRAINT nn_nombre NOT NULL,
    email VARCHAR(100) CONSTRAINT uk_email UNIQUE,
    salario DECIMAL(10, 2) CONSTRAINT ck_salario CHECK (salario > 0),
    id_departamento INT CONSTRAINT fk_departamento REFERENCES departamentos_ejemplo (id_departamento)
);

-- Ejemplo de inserción válida
INSERT INTO empleados_con_restricciones (empleado_id, nombre, email, salario, id_departamento)
VALUES (1, 'Juan Pérez', 'juan.perez@ejemplo.com', 5000.00, 1);

SELECT * FROM empleados_con_restricciones;

DROP TABLE IF EXISTS empleados_con_restricciones;
DROP TABLE IF EXISTS departamentos_ejemplo;

DROP TABLE IF EXISTS departamentos_para_ejemplo CASCADE;
DROP TABLE IF EXISTS empleados_restricciones_tabla;

CREATE TABLE departamentos_para_ejemplo (
    id_departamento INT PRIMARY KEY,
    nombre_departamento VARCHAR(50) UNIQUE NOT NULL
);

INSERT INTO departamentos_para_ejemplo (id_departamento, nombre_departamento) VALUES (10, 'Contabilidad');
INSERT INTO departamentos_para_ejemplo (id_departamento, nombre_departamento) VALUES (20, 'Recursos Humanos');


CREATE TABLE empleados_restricciones_tabla (
    empleado_id INT,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    salario DECIMAL(10, 2),
    id_departamento INT,
    CONSTRAINT pk_empleado_tabla PRIMARY KEY (empleado_id),
    CONSTRAINT uk_email_tabla UNIQUE (email),
    CONSTRAINT ck_salario_tabla CHECK (salario > 0 AND salario < 50000),
    CONSTRAINT fk_depto_tabla FOREIGN KEY (id_departamento) REFERENCES departamentos_para_ejemplo (id_departamento)
);

-- Ejemplo de inserción válida
INSERT INTO empleados_restricciones_tabla (empleado_id, nombre, email, salario, id_departamento)
VALUES (101, 'Maria Lopez', 'maria.lopez@ejemplo.com', 7500.00, 10);

SELECT * FROM empleados_restricciones_tabla;

DROP TABLE IF EXISTS empleados_restricciones_tabla;
DROP TABLE IF EXISTS departamentos_para_ejemplo;

DROP VIEW IF EXISTS vista_empleados_departamentos;

CREATE VIEW vista_empleados_departamentos AS
SELECT
    e.id AS empleado_id,
    e.first_name AS nombre_empleado,
    e.last_name AS apellido_empleado,
    d.department_name AS nombre_departamento
FROM
    employees e
JOIN
    departments d ON e.department_id = d.department_id;

SELECT * FROM vista_empleados_departamentos LIMIT 5;

DROP VIEW vista_empleados_departamentos;

SELECT
    first_name,
    last_name,
    salary
FROM
    employees
ORDER BY
    salary DESC
LIMIT 5;

SELECT
    t1.first_name,
    t1.last_name,
    t2.salario_promedio_depto
FROM
    employees t1,
    (SELECT department_id, AVG(salary) AS salario_promedio_depto FROM employees GROUP BY department_id) t2
WHERE
    t1.department_id = t2.department_id
ORDER BY
    t1.last_name
LIMIT 5;

CREATE ROLE rol_lector;

GRANT SELECT ON employees TO rol_lector;

REVOKE SELECT ON employees FROM rol_lector;

DROP ROLE IF EXISTS rol_lector;