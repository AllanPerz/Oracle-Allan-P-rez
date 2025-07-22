SELECT (319/29) + 12;

SELECT last_name
FROM employees
WHERE LOWER(last_name) = 'abel';

SELECT last_name
FROM employees
WHERE UPPER(last_name) = 'ABEL';

SELECT last_name
FROM employees
WHERE INITCAP(last_name) = 'Abel';

SELECT CONCAT('Hello', 'World');

SELECT CONCAT(first_name, last_name)
FROM employees;

SELECT SUBSTR('HelloWorld',1,5);

SELECT SUBSTR('HelloWorld', 6);

SELECT SUBSTR(last_name,1,3)
FROM employees;

SELECT LENGTH('HelloWorld');

SELECT LENGTH(last_name)
FROM employees;

SELECT POSITION('W' IN 'HelloWorld');

SELECT last_name, POSITION('a' IN last_name)
FROM employees;

SELECT LPAD('HelloWorld',15, '-');

SELECT LPAD(last_name, 10,'*')
FROM employees;

SELECT RPAD('HelloWorld',15, '-');

SELECT RPAD(last_name, 10,'*')
FROM employees;

SELECT TRIM(LEADING 'a' FROM 'abcba');

SELECT TRIM(TRAILING 'a' FROM 'abcba');

SELECT TRIM(BOTH 'a' FROM 'abcba');

/* REPLACE (string1, string_to_replace, [replacement_string] )*/

SELECT REPLACE('JACK and JUE','J','BL');

/*SELECT REPLACE('JACK and JUE','J'); Me tira error */

SELECT REPLACE(last_name,'a','*')
FROM employees;

SELECT LOWER(last_name)||
LOWER(SUBSTR(first_name,1,1))
AS "User Name"
FROM employees;

CREATE TABLE f_staffs (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

INSERT INTO f_staffs (first_name, last_name) VALUES
('Sarah', 'Doe'),
('Ben', 'Miller'),
('Mark', 'Tuttle');

SELECT LOWER (last_name) || LOWER (SUBSTR(first_name,1,1))
FROM f_staffs;

SELECT first_name, last_name, salary, department_id
FROM employees
WHERE department_id= 20;

SELECT first_name, last_name, salary, department_id
FROM employees
WHERE department_id= 30;

SELECT first_name, last_name, salary, department_id
FROM employees
WHERE department_id= 40;

/*SELECT *
FROM employees
WHERE last_name = :l_name;*/

/* ROUND(column|expression, decimal places)
   TRUNC(column|expression, decimal places
*/

CREATE TABLE wf_countries (
    country_id SERIAL PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL,
    airports INTEGER NOT NULL
);

INSERT INTO wf_countries (country_name, airports) VALUES
('Canada', 5),
('Republic of Costa Rica', 2),
('Republic of Cape Verde', 1),
('Greenland', 0),
('Dominican Republic', 4),
('State of Eritrea', 3);

SELECT country_name, MOD(airports,2)
AS "Mod Demo"
FROM wf_countries;

SELECT CURRENT_DATE;

SELECT last_name, hire_date + 60
FROM employees;

SELECT last_name, (CURRENT_DATE -
hire_date)/7
FROM employees; 

SELECT employee_id, (end_date -
start_date)/365
AS "Tenure in last job"
FROM job_history;

SELECT last_name, hire_date
FROM employees
WHERE (EXTRACT(YEAR FROM AGE(NOW(), hire_date)) * 12 + EXTRACT(MONTH FROM AGE(NOW(), hire_date))) > 240;

SELECT (NOW() + INTERVAL '12 months')::date AS "Next Year";

SELECT (DATE_TRUNC('month', CURRENT_DATE) + INTERVAL '1 month' - INTERVAL '1 day')::date AS "End of the Month";

SELECT
    hire_date,
    (CASE
        WHEN EXTRACT(DAY FROM hire_date) >= 16 THEN DATE_TRUNC('month', hire_date + INTERVAL '1 month')::date
        ELSE DATE_TRUNC('month', hire_date)::date
    END) AS rounded_to_month,
    (CASE
        WHEN EXTRACT(MONTH FROM hire_date) >= 7 THEN DATE_TRUNC('year', hire_date + INTERVAL '1 year')::date
        ELSE DATE_TRUNC('year', hire_date)::date
    END) AS rounded_to_year
FROM
    employees
WHERE
    department_id = 20;

SELECT last_name, hire_date + 60
FROM employees;

SELECT last_name, (CURRENT_DATE -
hire_date)/7
FROM employees;

SELECT 101 AS employee_id,
('2025-07-20'::date - '2023-01-15'::date) / 365.0 AS "Tenure in last job_Years",
(AGE('2025-07-20'::date, '2023-01-15'::date)) AS "Tenure in last job_Interval";