CREATE SCHEMA IF NOT EXISTS mary;

SELECT *
FROM mary.students;

/*CREATE TABLE table
(column data type [DEFAULT expression],
(column data type [DEFAULT expression],
(……[ ] ); */

CREATE TABLE my_cd_collection (
    cd_number SMALLINT,
    title VARCHAR(20),
    artist VARCHAR(20),
    purchase_date DATE DEFAULT NOW()
);

CREATE TABLE my_friends (
    first_name VARCHAR(20),
    last_name VARCHAR(30),
    email VARCHAR(30),
    phone_num VARCHAR(12),
    birth_date DATE
);

ALTER TABLE my_cd_collection
ALTER COLUMN title TYPE VARCHAR(50);

ALTER TABLE my_cd_collection
ALTER COLUMN artist TYPE VARCHAR(50); 

INSERT INTO my_cd_collection (cd_number, title, artist, purchase_date) VALUES
(101, 'Thriller', 'Michael Jackson', '2005-03-15'),
(102, 'The Dark Side of the Moon', 'Pink Floyd', '2010-07-20'),
(103, 'Abbey Road', 'The Beatles', '2012-11-01'),
(104, 'Bad', 'Michael Jackson', '2008-01-25'),
(105, 'Nevermind', 'Nirvana', '2015-09-10');

INSERT INTO my_friends (first_name, last_name, email, phone_num, birth_date) VALUES
('Juan', 'Pérez', 'juan.perez@example.com', '555-123-4567', '1990-05-20'),
('Maria', 'González', 'maria.gonzalez@example.com', '555-987-6543', '1988-11-12'),
('Pedro', 'Rodríguez', 'pedro.rodriguez@example.com', '555-444-5555', '1992-03-01'),
('Ana', 'López', 'ana.lopez@example.com', '555-222-3333', '1995-07-28'),
('Carlos', 'Martínez', 'carlos.martinez@example.com', '555-777-8888', '1985-09-03');

CREATE EXTENSION IF NOT EXISTS file_fdw;

CREATE SERVER local_files_server
FOREIGN DATA WRAPPER file_fdw;

CREATE FOREIGN TABLE emp_load (
    employee_number CHAR(5),
    employee_dob CHAR(20), 
    employee_last_name CHAR(20),
    employee_first_name CHAR(15),
    employee_middle_name CHAR(15),
    employee_hire_date CHAR(10) 
)
SERVER local_files_server
OPTIONS (
    filename '/ruta/a/tu/archivo/info.dat', 
    delimiter ',',                         
    header 'false'   
);                  

CREATE TABLE time_ex1 (
    exact_time TIMESTAMP
);

INSERT INTO time_ex1
VALUES (TO_TIMESTAMP('10-Jun-2017 10:52:29.123456', 'DD-Mon-YYYY HH24:MI:SS.US'));

INSERT INTO time_ex1
VALUES (NOW());

SELECT *
FROM time_ex1;

CREATE TABLE time_ex2 (
    time_with_offset TIMESTAMP WITH TIME ZONE
);

INSERT INTO time_ex2
VALUES (NOW());

INSERT INTO time_ex2
VALUES (TO_TIMESTAMP('10-Jun-2017 10:52:29.123456 AM +02:00', 'DD-Mon-YYYY HH12:MI:SS.US AM TZ'));

SELECT *
FROM time_ex2;

CREATE TABLE time_ex3 (
    first_column TIMESTAMP WITH TIME ZONE,
    second_column TIMESTAMP WITH TIME ZONE
);

INSERT INTO time_ex3 (first_column, second_column)
VALUES
(
    TO_TIMESTAMP('15-Jul-2017 08:00:00 AM -07:00', 'DD-Mon-YYYY HH12:MI:SS AM OFFCENT'),
    TO_TIMESTAMP('15-Nov-2007 08:00:00', 'DD-Mon-YYYY HH24:MI:SS')
);

SELECT *
FROM time_ex3;

/*INTERVAL YEAR [(year_precision)] TO MONTH*/

CREATE TABLE time_ex4 (
    loan_duration1 INTERVAL YEAR TO MONTH,
    loan_duration2 INTERVAL YEAR TO MONTH
);

INSERT INTO time_ex4 (loan_duration1, loan_duration2)
VALUES (
    INTERVAL '120 MONTH', 
    INTERVAL '3 YEAR 6 MONTH' 
);

SELECT
    CURRENT_DATE + loan_duration1 AS "120 months from now",
    CURRENT_DATE + loan_duration2 AS "3 years 6 months from now"
FROM time_ex4;

/* INTERVAL DAY [day_precision)] TO SECOND
[(fractional_seconds_precision)] */

CREATE TABLE time_ex5 (
    day_duration1 INTERVAL DAY TO SECOND,
    day_duration2 INTERVAL DAY TO SECOND
);

INSERT INTO time_ex5 (day_duration1, day_duration2)
VALUES (
    INTERVAL '25 DAY',
    INTERVAL '1 DAY 08 HOURS 00 MINUTES 00.123456 SECONDS'
);

SELECT
    NOW() + day_duration1 AS "25 Days from now",
    TO_CHAR(NOW() + day_duration2, 'DD-Mon-YYYY HH24:MI:SS') AS "precise days and time from now"
FROM time_ex5;

/* ALTER TABLE tablename
ADD (column name data type [DEFAULT expression],
column name data type [DEFAULT expression], ... */

ALTER TABLE my_cd_collection
ADD COLUMN release_date DATE DEFAULT CURRENT_DATE;

ALTER TABLE my_friends
ADD COLUMN favorite_game VARCHAR(30);

CREATE TABLE mod_emp (
    last_name VARCHAR(20), 
    salary NUMERIC(8,2)  
);

ALTER TABLE mod_emp
ALTER COLUMN last_name TYPE VARCHAR(30);

ALTER TABLE mod_emp
ALTER COLUMN last_name TYPE VARCHAR(10);

ALTER TABLE mod_emp
ALTER COLUMN salary TYPE NUMERIC(10,2);

ALTER TABLE mod_emp
ALTER COLUMN salary SET DEFAULT 50.00;

/*ALTER TABLE tablename
DROP COLUMN column name;*/

ALTER TABLE my_cd_collection
DROP COLUMN release_date;

ALTER TABLE my_cd_collection
DROP COLUMN release_date;

ALTER TABLE copy_employees
SET UNUSED (email);

ALTER TABLE copy_employees
DROP UNUSED COLUMNS;

/*DROP TABLE tablename;*/

DROP TABLE copy_employees;

/*FLASHBACK TABLE tablename TO BEFORE DROP;*/

FLASHBACK TABLE copy_employees TO BEFORE DROP;

SELECT original_name, operation, droptime
FROM user_recyclebin

/*DROP TABLE copy_employees PURGE;*/

/*RENAME old_name to new_name;*/

ALTER TABLE my_cd_collection RENAME TO my_music;

/*TRUNCATE TABLE tablename;*/

/*COMMENT ON TABLE tablename | COLUMN table.column
IS 'place your comment here';
*/

COMMENT ON TABLE employees
IS 'Western Region only';

SELECT
    c.relname AS table_name,
    obj_description(c.oid, 'pg_class') AS comment
FROM
    pg_class c
JOIN
    pg_namespace n ON n.oid = c.relnamespace
WHERE
    c.relkind = 'r' 
    AND n.nspname NOT IN ('pg_catalog', 'information_schema')
    AND pg_catalog.has_table_privilege(c.oid, 'SELECT');

 
CREATE TABLE copy_employees (
    employee_id INTEGER PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50), 
    phone_number VARCHAR(20),
    hire_date DATE,
    job_id VARCHAR(20),
    salary NUMERIC(10, 2),
    commission_pct NUMERIC(3, 2),
    manager_id INTEGER,
    department_id INTEGER
);

INSERT INTO copy_employees
VALUES (1, 'Natacha', 'Hansen', 'NHANSEN', '4412312341234',
'07-SEP-1998', 'AD_VP', 12000, null, 100, 90, NULL); 

INSERT INTO copy_employees (
    employee_id, first_name, last_name, email, phone_number,
    hire_date, job_id, salary, commission_pct, manager_id, department_id
) VALUES (
    1,
    'Natacha',
    'Hansen',
    'NHANSEN',
    '4412312341234',
    TO_DATE('07-SEP-1998', 'DD-MON-YYYY'),
    'AD_VP',
    12000,
    NULL,
    100,
    90
);

UPDATE copy_employees
SET salary = 1
WHERE employee_id = 1;

