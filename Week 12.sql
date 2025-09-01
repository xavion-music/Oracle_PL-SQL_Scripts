-- Who is the manager of 'Bruce Ernst'

select manager_id from hr.employees 
where employee_id=(select manager_id from hr.employees
where first_name='Bruce' and last_name='Ernst');

-- Hierarchical queries
/*
select cloumn1, column2, ...
from table
start with condition1
connect by prior condition2;
*/

-- list out employees directly or inddirectly working under Bruce Ernst
select employee_id, first_name, last_name, manager_id from hr.employees
strat with first_name='Bruce' and last_name='Ernst'
connect by prior employee_id=manager_id;

select employee_id,first_name,last_name,manager_id from hr.employees order by manager_id nulls first;

--who is the manager of 'Bruce Ernst'?
select first_name,last_name from hr.employees where employee_id=(select manager_id from hr.employees
where first_name='Bruce' and last_name='Ernst');

--Hierarchical queries
/*
SELECT column1, column2, ...
FROM table
START WITH condition1
CONNECT BY PRIOR condition2;
*/
--list out employees directly or indirectly working under bruce ernst
select employee_id,first_name,last_name,manager_id from hr.employees
start with first_name='Bruce' and last_name='Ernst'
connect by prior employee_id=manager_id;

--list out direct and indirect manager of bruce ernst
select employee_id,first_name,last_name,manager_id from hr.employees
start with first_name='Bruce' and last_name='Ernst'
connect by prior manager_id=employee_id;

--list out manager name of bruce ernst
select employee_id,first_name,last_name,manager_id,level from hr.employees where level=2
start with first_name='Bruce' and last_name='Ernst'
connect by prior manager_id=employee_id;

--Excercise 3.1
select employee_id,first_name,last_name,manager_id from hr.employees
start with first_name='Lex' and last_name='De Haan'
connect by prior employee_id=manager_id;

select employee_id,first_name,last_name,manager_id,level from hr.employees --where level=2
start with manager_id is null
connect by prior manager_id=employee_id order by level;

select level,count(employee_id) from hr.employees
start with manager_id is null
connect by prior employee_id=manager_id group by level order by level;


select sys_connect_by_path(first_name,'/') as "Hierarchy" from hr.employees
start with manager_id is null
connect by prior employee_id=manager_id;

select sys_connect_by_path(first_name,'/') as "Hierarchy" from hr.employees
start with first_name='Lex'
connect by prior employee_id=manager_id;

-- List out all the employee details who is managed by Matthew directly or indirectly

--select * from employees;

select employee_id,first_name,last_name,manager_id,job_id,email,phone_number,hire_date,
department_id,salary from hr.employees
start with first_name='Matthew'
connect by prior employee_id=manager_id;

--Analytical functions
select round(avg(salary)) as "average salary" from hr.employees;
select department_id, round(avg(salary)) as "average salary" from hr.employees group by department_id order by department_id;


select round(avg(salary)) as "average salary" from hr.employees where department_id=80;
select employee_id,salary,round(avg(salary)) as "average salary" from hr.employees where department_id=80;--error

select employee_id,salary,round(avg(salary)) as "average salary" from hr.employees where department_id=80 group by department_id,
employee_id,salary;--logical error

--Advanced analytical functions
/*
analytic_function_name ( [ argument_list ] )
OVER (
[ PARTITION BY partition_expression_list ]
[ ORDER BY expression [{ ASC | DESC }] [, ...] ]
[ window_frame_clause ]
)
*/
select employee_id,salary,round(avg(salary) over()) as "avg salary" from hr.employees where department_id=80;
select employee_id,salary,department_id,round(avg(salary) over(partition by department_id)) as "avg salary"
from hr.employees ;

select product_id,transaction_id,round(avg(salary) over()) as "avg salary" from hr.employees where department_id=80;
select employee_id,salary,department_id,round(avg(salary) over(partition by department_id)) as "avg salary"
from hr.employees ;

/*Use SH database[Costs and products table]
Write a SQL statement that returns the difference between the product
cost in every transaction made on 'January 29, 2000' (time_id) and the
average cost of all the products in all the transactions
*/
select prod_id, time_id ,unit_cost,
round( avg(unit_cost) over() ) as "average cost",
unit_cost - round( avg(unit_cost) over() ) as "difference"
from sh.costs
where time_id='00-01-29';
/*
Write an SQL statement that returns the difference between the product
cost in every transaction made on 'January 29, 2000' (time_id) and the
average cost of all the transactions for the same product
*/
select prod_id, time_id ,unit_cost,
round( avg(unit_cost) over(partition by prod_id) ) as "average cost",
unit_cost - round(avg(unit_cost) over(partition by prod_id)) as "difference"
from sh.costs
where time_id='00-01-29';

--Window_frame_clause
--show the employee_id,salary and cummulative salary for department no 80

select employee_id,salary,sum(salary)
over(partition by department_id order by employee_id) as "cummulative salary"
from hr.employees where department_id=80;

select employee_id,salary,sum(salary)
over(partition by department_id order by employee_id rows between unbounded preceding and current row) as "cummulative salary"
from hr.employees where department_id=80;

select employee_id,salary,sum(salary)
over(partition by department_id order by employee_id rows between current row and unbounded following) as "cummulative salary"
from hr.employees where department_id=80;

select employee_id,salary,sum(salary)
over(partition by department_id order by employee_id rows between 1 preceding and 1 following) as "cummulative salary"
from hr.employees where department_id=80;

--rank()--> skips the value in case of tie
select employee_id,salary,rank() over( order by salary) as "Rank" from hr.employees;

--dense_rank()--> does not skip value in case of tie
select employee_id,salary,dense_rank() over( order by salary) as "dense_Rank" from hr.employees;

--row_number()--> unique value
select employee_id,salary,row_number() over( order by salary) as "Row_number" from hr.employees;

--compare
select employee_id,salary,rank() over( order by salary) as "Rank",
dense_rank() over( order by salary) as "dense_Rank",
row_number() over( order by salary) as "Row_number"
from hr.employees;