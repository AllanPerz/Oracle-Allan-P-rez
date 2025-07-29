/*CREATE SEQUENCE sequence
[INCREMENT BY n]
[START WITH n]
[{MAXVALUE n | NOMAXVALUE}]
[{MINVALUE n | NOMINVALUE}]
[{CYCLE | NOCYCLE}]
[{CACHE n | NOCACHE}];*/

CREATE SEQUENCE runner_id_seq
INCREMENT BY 1
START WITH 1
MAXVALUE 50000
NO CYCLE;

SELECT sequence_name, min_value, max_value, increment_by, last_number
FROM user_sequences;

CREATE SEQUENCE departments_seq
INCREMENT BY 1
START WITH 1
MAXVALUE 99999 
NO CYCLE;

INSERT INTO departments (department_id, department_name, location_id)
VALUES (NEXTVAL('departments_seq'), 'Support', 2500);

CREATE SEQUENCE employees_seq
INCREMENT BY 1
START WITH 1
MAXVALUE 99999
NO CYCLE;

CREATE SEQUENCE dept_deptid_seq
INCREMENT BY 1
START WITH 1
MAXVALUE 99999 
NO CYCLE;

CREATE TABLE runners (
    runner_id INT PRIMARY KEY, 
    first_name VARCHAR(60),  
    last_name VARCHAR(60)
);

CREATE SEQUENCE runner_id_seq
INCREMENT BY 1
START WITH 1
MAXVALUE 50000
NO CYCLE;

INSERT INTO runners
(runner_id, first_name, last_name)
VALUES (NEXTVAL('runner_id_seq'), 'Joanne', 'Everely');

INSERT INTO runners
(runner_id, first_name, last_name)
VALUES (NEXTVAL('runner_id_seq'), 'Adam', 'Curtis');

SELECT runner_id, first_name, last_name
FROM runners;

/*CREATE INDEX index_name
ON table_name( column...,column)*/

CREATE INDEX wf_cont_reg_id_idx
ON wf_countries(region_id);

CREATE INDEX emps_name_idx
ON employees(first_name, last_name);

SELECT
    idx.relname AS index_name,
    att.attname AS column_name,
    (array_position(ind.indkey, att.attnum) + 1) AS column_position,
    CASE
        WHEN ind.indisunique THEN 'UNIQUE'
        ELSE 'NONUNIQUE'
    END AS uniqueness
FROM
    pg_class AS tab
JOIN
    pg_index AS ind ON ind.indrelid = tab.oid
JOIN
    pg_class AS idx ON idx.oid = ind.indexrelid
JOIN
    pg_attribute AS att ON att.attrelid = tab.oid AND att.attnum = ANY(ind.indkey)
WHERE
    tab.relname = 'employees' -- Asegúrate de que el nombre de la tabla esté en minúsculas en PostgreSQL
ORDER BY
    idx.relname, column_position;

CREATE INDEX upper_last_name_idx
ON employees (UPPER(last_name));

SELECT *
FROM employees
WHERE UPPER(last_name) = 'KING';

SELECT *
FROM employees
WHERE UPPER(last_name) LIKE 'KIN%';

SELECT *
FROM employees
WHERE UPPER (last_name) IS NOT NULL
ORDER BY UPPER (last_name);

SELECT first_name, last_name, hire_date
FROM employees
WHERE TO_CHAR(hire_date, 'yyyy') = '1987';

DROP INDEX upper_last_name_idx;

DROP INDEX emps_name_idx;

DROP INDEX emp_hire_year_idx;

/*CREATE [PUBLIC] SYNONYM synonym
FOR object;*/

CREATE VIEW amy_emps AS
SELECT *
FROM amy_copy_employees;

/* DROP [PUBLIC] SYNONYM name_of_synonym; */

DROP SYNONYM amy_emps;