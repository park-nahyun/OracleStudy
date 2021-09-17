--�� ���� ����Ŭ ������ ������ �ڽ��� ���� ��ȸ
SELECT USER
FROM DUAL;
--==>> SYS

--1�� �ּ��� ó��

/*
������
(������)
�ּ���
ó��
*/

SHOW USER
--==>> USER��(��) "SYS"�Դϴ�.
-- SQLPLUS ������ �� ����ϴ� ��ɾ�

SELECT USER
FROM DUAL;
--==>> SYS

SELECT 1+2
FROM DUAL;
--==>> 3

select 1+2
from dual;
--==>> 3

SELECT 1 + 2
FROM DUAL;
--==>> 3

SELECT '�ֿ밭�ϱ�������F������'
FROM DUAL;
--==>> �ֿ밭�ϱ�������F������

SELECT '������ ������ ����Ŭ ����';
--==>>
/*
ORA-00923: FROM keyword not found where expected
00923. 00000 -  "FROM keyword not found where expected"
*Cause:    
*Action:
39��, 23������ ���� �߻�
*/

SELECT 3.14 + 1.36
FROM DUAL;
--==>> 4.5


SELECT 1.2345 + 2.3456
FROM DUAL;
--==>> 3.5801


SELECT 10 * 5
FROM DUAL;
--==>> 50


SELECT 1000 / 23
FROM DUAL;
--==>> 43.4782608695652173913043478260869565217

SELECT 100 - 23
FROM DUAL;
--==>> 77

SELECT '�ڳ���' + '���ؼ�'
FROM DUAL;
--==>> ���� �߻�
/*
ORA-01722: invalid number
01722. 00000 -  "invalid number"
*Cause:    The specified number was invalid.
*Action:   Specify a valid number.
*/


--�� ����Ŭ ������ �����Ѥ� ����� ���� ���� ���� ��ȸ
SELECT USERNAME, ACCOUNT_STATUS
FROM DBA_USERS;
--==>>
/*
SYS	                OPEN
SYSTEM	            OPEN
ANONYMOUS          	OPEN
HR	                OPEN
APEX_PUBLIC_USER	    LOCKED
FLOWS_FILES	        LOCKED
APEX_040000	        LOCKED
OUTLN	            EXPIRED & LOCKED
DIP	                EXPIRED & LOCKED
ORACLE_OCM	        EXPIRED & LOCKED
XS$NULL	            EXPIRED & LOCKED
MDSYS	            EXPIRED & LOCKED
CTXSYS	            EXPIRED & LOCKED
DBSNMP	            EXPIRED & LOCKED
XDB	                EXPIRED & LOCKED
APPQOSSYS	        EXPIRED & LOCKED
*/


SELECT USERNAME, USER_ID, ACCOUNT_STATUS, PASSWORD, LOCK_DATE
FROM DBA_USERS;


SELECT *
FROM DBA_USERS;

-- ���̺��� ���� '�÷�' �̶�� �Ѵ�.


SELECT USERNAME, USER_ID
FROM DBA_USERS;

--> ��DBA_���� �����ϴ� Oracle Data Dictionary View ��
--   ������ ������ �������� �������� ��쿡�� ��ȸ�� �����ϴ�.
--   ������ ������ ��ųʸ� ������ ���� ���ص� �������.


--�� ��hr�� ����� ������ ��� ���·� ����
ALTER USER HR ACCOUNT LOCK;
--==>> User HR��(��) ����Ǿ����ϴ�.

--�� �ٽ� ����� ���� ���� ��ȸ
SELECT USERNAME, ACCOUNT_STATUS
FROM DBA_USERS;
--==>>
/*
        :
    HR	LOCKED
        :
*/


--�� ��hr�� ����� ������ ��� ���� ���·� ����
ALTER USER HR ACCOUNT UNLOCK;
--==>> User HR��(��) ����Ǿ����ϴ�.


--�� �ٽ� ����� ���� ���� ��ȸ
SELECT USERNAME, ACCOUNT_STATUS
FROM DBA_USERS;
--==>>
/*
        :
    HR	OPEN
        :
*/


---------------------------------------------------------

--�� TABLESPACE ����

-- �� TABLESPACE ��?
--    ���׸�Ʈ(���̺�, �ε���, ....)�� ��Ƶδ�(�����صδ�)
--    ����Ŭ�� ������ ���� ������ �ǹ��Ѵ�.


CREATE TABLESPACE TBS_EDUA                   -- CREATE ���� ��ü��      �� ����
DATAFILE 'C:\TESTORADATA\TBS_EDUA01.DEF'     -- ���������� ����Ǵ� ������ ����
SIZE 4M                                      -- ������ ������ ������ �뷮
EXTENT MANAGEMENT LOCAL                      -- ����Ŭ ������ ���׸�Ʈ�� �˾Ƽ� ����
SEGMENT SPACE MANAGEMENT AUTO;                -- ���׸�Ʈ ���� ������ �ڵ����� ����Ŭ ������...
--==>> TABLESPACE TBS_EDUA��(��) �����Ǿ����ϴ�.

--�� ���̺����̽� ���� ������ �����ϱ� ����
--   �������� ��ο� ���͸�(C:\TESTORADATA\����)



--�� ������ ���̺����̽�(TBS_EDUA) ��ȸ
SELECT *
FROM DBA_TABLESPACES;
--==>>
/*
SYSTEM	8192	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING	NO	LOCAL	SYSTEM	NO	MANUAL	DISABLED	NOT APPLY	NO	HOST	NO	
SYSAUX	8192	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING	NO	LOCAL	SYSTEM	NO	AUTO	DISABLED	NOT APPLY	NO	HOST	NO	
UNDOTBS1	8192	65536		1	2147483645	2147483645		65536	ONLINE	UNDO	LOGGING	NO	LOCAL	SYSTEM	NO	MANUAL	DISABLED	NOGUARANTEE	NO	HOST	NO	
TEMP	8192	1048576	1048576	1		2147483645	0	1048576	ONLINE	TEMPORARY	NOLOGGING	NO	LOCAL	UNIFORM	NO	MANUAL	DISABLED	NOT APPLY	NO	HOST	NO	
USERS	8192	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING	NO	LOCAL	SYSTEM	NO	AUTO	DISABLED	NOT APPLY	NO	HOST	NO	
TBS_EDUA	8192	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING	NO	LOCAL	SYSTEM	NO	AUTO	DISABLED	NOT APPLY	NO	HOST	NO	
*/



--�� �������� ���� �̸� ��ȸ
SELECT *
FROM DBA_DATA_FILES;
--==>>
/*
                                    :
C:\TESTORADATA\TBS_EDUA01.DEF	5	TBS_EDUA	4194304	512	AVAILABLE	5	NO	0	0	0
*/


--�� ����Ŭ ����� ���� ����
CREATE USER pnh IDENTIFIED BY java006$
DEFAULT TABLESPACE TBS_EDUA;
--> khj ��� ����ڸ� ����ڴ�. (�����ϰڴ�.)
--  �н������ java006$ �� �ϰڴ�.
--  �� ������ ���� �����ϴ� ����Ŭ ��ü��(���׸�Ʈ����)
--  �⺻������(default) TBS_EDUA ��� ���̺����̽��� ������ �� �ֵ��� �����ϰڴ�.
--==>> User PNH��(��) �����Ǿ����ϴ�.



--�� ������ ����Ŭ ����� ����(pnh)�� ����
--   ������ �õ��� �������� ���� �Ұ�.
--   �� ��CREATE SESSION�������� ���� ������...


--�� ������ ����Ŭ ����� ����(pnh)��
--   ���� ������ ������ �� �ֵ��� CREATE SESSION ���� �ο� �� SYS ��...
GRANT CREATE SESSION TO PNH;
--==>> Grant��(��) �����߽��ϴ�.


--�� ������ ����Ŭ ����� ����(pnh)��
--   DEFAULT TABLESPACE ��ȸ


SELECT USERNAME, DEFAULT_TABLESPACE
FROM DBA_USERS;
--==>>
/*
SYS	                SYSTEM
SYSTEM	            SYSTEM
ANONYMOUS	        SYSAUX
HR	                USERS
PNH	                TBS_EDUA
APEX_PUBLIC_USER	    SYSTEM
FLOWS_FILES      	SYSAUX
APEX_040000	        SYSAUX
OUTLN	            SYSTEM
DIP             	SYSTEM
ORACLE_OCM          	SYSTEM
XS$NULL	            SYSTEM
MDSYS	            SYSAUX
CTXSYS	            SYSAUX
DBSNMP	            SYSAUX
XDB                 	SYSAUX
APPQOSSYS	        SYSAUX
*/

--�� ������ ����Ŭ ����� ����(PNH)�� 
--   �ý��� ���� ���� ��ȸ

SELECT *
FROM DBA_SYS_PRIVS;
--==>>
/*
        :
    PNH	CREATE SESSION	NO
        :
*/


--�� ������ ����Ŭ ����� ����(PNH)��
--   ���̺� ������ ������ �� �ֵ��� CREATE TABLE ���� �ο�

GRANT CREATE TABLE TO PNH;
--==>> Grant��(��) �����߽��ϴ�.


--�� ������ ����Ŭ ����� ����(PNH)��
--   ���̺����̽�(TBS_EDUA)���� ����� �� �ִ� ����(�Ҵ緮)
-    �� ũ�⸦ ���������� ����.
ALTER USER PNH
QUOTA UNLIMITED ON TBS_EDUA;
--==>> User PNH��(��) ����Ǿ����ϴ�.

