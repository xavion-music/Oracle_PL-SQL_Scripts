-- Script File Name: Chaupala_DBAS32100_991708879_Assignment_3.sql
-- Your Name: Palak Yogesh Chaudhary
-- Oracle User Name: s1_chaupala
-- Question/Problem: Managing users and permissions on a database system.

-- Step 1: Create a database authenticated user named user1 with the following settings:
-- Password: changethis
-- Default tablespace: users
-- Temporary tablespace: temp
-- Quota unlimited
connect as sysdba;
CREATE USER user1 IDENTIFIED BY palak DEFAULT TABLESPACE users TEMPORARY TABLESPACE temp QUOTA UNLIMITED ON users;

-- Step 3, Task 1: Grant CREATE SESSION, CREATE USER and CREATE TABLE with admin option to user1
GRANT CREATE SESSION, CREATE USER, CREATE TABLE TO user1 WITH ADMIN OPTION;

-- Step 2: Change user1 settings:
-- Change the quota to 250M
-- Change the password to secret
ALTER USER user1 QUOTA 250M ON users;
ALTER USER user1 IDENTIFIED BY secret;

-- Step 3, Task 2: Connect as user1 and create a table
CONNECT user1/secret;
CREATE TABLE u1_t(x NUMBER);
INSERT INTO u1_t VALUES (1);
COMMIT;

-- Step 3, Task 3: While connected as user1, create a user named user2 and grant CREATE SESSION and CREATE TABLE to user2
CREATE USER user2 IDENTIFIED BY p2;
GRANT CREATE SESSION, CREATE TABLE TO user2;

-- Step 3, Task 4: Connect as SYSTEM and revoke CREATE TABLE and CREATE USER from user1
connect as sysdba;
REVOKE CREATE TABLE, CREATE USER FROM user1;

-- Step 3, Task 5: Connect as user2 and create a table
CONNECT user2/p2;
CREATE TABLE u2_t(y NUMBER);
INSERT INTO u2_t VALUES (2);
COMMIT;

-- Additional connection as user1 (not explicitly required by document but present in original code)
CONNECT user1/secret;

-- Step 4: Connect as system and create the following table:
-- CREATE TABLE emp(ename VARCHAR2(15), sal NUMBER(6,2));
-- INSERT INTO emp VALUES('bob', 4598.57);
CONNECT admin/admin AS SYSDBA;
CREATE TABLE emp( ename VARCHAR2(15), sal NUMBER(6,2));
INSERT INTO emp VALUES ('palak', 8999.99); -- I used my information I hope it's fine
COMMIT;

-- Step 4: Grant select and update on emp to user1 with grant option
GRANT SELECT, UPDATE ON emp TO user1 WITH GRANT OPTION;

-- Step 4: Connect as user1 and grant select on system.emp and update to user2
CONNECT user1/secret;
GRANT SELECT, UPDATE ON sys.emp TO user2;

-- Step 4: Connect as user2 and write a select statement on system.emp
CONNECT user2/p2;
SELECT * FROM sys.emp;

-- Step 4: Connect as system and revoke select and update from user1
CONNECT admin/admin AS SYSDBA;
REVOKE SELECT, UPDATE ON emp FROM user1;

-- Step 4: Connect as user2 and try to run a select statement on system.emp
CONNECT user2/p2;
SELECT * FROM sys.emp;