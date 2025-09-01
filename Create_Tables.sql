-- File Name: Create_Tables.sql
-- Name: Palak Yogesh Chaudhary
-- Student Id: 991708879
-- Oracle Username: S1_CHAUPALA
-- Group: 4

/* -- Dropping old tables in case they already exist.
DROP TABLE dvd_rental CASCADE CONSTRAINTS PURGE;
DROP TABLE dvds CASCADE CONSTRAINTS PURGE;
DROP TABLE customer CASCADE CONSTRAINTS PURGE;
DROP TABLE movie_category CASCADE CONSTRAINTS PURGE;*/

-- Creating new tables

CREATE TABLE movie_category (
    categoryid NUMBER PRIMARY KEY,
    categoryname VARCHAR2(40)
);

CREATE TABLE customer (
    customerid VARCHAR2(4) PRIMARY KEY,
    firstname VARCHAR2(30),
    lastname VARCHAR2(30),
    phonenumber VARCHAR2(20),
    birthdate DATE,
    driverlicensenumber VARCHAR2(20),
    status VARCHAR2(20)
);

CREATE TABLE dvds (
    tapeid NUMBER PRIMARY KEY,
    title VARCHAR2(100),
    year NUMBER(4),
    cost NUMBER(5,2),
    categoryid NUMBER,
    rentedout VARCHAR2(5),
    rating VARCHAR2(10),
    actiononreturn VARCHAR2(30),
    CONSTRAINT fk_dvds_category FOREIGN KEY (categoryid) REFERENCES movie_category(categoryid)
);

CREATE TABLE dvd_rental (
    rentalid NUMBER PRIMARY KEY,
    rentaldate DATE,
    customerid VARCHAR2(4),
    tapeid NUMBER,
    CONSTRAINT fk_rental_customer FOREIGN KEY (customerid) REFERENCES customer(customerid),
    CONSTRAINT fk_rental_tape FOREIGN KEY (tapeid) REFERENCES dvds(tapeid)
);

-- View all records in each table
SELECT * FROM MOVIE_CATEGORY;

SELECT * FROM CUSTOMER;

SELECT * FROM DVDS;

SELECT * FROM DVD_RENTAL;



