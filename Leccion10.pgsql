SELECT first_name, last_name,
hire_date
FROM employees
WHERE hire_date >
(SELECT hire_date
FROM employees
WHERE last_name = 'Vargas');

SELECT last_name
FROM employees
WHERE department_id =
(SELECT department_id
FROM employees
WHERE last_name = 'Grant');

SELECT last_name, job_id, department_id
FROM employees
WHERE department_id =
(SELECT department_id
FROM departments
WHERE department_name = 'Marketing')
ORDER BY job_id;

SELECT last_name, job_id, salary, department_id
FROM employees
WHERE job_id =
(SELECT job_id
FROM employees
WHERE id = 141)
AND department_id =
(SELECT department_id
FROM departments
WHERE location_id = 1500);

SELECT last_name, salary
FROM employees
WHERE salary <
(SELECT AVG(salary)
FROM employees);

SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id
HAVING MIN(salary) >
(SELECT MIN(salary)
FROM employees
WHERE department_id = 50);

/* Ejemplos de sintaxis mal redactadas 
SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id
HAVING MIN(salary) >
(SELECT MIN(salary)
FROM employees
WHERE department_id = 50);

SELECT first_name, last_name
FROM employees
WHERE salary =
(SELECT salary
FROM employees
WHERE department_id = 20); */

SELECT last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) IN
(SELECT EXTRACT(YEAR FROM hire_date)
FROM employees
WHERE department_id=90);

SELECT last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) < ANY
(SELECT EXTRACT(YEAR FROM hire_date)
FROM employees
WHERE department_id=90);

SELECT last_name, hire_date FROM employees
WHERE EXTRACT(YEAR FROM hire_date) < ALL
(SELECT EXTRACT(YEAR FROM hire_date)
FROM employees
WHERE department_id=90);

SELECT last_name,
id
FROM employees
WHERE id IN
(SELECT manager_id
FROM employees);

SELECT last_name, id
FROM employees
WHERE id <= ALL
(SELECT manager_id
FROM employees);

SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id
HAVING MIN(salary) < ANY
(SELECT salary
FROM employees
WHERE department_id IN (10,20))
ORDER BY department_id;

SELECT id, manager_id, department_id
FROM employees
WHERE(manager_id,department_id) IN
(SELECT manager_id,department_id
FROM employees
WHERE id IN (149,174))
AND id NOT IN (149,174);

SELECT id,
manager_id,
department_id
FROM employees
WHERE manager_id IN
(SELECT manager_id
FROM employees
WHERE id IN
(149,174))
AND department_id IN
(SELECT department_id
FROM employees
WHERE id IN
(149,174))
AND id NOT IN(149,174);

SELECT id,
manager_id,
department_id
FROM employees
WHERE manager_id IN
(SELECT manager_id
FROM employees
WHERE id IN
(149,174))
AND department_id IN
(SELECT department_id
FROM employees
WHERE id IN
(149,174))
AND id NOT IN(149,174);

SELECT first_name, last_name,
job_id
FROM employees
WHERE job_id =
(SELECT job_id
FROM employees
WHERE last_name = 'Ernst');

SELECT first_name, last_name,
job_id
FROM employees
WHERE job_id =
(SELECT job_id
FROM employees
WHERE last_name = 'Ernst');

SELECT o.first_name,o.last_name,
o.salary
FROM employees o
WHERE o.salary >
(SELECT AVG(i.salary)
FROM employees i
WHERE i.department_id =
o.department_id);

SELECT last_name AS "Not a Manager"
FROM employees emp
WHERE NOT EXISTS
(SELECT *
FROM employees mgr
WHERE mgr.manager_id = emp.id);

SELECT last_name AS "Not a Manager"
FROM employees emp
WHERE emp.id NOT IN
(SELECT mgr.manager_id
FROM employees mgr);

/* WITH subquery-name AS (subquery),
subquery-name AS (subquery)
SELECT column-list
FROM {table | subquery-name | view}
WHERE condition is true; */

WITH managers AS
(SELECT DISTINCT manager_id
FROM employees
WHERE manager_id IS NOT NULL)
SELECT last_name AS "Not a manager"
FROM employees
WHERE id NOT IN
(SELECT *
FROM managers);