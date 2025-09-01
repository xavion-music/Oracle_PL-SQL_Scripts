create table student (
sid number(3) primary key,
sname varchar2(20) not null,
scity varchar2(20)
);
--transaction 1 starts here
insert into student values(1, 'A', 'Brampton');
insert into student values(2, 'B', 'Windsor');
insert into student values(3, 'C', 'Milton');
select * from student;

update student set scity='Oakville' where sid=2;
select * from student;
rollback; --undo everything as we do not have any commit yet

select * from student; --no data

insert into student values(1, 'A', 'Brampton');
insert into student values(2, 'B', 'Windsor');
insert into student values(3, 'C', 'Milton');
select * from student;
commit; -- transaction 1 ends here

--transaction 2 starts here
update student set scity='Oakville' where sid=2;
insert into student values(4,'D','Brampton');
insert into student values(5,'E','Windsor');
select *from student;
rollback;--undo line number 23,24,25
select *from student;
commit; --transaction 2 ends here

--transaction 3 starts here
update student set scity='Oakville' where sid=2;
insert into student values(6,'F','Toronto');
insert into student values(7,'G','London');
savepoint s1;
insert into student values(8,'FG','Toronto');
insert into student values(9,'GH','London');
select * from student;
rollback to s1; --undo line 36 37
select * from student;