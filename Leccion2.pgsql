CREATE TABLE DEPARTMENTS (
    DEPARTMENT_ID NUMERIC (4,0) PRIMARY KEY,
    DEPARTMENT_NAME VARCHAR(30),           
    MANAGER_ID NUMERIC(6,0),                
    LOCATION_ID NUMERIC(4,0)       
);

INSERT INTO DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID) VALUES
(10, 'Administration', 200, 1700),
(20, 'Marketing', 201, 1800),
(30, 'Purchasing', 114, 1700),
(40, 'Human Resources', 203, 2500),
(50, 'Shipping', 121, 1500),
(60, 'IT', 103, 1400),
(70, 'Public Relations', 204, 2500),
(80, 'Sales', 145, 1500),
(90, 'Executive', 100, 1700);

DESCRIBE DEPARTMENTS;

SELECT department_id || 
department_name  
FROM departments;

SELECT department_id ||' '|| 
department_name  AS " Department Info "
FROM departments;

SELECT first_name ||' '|| 
last_name AS "Employee Name"
FROM employees;

SELECT last_name || ' has a monthly  
    salary of ' || salary || ' 
    dollars.' AS Pay 
FROM employees;

SELECT last_name ||' has a '|| 1 ||' year salary of '|| 
    salary*12 || ' dollars.' AS Pay
FROM employees;

ALTER TABLE EMPLOYEES
ADD COLUMN DEPARTMENT_ID NUMERIC(4,0);

SELECT department_id
 FROM employees;

SELECT DISTINCT department_id
 FROM employees;

SELECT last_name, salary, job_id
FROM EMPLOYEES
WHERE SALARY > 10000;

SELECT DISTINCT JOB_ID
FROM EMPLOYEES
WHERE SALARY > 10000;

SELECT id, first_name, 
last_name
FROM employees;

SELECT id, first_name, 
last_name
FROM employees
WHERE id = 101;

SELECT id, last_name, department_id
FROM  employees
WHERE department_id = 90;

SELECT first_name, last_name
FROM employees;

SELECT last_name, salary
FROM employees
WHERE salary <= 3000;

SELECT last_name, salary
FROM employees
WHERE salary BETWEEN 9000 AND 11000;

SELECT last_name, salary
FROM employees
WHERE salary >= 9000 AND salary <=11000;

SELECT COUNTRY_ID,COUNTRY_NAME,REGION_ID
FROM COUNTRIES
WHERE COUNTRY_ID IN ('UK', 'CA');

SELECT last_name
FROM employees
WHERE last_name LIKE '_o%';

SELECT last_name
FROM employees
WHERE last_name LIKE '_o%';

/*SELECT last_name, job_id
FROM EMPLOYEES
WHERE job_id LIKE '%\_R%' ESCAPE '\';*/

SELECT last_name, manager_id
FROM employees
WHERE manager_id IS NULL;

SELECT last_name, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL;