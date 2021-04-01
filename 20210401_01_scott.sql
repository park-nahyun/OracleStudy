show user;



---■■■ JOIN(조인) ■■■---

-- 1. SQL 1992 CODE
SELECT *
FROM EMP, DEPT;
--> 수학에서 말하는 데카르트 곱(Catersian Product)
--  두 테이블을 합친(결합한) 모든 경우의 수


-- Equi join : 서로 정확히 일치하는 데이터들끼리 연결시키는 결합
SELECT *
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;
-- DEPTNO 가 10인 것 끼리.. 


SELECT *
FROM EMP E, DEPT D      -- 별칭부여
WHERE E.DEPTNO = D.DEPTNO;


-- Non Equi join : 범위 안에 적합한 데이터들끼리 연결시키는 결합

SELECT *
FROM SALGRADE;
SELECT *
FROM EMP;


SELECT *
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL; --범위
-- 이게 훨씬 더 중요



-- Equi join 시 『+』를 활용한 결합 방법
SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--> 총 14건의 데이터가 결합되어 조회된 상황
--  즉, 부서번호를 갖지 못한 사원들(5인)은 모두 누락~!!!


SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO(+);
-- FROM부터.. TBL_EMP 를 다 퍼올린 다음 D.DEPTNO를 덧붙이는 식이...
--> 총 19건의 데이터가 결합되어 조회된 상황
--  즉, 부서번호 갖지 못한 사원들(5인)도 모두 조회된 상황~!!!


SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;
--> 총 16건의 데이터가 결합되어 조회된 상황
--  즉, 부서에 소속된 사원이 아무도 없는 부서도 모두 조회된 상황
--  부서없는(수지 등) 사람들은 조회 안됐음

--※ (+)가 없는 쪽 테이블의 데이터를 모두 메모리에 적재한 후
--   (+)가 있는 쪽 테이블의 데이터를 하나하나 확인하여 결합시키는 형태로
--   JOIN이 이루어진다


SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO(+);
--> 위와 같은 이유로 이러한 형식의 JOIN 구문은 존재하지 않는다.

-- BUT 이게 불편. WHERE이 결합에 대한 조건인지
-- 결합하고 나서 특정 조건만 보려는 건지 헷갈린다.


-- 2. SQL 1999 CODE → 『JOIN』 키워드 등장 → JOIN 유형 명시
--                      결합 조건은 『WHERE』 대신 『ON』



-- CROSS JOIN
SELECT *
FROM EMP ㄴCROSS JOIN DEPT;
--> 위에서 한 (Catersian Product)와 결과 같다.



-- INNER JOIN
SELECT *
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;
--> Equi join 과 같은 결과

--※ INNER JOIN 시 INNER 는 생략 가능
SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM EMP E JOIN SALGRADE S
ON E.SAL BETWEEN S.LOSAL AND S.HISAL;
--> Equi Join과 Non Equi Join 이 INNER JOIN으로 통합된 상황


-- OUTER JOIN

SELECT *
FROM TBL_EMP E LEFT OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;
-- E가 메인, D를 추가..
-- 주인공인 메인의 방향 알려주고 OUTER JOIN
-- ※ 방향이 지정된 쪽 테이블(→ LEFT)의 데이터를 모두 메모리에 적재한 후
--    방향이 지정되지 않은 쪽 테이블들의 데이터를 각각 확인하여 결합시키는 형태로
--    JOIN 이 이루어진다.

SELECT *
FROM TBL_EMP E RIGHT OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;
-- D가 메인 E가 추가

SELECT *
FROM TBL_EMP E FULL OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;
-- 이제 누가 MAIN 인 지를 따지니까 둘 다 (+) 붙이는 것과 유사한.. 기능 가능..
-- 부서 없는 사원, 사원 없는 부서 둘 다 조회 가능.


--※ OUTER JOIN 에서 OUTER 는 생략 가능
--   BUT 방향 있으므로 구분 가능

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


-- 위의 쿼리문에서 직원만 찾고 싶을 때..

SELECT *
FROM TBL_EMP E JOIN TBL_DEPT D -------INNER
ON E.DEPTNO = D.DEPTNO;
AND JOB = 'CLERK';
-- 이렇게 쿼리문을 구성해도 조회하는데는 문제가 없다.
-- 92 코드라면 선택권 없이 이렇게 해야 함..

SELECT *
FROM TBL_EMP E JOIN TBL_DEPT D -------INNER
ON E.DEPTNO = D.DEPTNO
WHERE JOB = 'CLERK';
-- 하지만, 이와 같이 구성하여 조회할 수 있도록 권장한다.
-- 그게 ON이 탄생한 의도니까..



-----------------------------------------------------------------------


--○ EMP 테이블과 DEPT 테이블을 대상으로
--   직종이 MANAGER 와 CLERK 인 사원들만
--   부서번호, 부서명, 사원명, 직종명, 급여 항목을 조회한다.
--   -------- ------  ------  -----  ----
--   DEPTNO    DNAME   ENAME   JOB   SAL
--   -------- ------  ------  -----  ----
--     E,D       D       E      E      E


SELECT DEPTNO, DNAME, ENAME, JOB, SAL 
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--==>> 에러 발생
/*
ORA-00918: column ambiguously defined
00918. 00000 -  "column ambiguously defined"
*Cause:    
*Action:
183행, 8열에서 오류 발생
*/
--> 두 테이블 간 중복되는 컬럼에 대한 소속 테이블을
--  정해줘야(명시해 줘야) 한다.


SELECT DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--> 두 테이블 간 중복되는 컬럼이 존재하지 않는 조회 구문은
--  에러 발생하지 않는다.
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
-- 중복되는 컬럼만 어디 있는 거 쓰면 되는지 명시 해주면 에러 없음~!
--> 두 테이블 간 중복되는 컬럼에 대해 소속 테이블을 명시하는 경우
--  부서(DEPT), 사원(EMP) 중 어떤 테이블을 지정해도
--  쿼리문 수행에 대한 결과 반환에 문제가 없다.

-- ※ 하지만...
--    두 테이블 간 중복되는 컬럼에 대해 소속 테이블을 명시하는 경우
--    부모 테이블의 컬럼을 참조할 수 있도록 해야 한다.
SELECT *
FROM DEPT;      -- 부모 테이블
SELECT *
FROM EMP;       -- 자식 테이블


-- ※ 부모 자식 테이블 관계를 명확히 정리할 수 있도록 한다.
-- EMP 테이블과 DEPT 테이블이 어떻게 연결되는지 확인 해야 한다.
-- EMP라는 테이블과 DEPT 테이블의 관계에 있어서 연결고리가 되는 것이 DEPTNO


--        DEPTNO
-- EMP ----------- DEPT

-- DEPTNO에는 10번 1개, 20번 1개... EMP는 10번 여러개.. 20번 여러개..
-- 여러 개가 오는 것이 자식~!


-- 부모 테이블 써야하는 이유2
-- OUTER 테이블에서..

SELECT D.DEPTNO, DNAME, ENAME, JOB, SAL 
FROM EMP E LEFT JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT E.DEPTNO, DNAME, ENAME, JOB, SAL 
FROM EMP E LEFT JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;
--------------------------------얘넨 다행히 같게 나오지만

SELECT D.DEPTNO, DNAME, ENAME, JOB, SAL 
FROM EMP E RIGHT JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT E.DEPTNO, DNAME, ENAME, JOB, SAL 
FROM EMP E RIGHT JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;
------------------------------- 여기선 OPERATION의 부서 번호가 누락됨..

-- 소속에 부모 테이블을 써야 할 경우 어떤 최악의 경우라도 값이 나오게 됨..



-- 두 테이블 간 중복되지 않는 컬럼도 소속을 명시하는 것을 권장한다.
-- 소속을 쓰지 않는다면.. 오라클은 EMP, DEPT를 둘 다 방문해서 양쪽에 다 있는 걸 확인하고 명시한다.
-- 테이블을 명시 한다면 한 곳만 들러도 되겠지?


-- 최종 쿼리
SELECT D.DEPTNO "부서번호", D.DNAME "부서명", E.JOB "직종명", E.SAL "급여"
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE JOB IN ('CLERK', 'MANAGER');



--○ SELF JOIN (자기 조인)
-- EMP 테이블의 정보를 다음과 같이 조회할 수 있도록 한다.
---------------------------------------------------------------------
-- 사원번호   사원명   직종명   관리자번호   관리자명   관리자직종명
---------------------------------------------------------------------
-- 7369       SMITH    CLERK      7902                                   ① E1
--                                             FORD       ANALYIST       ② E2
SELECT *
FROM EMP;

SELECT *
FROM JOB;


SELECT E1.EMPNO "사원번호", E1.ENAME "사원명", E1.JOB "직종명", E1.MGR "관리자번호"
     , E2.ENAME "관리자명", E2.JOB "관리자직종명"             --E2.EMPNO 해도 됨
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
-- 대빵인 KING이 나오지 않는다.
*/





SELECT E1.EMPNO "사원번호", E1.ENAME "사원명", E1.JOB "직종명", E1.MGR "관리자번호"
     , E2.ENAME "관리자명", E2.JOB "관리자직종명"             --E2.EMPNO 해도 됨
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