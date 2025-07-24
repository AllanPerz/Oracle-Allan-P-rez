SELECT MAX(salary)
FROM employees;

/*SELECT column,
group_function(column),
..
FROM table
WHERE condition
GROUP BY column;*/

SELECT MIN(date_of_independence)
AS "Lowest Date of Independence"
FROM wf_countries;

SELECT MIN(country_name)
FROM wf_countries;

SELECT MIN(hire_date)
FROM employees;

SELECT MAX(date_of_independence)
AS "Highest Date of Independence"
FROM wf_countries;

SELECT MAX(country_name)
FROM wf_countries;

SELECT MAX(hire_date)
FROM employees;

ALTER TABLE wf_countries
ADD COLUMN Area DECIMAL(10, 2);

UPDATE wf_countries
SET Area =
    CASE
        WHEN country_id = 1 THEN 9984670.00
        WHEN country_id = 2 THEN 51100.00
        WHEN country_id = 3 THEN 4033.00
        WHEN country_id = 4 THEN 2166086.00
        WHEN country_id = 5 THEN 48671.00
        WHEN country_id = 6 THEN 117600.00
        ELSE NULL 
    END
WHERE country_id IN (1, 2, 3, 4, 5, 6);

SELECT SUM(area)
FROM wf_countries
WHERE country_id = 4;

SELECT SUM(salary)
FROM employees
WHERE department_id = 90;

SELECT SUM(area)
FROM wf_countries;

SELECT SUM (salary)
FROM employees
WHERE department_id = 90;

SELECT SUM(area)
FROM wf_countries;

SELECT SUM (salary)
FROM employees
WHERE department_id = 90;

SELECT AVG(commission_pct)
FROM employees;

SELECT MAX(salary), MIN(salary), MIN(id)
FROM employees
WHERE department_id = 60;

SELECT COUNT(job_id)
FROM employees;

SELECT COUNT(commission_pct)
FROM employees;

SELECT COUNT(*)
FROM employees
WHERE hire_date < '01-Jan-1996';

SELECT COUNT(*)
FROM employees
WHERE hire_date < '01-Jan-1996';

SELECT job_id
FROM employees;

SELECT DISTINCT job_id
FROM employees;

SELECT DISTINCT job_id,
department_id
FROM employees;

SELECT SUM(salary)
FROM employees
WHERE department_id = 90;

SELECT SUM(DISTINCT salary)
FROM employees
WHERE department_id = 90;

SELECT COUNT (DISTINCT
job_id)
FROM employees;

SELECT COUNT (DISTINCT salary)
FROM employees;

SELECT AVG(commission_pct)
FROM employees;

SELECT AVG(COALESCE(commission_pct, 0))
FROM employees;

SELECT AVG(commission_pct)
FROM employees;

SELECT AVG(COALESCE(commission_pct, 0))
FROM employees;