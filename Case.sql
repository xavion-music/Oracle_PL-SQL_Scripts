--CASE expression
/*--when you have exact match
-- Simple CASE expression:
CASE input_expression
WHEN when_expression THEN result_expression [ ...n ]
[ ELSE else_result_expression ]
END
*/
select *from hr.locations;
select location_id,street_address,city,state_province,
case country_id
when 'IT' then 'Italy'
when 'JP' then 'Japan'
when 'US' then 'United States'
when 'CA' then 'Canada'
else 'others'
end as country_name
from hr.locations;





/*--range matched
-- Searched CASE expression:
CASE
WHEN Boolean_expression THEN result_expression [ ...n ]
[ ELSE else_result_expression ]
END
*/

/*--range matched
-- Searched CASE expression:
CASE
WHEN Boolean_expression THEN result_expression [ ...n ]
[ ELSE else_result_expression ]
END
*/

select *from hr.employees;
select employee_id,first_name,salary,
case
when extract(year from hire_date)<2003 then 'hired before 2003'
when extract(year from hire_date)<2005 then 'hired in between 2003 and 2005'
when extract(year from hire_date)<2008 then 'hired in between 2005 and 2008'
else 'hired after 2008'
end as YearOfHire
from hr.employees;

-- Activity practice case

SET SERVEROUTPUT ON;

DECLARE
  CURSOR emp_cur IS
    SELECT employee_id, first_name, last_name, salary
    FROM employees;

  v_emp_id employees.employee_id%TYPE;
  v_fname employees.first_name%TYPE;
  v_lname employees.last_name%TYPE;
  v_salary employees.salary%TYPE;
  v_category VARCHAR2(10);
BEGIN
  OPEN emp_cur;
  LOOP
    FETCH emp_cur INTO v_emp_id, v_fname, v_lname, v_salary;
    EXIT WHEN emp_cur%NOTFOUND;
    
    -- Using CASE inside PL/SQL
    CASE 
      WHEN v_salary > 10000 THEN
        v_category := 'High';
      WHEN v_salary > 6000 THEN
        v_category := 'Medium';
      ELSE
        v_category := 'Low';
    END CASE;
    
    DBMS_OUTPUT.PUT_LINE('ID: ' || v_emp_id || ', Name: ' || v_fname || ' ' || v_lname || ', Category: ' || v_category);
  END LOOP;
  CLOSE emp_cur;
END;
/



