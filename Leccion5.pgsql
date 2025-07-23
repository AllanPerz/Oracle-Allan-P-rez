/* TO_CHAR (date column name, 'format model you specify') */

SELECT TO_CHAR(hire_date, 'Month dd, YYYY')
FROM employees;

SELECT TO_CHAR(hire_date, 'fmMonth dd, YYYY')
FROM employees;

SELECT TO_CHAR(hire_date, 'fmMonth ddth, YYYY')
FROM employees;

SELECT TO_CHAR(hire_date, 'fmDay ddth Mon, YYYY')
FROM employees;

SELECT TO_CHAR(hire_date, 'fmDay ddthsp Mon, YYYY')
FROM employees;

SELECT TO_CHAR(hire_date, 'fmDay, ddthsp "of" Month, Year')
FROM employees;

SELECT TO_CHAR(CURRENT_DATE, 'hh:mm');

SELECT TO_CHAR(CURRENT_DATE, 'hh:mm pm');

SELECT TO_CHAR(CURRENT_DATE, 'hh:mm:ss pm');

/* TO_CHAR(number, 'format model') */

SELECT TO_CHAR(salary,
'$99,999') AS "Salary"
FROM employees;

/* TO_NUMBER(character string, 'format model') */

SELECT TO_NUMBER('5,320', '9,999')
AS "Number";

SELECT * FROM employees;

ALTER TABLE employees
ADD COLUMN bonus NUMERIC(10, 2);

UPDATE employees
SET bonus =
    CASE
        WHEN department_id = 80 THEN salary * 0.10 
        WHEN department_id = 90 THEN salary * 0.15 
        WHEN job_id = 'AD_PRES' THEN 10000 
        WHEN job_id = 'SA_MAN' THEN 5000 
        ELSE salary * 0.05 
    END
WHERE bonus IS NULL;

SELECT last_name, bonus::NUMERIC
FROM employees
WHERE department_id = 80;

/* TO_DATE('character string', 'format model') 
   TO_DATE('November 3, 2001', 'Month dd, yyyy') 
*/ 

SELECT TO_DATE('May10,1989', 'fxMonDD,YYYY')
AS "Convert";

SELECT TO_DATE('Sep 07, 1965', 'fxMon dd, YYYY') AS "Date";

SELECT TO_DATE('July312004', 'fxMonthDDYYYY') AS "Date";

SELECT TO_DATE('June 19, 1990','fxMonth dd, YYYY') AS "Date";

SELECT TO_DATE('27-Oct-95','DD-Mon-YY')
AS "Date";

SELECT TO_DATE('27-Oct-95','DD-Mon-RR')
AS "Date";

SELECT last_name, TO_CHAR(hire_date, 'DD-Mon-YY')
FROM employees
WHERE hire_date < TO_DATE('01-Jan-90','DD-Mon-YY'); 

SELECT
    TO_CHAR(
        (hire_date + INTERVAL '6 months' + INTERVAL '1 day' * (
            (5 - EXTRACT(DOW FROM (hire_date + INTERVAL '6 months')) + 7) % 7
        )),
        'Day, Month DD, YYYY'
    ) AS "Next Evaluation"
FROM
    employees
WHERE
    id = 100;

/* NVL (expression 1 value that may contain a null, expression 2
value to substitute for null) */


ALTER TABLE wf_countries
ADD COLUMN internet_extension VARCHAR(10);

UPDATE countries
SET internet_extension =
    CASE country_name
        WHEN 'Canada' THEN '.ca'
        WHEN 'Republic of Costa Rica' THEN '.cr'
        WHEN 'Republic of Cape Verde' THEN '.cv'
        WHEN 'Greenland' THEN '.gl'
        WHEN 'Dominican Republic' THEN '.do'
        WHEN 'State of Eritrea' THEN '.er'
        ELSE NULL
    END;

SELECT country_name, COALESCE(internet_extension, 'None') 
AS "Internet extn"
FROM wf_countries
WHERE country_name = 'Canada'
ORDER BY internet_extension DESC;

SELECT last_name, COALESCE(commission_pct, 0)
FROM employees
WHERE department_id IN(80,90);

ALTER TABLE wf_countries
ADD COLUMN date_of_independence DATE;

UPDATE wf_countries
SET date_of_independence =
    CASE country_name
        WHEN 'Canada' THEN '1867-07-01'::DATE         
        WHEN 'Republic of Costa Rica' THEN '1821-09-15'::DATE    
        WHEN 'Republic of Cape Verde' THEN '1975-07-05'::DATE  
        WHEN 'Greenland' THEN '1979-05-01'::DATE     
        WHEN 'Dominican Republic' THEN '1844-02-27'::DATE 
        WHEN 'State of Eritrea' THEN '1993-05-24'::DATE   
        ELSE NULL 
    END
WHERE country_name IN (
    'Canada',
    'Republic of Costa Rica',
    'Republic of Cape Verde',
    'Greenland',
    'Dominican Republic',
    'State of Eritrea'
);

SELECT COALESCE(TO_CHAR(date_of_independence, 'YYYY-MM-DD'), 'No date') AS "Independence Date"
FROM wf_countries;

SELECT last_name, COALESCE(commission_pct, 0) * 250 AS "Commission"
FROM employees
WHERE department_id IN (80, 90);

/* NVL2 (expression 1 value that may contain a null, expression
2 value to return if expression 1 is not null, expression 3
value to replace if expression 1 is null) */

SELECT last_name, salary,
    CASE
        WHEN commission_pct IS NOT NULL THEN salary + (salary * commission_pct)
        ELSE salary
    END AS income
FROM employees
WHERE department_id IN (80, 90);

/* NULLIF(expression 1, expression 2) */

SELECT first_name, LENGTH(first_name) AS "Length FN", last_name,
LENGTH(last_name) AS "Length LN", NULLIF(LENGTH(first_name),
LENGTH(last_name)) AS "Compare Them"
FROM employees;

/* COALESCE (expression 1, expression 2, ...expression n) */

/* COALESCE (expression 1, expression 2, ...expression n) */

SELECT last_name,
COALESCE(commission_pct, salary, 10)
AS "Comm"
FROM employees
ORDER BY commission_pct;

/* CASE expr WHEN comparison_expr1 THEN return_expr1
[WHEN comparison_expr2 THEN return_expr2
WHEN comparison_exprn THEN return_exprn
ELSE else_expr]
END */

SELECT last_name,
CASE department_id
WHEN 90 THEN 'Management'
WHEN 80 THEN 'Sales'
WHEN 60 THEN 'It'
ELSE 'Other dept.'
END AS "Department"
FROM employees;

/* DECODE(columnl|expression, search1, result1
[, search2, result2,...,]
[, default])*/

SELECT last_name,
DECODE(department_id,
90, 'Management',
80, 'Sales',
60, 'It',
'Other dept.')
AS "Department"
FROM employees; --Me da error la funcion DECODE y El equivalente es CASE osea lo mismo anterior

SELECT
    last_name,
    CASE department_id
        WHEN 90 THEN 'Management'
        WHEN 80 THEN 'Sales'
        WHEN 60 THEN 'It'
        ELSE 'Other dept.'
    END AS "Department"
FROM
    employees;

    