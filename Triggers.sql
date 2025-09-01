--Triggers
/*
CREATE [OR REPLACE] TRIGGER trigger_name
{BEFORE|AFTER}
{DELETE|INSERT|UPDATE
[OF col_name1 [, col_name2]...]}
[OR {DELETE|INSERT|UPDATE
[OF col_name1 [, col_name2]...]}]...
ON table_name
[FOR EACH ROW
[WHEN (trigger_condition)]]
pl_sql_block

*/

alter session set current_schema=s1;
set serveroutput on
create table tmpUser(id number,name varchar2(20));

insert into tmpUser values(10,'Megha');
insert into tmpUser values(20,'RYAN');
insert into tmpUser values(30,'abraHAM');

select *from tmpUser;

create or replace trigger format_uname
before insert on tmpUser
for each row
when(new.name != upper(new.name))
begin
:new.name := upper(:new.name);--convert entered name into uppercase and reassigned as new value
end;


insert into tmpUser values(10,'Megha');
insert into tmpUser values(20,'RYAN');
insert into tmpUser values(30,'abraHAM');

select *from tmpUser;

--ex2
--create a log table
create table customer as select *from si.customer;

create table lgtbl
(
operation varchar2(20),
username varchar2(10),
opdate date,
custname varchar2(20)
);

--create a trigger on customer table for insert,update or delete data and insert the value in log table accordingly

create or replace trigger ins_up_del_custdata
before insert or update or delete
on customer
for each row
begin
if INSERTING then
insert into lgtbl values('Insert',user,sysdate,:new.custname);
end if;

if updating then
insert into lgtbl values('Update',user,sysdate,:old.custname);
end if;

if deleting then
insert into lgtbl values('delete',user,sysdate,:old.custname);
end if;

end;

insert into customer values('philip','xyz','brampton','on','t6yu5r','123456789','987654321');
select *from lgtbl;

update customer set custname='Myra' where custname='philip';
select *from customer where custname='Myra';
select *from lgtbl;
delete from customer where custname='Myra';
select *from lgtbl;