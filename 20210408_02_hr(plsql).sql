SELECT USER
FROM DUAL;
--==>> HR


SET SERVEROUTPUT ON;
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.


--�� %TYPE


-- 1. Ư�� ���̺� ���ԵǾ� �ִ� �÷��� �ڷ����� �����ϴ� ������Ÿ��

-- 2. ���� �� ����
-- ������ ���̺�.�÷���%TYPE [:= �ʱⰪ];
SELECT FIRST_NAME
FROM EMPLOYEES;

DESC EMPLOYEES;

-- ��ü�� �����ϴ� ���� �ƴ϶� ������Ÿ�Ը� �о���� ��!

--�� HR.EMPLOYEES ���̺��� Ư�� �����͸� ������ ����
DECLARE
    -- VNAME    VARCHAR(20);
    VNAME   EMPLOYEES.FIRST_NAME%TYPE;
BEGIN
    SELECT FIRST_NAME INTO VNAME
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID=103;
    
    DBMS_OUTPUT.PUT_LINE(VNAME);
END;
--==>> Alexander


--�� %ROWTYPE

-- 1. ���̺��� ���ڵ�� ���� ������ ����ü ������ ����(���� ���� �÷�)

-- 2. ���� �� ����
-- ������ ���̺��%ROWTYPE;
SELECT FIRST_NAME
FROM EMPLOYEES;

DESC EMPLOYEES;
--==>>
/*
�̸�             ��?       ����           
-------------- -------- ------------ 
EMPLOYEE_ID    NOT NULL NUMBER(6)    
FIRST_NAME              VARCHAR2(20) 
LAST_NAME      NOT NULL VARCHAR2(25) 
EMAIL          NOT NULL VARCHAR2(25) 
PHONE_NUMBER            VARCHAR2(20) 
HIRE_DATE      NOT NULL DATE         
JOB_ID         NOT NULL VARCHAR2(10) 
SALARY                  NUMBER(8,2)  
COMMISSION_PCT          NUMBER(2,2)  
MANAGER_ID              NUMBER(6)    
DEPARTMENT_ID           NUMBER(4) 
*/


--�� HR.EMPLOYEES ���̺��� ������ �������� ������ ����
DECLARE
    -- VNAME    VARCHAR(20);
    -- VPHONE   VARCHAR(20);
    -- VEMAIL   VARCHAR(25);
    
    -- VNAME EMPLOYEES.FIRST_NAME%TYPE;
    -- VPHONE EMPLOYEES.PHONE_NUMBER%TYPE;
    -- VEMAIL EMPLOYEES.EMAIL%TYPE;
    
    VEMP       EMPLOYEES%ROWTYPE;   -- VEMP ���̺� ���� EMPLOYEES �� ���� Ÿ���� �� �����ͼ�..

BEGIN

    SELECT FIRST_NAME, PHONE_NUMBER, EMAIL
            INTO VEMP.FIRST_NAME, VEMP.PHONE_NUMBER, VEMP.EMAIL
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID=103;
    
    DBMS_OUTPUT.PUT_LINE(VEMP.FIRST_NAME || ' - '
                        || VEMP.PHONE_NUMBER || ' - '
                        || VEMP.EMAIL);
END;
--==>> Alexander - 590.423.4567 - AHUNOLD



--�� HR.EMPLOYEES ���̺��� ������ �������� ������ ����
DECLARE
    VEMP    EMPLOYEES%ROWTYPE;
    
BEGIN
    SELECT FIRST_NAME, PHONE_NUMBER, EMAIL
        INTO VEMP.FIRST_NAME, VEMP.PHONE_NUMBER, VEMP.EMAIL
    FROM EMPLOYEES;
    
    DBMS_OUTPUT.PUT_LINE(VEMP.FIRST_NAME || '-'
                        || VEMP.PHONE_NUMBER || '-'
                        || VEMP.EMAIL);
                        
END;
--==>>
/*
���� ���� -
ORA-01422: exact fetch returns more than requested number of rows
ORA-06512: at line 5
01422. 00000 -  "exact fetch returns more than requested number of rows"
*Cause:    The number specified in exact fetch is less than the rows returned.
*Action:   Rewrite the query or change number of rows requested
*/

--> ���� ���� ��(ROWS) ������ ���ͼ� �������� �ϸ�
--  ������ �����ϴ� �� ��ü�� �Ұ����� ��Ȳ...

-- �Ұ�~!!!


