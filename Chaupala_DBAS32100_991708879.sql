-- Filename: Chaupala_DBAS32100_991708879.sql
-- Name: Palak Yogesh Chaudhary
-- Oracle Username: s1_chaupala

-- Q1: Write a PL/SQL code to display employee details along with region and country name of 5 lowest paid employees.

set serveroutput on;

declare
  cursor emp_c is
    select e.employee_id, e.first_name, e.last_name, e.salary,
           c.country_name, r.region_name
    from hr.employees e
    join hr.departments d on e.department_id = d.department_id
    join hr.locations l on d.location_id = l.location_id
    join hr.countries c on l.country_id = c.country_id
    join hr.regions r on c.region_id = r.region_id
    order by e.salary
    fetch first 5 rows only;
begin
  for e in emp_c loop
    dbms_output.put_line('EmpID: '||e.employee_id||' Name: '||e.first_name||' '||e.last_name||' Salary: '||e.salary||' Country: '||e.country_name||' Region: '||e.region_name);
  end loop;
end;
/

-- Q2: Write a PL/SQL block of code to generate Fibonacci series between 1 to 100

set serveroutput on;

declare
  a number := 0;
  b number := 1;
  c number := 0;
begin
  dbms_output.put_line('Fibonacci Series between 1 and 100:');
  while c <= 100 loop
    if c >= 1 then
      dbms_output.put_line(c);
    end if;
    c := a + b;
    a := b;
    b := c;
  end loop;
end;
/

-- Q3: Create PL/SQL block of code to display all records of employee table using explicit cursors.

set serveroutput on;

declare
  cursor emp_cur is
    select * from hr.employees;
  r emp_cur%rowtype;
begin
  open emp_cur;
  loop
    fetch emp_cur into r;
    exit when emp_cur%notfound;
    dbms_output.put_line('ID:'||r.employee_id||' Name:'||r.first_name||' '||r.last_name||' Salary:'||r.salary);
  end loop;
  close emp_cur;
end;
/
