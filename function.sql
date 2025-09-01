--functions
/*
CREATE [OR REPLACE] FUNCTION function_name
[(
parameter_name_1 data_type
[, parameter_name_2 data_type]...
)]
RETURN data_type
{IS | AS}
pl_sql_block

*/
set serveroutput on
--ex1 create a function which counts total number of employees for a given department no. [HR schema]

create or replace function ecnt
( v_did IN hr.employees.department_id%type )
return number
as
totalcnt number;
begin
select count(*)
into totalcnt
from hr.employees e where e.department_id=v_did;

return totalcnt;
end;