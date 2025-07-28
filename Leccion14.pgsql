CREATE TABLE clients (
    client_number INTEGER,
    first_name VARCHAR(14),
    last_name VARCHAR(13)
);

CREATE TABLE clients2 (
    client_number INTEGER,
    last_name VARCHAR(13),
    email VARCHAR(80)
);

CREATE TABLE clients
(client_number NUMBER(4),
first_name VARCHAR2(14),
last_name VARCHAR2(13),
CONSTRAINT clients_client_num_pk PRIMARY KEY
(client_number));

CREATE TABLE copy_job_history
(employee_id NUMBER(6,0),
start_date DATE,
job_id VARCHAR2(10),
department_id NUMBER(4,0),
CONSTRAINT copy_jhist_id_st_date_pk PRIMARY KEY(employee_id,
start_date));

CREATE TABLE copy_employees
(employee_id NUMBER(6,0) CONSTRAINT copy_emp_pk PRIMARY KEY,
first_name VARCHAR2(20),
last_name VARCHAR2(25),
department_id NUMBER(4,0) CONSTRAINT c_emps_dept_id_fk
REFERENCES departments(department_id),
email VARCHAR2(25));

CREATE TABLE copy_employees
(employee_id NUMBER(6,0) CONSTRAINT copy_emp_pk PRIMARY KEY,
first_name VARCHAR2(20),
last_name VARCHAR2(25),
department_id NUMBER(4,0),
email VARCHAR2(25),
CONSTRAINT c_emps_dept_id_fk FOREIGN KEY (department_id)
REFERENCES departments(department_id));

CREATE TABLE copy_job_history
(employee_id NUMBER(6,0),
start_date DATE,
end_date DATE,
job_id VARCHAR2(10),
department_id NUMBER(4,0),
CONSTRAINT cjhist_emp_id_st_date_pk
PRIMARY KEY(employee_id, start_date),
CONSTRAINT cjhist_end_ck CHECK (end_date > start_date));

ALTER TABLE employees
ADD CONSTRAINT emp_id_pk PRIMARY KEY (id);

/*ALTER TABLE table_name
ADD [CONSTRAINT constraint_name] type of constraint
(column_name);

ALTER TABLE table_name
ADD [CONSTRAINT constraint_name] type of constraint
(column_name);
*/

ALTER TABLE employees
ADD CONSTRAINT emp_dept_fk FOREIGN KEY (department_id)
REFERENCES departments (department_id) ON DELETE CASCADE;

ALTER TABLE table_name
MODIFY (column_name CONSTRAINT constraint_name NOT NULL);

ALTER TABLE copy_employees
ALTER COLUMN email SET NOT NULL;

/* ALTER TABLE table_name
DROP CONSTRAINT name [CASCADE} */

ALTER TABLE copy_departments
DROP CONSTRAINT c_dept_dept_id_pk CASCADE;

/*ALTER TABLE table_name
DISABLE CONSTRAINT constraint_name [CASCADE];*/

ALTER TABLE copy_departments
DISABLE CONSTRAINT c_dept_dept_id_pk CASCADE;

/*ALTER TABLE table_name
ENABLE CONSTRAINT constraint_name;*/

ALTER TABLE copy_departments
ENABLE CONSTRAINT c_dept_dept_id_pk;

/*ALTER TABLE table_name
DROP(column name(s)) CASCADE CONSTRAINTS;*/

SELECT
    tc.constraint_name,
    tc.table_name,
    tc.constraint_type,
   
    'ENABLED' AS status 
FROM
    information_schema.table_constraints tc
WHERE
    tc.table_name = 'copy_employees' 
    AND tc.table_schema = 'public'; 