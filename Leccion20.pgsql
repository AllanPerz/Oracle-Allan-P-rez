CREATE TABLE emp
AS select * FROM employees;

CREATE TABLE dept
AS select * FROM departments;

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'emp';

ALTER TABLE emp
ALTER COLUMN department_id TYPE INTEGER USING department_id::integer;

ALTER TABLE emp
ADD CONSTRAINT FK_emp_dept
FOREIGN KEY (department_id)
REFERENCES dept (department_id) -- ¡Probablemente esto es lo que necesitas!
ON DELETE CASCADE;

SELECT COUNT(*) AS "Num emps"
FROM emp;

DELETE FROM dept
WHERE department_id = 10;

SELECT COUNT(*) AS "Num emps"
FROM emp;

CREATE VIEW V2 AS
SELECT
    d.department_name,
    MAX(e.salary) AS highest_salary,
    MIN(e.salary) AS lowest_salary,
    AVG(e.salary) AS average_salary
FROM
    emp e
JOIN
    dept d ON e.department_id = d.department_id
GROUP BY
    d.department_name;

CREATE SEQUENCE ct_seq;

SELECT nextval('ct_seq');

SELECT nextval('ct_seq');

SELECT currval('ct_seq');

CREATE SEQUENCE ct_seq;

SELECT nextval('ct_seq');

ALTER TABLE emp
ADD COLUMN email VARCHAR(100);

ALTER TABLE emp
ADD COLUMN phone_number VARCHAR(20);

INSERT INTO emp (
    id,
    first_name,
    last_name,
    email,
    phone_number,
    hire_date,
    job_id,
    salary,
    commission_pct,
    manager_id,
    department_id
) VALUES (
    nextval('ct_seq'),
    'Kaare',
    'Hansen',
    'KHANSEN',
    '4496583212',
    CURRENT_DATE,
    'Manager',
    6500,
    NULL,
    100,
    10
);
