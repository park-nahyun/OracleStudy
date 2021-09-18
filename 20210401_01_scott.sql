show user;



---���� JOIN(����) ����---

-- 1. SQL 1992 CODE
SELECT *
FROM EMP, DEPT;
--> ���п��� ���ϴ� ��ī��Ʈ ��(Catersian Product)
--  �� ���̺��� ��ģ(������) ��� ����� ��


-- Equi join : ���� ��Ȯ�� ��ġ�ϴ� �����͵鳢�� �����Ű�� ����
SELECT *
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;
-- DEPTNO �� 10�� �� ����.. 


SELECT *
FROM EMP E, DEPT D      -- ��Ī�ο�
WHERE E.DEPTNO = D.DEPTNO;


-- Non Equi join : ���� �ȿ� ������ �����͵鳢�� �����Ű�� ����

SELECT *
FROM SALGRADE;
SELECT *
FROM EMP;


SELECT *
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL; --����
-- �̰� �ξ� �� �߿�



-- Equi join �� ��+���� Ȱ���� ���� ���
SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--> �� 14���� �����Ͱ� ���յǾ� ��ȸ�� ��Ȳ
--  ��, �μ���ȣ�� ���� ���� �����(5��)�� ��� ����~!!!


SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO(+);
-- FROM����.. TBL_EMP �� �� �ۿø� ���� D.DEPTNO�� �����̴� ����...
--> �� 19���� �����Ͱ� ���յǾ� ��ȸ�� ��Ȳ
--  ��, �μ���ȣ ���� ���� �����(5��)�� ��� ��ȸ�� ��Ȳ~!!!


SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;
--> �� 16���� �����Ͱ� ���յǾ� ��ȸ�� ��Ȳ
--  ��, �μ��� �Ҽӵ� ����� �ƹ��� ���� �μ��� ��� ��ȸ�� ��Ȳ
--  �μ�����(���� ��) ������� ��ȸ �ȵ���

--�� (+)�� ���� �� ���̺��� �����͸� ��� �޸𸮿� ������ ��
--   (+)�� �ִ� �� ���̺��� �����͸� �ϳ��ϳ� Ȯ���Ͽ� ���ս�Ű�� ���·�
--   JOIN�� �̷������


SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO(+);
--> ���� ���� ������ �̷��� ������ JOIN ������ �������� �ʴ´�.

-- BUT �̰� ����. WHERE�� ���տ� ���� ��������
-- �����ϰ� ���� Ư�� ���Ǹ� ������ ���� �򰥸���.


-- 2. SQL 1999 CODE �� ��JOIN�� Ű���� ���� �� JOIN ���� ���
--                      ���� ������ ��WHERE�� ��� ��ON��



-- CROSS JOIN
SELECT *
FROM EMP ��CROSS JOIN DEPT;
--> ������ �� (Catersian Product)�� ��� ����.



-- INNER JOIN
SELECT *
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;
--> Equi join �� ���� ���

--�� INNER JOIN �� INNER �� ���� ����
SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM EMP E JOIN SALGRADE S
ON E.SAL BETWEEN S.LOSAL AND S.HISAL;
--> Equi Join�� Non Equi Join �� INNER JOIN���� ���յ� ��Ȳ


-- OUTER JOIN

SELECT *
FROM TBL_EMP E LEFT OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;
-- E�� ����, D�� �߰�..
-- ���ΰ��� ������ ���� �˷��ְ� OUTER JOIN
-- �� ������ ������ �� ���̺�(�� LEFT)�� �����͸� ��� �޸𸮿� ������ ��
--    ������ �������� ���� �� ���̺���� �����͸� ���� Ȯ���Ͽ� ���ս�Ű�� ���·�
--    JOIN �� �̷������.

SELECT *
FROM TBL_EMP E RIGHT OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;
-- D�� ���� E�� �߰�

SELECT *
FROM TBL_EMP E FULL OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;
-- ���� ���� MAIN �� ���� �����ϱ� �� �� (+) ���̴� �Ͱ� ������.. ��� ����..
-- �μ� ���� ���, ��� ���� �μ� �� �� ��ȸ ����.


--�� OUTER JOIN ���� OUTER �� ���� ����
--   BUT ���� �����Ƿ� ���� ����

SELECT *
FROM TBL_EMP E LEFT OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;


SELECT *
FROM TBL_EMP E RIGHT OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;


SELECT *
FROM TBL_EMP E FULL OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;
--------------------------------------------------OUTER

SELECT *
FROM TBL_EMP E INNER OUTER JOIN TBL_DEPT D -------INNER
ON E.DEPTNO = D.DEPTNO;


-- ���� ���������� ������ ã�� ���� ��..

SELECT *
FROM TBL_EMP E JOIN TBL_DEPT D -------INNER
ON E.DEPTNO = D.DEPTNO;
AND JOB = 'CLERK';
-- �̷��� �������� �����ص� ��ȸ�ϴµ��� ������ ����.
-- 92 �ڵ��� ���ñ� ���� �̷��� �ؾ� ��..

SELECT *
FROM TBL_EMP E JOIN TBL_DEPT D -------INNER
ON E.DEPTNO = D.DEPTNO
WHERE JOB = 'CLERK';
-- ������, �̿� ���� �����Ͽ� ��ȸ�� �� �ֵ��� �����Ѵ�.
-- �װ� ON�� ź���� �ǵ��ϱ�..



-----------------------------------------------------------------------


--�� EMP ���̺�� DEPT ���̺��� �������
--   ������ MANAGER �� CLERK �� ����鸸
--   �μ���ȣ, �μ���, �����, ������, �޿� �׸��� ��ȸ�Ѵ�.
--   -------- ------  ------  -----  ----
--   DEPTNO    DNAME   ENAME   JOB   SAL
--   -------- ------  ------  -----  ----
--     E,D       D       E      E      E


SELECT DEPTNO, DNAME, ENAME, JOB, SAL 
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--==>> ���� �߻�
/*
ORA-00918: column ambiguously defined
00918. 00000 -  "column ambiguously defined"
*Cause:    
*Action:
183��, 8������ ���� �߻�
*/
--> �� ���̺� �� �ߺ��Ǵ� �÷��� ���� �Ҽ� ���̺���
--  �������(����� ���) �Ѵ�.


SELECT DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--> �� ���̺� �� �ߺ��Ǵ� �÷��� �������� �ʴ� ��ȸ ������
--  ���� �߻����� �ʴ´�.
--==>>
/*
ACCOUNTING	CLARK	MANAGER	2450
ACCOUNTING	KING	PRESIDENT	5000
ACCOUNTING	MILLER	CLERK	1300
RESEARCH	JONES	MANAGER	2975
RESEARCH	FORD	ANALYST	3000
RESEARCH	ADAMS	CLERK	1100
RESEARCH	SMITH	CLERK	800
RESEARCH	SCOTT	ANALYST	3000
SALES	    WARD	SALESMAN	1250
SALES	    TURNER	SALESMAN	1500
SALES	    ALLEN	SALESMAN	1600
SALES	    JAMES	CLERK	950
SALES	    BLAKE	MANAGER	2850
SALES	    MARTIN	SALESMAN	1250
*/


SELECT D.DEPTNO, DNAME, ENAME, JOB, SAL 
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
-- �ߺ��Ǵ� �÷��� ��� �ִ� �� ���� �Ǵ��� ��� ���ָ� ���� ����~!
--> �� ���̺� �� �ߺ��Ǵ� �÷��� ���� �Ҽ� ���̺��� ����ϴ� ���
--  �μ�(DEPT), ���(EMP) �� � ���̺��� �����ص�
--  ������ ���࿡ ���� ��� ��ȯ�� ������ ����.

-- �� ������...
--    �� ���̺� �� �ߺ��Ǵ� �÷��� ���� �Ҽ� ���̺��� ����ϴ� ���
--    �θ� ���̺��� �÷��� ������ �� �ֵ��� �ؾ� �Ѵ�.
SELECT *
FROM DEPT;      -- �θ� ���̺�
SELECT *
FROM EMP;       -- �ڽ� ���̺�


-- �� �θ� �ڽ� ���̺� ���踦 ��Ȯ�� ������ �� �ֵ��� �Ѵ�.
-- EMP ���̺�� DEPT ���̺��� ��� ����Ǵ��� Ȯ�� �ؾ� �Ѵ�.
-- EMP��� ���̺�� DEPT ���̺��� ���迡 �־ ������� �Ǵ� ���� DEPTNO


--        DEPTNO
-- EMP ----------- DEPT

-- DEPTNO���� 10�� 1��, 20�� 1��... EMP�� 10�� ������.. 20�� ������..
-- ���� ���� ���� ���� �ڽ�~!


-- �θ� ���̺� ����ϴ� ����2
-- OUTER ���̺���..

SELECT D.DEPTNO, DNAME, ENAME, JOB, SAL 
FROM EMP E LEFT JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT E.DEPTNO, DNAME, ENAME, JOB, SAL 
FROM EMP E LEFT JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;
--------------------------------��� ������ ���� ��������

SELECT D.DEPTNO, DNAME, ENAME, JOB, SAL 
FROM EMP E RIGHT JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT E.DEPTNO, DNAME, ENAME, JOB, SAL 
FROM EMP E RIGHT JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;
------------------------------- ���⼱ OPERATION�� �μ� ��ȣ�� ������..

-- �Ҽӿ� �θ� ���̺��� ��� �� ��� � �־��� ���� ���� ������ ��..



-- �� ���̺� �� �ߺ����� �ʴ� �÷��� �Ҽ��� ����ϴ� ���� �����Ѵ�.
-- �Ҽ��� ���� �ʴ´ٸ�.. ����Ŭ�� EMP, DEPT�� �� �� �湮�ؼ� ���ʿ� �� �ִ� �� Ȯ���ϰ� ����Ѵ�.
-- ���̺��� ��� �Ѵٸ� �� ���� �鷯�� �ǰ���?


-- ���� ����
SELECT D.DEPTNO "�μ���ȣ", D.DNAME "�μ���", E.JOB "������", E.SAL "�޿�"
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE JOB IN ('CLERK', 'MANAGER');



--�� SELF JOIN (�ڱ� ����)
-- EMP ���̺��� ������ ������ ���� ��ȸ�� �� �ֵ��� �Ѵ�.
---------------------------------------------------------------------
-- �����ȣ   �����   ������   �����ڹ�ȣ   �����ڸ�   ������������
---------------------------------------------------------------------
-- 7369       SMITH    CLERK      7902                                   �� E1
--                                             FORD       ANALYIST       �� E2
SELECT *
FROM EMP;

SELECT *
FROM JOB;


SELECT E1.EMPNO "�����ȣ", E1.ENAME "�����", E1.JOB "������", E1.MGR "�����ڹ�ȣ"
     , E2.ENAME "�����ڸ�", E2.JOB "������������"             --E2.EMPNO �ص� ��
FROM EMP E1 JOIN EMP E2
ON E1.MGR = E2.EMPNO;
--==>>
/*
7902	FORD	ANALYST	    7566	JONES	MANAGER
7788	SCOTT	ANALYST	    7566	JONES	MANAGER
7844	TURNER	SALESMAN	7698	BLAKE	MANAGER
7499	ALLEN	SALESMAN	7698	BLAKE	MANAGER
7521	WARD	SALESMAN	7698	BLAKE	MANAGER
7900	JAMES	CLERK	    7698	BLAKE	MANAGER
7654	MARTIN	SALESMAN    7698	BLAKE	MANAGER
7934	MILLER	CLERK	    7782	CLARK	MANAGER
7876	ADAMS	CLERK	    7788	SCOTT	ANALYST
7698	BLAKE	MANAGER	    7839	KING	PRESIDENT
7566	JONES	MANAGER	    7839	KING	PRESIDENT
7782	CLARK	MANAGER	    7839	KING	PRESIDENT
7369	SMITH	CLERK	    7902	FORD	ANALYST
-- �뻧�� KING�� ������ �ʴ´�.
*/





SELECT E1.EMPNO "�����ȣ", E1.ENAME "�����", E1.JOB "������", E1.MGR "�����ڹ�ȣ"
     , E2.ENAME "�����ڸ�", E2.JOB "������������"             --E2.EMPNO �ص� ��
FROM EMP E1 LEFT JOIN EMP E2
ON E1.MGR = E2.EMPNO;
--==>>
/*
7902	FORD	ANALYST	    7566	JONES	MANAGER
7788	SCOTT	ANALYST 	7566	JONES	MANAGER
7900	JAMES	CLERK	    7698	BLAKE	MANAGER
7844	TURNER	SALESMAN	7698	BLAKE	MANAGER
7654	MARTIN	SALESMAN	7698	BLAKE	MANAGER
7521	WARD	SALESMAN	7698	BLAKE	MANAGER
7499	ALLEN	SALESMAN	7698	BLAKE	MANAGER
7934	MILLER	CLERK	    7782	CLARK	MANAGER
7876	ADAMS	CLERK	    7788	SCOTT	ANALYST
7782	CLARK	MANAGER 	7839	KING	PRESIDENT
7698	BLAKE	MANAGER 	7839	KING	PRESIDENT
7566	JONES	MANAGER 	7839	KING	PRESIDENT
7369	SMITH	CLERK	    7902	FORD	ANALYST
7839	KING	PRESIDENT	(null)	(null)	(null)		
*/