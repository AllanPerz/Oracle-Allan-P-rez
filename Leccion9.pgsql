
CREATE TABLE students (
    id INT PRIMARY KEY,
    height DECIMAL(5, 2),
    year_in_school INT
);

INSERT INTO students (id, height, year_in_school) VALUES
(1, 1.70, 10),
(2, 1.65, 10),
(3, 1.78, 10),
(4, 1.60, 10),
(5, 1.72, 11),
(6, 1.80, 11),
(7, 1.68, 11),
(8, 1.75, 11),
(9, 1.85, 12),
(10, 1.70, 12),
(11, 1.90, 12),
(12, 1.77, 12);

SELECT AVG(height) FROM students;

SELECT AVG(height) FROM students WHERE year_in_school = 10;
SELECT AVG(height) FROM students WHERE year_in_school = 11;
SELECT AVG(height) FROM students WHERE year_in_school = 12;

SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id
ORDER BY department_id;

SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id
ORDER BY department_id;

SELECT MAX(salary)
FROM employees
GROUP BY department_id;

SELECT department_id, MAX(salary)
FROM employees
GROUP BY department_id;

SELECT COUNT(country_name), country_id
FROM wf_countries
GROUP BY country_id
ORDER BY country_id;

SELECT COUNT(*), country_id
FROM wf_countries
GROUP BY country_id
ORDER BY country_id;

SELECT department_id, MAX(salary)
FROM employees
WHERE last_name != 'King'
GROUP BY department_id;

ALTER TABLE wf_countries
ADD COLUMN population INT;

UPDATE wf_countries
SET population = CASE country_id
    WHEN 1 THEN 38000000 
    WHEN 2 THEN 5200000  
    WHEN 3 THEN 600000   
    WHEN 4 THEN 56000    
    WHEN 5 THEN 11000000 
    WHEN 6 THEN 3600000 
    ELSE population      
END
WHERE country_id IN (1, 2, 3, 4, 5, 6);

SELECT country_id, ROUND(AVG(population)) AS population
FROM wf_countries
GROUP BY country_id
ORDER BY country_id;

CREATE TABLE wf_spoken_languages (
    country_id INT,
    language_id INT,
    PRIMARY KEY (country_id, language_id) 
);

INSERT INTO wf_spoken_languages (country_id, language_id) VALUES
(1, 2),
(1, 3),
(2, 1),
(3, 4),
(4, 5),
(4, 2),
(4, 6),
(5, 1),
(6, 7),
(6, 8),
(6, 2);

SELECT country_id, COUNT(language_id) AS "Number of
languages"
FROM wf_spoken_languages
GROUP BY country_id;

SELECT department_id, job_id,
count(*)
FROM employees
WHERE department_id > 40
GROUP BY department_id, job_id;

SELECT department_id, job_id,
count(*)
FROM employees
WHERE department_id > 40
GROUP BY department_id, job_id;

SELECT department_id,MAX(salary)
FROM employees
GROUP BY department_id
HAVING COUNT(*)>1
ORDER BY department_id;

SELECT country_id,
ROUND(AVG(population))
FROM wf_countries
GROUP BY country_id
HAVING MIN(population)>300000
ORDER BY country_id;

SELECT AVG(height) FROM students;

SELECT AVG(height) FROM students WHERE year_in_school = 10;
SELECT AVG(height) FROM students WHERE year_in_school = 11;
SELECT AVG(height) FROM students WHERE year_in_school = 12;

SELECT department_id, job_id, SUM(salary)
FROM employees
WHERE department_id < 50
GROUP BY (department_id, job_id);

SELECT department_id, job_id, SUM(salary)
FROM employees
WHERE department_id < 50
GROUP BY CUBE (department_id, job_id);

SELECT department_id, job_id, manager_id, SUM(salary)
FROM employees
WHERE department_id < 50
GROUP BY GROUPING SETS
((job_id, manager_id),(department_id, job_id),
(department_id, manager_id));

SELECT department_id, job_id, SUM(salary),
GROUPING(department_id) AS "Dept sub total",
GROUPING(job_id) AS "Job sub total"
FROM employees
WHERE department_id < 50
GROUP BY CUBE (department_id, job_id);

CREATE TABLE A (
    A_ID INT PRIMARY KEY
);

CREATE TABLE B (
    B_ID INT PRIMARY KEY
);

INSERT INTO A (A_ID) VALUES
(1),
(2),
(3),
(4),
(5);

INSERT INTO B (B_ID) VALUES
(4),
(5),
(6),
(7),
(8);

SELECT a_id
FROM a
UNION
SELECT b_id
FROM b; 

SELECT a_id
FROM a
UNION ALL
SELECT b_id
FROM b;

SELECT a_id
FROM a
INTERSECT
SELECT b_id
FROM b;

SELECT a_id
FROM a
EXCEPT
SELECT b_id
FROM b;

SELECT hire_date, id, job_id
FROM employees
UNION
SELECT NULL::date, id, job_id
FROM job_history;

SELECT hire_date, id, job_id
FROM employees
UNION
SELECT NULL::date, id, job_id
FROM job_history
ORDER BY id;

SELECT hire_date, id, job_id
FROM employees
UNION
SELECT NULL::date, id, job_id
FROM job_history
ORDER BY id;

SELECT
    hire_date,
    id,
    NULL::date AS start_date,  
    NULL::date AS end_date,    
    job_id,
    department_id
FROM
    employees
UNION
SELECT
    NULL::date AS hire_date, 
    id,
    start_date,
    end_date,
    job_id,
    department_id
FROM
    job_history
ORDER BY
    id;