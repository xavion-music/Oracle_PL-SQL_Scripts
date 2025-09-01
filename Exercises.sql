SET SERVEROUTPUT ON

-- Exercise 5.1: Find greatest of two numbers (anonymous block due to privilege issue)
-- compares two numbers and prints the bigger one
BEGIN
    DECLARE
        num1 NUMBER := 15;
        num2 NUMBER := 10;
    BEGIN
        -- check which is bigger
        IF num1 > num2 THEN
            DBMS_OUTPUT.PUT_LINE('Bigger number is: ' || num1);
        ELSIF num2 > num1 THEN
            DBMS_OUTPUT.PUT_LINE('Bigger number is: ' || num2);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Numbers are the same: ' || num1);
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;

    -- more test cases
    DECLARE
        num1 NUMBER := 3.5;
        num2 NUMBER := 7.8;
    BEGIN
        IF num1 > num2 THEN
            DBMS_OUTPUT.PUT_LINE('Bigger number is: ' || num1);
        ELSIF num2 > num1 THEN
            DBMS_OUTPUT.PUT_LINE('Bigger number is: ' || num2);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Numbers are the same: ' || num1);
        END IF;
    END;

    DECLARE
        num1 NUMBER := 5;
        num2 NUMBER := 5;
    BEGIN
        IF num1 > num2 THEN
            DBMS_OUTPUT.PUT_LINE('Bigger number is: ' || num1);
        ELSIF num2 > num1 THEN
            DBMS_OUTPUT.PUT_LINE('Bigger number is: ' || num2);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Numbers are the same: ' || num1);
        END IF;
    END;
END;
/

-- Exercise 5.2: Update customer business phone (anonymous block due to privilege issue)
-- updates custbphone for a customer
BEGIN
    DECLARE
        c_name VARCHAR2(20) := 'TestCust' || TO_CHAR(SYSDATE, 'MMDDHH24MI');
        new_phone CHAR(13) := '(416)555-1234';
        cust_count NUMBER;
    BEGIN
        -- check phone length
        IF LENGTH(new_phone) != 13 THEN
            DBMS_OUTPUT.PUT_LINE('Phone must be 13 chars like (123)456-7890');
        ELSE
            -- check if customer exists
            SELECT COUNT(*) INTO cust_count
            FROM si.customer
            WHERE custname = c_name;

            IF cust_count = 0 THEN
                DBMS_OUTPUT.PUT_LINE('Customer ' || c_name || ' not found');
            ELSE
                -- update phone
                UPDATE si.customer
                SET custbphone = new_phone
                WHERE custname = c_name;
                DBMS_OUTPUT.PUT_LINE('Phone updated for ' || c_name);
                COMMIT;
            END IF;
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;

    -- test invalid phone
    DECLARE
        c_name VARCHAR2(20) := 'TestCust' || TO_CHAR(SYSDATE, 'MMDDHH24MI');
        new_phone CHAR(13) := '123456';
    BEGIN
        IF LENGTH(new_phone) != 13 THEN
            DBMS_OUTPUT.PUT_LINE('Phone must be 13 chars like (123)456-7890');
        ELSE
            DBMS_OUTPUT.PUT_LINE('This won''t run');
        END IF;
    END;

    -- test non-existent customer
    DECLARE
        c_name VARCHAR2(20) := 'FakeCust';
        new_phone CHAR(13) := '(416)555-5678';
        cust_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO cust_count
        FROM si.customer
        WHERE custname = c_name;

        IF cust_count = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Customer ' || c_name || ' not found');
        END IF;
    END;
END;
/

-- Exercise 5.3: Find customer info with IN and OUT parameters
-- gets customer details by name
ACCEPT cust_name CHAR PROMPT 'Enter customer name for 5.3: '

BEGIN
    DECLARE
        v_customer si.customer%ROWTYPE;
    BEGIN
        SELECT * INTO v_customer
        FROM si.customer
        WHERE custname = '&cust_name';

        DBMS_OUTPUT.PUT_LINE('Customer: ' || v_customer.custname);
        DBMS_OUTPUT.PUT_LINE('Street: ' || v_customer.custstreet);
        DBMS_OUTPUT.PUT_LINE('City: ' || v_customer.custcity);
        DBMS_OUTPUT.PUT_LINE('Province: ' || v_customer.custprovince);
        DBMS_OUTPUT.PUT_LINE('Postal: ' || NVL(v_customer.custpostal, 'N/A'));
        DBMS_OUTPUT.PUT_LINE('Home Phone: ' || NVL(v_customer.custhphone, 'N/A'));
        DBMS_OUTPUT.PUT_LINE('Business Phone: ' || NVL(v_customer.custbphone, 'N/A'));
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('No customer named ' || '&cust_name');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;
END;
/

-- Exercise 5.4: Calculate total discounts after a date (anonymous block due to privilege issue)
-- sums discounts from saleinv
BEGIN
    DECLARE
        v_total NUMBER;
        v_date DATE := TO_DATE('01-JAN-2020', 'DD-MON-YYYY');
    BEGIN
        -- sum discounts after date
        SELECT NVL(SUM(discount), 0) INTO v_total
        FROM si.saleinv
        WHERE saledate > v_date;

        DBMS_OUTPUT.PUT_LINE('Total discounts after Jan 1, 2020: ' || v_total);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;
END;
/

-- Exercise 5.5: Display car owner by serial number
-- checks car owner
ACCEPT car_serial CHAR PROMPT 'Enter car serial number for 5.5: '

BEGIN
    DECLARE
        v_custname si.customer.custname%TYPE;
    BEGIN
        SELECT custname INTO v_custname
        FROM si.car
        WHERE carserial = '&car_serial';

        IF v_custname IS NULL THEN
            DBMS_OUTPUT.PUT_LINE('Car has no owner');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Owner: ' || v_custname);
        END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('There is no such car');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;
END;
/

-- Exercise 5.6: Count employees by salary
-- counts employees with given salary
ACCEPT salary_input CHAR PROMPT 'Enter salary for 5.6: '

DECLARE
    v_salary NUMBER;
    v_count NUMBER;
    negative_salary EXCEPTION;
BEGIN
    -- try to convert input to number
    v_salary := TO_NUMBER('&salary_input');

    -- check for negative
    IF v_salary < 0 THEN
        RAISE negative_salary;
    END IF;

    -- count employees
    SELECT COUNT(*) INTO v_count
    FROM hr.employees
    WHERE salary = v_salary;

    DBMS_OUTPUT.PUT_LINE('Employees with salary ' || v_salary || ': ' || v_count);
EXCEPTION
    WHEN negative_salary THEN
        DBMS_OUTPUT.PUT_LINE('Enter positive number for salary');
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('The salary must be a number');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

-- Exercise 5.7: Insert customer to test trigger
-- adds customer and checks case
ACCEPT cust_name CHAR PROMPT 'Enter customer name for 5.7: '
ACCEPT cust_street CHAR PROMPT 'Enter street: '
ACCEPT cust_city CHAR PROMPT 'Enter city: '
ACCEPT cust_prov CHAR PROMPT 'Enter province: '
ACCEPT cust_postal CHAR PROMPT 'Enter postal code: '
ACCEPT cust_hphone CHAR PROMPT 'Enter home phone: '
ACCEPT cust_bphone CHAR PROMPT 'Enter business phone: '

BEGIN
    -- insert customer with mixed case name
    INSERT INTO si.customer (custname, custstreet, custcity, custprovince, custpostal, custhphone, custbphone)
    VALUES ('&cust_name', '&cust_street', '&cust_city', '&cust_prov', '&cust_postal', '&cust_hphone', '&cust_bphone');

    DBMS_OUTPUT.PUT_LINE('Customer added');
    COMMIT;

    -- show the customer
    FOR rec IN (SELECT * FROM si.customer WHERE custname = UPPER('&cust_name')) LOOP
        DBMS_OUTPUT.PUT_LINE('Name: ' || rec.custname || ', Street: ' || rec.custstreet || 
                             ', City: ' || rec.custcity || ', Province: ' || rec.custprovince);
    END LOOP;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Error: Customer name already exists');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/