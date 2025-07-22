INSERT INTO COUNTRIES (COUNTRY_ID, COUNTRY_NAME, REGION_ID) VALUES
('CA', 'Canada', 2),
('DE', 'Germany', 1),
('UK', 'United Kingdom', 1),
('US', 'United States of America', 2);

SELECT *
FROM countries;

SELECT country_id, country_name, region_id
FROM countries; 

CREATE TABLE Employees (
    ID INT PRIMARY KEY,
    FIRST_NAME VARCHAR(50),
    LAST_NAME VARCHAR(50),
    SALARY INT
);

INSERT INTO EMPLOYEES (ID, FIRST_NAME, LAST_NAME, SALARY) VALUES
(10, 'John', 'Doe', 4000),
(20, 'Jane', 'Jones', 3000),
(30, 'Sylvia', 'Smith', 5000),
(40, 'Hai', 'Nguyen', 6000);

CREATE TABLE Locations (
    LOCATION_ID INT PRIMARY KEY,
    CITY VARCHAR(50),
    STATE_PROVINCE VARCHAR(50)
);

INSERT INTO Locations (LOCATION_ID, CITY, STATE_PROVINCE) VALUES
(1800, 'Toronto', 'Ontario'),
(2500, 'Oxford', 'Oxford'),
(1400, 'Southlake', 'Texas'),
(1500, 'South San Francisco', 'California'),
(1700, 'Seattle', 'Washington');

SELECT location_id, city, state_province
FROM locations;

SELECT last_name, salary, salary + 300
FROM employees;

INSERT INTO EMPLOYEES (ID, FIRST_NAME, LAST_NAME, SALARY) VALUES
(100, 'Steven', 'King', 24000),
(101, 'Neena', 'Kochhar', 17000),
(102, 'Lex', 'De Haan', 17000),
(103, 'Elisabeth', 'Whalen', 4400),
(104, 'Adam', 'Higgins', 12000),
(105, 'Laura', 'Gietz', 8300),
(106, 'David', 'Zlotkey', 10500);

SELECT last_name, salary, 12 * salary + 100 AS "12*SALARY+100"
FROM employees;

SELECT last_name, salary, 12 * (salary + 100) AS "12*(SALARY+100)"
FROM employees;

ALTER TABLE EMPLOYEES
ADD COLUMN JOB_ID VARCHAR(20),
ADD COLUMN COMMISSION_PCT NUMERIC(3,2);

SELECT last_name, job_id, salary, commission_pct, 
salary*commission_pct
FROM employees;

SELECT last_name AS name,  
commission_pct AS comm
FROM employees;

SELECT last_name AS "Name",      
       salary * 12 AS "Annual Salary" 
FROM employees;