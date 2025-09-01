set serveroutput on
--1)
select ecnt(30) as "total employees" from dual;

--2)
accept p_did prompt 'Enter department id: '
declare
cnt number;
begin
cnt := ecnt(&p_did);
dbms_output.put_line('department id &p_did has total '||cnt||' employees');
end;