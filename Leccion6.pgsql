CREATE TABLE jobs (
    JOB_ID VARCHAR(10) PRIMARY KEY,
    JOB_TITLE VARCHAR(50) NOT NULL 
);

INSERT INTO jobs (JOB_ID, JOB_TITLE) VALUES
('AD_PRES', 'President'),
('AD_VP', 'Administration Vice President'),
('AD_ASST', 'Administration Assistant'),
('AC_MGR', 'Accounting Manager'),
('AC_ACCOUNT', 'Public Accountant'),
('SA_MAN', 'Sales Manager');

SELECT first_name, last_name, job_id, job_title
FROM employees NATURAL JOIN jobs
WHERE department_id > 80;

SELECT first_name, last_name, job_id, job_title
FROM employees NATURAL JOIN jobs
WHERE department_id > 10;

SELECT department_name, city
FROM departments NATURAL JOIN
locations;

SELECT last_name, department_name
FROM employees CROSS JOIN
departments;

SELECT first_name, last_name, department_id, department_name
FROM employees JOIN departments USING (department_id);

SELECT first_name, last_name, department_id, department_name
FROM employees JOIN departments USING (department_id)
WHERE last_name = 'Higgins';

SELECT last_name, job_title
FROM employees e JOIN jobs j
ON (e.job_id = j.job_id);

SELECT last_name, job_title
FROM employees e JOIN jobs j
ON (e.job_id = j.job_id);

SELECT last_name, job_title
FROM employees e JOIN jobs j
ON (e.job_id = j.job_id)
WHERE last_name LIKE 'H%';

CREATE TABLE job_grades (
    GRADE_LEVEL CHAR(1) PRIMARY KEY, 
    LOWEST_SAL NUMERIC(8, 2) NOT NULL, 
    HIGHEST_SAL NUMERIC(8, 2) NOT NULL 
);

INSERT INTO job_grades (GRADE_LEVEL, LOWEST_SAL, HIGHEST_SAL) VALUES
('A', 1000, 2999),
('B', 3000, 5999),
('C', 6000, 9999),
('D', 10000, 14999),
('E', 15000, 24999),
('F', 25000, 40000);

SELECT last_name, salary, grade_level, lowest_sal,
highest_sal
FROM employees JOIN job_grades
ON(salary BETWEEN lowest_sal AND highest_sal); 

SELECT last_name, department_name AS "Department", city
FROM employees JOIN departments USING (department_id)
JOIN locations USING (location_id);

SELECT e.last_name, d.department_id,
d.department_name
FROM employees e LEFT OUTER JOIN
departments d
ON (e.department_id =
d.department_id);

SELECT e.last_name, d.department_id,
d.department_name
FROM employees e RIGHT OUTER JOIN
departments d
ON (e.department_id =
d.department_id);

CREATE TABLE job_history (
    id INTEGER NOT NULL,            
    start_date DATE NOT NULL,               
    end_date DATE NOT NULL,               
    job_id VARCHAR(10) NOT NULL,            
    department_id INTEGER,                   


    PRIMARY KEY (id, start_date),

    FOREIGN KEY (id) REFERENCES employees(id),
    FOREIGN KEY (job_id) REFERENCES jobs(JOB_ID)
);

SELECT last_name, e.job_id AS "Job", jh.job_id AS "Old job",
end_date
FROM employees e LEFT OUTER JOIN job_history jh
ON(e.id = jh.id);

ALTER TABLE employees
ADD COLUMN manager_id INTEGER;

ALTER TABLE employees
ADD CONSTRAINT fk_manager
FOREIGN KEY (manager_id) REFERENCES employees(id);

UPDATE employees
SET manager_id =
    CASE id
        WHEN 101 THEN 100
        WHEN 102 THEN 100 
        WHEN 103 THEN 102 
        WHEN 104 THEN 103
        WHEN 124 THEN 100 
        ELSE manager_id 
    END
WHERE id IN (100, 101, 102, 103, 104, 107, 124);

SELECT worker.last_name, worker.manager_id, manager.last_name
AS "Manager name"
FROM employees worker JOIN employees manager
ON (worker.manager_id = manager.id);

SELECT
    e.id AS employee_id,
    e.last_name,
    e.job_id,
    e.manager_id,
    1 AS level
FROM
    employees e
WHERE
    e.id = 100;

WITH RECURSIVE employee_hierarchy AS (
    SELECT
        e.id AS employee_id,
        e.last_name,
        e.job_id,
        e.manager_id,
        CAST(e.last_name AS TEXT) AS path_string, 
        1 AS level
    FROM
        employees e
    WHERE
        e.last_name = 'King'

    UNION ALL

    SELECT
        e.id AS employee_id,
        e.last_name,
        e.job_id,
        e.manager_id,
        eh.path_string || ' reports to ' || e.last_name, 
        eh.level + 1
    FROM
        employees e
    INNER JOIN employee_hierarchy eh ON e.manager_id = eh.employee_id 
)
SELECT
    last_name || ' reports to ' || (SELECT last_name FROM employees WHERE id = eh.manager_id) AS "Walk Top Down"

FROM
    employee_hierarchy eh
WHERE
    eh.manager_id IS NOT NULL;

WITH RECURSIVE employee_hierarchy AS (

    SELECT
        e.id AS employee_id,
        e.last_name,
        e.job_id,
        e.manager_id,
        CAST(NULL AS TEXT) AS manager_last_name, 
        1 AS level
    FROM
        employees e
    WHERE
        e.last_name = 'King'

    UNION ALL

    -- Recursive member
    SELECT
        e.id AS employee_id,
        e.last_name,
        e.job_id,
        e.manager_id,
        eh.last_name AS manager_last_name,
        eh.level + 1
    FROM
        employees e
    INNER JOIN employee_hierarchy eh ON e.manager_id = eh.employee_id
)
SELECT
    eh.level,
    eh.last_name || ' reports to ' || COALESCE(eh.manager_last_name, '') AS "Walk Top Down"
FROM
    employee_hierarchy eh;

WITH RECURSIVE employee_hierarchy AS (

    SELECT
        e.id AS employee_id,
        e.last_name,
        e.manager_id,
        1 AS level 
    FROM
        employees e
    WHERE
        e.last_name = 'King'

    UNION ALL

    SELECT
        e.id AS employee_id,
        e.last_name,
        e.manager_id,
        eh.level + 1 AS level
    FROM
        employees e
    INNER JOIN employee_hierarchy eh ON e.manager_id = eh.employee_id
)
SELECT
    LPAD(eh.last_name, LENGTH(eh.last_name) + (eh.level * 2) - 2, '_') AS "Org Chart"
FROM
    employee_hierarchy eh;

WITH RECURSIVE employee_hierarchy AS (
    SELECT
        e.id AS employee_id,
        e.last_name,
        e.manager_id,
        1 AS level
    FROM
        employees e
    WHERE
        e.last_name = 'Grant' 
    UNION ALL

    SELECT
        e.id AS employee_id,
        e.last_name,
        e.manager_id,
        eh.level + 1 AS level
    FROM
        employees e
    INNER JOIN employee_hierarchy eh ON e.id = eh.manager_id)
                                                          
SELECT
    LPAD(eh.last_name, LENGTH(eh.last_name) + (eh.level * 2) - 2, '_') AS "ORG_CHART"
FROM
    employee_hierarchy eh;

WITH RECURSIVE employee_hierarchy AS (
    SELECT
        e.id AS employee_id,
        e.last_name,
        e.manager_id
    FROM
        employees e
    WHERE
        e.last_name = 'Kochhar'

    UNION ALL

    SELECT
        e.id AS employee_id,
        e.last_name,
        e.manager_id
    FROM
        employees e
    INNER JOIN employee_hierarchy eh ON e.manager_id = eh.employee_id
)
SELECT
    last_name
FROM
    employee_hierarchy
WHERE
    last_name != 'Higgins';