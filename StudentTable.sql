DROP TABLE student;

CREATE TABLE student (
    sid VARCHAR2(20),
    SGPA NUMBER(2,1)
);

DESC student;

SELECT * FROM student;
SELECT * FROM hr.employees;

SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME
FROM hr.employees
WHERE EMPLOYEE_ID IN (101, 102, 103, 104);

