CREATE VIEW view_employees
AS SELECT id,first_name, last_name
FROM employees
WHERE id BETWEEN 100 and 124;

SELECT *
FROM view_employees;

/*CREATE [OR REPLACE] [FORCE| NOFORCE] VIEW view [(alias [,
alias]...)] AS subquery
[WITH CHECK OPTION [CONSTRAINT constraint]]
[WITH READ ONLY [CONSTRAINT constraint]];*/

ALTER TABLE wf_countries
ADD COLUMN region_id INTEGER;

ALTER TABLE wf_countries
ADD COLUMN capital VARCHAR(100);

UPDATE wf_countries
SET
    region_id = 1,
    capital = 'Ottawa'
WHERE country_id = 1;

UPDATE wf_countries
SET
    region_id = 2,
    capital = 'San José'
WHERE country_id = 2; 

UPDATE wf_countries
SET
    region_id = 3,
    capital = 'Praia'
WHERE country_id = 3; 

UPDATE wf_countries
SET
    region_id = 1,
    capital = 'Nuuk'
WHERE country_id = 4;

UPDATE wf_countries
SET
    region_id = 4,
    capital = 'Santo Domingo'
WHERE country_id = 5;

UPDATE wf_countries
SET
    region_id = 3,
    capital = 'Asmara'
WHERE country_id = 6;

ALTER TABLE wf_countries
ADD COLUMN location VARCHAR(100);

UPDATE wf_countries
SET location = CASE country_id
    WHEN 1 THEN 'Norteamérica'
    WHEN 2 THEN 'Centroamérica'
    WHEN 3 THEN 'África'
    WHEN 4 THEN 'Norteamérica'
    WHEN 5 THEN 'Caribe'
    WHEN 6 THEN 'África'
    ELSE NULL
END
WHERE country_id IN (1, 2, 3, 4, 5, 6);

CREATE OR REPLACE VIEW view_euro_countries
AS SELECT country_id, region_id, country_name, capital
FROM wf_countries
WHERE location LIKE 'Norteamérica';

SELECT * FROM view_euro_countries
ORDER BY country_name;

CREATE OR REPLACE VIEW view_euro_countries
AS SELECT country_id, country_name, capital
FROM wf_countries
WHERE location LIKE '%Norteamérica';


CREATE TABLE wf_world_regions (
    region_id INTEGER PRIMARY KEY,
    region_name VARCHAR(100) UNIQUE NOT NULL
);

INSERT INTO wf_world_regions (region_id, region_name) VALUES
(1, 'Norteamérica'),
(2, 'Centroamérica'),
(3, 'África'),
(4, 'Caribe'),
(5, 'Europa');

CREATE OR REPLACE VIEW view_high_pop
("Region ID", "Highest
population")
AS SELECT region_id, MAX(population)
FROM wf_countries
GROUP BY region_id;

SELECT * FROM view_high_pop;

CREATE VIEW view_dept50
AS SELECT department_id,
employee_id,first_name, last_name,
salary
FROM copy_employees
WHERE department_id = 50;

SELECT * FROM
view_dept50;

UPDATE view_dept50
SET department_id = 90
WHERE employee_id = 124;

CREATE OR REPLACE VIEW view_dept50
AS SELECT department_id, employee_id, first_name, last_name, salary
FROM employees
WHERE department_id = 50
WITH CHECK OPTION CONSTRAINT view_dept50_check;

CREATE OR REPLACE VIEW view_dept50
AS SELECT department_id, employee_id, first_name, last_name,
salary
FROM employees
WHERE department_id = 50
WITH READ ONLY;

/*DROP VIEW viewname;*/

SELECT e.last_name, e.salary, e.department_id, d.maxsal
FROM employees e,
(SELECT department_id, max(salary) maxsal
FROM employees
GROUP BY department_id) d
WHERE e.department_id = d.department_id
AND e.salary = d.maxsal;

SELECT
    last_name,
    hire_date
FROM
    employees
ORDER BY
    hire_date ASC 
LIMIT 5;