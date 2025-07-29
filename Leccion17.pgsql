/*CREATE USER user
IDENTIFIED BY password;*/

CREATE USER scott WITH PASSWORD 'ur35scott';

ALTER USER scott WITH PASSWORD 'imscott35';

GRANT UPDATE (salary) ON employees TO scott;

CREATE ROLE manager;

GRANT CREATE ON SCHEMA public TO manager;

CREATE ROLE jennifer_cho LOGIN PASSWORD 'your_secure_password';

GRANT manager TO jennifer_cho;

/* CREATE ROLE role_name; */

/* GRANT object_priv [(column_list)]
ON object_name
TO {user|role|PUBLIC}
[WITH GRANT OPTION]; */

GRANT SELECT ON clients TO PUBLIC;

GRANT UPDATE (first_name, last_name) ON clients TO jennifer_cho;
GRANT UPDATE (first_name, last_name) ON clients TO manager;

CREATE SCHEMA scott_king;

CREATE TABLE scott_king.clients (
    client_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    address VARCHAR(255),
    salary NUMERIC(10, 2)
);

SELECT * FROM scott_king.clients;

CREATE VIEW clients AS SELECT * FROM scott_king.clients;

SELECT * FROM clients;

CREATE ROLE scott_king LOGIN PASSWORD 'secure_password_for_scott';

GRANT SELECT, INSERT ON clients TO scott_king WITH GRANT OPTION;

GRANT SELECT ON jason_tsang.clients TO PUBLIC;

/*REVOKE {privilege [, privilege...]|ALL}
ON object
FROM {user[, user...]|role|PUBLIC}
[CASCADE CONSTRAINTS];*/

REVOKE SELECT, INSERT ON clients FROM scott_king;

CREATE VIEW HQ_EMP AS
SELECT *
FROM emp;

SELECT first_name, last_name
FROM employees
WHERE first_name ~ '^Ste(v|ph)en$';

SELECT last_name, REGEXP_REPLACE(last_name, '^H[aeiou]', '**') AS "Name changed"
FROM employees;

SELECT country_name, REGEXP_COUNT(country_name, '(ab)') AS "Count of 'ab'"
FROM wf_countries
WHERE REGEXP_COUNT(country_name, '(ab)') > 0;

ALTER TABLE copy_employees
ADD CONSTRAINT email_addr_chk
CHECK (email ~ '@');

CREATE TABLE my_contacts (
    first_name VARCHAR(15),
    last_name VARCHAR(15),
    email VARCHAR(30) CHECK (email ~ '.+@.+\\..+')
);