CREATE TABLE copy_employees
AS (SELECT * FROM employees);

CREATE TABLE copy_departments
AS (SELECT * FROM departments);

SELECT * FROM copy_employees;

SELECT * FROM copy_departments;

INSERT INTO copy_departments
(department_id, department_name, manager_id, location_id)
VALUES (200,'Human Resources', 205, 1500);

INSERT INTO copy_departments
VALUES
(210,'Estate Management', 102, 1700);

ALTER TABLE copy_employees
ADD COLUMN email VARCHAR(25); 

ALTER TABLE copy_employees
ADD COLUMN phone_number VARCHAR(20);

INSERT INTO copy_employees
(id, first_name, last_name, phone_number,
hire_date,
job_id, salary)
VALUES
(302,'Grigorz','Polanski', '8586667641', '15-Jun-2017',
'IT_PROG',4200);

INSERT INTO copy_employees
(id, first_name, last_name, email, phone_number,
hire_date, job_id, salary)
VALUES
(303,'Grigorz','Polanski', 'gpolanski', '', '15-Jun-2017',
'IT_PROG',4210);

SELECT hire_date, id, job_id
FROM employees
UNION
SELECT NULL::date, id, job_id
FROM job_history;

SELECT first_name, TO_CHAR(hire_date,'Month, fmdd, yyyy')
FROM employees
WHERE id = 101;

INSERT INTO copy_employees
(id, first_name, last_name, email, phone_number,
hire_date,job_id, salary)
VALUES
(301,'Katie','Hernandez', 'khernandez','8586667641',
TO_DATE('July 8, 2017', 'Month fmdd, yyyy'),
'MK_REP',4200);

INSERT INTO copy_employees
(id, first_name, last_name, email, phone_number,
hire_date, job_id, salary)
VALUES
(303,'Angelina','Wright', 'awright','4159982010',
TO_DATE('July 10, 2017 17:20', 'Month fmdd, yyyy HH24:MI'),
'MK_REP', 3600); 

SELECT first_name, last_name,
TO_CHAR(hire_date, 'dd-Mon-YYYY HH24:MI') As "Date and Time"
FROM copy_employees
WHERE id = 303;

CREATE TABLE sales_reps (
    id INT PRIMARY KEY, 
    name VARCHAR(100),
    salary NUMERIC(10, 2),
    commission_pct NUMERIC(5, 2)
);

INSERT INTO sales_reps(id, name, salary, commission_pct)
SELECT id, last_name, salary, commission_pct
FROM employees
WHERE job_id LIKE '%REP%';

UPDATE copy_employees
SET phone_number = '123456'
WHERE id = 303;

UPDATE copy_employees
SET phone_number = '654321', last_name = 'Jones'
WHERE id >= 303;

UPDATE copy_employees
SET phone_number = '654321', last_name = 'Jones'

UPDATE copy_employees
SET salary = (SELECT salary
FROM copy_employees
WHERE id = 100)
WHERE id = 101;

UPDATE copy_employees
SET salary = (SELECT salary
FROM copy_employees
WHERE id = 205),
job_id = (SELECT job_id
FROM copy_employees
WHERE id = 205)
WHERE id = 206;

UPDATE copy_employees
SET salary = (SELECT salary
FROM employees
WHERE id = 205)
WHERE id = 202;

ALTER TABLE copy_employees
ADD COLUMN department_name VARCHAR(30);

UPDATE copy_employees ce
SET department_name = d.department_name
FROM departments d
WHERE ce.department_id = d.department_id;

DELETE from copy_employees
WHERE id = 303;

DELETE FROM copy_employees
WHERE department_id =
(SELECT department_id
FROM departments
WHERE department_name = 'Shipping');

DELETE FROM copy_employees e
WHERE e.manager_id IN
    (SELECT d.manager_id
     FROM employees d
     GROUP BY d.manager_id
     HAVING count(d.department_id) < 2);

UPDATE copy_employees
SET last_name = (SELECT last_name
FROM copy_employees
WHERE id = 999)
WHERE id = 101;

CREATE TABLE my_employees (
    hire_date DATE DEFAULT CURRENT_DATE,
    first_name VARCHAR(15),
    last_name VARCHAR(15)
);

INSERT INTO my_employees
(hire_date, first_name, last_name)
VALUES
(DEFAULT, 'Angelina','Wright');

CREATE TABLE copy_emp (
    employee_id INT PRIMARY KEY, 
    last_name VARCHAR(50),       
    department_id INT            
);

INSERT INTO copy_emp (employee_id, last_name, department_id)
SELECT
    e.id,
    e.last_name,
    e.department_id
FROM
    employees e
ON CONFLICT (employee_id) DO UPDATE SET
    last_name = EXCLUDED.last_name,
    department_id = EXCLUDED.department_id;

/* INSERT ALL INTO clause VALUES clause SUBQUERY */

CREATE TABLE copy_my_employees (
    hire_date DATE DEFAULT CURRENT_DATE, 
    first_name VARCHAR(15),             
    last_name VARCHAR(15)               
);

INSERT INTO my_employees (hire_date, first_name, last_name)
SELECT hire_date, first_name, last_name
FROM employees;

INSERT INTO copy_my_employees (hire_date, first_name, last_name)
SELECT hire_date, first_name, last_name
FROM employees;

INSERT INTO sales_reps(id, name, salary, commission_pct)
SELECT id, last_name, salary, commission_pct
FROM employees
WHERE job_id LIKE '%REP%';

CREATE TABLE all_calls (
    caller_id VARCHAR(50),
    call_timestamp TIMESTAMP, 
    call_duration INT,     
    call_format VARCHAR(10)
);

CREATE TABLE police_record_calls (
    caller_id VARCHAR(50),
    call_timestamp TIMESTAMP,
    recipient_caller VARCHAR(50)
);

CREATE TABLE short_calls (
    caller_id VARCHAR(50),
    call_timestamp TIMESTAMP,
    call_duration INT
);

CREATE TABLE long_calls (
    caller_id VARCHAR(50),
    call_timestamp TIMESTAMP,
    call_duration INT
);

CREATE TABLE calls (
    caller_id VARCHAR(50) PRIMARY KEY, 
    call_timestamp TIMESTAMP,      
    call_duration INT,                
    call_format VARCHAR(10),          
    recipient_caller VARCHAR(50)       
);

-- Insertar/Actualizar en sales_reps
INSERT INTO sales_reps(id, name, salary, commission_pct)
SELECT id, last_name, salary, commission_pct
FROM employees
WHERE job_id LIKE '%REP%'
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    salary = EXCLUDED.salary,
    commission_pct = EXCLUDED.commission_pct;

-- Inserta en all_calls (condición: call_format IN ('tlk', 'txt', 'pic'))
INSERT INTO all_calls (caller_id, call_timestamp, call_duration, call_format)
SELECT
    caller_id,
    call_timestamp,
    call_duration,
    call_format
FROM
    calls
WHERE
    CAST(call_timestamp AS DATE) = CURRENT_DATE
    AND call_format IN ('tlk', 'txt', 'pic');

-- Inserta en police_record_calls (condición: call_format IN ('tlk', 'txt'))
INSERT INTO police_record_calls (caller_id, call_timestamp, recipient_caller)
SELECT
    caller_id,
    call_timestamp,
    recipient_caller
FROM
    calls
WHERE
    CAST(call_timestamp AS DATE) = CURRENT_DATE
    AND call_format IN ('tlk', 'txt');

-- Inserta en short_calls (condición: call_duration < 50 AND call_type = 'tlk')
INSERT INTO short_calls (caller_id, call_timestamp, call_duration)
SELECT
    caller_id,
    call_timestamp,
    call_duration
FROM
    calls
WHERE
    CAST(call_timestamp AS DATE) = CURRENT_DATE
    AND call_duration < 50
    AND call_format = 'tlk';

-- Inserta en long_calls (condición: call_duration >= 50 AND call_type = 'tlk')
INSERT INTO long_calls (caller_id, call_timestamp, call_duration)
SELECT
    caller_id,
    call_timestamp,
    call_duration
FROM
    calls
WHERE
    CAST(call_timestamp AS DATE) = CURRENT_DATE
    AND call_duration >= 50
    AND call_format = 'tlk';