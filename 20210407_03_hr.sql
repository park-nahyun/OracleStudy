SELECT USER
FROM DUAL;
--==>> HR


--�� EMPLOYEES ���̺��� ������ SALARY �� 10% �λ��Ѵ�.
--   ��, �μ����� 'IT' �� ���� �����Ѵ�.
--  (����� ����� Ȯ�� �� ROLLBACK)


SELECT *
FROM DEPARTMENTS;
--==>>
/*
10	Administration	200	1700
20	Marketing	201	1800
30	Purchasing	114	1700
40	Human Resources	203	2400
50	Shipping	121	1500
60	IT	103	1400                               ------- CHEKCK~!!
70	Public Relations	204	2700
80	Sales	145	2500
90	Executive	100	1700
100	Finance	108	1700
110	Accounting	205	1700
120	Treasury		1700
130	Corporate Tax		1700
140	Control And Credit		1700
150	Shareholder Services		1700
160	Benefits		1700
170	Manufacturing		1700
180	Construction		1700
190	Contracting		1700
200	Operations		1700
210	IT Support		1700
220	NOC		1700
230	IT Helpdesk		1700
240	Government Sales		1700
250	Retail Sales		1700
260	Recruiting		1700
270	Payroll		1700
*/

SELECT *
FROM EMPLOYEES E JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE D.DEPARTMENT_NAME = 'IT';


UPDATE EMPLOYEES
SET SALARY = SALARY * 1.1
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME='IT');


--==>>
/*
103	Alexander	Hunold	AHUNOLD	590.423.4567	06/01/03	IT_PROG	9900		102	60	60	IT	103	1400
104	Bruce	Ernst	BERNST	590.423.4568	07/05/21	IT_PROG	6600		103	60	60	IT	103	1400
105	David	Austin	DAUSTIN	590.423.4569	05/06/25	IT_PROG	5280		103	60	60	IT	103	1400
106	Valli	Pataballa	VPATABAL	590.423.4560	06/02/05	IT_PROG	5280		103	60	60	IT	103	1400
107	Diana	Lorentz	DLORENTZ	590.423.5567	07/02/07	IT_PROG	4620		103	60	60	IT	103	1400
*/


ROLLBACK;
-- �ѹ� �Ϸ�


--�� EMPLOYEE ���̺��� JOB_TITLE �� ��Sales Maneger���� �������
--   SALARY �� �ش� ����(����)�� �ְ� �޿�(MAX_SALARY)�� �����Ѵ�.
--   ��, �Ի����� 2006�� ����(�ش� �⵵ ����) �Ի��ڿ� ���Ͽ�
--   ������ �� �ֵ��� ó���Ѵ�.
--   (������ �ۼ��Ͽ� ��� Ȯ�� �� ROLLBACK)




SELECT *
FROM JOBS;



UPDATE EMPLOYEES
SET SALARY = (SELECT MAX_SALARY
                FROM JOBS
                WHERE JOB_TITLE = 'Sales Manager')
WHERE JOB_ID = (SELECT JOB_ID 
                FROM JOBS
                WHERE JOB_TITLE = 'Sales Manager')
  AND HIRE_DATE  < TO_DATE('2006/01/01', 'YY/MM/DD') ;
  
  
/*

UPDATE EMPLOYEES
SET SALARY = (SELECT MAX_SALARY
                FROM JOBS
                WHERE JOB_TITLE = 'Sales Manager')
WHERE JOB_ID = (SELECT JOB_ID 
                FROM JOBS
                WHERE JOB_TITLE = 'Sales Manager')
  AND TO_NUMBER(TO_CHAR(HIRE_DATE('YYYY')) <= 2005 ;
*/

-- Ȯ�ο�
SELECT FIRST_NAME, HIRE_DATE, JOB_ID, SALARY
FROM EMPLOYEES
WHERE HIRE_DATE  < TO_DATE('06/01/01', 'YY/MM/DD')
 AND JOB_ID = 'SA_MAN';
--==>>
/*
John	04/10/01	SA_MAN	20080
Karen	05/01/05	SA_MAN	20080
Alberto	05/03/10	SA_MAN	20080
*/
 
ROLLBACK;



--�� EMPLOYEES ���̺��� SALARY ��
--   �� �μ��� �̸����� �ٸ� �λ���� �����Ͽ� ������ �� �ֵ��� �Ѵ�.
--   Finance �� 10%
--   Executive �� 15%
--   Accoungting �� 20%
--   ������ �� 0%
--   (������ �ۼ��Ͽ� ��� Ȯ�� �� ROLLBACK)

SELECT *
FROM DEPARTMENTS;

SELECT *
FROM EMPLOYEES;

UPDATE EMPLOYEES
SET SALARY = CASE DEPARTMENT_ID WHEN ('Finance'�� �μ����̵�)
                                THEN SALARY * 1.1
                                WHEN ('Executive'�� �μ����̵�)
                                THEN SALARY * 1.15
                                WHEN ('Accounting'�� �μ����̵�)
                                THEN SALARY * 1.2
                                ELSE SALARY * 
            END;
-- WHERE�� �ᵵ �ǰ� �� �ᵵ �ȴ�.
-- SET���� ���ǿ� �´� �͸� �ٲٸ� �Ǵϱ�..
-- �ƴϸ� WHERE���� ���������� �ۿ÷��� �ٲٸ� ��..!


-- ('Finance'�� �μ����̵�)
SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'Finance';
--==>> 100

-- ('Executive'�� �μ����̵�)
SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'Executive';
--==>> 90        

-- ('Accounting'�� �μ����̵�)
SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'Accounting';
--==>> 110                        



UPDATE EMPLOYEES
SET SALARY = CASE DEPARTMENT_ID WHEN (SELECT DEPARTMENT_ID
                                        FROM DEPARTMENTS
                                        WHERE DEPARTMENT_NAME = 'Finance')
                                THEN SALARY * 1.1
                                WHEN (SELECT DEPARTMENT_ID
                                        FROM DEPARTMENTS
                                        WHERE DEPARTMENT_NAME = 'Executive')
                                THEN SALARY * 1.15
                                WHEN (SELECT DEPARTMENT_ID
                                        FROM DEPARTMENTS
                                        WHERE DEPARTMENT_NAME = 'Accounting')
                                THEN SALARY * 1.2
                                ELSE SALARY 
                                END
--==>> 107�� �� ��(��) ������Ʈ�Ǿ����ϴ�.

-- WHERE �� ���� �ۿ÷������� ���� ������ WHERE �� �ִ� ���� ����.


WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME IN ('Finance', 'Executive', 'Accounting'));
--==>> 11�� �� ��(��) ������Ʈ �Ǿ����ϴ�.
ROLLBACK;



-- ���� DELETE ���� --

-- 1. ���̺��� ������ ��(���ڵ�)�� �����ϴ� �� ����ϴ� ����.

-- 2. ���� �� ����
-- DELETE [FROM] ���̺��
-- [WHERE ������];

SELECT *
FROM EMPLOYEES
WHERE EMPLOYEE_ID=198;


DELETE
FROM EMPLOYEES
WHERE EMPLOYEE_ID=198;


ROLLBACK;



--�� EMPLOYEES ���̺��� �������� ������ �����Ѵ�.
--   ��, �μ����� 'IT' �� ���� �����Ѵ�.

-- �� �����δ� EMPLOYEES ���̺��� �����Ͱ�(�����ϰ��� �ϴ� ���)
--    �ٸ� ���̺�(Ȥ�� �ڱ� �ڽ� ���̺�)�� ���� �������ϰ� �ִ� ���
--    �������� ���� �� �ִٴ� ����� �����ؾ� �ϸ�...
--    �׿� ���� ������ �˾ƾ� �Ѵ�. 


SELECT * 
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                         FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME = 'IT');

DELETE
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                         FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME = 'IT');

--==>> ���� �߻� 
/*
ORA-02292: integrity constraint (HR.DEPT_MGR_FK) violated - child record found
*/


-- ���� ��(VIEW) ���� --

-- 1. ��(VIEW)�� �̹� Ư���� �����ͺ��̽� ���� �����ϴ�
--    �ϳ� �̻��� ���̺��� ����ڰ� ��� ���ϴ� �����͵鸸��
--    ��Ȯ�ϰ� ���ϰ� �������� ���ؿ� ������ ���ϴ� �÷��鸸 ��Ƽ�
--    �������� ������ ���̺�� ���Ǽ� �� ���ȿ� ������ �ִ�.
--    (���̺� ������ �� �����ִ� �� �ƴϴϱ�.., ���� ������ �̸��� �������� ���� ���� ����..)

--    ������ ���̺��̶� �䰡 ������ �����ϴ� ���̺�(��ü)�� �ƴ϶�
--    �ϳ� �̻��� ���̺��� �Ļ��� �� �ٸ� ������ �� �� �ִ� ����̸�
--    �� ������ �����س��� SQL �����̶�� �� �� �ִ�.

-- 2. ���� �� ����
--    CREATE [OR REPLACE] VIEW ���̸�      -- ���̺�, ����ڴ� OR REPLACE ����
--    [(ALIAS[, ALIAS, ...])]
--    AS
--    ��������(SUBQUERY)
--    [WITH CHECK OPTION]                       
--    [WITH READ ONLY];                    -- �б� ����


--�� ��(VIEW) ����
CREATE OR REPLACE VIEW VIEW_EMPLOYEES
AS
SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY, C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
  AND D.LOCATION_ID = L.LOCATION_ID(+)
  AND L.COUNTRY_ID = C.COUNTRY_ID(+)
  AND C.REGION_ID = R.REGION_ID(+);
  
--�� ��(VIEW) ��ȸ
SELECT *
FROM VIEW_EMPLOYEES;

--�� ��(VIEW) ���� Ȯ��
DESC VIEW_EMPLOYEES;
--==>>
/*

�̸�              ��?       ����           
--------------- -------- ------------ 
FIRST_NAME               VARCHAR2(20) 
LAST_NAME       NOT NULL VARCHAR2(25) 
DEPARTMENT_NAME          VARCHAR2(30) 
CITY                     VARCHAR2(30) 
COUNTRY_NAME             VARCHAR2(40) 
REGION_NAME              VARCHAR2(25) 
*/


--�� ��(VIEW) �ҽ� Ȯ��       -- CHECK~!!!
SELECT VIEW_NAME, TEXT       -- TEXT
FROM USER_VIEWS              -- USER_VIEWS
WHERE VIEW_NAME = 'VIEW_EMPLOYEES';
--==>>
/*
VIEW_EMPLOYEES	"SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY, C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
  AND D.LOCATION_ID = L.LOCATION_ID(+)
  AND L.COUNTRY_ID = C.COUNTRY_ID(+)
  AND C.REGION_ID = R.REGION_ID(+)"
  
  -- ����� �����ϸ� �� ���� �ڵ尡 �״�� ���� �����
*/