-- Task 10: Creating and Using SQL Views
-- SQL Developer Internship - Elevate Labs

USE intern_training_db;

------------------------------------------------
-- 1. Complex query joining employees & departments
------------------------------------------------
SELECT
    e.emp_id,
    e.name AS employee_name,
    e.email,
    e.salary,
    d.department_name,
    d.location
FROM employees e
JOIN departments d
ON e.department_id = d.department_id;

------------------------------------------------
-- 2. Create a VIEW from the complex query
------------------------------------------------
DROP VIEW IF EXISTS employee_department_view;

CREATE VIEW employee_department_view AS
SELECT
    e.emp_id,
    e.name AS employee_name,
    e.email,
    e.salary,
    d.department_name,
    d.location
FROM employees e
JOIN departments d
ON e.department_id = d.department_id;

------------------------------------------------
-- 3. Query data directly from the view
------------------------------------------------
SELECT * FROM employee_department_view;

------------------------------------------------
-- 4. Apply filtering and sorting on the view
------------------------------------------------
SELECT
    employee_name,
    department_name,
    salary
FROM employee_department_view
WHERE salary > 60000
ORDER BY salary DESC;

------------------------------------------------
-- 5. Security & simplicity demonstration
-- Hide salary column for non-HR users
------------------------------------------------
DROP VIEW IF EXISTS employee_public_view;

CREATE VIEW employee_public_view AS
SELECT
    emp_id,
    employee_name,
    department_name
FROM employee_department_view;

SELECT * FROM employee_public_view;

------------------------------------------------
-- 6. Attempt insert through view (will FAIL)
------------------------------------------------
-- INSERT INTO employee_department_view
-- (employee_name, email, salary, department_name)
-- VALUES ('Test User', 'test@company.com', 50000, 'IT');

-- Reason:
-- Views with JOINs are generally NOT updatable

------------------------------------------------
-- 7. Drop and recreate view safely
------------------------------------------------
DROP VIEW IF EXISTS employee_department_view;

CREATE VIEW employee_department_view AS
SELECT
    e.emp_id,
    e.name AS employee_name,
    e.email,
    e.salary,
    d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id;

------------------------------------------------
-- 8. Reporting dashboard use case
-- Monthly salary report by department
------------------------------------------------
SELECT
    department_name,
    COUNT(*) AS employee_count,
    AVG(salary) AS avg_salary
FROM employee_department_view
GROUP BY department_name;
