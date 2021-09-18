
SELECT USER
FROM DUAL;
--==>> SCOTT

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session��(��) ����Ǿ����ϴ�.


SELECT *
FROM TBL_�԰�;
--==>>
/*
1	H001	2021-04-09	20	400
2	H002	2021-04-09	30	500
3	H003	2021-04-09	40	600
4	H004	2021-04-09	50	700
5	H005	2021-04-09	60	800
6	H006	2021-04-09	70	900
7	H007	2021-04-09	80	1000
8	C001	2021-04-09	30	800
9	C002	2021-04-09	40	900
10	C003	2021-04-09	50	1000
11	C004	2021-04-09	60	1100
12	C005	2021-04-09	70	1200
13	C006	2021-04-09	80	1300
14	C007	2021-04-09	90	1400
15	E001	2021-04-09	80	990
16	E002	2021-04-09	70	880
17	E003	2021-04-09	60	770
18	E004	2021-04-09	50	660
19	E005	2021-04-09	40	550
20	E006	2021-04-09	30	440
21	E007	2021-04-09	20	330
*/
SELECT *
FROM TBL_���;
--==>>
/*
1	H001	2021-04-12	1	1100
2	H002	2021-04-12	2	1200
3	H003	2021-04-12	3	1300
4	H004	2021-04-12	4	1400
5	H005	2021-04-12	5	1500
6	H006	2021-04-12	6	1600
7	H007	2021-04-12	7	1700
8	C001	2021-04-12	1	1100
9	C002	2021-04-12	2	1200
10	C003	2021-04-12	3	1300
11	C004	2021-04-12	4	1400
12	C005	2021-04-12	5	1500
13	C006	2021-04-12	6	1600
14	C007	2021-04-12	7	1700
15	E001	2021-04-12	2	1900
16	E002	2021-04-12	3	1910
17	E003	2021-04-12	4	1920
18	E004	2021-04-12	5	1930
19	E005	2021-04-12	6	1940
20	E006	2021-04-12	7	1950
21	E007	2021-04-12	8	1960
*/
SELECT *
FROM TBL_��ǰ;
--==>>
/*
H001	Ȩ����	1500	19
H002	�����	1200	28
H003	�ڰ�ġ	1000	37
H004	���ڱ�	 900	46
H005	������	1100	55
H006	����Ĩ	2000	64
H007	������	1700	73
C001	������	2000	29
C002	��극	1800	38
C003	���̽�	1700	47
C004	���͸�	1900	56
C005	���̺�	1700	65
C006	���Ͻ�	1200	74
C007	������	1900	83
E001	������ 	 600	78
E002	������	 500	67
E003	�˵��	 300	56
E004	��Ʋ��	 600	45
E005	������	 800	34
E006	���׸�	 900	23
E007	��ī��	 900	12
*/

--�� ������ ���ν��� ���� �۵����� Ȯ��
-- �� ���ν��� ȣ��
-- �����19/���1���� Ȩ���� ����� ����
EXEC PRC_���_UPDATE(1,21);
--==>> ���� �߻� 
-- ORA-20002: ��� ����~~!!!

SELECT *
FROM TBL_�԰�;
SELECT *
FROM TBL_���;
SELECT *
FROM TBL_��ǰ;

EXEC PRC_���_UPDATE(1,20);
--==>>PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

SELECT *
FROM TBL_��ǰ;
--==>>
/*
H001	Ȩ����	1500	 0
H002	�����	1200	28
H003	�ڰ�ġ	1000	37
H004	���ڱ�	 900	46
H005	������	1100	55
H006	����Ĩ	2000	64
H007	������	1700	73
C001	������	2000	29
C002	��극	1800	38
C003	���̽�	1700	47
C004	���͸�	1900	56
C005	���̺�	1700	65
C006	���Ͻ�	1200	74
C007	������	1900	83
E001	������	 600	78
E002	������	 500	67
E003	�˵��	 300	56
E004	��Ʋ��	 600	45
E005	������	 800	34
E006	���׸�	 900	23
E007	��ī��	 900	12
*/


SELECT *
FROM TBL_���
--==>> 1	H001	2021-04-12	20	1100

ROLLBACK;

SELECT *
FROM TBL_�԰�;

SELECT *
FROM TBL_��ǰ;

EXEC PRC_�԰�_UPDATE(1,23);

EXEC PRC_�԰�_DELETE(1);

EXEC PRC_���_DELETE(1);



---------------------------------------------------------------------------------------

--�� Ʈ���� �ǽ� ���� ���̺� ����(TBL_TEST1)
CREATE TABLE TBL_TEST1
( ID    NUMBER
, NAME  VARCHAR2(30)
, TEL   VARCHAR2(60)
);
--==>> Table TBL_TEST1��(��) �����Ǿ����ϴ�.

--�� ������ ���̺� �������� �߰�
--   ID �÷��� PK �������� ����

ALTER TABLE TBL_TEST1
ADD CONSTRAINT TEST1_ID_PK PRIMARY KEY(ID);
--==>> Table TBL_TEST1��(��) ����Ǿ����ϴ�.


--�� Ʈ���� �ǽ� ���� ���̺� ����(TBL_EVENTLOG)
CREATE TABLE TBL_EVENTLOG
( MEMO VARCHAR2(200)
, INJA DATE DEFAULT SYSDATE
);
--==>> Table TBL_EVENTLOG��(��) �����Ǿ����ϴ�.

SELECT *
FROM TBL_TEST1;
--==>> ��ȸ ��� ����

SELECT *
FROM TBL_EVENTLOG;
--==>> ��ȸ ��� ����


--�� ��¥ ���� ���� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session��(��) ����Ǿ����ϴ�.



--�� TBL_TEST1 ���̺��� ������ ����
INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(1, '�谡��', '010-1111-1111');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(2, '�輭��', '010-2222-2222');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(3, '������', '010-3333-3333');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.


--�� TBL_TEST1 ���̺��� ������ ������Ʈ
UPDATE TBL_TEST1
SET NAME = '�質��'
WHERE ID = 1;
---==>> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

UPDATE TBL_TEST1
SET NAME = '��ٿ�'
WHERE ID = 1;
---==>> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

UPDATE TBL_TEST1
SET NAME = '�赿��'
WHERE ID = 2;
---==>> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.


--�� TBL_TEST1 ���̺��� ������ ����

DELETE
FROM TBL_TEST1
WHERE ID = 3;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

DELETE
FROM TBL_TEST1
WHERE ID = 2;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

DELETE
FROM TBL_TEST1
WHERE ID = 1;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.


--�� Ȯ��
SELECT *
FROM TBL_TEST1;


--�� TBL_EVENTLOG
SELECT *
FROM TBL_EVENTLOG;
--==>>
/*
INSERT �������� ����Ǿ����ϴ�.	2021-04-12 15:23:14
INSERT �������� ����Ǿ����ϴ�.	2021-04-12 15:23:14
INSERT �������� ����Ǿ����ϴ�.	2021-04-12 15:23:14
UPDATE �������� ����Ǿ����ϴ�.	2021-04-12 15:23:38
UPDATE �������� ����Ǿ����ϴ�.	2021-04-12 15:23:57
UPDATE �������� ����Ǿ����ϴ�.	2021-04-12 15:24:16
DELETE �������� ����Ǿ����ϴ�.	2021-04-12 15:25:17
DELETE �������� ����Ǿ����ϴ�.	2021-04-12 15:25:24
DELETE �������� ����Ǿ����ϴ�.	2021-04-12 15:25:38
*/


--�� ����Ŭ ������ �ð��� 16:03 �� ���·� �׽�Ʈ
INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(4, '�ڹ���', '010-4444-4444');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.


UPDATE TBL_TEST1
SET TEL = '010-4141-4141'
WHERE ID = 4;
--==>> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

DELETE
FROM TBL_TEST1
WHERE ID = 4;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.


COMMIT;

--�� ����Ŭ ������ �ð��� 19:07 �� ���·� �׽�Ʈ
INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(5, '������', '010-5555-5555');
--==>> ���� �߻�
/*
ORA-20005: �۾��� 08 ~ 18:00 ������ �����մϴ�.
*/


--�� BEFORE ROW TRIGGER �ǽ� ������ ���� ���̺� ����(TBL_TEST2) �� �θ� ���̺�
CREATE TABLE TBL_TEST2
( CODE NUMBER
, NAME VARCHAR2(40)
, CONSTRAINT TEST2_CODE_PK PRIMARY KEY(CODE)
);
--==>> Table TBL_TEST2��(��) �����Ǿ����ϴ�.

--�� BEFORE ROW TRIGGER �ǽ� ������ ���� ���̺� ����(TBL_TEST3) �� �ڽ����̺�
CREATE TABLE TBL_TEST3
( SID    NUMBER
, CODE   NUMBER
, SU     NUMBER
, CONSTRAINT TEST3_SID_PK PRIMARY KEY(SID)
, CONSTRAINT TEST3_CODE_FK FOREIGN KEY(CODE)
             REFERENCES TBL_TEST2(CODE)
);


--�� �θ� ���̺� ������ �Է�
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(1, '�����');
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(2, '��Ź��');
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(3, '������');

SELECT *
FROM TBL_TEST2;
--==>>
/*
1	�����
2	��Ź��
3	������
*/

COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� �ڽ� ���̺� ������ �Է�

INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(1, 1, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(2, 1, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(3, 1, 40);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(4, 2, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(5, 2, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(6, 2, 40);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(7, 1, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(8, 2, 20);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 8

SELECT *
FROM TBL_TEST3;
--==>>
/*
1	1	20
2	1	30
3	1	40
4	2	20
5	2	30
6	2	40
7	1	20
8	2	20
*/

COMMIT;
--==>> Ŀ�� �Ϸ�.


SELECT C.SID, P.CODE, P.NAME, C.SU
FROM TBL_TEST2 P JOIN TBL_TEST3 C
ON P.CODE = C.CODE;


DELETE
FROM TBL_TEST2
WHERE CODE=1;
--==>> �����߻�
/*
ORA-02292: integrity constraint (SCOTT.TEST3_CODE_FK) violated - child record found
*/


DELETE
FROM TBL_TEST2
WHERE CODE=3;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.



--�� Ʈ���� �ۼ� ���� �ٽ� �׽�Ʈ
DELETE
FROM TBL_TEST2
WHERE CODE=1;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

SELECT * 
FROM TBL_TEST2;

SELECT * 
FROM TBL_TEST3;

COMMIT;
--==>> Ŀ�� �Ϸ�;


--�� Ʈ���� �ǽ� ���� ���̺� ����
TRUNCATE TABLE TBL_�԰�;
--==>> Table TBL_�԰���(��) �߷Ƚ��ϴ�.

TRUNCATE TABLE TBL_���;
--==>> Table TBL_�����(��) �߷Ƚ��ϴ�.


UPDATE TBL_��ǰ
SET ������ = 0;
--==>> 21�� �� ��(��) ������Ʈ�Ǿ����ϴ�.

COMMIT;
--==>> Ŀ�� �Ϸ�


----------------20210412_02_SCOTT������ �׽�Ʈ ���-------------

--�� Ʈ���� ���� �� 
SELECT *
FROM TBL_�԰�;
--==>> ��ȸ ��� ����

SELECT *
FROM TBL_��ǰ;
--==>> H001	Ȩ����	1500	0


--�� �԰� ���̺� �԰� �̺�Ʈ �߻�

INSERT INTO TBL_�԰�(�԰��ȣ, ��ǰ�ڵ�, �԰�����, �԰����, �԰�ܰ�)
VALUES(1, 'H001', SYSDATE, 100, 1000);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

SELECT *
FROM TBL_�԰�;
--==>> 1	H001	21/04/13	100	1000

SELECT *
FROM TBL_��ǰ;
--==>> H001	Ȩ����	1500	100


--�� �԰� ���̺� �԰� ���� �߻�

UPDATE TBL_�԰�
SET �԰���� = 200
WHERE ��ǰ�ڵ� = 'H001';
--==>> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

SELECT *
FROM TBL_�԰�;
--==>> 1	H001	21/04/13	200	1000

SELECT *
FROM TBL_��ǰ;
--==>> H001	Ȩ����	1500	200



--�� �԰� ���̺� �԰� ���� ���� �߻�

DELETE
FROM TBL_�԰�
WHERE ��ǰ�ڵ� = 'H001';
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

SELECT *
FROM TBL_�԰�;
--==>> ��ȸ ��� ����

SELECT *
FROM TBL_��ǰ;
--==>> H001	Ȩ����	1500	0




--�� Ʈ���� ���� �� 

INSERT INTO TBL_�԰�(�԰��ȣ, ��ǰ�ڵ�, �԰�����, �԰����, �԰�ܰ�)
VALUES(1, 'H001', SYSDATE, 200, 1000);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

SELECT *
FROM TBL_���;
--==>> ��ȸ ��� ����

SELECT *
FROM TBL_��ǰ;
--==>> H001	Ȩ����	1500	200


--�� ��� ���̺� ��� �̺�Ʈ �߻�

INSERT INTO TBL_���(����ȣ, ��ǰ�ڵ�, �������, ������, ���ܰ�)
VALUES(1, 'H001', SYSDATE, 100, 1200);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

SELECT *
FROM TBL_���;
--==>> 1	H001	21/04/13	100	1200

SELECT *
FROM TBL_��ǰ;
--==>> H001	Ȩ����	1500	100


--�� ��� ���̺� ��� ���� �߻�

UPDATE TBL_���
SET ������ = 50
WHERE ��ǰ�ڵ� = 'H001';
--==>> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

SELECT *
FROM TBL_���;
--==>> 1	H001	21/04/13	50	1200
     
SELECT *
FROM TBL_��ǰ;
--==>> H001	Ȩ����	1500	150



--�� ��� ���̺� ��� ���� �߻�

DELETE
FROM TBL_���
WHERE ��ǰ�ڵ� = 'H001';
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

SELECT *
FROM TBL_���;
--==>> ��ȸ ��� ����
     
SELECT *
FROM TBL_��ǰ;
--==>> H001	Ȩ����	1500	200

