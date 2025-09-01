-- File Name: Palak_DBAS32100_991708879.sql
-- Name: Palak Yogesh Chaudhary
-- Oracle Username: S1_CHAUPALA

-- Question 1:
-- Create a procedure that:
-- Takes job ID and increment percentage
-- Updates salary of all employees with that job ID
-- Prints number of rows updated
-- Call it with an anonymous block

set serveroutput on;

CREATE OR REPLACE PROCEDURE update_salary_by_job (
p_job_id IN employees.job_id%TYPE,
p_percent IN NUMBER
)
AS
v_count NUMBER := 0;
BEGIN
UPDATE employees
SET salary = salary + (salary * p_percent / 100)
WHERE job_id = p_job_id;

v_count := SQL%ROWCOUNT;
DBMS_OUTPUT.PUT_LINE(v_count || ' employee(s) updated.');
EXCEPTION
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

BEGIN
update_salary_by_job('IT_PROG', 10);
END;
/


-- Question 2:
-- FUNCTION that:
-- Accepts employee_id
-- Returns YES if salary > 10000, NO otherwise, NOT FOUND if ID does not exist
-- Call it with anonymous block and print result

set serveroutput on;

CREATE OR REPLACE FUNCTION check_salary (
p_emp_id IN employees.employee_id%TYPE
) RETURN VARCHAR2
AS
v_salary employees.salary%TYPE;
BEGIN
SELECT salary INTO v_salary
FROM employees
WHERE employee_id = p_emp_id;

IF v_salary > 10000 THEN
RETURN 'YES';
ELSE
RETURN 'NO';
END IF;

EXCEPTION
WHEN NO_DATA_FOUND THEN
RETURN 'NOT FOUND';
WHEN OTHERS THEN
RETURN 'ERROR';
END;
/

DECLARE
v_result VARCHAR2(20);
BEGIN
v_result := check_salary(100);
DBMS_OUTPUT.PUT_LINE('Salary check result: ' || v_result);
END;
/
