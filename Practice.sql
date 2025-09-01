-- Basic Syntax

SET SERVEROUTPUT ON;

DECLARE 
   message VARCHAR2(20) := 'Hello, World:'; 
BEGIN 
   DBMS_OUTPUT.PUT_LINE(message); 
END; 
/

-- Data Types

SET SERVEROUTPUT ON;

DECLARE
  NUM1 INTEGER; 
  NUM2 REAL;
  NUM3 DOUBLE PRECISION;
BEGIN
  NUM1 := 4;
  NUM2 := 5;
  NUM3 := 6;
  
  DBMS_OUTPUT.PUT_LINE('NUM1 = ' || NUM1);
  DBMS_OUTPUT.PUT_LINE('NUM2 = ' || NUM2);
  DBMS_OUTPUT.PUT_LINE('NUM3 = ' || NUM3);
  
--Aletrnate combine all in one line
--DBMS_OUTPUT.PUT_LINE('NUM1 = ' || NUM1 || ', NUM2 = ' || NUM2 || ', NUM3 = ' || NUM3);
END;
/


-- PL/SQL USER-DEFINED SUBTYPES
SET SERVEROUTPUT ON;

DECLARE

SUBTYPE NAME IS CHAR(20);
SUBTYPE MESSAGE IS VARCHAR2(100);
SALUTATION NAME;
GREETINGS MESSAGE;
BEGIN
SALUTATION := 'READER';
GREETINGS := 'WELCOME TO THE WORLD OF PL/SQL';
DBMS_OUTPUT.PUT_LINE('HELLO '||SALUTATION||GREETINGS);
END;
/

-- VARIABLE DECLARATION IN PL/SQL
SET SERVEROUTPUT ON;

DECLARE 
a integer := 10;
b integer := 20;
c integer;
f REAL;
BEGIN 
c := a+b;
DBMS_OUTPUT.PUT_LINE('VALUE OF C: '||c);
f := 70.0/3.0;
DBMS_OUTPUT.PUT_LINE('VALUE OF F: '||f);
END;
/

--VARIABLE SCOPE IN PL/SQL (LOCAL AND GLOBAL)

SET SERVEROUT ON;

DECLARE 
-- GLOBAL VARIABLES
NUM1 NUMBER := 95;
NUM2 NUMBER := 85;
BEGIN
DBMS_OUTPUT.PUT_LINE('OUTER VARIABLE NUM1: ' || NUM1);
DBMS_OUTPUT.PUT_LINE('OUTER VARIABLE NUM2: ' || NUM2);
DECLARE
--LOCAL VARIABLES
NUM1 NUMBER := 195;
NUM2 NUMBER := 185;
BEGIN
DBMS_OUTPUT.PUT_LINE('INNER VARIABLE NUM1: ' || NUM1);
DBMS_OUTPUT.PUT_LINE('INNER VARIABLE NUM2: ' || NUM2);
END;
END;
/

SET SERVEROUTPUT ON;
SET HEADING OFF;
SET VERIFY OFF;

ACCEPT NAME PROMPT 'ENTER PROSPECT NAME: ';
ACCEPT MAKE PROMPT 'ENTER MAKE: ';
ACCEPT MODEL PROMPT 'ENTER MODEL: ';
ACCEPT YEAR PROMPT 'ENTER YEAR: ';
ACCEPT COLOR PROMPT 'ENTER COLOR: ';
ACCEPT TRIM PROMPT 'ENTER TRIM: ';
ACCEPT CODE PROMPT 'ENTER OPTION CODE: ';

BEGIN
NEW_PROSPECT('&NAME', '&MAKE', '&MODEL', '&YEAR', '&COLOR', '&TRIM', '&CODE');
COMMIT;
END;
/


-- Turn on server output so messages (like DBMS_OUTPUT) are shown
SET SERVEROUTPUT ON;

-- These settings clean up the display
SET HEADING OFF;
SET VERIFY OFF;

-- Ask the user to enter all required info using substitution variables
ACCEPT NAME PROMPT 'ENTER PROSPECT NAME: ';
ACCEPT MAKE PROMPT 'ENTER MAKE (e.g., Toyota, Honda, etc.): ';
ACCEPT MODEL PROMPT 'ENTER MODEL: ';
ACCEPT YEAR PROMPT 'ENTER YEAR (e.g., 2020): ';
ACCEPT COLOR PROMPT 'ENTER COLOR (e.g., Red): ';
ACCEPT TRIM PROMPT 'ENTER TRIM (e.g., XLE): ';
ACCEPT CODE PROMPT 'ENTER OPTION CODE (must be valid from options table): ';

--SELECT OPTIONCODE FROM OPTIONS;
--SELECT DISTINCT carmake FROM car;

-- Use the values entered above to call the procedure
BEGIN
  NEW_PROSPECT(
    '&NAME',
    '&MAKE',
    '&MODEL',
    '&YEAR',
    '&COLOR',
    '&TRIM',
    '&CODE'
  );
  COMMIT; -- Save the data to the database
END;
/

SELECT DISTINCT 'CARMAKES' AS CATEGORY, carmake AS VALUE FROM car
UNION ALL
SELECT DISTINCT 'CARMODELS', carmodel FROM car
UNION ALL
SELECT DISTINCT 'EXTCOLORS', extcolor FROM car
UNION ALL
SELECT DISTINCT 'CARTRIMS', cartrim FROM car
UNION ALL
SELECT 'OPTIONCODES', optioncode FROM options;


---------------- Practice 6/7/25 ----------------------

/* 1. Question: Write a PL/SQL procedure named add_student to insert a new student into the students table.
If the age is less than 18, raise a user-defined exception that prints "Too young for college".
Also, add a system-defined exception for any other error.*/

set SERVEROUTPUT on;
create table students (
student_name varchar2(100),
student_age number
);

create or replace procedure add_student(
nm IN students.student_name%type,
Ag IN students.student_age%type
)
as
too_young exception;
begin
if ag < 18 then
raise too_young;
end if;

insert into students (student_name, student_age)
values (nm, ag);

dbms_output.put_line('student added.');
exception
when too_young then
DBMS_OUTPUT.PUT_LINE('Too young for college');
when others then
dbms_output.put_line('some error occured');
end;
/

begin
add_student('palak', 17);
end;
/


/* 1. Question: Write a PL/SQL procedure named add_student to insert a new student into the students table.
If the age is less than 18, raise a user-defined exception that prints "Too young for college".
Also, add a system-defined exception for any other error.*/

set SERVEROUTPUT on;

create table students(
student_name varchar2(100),
student_age number
);

create or replace procedure add_student(
nm IN students.student_name%type,
ag IN students.student_age%type
)
as
too_young exception;

begin 
if ag < 18 then 
raise too_young;
end if;

insert into students (student_name, student_age)
values (nm,ag);

dbms_output.put_line('student added.');
exception
when too_young then
dbms_output.put_line('too young for college');
when others then
dbms_output.put_line('some error occured');
end;
/

begin
add_student('Ashley', 23);
end;
/


/* 1. Question: Write a PL/SQL procedure named add_student to insert a new student into the students table.
If the age is less than 18, raise a user-defined exception that prints "Too young for college".
Also, add a system-defined exception for any other error.*/

set serveroutput on;
create table students(
student_name varchar2(100),
student_age NUMBER
);

create or replace procedure add_students(
nm IN students.student_name%type,
ag IN students.student_age%type
)
as
too_young exception;

begin
if ag < 18 then
raise too_young;
end if;

insert into students(student_name,student_age)
values(nm, ag);

dbms_output.put_line('student added');
exception
when too_young then
dbms_output.put_line('too young for college');
when others then
dbms_output.put_line('some error occured');
end;
/

begin
add_student('raphael', 16);
end;
/

/* 1. Question: Write a PL/SQL procedure named add_student to insert a new student into the students table.
If the age is less than 18, raise a user-defined exception that prints "Too young for college".
Also, add a system-defined exception for any other error.*/

set serveroutput on;
create table students(
student_name varchar2(100),
student_age number 
)

create or replace procedure add_student(
nm IN students.student_name%type,
ag IN students.student_age%TYPE
)
as
too_young exception;

begin
if ag < 18 then
raise too_young;
end if;

insert into students(student_name, student_age)
values(nm, ag);

dbms_output.put_line('student added');
exception
when too_young then
dbms_output.put_line('too young for college');
when others then
dbms_output.put_line('some error occured');
end;
/

begin
add_student('luke', 45);
end;
/


/* 1. Question: Write a PL/SQL procedure named add_student to insert a new student into the students table.
If the age is less than 18, raise a user-defined exception that prints "Too young for college".
Also, add a system-defined exception for any other error.*/

set serveroutput on;
create table students(
student_name varchar2(100),
student_age number
);

create or replace procedure add_student(
nm IN students.student_name%type,
ag IN students.student_age%type
)
as
too_young exception;

begin
if ag < 18 then
raise too_young;
end if;

insert into students(student_name,student_age)
values(nm, ag);

dbms_output.put_line('student added');
exception
when too_young then
dbms_output.put_line('too young for college');
when others then
dbms_output.put_line('some error occured');
end;
/

begin
add_students('jamal', 13);
end;
/

/* 1. Question: Write a PL/SQL procedure named add_student to insert a new student into the students table.
If the age is less than 18, raise a user-defined exception that prints "Too young for college".
Also, add a system-defined exception for any other error.*/

set serveroutput on;
create table Students(
student_name varchar2(100),
student_age number
);

create or replace procedure add_students(
nm IN students.student_name%type,
ag IN students.student_age%type
)
as
too_young exception;

begin
if ag < 18 then
raise too_young;
end if;

insert into students(student_name, student_age)
values(nm, ag);

dbms_output.put_line('Student accepted successfully');

exception
when too_young then
dbms_output.put_line('too young for college');
when others then
dbms_output.put_line('some error occured');
end;
/

begin
add_students('Pal', 17);
end;
/

/* 2. Create a procedure add_order to insert into orders table.
If the amount is greater than 10,000, raise an exception and print "Amount exceeds limit".
Handle other exceptions generically.*/

set serveroutput on;
create table orders(
order_id number,
customer_name varchar2(100),
amount number
);

create or replace procedure add_order(
o_id IN orders.order_id%type,
nm IN orders.customer_name%type,
am IN orders.amount%type
)
as
too_much exception;

begin
if am > 10000 then
raise too_much;
end if;

insert into orders(order_id, customer_name, amount)
values(o_id, nm, am);

dbms_output.put_line('order placed successfully');

exception
when too_much then
dbms_output.put_line('amount exceeded limit');
when others then
dbms_output.put_line('some error occurred');
end;
/

BEGIN
  add_order(1, 'Palak', 15000); -- Triggers custom exception
END;
/

/* Question 1. Write a procedure get_employee_salary that takes employee_id, prints the salary. 
If no employee found, print "No such employee".*/

set serveroutput on;
create or replace procedure get_employee_salary (
p_emp_id IN employees.salary%type
)
as
v_salary employees.salary%type;

begin
select salary into v_salary
from employees
where employee_id = p_emp_id;

dbms_output.put_line('Salary: ' || v_salary);
exception
when no_data_found then
dbms_output.put_line('no such employee');
end;
/

begin
get_employee_salary(101);
end;
/

/*SELECT * FROM all_tables WHERE table_name = 'EMPLOYEES';

SELECT username, account_status 
FROM dba_users 
WHERE username = 'HR';*/

@C:\Users\palak\Downloads\Database_Management\db-sample-schemas-23.3\human_resources\hr_install.sql

CONNECT HR/hr123;

SELECT employee_id, first_name, last_name, salary
FROM HR.EMPLOYEES
FETCH FIRST 5 ROWS ONLY;

-- Cursorrrrrrrrrrrrrrrrrrrr
set serveroutput on;
DECLARE
  CURSOR emp_cursor IS
    SELECT first_name, salary FROM HR.employees;
  v_name HR.employees.first_name%TYPE;
  v_sal HR.employees.salary%TYPE;
BEGIN
  OPEN emp_cursor;
  LOOP
    FETCH emp_cursor INTO v_name, v_sal;
    EXIT WHEN emp_cursor%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(v_name || ' earns ' || v_sal);
  END LOOP;
  CLOSE emp_cursor;
END;
/

/* Question 1. Write a procedure ADD_EMP to insert a new employee into the EMPLOYEES table. 
It should accept first name, last name, email, salary, job id, and department id.*/

set serveroutput on;
create or replace procedure add_emp (
p_fname IN employees.first_name%type,
p_lname IN employees.last_name%type,
p_email IN employees.email%type,
p_salary IN employees.salary%type,
p_job_id IN employees.job_id%type,
p_dept_id IN employees.department_id%type
)
as

begin
insert into employees(employee_id, first_name, last_name, email, hire_date, 
job_id, salary, department_id)
values(employees_seq.nextval, p_fname, p_lname, p_email, sysdate, p_job_id,
p_salary, p_dept_id);

dbms_output.put_line('employee inserted');

exception
when others then
dbms_output.put_line('Error inserting employee.');
end;
/

begin
  add_emp('PALAK', 'CHAUDHARY', 'palak@example.com', 6000, 'IT_PROG', 20);
end;
/

/* Question 1. Write a procedure ADD_EMP to insert a new employee into the EMPLOYEES table. 
It should accept first name, last name, email, salary, job id, and department id.*/

set serveroutput on;
create or replace procedure add_emp(
p_fname IN employees.first_name%type,
p_lname IN employees.last_name%type,
p_email IN employees.email%type,
p_salary IN employees.salary%type,
p_job_id IN employees.job_id%type,
p_dept_id IN employees.department_id%type
)
as

begin
insert into employees(employee_id, first_name, last_name, email, 
hire_date, job_id, salary, department_id)
values(employees_seq.nextval, p_fname, p_lname, p_email, sysdate,
p_job_id, p_salary, p_dept_id);

dbms_output.put_line('employee inserted');

exception
when others then
dbms_output.put_line('Error inserting employee.');
end;
/

begin
add_emp('Riley', 'James', 'Rijam@gmail.com', 4000, 'IT_PROG', 20);
end;
/


/* Question 1. Write a procedure ADD_EMP to insert a new employee into the EMPLOYEES table. 
It should accept first name, last name, email, salary, job id, and department id.*/

set serveroutput on;
create or replace procedure add_emp(
p_fname IN employees.first_name%type,
p_lname IN employees.last_name%type,
p_email IN employees.email%type,
p_salary IN employees.salary%type,
p_job_id IN employees.job_id%type,
p_dept_id IN employees.department_id%type
)
as

begin
insert into employees(employee_id, first_name, last_name, email, 
hire_date, salary, job_id, department_id)
values(employees_seq.nextval, p_fname, p_lname, p_email, sysdate, p_salary,
p_job_id, p_dept_id);

dbms_output.put_line('Employee entered.');

exception
when others then
dbms_output.put_line('Error inserting employee');
end;
/

begin
add_emp('Joel', 'Chen', 'JC@gmail.com', 5000, 'IT_PROG', 20);
end;
/

select * from employees;


/* Question 1. Write a procedure ADD_EMP to insert a new employee into the EMPLOYEES table. 
It should accept first name, last name, email, salary, job id, and department id.*/

set serveroutput on;
create or replace procedure add_emp (
p_fname IN employees.first_name%type,
p_lname IN employees.last_name%type,
p_email IN employees.email%type,
p_salary IN employees.salary%type,
p_job_id IN employees.job_id%type,
p_dept_id IN employees.department_id%type
)
as
begin
insert into employees (
employee_id, first_name, last_name, email, hire_date, job_id,
salary, department_id
)
values (
employees_seq.nextval, p_fname, p_lname, p_email,
sysdate, p_job_id, p_salary, p_dept_id
);

dbms_output.put_line('Employee Inserted');
exception
when others then
dbms_output.put_line('error inserting employee');
end;
/

begin
add_emp('Jatin', 'Chatur', 'jach@gmail.com', 7000, 'IT_Prog', 20);
end;
/


/* Question 1. Write a procedure ADD_EMP to insert a new employee into the EMPLOYEES table. 
It should accept first name, last name, email, salary, job id, and department id.*/

set serveroutput on;
create or replace procedure add_emp (
p_fname IN employees.first_name%type,
p_lname IN employees.last_name%type,
p_email IN employees.email%type,
p_salary IN employees.salary%type,
p_job_id IN employees.job_id%type,
p_dept_id IN employees.department_id%type
)
as
begin
insert into employees(
employee_id, first_name, last_name, email,
hire_date, job_id, salary, department_id
)
values(
employees_seq.nextval, p_fname, p_lname, p_email,
sysdate, p_job_id, p_salary, p_dept_id
);

dbms_output.put_line('Employee Inserted');
exception
when others then
dbms_output.put_line('Error inserting employee');
end;
/

begin
add_emp('Boss', 'Chan', 'Boch@gmail.com', 5000, 'IT_PROG', 20);
end;
/

select * from employees;

/* Question 1. Write a procedure ADD_EMP to insert a new employee into the EMPLOYEES table. 
It should accept first name, last name, email, salary, job id, and department id.*/

set serveroutput on;
create or replace procedure add_emp(
p_fname IN employees.first_name%type,
p_lname IN employees.last_name%type,
p_email IN employees.email%type,
p_salary IN employees.salary%type,
p_job_id IN employees.job_id%type,
p_dept_id IN employees.department_id%type
)
as
begin
insert into employees(employee_id, first_name, last_name,
email, hire_date, salary, job_id, department_id)
values (employees_seq.nextval, p_fname, p_lname, p_email, 
sysdate, p_salary, p_job_id, p_dept_id);

dbms_output.put_line('employee inserted');
exception
when others then
dbms_output.put_line('error inserting employee');
end;
/

begin
add_emp('Adolf', 'Piastri', 'Adop@gmail.com', 5000, 'IT_PROG', 20);
end;
/


/*Write a PL/SQL block that prints each employee’s first name and salary.*/

set serveroutput on;
declare
cursor emp_cur IS
select first_name, salary from employees;
v_fname employees.first_name%type;
v_salary employees.salary%type;
begin
open emp_cur;
loop
fetch emp_cur into v_fname, v_salary;
exit when emp_cur%notfound;
dbms_output.put_line(v_fname || ' earns ' || v_salary);
end loop;
close emp_cur;
end;
/

/*Write a PL/SQL block that prints each employee’s first name and salary.*/

set serveroutput on;
declare
cursor emp_cur IS 
select first_name, salary from employees;
v_fname employees.first_name%type;
v_salary employees.salary%type;
begin
open emp_cur;
loop
fetch emp_cur into v_fname, v_salary;
exit when emp_cur%notfound;
dbms_output.put_line(v_fname || ' earns ' || v_salary);
end loop;
close emp_cur;
end;
/


/*Write a PL/SQL block that prints each employee’s first name and salary.*/

set serveroutput on;
declare
cursor emp_cur IS
select first_name, salary from employees;
v_fname employees.first_name%type;
v_salary employees.salary%type;
begin
open emp_cur;
loop
fetch emp_cur into v_fname, v_salary;
exit when emp_cur%notfound;
dbms_output.put_line(v_fname || 'earns' || v_salary);
end loop;
close emp_cur;
end;
/

/*Write a PL/SQL block that prints each employee’s first name and salary.*/

set serveroutput on;

declare 
cursor emp_cur IS
select first_name, salary from employees;
v_fname employees.first_name%type;
v_salary employees.salary%type;
begin
open emp_cur;
loop
fetch emp_cur into v_fname, v_salary;
exit when emp_cur%notfound;
dbms_output.put_line(v_fname || 'earns' || v_salary);
end loop;
close emp_cur;
end;
/


/*Write a PL/SQL block that prints each employee’s first name and salary.*/

set serveroutput on; 

declare
cursor emp_cur IS
select first_name, salary from employees;
v_fname employees.first_name%type;
v_salary employees.salary%type;
begin
open emp_cur;
loop 
fetch emp_cur into v_fname, v_salary;
exit when emp_cur%notfound;
dbms_output.put_line(v_fname || ' earns ' || v_salary);
end loop;
close emp_cur;
end;
/


/*Write a PL/SQL block that prints each employee’s first name and salary.*/

set serveroutput on;

declare
cursor emp_cur IS
select first_name, salary from employees;
v_fname employees.first_name%type;
v_salary employees.salary%type;
begin
open emp_cur;
loop
fetch emp_cur into v_fname, v_salary;
exit when emp_cur%notfound;
dbms_output.put_line(v_fname || ' earns ' || v_salary);
end loop;
close emp_cur;
end;
/


/*Write a PL/SQL block that prints each employee’s first name and salary.*/

set serveroutput on;

declare
cursor emp_cur IS
select first_name, salary from employees;
v_fname employees.first_name%type;
v_salary employees.salary%type;
begin
open emp_cur;
loop
fetch emp_cur into v_fname, v_salary;
exit when emp_cur%notfound;
dbms_output.put_line(v_fname || ' earns ' || v_salary);
end loop;
close emp_cur;
end;
/


/*Write a PL/SQL block that prints each employee’s first name and salary.*/

set serveroutput on;

declare
cursor emp_cur IS
select first_name, salary from employees;
v_fname employees.first_name%type;
v_salary employees.salary%type;
begin
open emp_cur;
loop
fetch emp_cur into v_fname, v_salary;
exit when emp_cur%notfound;
dbms_output.put_line(v_fname || ' earns ' || v_salary);
end loop;
close emp_cur;
end;
/


/*Write a PL/SQL block that prints each employee’s first name and salary.*/

set serveroutput on;

declare 
cursor emp_cur IS
select first_name, salary from employees;
v_fname employees.first_name%type;
v_salary employees.salary%type;
begin
open emp_cur;
loop
fetch emp_cur into v_fname, v_salary;
exit when emp_cur%notfound;
dbms_output.put_line(v_fname || ' earns ' || v_salary);
end loop;
close emp_cur;
end;
/

/*Write a PL/SQL block that prints each employee’s first name and salary.*/

set serveroutput on;

declare
cursor emp_cur IS
select first_name, salary from employees;
v_fname employees.first_name%type;
v_salary employees.salary%type;
begin
open emp_cur;
loop
fetch emp_cur into v_fname, v_salary;
exit when emp_cur%notfound;
dbms_output.put_line(v_fname || ' earns ' || v_salary);
end loop;
close emp_cur;
end;
/

//Select * from departments;
/*Write a PL/SQL block that lists departments*/

set serveroutput on;

declare
cursor c IS
select department_name from departments;
v_dept_name departments.department_name%type;
begin
open c;
loop
fetch c into v_dept_name;
exit when c%notfound;
dbms_output.put_line('department name is: ' || v_dept_name);
end loop;
close c;
end;
/

/*Write a PL/SQL block that prints locations with region*/
//select * from locations;
//select * from regions;
set serveroutput on;

declare
  cursor loc IS
    select l.city, r.region_name
    from locations l
    cross join regions r;
  v_location locations.city%type;
  v_region regions.region_name%type;
begin
  open loc;
  loop
    fetch loc into v_location, v_region;
    exit when loc%notfound;
    dbms_output.put_line(v_location || ' in region ' || v_region);
  end loop;
  close loc;
end;
/


/*Write a PL/SQL block that prints locations with region*/

set serveroutput on;

declare 
cursor loc IS
select l.city, r.region_name
from locations l
cross join regions r;
v_location locations.city%type;
v_region regions.region_name%type;
begin
open loc;
loop
fetch loc into v_location, v_region;
exit when loc%notfound;
dbms_output.put_line(v_location || ' in region ' || v_region);
end loop;
close loc;
end;
/

/*Write a PL/SQL block that prints locations with region*/

set serveroutput on;

declare
cursor loc IS
select l.city, r.region_name
from locations l
cross join regions r;
v_location locations.city%type;
v_region regions.region_name%type;
begin
open loc;
loop
fetch loc into v_location, v_region;
exit when loc%notfound;
dbms_output.put_line(v_location || ' in region ' || v_region);
end loop;
close loc;
end;
/

/*Write a PL/SQL block that prints locations with region*/

set serveroutput on;

declare
cursor loc IS
select l.city, r.region_name
from locations l
cross join regions r;
v_location locations.city%type;
v_region regions.region_name%type;
begin
open loc;
loop
fetch loc into v_location, v_region;
exit when loc%notfound;
dbms_output.put_line(v_location || ' in region ' || v_region);
end loop;
close loc;
end;
/

/*Write a PL/SQL block that lists jobs and min salaries*/

//select * from jobs;

set serveroutput on;

declare
cursor C IS
select job_title, min_salary from jobs;
v_job_title jobs.job_title%type;
v_min_salary jobs.min_salary%type;
begin
open C;
loop
fetch C into v_job_title, v_min_salary;
exit when C%notfound;
dbms_output.put_line(v_job_title || ' Starts at ' || v_min_salary);
end loop;
close C;
end;
/

/*Write a PL/SQL block that prints countries*/

set serveroutput on;
declare
cursor C IS
select country_id, country_name from countries;
v_id countries.country_id%type;
v_name countries.country_name%type;
begin
open C;
loop
fetch C into v_id, v_name;
exit when C%notfound;
dbms_output.put_line(v_name || '('|| v_id ||')');
end loop;
close C;
end;
/


/*Write a PL/SQL block that prints countries*/

set serveroutput on;

declare
cursor C IS
select country_id, country_name from countries;
v_id countries.country_id%type;
v_name countries.country_name%type;
begin
open C;
loop
fetch C into v_id, v_name;
exit when C%notfound;
dbms_output.put_line(v_name || '('|| v_id ||')');
end loop;
close C;
end;
/


/*Write a function GET_SALARY that takes employee id and returns salary.*/

set serveroutput on; 

create or replace function get_salary(
p_emp_id IN employees.employee_id%type
)

return employees.salary%type
as
v_salary employees.salary%type;
begin
select salary into v_salary
from employees
where employee_id = p_emp_id;

return v_salary;
exception
when no_data_found then
dbms_output.put_line('no employee found.');
return null;
end;
/

begin
dbms_output.put_line('Salary: ' || get_salary(101));
end;
/

/*Write a function GET_SALARY that takes employee id and returns salary.*/

set serveroutput on;

create or replace function get_salary(
p_emp_id in employees.employee_id%type
)

return employees.salary%type
as
v_salary employees.salary%type;
begin
select salary into v_salary
from employees
where employee_id = p_emp_id;

return v_salary;
exception
when no_data_found then
dbms_output.put_line('no employee found');
return null;
end;
/

begin
dbms_output.put_line('Salary: ' || get_salary(101));
end;
/


/*Write a function GET_SALARY that takes employee id and returns salary.*/

set serveroutput on;

create or replace function get_salary(
p_emp_id in employees.employee_id%type
)

return employees.salary%type
as
v_salary employees.salary%type;
begin
select salary into v_salary
from employees
where employee_id = p_emp_id;

return v_salary;
exception
when no_data_found then
dbms_output.put_line('No employee found');
return null;
end;
/

begin
dbms_output.put_line('Salary: ' || get_salary(101));
end;
/

/*Write a function GET_SALARY that takes employee id and returns salary.*/

set serveroutput on;

create or replace function get_salary(
p_emp_id employees.employee_id%type
)

return employees.salary%type
as
v_salary employees.salary%type;
begin
select salary into v_salary
from employees
where employee_id = p_emp_id;

return v_salary;
exception
when no_data_found then
dbms_output.put_line('No data found');
return null;
end;
/

begin
dbms_output.put_line('Salary: ' || get_salary(101));
end;
/

/*Write a function GET_SALARY that takes employee id and returns salary.*/

set serveroutput on;

create or replace function get_salary(
p_emp_id employees.employee_id%type
)

return employees.salary%type
as
v_salary employees.salary%type;
begin
select salary into v_salary
from employees
where employee_id = p_emp_id;

return v_salary;
exception
when no_data_found then
dbms_output.put_line('Employee not found');
return null;
end;
/

begin
dbms_output.put_line('Salary: ' || get_salary(101));
end;
/

/*Write a function to get department name by id.*/

--select * from departments;

set serveroutput on;

create or replace function get_name(
p_id in departments.department_id%type
)

return departments.department_name%type
as
v_name departments.department_name%type;
begin
select department_name into v_name
from departments
where department_id = p_id;

return v_name;
exception
when no_data_found then
dbms_output.put_line('department not found');
return null;
end;
/

begin
dbms_output.put_line('Department: ' || get_name(60));
end;
/

/*Write a function to get location city by id.*/

--select * from locations;

set serveroutput on;

create or replace function get_city(
p_id in locations.location_id%type
)

return locations.city%type
as 
v_city locations.city%type;
begin
select city into v_city
from locations
where location_id = p_id;

return v_city;
exception
when no_data_found then
dbms_output.put_line('Location not found');
return null;
end;
/

begin
dbms_output.put_line('City: ' || get_city(1800));
end;
/

/*Write a function to get region name by id.*/

--select * from regions;

set serveroutput on;

create or replace function get_name(
p_id in regions.region_name%type
)

return regions.region_name%type
as
v_name regions.region_name%type;
begin
select region_name into v_name
from regions
where region_id = p_id;

return v_name;
exception
when no_data_found then
dbms_output.put_line('No region found');
return null;
end;
/

begin
dbms_output.put_line('Region name: ' || get_name(20));
end;
/

/*Write a function to get job title by id.*/

--select * from jobs;

set serveroutput on;

create or replace function get_title(
p_id in jobs.job_id%type
)

return jobs.job_title%type
as
v_title jobs.job_title%type;
begin
select job_title into v_title
from jobs
where job_id = p_id;

return v_title;
exception
when no_data_found then
dbms_output.put_line('No jobs found');
return null;
end;
/

begin
dbms_output.put_line('Job Title: ' || get_title('SA_MAN'));
end;
/


/*Write a procedure INSERT_SALARY_CHECK that inserts an employee 
only if salary > 3000. Raise an exception if less.*/

set serveroutput on;

create or replace procedure insert_salary_check(
p_fname in employees.first_name%type,
p_lname in employees.last_name%type,
p_email in employees.email%type,
p_salary in employees.salary%type
)
as
too_low_salary exception;
begin
if p_salary < 3000 then 
raise too_low_salary;
end if;

insert into employees(
employee_id, first_name, last_name, email, hire_date, job_id, salary, department_id
)
values(
employees_seq.nextval, p_fname, p_lname, p_email, sysdate, 'IT_PROG', p_salary, 20
);

dbms_output.put_line('Employee Inserted');
exception
when too_low_salary then
dbms_output.put_line('salary too low for employee');
when others then
dbms_output.put_line('Some other error occurred');
end;
/

begin
insert_salary_check('Raphael', 'Verdi', 'rapver@gmail.com', 2000);
insert_salary_check('Daphne', 'Blake', 'daphne@gmail.com', 4000);
end;
/


/*Write a procedure INSERT_SALARY_CHECK that inserts an employee 
only if salary > 3000. Raise an exception if less.*/

set serveroutput on;

create or replace procedure insert_salary_check(
p_fname in employees.first_name%type,
p_lname in employees.last_name%type,
p_email in employees.email%type,
p_salary in employees.salary%type
)
as
too_low_salary exception;
begin
if p_salary < 3000 then
raise too_low_salary;
end if;

insert into employees(
employee_id, first_name, last_name, email, hire_date, 
job_id, salary, department_id
)
values(employees_seq.nextval, p_fname, p_lname, 
p_email, sysdate, 'IT_PROG', p_salary, 20);

dbms_output.put_line('Employee Inserted');
exception
when too_low_salary then
dbms_output.put_line('Too low salary for employee');
when others then
dbms_output.put_line('Some error occurred');
end;
/

begin
insert_salary_check('James', 'Cameron', 'jcam@gmail.com', 6000);
insert_salary_check('Jenny', 'Su', 'jsu@gmail.com', 1000);
end;
/

/*Write a procedure INSERT_SALARY_CHECK that inserts an employee 
only if salary > 3000. Raise an exception if less.*/

set serveroutput on; 

create or replace procedure insert_salary_check(
p_fname in employees.first_name%type,
p_lname in employees.last_name%type,
p_email in employees.email%type,
p_salary in employees.salary%type
)
as
too_low_salary exception;
begin
if p_salary < 3000 then
raise too_low_salary;
end if;

insert into employees(
employee_id, first_name, last_name, email, 
hire_date, job_id, salary, department_id
)
values(
employees_seq.nextval, p_fname, p_lname, p_email,
sysdate, 'IT_PROG', p_salary, 20
);

dbms_output.put_line('Employee Inserted');
exception
when too_low_salary then
dbms_output.put_line('Too low salary for employee');
when others then
dbms_output.put_line('Some other error occurred');
end;
/

begin
insert_salary_check('Nick', 'Bert', 'nb@gmail.com', 2000);
insert_salary_check('Noel', 'Ovo', 'ovonoel@gmail.com', 7000);
end;
/

/*Write a procedure INSERT_SALARY_CHECK that inserts an employee 
only if salary > 3000. Raise an exception if less.*/

create or replace procedure insert_salary_check(
p_fname in employees.first_name%type,
p_lname in employees.last_name%type,
p_email in employees.email%type,
p_salary in employees.salary%type
)
as
too_low_salary exception;
begin
if p_salary < 3000 then
raise too_low_salary;
end if;

insert into employees(
employee_id, first_name, last_name, email, hire_date, 
job_id, salary, department_id
)
values(
employees_seq.nextval, p_fname, p_lname, p_email, sysdate,
'IT_PROG', p_salary, 20
);

dbms_output.put_line('Employee Inserted');
exception
when too_low_salary then
dbms_output.put_line('Too low salary for employee');
when others then
dbms_output.put_line('Some other error occurred');
end;
/

begin
insert_salary_check('Jaques', 'Robert', 'jro@gmail.com', 2600);
insert_salary_check('Masaki', 'Satou', 'masa@gmail.com', 9000);
end;
/

/*Write a procedure for minimum salary rule. Raise an exception.*/

set serveroutput on;

create or replace procedure sal_check(
p_fname in employees.first_name%type,
p_lname in employees.last_name%type,
p_email in employees.email%type,
p_salary in employees.salary%type
)
as
low_salary exception;
begin
if p_salary < 3000 then
raise low_salary;
end if;

insert into employees(
employee_id, first_name, last_name,
email, hire_date, job_id, salary, department_id)
values(
employees_seq.nextval, p_fname, p_lname, p_email,
sysdate, 'IT_PROG', p_salary, 20
);

dbms_output.put_line('Employee Inserted');

exception
when low_salary then
dbms_output.put_line('Salary below minimum allowed');
end;
/

begin
sal_check('Banq', 'Roma', 'baro@gmail.com', 1000);
sal_check('Oliver', 'Khatib', 'ovoliver@gmail.com', 8000);
end;
/


/*Write a procedure to check if department exists. 
Raise an exception if it does not exist.*/

set serveroutput on;

create or replace procedure dept_check(
p_fname in employees.first_name%type,
p_lname in employees.last_name%type,
p_email in employees.email%type,
p_salary in employees.salary%type,
p_dept in employees.department_id%type
)
as
no_dept exception;
v_count number;
begin
select count(*) into v_count
from employees
where department_id = p_dept;

if v_count = 0 then
raise no_dept;
end if;

insert into employees(
employee_id, first_name, last_name, email, 
hire_date, job_id, salary, department_id
)
values(
employees_seq.nextval, p_fname, p_lname, p_email,
sysdate, 'IT_PROG', p_salary, p_dept
);

dbms_output.put_line('Employee Inserted');

exception
when no_dept then
dbms_output.put_line('Department does not exist');
end;
/

begin
dept_check('Aubrey', 'Graham', 'drake@gmail.com', 10000, 30);
end;
/

/*Write a procedure to check if department exists. 
Raise an exception if it does not exist.*/

set serveroutput on;

create or replace procedure dept_check(
p_fname in employees.first_name%type,
p_lname in employees.last_name%type,
p_email in employees.email%type,
p_salary in employees.salary%type, 
p_dept in employees.department_id%type
)
as
no_dept exception;
v_count number;
begin
select count(*) into v_count
from employees
where department_id = p_dept;

if v_count = 0 then
raise no_dept;
end if;

insert into employees(
employee_id, first_name, last_name, email, hire_date,
job_id, salary, department_id
)
values(
employees_seq.nextval, p_fname, p_lname, p_email, sysdate,
'IT_PROG', p_salary, p_dept
);

dbms_output.put_line('Employee Inserted');

exception
when no_dept then
dbms_output.put_line('Department does not exist');
end;
/

begin
dept_check('Raqul', 'Nodt', 'raq@gmail.com', 6000, 69);
dept_check('Bambietta', 'Belrose', 'bambel@gmail.com', 8000, 20);
end;
/

/*Write a procedure to make sure the email is unique. 
Raise an exception if it is not unique.*/

set serveroutput on;

create or replace procedure unique_email(
p_fname in employees.first_name%type,
p_lname in employees.last_name%type,
p_email in employees.email%type,
p_salary in employees.salary%type,
p_dept in employees.department_id%type
)
as
not_unique exception;
v_count number;
begin
select count(*) into v_count
from employees
where email = p_email;

if v_count > 0 then
raise not_unique;
end if;

insert into employees(
employee_id, first_name, last_name, email, hire_date, 
job_id, salary, department_id
)
values(
employees_seq.nextval, p_fname, p_lname, p_email, sysdate,
'IT_PROG', p_salary, p_dept
);

dbms_output.put_line('Employee Inserted with email ' || p_email);

exception
when not_unique then
dbms_output.put_line('Email ' || p_email || ' already exists');
end;
/

begin
unique_email('Carol', 'Vuitton', 'bambel@gmail.com', 8000, 20);
unique_email('Norman', 'Osborn', 'noros@gmail.com', 7000, 30);
end;
/


/*Write a procedure to make sure the job_id exists. 
Raise an exception if it does not exist.*/

set serveroutput on;

create or replace procedure job_valid(
p_fname in employees.first_name%type,
p_lname in employees.last_name%type,
p_email in employees.email%type,
p_salary in employees.salary%type,
p_dept in employees.department_id%type,
p_job in employees.job_id%type
)
as
not_valid exception;
v_count number;
begin
select count(*) into v_count
from jobs
where job_id = p_job;

if v_count = 0 then
raise not_valid;
end if;

insert into employees(
employee_id, first_name, last_name, email, hire_date, 
job_id, salary, department_id
)
values(
employees_seq.nextval, p_fname, p_lname, p_email, sysdate,
p_job, p_salary, p_dept
);

dbms_output.put_line('Employee inserted with job ' || p_job);

exception
when not_valid then
dbms_output.put_line('Job id does not exist');
end;
/

begin
job_valid('Vende', 'Nors', 'veno@gmail.com', 8000, 20, 'L_OL');
job_valid('Shinji', 'Hirako', 'shinhira@gmail.com', 6000, 20, 'IT_PROG');
end;
/


/*Write a procedure to make sure the job_id exists. 
Raise an exception if it does not exist.*/

set serveroutput on;

create or replace procedure job_valid(
p_fname in employees.first_name%type,
p_lname in employees.last_name%type,
p_email in employees.email%type,
p_salary in employees.salary%type,
p_dept in employees.department_id%type,
p_job in employees.job_id%type
)
as
not_valid exception;
v_count number;
begin
select count(*) into v_count
from jobs
where job_id = p_job;

if v_count = 0 then
raise not_valid;
end if;

insert into employees(
employee_id, first_name, last_name, email, hire_date,
job_id, salary, department_id
)
values(
employees_seq.nextval, p_fname, p_lname, p_email, sysdate,
p_job, p_salary, p_dept
);

dbms_output.put_line('Employee inserted with job id : ' || p_job);

exception
when not_valid then
dbms_output.put_line('Job id does not exist');
end;
/

begin
job_valid('Stern', 'Ritter', 'sternrit@gmail.com', 7000, 20, 'SA_MAN');
end;
/


/*Write a procedure to make sure the job_id exists. 
Raise an exception if it does not exist.*/

set serveroutput on;

create or replace procedure job_valid(
p_fname in employees.first_name%type,
p_lname in employees.last_name%type,
p_email in employees.email%type,
p_salary in employees.salary%type,
p_dept in employees.department_id%type,
p_job in employees.job_id%type
)
as
not_valid exception;
v_count number;
begin
select count(*) into v_count
from jobs
where job_id = p_job;

if v_count = 0 then
raise not_valid;
end if;

insert into employees(
employee_id, first_name, last_name, email, hire_date,
job_id, salary, department_id
)
values(
employees_seq.nextval, p_fname, p_lname, p_email, 
sysdate, p_job, p_salary, p_dept
);

dbms_output.put_line('Employee Inserted with job_id: ' || p_job);

exception
when not_valid then
dbms_output.put_line('Job id does not exist');
when others then
dbms_output.put_line('Some other error occurred');
end;
/

begin
job_valid('Rami', 'Malek', 'rama@gmail.com', 7000, 20, 'IT_PROG');
job_valid('Barry', 'Khaled', 'bakha@gmail.com', 5000, 30, 'J_CO');
end;
/



------------------ EVERYTHING AFTER MIDTERM ------------------------------------



/*1. Hierarchical Query: Write a query to generate an organization chart 
showing each employee, their manager, and their “level” in the hierarchy (root is level 1). 
Display the chain of command for each employee as a path from the CEO down.*/

select employee_id, first_name, last_name, manager_id, level,
sys_connect_by_path(first_name, ' -> ')
as chain_of_command from employees
start with manager_id is null
connect by prior employee_id = manager_id
order siblings by first_name, last_name;

/*1. Hierarchical Query: Write a query to generate an organization chart 
showing each employee, their manager, and their “level” in the hierarchy (root is level 1). 
Display the chain of command for each employee as a path from the CEO down.*/

select employee_id, first_name, last_name, manager_id, level,
sys_connect_by_patch(first_name, ' -> ')
as chain_of_command from employees
start with manager_id is null
connect by prior employee_id = manager_id
order siblings by first_name, last_name;

/*1. Hierarchical Query: Write a query to generate an organization chart 
showing each employee, their manager, and their “level” in the hierarchy (root is level 1). 
Display the chain of command for each employee as a path from the CEO down.*/

select employee_id, first_name, last_name, manager_id, level,
sys_connect_by_path(first_name, ' -> ')
as chain_of_command from employees
start with manager_id is null
connect by prior employee_id = manager_id
order siblings by first_name, last_name;

/*1. Hierarchical Query: Write a query to generate an organization chart 
showing each employee, their manager, and their “level” in the hierarchy (root is level 1). 
Display the chain of command for each employee as a path from the CEO down.*/

select employee_id, first_name, last_name, manager_id, level,
sys_connect_by_path(first_name, ' -> ') as chain_of_command
from hr.employees
start with manager_id is null
connect by prior employee_id = manager_id
order siblings by first_name, last_name;

/*1. Hierarchical Query: Write a query to generate an organization chart 
showing each employee, their manager, and their “level” in the hierarchy (root is level 1). 
Display the chain of command for each employee as a path from the CEO down.*/

select employee_id, first_name, last_name, manager_id, level,
sys_connect_by_path(first_name, ' -> ')
as chain_of_command from hr.employees
start with manager_id is null
connect by prior employee_id = manager_id
order siblings by first_name, last_name;


------------Grouped Practical Questions & Solutions by Topic--------------------


--------------Transaction Management--------------------------



/*Update a city, insert students, use SAVEPOINT and ROLLBACK, show final rows.*/

UPDATE student SET scity = 'Toronto' WHERE sid = 2;
INSERT INTO student VALUES (10, 'H', 'Hamilton');
INSERT INTO student VALUES (11, 'I', 'Niagara');
INSERT INTO student VALUES (12, 'J', 'Ajax');
SAVEPOINT before_extra;
INSERT INTO student VALUES (13, 'K', 'Pickering');
ROLLBACK TO before_extra;
COMMIT;
SELECT * FROM student;
-- Only sids 10, 11, 12 are added (13 is not)


/*Update a city (location), insert locations, 
use SAVEPOINT and ROLLBACK, show final rows*/

update hr.locations set city = 'toronto' where location_id = 1400;

insert into hr.locations values(3500, '121 King St', 'Toronto', null, 'ON', 'CA');
insert into hr.locations values(3600, '88 queen St', 'Hamilton', null, 'ON', 'CA');
insert into hr.locations values(3700, '77 Bay St', 'Niagara', null, 'ON', 'CA');
savepoint before_extra;
insert into hr.locations values(3800, '555 Main St', 'Pickering', null, 'ON', 'CA');
rollback to before_extra;
commit;
select * from hr.locations where location_id >= 3500;


/*Update a city (location), then rollback. What is the final value?*/

update hr.loactions set city = 'Oakville' where location_id = 1400;
rollback;

/*Update, insert rows, then rollback. What is the final data?*/

update hr.locations set city = 'Oakville' where location_id = 1400;
insert into hr.locations values(3900, '10 River St', 'Brampton', null, 'ON', 'CA');
insert into hr.locations values(4000, '22 Lake rd', 'Windsor', null, 'ON', 'CA');
rollback;

/*Savepoint/transaction block sequence with INSERT, UPDATE, ROLLBACK, and COMMIT*/

insert into hr.locations values(4100, '1 Yonge St', 'Barrie', null, 'ON', 'CA');
insert into hr.locations values(4200, '23 Main St', 'Kingston', null, 'ON', 'CA');
savepoint s1;

update hr.locations set city = 'Ottawa' where location_id = 4200;
savepoint s2;

insert into hr.locations values(4300, '5 Elm St', 'Sudbury', null, 'ON', 'CA');
rollback to s2;

commit;


/*PL/SQL block to increase salary in department 10 by 10%, with exception handling*/

begin
update hr.employees set salary = salary * 1.10 where department_id = 10;
commit;
exception
when others then
rollback;
end;

/*Simulate a bank transfer with error handling (atomic transaction) 
using HR tables (simulate as transferring salary between two employees)*/

begin
update hr.employees set salary = salary - 1000 where employee_id = 100;
update hr.employees set salary = salary + 1000 where employee_id = 101;
commit;
exception
when others then
rollback;
end;


------------------------Hierarchical Queries & Self-Joins-----------------------

/*List all employees managed (directly or indirectly) 
by a given manager (e.g., Lex Garcia)*/

select first_name, last_name
from hr.employees
start with first_name = 'Lex' and last_name = 'Garcia'
connect by prior employee_id = manager_id;

/*List all employees managed (directly or indirectly) 
by a given manager (e.g., Lex Garcia)*/

select first_name, last_name
from hr.employees
start with first_name = 'Lex' and last_name = 'Garcia'
connect by prior employee_id = manager_id;

/*List all employees managed (directly or indirectly) 
by a given manager (e.g., Lex Garcia)*/

select first_name, last_name
from hr.employees
start with first_name = 'John' and last_name = 'Chen'
connect by prior employee_id = manager_id;

/*List all employees managed (directly or indirectly) 
by a given manager (e.g., Lex Garcia)*/

select first_name, last_name
from hr.employees
start with first_name = 'Lex' and last_name = 'De Haan'
connect by prior employee_id = manager_id;

/*List all employees managed by Steven King*/

select first_name, last_name, level
from hr.employees
start with first_name = 'Steven' and last_name = 'King'
connect by prior employee_id  = manager_id;

/*List all employees managed by Steven King*/

select first_name, last_name, level
from hr.employees
start with first_name = 'Steven' and last_name = 'King'
connect by prior employee_id = manager_id;

/*For each employee, show their full path (chain of command) up to the CEO*/

select employee_id, first_name, last_name, level,
sys_connect_by_path(first_name, '->') as chain_of_command
from hr.employees
start with manager_id is null
connect by prior employee_id = manager_id
order siblings by first_name, last_name;




-------------------- Hierarchical Queries --------------------------------------



/*List all employees managed (directly or indirectly) 
by a given manager (e.g., Lex De Haan)*/

select first_name, last_name
from hr.employees
start with first_name = 'Lex' and last_name = 'De Haan'
connect by prior employee_id = manager_id;

/*List all employees managed (directly or indirectly) 
by a given manager (e.g., Lex De Haan)*/

select first_name, last_name
from hr.employees
start with first_name='Lex' and last_name='De Haan'
connect by prior employee_id = manager_id;

/*List all employees managed (directly or indirectly) 
by a given manager (e.g., Lex De Haan)*/

select first_name, last_name
from hr.employees
start with first_name = 'Lex' and last_name='De Haan'
connect by prior employee_id = manager_id;

/*List all employees managed (directly or indirectly) 
by a given manager (e.g., Lex De Haan)*/

select first_name, last_name 
from hr.employees
start with first_name='Lex' and last_name='De Haan'
connect by prior employee_id = manager_id;

/*List all employees managed (directly or indirectly) 
by a given manager (e.g., Lex De Haan)*/

select first_name, last_name
from hr.employees
start with first_name='Lex' and last_name='De Haan'
connect by prior employee_id = manager_id;

/*List all employees managed by Steven King*/

select first_name, last_name, level
from hr.employees
start with first_name='Steven' and last_name='King'
connect by prior employee_id = manager_id;

/*List all employees managed by Steven King*/

select first_name, last_name, level
from hr.employees
start with first_name='Steven' and last_name='King'
connect by prior employee_id = manager_id;

/*List all employees managed by Steven King*/

select first_name, last_name, level
from hr.employees
start with first_name = 'Steven' and last_name = 'King'
connect by prior employee_id = manager_id;

/*For each employee, show their full path (chain of command) up to the CEO*/

select employee_id, first_name, last_name, manager_id, level,
sys_connect_by_path(first_name, ' -> ')as chain_of_command
from hr.employees
start with manager_id is null
connect by prior employee_id = manager_id
order siblings by first_name, last_name;

/*For each employee, show their full path (chain of command) up to the CEO*/

select employee_id, first_name, last_name, manager_id, level,
sys_connect_by_path(first_name, ' -> ') as chain_of_command
from hr.employees
start with manager_id is null
connect by prior employee_id = manager_id
order siblings by first_name, last_name;

/*For each employee, show their full path (chain of command) up to the CEO*/

select employee_id, first_name, last_name, manager_id, level,
sys_connect_by_path(first_name, ' -> ') as chain_of_command
from hr.employees
start with manager_id is null
connect by prior employee_id = manager_id
order siblings by first_name, last_name;

/*For each employee, show their full path (chain of command) up to the CEO*/

select employee_id, first_name, last_name, manager_id, level,
sys_connect_by_path(first_name, ' -> ') as chain_of_command
from hr.employees
start with manager_id is null
connect by prior employee_id = manager_id
order siblings by first_name, last_name;

/*For each employee, show their full path (chain of command) up to the CEO*/

select employee_id, first_name, last_name, manager_id, level,
sys_connect_by_path(first_name, ' -> ') as chain_of_command
from hr.employees
start with manager_id is null
connect by prior employee_id = manager_id
order siblings by first_name, last_name;

/*For each employee, show their manager’s first and last name (self-join)*/

select e.first_name as emp_first, e.last_name as emp_last,
m.first_name as mgr_first, m.last_name as mgr_last
from hr.employees e
left join hr.employees m on e.manager_id = m.employee_id;

/*For each employee, show their manager’s first and last name (self-join)*/

select e.first_name as emp_first, e.last_name as emp_last,
m.first_name as mgr_first, m.last_name as mgr_last
from hr.employees e
left join hr.employees m on e.manager_id = m.employee_id;

/*For each employee, show their manager’s first and last name (self-join)*/

select e.first_name as emp_first, e.last_name as emp_last,
m.first_name as mgr_first, m.last_name as mgr_last
from hr.employees e
left join hr.employees m on e.manager_id = m.employee_id;

/*For each employee, show their manager’s first and last name (self-join)*/

select e.first_name as emp_first, e.last_name as emp_last,
m.first_name as mgr_first, m.last_name as mgr_last
from hr.employees e
left join hr.employees m on e.manager_id = m.employee_id;

/*For each employee, show their manager’s first and last name (self-join)*/

select e.first_name as emp_first, e.last_name as emp_last,
m.first_name as mgr_first, m.last_name as mgr_last
from hr.employees e
left join hr.employees m on e.manager_id = m.employee_id;

/*Find the manager of a specific employee (e.g., Den Li)*/

select m.first_name, m.last_name
from hr.employees e
join hr.employees m on e.manager_id = m.employee_id
where e.first_name = 'Laura' and e.last_name = 'Bissot';

/*Find the manager of a specific employee (e.g., Den Li)*/

select m.first_name, m.last_name
from hr.employees e
join hr.employees m on e.manager_id = m.employee_id
where e.first_name = 'Laura' and e.last_name = 'Bissot';

/*Find the manager of a specific employee (e.g., Den Li)*/

select m.first_name, m.last_name
from hr.employees e
join hr.employees m on e.manager_id = m.employee_id
where e.first_name='Laura' and e.last_name='Bissot';

/*Find the manager of a specific employee (e.g., Den Li)*/

select m.first_name, m.last_name
from hr.employees e
join hr.employees m on e.manager_id = m.employee_id
where e.first_name = 'Laura' and e.last_name = 'Bissot';

/*Find the manager of a specific employee (e.g., Den Li)*/

select m.first_name, m.last_name
from hr.employees e
join hr.employees m on e.manager_id = m.employee_id
where e.first_name = 'Laura' and e.last_name = 'Bissot';

/*Find the manager of a specific employee (e.g., Den Li)*/

select m.first_name, m.last_name
from hr.employees e
join hr.employees m on e.manager_id = m.employee_id
where e.first_name = 'Laura' and e.last_name = 'Bissot';

/*Find the manager of a specific employee (e.g., Den Li)*/

select m.first_name, m.last_name
from hr.employees e
join hr.employees m on e.manager_id = m.employee_id
where e.first_name = 'Laura' and e.last_name = 'Bissot';

/*Find the manager of a specific employee (e.g., Den Li)*/

select m.first_name, m.last_name
from hr.employees e
join hr.employees m on e.manager_id = m.employee_id
where e.first_name = 'Laura' and e.last_name = 'Bissot';

/*Find the manager of a specific employee (e.g., Den Li)*/

select m.first_name, m.last_name
from hr.employees e
join hr.employees m on e.manager_id = m.employee_id
where e.first_name = 'Laura' and e.last_name = 'Bissot';

/*Find the manager of a specific employee (e.g., Den Li)*/

select m.first_name, m.last_name
from hr.employees e
join hr.employees m on e.manager_id = m.employee_id
where e.first_name = 'Laura' and e.last_name = 'Bissot';

/*List employees two or more levels below the root manager, showing full path*/

--------------------This one is not working unfortunately----------------------
/*SELECT employee_id, first_name, last_name, LEVEL, 
       SYS_CONNECT_BY_PATH(first_name, ' > ') AS path_from_ceo
FROM hr.employees
START WITH manager_id IS NULL
CONNECT BY PRIOR employee_id = manager_id
HAVING LEVEL >= 3;
*/

/*For each manager, count the number of subordinates (direct/indirect reports)*/

select manager_id, count(*) as num_subordinates
from hr.employees
start with manager_id is not null
connect by prior employee_id = manager_id
group by manager_id;

/*For each manager, count the number of subordinates (direct/indirect reports)*/

select manager_id, count(*) as num_subordinates
from hr.employees
start with manager_id is not null 
connect by prior employee_id = manager_id
group by manager_id;

/*For each manager, count the number of subordinates (direct/indirect reports)*/

select manager_id, count(*) as num_subordinates
from hr.employees
start with manager_id is not null
connect by prior employee_id = manager_id
group by manager_id;

/*For each manager, count the number of subordinates (direct/indirect reports)*/

select manager_id, count(*) as num_subordinates
from hr.employees
start with manager_id is null
connect by prior employee_id = manager_id
group by manager_id;

/*For each manager, count the number of subordinates (direct/indirect reports)*/

select manager_id, count(*) as num_subordinates
from hr.employees
start with manager_id is null
connect by prior employee_id = manager_id
group by manager_id;

/*For each manager, count the number of subordinates (direct/indirect reports)*/

select manager_id, count(*) as num_subordinates
from hr.employees
start with manager_id is null
connect by prior employee_id = manager_id
group by manager_id;

/*For each manager, count the number of subordinates (direct/indirect reports)*/

select manager_id, count(*) as num_subordinates
from hr.employees
start with manager_id is null
connect by prior employee_id = manager_id
group by manager_id;

/*For each manager, count the number of subordinates (direct/indirect reports)*/

select manager_id, count(*) as num_subordinates
from hr.employees
start with manager_id is null
connect by prior employee_id = manager_id
group by manager_id;

/*For each manager, count the number of subordinates (direct/indirect reports)*/

select manager_id, count(*) as num_subordinates
from hr.employees
start with manager_id is null
connect by prior employee_id = manager_id
group by manager_id;

/*For each manager, count the number of subordinates (direct/indirect reports)*/

select manager_id, count(*) as num_subordinates
from hr.employees
start with manager_id is null
connect by prior employee_id = manager_id
group by manager_id;

/*For each manager, count the number of subordinates (direct/indirect reports)*/

select manager_id, count(*) as num_subordinates
from hr.employees
start with manager_id is null
connect by prior employee_id = manager_id
group by manager_id;

/*For each manager, count the number of subordinates (direct/indirect reports)*/

select manager_id, count(*) as num_subordinates
from hr.employees
start with manager_id is null
connect by prior employee_id = manager_id
group by manager_id;


-------------------------Analytic and Advanced Functions------------------------

/*For each employee: show emp_id, dept_id, salary, avg dept salary, 
diff from avg, rank, row number (salary order in dept)*/

select employee_id, department_id, salary,
avg(salary) over (partition by department_id) as avg_dept_salary,
salary - AVG(salary) over (partition by department_id) as diff_from_avg,
rank() over (partition by department_id order by salary desc) as salary_rank,
row_number() over (partition by department_id order by salary desc) as row_num
from hr.employees;

/*For each employee: show emp_id, dept_id, salary, avg dept salary, 
diff from avg, rank, row number (salary order in dept)*/

select employee_id, department_id, salary,
avg(salary) over (partition by department_id) as avg_dept_salary,
salary - avg(salary) over (partition by department_id) as diff_from_avg,
rank() over (partition by department_id order by salary desc) as salary_rank,
row_number() over (partition by department_id order by salary desc) as row_num
from hr.employees;

/*For each employee: show emp_id, dept_id, salary, avg dept salary, 
diff from avg, rank, row number (salary order in dept)*/

select employee_id, department_id, salary,
avg(salary) over (partition by department_id) as avg_dept_salary,
salary - avg(salary) over (partition by department_id) as diff_from_avg,
rank() over (Partition by department_id order by salary desc) as salary_rank,
row_number() over (partition by department_id order by salary desc) as row_num
from hr.employees;

/*For each employee: show emp_id, dept_id, salary, avg dept salary, 
diff from avg, rank, row number (salary order in dept)*/

select employee_id, department_id, salary,
avg(salary) over (partition by department_id) as avg_dept_salary,
salary - avg(salary) over (partition by department_id) as diff_from_avg,
rank() over (partition by department_id order by salary desc) as salary_rank,
row_number() over (partition by department_id order by salary desc) as row_num
from hr.employees;

/*For each employee: show emp_id, dept_id, salary, avg dept salary, 
diff from avg, rank, row number (salary order in dept)*/

select employee_id, department_id, salary,
avg(salary) over (partition by department_id) as avg_dept_salary, 
salary - avg(salary) over (partition by department_id) as diff_from_avg,
rank() over (partition by department_id order by salary desc) as salary_rank,
row_number() over (partition by department_id order by salary desc) as row_num
from hr.employees;

/*For each employee: show emp_id, dept_id, salary, avg dept salary, 
diff from avg, rank, row number (salary order in dept)*/

select employee_id, department_id, salary,
avg(salary) over (partition by department_id) as avg_dept_salary,
salary - avg(salary) over (partition by department_id) as diff_from_avg,
rank() over (partition by department_id order by salary desc) as salary_rank,
row_number() over (partition by department_id order by salary desc) as row_num
from hr.employees;

/*Show employees’ salary, previous and next salary in dept using LAG/LEAD*/

select employee_id, department_id, salary, 
lag(salary) over (partition by department_id order by salary) as prev_salary,
lead(salary) over (partition by department_id order by salary) as next_salary
from hr.employees;

/*Show employees’ salary, previous and next salary in dept using LAG/LEAD*/

select employee_id, department_id, salary,
lag(salary) over (partition by department_id order by salary) as prev_salary,
lead(salary) over (partition by department_id order by salary) as next_salary
from hr.employees;

/*Show employees’ salary, previous and next salary in dept using LAG/LEAD*/

select employee_id, department_id, salary,
lag(salary) over (partition by department_id order by salary desc) as prev_salary,
lead(salary) over (partition by department_id order by salary desc) as next_salary
from hr.employees;

/*Show employees’ salary, previous and next salary in dept using LAG/LEAD*/

select employee_id, department_id, salary,
lag(salary) over (partition by department_id order by salary desc) as prev_salary,
lead(salary) over (partition by department_id order by salary desc) as next_salary
from hr.employees;

/*Show employees’ salary, previous and next salary in dept using LAG/LEAD*/

select employee_id, department_id, salary,
lag(salary) over (partition by department_id order by salary desc) as prev_salary,
lead(salary) over (partition by department_id order by salary desc) as next_salary
from hr.employees;

/*Show employees’ salary, previous and next salary in dept using LAG/LEAD*/

select employee_id, department_id, salary,
lag(salary) over (partition by department_id order by salary desc) as prev_salary,
lead(salary) over (partition by department_id order by salary desc) as next_salary
from hr.employees;

/*Show employees’ salary, previous and next salary in dept using LAG/LEAD*/

select employee_id, department_id, salary,
lag(salary) over (partition by department_id order by salary desc) as prev_salary,
lead(salary) over (partition by department_id order by salary desc) as next_salary
from hr.employees;

/*For each employee, get their rank, dense_rank, and row_number by salary in department*/

select employee_id, department_id, salary,
rank() over (partition by department_id order by salary ) as rank,
dense_rank() over (partition by department_id order by salary ) as dense_rank,
row_number() over (partition by department_id order by salary ) as row_num
from hr.employees;

/*For each employee, get their rank, dense_rank, and row_number by salary in department*/

select employee_id, department_id, salary,
rank() over (partition by department_id order by salary) as rank,
dense_rank() over (partition by department_id order by salary) as dense_rank,
row_number() over (partition by department_id order by salary) as row_num
from hr.employees;

/*For each employee, get their rank, dense_rank, and row_number by salary in department*/

select employee_id, department_id, salary,
rank() over (partition by department_id order by salary) as rank,
dense_rank() over (partition by department_id order by salary) as dense_rank,
row_number() over (partition by department_id order by salary) as row_num
from hr.employees;

/*List the top 3 highest-paid employees in each department*/

select * from (
select employee_id, first_name, last_name, department_id, salary,
dense_rank() over (partition by department_id order by salary desc) as salary_rank
from hr.employees
)
where salary_rank <= 3;

/*List the top 3 highest-paid employees in each department*/

select * from (
select employee_id, first_name, last_name, department_id, salary,
dense_rank() over (partition by department_id order by salary desc) as salary_rank
from hr.employees
)
where salary_rank <= 3;

/*List the top 3 highest-paid employees in each department*/

select * from (
select employee_id, first_name, last_name, department_id, salary,
dense_rank() over (partition by department_id order by salary desc) as salary_rank
from hr.employees
)
where salary_rank <= 3;

/*List the top 3 highest-paid employees in each department*/

select * from (
select employee_id, first_name, last_name, department_id, salary,
dense_rank() over (partition by department_id order by salary desc) as salary_rank
from hr.employees
)
where salary_rank <= 3;

/*List the top 3 highest-paid employees in each department*/

select * from (
select employee_id, first_name, last_name, department_id, salary,
dense_rank() over (partition by department_id order by salary desc) as salary_rank
from hr.employees
)
where salary_rank <=3;

/*List the top 3 highest-paid employees in each department*/

select * from (
select employee_id, first_name, last_name, department_id, salary,
dense_rank() over (partition by department_id order by salary desc) as salary_rank
from hr.employees
)
where salary_rank <= 3;

/*Cumulative sum of salary within department, ordered by employee_id*/

select employee_id, department_id, salary, 
sum(salary) over (partition by department_id order by employee_id rows between
unbounded preceding and current row) as cumulative_salary 
from hr.employees;

/*Cumulative sum of salary within department, ordered by employee_id*/

select employee_id, department_id, salary,
sum(salary) over (partition by department_id order by employee_id rows between
unbounded preceding and current row) as cumulative_salary
from hr.employees;

/*Cumulative sum of salary within department, ordered by employee_id*/

select employee_id, department_id, salary,
sum(salary) over (partition by department_id order by employee_id rows between
unbounded preceding and current row) as cumulative_salary
from hr.employees;

/*Cumulative sum of salary within department, ordered by employee_id*/

select employee_id, department_id, salary,
sum(salary) over (partition by department_id order by employee_id rows between
unbounded preceding and current row) as cumulative_salary
from hr.employees;

/*Cumulative sum of salary within department, ordered by employee_id*/

select employee_id, department_id, salary,
sum(salary) over (partition by department_id order by employee_id rows between
unbounded preceding and current row)as cumulative_salary
from hr.employees;

/*Cumulative sum of salary within department, ordered by employee_id*/

select employee_id, department_id, salary,
sum(salary) over (partition by department_id order by employee_id rows between
unbounded preceding and current row) as cumulative_salary
from hr.employees;

/*Cumulative sum of salary within department, ordered by employee_id*/

select employee_id, department_id, salary,
sum(salary) over (partition by department_id order by employee_id rows between
unbounded preceding and current row)as cumulative_salary
from hr.employees;

/*Cumulative sum of salary within department, ordered by employee_id*/

select employee_id ,department_id, salary,
sum(salary) over (partition by department_id order by employee_id rows between
unbounded preceding and current row)as cumulative_salary
from hr.employees;

/*Cumulative sum of salary within department, ordered by employee_id*/

select employee_id, department_id, salary, 
sum(salary) over (partition by department_id order by employee_id rows between
unbounded preceding and current row)as cumulative_salary
from hr.employees;

/*Cumulative sum of salary within department, ordered by employee_id*/

select employee_id, department_id, salary,
sum(salary) over (partition by department_id order by employee_id rows between
unbounded preceding and current row) as cumulative_salary
from hr.employees;

/*Cumulative sum of salary within department, ordered by employee_id*/

select employee_id, department_id, salary,
sum(salary) over (partition by department_id order by employee_id rows between
unbounded preceding and current row)as cumulative_salary
from hr.employees;

/*Employee count by department (aggregate and analytic)*/

-- Aggregate

select department_id, count(*) as dept_count
from hr.employees
group by department_id;

-- Analytic

select employee_id, department_id,
count(*) over (partition by department_id) as dept_count
from hr.employees;

/*Employee count by department (aggregate and analytic)*/

--Aggregate

select department_id, count(*) as dept_count
from hr.employees
group by department_id;

--Analytic

select employee_id, department_id,
count(*) over (partition by department_id) as dept_count
from hr.employees;

/*Employee count by department (aggregate and analytic)*/

--Aggregate

select department_id, count(*) as dept_count
from hr.employees
group by department_id;

--Analytic

select employee_id, department_id,
count(*) over (partition by department_id) as dept_count
from hr.employees;

/*Employee count by department (aggregate and analytic)*/

--Aggregate

select department_id, count(*) as dept_count
from hr.employees
group by department_id;

--Analytic

select employee_id, department_id,
count(*) over (partition by department_id) as dept_count
from hr.employees;

/*List second highest salary in HR*/

select first_name, last_name, salary
from (
select first_name, last_name, salary,
dense_rank() over (order by salary desc) as rnk
from hr.employees
)
where rnk = 2;

/*List second highest salary in HR*/

select first_name, last_name, salary
from (
select first_name, last_name, salary,
dense_rank() over (order by salary desc) as rnk
from hr.employees
)
where rnk = 2;

/*List second highest salary in HR*/

select first_name, last_name, salary
from (
select first_name, last_name, salary,
dense_rank() over (order by salary desc) as rnk
from hr.employees
)
where rnk=2;

/*List second highest salary in HR*/

select first_name, last_name, salary
from (
select first_name, last_name, salary,
dense_rank() over (order by salary desc) as rnk
from hr.employees
)
where rnk=2;

/*Show employees with second lowest salary in each department*/

select employee_id, department_id, salary
from (
select employee_id, department_id, salary,
dense_rank() over (partition by department_id order by salary asc) as sal_rnk
from hr.employees
)
where sal_rnk=2;

/*Show employees with second lowest salary in each department*/

select employee_id, department_id, salary
from (
select employee_id, department_id, salary,
dense_rank() over (partition by department_id order by salary asc) as sal_rnk
from hr.employees
)
where sal_rnk=2;

/*Show employees with second lowest salary in each department*/

select employee_id, department_id, salary
from( 
select employee_id, department_id, salary,
dense_rank() over (partition by department_id order by salary asc) as sal_rnk
from hr.employees
)
where sal_rnk=2;

/*Show employees with second lowest salary in each department*/

select employee_id, department_id, salary
from (
select employee_id, department_id, salary,
dense_rank() over (partition by department_id order by salary asc) as sal_rnk
from hr.employees
)
where sal_rnk=2;

/*For each department, show employee with highest 
and lowest salary using analytic functions*/

select employee_id, department_id, salary,
min(salary) keep (dense_rank first order by salary) over (partition by department_id) as lowest,
max(salary) keep (dense_rank last order by salary) over (partition by department_id) as highest
from hr.employees
order by department_id, salary;

/*For each department, show employee with highest 
and lowest salary using analytic functions*/

select employee_id, department_id, salary,
min(salary) keep (dense_rank first order by salary) over (partition by department_id) as lowest,
max(salary) keep (dense_rank last order by salary) over (partition by department_id) as highest
from hr.employees
order by department_id, salary;

/*For each department, show employee with highest 
and lowest salary using analytic functions*/

select employee_id, department_id, salary,
min(salary) keep (dense_rank first order by salary) over (partition by department_id) as lowest,
max(salary) keep (dense_rank last order by salary) over (partition by department_id) as highest
from hr.employees
order by department_id, salary;

/*For each department, show employee with highest 
and lowest salary using analytic functions*/

select employee_id, department_id, salary,
min(salary) keep (dense_rank first order by salary) over (partition by department_id) as lowest,
max(salary) keep (dense_rank last order by salary) over (partition by department_id) as highest
from hr.employees
order by department_id, salary;

/*For each department, show employee with highest 
and lowest salary using analytic functions*/

select employee_id, department_id, salary,
min(salary) keep (dense_rank first order by salary) over (partition by department_id) as lowest,
max(salary) keep (dense_rank last order by salary) over (partition by department_id) as highest
from hr.employees
order by department_id, salary;

---------------------Batch 4: CASE, Grouping, Rollup, Cube, Aggregation------------------------

/*Classify employees by salary with CASE and group/count by department*/

select department_id,
case
when salary > 10000 then 'high'
when salary > 6000 then 'medium'
else 'low'
end as salary_category,
count(*) as num_employees
from hr.employees
group by department_id,
case
when salary > 10000 then 'high'
when salary > 6000 then 'medium'
else 'low'
end;

/*Classify employees by salary with CASE and group/count by department*/

select department_id,
case
when salary > 10000 then 'high'
when salary > 6000 then 'medium'
else 'low'
end as salary_category,
count(*) as num_employees
from hr.employees
group by department_id,
case
when salary > 10000 then 'high'
when salary > 6000 then 'medium'
else 'low'
end;

/*Classify employees by salary with CASE and group/count by department*/

select department_id,
case
when salary > 10000 then 'high'
when salary > 6000 then 'medium'
else 'low'
end as salary_category,
count(*) as num_employees
from hr.employees
group by department_id,
case
when salary > 10000 then 'high'
when salary > 6000 then 'medium'
else 'low'
end;

/*Classify employees by salary with CASE and group/count by department*/

select department_id,
case
when salary > 10000 then 'high'
when salary > 6000 then 'medium'
else 'low'
end as salary_category,
count(*) as num_employees
from hr.employees
group by department_id,
case
when salary > 10000 then 'high'
when salary > 6000 then 'medium'
else 'low'
end;

/*Classify employees by salary with CASE and group/count by department*/

select department_id,
case
when salary > 10000 then 'high'
when salary > 6000 then 'medium'
else 'low'
end as salary_category,
count(*) as num_employees
from hr.employees
group by department_id,
case
when salary > 10000 then 'high'
when salary > 6000 then 'medium'
else 'low'
end;

/*GROUP BY GROUPING SETS: avg salary for each department, job, and grand total*/

select department_id, job_id, avg(salary) as avg_salary
from hr.employees
group by grouping sets (
(department_id),
(job_id),
()
);

/*GROUP BY GROUPING SETS: avg salary for each department, job, and grand total*/

select department_id, job_id, avg(salary) as avg_salary
from hr.employees
group by grouping sets (
(department_id),
(job_id),
()
);

/*GROUP BY GROUPING SETS: avg salary for each department, job, and grand total*/

select department_id, job_id, avg(salary) as avg_salary
from hr.employees
group by grouping sets (
(department_id),
(job_id),
()
);

/*GROUP BY GROUPING SETS: avg salary for each department, job, and grand total*/

select department_id, job_id, avg(salary) as avg_salary
from hr.employees
group by grouping sets(
(department_id),
(job_id),
()
);

/*Use ROLLUP to count employees by department and job, with subtotals and grand total*/

select department_id, job_id, count(*) as employee_count
from hr.employees
group by rollup (department_id, job_id);

/*Use ROLLUP to count employees by department and job, with subtotals and grand total*/

select department_id, job_id, count(*) as employee_count
from hr.employees
group by rollup (department_id, job_id);

/*Use ROLLUP to count employees by department and job, with subtotals and grand total*/

select department_id, job_id, count(*) as employee_count
from hr.employees
group by rollup (department_id, job_id);

/*Use ROLLUP to count employees by department and job, with subtotals and grand total*/

select department_id, job_id, count(*) as employee_count
from hr.employees
group by rollup (department_id, job_id);

/*Use CUBE to show total salary for every combination of department and job, 
with subtotals and grand total*/

select department_id, job_id, sum(salary) as total_salary
from hr.employees
group by cube (department_id, job_id);

/*Use CUBE to show total salary for every combination of department and job, 
with subtotals and grand total*/

select department_id, job_id, sum(salary) as total_salary
from hr.employees
group by cube (department_id, job_id);

/*Use CUBE to show total salary for every combination of department and job, 
with subtotals and grand total*/

select department_id, job_id, sum(salary) as total_salary
from hr.employees
group by cube(department_id, job_id);

/*Use CUBE to show total salary for every combination of department and job, 
with subtotals and grand total*/

select department_id, job_id, sum(salary) as total_salary
from hr.employees
group by cube (department_id, job_id);

/*Use CUBE to show total salary for every combination of department and job, 
with subtotals and grand total*/

select department_id, job_id, sum(salary) as total_salary
from hr.employees
group by cube (department_id, job_id);

/*GROUPING_ID to distinguish subtotal/grand total rows in ROLLUP*/

select department_id, job_id, count(*) as employee_count, grouping_id(department_id, job_id) as grp_id
from hr.employees
group by rollup(department_id, job_id);

/*GROUPING_ID to distinguish subtotal/grand total rows in ROLLUP*/

select department_id, job_id, 
count(*) as employee_count, 
grouping_id(department_id, job_id) as grp_id
from hr.employees
group by rollup (department_id, job_id);

/*GROUPING_ID to distinguish subtotal/grand total rows in ROLLUP*/

select department_id, job_id,
count(*) as employee_count,
grouping_id (department_id, job_id) as grp_id
from hr.employees
group by rollup (department_id, job_id);

/*GROUPING_ID to distinguish subtotal/grand total rows in ROLLUP*/

select department_id, job_id,
count(*) as employee_count,
grouping_id(department_id, job_id) as grp_id
from hr.employees
group by rollup (department_id, job_id);

/*For each department and job_id, number of employees 
and subtotal rows with ROLLUP, mark with GROUPING()*/

select department_id, job_id,
count(*) as employee_count,
grouping(department_id) as dept_group,
grouping(job_id) as job_group
from hr.employees
group by rollup (department_id, job_id)
order by department_id, job_id;

/*For each department and job_id, number of employees 
and subtotal rows with ROLLUP, mark with GROUPING()*/

select department_id, job_id,
count(*) as employee_count,
grouping (department_id) as dept_group,
grouping (job_id) as job_group
from hr.employees
group by rollup (department_id, job_id)
order by department_id, job_id;

/*For each department and job_id, number of employees 
and subtotal rows with ROLLUP, mark with GROUPING()*/

select department_id, job_id,
count(*) as employee_count,
grouping (department_id) as dept_group,
grouping (job_id) as job_group
from hr.employees
group by rollup (department_id, job_id)
order by department_id, job_id;

/*For each department and job_id, number of employees 
and subtotal rows with ROLLUP, mark with GROUPING()*/

select department_id, job_id,
count(*) as employee_count,
grouping (department_id) as dept_group,
grouping (job_id) as job_group
from hr.employees
group by rollup (department_id, job_id)
order by department_id, job_id;

/*For each department and job_id, number of employees 
and subtotal rows with ROLLUP, mark with GROUPING()*/

select department_id, job_id,
count(*) as employee_count,
grouping (department_id) as dept_group,
grouping (job_id) as job_group
from hr.employees
group by rollup (department_id, job_id)
order by department_id, job_id;

/*GROUPING SETS to provide avg, min, max salary for department, 
job, department+job, and all*/

select department_id, job_id,
avg(salary) as avg_salary,
min(salary) as min_salary,
max(salary) as max_salary,
grouping_id(department_id, job_id) as grouping_level
from hr.employees
group by grouping sets(
(department_id, job_id),
(department_id),
(job_id),
()
);

/*GROUPING SETS to provide avg, min, max salary for department, 
job, department+job, and all*/

select department_id, job_id,
avg(salary) as avg_salary,
min(salary) as min_salary,
max(salary) as max_salary,
grouping_id (department_id, job_id) as grouping_level
from hr.employees
group by grouping sets (
(department_id, job_id),
(department_id),
(job_id),
()
);

/*GROUPING SETS to provide avg, min, max salary for department, 
job, department+job, and all*/

select department_id, job_id,
avg(salary) as avg_salary,
min(salary) as min_salary,
max(salary) as max_salary,
grouping_id (department_id, job_id) as group_level
from hr.employees
group by grouping sets (
(department_id), (job_id),
(department_id),
(job_id),
()
);


/*GROUPING SETS to provide avg, min, max salary for department, 
job, department+job, and all*/

select department_id, job_id,
avg(salary) as avg_salary,
min(salary) as min_salary,
max(salary) as max_salary,
grouping_id (department_id, job_id) as grouping_level
from hr.employees
group by grouping sets (
(department_id, job_id),
(department_id),
(job_id),
()
);

/*Group employees by job_id, return job_id, 
number of employees, and average salary*/

select job_id, count(*) as num_employees,
avg(salary) as avg_salary
from hr.employees
group by job_id;

/*Group employees by job_id, return job_id, 
number of employees, and average salary*/

select job_id, count(*) as employee_count,
avg(salary) as avg_salary
from hr.employees
group by job_id;

/*Group employees by job_id, return job_id, 
number of employees, and average salary*/

select job_id, count(*) as employee_count,
avg(salary) as avg_salary
from hr.employees
group by job_id;

/*Group employees by job_id, return job_id, 
number of employees, and average salary*/

select job_id, count(*) as employee_count,
avg(salary) as avg_salary
from hr.employees
group by job_id;

/*Group employees by job_id, return job_id, 
number of employees, and average salary*/

select job_id, count(*) as employee_count,
avg(salary) as avg_salary
from hr.employees
group by job_id;

/*Group employees by job_id, return job_id, 
number of employees, and average salary*/

select job_id, count(*) as employee_count,
avg(salary) as avg_salary
from hr.employees
group by job_id;

/*Group employees by job_id, return job_id, 
number of employees, and average salary*/

select job_id, count(*) as employee_count,
avg(salary) as avg_salary
from hr.employees
group by job_id;

/*Group employees by job_id, return job_id, 
number of employees, and average salary*/

select job_id, count(*) as employee_count,
avg(salary) as avg_salary
from hr.employees
group by job_id;

--------------------Batch 5: Table Design, DDL, Users & Privileges, Validation--------------------------

/*Find all employees with the same job as a given employee (self-join scenario)*/

select e1.first_name as employee, e2.first_name as collegue, e1.job_id
from hr.employees e1
join hr.employees e2
on e1.job_id = e2.job_id and e1.employee_id <> e2.employee_id
where e1.first_name = 'Lex' and e1.last_name = 'De Haan';

/*Find all employees with the same job as a given employee (self-join scenario)*/

select e1.first_name as employee, e2.first_name as collegue, e1.job_id
from hr.employees e1
join hr.employees e2
on e1.job_id = e2.job_id and e1.employee_id <> e2.employee_id
where e1.first_name = 'Lex' and e1.last_name = 'De Haan';

/*Find all employees with the same job as a given employee (self-join scenario)*/

select e1.first_name as employee, e1.last_name as collegue, e1.job_id
from hr.employees e1
join hr.employees e2
on e1.job_id = e2.job_id and e1.employee_id <> e2.employee_id
where e1.first_name = 'Lex' and e1.last_name = 'De Haan';

/*Find all employees with the same job as a given employee (self-join scenario)*/

select e1.first_name as employee, e1.last_name as collegue, e1.job_id
from hr.employees e1
join hr.employees e2
on e1.job_id = e2.job_id and e1.employee_id <> e2.employee_id
where e1.first_name = 'Lex' and e1.last_name = 'De Haan';

/*Find all employees with the same job as a given employee (self-join scenario)*/

select e1.first_name as employee, e1.last_name as collegue, e1.job_id
from hr.employees e1
join hr.employees e2
on e1.job_id = e2.job_id and e1.employee_id <> e2.employee_id
where e1.first_name = 'Lex' and e1.last_name = 'De Haan';

/*Find all employees with the same job as a given employee (self-join scenario)*/

select e1.first_name as employee, e1.last_name as collegue, e1.job_id
from hr.employees e1
join hr.employees e2
on e1.job_id = e2.job_id and e1.employee_id <> e2.employee_id
where e1.first_name = 'Lex' and e1.last_name = 'De Haan';

/*Find all employees with the same job as a given employee (self-join scenario)*/

select e1.first_name as employee, e1.last_name as collegue, e1.job_id
from hr.employees e1
join hr.employees e2
on e1.job_id = e2.job_id and e1.employee_id <> e2.employee_id
where e1.first_name = 'Lex' and e1.last_name = 'De Haan';

/*List all departments with fewer than 3 employees*/

select department_id, count(*) as num_employees
from hr.employees
group by department_id
having count(*) < 3;

/*List all departments with fewer than 3 employees*/

select department_id, count(*) as num_employee
from hr.employees
group by department_id
having count(*) < 3;

/*List all departments with fewer than 3 employees*/

select department_id, count(*) as num_employees
from hr.employees
group by department_id
having count(*) < 3;

/*List all departments with fewer than 3 employees*/

select department_id, count(*) as num_employees
from hr.employees
group by department_id
having count(*) < 3;

/*List all departments with fewer than 3 employees*/

select department_id, count(*) as num_employee
from hr.employees
group by department_id
having count(*) < 3;

/*List all departments with fewer than 3 employees*/

select department_id, count(*) as num_employee
from hr.employees
group by department_id
having count(*) < 3;

/*List all departments with fewer than 3 employees*/

select department_id, count(*) as num_employees
from hr.employees
group by department_id
having count(*) < 3;

/*List all departments with fewer than 3 employees*/

select department_id, count(*) as num_employees
from hr.employees
group by department_id
having count(*) < 3;

/*List all departments with fewer than 3 employees*/

select department_id, count(*) as num_employees
from hr.employees
group by department_id
having count(*) < 3;

/*List all departments with fewer than 3 employees*/ 

select department_id, count(*) as num_employees
from hr.employees
group by department_id
having count(*) < 3;

/*List all departments with fewer than 3 employees*/

select department_id, count(*) as num_employees
from hr.employees
group by department_id
having count(*) < 3;

/*List all departments with fewer than 3 employees*/

select department_id, count(*) as num_employees
from hr.employees
group by department_id
having count(*) < 3;

/*List every job_id, its minimum and maximum salary across all employees*/

select job_id, min(salary) as min_salary, max(salary) as max_salary
from hr.employees
group by job_id;

/*List every job_id, its minimum and maximum salary across all employees*/

select job_id, min(salary) as min_salary, max(salary) as max_salary
from hr.employees
group by job_id;

/*List every job_id, its minimum and maximum salary across all employees*/

select job_id, min(salary) as min_salary, max(salary) as max_salary
from hr.employees
group by job_id;

/*List every job_id, its minimum and maximum salary across all employees*/

select job_id, min(salary) as min_salary, max(salary) as max_salary
from hr.employees
group by job_id;

/*Find all managers and how many direct reports they have*/

select manager_id, count(*) as num_reports
from hr.employees
where manager_id is not null
group by manager_id;

/*Find all managers and how many direct reports they have*/

select manager_id, count(*) as num_reports
from hr.employees
where manager_id is not null
group by manager_id;

/*Practical question 1*/

create user u1 identified by p1;
create user u2 identified by p2;

grant connect, resource to u2;
grant connect, resource to u1 with admin option;

connect u1/p1;

revoke connect, resource from u2;

drop user u2 cascade;

/*Practical question 1*/

create user u1 identified by p1;
create user u2 identified by p2;

grant connect, resource to u2;
grant connect, resource to u1 with admin option;

connect u1/p1;

revoke connect, resource from u2;

drop user u2 cascade;

/*Practical question 1*/

create user u1 identified by p1;
create user u2 identified by p2;

grant connect, resource to u2;
grant connect, resource to u1 with admin option;

connect u1/p1;

revoke connect, resource from u2;

drop user u2 cascade;

/*Practical question 1*/

create user u1 identified by p1;
create user u2 identified by p2;

grant connect, resource to u2;
grant connect, resource to u1 with admin option;

connect u1/p1;

revoke connect, resource from u2;

drop user u2 cascade;

/*Practical question 1*/

create user u1 identified by p1;
create user u2 identified by p2;

grant connect, resource to u2;
grant connect, resource to u1 with admin option;

connect u1/p1;

revoke connect, resource from u2;

drop user u2 cascade;


-------------------------------Practical question 2-----------------------------

/*Find out the root node for given data of employee*/

select employee_id, first_name
from hr.employees
start with manager_id is null
connect by prior employee_id = manager_id;

/*Find out the root node for given data of employee*/

select employee_id, first_name
from hr.employees
start with manager_id is null
connect by prior employee_id = manager_id;

/*Find out the root node for given data of employee*/

select employee_id, first_name
from hr.employees
start with manager_id is null
connect by prior employee_id = manager_id;

/*Find out the root node for given data of employee*/

select employee_id, first_name
from hr.employees
start with manager_id is null
connect by prior employee_id  = manager_id;

/*Find out the root node for given data of employee*/

select employee_id, first_name
from hr.employees
start with manager_id is null
connect by prior employee_id = manager_id;

/*Display all details of employee having second highest salary*/

select * 
from (
select e.*, dense_rank() over (order by salary desc) as sal_rank
from employees e
)
where sal_rank=2;

/*Display all details of employee having second highest salary*/

select * from (
select e.*, dense_rank() over (order by salary desc) as sal_rank
from employees e
)
where sal_rank=2;

/*Display all details of employee having second highest salary*/

select * from (
select e.*, dense_rank() over (order by salary desc) as sal_rank
from hr.employees e
)
where sal_rank=2;

/*Display all details of employee having second highest salary*/

select * from (
select e.*, dense_rank() over (order by salary desc) as sal_rank
from hr.employees e
)
where sal_rank=2;

/*Display all the details of employee having second highest salary*/

select * from (
select e.*, dense_rank() over (order by salary desc) as sal_rank
from hr.employees e
)
where sal_rank = 2;

/*Display all details of employee having second highest salary*/

select * from (
select e.*, dense_rank() over (order by salary desc) as sal_rank
from hr.employees e
)
where sal_rank = 2;

/*Display all details of employee having second highest salary*/

select * from (
select e.*, dense_rank() over (order by salary desc) as sal_rank
from hr.employees e
)
where sal_rank = 2;

/*Display all details of employee having second highest salary*/

select * from (
select e.*, dense_rank() over (order by salary desc) sal_rank
from hr.employees e
)
where sal_rank=2;

/*Display all details of employee having second highest salary*/

select * from (
select e.*, dense_rank() over (order by salary desc) sal_rank
from hr.employees e
)
where sal_rank = 2

/*Display all details of employee having second highest salary*/

select * from (
select e.*, dense_rank() over (order by salary desc) as sal_rank
from hr.employees e
)
where sal_rank = 2;

/*Display all details of employee having second highest salary*/

select * from (
select e.*, dense_rank() over (order by salary desc) as sal_rank
from hr.employees e
)
where sal_rank = 2;

/*Display all details of employee having second highest salary*/

select * from (
select e.*, dense_rank() over (order by salary desc) as sal_rank
from hr.employees e
)
where sal_rank = 2;

/*Create a report that shows job name, department name, and average salary of 
employees for each department, job, specific job in a department 
and overall (for the whole company)*/

SELECT j.job_title, d.department_name,
       ROUND(AVG(salary), 2) AS avg_salary
FROM employees e
JOIN jobs j ON e.job_id = j.job_id
JOIN departments d ON e.department_id = d.department_id
GROUP BY GROUPING SETS (
  (j.job_title),
  (d.department_name),
  (j.job_title, d.department_name),
  ()
);

/*Create a report that shows job name, department name, and average salary of 
employees for each department, job, specific job in a department 
and overall (for the whole company)*/

select j.job_title, d.department_name,
round(avg(salary), 2) as avg_salary
from hr.employees e
join jobs j on e.job_id = j.job_id
join departments d on e.department_id = d.department_id
group by grouping sets (
(j.job_title),
(d.department_name),
(j.job_title, d.department_name),
()
);

/*Create a report that shows job name, department name, and average salary of 
employees for each department, job, specific job in a department 
and overall (for the whole company)*/

select j.job_title, d.department_name,
round(avg(salary), 2) as avg_salary
from hr.employees e
join jobs j on e.job_id = j.job_id
join departments d on e.department_id = d.department_id
group by grouping sets (
(j.job_title),
(d.department_name),
(j.job_title, d.department_name),
()
);

/*Display all details of employee having second highest salary*/

select * from (
select e.*, dense_rank() over (order by salary desc) as sal_rank
from hr.employees e
)
where sal_rank = 2;

/*Find out the root node for given data of employee*/

select employee_id, first_name
from hr.employees
start with manager_id is null
connect by prior employee_id = manager_id;

/*Create a report that shows job name, department name, and average salary of 
employees for each department, job, specific job in a department 
and overall (for the whole company)*/

select j.job_title, d.department_name,
round(avg(salary), 2) as avg_salary
from hr.employees e
join jobs j on e.job_id = j.job_id
join departments d on e.department_id = d.department_id
group by grouping sets (
(j.job_title),
(d.department_name),
(j.job_title, d.department_name),
()
);

/*Find out the root node for given data of employee*/

select employee_id, first_name
from hr.employees
start with manager_id is null
connect by prior employee_id = manager_id;

/*Find details of second highest earning employee*/

select * from (
select e.*, dense_rank() over (order by salary desc) as sal_rank
from hr.employees e
)
where sal_rank = 2;

/*Practical Question 1*/

create user u1 identified by p1;
create user u2 identified by p2;

grant connect, resource to u2;
grant connect, resource to u1 with admin option;

connect u1/p1;

revoke connect, resource from u2;

drop user u2 cascade;

/*Practical Question 1*/

create user u1 identified by p1;
create user u2 identified by p2;

grant connect, resource to u1;
grant connect, resource to u2;
grant create session, create table to u2;
grant grant any privilege to u1;

connect u1/p1

revoke connect, resource from u2;
revoke create table from u2;

drop user u2 cascade;

/*Practical Question 1*/

create user u1 identified by p1;
create user u2 identified by p2;

grant connect, resource to u1;
grant connect, resource to u2;
grant create session, create table to u2;
grant grant any privilege to u1;

connect u1/p1;

revoke connect, resource from u2;
revoke create table from u2;

drop user u2 cascade;

/*Practical Question 1*/

create user u1 identified by p1;
create user u2 identified by p2;

grant connect, resource to u2;
grant connect, resource to u1;
grant create session, create table to u2;
grant grant any privilege to u1;

connect u1/p1;

revoke connect, resource from u2;
revoke create table from u2;

drop user u2 cascade;


/*Find the root node (employee with no manager):*/

select employee_id, first_name
from hr.employees
start with manager_id is null
connect by prior employee_id = manager_id;

/*Display all details of employee having second highest salary:*/

select * from (
select e.*, dense_rank() over (order by salary desc) as sal_rank
from hr.employees e
)
where sal_rank = 2;

/*Create a report showing job name, department name, and average salary:*/

select j.job_title, d.department_name,
round(avg(salary), 2) as avg_salary
from hr.employees e
join jobs j on e.job_id = j.job_id
join departments d on e.department_id = d.department_id
group by grouping sets (
(j.job_title),
(d.department_name),
(j.job_title, d.department_name),
()
);

/*Find the root node (employee with no manager):*/

select employee_id, first_name
from hr.employees
start with manager_id is null
connect by prior employee_id = manager_id;

/*Display all details of employee having second highest salary:*/

select * from (
select e.*, dense_rank() over (order by salary desc) as sal_rank
from hr.employees e
)
where sal_rank = 2;

/*Create a report showing job name, department name, and average salary:*/

select j.job_title, d.department_name,
round(avg(salary), 2) as avg_salary
from hr.employees e
join jobs j on e.job_id = j.job_id
join departments d on e.department_id = d.department_id
group by grouping sets(
(j.job_title),
(d.department_name),
(j.job_title, d.department_name),
()
);

/*Practical Question 1*/

create user u1 identified by p1;
create user u2 identified by p2;

grant connect, resource to u2;
grant connect, resource to u1;
grant create session, create table to u2;
grant grant any privilege to u1;

connect u1/p1;

revoke connect, resource from u2;
revoke create table from u2;

drop user u2 cascade;