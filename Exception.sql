--Execption
set serveroutput on
--diplay employee details for the given employee number. print appropriate message if employee number does not exist
accept p_eid prompt 'Enter employee number: '
declare
v_emp hr.employees%rowtype;
begin
select *
into v_emp
from hr.employees e where e.employee_id= &p_eid;

dbms_output.put_line(v_emp.employee_id||chr(32)||v_emp.first_name||chr(32)||v_emp.salary||chr(32)||v_emp.department_id);
Exception
when no_data_found then
dbms_output.put_line('no record found for employee id '||&p_eid);

end;


-- User defined exception
-- Create user defined exception for department having more than 5 employees

accept p_did prompt 'Enter department id: '
declare
empcnt number;
toomanyemp exception;
begin
select count(*)
into empcnt
from hr.employees e where e.department_id=&p_did;

if empcnt <= 5 then
dbms_output.put_line('Department id &p_did has '||empcnt||' employees');
else
raise toomanyemp;
end if;

Exception
when toomanyemp then
dbms_output.put_line('department id &p_did has too many employees');

end;

