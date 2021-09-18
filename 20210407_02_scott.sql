
SELECT USER
FROM DUAL;
--==>> SCOTT


--���� UPDATE ����--

-- 1. ���̺��� ���� �����͸� �����ϴ� ����.

-- 2. ���� �� ����
-- UPDATE ���̺��
-- SET �÷���=������ ��[, �÷���=������ ��, ....]
-- [WHERE ������]


SELECT *
FROM TBL_SAWON;


ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session��(��) ����Ǿ����ϴ�.


--�� TBL_SAWON ���̺��� �����ȣ 1003�� �����
--   �ֹι�ȣ�� ��8303082234567�� �� �����Ѵ�.


UPDATE TBL_SAWON
SET JUBUN='8303082234567'
WHERE SANO=1003;


-- ���� �� COMMIT �Ǵ� ROLLBACK �� �ݵ�� ���������� ����
COMMIT;
--==>> Ŀ�� ��


--�� TBL_SAWON ���̺��� 1005 ����� �Ի��ϰ� �޿���
--   ���� 2018-02-22, 2200 ���� �����Ѵ�.
UPDATE TBL_SAWON
SET HIREDATE= TO_DATE('2018-02-22', 'YYYY-MM-DD'), SAL=2200
WHERE SANO=1005;
--==>> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.



--Ȯ��
SELECT *
FROM TBL_SAWON;


-- ���� �� COMMIT �Ǵ� ROLLBACK �� �ݵ�� ���������� ����
COMMIT;
--==>> Ŀ�� ��


--�� TBL_INSA ���̺� ����(�����͸�)
CREATE TABLE TBL_INSABACKUP
AS
SELECT *
FROM TBL_INSA;
--==>> Table TBL_INSABACKUP��(��) �����Ǿ����ϴ�.

SELECT *
FROM TBL_INSA;


--�� TBL_INSABACKUP ���̺���
--   ������ ����� ���常 ���� 10% �λ�~!!!
UPDATE TBL_INSABACKUP
SET SUDANG=1.1*SUDANG
WHERE JIKWI IN ('����', '����');
--==>>15�� �� ��(��) ������Ʈ�Ǿ����ϴ�.


-- Ȯ��
SELECT *
FROM TBL_INSABACKUP;

COMMIT;
--==>> Ŀ�� ��.


--�� TBL_INSABACKUP ���̺��� ��ȭ��ȣ�� 016, 017, 018, 019 �� �����ϴ�
--   ��ȭ��ȣ�� ��� �̸� ��� 010 ���� �����Ѵ�.
UPDATE TBL_INSABACKUP
SET TEL= '010' || SUBSTR(TEL, 4)  
WHERE SUBSTR(TEL, 1, 3) IN ('016', '017', '018', '019');
--==>> 24�� �� ��(��) ������Ʈ�Ǿ����ϴ�.

-- Ȯ��
SELECT *
FROM TBL_INSABACKUP;

COMMIT;
--==>> Ŀ�� ��.



--�� TBL_SAWON ���̺� ���
CREATE TABLE TBL_SAWONBACKUP
AS
SELECT *
FROM TBL_SAWON;
--==>> Table TBL_SAWONBACKUP��(��) �����Ǿ����ϴ�.
--> TBL_SAWON ���̺��� �����͵鸸 ����� ����
-- ��, �ٸ� �̸��� ���̺� ���·� ������ �� ��Ȳ

--�� Ȯ��
SELECT *
FROM TBL_SAWONBACKUP;
SELECT *
FROM TBL_SAWON;


--�� ������ ����
UPDATE TBL_SAWON
SET SANAME = '�̹���';

SELECT *
FROM TBL_SAWON;

COMMIT;

--���� ���� UPDATE ó�� ���Ŀ� COMMIT�� �����Ͽ��� ������
--ROLLBACK�� �Ұ����� ��Ȳ�̴�.
--������, TBL_SAWONBACKUP ���̺� �����͸� ����صξ���.
--SANAME �÷��� ���븸 �����Ͽ� '�̹���' ��� �־��� �� �ִٴ� ���̴�.

UPDATE TBL_SAWON
SET SANAME = (SELECT SANAME
              FROM TBL_SAWONBACKUP
              WHERE SANO = TBL_SAWON.SANO);
              
SELECT *
FROM TBL_SAWON;

COMMIT;

UPDATE TBL_SAWON
SET SANAME='�谡��'
WHERE SANO=1001;

UPDATE TBL_SAWON
SET SANAME='�輭��'
WHERE SANO=1002;
        :
        :
        

UPDATE TBL_SAWON
SET SANAME= TBL_SAWONBACKUP ���̺��� 1004�� ����� �����;


UPDATE TBL_SAWON
SET SANAME=( SELECT SANAME
             FROM TBL_SAWONBACKUP
             WHERE SANO = TBL_SAWON.SANO);
             -- SANO�� �ϳ��� ������ ������Ʈ
             
    

        