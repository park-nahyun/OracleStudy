
SELECT USER
FROM DUAL;
--==>> HR


--���� ���� �ǽ� ���� ����--

-- HR ���� ��Ű�� ERD �� �̿��� ���̺� ����

-- ������... HR ��Ű���� �ִ� �⺻ ���̺�(7��)
-- CONTRIES / DEPARTMENTS / EMPLOYEES / JOBS / JOB_HISTORY
-- / LOCATIONS / REGIONS
-- �� �Ȱ��� ���� �����Ѵ�.


-- ��, �����ϴ� ���̺� �̸��� �����̺��+����ȣ��
-- COUNTRIES04 / DEPARTMENTS04 / EMPLOYEES04 / JOBS04 / JOB_HISTORY04
-- / LOCATIONS04 / REGIONS04
-- �� ���� �����Ѵ�.


-- 1. ���� ���̺��� ���� ����
-- 2. ���̺� ����(�÷� �̸�, �ڷ���, DEFAULT ǥ����, NOT NULL ��...)
--    �������� ����(PK, UK, FK, CK, ... NN)
-- 3. �ۼ� �� ������ �Է�(������ �Է� ������ ���ǹ� �� ��)
-- 4. ���� �׸�
--     - 20210406_03_hr_�����ǽ�����_4��.sql
--     - �ı�_4��.txt
-- 5. ���� ����
--    ���� ���� 17:40 ����


SELECT *
FROM COUNTRIES;
--==>>
/*
COUNTRY_ID   COUNTRY_NAME   REGION_ID
AR           Argentina       2
*/
SELECT*
FROM JOB_HISTORY;

SELECT *
FROM DEPARTMENTS;
--==>> 
/*
DEPARTMENT_ID   DEPARTMENT_NAME   MANAGER_ID   LOCATION_ID
10   Administration   200   1700
*/

SELECT *
FROM EMPLOYEES;
--==>>
/*
EMPLOYEE_ID   FIRST_NAME   LAST_NAME   EMAIL   PHONE_NUMBER   HIRE_DATE   JOB_ID   SALARY   COMMISSION_PCT   MANAGER_ID   DEPARTMENT_ID
100           Steven       King       SKING   515.123.4567   03/06/17   AD_PRES   24000                             90
*/