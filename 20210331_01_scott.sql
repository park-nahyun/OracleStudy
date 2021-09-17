SELECT USER
FROM DUAL;
--==>> SCOTT


SELECT DEPTNO "�μ���ȣ", SUM(SAL) "�޿���", GROUPING(DEPTNO)
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);



SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN DEPTNO
            ELSE '���μ�'
       END "�μ���ȣ"
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>> ������ DEPTNO�� ����, '���μ�'�� ����
/*
ORA-00932: inconsistent datatypes: expected NUMBER got CHAR
00932. 00000 -  "inconsistent datatypes: expected %s got %s"
*Cause:    
*Action:
13��, 18������ ���� �߻�
*/




SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN TO_CHAR(DEPTNO)
            ELSE '���μ�'
       END "�μ���ȣ"
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	    8750
20	    10875
30	    9400
(NULL)	8000
���μ�	37025
*/



SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '����')
            ELSE '���μ�'
       END "�μ���ȣ"
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	        8750
20	        10875
30	        9400
����	        8000
���μ�	    37025
*/



--�� TBL_SAWON ���̺��� ������ ���� ��ȸ�� �� �ֵ��� �������� �����Ѵ�.
/*
---------------------------------------
       ����               �޿���
---------------------------------------
        ��                XXXXXXX
        ��                XXXXXXX
        �����          XXXXXXXX
----------------------------------------
*/


-- ���� �� ��(��..)

SELECT *
FROM TBL_SAWON;


SELECT SUM(SAL)
FROM TBL_SAWON
GROUP BY (SUBSTR(JUBUN 7, 1)); -- �ȵ�


SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '����'
            WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '����'
       ELSE '���� ����'
       END "����"
     , SAL "�޿�"
FROM TBL_SAWON;



SELECT CASE GROUPING(T.����) WHEN 1 THEN '�����'
       ELSE T.���� END "����"
     , SUM(T.�޿�)
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '����'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '����'
           ELSE '���� ����'
           END "����"
         , SAL "�޿�"
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.����);
--==>>
/*
����  	12000
����	    24100
�����	36100
*/


-- �Բ� Ǯ��


SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '����'
            WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '����'
       ELSE 'Ȯ�� �Ұ�'
       END "����"
     , SAL "�޿�"
FROM TBL_SAWON;




SELECT *
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '����'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '����'
           ELSE 'Ȯ�� �Ұ�'
           END "����"
         , SAL "�޿�"
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.����);



SELECT T.���� "����"
     , SUM(T.�޿�)"�޿���"
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '����'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '����'
           ELSE '���� ����'
           END "����"
         , SAL "�޿�"
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.����);
--==>>
/*
����	    12000
����	    24100
NULL	36100
*/


SELECT CASE GROUPING(T.����) WHEN 1 THEN '�����'
                             WHEN 0 THEN T.����
       ELSE 'Ȯ�κҰ�' END "����"
     , SUM(T.�޿�)
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '����'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '����'
           ELSE '���� ����'
           END "����"
         , SAL "�޿�"
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.����);
--==>>
/*
����	        12000
����	        24100
�����	    36100
*/


SELECT *
FROM VIEW_SAWON;



--�� TBL_SAWON ���̺��� ������ ���� ���ɴ뺰 �ο��� ���·�
--   ��ȸ�� �� �ֵ��� �������� �����Ѵ�.
/*
--------------------------------
      ���ɴ�         �ο���
--------------------------------
        10              X
        20              X
        30              X
        40              X
        50              X
       ��ü             XX
----------------------------------
*/


-- õ���� ���� Ǯ��
-- ����� (INLINE VIEW �� �� �� ��ø~!!!) �� ����ؼ� ���� �ʱ�..

SELECT *
FROM TBL_SAWON;


-- ���� ���
SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 2000) + 1
            WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1900) + 1
       ELSE -1 
       END "����"
FROM TBL_SAWON;



-- ���ɴ� ���
SELECT CASE SUBSTR(TO_CHAR(T.����), 1, 1) WHEN '1' THEN '10'
                                 WHEN '2' THEN '20'
                                 WHEN '3' THEN '30'
                                 WHEN '4' THEN '40'
                                 WHEN '5' THEN '50'
       ELSE '����'
       END "���ɴ�"
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 2000) + 1
                WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1900) + 1
           ELSE -1 
           END "����"
    FROM TBL_SAWON
) T;


SELECT CASE WHEN GROUPING(S.���ɴ�) = 1 THEN '��ü'
            WHEN GROUPING(S.���ɴ�) = 0 THEN S.���ɴ�
       ELSE '����'
       END "���ɴ�"
     , COUNT(S.���ɴ�) "�ο���"
FROM
(
    SELECT CASE SUBSTR(TO_CHAR(T.����), 1, 1) WHEN '1' THEN '10'
                                     WHEN '2' THEN '20'
                                     WHEN '3' THEN '30'
                                     WHEN '4' THEN '40'
                                     WHEN '5' THEN '50'
           ELSE '����'
           END "���ɴ�" -- SUBSTR ���� ���� �ٽ�...
    FROM
    (
        SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 2000) + 1
                    WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1900) + 1
               ELSE -1 
               END "����"
        FROM TBL_SAWON
    ) T
) S
GROUP BY ROLLUP(S.���ɴ�)
ORDER BY 1 ASC
--==>>
/*
10	2
20	11
40	1
50	2
��ü	16
*/



-- ����� (INLINE VIEW �� �� ���� ���~!!!)

SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 2000) + 1
            WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1900) + 1
       ELSE -1 
       END "����"
FROM TBL_SAWON;

SELECT TRUNC(28, -1) "Ȯ��" -- ����~~!! 10�� �ڸ�����~~ ������� �� ��� ��~~!!!
FROM DUAL;


-- ���� �� �� ��
SELECT CASE WHEN GROUPING(S.���ɴ�) = 1 THEN '��ü'
            WHEN GROUPING(S.���ɴ�) = 0 THEN S.���ɴ�
       ELSE '����'
       END "���ɴ�"
     , COUNT(S.���ɴ�) "�ο���"
FROM
(
  SELECT  TRUNC(CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 2000) + 1
                    WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1900) + 1
               ELSE -1 
               END, -1) "���ɴ�"
 FROM TBL_SAWON;
) S



--�� ROLLUP Ȱ�� �� CUBE

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY DEPTNO, JOB -- �μ� ��ȣ����, �������� ����
ORDER BY 1,2;  
--==>> 
/*
10	CLERK	    1300    -- 10�� �ȿ��� CLERK���� �𿩶�~ 
10	MANAGER	    2450
10	PRESIDENT	5000
20	ANALYST	    6000
20	CLERK	    1900
20	MANAGER	    2975
30	CLERK	    950
30	MANAGER	    2850
30	SALESMAN	5600
*/


SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB) -- �μ� ��ȣ����, �������� ����
ORDER BY 1,2; 
--==>>
/*
10	    CLERK   	1300
10	    MANAGER	    2450
10	    PRESIDENT	5000
10	    (NULL)	    8750    -- 10�� �μ� ��� ������ �޿���
20	    ANALYST	    6000
20  	CLERK	    1900
20	    MANAGER	    2975
20	    (NULL)  	10875   -- 20�� �μ� ��� ������ �޿���
30	    CLERK	    950
30	    MANAGER	    2850
30	    SALESMAN	5600
30	    (NULL)  	9400    -- 30�� �μ� ��� ������ �޿���
(NULL)	(NULL)	    29025   -- ��� �μ� ��� ������ �޿���
*/

--�� CUBE �� ROLLUP() ���� �� �ڼ��� ����� ��ȯ���� �� �ִ�.
SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB) -- �μ� ��ȣ����, �������� ����
ORDER BY 1,2; 
--==>>
/*
10	    CLERK	    1300
10	    MANAGER	    2450
10	    PRESIDENT	5000
10	    (NULL)	    8750        -- 10�� �μ� ��� ������ �޿���
20	    ANALYST 	6000
20	    CLERK	    1900
20	    MANAGER	    2975
20	    (NULL)	    10875       -- 20�� �μ� ��� ������ �޿���
30	    CLERK	    950
30	    MANAGER	    2850
30	    SALESMAN	5600
30	    (NULL)	    9400        -- 30�� �μ� ��� ������ �޿���
(NULL)	ANALYST	    6000        -- ��� �μ� ��� ������ �޿���
(NULL)	CLERK	    4150        -- ��� �μ� ��� ������ �޿���
(NULL)	MANAGER	    8275        -- ��� �μ� ��� ������ �޿���
(NULL)	PRESIDENT	5000        -- ��� �μ� ��� ������ �޿���
(NULL)	SALESMAN	5600        -- ��� �μ� ��� ������ �޿���
(NULL)	(NULL)  	29025       -- ��� �μ� ��� ������ �޿���
*/



--�� ROLLUP() �� CUBE() ��
--   �׷��� �����ִ� ����� �ٸ���.(����)


-- ROLLUP(A, B, C)
-- �� (A, B, C) / (A, B) / (A) / ()

-- CUBE(A, B, C)
-- �� (A, B, C) / (A, B) / (A, C) / (B, C) / (A) / (B) / (C) / ()

--==>> ���� ó�� ������ ���ϴ� ����� ���� ���ϰų� �ʹ� ���� ������� ��µǱ� ������
--    ������ ���� ���¸� �� ���� ����Ѵ�.


SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '����')
       ELSE '��ü�μ�'
       END "�μ���ȣ"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
       ELSE '��ü����'
       END "����" 
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY 1,2;
--==>>
/*
10  	CLERK	    1300
10  	MANAGER	    2450
10  	PRESIDENT	5000
10  	��ü����	    8750
20  	ANALYST	    6000
20  	CLERK	    1900
20  	MANAGER	    2975
20	    ��ü����	    10875
30  	CLERK	    950
30  	MANAGER	    2850
30	    SALESMAN	5600
30  	��ü����	    9400
����	    CLERK	    2500
����	    SALESMAN	5500
����	    ��ü����    	8000
��ü�μ�	��ü����	    37025
*/


SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '����')
       ELSE '��ü�μ�'
       END "�μ���ȣ"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
       ELSE '��ü����'
       END "����" 
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1,2;
--==>>
/*
10	        CLERK	    1300
10	        MANAGER	    2450
10	        PRESIDENT	5000
10	        ��ü����    	8750
20	        ANALYST	    6000
20	        CLERK	    1900
20	        MANAGER	    2975
20	        ��ü����    	10875
30	        CLERK	    950
30	        MANAGER	    2850
30	        SALESMAN	5600
30	        ��ü����	    9400
����	        CLERK	    2500
����	        SALESMAN	5500
����  	    ��ü����	    8000
��ü�μ�    	ANALYST 	6000
��ü�μ�    	CLERK	    6650
��ü�μ�    	MANAGER	    8275
��ü�μ�    	PRESIDENT	5000
��ü�μ�    	SALESMAN	11100
��ü�μ�    	��ü����    	37025
*/


SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '����')
       ELSE '��ü�μ�'
       END "�μ���ȣ"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
       ELSE '��ü����'
       END "����" 
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO, JOB), (DEPTNO), ()) -- ROLLUP�� ������� ����
ORDER BY 1,2;
--==>>
/*
10	CLERK	1300
10	MANAGER	2450
10	PRESIDENT	5000
10	��ü����	8750
20	ANALYST	6000
20	CLERK	1900
20	MANAGER	2975
20	��ü����	10875
30	CLERK	950
30	MANAGER	2850
30	SALESMAN	5600
30	��ü����	9400
����	CLERK	2500
����	SALESMAN	5500
����	��ü����	8000
��ü�μ�	��ü����	37025
*/

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '����')
       ELSE '��ü�μ�'
       END "�μ���ȣ"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
       ELSE '��ü����'
       END "����" 
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO, JOB), (DEPTNO), (JOB), ()) -- CUBE ������� ����
ORDER BY 1,2;
--==>>
/*
10	CLERK	1300
10	MANAGER	2450
10	PRESIDENT	5000
10	��ü����	8750
20	ANALYST	6000
20	CLERK	1900
20	MANAGER	2975
20	��ü����	10875
30	CLERK	950
30	MANAGER	2850
30	SALESMAN	5600
30	��ü����	9400
����	CLERK	2500
����	SALESMAN	5500
����	��ü����	8000
��ü�μ�	ANALYST	6000
��ü�μ�	CLERK	6650
��ü�μ�	MANAGER	8275
��ü�μ�	PRESIDENT	5000
��ü�μ�	SALESMAN	11100
��ü�μ�	��ü����	37025
*/


ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--�� TBL_EMP  ���̺��� �Ի�⵵�� �ο����� ��ȸ�Ѵ�.

SELECT *
FROM TBL_EMP
ORDER BY HIREDATE;

/*
-------------------------------
    �Ի�⵵         �ο���
-------------------------------
    1980                1
    1981               10
    1982                1
    1987                2
    2021                5
    ��ü               19
--------------------------------
*/


-- �ο� �� ��ȸ
SELECT EXTRACT(YEAR FROM HIREDATE)"�Ի�⵵"
FROM TBL_EMP;


--

SELECT CASE WHEN GROUPING(T.�Ի�⵵) = 1 THEN '��ü'
            ELSE TO_CHAR(T.�Ի�⵵)
       END "�Ի�⵵"
     , COUNT(T.�Ի�⵵)
FROM
(
    SELECT EXTRACT(YEAR FROM HIREDATE)"�Ի�⵵"
    FROM TBL_EMP
) T
GROUP BY ROLLUP(T.�Ի�⵵)
ORDER BY 1;
--==>>
/*
1980	1
1981	10
1982	1
1987	2
2021	5
��ü  	19
*/



SELECT CASE WHEN GROUPING(T.�Ի�⵵) = 1 THEN '��ü'
            ELSE TO_CHAR(T.�Ի�⵵)
       END "�Ի�⵵"
     , COUNT(T.�Ի�⵵)
FROM
(
    SELECT EXTRACT(YEAR FROM HIREDATE)"�Ի�⵵"
    FROM TBL_EMP
) T
GROUP BY CUBE(T.�Ի�⵵)
ORDER BY 1;



SELECT CASE WHEN GROUPING(T.�Ի�⵵) = 1 THEN '��ü'
            ELSE TO_CHAR(T.�Ի�⵵)
       END "�Ի�⵵"
     , COUNT(T.�Ի�⵵)
FROM
(
    SELECT EXTRACT(YEAR FROM HIREDATE)"�Ի�⵵"
    FROM TBL_EMP
) T
GROUP BY GROUPING SETS(�Ի�⵵, ())
ORDER BY 1;



-- �����ؼ� �� ��
SELECT EXTRACT(YEAR FROM HIREDATE) "�Ի�⵵"
     , COUNT(*)
FROM TBL_EMP
GROUP BY ROLLUP(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>>
/*
1980	1
1981	10
1982	1
1987	2
2021	5
(NULL)	19
*/

SELECT EXTRACT(YEAR FROM HIREDATE) "�Ի�⵵"
     , COUNT(*)
FROM TBL_EMP
GROUP BY CUBE(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;


SELECT EXTRACT(YEAR FROM HIREDATE) "�Ի�⵵"
     , COUNT(*)
FROM TBL_EMP
GROUP BY GROUPING SETS((EXTRACT(YEAR FROM HIREDATE)), ())
ORDER BY 1;


--�� ���Ⱑ ����
SELECT EXTRACT(YEAR FROM HIREDATE) "�Ի�⵵"
     , COUNT(*)
FROM TBL_EMP
GROUP BY ROLLUP(TO_CHAR(HIREDATE, 'YYYY')) -- ���ڷ� ������ ���� / CUBE, GROUPSET�� ��������
ORDER BY 1;
--==>> ���� �߻�
/*
ORA-00979: not a GROUP BY expression
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
643��, 26������ ���� �߻�
*/

SELECT TO_CHAR(HIREDATE, 'YYYY') "�Ի�⵵"
     , COUNT(*)
FROM TBL_EMP
GROUP BY ROLLUP(TO_CHAR(HIREDATE, 'YYYY')) -- ���ڷ� ������ ���� / CUBE, GROUPSET�� ��������
ORDER BY 1;
-- SELECT �������� �� �ڷ����� GROUP BY�� �ڷ����� ��ġ�ؾ� �Ѵ�.
-- SELECT�� �׷���̰� ��������Ÿ� ���� ������..!!


---------------------------------------------------------------------
--���� HAVING ����--

--�� EMP ���̺��� �μ���ȣ�� 20, 30�� �μ��� �������
--   �μ��� �� �޿��� 10000 ���� ���� ��츸 �μ����� �� �޿��� ��ȸ�Ѵ�.

SELECT *
FROM TBL_EMP;

SELECT DEPTNO, SUM(SAL)
FROM TBL_EMP
WHERE DEPTNO IN (20, 30)
GROUP BY DEPTNO;


SELECT DEPTNO, SUM(SAL)
FROM TBL_EMP
WHERE DEPTNO IN (20, 30)
      AND SUM(SAL) < 10000
GROUP BY DEPTNO;
--==>> ��.. �������ϴ�..
/*
ORA-00934: group function is not allowed here (SUM, WHERE��)
00934. 00000 -  "group function is not allowed here"
*Cause:    
*Action:
684��, 11������ ���� �߻�
*/


SELECT DEPTNO, SUM(SAL)
FROM TBL_EMP
WHERE DEPTNO IN (20, 30)
HAVING SUM(SAL) < 10000
GROUP BY DEPTNO;
--==>> 
/*
30	9400
*/


SELECT DEPTNO, SUM(SAL)
FROM TBL_EMP
HAVING DEPTNO IN (20, 30)
       AND SUM(SAL) < 10000
GROUP BY DEPTNO;
--==>> 
/*
30	9400
*/
-- WHERE ���� HAVING�� �� �־ �Ǳ������� ����..
-- �Ľ� ����..! FROM ���� WHERE �������� 1�������� �޸𸮿� �ۿø�
-- WHERE�� ������ EMP ���̺� ��ü�� �ۿø�.. ȿ����

--------------------------------------------------------------

--���� ��ø �׷��Լ� / �м��Լ� ����--

-- �׷� �Լ� 2 LEVEL ���� ��ø�ؼ� ����� �� �ִ�.
-- �� ������ MS-SQL �� �Ұ����ϴ�.
SELECT MAX(SUM(SAL))
FROM EMP
GROUP BY DEPTNO;
--==>> 10875

-- RANK()
-- DENSE_RANK()
--> �Լ� �ȿ��� �����ؾ� �ؼ� ���ҽ� �Ҹ� ���ϴ�
--  ORACLE 9i ���� ����.. MSSQL 2005���� ����..

--�� ���� ���������� RANK()�� DENSE_RANK()�� ����� �� ���� ������
--   �̸� ��ü�Ͽ� ������ ������ �� �ִ� ����� �����ؾ� �Ѵ�.

-- ���� ���, �޿��� ������ ���ϰ��� �Ѵٸ�...
-- �ش� ����� �޿����� �� ū ���� �� ������ Ȯ���� ��
-- �� Ȯ���� ���ڿ� +1 �� �߰� �������ָ� �װ��� �� ����� �ȴ�.


SELECT ENAME, SAL, 1
FROM EMP;

SELECT COUNT(*) + 1
FROM EMP
WHERE SAL > 800;
-- ���̽����� SAL�� ū ����� �� ���̳�?
--==>> ���̽��� �޿� ���


SELECT COUNT(*) + 1
FROM EMP
WHERE SAL > 1600;   -- ALLEN �� �޿�
--==>> 7 �� ALLEN �� �޿� ���




--�� ���� ��� ���� (��� ���� ����)
--   ���� ������ �ִ� ���̺��� �÷���
--   ���� ������ ������(WHERE��, HAVING��)�� ���Ǵ� ���,
--   �츮�� �� �������� ���� ��� ���� ��� �θ���.

SELECT ENAME "�����", SAL "�޿�", 1 "�޿����"
FROM EMP;


SELECT ENAME "�����", SAL "�޿�", (1) "�޿����"
FROM EMP;


SELECT ENAME "�����", SAL "�޿�"
    , (SELECT COUNT(*) + 1
        FROM EMP 
        WHERE SAL > 800)  "�޿����"                           
FROM EMP;
--==>>
/*
SMITH	800 	14
ALLEN	1600	14
WARD	1250	14
JONES	2975	14
MARTIN	1250	14
BLAKE	2850	14
CLARK	2450	14
SCOTT	3000	14
KING	5000	14
TURNER	1500	14
ADAMS	1100	14
JAMES	950 	14
FORD	3000	14
MILLER	1300	14
*/


SELECT ENAME "�����", SAL "�޿�"
    , (SELECT COUNT(*) + 1
        FROM EMP E2
        WHERE E2.SAL > E1.SAL)  "�޿����"                           
FROM EMP E1
ORDER BY 3;
/*
KING	5000	1
FORD	3000	2
SCOTT	3000	2
JONES	2975	4
BLAKE	2850	5
CLARK	2450	6
ALLEN	1600	7
TURNER	1500	8
MILLER	1300	9
WARD	1250	10
MARTIN	1250	10
ADAMS	1100	12
JAMES	950 	13
SMITH	800	    14
-- ���� ó���� ������ ������.. ���� ������ �� �� �� �Ἥ �ؾ��� ��..!
*/




--�� EMP ���̺��� �������
--   �����, �޿�, �μ���ȣ, �μ����޿����, ��ü�޿���� �׸��� ��ȸ�Ѵ�.
--   ��, RANK() �Լ��� ������� �ʰ� ���� ��� ������ Ȱ���� �� �ֵ��� �Ѵ�.


-- �μ� �޿� ���


SELECT ENAME "�����", SAL "�޿�"
       , CASE WHEN DEPTNO IS NULL THEN '����' ELSE TO_CHAR(DEPTNO) END "�μ���ȣ"
FROM TBL_EMP;

SELECT ENAME "�����", SAL "�޿�"
      
      , (SELECT COUNT(*) + 1
        FROM TBL_EMP E2
        WHERE E2.SAL > E1.SAL) "��ü�޿����"
      , (SELECT COUNT(*) + 1
        FROM TBL_EMP E2
        WHERE E2.SAL > E1.SAL  AND E1.DEPTNO = E2.DEPTNO) "�μ����޿����"
FROM 
(
    SELECT ENAME "�����", SAL "�޿�"
           , CASE WHEN DEPTNO IS NULL THEN '����' ELSE TO_CHAR(DEPTNO) END "�μ���ȣ"
    FROM TBL_EMP;
) E1
ORDER BY 3, 5;

--==>>
/*
KING	5000	10	1	1
CLARK	2450	10	7	2
MILLER	1300	10	12	3
FORD	3000	20	2	1
SCOTT	3000	20	2	1
JONES	2975	20	4	3
ADAMS	1100	20	15	4
SMITH	800	    20	19	5
BLAKE	2850	30	5	1
ALLEN	1600	30	9	2
TURNER	1500	30	10	3
MARTIN	1250	30	13	4
WARD	1250	30	13	4
JAMES	950 	30	18	6
����	    1500	    10	1
������	1000		16	1
������	2000		8	1
������	2500		6	1
������	1000		16	1
*/


-- ���� Ǯ��

SELECT ENAME "�����"
     , SAL "�޿�"
     , DEPTNO "�μ���ȣ"
     , (SELECT COUNT(*) + 1
        FROM EMP E2
        WHERE E2.DEPTNO = E1.DEPTNO AND E2.SAL > E1.SAL) "�μ����޿����"
     , (SELECT COUNT(*) + 1
         FROM EMP E2
         WHERE E2.SAL > E1.SAL) "��ü�޿����"
FROM EMP E1
ORDER BY E1.DEPTNO, E1.SAL DESC;
--==>> 
/*
KING	5000	10	1	1
CLARK	2450	10	2	6
MILLER	1300	10	3	9
SCOTT	3000	20	1	2
FORD	3000	20	1	2
JONES	2975	20	3	4
ADAMS	1100	20	4	12
SMITH	800	    20	5	14
BLAKE	2850	30	1	5
ALLEN	1600	30	2	7
TURNER	1500	30	3	8
MARTIN	1250	30	4	10
WARD	1250	30	4	10
JAMES	950	    30	6	13
*/

SELECT *
FROM EMP
ORDER BY DEPTNO, HIREDATE;

--�� EMP ���̺��� ������� ������ ���� ��ȸ�� �� �ֵ��� �������� �����Ѵ�.
/*
----------------------------------------------------------------------
    �����     �μ���ȣ       �Ի���      �޿�       �μ����Ի纰�޿�����
----------------------------------------------------------------------
    CLERK       10        1981-06-09     2450           2450
    KING        10        1981-11-17     5000           7450
    MILLER      10        1982-01-23     1300           8750
    SMITH       20        1980-12-17      800            800
    JONES       20        1981-04-02     2975           3775
                                :  
                                :
 -----------------------------------------------------------------------
*/

SELECT SAL "�μ����Ի纰�޿�����"
FROM EMP
ORDER BY DEPTNO, HIREDATE;



SELECT ENAME "�����", DEPTNO "�μ���ȣ", HIREDATE "�Ի���", SAL "�޿�"
    , (SELECT SUM(E2.SAL)
        FROM EMP E2
        WHERE E1.HIREDATE >= E2.HIREDATE 
        AND E2.DEPTNO = E1.DEPTNO) "�μ���"
FROM EMP E1
ORDER BY DEPTNO, HIREDATE;
--==>>
/*
CLARK	10	1981-06-09	2450	2450
KING	10	1981-11-17	5000	7450
MILLER	10	1982-01-23	1300	8750
SMITH	20	1980-12-17	 800	800
JONES	20	1981-04-02	2975	3775
FORD	20	1981-12-03	3000	6775
SCOTT	20	1987-07-13	3000	10875
ADAMS	20	1987-07-13	1100	10875
ALLEN	30	1981-02-20	1600	1600
WARD	30	1981-02-22	1250	2850
BLAKE	30	1981-05-01	2850	5700
TURNER	30	1981-09-08	1500	7200
MARTIN	30	1981-09-28	1250	8450
JAMES	30	1981-12-03	 950	9400
*/



SELECT ENAME "�����", DEPTNO "�μ���ȣ", HIREDATE "�Ի���", SAL "�޿�"
    , 1 "�μ����Ի纰�޿�����"
FROM EMP
ORDER BY 2, 3;



SELECT ENAME "�����", DEPTNO "�μ���ȣ", HIREDATE "�Ի���", SAL "�޿�"
    , (1) "�μ����Ի纰�޿�����"
FROM EMP
ORDER BY 2, 3;



SELECT E1.ENAME "�����", E1.DEPTNO "�μ���ȣ", E1.HIREDATE "�Ի���", E1.SAL "�޿�"
    , (SELECT SUM(E2.SAL)
         FROM EMP E2) "�μ����Ի纰�޿�����"  
FROM EMP E1
ORDER BY 2, 3;



SELECT E1.ENAME "�����", E1.DEPTNO "�μ���ȣ", E1.HIREDATE "�Ի���", E1.SAL "�޿�"
    , (SELECT SUM(E2.SAL)
       FROM EMP E2
       WHERE E2.DEPTNO = E1.DEPTNO
         AND E2.HIREDATE <= E1.HIREDATE) "�μ����Ի纰�޿�����"  
FROM EMP E1
ORDER BY 2, 3;
--==>>
/*
CLARK	10	1981-06-09	2450	2450
KING	10	1981-11-17	5000	7450
MILLER	10	1982-01-23	1300	8750
SMITH	20	1980-12-17	 800	 800
JONES	20	1981-04-02	2975	3775
FORD	20	1981-12-03	3000	6775
SCOTT	20	1987-07-13	3000	10875
ADAMS	20	1987-07-13	1100	10875
ALLEN	30	1981-02-20	1600	1600
WARD	30	1981-02-22	1250	2850
BLAKE	30	1981-05-01	2850	5700
TURNER	30	1981-09-08	1500	7200
MARTIN	30	1981-09-28	1250	8450
JAMES	30	1981-12-03	 950	9400
*/


--�� TBL_EMP ���̺��� �Ի��� ����� ���� ���� ������ ���� 
--   �Ի����� �ο����� ��ȸ�� �� �ִ� �������� �����Ѵ�.
/*
--------------------------
    �Ի���       �ο���
--------------------------
   XXXX-XX        XX
---------------------------
*/

-- ���� �ٽ� �� ��

SELECT *
FROM TBL_EMP;

SELECT SUM(COUNT(HIREDATE))
FROM TBL_EMP E2
GROUP BY E2.HIREDATE;

-- �Ի��ϸ��� �� �� �Ի��ߴ���
SELECT E1.HIREDATE,
       (SELECT SUM(COUNT(*))
        FROM TBL_EMP E2
        WHERE TO_CHAR(E1.HIREDATE, 'YYYY-MM-DD') = TO_CHAR(E2.HIREDATE, 'YYYY-MM-DD')
        GROUP BY E2.HIREDATE) "����Ի�"
FROM TBL_EMP E1
GROUP BY E1.HIREDATE
ORDER BY 1;
--==>>
/*
1980-12-17	1
1981-02-20	1
1981-02-22	1
1981-04-02	1
1981-05-01	1
1981-06-09	1
1981-09-08	1
1981-09-28	1
1981-11-17	1
1981-12-03	2
1982-01-23	1
1987-07-13	2
2021-03-30	5
2021-03-30	5
2021-03-30	5
2021-03-30	5
2021-03-30	5
*/


SELECT HIREDATE, 
       (SELECT SUM(COUNT(*))
        FROM TBL_EMP E2
        WHERE TO_CHAR(E1.HIREDATE, 'YYYY-MM') = TO_CHAR(E2.HIREDATE, 'YYYY-MM')
        GROUP BY E2.HIREDATE) "�ش糯¥�Ի��ο�"
FROM TBL_EMP E1
GROUP BY E1.HIREDATE;
--==>>

 SELECT SUM(COUNT(*))
    FROM TBL_EMP E2
    WHERE TO_CHAR(E1.HIREDATE, 'YYYY-MM') = TO_CHAR(E2.HIREDATE, 'YYYY-MM')
    GROUP BY E2.HIREDATE; "�ش糯¥�Ի��ο�"

SELECT MAX(T.HIREDATE), MAX(T.�ش糯¥�Ի��ο�)
FROM 
    (SELECT HIREDATE, 
           (SELECT SUM(COUNT(*))
            FROM TBL_EMP E2
            WHERE TO_CHAR(E1.HIREDATE, 'YYYY-MM') = TO_CHAR(E2.HIREDATE, 'YYYY-MM')
            GROUP BY E2.HIREDATE) "�ش糯¥�Ի��ο�"
    FROM TBL_EMP E1
    GROUP BY E1.HIREDATE
) T;




-- ���� Ǯ��..



SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "�Ի���"
      , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM');
--==>> 
/*
1981-05	1
1981-12	2
1982-01	1
2021-03	5
1981-09	2
1981-02	2
1981-11	1
1980-12	1
1981-04	1
1987-07	2
1981-06	1
*/


SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "�Ի���"
      , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) = 5;
--==>> 2021-03	5


SELECT COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM');
--==>>
/*
1
2
1
5
2
2
1
1
1
2
1
*/


SELECT MAX(COUNT(*)) "�ο���"
FROM TBL_EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM');



SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "�Ի���"
      , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) = (SELECT MAX(COUNT(*)) 
                  FROM TBL_EMP
                  GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM'));
--==>> 2021-03	5



------------------------------------------------------------------------

--���� ROW_NUMBER() ����--

SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) "����"
     , ENAME "�����", SAL "�޿�", HIREDATE "�Ի���"
FROM EMP
ORDER BY ENAME;
--==>>
/*
1	KING	5000	1981-11-17
2	FORD	3000	1981-12-03
3	SCOTT	3000	1987-07-13
4	JONES	2975	1981-04-02
5	BLAKE	2850	1981-05-01
6	CLARK	2450	1981-06-09
7	ALLEN	1600	1981-02-20
8	TURNER	1500	1981-09-08
9	MILLER	1300	1982-01-23
10	WARD	1250	1981-02-22
11	MARTIN	1250	1981-09-28
12	ADAMS	1100	1987-07-13
13	JAMES	950	    1981-12-03
14	SMITH	800	    1980-12-17
*/


--�� �Խ����� �Խù� ��ȣ��
--   SEQUENCE �� IDENTITY �� ����ϰ� �Ǹ�
--   �Խù��� �������� ���, ������ �Խù��� �ڸ���
--   ���� ��ȣ�� ���� �Խù��� ��ϵǴ� ��Ȳ�� �߻��ϰ� �ȴ�.
--   �̴�, ���� ����������... �̰���... �ٶ������� ���� ��Ȳ�� �� �ֱ� ������
--   ROW_NUMBER() �� ����� ����� �� �� �ִ�.
--   ������ �������� ����� ������ SEQUENCE �� IDENTITY�� ���������
--   �ܼ��� �Խù��� ���ȭ�Ͽ� ����ڿ��� ����Ʈ �������� ������ ������
--   ������� �ʴ� ���� ����.


--�� ����
CREATE TABLE TBL_AAA
( NO    NUMBER
, NAME  VARCHAR2(40)
, GRADE CHAR
);
--==> Table TBL_AAA��(��) �����Ǿ����ϴ�.


INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(1, '������', 'A');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(2, '�̻�ȭ', 'B');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(3, '������', 'A');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(4, '�ڹ���', 'C');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(5, '�̻�ȭ', 'A');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(6, '������', 'B');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(7, '������', 'B');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. *7


COMMIT;
--==>> Ŀ�� �Ϸ�

SELECT *
FROM TBL_AAA;
-==>>
/*
1	������	A
1	������	A
2	�̻�ȭ	B
3	������	A
4	�ڹ���	C
5	�̻�ȭ	A
6	������	B
7	������	B

-- ���������� ���� �� �ְ� ������ ����. ���� ��� ����?
*/

UPDATE TBL_AAA
SET GRADE = 'A'
WHERE NAME = '�̻�ȭ' AND GRADE = 'B';
-- ����B�� �̻�ȭ ������ A�� �ٲٷ���?
--==>> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

COMMIT;

SELECT *
FROM TBL_AAA;
-- ���� ��ȭ�� ���� �ȵǰ� ��.
/*
1	������	A
1	������	A
2	�̻�ȭ	A
3	������	A
4	�ڹ���	C
5	�̻�ȭ	A
6	������	B
7	������	B
*/
-- BUT NO ��ȣ�� ����ϸ� ���� �����ϰ���?
-- SEQUENCE�� IDENTITY�� ������������ ���� �� �ƴ�����..
-- �ĺ������� �ʿ���..!



--�� SEQUENCE ���� (������, �ֹ���ȣ)
--   �� �������� �ǹ� : 1.(�Ϸ���) �������� ��ǵ� 2.(���, �ൿ ����) ����
--                       ���� ��ȣǥó�� �� ġ�� ��ȣ ����.. ��ġ�� �� ����


CREATE SEQUENCE SEQ_BOARD -- ������ �⺻ ���� ����(MSSQL �� IDENTITY�� ������ ����)
START WITH 1              -- ���۰�
INCREMENT BY 1            -- ������
NOMAXVALUE                -- �ִ밪 ���� ����
NOCACHE;                 -- ĳ�� ��� ����(����). �ӽ� ���� ���Ѵ�. // Ʈ����, ���� ������ ���� �� �����ؼ�.. ������ ó��.... �������� ��ȣǥ �ޱ� ���� ���� �� ���� �� ����..
--==>> Sequence SEQ_BOARD��(��) �����Ǿ����ϴ�.
-- ù°�ٸ� �ᵵ ������ �������. �������� �ɼ�. 
-- 1���� �����ؼ� 1�� ����, �ƽ� ��� ���� ĳ�� ����.(�⺻)


--�� ���̺� ����(TBL_BOARD)
CREATE TABLE TBL_BOARD           -- TBL_BOARD �̸� �� �Խ���
( NO        NUMBER               -- �Խù� ��ȣ      X  ����ڰ� ���� �Է��ϳ�
, TITLE     VARCHAR2(50)         -- �Խù� ����      ��
, CONTENTS  VARCHAR2(2000)       -- �Խù� ����      ��
, NAME      VARCHAR2(20)         -- �Խù� �ۼ���    �� 
, PW        VARCHAR2(20)         -- �Խù� �н�����  �� 
, CREATED   DATE DEFAULT SYSDATE -- �Խù� �ۼ���    X
);
--==>> Table TBL_BOARD��(��) �����Ǿ����ϴ�.

--�� ������ �Է� �� �Խ��ǿ� �Խù� �ۼ�
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '�ѽ�~1��', '���� 1��������~', '������', 'JAVA006$', DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '�ǰ�����', '�ٵ� �ǰ� ì��ô�', '�̻�ȭ', 'JAVA006$', DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '������', '���� �� ����...', '�ڹ���', 'JAVA006$', DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.


INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '������', '�̼����� ����?', '������', 'JAVA006$', DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '�����ϰ������', '���̳ʹ��־��', '��ƺ�', 'JAVA006$', DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '�����ֽ��ϴ�', '������ �ϸ� �ȵǳ���', '������', 'JAVA006$', DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '�����ֽ��ϴ�', '�������� �ٽ� �����ҰԿ�', '������', 'JAVA006$', DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

--�� Ȯ��
SELECT *
FROM TBL_BOARD;
--==>>
/*
1	�ѽ�~1��	���� 1��������~	            ������	JAVA006$	21/03/31
2	�ǰ�����	�ٵ� �ǰ� ì��ô�      	    �̻�ȭ	JAVA006$	21/03/31
3	������	���� �� ����...          	�ڹ���	JAVA006$	21/03/31
4	������	�̼����� ����?	            ������	JAVA006$	21/03/31
5	�����ϰ������	���̳ʹ��־��	    ��ƺ�	JAVA006$	21/03/31
6	�����ֽ��ϴ�	������ �ϸ� �ȵǳ��� 	������	JAVA006$	21/03/31
7	�����ֽ��ϴ�	�������� �ٽ� �����ҰԿ�	������	JAVA006$	21/03/31
*/

--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.

 
--�� �Խù� ����
DELETE
FROM TBL_BOARD
WHERE NO=4;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.


--�� �Խù� �ۼ�
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '������', '�� �׳� �߷���', '�̻���', 'JAVA006$', DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.


--�� �Խù� ����
DELETE
FROM TBL_BOARD
WHERE NO=8;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.


--�� �Խù� �ۼ�
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '���¿�', '�� ������ �ֽ��ϴ�', '�弭��', 'JAVA006$', DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

--�� Ŀ��
COMMIT;
--==>>

--�� Ȯ��
SELECT *
FROM TBL_BOARD;
--==>>
/*
1	�ѽ�~1��	���� 1��������~	            ������	JAVA006$	21/03/31
3	������	���� �� ����...          	�ڹ���	JAVA006$	21/03/31
5	�����ϰ������	���̳ʹ��־��	    ��ƺ�	JAVA006$	21/03/31
6	�����ֽ��ϴ�	������ �ϸ� �ȵǳ���	    ������	JAVA006$	21/03/31
7	�����ֽ��ϴ�	�������� �ٽ� �����ҰԿ�	������	JAVA006$	21/03/31
9	���¿�	�� ������ �ֽ��ϴ�	        �弭��	JAVA006$	21/03/31
-- ���� ������.. ���Ȼ� ����...
*/

SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "�۹�ȣ"
     , TITLE "����", NAME "�ۼ���", CREATED "�ۼ���"
FROM TBL_BOARD
ORDER BY 4 DESC;
--==>>
/*
6	���¿�	        �弭��	21/03/31
5	�����ֽ��ϴ�	    ������	21/03/31
4	�����ֽ��ϴ�	    ������	21/03/31
3	�����ϰ������	��ƺ�	21/03/31
2	������	        �ڹ���	21/03/31
1	�ѽ�~1��	        ������	21/03/31
-- �ֽ� ���� ���� ���� '���̵���' �ϴ� ��..!
*/


--�� �Խù� �ۼ�
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '�ܷο���', '���۵� ���� �ȿ��', '������', 'JAVA006$', DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.


SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "�۹�ȣ"
     , TITLE "����", NAME "�ۼ���", CREATED "�ۼ���"
FROM TBL_BOARD
ORDER BY 4 DESC;
--==>>
/*
7	�ܷο���        	������	21/03/31
6	���¿�	        �弭��	21/03/31
5	�����ֽ��ϴ�  	������	21/03/31
4	�����ֽ��ϴ�  	������	21/03/31
3	�����ϰ������	��ƺ�	21/03/31
2	������	        �ڹ���	21/03/31
1	�ѽ�~1��	        ������	21/03/31
*/

--�� �Խù� ����
DELETE
FROM TBL_BOARD
WHERE NO=7; -- �����̰� ���� �ƴϰ�.. ����Ǿ��ִ� ��ȣ�� ������


--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�


SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "�۹�ȣ"
     , TITLE "����", NAME "�ۼ���", CREATED "�ۼ���"
FROM TBL_BOARD
ORDER BY 4 DESC;
--==>>
/*
6	�ܷο���	        ������	21/03/31
5	���¿�	        �弭��	21/03/31
4	�����ֽ��ϴ�  	������	21/03/31
3	�����ϰ������	��ƺ�	21/03/31
2	������	        �ڹ���	21/03/31
1	�ѽ�~1��	        ������	21/03/31
*/

-------------------------------------------------------------------------------

--���� JOIN(����) ����--
SELECT * 
FROM EMP;

SELECT *
FROM DEPT;

SELECT *
FROM SALGRADE;

���̽� 800 1981-07-06 CLERK 20 ������ �޶� 1���

�̷��� �ѹ��� �� �� �ִ� �� �� �ɰ�����?;


SELECT EMPNO, ENAME, JOB
FROM EMP
WHERE EMPNO=7369;

SELECT EMPNO, ENAME, JOB, HIREDATE, SAL, COMM
FROM EMP;

SELECT EMPNO
FROM EMP;

-- �ۿø��� �޸� : 1���� ���� ���� 2��, 3���� ����
-- �ϳ��� ã�� �������� ã��.. �ϳ��� �ۿø��°�.. ��ȿ�����̴�..
