
SELECT USER
FROM DUAL;
--==>>

--���� UNION/UNION ALL ����--

--�� �ǽ� ���̺� ����(TBL_JUMUN)
CREATE TABLE TBL_JUMUN              -- �ֹ� ���̺� ����
( JUNO      NUMBER                  -- �ֹ� ��ȣ
, JECODE    VARCHAR2(30)            -- �ֹ��� ��ǰ �ڵ�
, JUSU      NUMBER                  -- �ֹ� ����
, JUDAY     DATE DEFAULT SYSDATE    -- �ֹ� ����
);

--==>> Table TBL_JUMUN��(��) �����Ǿ����ϴ�.

--> ���� �ֹ��� �߻����� ��� �ֹ� ���뿡 ���� �����Ͱ� �Էµ� �� �ִ� ���̺�

--�� ������ �Է� �� ���� �ֹ� �߻� / ����
INSERT INTO TBL_JUMUN VALUES
(1, '�˵�����Ĩ', 20, TO_DATE('2001-11-01 09:05:12', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN VALUES
(2, '��Ŭ', 10, TO_DATE('2001-11-01 09:23:37', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN VALUES
(3, '����Ĩ', 30, TO_DATE('2001-11-01 11:41:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN VALUES
(4, 'Ģ��', 12, TO_DATE('2001-11-02 10:22:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN VALUES
(5, 'Ȩ����', 50, TO_DATE('2001-11-03 15:50:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN VALUES
(6, '�ٳ���ű', 40, TO_DATE('2001-11-04 11:10:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN VALUES
(7, '��������', 10, TO_DATE('2001-11-10 10:10:10', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN VALUES
(8, '��īĨ', 40, TO_DATE('2001-11-14 09:41:14', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN VALUES
(9, '����Ĩ', 20, TO_DATE('2001-11-14 14:20:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN VALUES
(10, 'ĭ��', 20, TO_DATE('2001-11-20 14:17:00', 'YYYY-MM-DD HH24:MI:SS'));
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 10

--�� ��¥ ���� ���� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==> Session��(��) ����Ǿ����ϴ�.

SELECT *
FROM TBL_JUMUN;
--==>>
/*
1	�˵�����Ĩ	20	2001-11-01 09:05:12
2	��Ŭ	        10	2001-11-01 09:23:37
3	����Ĩ     	30	2001-11-01 11:41:00
4	Ģ��      	12	2001-11-02 10:22:00
5	Ȩ����     	50	2001-11-03 15:50:00
6	�ٳ���ű	    40	2001-11-04 11:10:00
7	��������    	10	2001-11-10 10:10:10
8	��īĨ	    40	2001-11-14 09:41:14
9	����Ĩ	    20	2001-11-14 14:20:00
10	ĭ��      	20	2001-11-20 14:17:00
*/

--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� ������ �߰� �Է� �� 2001����� ���۵� �ֹ��� ����(2021��)���� ��� �߻�~!!!
INSERT INTO TBL_JUMUN VALUES(938765, 'Ȩ����', 10, SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_JUMUN VALUES(938766, '����', 10, SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_JUMUN VALUES(938767, '��Ŭ', 10, SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_JUMUN VALUES(938768, 'Ȩ����', 50, SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_JUMUN VALUES(938769, '����Ĩ', 30, SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_JUMUN VALUES(938770, '����Ĩ', 20, SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_JUMUN VALUES(938771, '����Ĩ', 10, SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_JUMUN VALUES(938772, '��īĨ', 40, SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_JUMUN VALUES(938773, '��īĨ', 20, SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_JUMUN VALUES(938774, 'ĭ��', 20, SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_JUMUN VALUES(938775, 'ĭ��', 10, SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_JUMUN VALUES(938776, '�ٳ���ű', 10, SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.


--�� Ȯ��
SELECT *
FROM TBL_JUMUN;
--==>>
/*
1	    �˵�����Ĩ	20	2001-11-01 09:05:12
2	    ��Ŭ	        10	2001-11-01 09:23:37
3	    ����Ĩ	    30	2001-11-01 11:41:00
4	    Ģ��  	    12	2001-11-02 10:22:00
5	    Ȩ����	    50	2001-11-03 15:50:00
6	    �ٳ���ű	    40	2001-11-04 11:10:00
7	    ��������	    10	2001-11-10 10:10:10
8	    ��īĨ	    40	2001-11-14 09:41:14
9	    ����Ĩ	    20	2001-11-14 14:20:00
10	    ĭ��  	    20	2001-11-20 14:17:00
            
                    :
                    :
                    
938765	Ȩ����	    10	2021-04-01 14:23:49
938766	����  	    10	2021-04-01 14:24:42
938767	��Ŭ	        10	2021-04-01 14:25:02
938768	Ȩ����	    50	2021-04-01 14:25:36
938769	����Ĩ	    30	2021-04-01 14:26:34
938770	����Ĩ	    20	2021-04-01 14:26:37
938771	����Ĩ	    10	2021-04-01 14:27:13
938772	��īĨ	    40	2021-04-01 14:27:54
938773	��īĨ	    20	2021-04-01 14:28:15
938774	ĭ��  	    20	2021-04-01 14:29:05
938775	ĭ��	        10	2021-04-01 14:29:16
938776	�ٳ���ű	    10	2021-04-01 14:29:37
*/


--�� �����̰� 2001�⵵���� ���� ���θ� ���...
-- TBL_JUMUN ���̹��� �ʹ� ���ſ��� ��Ȳ
-- ���ø����̼ǰ��� �������� ���� �ֹ� ������ �ٸ� ���̺� ������ �� �ֵ���
-- ����� ���� ���� ��Ȳ
-- ������ ��� �����͸� ������� ����� �͵� �Ұ����� ��Ȳ
-- �� ���������... ������� ������ �ֹ� ������ ��
--    ���� �߻��� �ֹ� ������ �����ϰ� 
--    �������� �ٸ� ���̺�(TBL_JUMUNBACKUP)��
--    ������ �̰��� ������ ��ȹ

-- �̷� �� B��� �������ϴ� ���̺� ���� �����.. (���� ��� �۳����..)
-- �ֱ� �ͺ��� �ٽý����ϴ�..? ���̺� �����..??


--�� TBL_JUMUNBACKUP ���̺� ����
CREATE TABLE TBL_JUMUNBACKUP
AS
SELECT *
FROM TBL_JUMUN
WHERE JUDAY< TRUNC(SYSDATE, 'DD');
--  TO_CHAR(JUDAY, 'YYYY-MM-DD') != TO_CHAR(SYSDATE, 'YYYY-MM-DD')


SELECT *
FROM TBL_JUMUNBACKUP;
--==>>
/*
1	�˵�����Ĩ	20	2001-11-01 09:05:12
2	��Ŭ	        10	2001-11-01 09:23:37
3	����Ĩ	    30	2001-11-01 11:41:00
4	Ģ��  	    12	2001-11-02 10:22:00
5	Ȩ����	    50	2001-11-03 15:50:00
6	�ٳ���ű    	40	2001-11-04 11:10:00
7	��������    	10	2001-11-10 10:10:10
8	��īĨ     	40	2001-11-14 09:41:14
9	����Ĩ     	20	2001-11-14 14:20:00
10	ĭ��      	20	2001-11-20 14:17:00
*/
--> TBL_JUMUN ���̺��� �����͵� ��
-- ���� �ֹ����� �̿��� �����ʹ� ��� TBL_JUMUNBACKUP ���̺� ����� ��ģ ����.

--�� TBL_JUMUN ���̺��� �����͵� ��
--   ���� �ֹ����� �̿��� �����ʹ� ��� ����.

DELETE
FROM TBL_JUMUN
WHERE TO_CHAR(JUDAY, 'YYYY-MM-DD') != TO_CHAR(SYSDATE, 'YYYY-MM-DD');
--==>> 10�� �� ��(��) �����Ǿ����ϴ�. -- 938764 ���� ������ ����~!!!(��� ����)


-- ���� ��ǰ �߼��� �Ϸ���� ���� ���� �ֹ� �����͸� �����ϰ�
-- ������ ��� �ֹ� �����͵��� ������ ��Ȳ�̹Ƿ�
-- ���̺��� ��(���ڵ�)�� ������ �پ��� �ſ� �������� ��Ȳ

SELECT *
FROM TBL_JUMUN;
--==>>
/*
938765	Ȩ����	10	2021-04-01 14:23:49
938766	����	    10	2021-04-01 14:24:42
938767	��Ŭ	    10	2021-04-01 14:25:02
938768	Ȩ����	50	2021-04-01 14:25:36
938769	����Ĩ	30	2021-04-01 14:26:34
938770	����Ĩ	20	2021-04-01 14:26:37
938771	����Ĩ	10	2021-04-01 14:27:13
938772	��īĨ	40	2021-04-01 14:27:54
938773	��īĨ	20	2021-04-01 14:28:15
938774	ĭ��	    20	2021-04-01 14:29:05
938775	ĭ��	    10	2021-04-01 14:29:16
938776	�ٳ���ű	10	2021-04-01 14:29:37
*/

--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


-- �׷���, ���ݱ��� �ֹ����� ������ ���� ������
-- ��ǰ�� �� �ֹ������� ��Ÿ���� �� ��Ȳ�� �߻��ϰ� �Ǿ���.
-- �׷��ٸ�... TBL_JUMUNBACKUP ���̺��� ���ڵ�(��)��
-- TBL_JUMUN ���̺��� ���ڵ�(��)�� ���ļ�
-- �ϳ��� ���̺��� ��ȸ�ϴ� �Ͱ� ����
-- ����� Ȯ���� �� �ֵ��� ��ȸ�ؾ� �Ѵ�.

-- �÷��� �÷��� ���踦 ����Ͽ� ���̺��� �����ϰ��� �ϴ� ��� JOIN �� ���������
-- ���ڵ�(��)�� ���ڵ�(��)�� �����ϰ��� �ϴ� ��� UNION / UNION ALL �� ����� �� �ִ�.


SELECT *
FROM TBL_JUMUNBACKUP
UNION
SELECT *
FROM TBL_JUMUN;


SELECT *
FROM TBL_JUMUNBACKUP
UNION ALL
SELECT *
FROM TBL_JUMUN;
--==>> ���� ���� �� ��� ����.



SELECT *
FROM TBL_JUMUN
UNION 
SELECT *
FROM TBL_JUMUNBACKUP;
-- ��ȸ�� ������� ù��° �÷��� �������� �����ؼ� ����
-- �ߺ��� ����� ������ �� �� �ϳ��� ����
-- ����� ���Ƽ� ������ ������


SELECT *
FROM TBL_JUMUN
UNION ALL
SELECT *
FROM TBL_JUMUNBACKUP;
-- ���ս�Ű�� �������..
-- ������ �갡 �� ����(���Ͽ��� ����� �� �����ϱ�)
-- �ߺ��� �� �״�� ����


--�� UNION �� �׻� �ܷΰ����� ù ��° �÷��� ��������
--   �������� ������ �����Ѵ�.
--   UNION ALL �� ���յ� ������� ��ȸ�� ����� ��ȯ�Ѵ�. (���� ������)
--   ����, UNION �� ��������� �ߺ��� ���� ������ ���
--   �ߺ��� �����ϰ� 1�� �ุ ��ȸ�� ����� ��ȯ�ϰ� �ȴ�.


--�� ���ݱ��� �ֹ����� ��� �����͸� ���� 
--   ��ǰ�� �� �ֹ����� ��ȸ�ϴ� �������� �����Ѵ�.
/*
-------------------------------------------------
        ��ǰ�ڵ�                    �� �ֹ���
-------------------------------------------------
        ..                              XX
        .....                           XXX
        ....                            XXX
-------------------------------------------------
*/



SELECT E.JECODE, SUM(E.JUSU)
FROM
(
    SELECT *
    FROM TBL_JUMUN 
    UNION ALL
    SELECT *
    FROM TBL_JUMUNBACKUP 
) E
GROUP BY E.JECODE;
-- �̰� �� ��..


-- �� Ǯ��

SELECT JECODE "��ǰ�ڵ�", SUM(JUSU) "�� �ֹ���"
FROM
(
    SELECT JECODE, JUSU
    FROM TBL_JUMUNBACKUP 
    UNION ALL
    SELECT JECODE, JUSU
    FROM TBL_JUMUN 
) T
GROUP BY T.JECODE;
 
 
-- UNION�� ����? SUM�� ���̰� �ִ�..��?
-- �ߺ��� ���ڵ尡 ���ŵǰ� �ϳ��� ������ ī��Ʈ�� �ϱ� ����

--> �� ������ �ذ��ϴ� ���������� UNION �� ����ؼ��� �ȵȴ�.
--  �� JECODE �� JUSU �� ��ȸ�ϴ� �������� �ߺ��� ���� �����ϴ� ��Ȳ�� �߻��ϱ� ����


--�� INTERSECT / MINUS (�� ������ / ������)
--   ��ǰ�ڵ�� �ֹ����� ���� �Ȱ��� �ุ �����ϰ��� �Ѵ�.

SELECT JECODE, JUSU
FROM TBL_JUMUNBACKUP
INTERSECT           -- �����ո� ã��
SELECT JECODE, JUSU
FROM TBL_JUMUN;
--==>>
/*
����Ĩ	30
��Ŭ	    10
ĭ��  	20
��īĨ	40
Ȩ����	50
*/

--�� TBL_JUMUNBACKUP ���̺�� TBL_JUMUN ���̺���
--   ��ǰ�ڵ�� �ֹ����� ���� �Ȱ��� ���� ������
--   �ֹ���ȣ, ��ǰ�ڵ�, �ֹ�����, �ֹ����� �׸����� ��ȸ�Ѵ�

SELECT *
FROM TBL_JUMUN;


SELECT  JECODE, JUSU, JUDAY, JUNO
FROM 
(
    SELECT *
    FROM TBL_JUMUNBACKUP 
    UNION ALL          
    SELECT *
    FROM TBL_JUMUN
) E1;

INTERSECT 


SELECT JECODE, JUSU
FROM
(   SELECT JECODE, JUSU
    FROM TBL_JUMUNBACKUP 
    INTERSECT
    SELECT JECODE, JUSU 
    FROM TBL_JUMUN
);


-- Ǯ��
SELECT E2.JUNO, E1.JECODE, E1.JUSU, E2.JUDAY
FROM 
(
    SELECT JECODE, JUSU
    FROM TBL_JUMUNBACKUP 
    INTERSECT
    SELECT JECODE, JUSU 
    FROM TBL_JUMUN
) E1
JOIN  
(
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUNBACKUP 
    UNION ALL          
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUN
) E2
ON E1.JECODE = E2.JECODE AND E1.JUSU=E2.JUSU;
--==>>
/*
2	��Ŭ	10	01/11/01
3	����Ĩ	30	01/11/01
5	Ȩ����	50	01/11/03
8	��īĨ	40	01/11/14
10	ĭ��	20	01/11/20
938767	��Ŭ	10	21/04/01
938768	Ȩ����	50	21/04/01
938769	����Ĩ	30	21/04/01
938772	��īĨ	40	21/04/01
938774	ĭ��	20	21/04/01
*/
WHERE E2.JECODE = E1.JECODE AND E2.JUSU = E1.JUSU;
        
        
          
