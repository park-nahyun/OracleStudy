SELECT USER
FROM DUAL;
--==>> SCOTT


SELECT DEPTNO "부서번호", SUM(SAL) "급여합", GROUPING(DEPTNO)
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);



SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN DEPTNO
            ELSE '모든부서'
       END "부서번호"
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>> 에러남 DEPTNO는 숫자, '모든부서'는 문자
/*
ORA-00932: inconsistent datatypes: expected NUMBER got CHAR
00932. 00000 -  "inconsistent datatypes: expected %s got %s"
*Cause:    
*Action:
13행, 18열에서 오류 발생
*/




SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN TO_CHAR(DEPTNO)
            ELSE '모든부서'
       END "부서번호"
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	    8750
20	    10875
30	    9400
(NULL)	8000
모든부서	37025
*/



SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴')
            ELSE '모든부서'
       END "부서번호"
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	        8750
20	        10875
30	        9400
인턴	        8000
모든부서	    37025
*/



--○ TBL_SAWON 테이블을 다음과 같이 조회될 수 있도록 쿼리문을 구성한다.
/*
---------------------------------------
       성별               급여합
---------------------------------------
        여                XXXXXXX
        남                XXXXXXX
        모든사원          XXXXXXXX
----------------------------------------
*/


-- 내가 한 것(음..)

SELECT *
FROM TBL_SAWON;


SELECT SUM(SAL)
FROM TBL_SAWON
GROUP BY (SUBSTR(JUBUN 7, 1)); -- 안됨


SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여자'
            WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남자'
       ELSE '성별 없음'
       END "성별"
     , SAL "급여"
FROM TBL_SAWON;



SELECT CASE GROUPING(T.성별) WHEN 1 THEN '모든사원'
       ELSE T.성별 END "성별"
     , SUM(T.급여)
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여자'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남자'
           ELSE '성별 없음'
           END "성별"
         , SAL "급여"
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.성별);
--==>>
/*
남자  	12000
여자	    24100
모든사원	36100
*/


-- 함께 풀이


SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여자'
            WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남자'
       ELSE '확인 불가'
       END "성별"
     , SAL "급여"
FROM TBL_SAWON;




SELECT *
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여자'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남자'
           ELSE '확인 불가'
           END "성별"
         , SAL "급여"
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.성별);



SELECT T.성별 "성별"
     , SUM(T.급여)"급여합"
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여자'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남자'
           ELSE '성별 없음'
           END "성별"
         , SAL "급여"
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.성별);
--==>>
/*
남자	    12000
여자	    24100
NULL	36100
*/


SELECT CASE GROUPING(T.성별) WHEN 1 THEN '모든사원'
                             WHEN 0 THEN T.성별
       ELSE '확인불가' END "성별"
     , SUM(T.급여)
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여자'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남자'
           ELSE '성별 없음'
           END "성별"
         , SAL "급여"
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.성별);
--==>>
/*
남자	        12000
여자	        24100
모든사원	    36100
*/


SELECT *
FROM VIEW_SAWON;



--○ TBL_SAWON 테이블을 다음과 같이 연령대별 인원수 형태로
--   조회할 수 있도록 쿼리문을 구성한다.
/*
--------------------------------
      연령대         인원수
--------------------------------
        10              X
        20              X
        30              X
        40              X
        50              X
       전체             XX
----------------------------------
*/


-- 천재인 나의 풀이
-- 방법① (INLINE VIEW 를 두 번 중첩~!!!) 과 비슷해서 같이 필기..

SELECT *
FROM TBL_SAWON;


-- 나이 계산
SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 2000) + 1
            WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1900) + 1
       ELSE -1 
       END "나이"
FROM TBL_SAWON;



-- 연령대 계산
SELECT CASE SUBSTR(TO_CHAR(T.나이), 1, 1) WHEN '1' THEN '10'
                                 WHEN '2' THEN '20'
                                 WHEN '3' THEN '30'
                                 WHEN '4' THEN '40'
                                 WHEN '5' THEN '50'
       ELSE '빠꾸'
       END "연령대"
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 2000) + 1
                WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1900) + 1
           ELSE -1 
           END "나이"
    FROM TBL_SAWON
) T;


SELECT CASE WHEN GROUPING(S.연령대) = 1 THEN '전체'
            WHEN GROUPING(S.연령대) = 0 THEN S.연령대
       ELSE '나가'
       END "연령대"
     , COUNT(S.연령대) "인원수"
FROM
(
    SELECT CASE SUBSTR(TO_CHAR(T.나이), 1, 1) WHEN '1' THEN '10'
                                     WHEN '2' THEN '20'
                                     WHEN '3' THEN '30'
                                     WHEN '4' THEN '40'
                                     WHEN '5' THEN '50'
           ELSE '빠꾸'
           END "연령대" -- SUBSTR 쓰지 말고 다시...
    FROM
    (
        SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 2000) + 1
                    WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1900) + 1
               ELSE -1 
               END "나이"
        FROM TBL_SAWON
    ) T
) S
GROUP BY ROLLUP(S.연령대)
ORDER BY 1 ASC
--==>>
/*
10	2
20	11
40	1
50	2
전체	16
*/



-- 방법② (INLINE VIEW 를 한 번만 사용~!!!)

SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 2000) + 1
            WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1900) + 1
       ELSE -1 
       END "나이"
FROM TBL_SAWON;

SELECT TRUNC(28, -1) "확인" -- 절삭~~!! 10의 자리까지~~ 배웠으면 좀 써라 써~~!!!
FROM DUAL;


-- 직접 해 볼 것
SELECT CASE WHEN GROUPING(S.연령대) = 1 THEN '전체'
            WHEN GROUPING(S.연령대) = 0 THEN S.연령대
       ELSE '나가'
       END "연령대"
     , COUNT(S.연령대) "인원수"
FROM
(
  SELECT  TRUNC(CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 2000) + 1
                    WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1900) + 1
               ELSE -1 
               END, -1) "연령대"
 FROM TBL_SAWON;
) S



--○ ROLLUP 활용 및 CUBE

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY DEPTNO, JOB -- 부서 번호끼리, 직종끼리 묶어
ORDER BY 1,2;  
--==>> 
/*
10	CLERK	    1300    -- 10번 안에서 CLERK끼리 모여라~ 
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
GROUP BY ROLLUP(DEPTNO, JOB) -- 부서 번호끼리, 직종끼리 묶어
ORDER BY 1,2; 
--==>>
/*
10	    CLERK   	1300
10	    MANAGER	    2450
10	    PRESIDENT	5000
10	    (NULL)	    8750    -- 10번 부서 모든 직종의 급여합
20	    ANALYST	    6000
20  	CLERK	    1900
20	    MANAGER	    2975
20	    (NULL)  	10875   -- 20번 부서 모든 직종의 급여합
30	    CLERK	    950
30	    MANAGER	    2850
30	    SALESMAN	5600
30	    (NULL)  	9400    -- 30번 부서 모든 직종의 급여합
(NULL)	(NULL)	    29025   -- 모든 부서 모든 직종의 급여합
*/

--○ CUBE → ROLLUP() 보다 더 자세한 결과를 반환받을 수 있다.
SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB) -- 부서 번호끼리, 직종끼리 묶어
ORDER BY 1,2; 
--==>>
/*
10	    CLERK	    1300
10	    MANAGER	    2450
10	    PRESIDENT	5000
10	    (NULL)	    8750        -- 10번 부서 모든 직종의 급여합
20	    ANALYST 	6000
20	    CLERK	    1900
20	    MANAGER	    2975
20	    (NULL)	    10875       -- 20번 부서 모든 직종의 급여합
30	    CLERK	    950
30	    MANAGER	    2850
30	    SALESMAN	5600
30	    (NULL)	    9400        -- 30번 부서 모든 직종의 급여합
(NULL)	ANALYST	    6000        -- 모든 부서 모든 직종의 급여합
(NULL)	CLERK	    4150        -- 모든 부서 모든 직종의 급여합
(NULL)	MANAGER	    8275        -- 모든 부서 모든 직종의 급여합
(NULL)	PRESIDENT	5000        -- 모든 부서 모든 직종의 급여합
(NULL)	SALESMAN	5600        -- 모든 부서 모든 직종의 급여합
(NULL)	(NULL)  	29025       -- 모든 부서 모든 직종의 급여합
*/



--※ ROLLUP() 과 CUBE() 는
--   그룹을 묶어주는 방식이 다르다.(차이)


-- ROLLUP(A, B, C)
-- → (A, B, C) / (A, B) / (A) / ()

-- CUBE(A, B, C)
-- → (A, B, C) / (A, B) / (A, C) / (B, C) / (A) / (B) / (C) / ()

--==>> 위의 처리 내용은 원하는 결과를 얻지 못하거나 너무 많은 결과물이 출력되기 때문에
--    다음의 쿼리 형태를 더 많이 사용한다.


SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴')
       ELSE '전체부서'
       END "부서번호"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
       ELSE '전체직종'
       END "직종" 
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY 1,2;
--==>>
/*
10  	CLERK	    1300
10  	MANAGER	    2450
10  	PRESIDENT	5000
10  	전체직종	    8750
20  	ANALYST	    6000
20  	CLERK	    1900
20  	MANAGER	    2975
20	    전체직종	    10875
30  	CLERK	    950
30  	MANAGER	    2850
30	    SALESMAN	5600
30  	전체직종	    9400
인턴	    CLERK	    2500
인턴	    SALESMAN	5500
인턴	    전체직종    	8000
전체부서	전체직종	    37025
*/


SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴')
       ELSE '전체부서'
       END "부서번호"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
       ELSE '전체직종'
       END "직종" 
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1,2;
--==>>
/*
10	        CLERK	    1300
10	        MANAGER	    2450
10	        PRESIDENT	5000
10	        전체직종    	8750
20	        ANALYST	    6000
20	        CLERK	    1900
20	        MANAGER	    2975
20	        전체직종    	10875
30	        CLERK	    950
30	        MANAGER	    2850
30	        SALESMAN	5600
30	        전체직종	    9400
인턴	        CLERK	    2500
인턴	        SALESMAN	5500
인턴  	    전체직종	    8000
전체부서    	ANALYST 	6000
전체부서    	CLERK	    6650
전체부서    	MANAGER	    8275
전체부서    	PRESIDENT	5000
전체부서    	SALESMAN	11100
전체부서    	전체직종    	37025
*/


SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴')
       ELSE '전체부서'
       END "부서번호"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
       ELSE '전체직종'
       END "직종" 
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO, JOB), (DEPTNO), ()) -- ROLLUP과 결과값이 같다
ORDER BY 1,2;
--==>>
/*
10	CLERK	1300
10	MANAGER	2450
10	PRESIDENT	5000
10	전체직종	8750
20	ANALYST	6000
20	CLERK	1900
20	MANAGER	2975
20	전체직종	10875
30	CLERK	950
30	MANAGER	2850
30	SALESMAN	5600
30	전체직종	9400
인턴	CLERK	2500
인턴	SALESMAN	5500
인턴	전체직종	8000
전체부서	전체직종	37025
*/

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴')
       ELSE '전체부서'
       END "부서번호"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
       ELSE '전체직종'
       END "직종" 
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO, JOB), (DEPTNO), (JOB), ()) -- CUBE 결과값이 같다
ORDER BY 1,2;
--==>>
/*
10	CLERK	1300
10	MANAGER	2450
10	PRESIDENT	5000
10	전체직종	8750
20	ANALYST	6000
20	CLERK	1900
20	MANAGER	2975
20	전체직종	10875
30	CLERK	950
30	MANAGER	2850
30	SALESMAN	5600
30	전체직종	9400
인턴	CLERK	2500
인턴	SALESMAN	5500
인턴	전체직종	8000
전체부서	ANALYST	6000
전체부서	CLERK	6650
전체부서	MANAGER	8275
전체부서	PRESIDENT	5000
전체부서	SALESMAN	11100
전체부서	전체직종	37025
*/


ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--○ TBL_EMP  테이블에서 입사년도별 인원수를 조회한다.

SELECT *
FROM TBL_EMP
ORDER BY HIREDATE;

/*
-------------------------------
    입사년도         인원수
-------------------------------
    1980                1
    1981               10
    1982                1
    1987                2
    2021                5
    전체               19
--------------------------------
*/


-- 인원 수 조회
SELECT EXTRACT(YEAR FROM HIREDATE)"입사년도"
FROM TBL_EMP;


--

SELECT CASE WHEN GROUPING(T.입사년도) = 1 THEN '전체'
            ELSE TO_CHAR(T.입사년도)
       END "입사년도"
     , COUNT(T.입사년도)
FROM
(
    SELECT EXTRACT(YEAR FROM HIREDATE)"입사년도"
    FROM TBL_EMP
) T
GROUP BY ROLLUP(T.입사년도)
ORDER BY 1;
--==>>
/*
1980	1
1981	10
1982	1
1987	2
2021	5
전체  	19
*/



SELECT CASE WHEN GROUPING(T.입사년도) = 1 THEN '전체'
            ELSE TO_CHAR(T.입사년도)
       END "입사년도"
     , COUNT(T.입사년도)
FROM
(
    SELECT EXTRACT(YEAR FROM HIREDATE)"입사년도"
    FROM TBL_EMP
) T
GROUP BY CUBE(T.입사년도)
ORDER BY 1;



SELECT CASE WHEN GROUPING(T.입사년도) = 1 THEN '전체'
            ELSE TO_CHAR(T.입사년도)
       END "입사년도"
     , COUNT(T.입사년도)
FROM
(
    SELECT EXTRACT(YEAR FROM HIREDATE)"입사년도"
    FROM TBL_EMP
) T
GROUP BY GROUPING SETS(입사년도, ())
ORDER BY 1;



-- 주의해서 볼 것
SELECT EXTRACT(YEAR FROM HIREDATE) "입사년도"
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

SELECT EXTRACT(YEAR FROM HIREDATE) "입사년도"
     , COUNT(*)
FROM TBL_EMP
GROUP BY CUBE(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;


SELECT EXTRACT(YEAR FROM HIREDATE) "입사년도"
     , COUNT(*)
FROM TBL_EMP
GROUP BY GROUPING SETS((EXTRACT(YEAR FROM HIREDATE)), ())
ORDER BY 1;


--※ 여기가 주의
SELECT EXTRACT(YEAR FROM HIREDATE) "입사년도"
     , COUNT(*)
FROM TBL_EMP
GROUP BY ROLLUP(TO_CHAR(HIREDATE, 'YYYY')) -- 문자로 묶으면 에러 / CUBE, GROUPSET도 마찬가지
ORDER BY 1;
--==>> 에러 발생
/*
ORA-00979: not a GROUP BY expression
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
643행, 26열에서 오류 발생
*/

SELECT TO_CHAR(HIREDATE, 'YYYY') "입사년도"
     , COUNT(*)
FROM TBL_EMP
GROUP BY ROLLUP(TO_CHAR(HIREDATE, 'YYYY')) -- 문자로 묶으면 에러 / CUBE, GROUPSET도 마찬가지
ORDER BY 1;
-- SELECT 구문에서 쓴 자료형과 GROUP BY의 자료형이 일치해야 한다.
-- SELECT는 그룹바이가 묶어놓은거를 쓰기 때문에..!!


---------------------------------------------------------------------
--■■■ HAVING ■■■--

--○ EMP 테이블에서 부서번호가 20, 30인 부서를 대상으로
--   부서의 총 급여가 10000 보다 적을 경우만 부서별로 총 급여를 조회한다.

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
--==>> 예.. 에러납니다..
/*
ORA-00934: group function is not allowed here (SUM, WHERE절)
00934. 00000 -  "group function is not allowed here"
*Cause:    
*Action:
684행, 11열에서 오류 발생
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
-- WHERE 없이 HAVING에 다 넣어도 되긴하지만 비추..
-- 파싱 순서..! FROM 다음 WHERE 조건절을 1차적으로 메모리에 퍼올림
-- WHERE이 없으면 EMP 테이블 전체를 퍼올림.. 효율ㄴ

--------------------------------------------------------------

--■■■ 중첩 그룹함수 / 분석함수 ■■■--

-- 그룹 함수 2 LEVEL 까지 중첩해서 사용할 수 있다.
-- 이 마저도 MS-SQL 은 불가능하다.
SELECT MAX(SUM(SAL))
FROM EMP
GROUP BY DEPTNO;
--==>> 10875

-- RANK()
-- DENSE_RANK()
--> 함수 안에서 정렬해야 해서 리소스 소모가 심하다
--  ORACLE 9i 부터 적용.. MSSQL 2005부터 적용..

--※ 하위 버전에서는 RANK()나 DENSE_RANK()를 사용할 수 없기 때문에
--   이를 대체하여 연산을 수행할 수 있는 방법을 강구해야 한다.

-- 예를 들어, 급여의 순위를 구하고자 한다면...
-- 해당 사원의 급여보다 더 큰 값이 몇 개인지 확인한 후
-- 그 확인한 숫자에 +1 을 추가 연산해주면 그것이 곳 등수가 된다.


SELECT ENAME, SAL, 1
FROM EMP;

SELECT COUNT(*) + 1
FROM EMP
WHERE SAL > 800;
-- 스미스보다 SAL이 큰 사람이 몇 명이냐?
--==>> 스미스의 급여 등수


SELECT COUNT(*) + 1
FROM EMP
WHERE SAL > 1600;   -- ALLEN 의 급여
--==>> 7 → ALLEN 의 급여 등수




--※ 서브 상관 쿼리 (상관 서브 쿼리)
--   메인 쿼리에 있는 테이블의 컬럼이
--   서브 퀴리의 조건절(WHERE절, HAVING절)에 사용되는 경우,
--   우리는 이 쿼리문을 서브 상관 쿼리 라고 부른다.

SELECT ENAME "사원명", SAL "급여", 1 "급여등수"
FROM EMP;


SELECT ENAME "사원명", SAL "급여", (1) "급여등수"
FROM EMP;


SELECT ENAME "사원명", SAL "급여"
    , (SELECT COUNT(*) + 1
        FROM EMP 
        WHERE SAL > 800)  "급여등수"                           
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


SELECT ENAME "사원명", SAL "급여"
    , (SELECT COUNT(*) + 1
        FROM EMP E2
        WHERE E2.SAL > E1.SAL)  "급여등수"                           
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
-- 서열 처리는 힘들지 않을까.. 서브 쿼리를 한 번 더 써서 해야할 듯..!
*/




--○ EMP 테이블을 대상으로
--   사원명, 급여, 부서번호, 부서내급여등수, 전체급여등수 항목을 조회한다.
--   단, RANK() 함수를 사용하지 않고 서브 상관 쿼리를 활용할 수 있도록 한다.


-- 부서 급여 등수


SELECT ENAME "사원명", SAL "급여"
       , CASE WHEN DEPTNO IS NULL THEN '인턴' ELSE TO_CHAR(DEPTNO) END "부서번호"
FROM TBL_EMP;

SELECT ENAME "사원명", SAL "급여"
      
      , (SELECT COUNT(*) + 1
        FROM TBL_EMP E2
        WHERE E2.SAL > E1.SAL) "전체급여등수"
      , (SELECT COUNT(*) + 1
        FROM TBL_EMP E2
        WHERE E2.SAL > E1.SAL  AND E1.DEPTNO = E2.DEPTNO) "부서내급여등수"
FROM 
(
    SELECT ENAME "사원명", SAL "급여"
           , CASE WHEN DEPTNO IS NULL THEN '인턴' ELSE TO_CHAR(DEPTNO) END "부서번호"
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
수지	    1500	    10	1
아이유	1000		16	1
정유미	2000		8	1
이제훈	2500		6	1
한지민	1000		16	1
*/


-- 같이 풀기

SELECT ENAME "사원명"
     , SAL "급여"
     , DEPTNO "부서번호"
     , (SELECT COUNT(*) + 1
        FROM EMP E2
        WHERE E2.DEPTNO = E1.DEPTNO AND E2.SAL > E1.SAL) "부서내급여등수"
     , (SELECT COUNT(*) + 1
         FROM EMP E2
         WHERE E2.SAL > E1.SAL) "전체급여등수"
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

--○ EMP 테이블을 대상으로 다음과 같이 조회할 수 있도록 쿼리문을 구성한다.
/*
----------------------------------------------------------------------
    사원명     부서번호       입사일      급여       부서내입사별급여누적
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

SELECT SAL "부서내입사별급여누적"
FROM EMP
ORDER BY DEPTNO, HIREDATE;



SELECT ENAME "사원명", DEPTNO "부서번호", HIREDATE "입사일", SAL "급여"
    , (SELECT SUM(E2.SAL)
        FROM EMP E2
        WHERE E1.HIREDATE >= E2.HIREDATE 
        AND E2.DEPTNO = E1.DEPTNO) "부서내"
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



SELECT ENAME "사원명", DEPTNO "부서번호", HIREDATE "입사일", SAL "급여"
    , 1 "부서내입사별급여누적"
FROM EMP
ORDER BY 2, 3;



SELECT ENAME "사원명", DEPTNO "부서번호", HIREDATE "입사일", SAL "급여"
    , (1) "부서내입사별급여누적"
FROM EMP
ORDER BY 2, 3;



SELECT E1.ENAME "사원명", E1.DEPTNO "부서번호", E1.HIREDATE "입사일", E1.SAL "급여"
    , (SELECT SUM(E2.SAL)
         FROM EMP E2) "부서내입사별급여누적"  
FROM EMP E1
ORDER BY 2, 3;



SELECT E1.ENAME "사원명", E1.DEPTNO "부서번호", E1.HIREDATE "입사일", E1.SAL "급여"
    , (SELECT SUM(E2.SAL)
       FROM EMP E2
       WHERE E2.DEPTNO = E1.DEPTNO
         AND E2.HIREDATE <= E1.HIREDATE) "부서내입사별급여누적"  
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


--○ TBL_EMP 테이블에서 입사한 사원의 수가 제일 많았을 때의 
--   입사년월과 인원수를 조회할 수 있는 쿼리문을 구성한다.
/*
--------------------------
    입사년월       인원수
--------------------------
   XXXX-XX        XX
---------------------------
*/

-- 꼭꼭 다시 볼 것

SELECT *
FROM TBL_EMP;

SELECT SUM(COUNT(HIREDATE))
FROM TBL_EMP E2
GROUP BY E2.HIREDATE;

-- 입사일마다 몇 명 입사했는지
SELECT E1.HIREDATE,
       (SELECT SUM(COUNT(*))
        FROM TBL_EMP E2
        WHERE TO_CHAR(E1.HIREDATE, 'YYYY-MM-DD') = TO_CHAR(E2.HIREDATE, 'YYYY-MM-DD')
        GROUP BY E2.HIREDATE) "몇명입사"
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
        GROUP BY E2.HIREDATE) "해당날짜입사인원"
FROM TBL_EMP E1
GROUP BY E1.HIREDATE;
--==>>

 SELECT SUM(COUNT(*))
    FROM TBL_EMP E2
    WHERE TO_CHAR(E1.HIREDATE, 'YYYY-MM') = TO_CHAR(E2.HIREDATE, 'YYYY-MM')
    GROUP BY E2.HIREDATE; "해당날짜입사인원"

SELECT MAX(T.HIREDATE), MAX(T.해당날짜입사인원)
FROM 
    (SELECT HIREDATE, 
           (SELECT SUM(COUNT(*))
            FROM TBL_EMP E2
            WHERE TO_CHAR(E1.HIREDATE, 'YYYY-MM') = TO_CHAR(E2.HIREDATE, 'YYYY-MM')
            GROUP BY E2.HIREDATE) "해당날짜입사인원"
    FROM TBL_EMP E1
    GROUP BY E1.HIREDATE
) T;




-- 같이 풀이..



SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "입사년월"
      , COUNT(*) "인원수"
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


SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "입사년월"
      , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) = 5;
--==>> 2021-03	5


SELECT COUNT(*) "인원수"
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


SELECT MAX(COUNT(*)) "인원수"
FROM TBL_EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM');



SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "입사년월"
      , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) = (SELECT MAX(COUNT(*)) 
                  FROM TBL_EMP
                  GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM'));
--==>> 2021-03	5



------------------------------------------------------------------------

--■■■ ROW_NUMBER() ■■■--

SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) "관찰"
     , ENAME "사원명", SAL "급여", HIREDATE "입사일"
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


--※ 게시판의 게시물 번호를
--   SEQUENCE 나 IDENTITY 를 사용하게 되면
--   게시물을 삭제했을 경우, 삭제한 게시물의 자리에
--   다음 번호를 가진 게시물이 등록되는 상황이 발생하게 된다.
--   이는, 보안 측변에서나... 미관상... 바람직하지 않은 상황일 수 있기 때문에
--   ROW_NUMBER() 의 사용을 고려해 볼 수 있다.
--   관리의 목적으로 사용할 때에는 SEQUENCE 나 IDENTITY를 사용하지만
--   단순히 게시물을 목록화하여 사용자에게 리스트 형식으로 보여줄 때에는
--   사용하지 않는 것이 좋다.


--※ 관찰
CREATE TABLE TBL_AAA
( NO    NUMBER
, NAME  VARCHAR2(40)
, GRADE CHAR
);
--==> Table TBL_AAA이(가) 생성되었습니다.


INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(1, '선혜연', 'A');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(2, '이상화', 'B');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(3, '선혜연', 'A');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(4, '박민지', 'C');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(5, '이상화', 'A');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(6, '한혜림', 'B');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(7, '한혜림', 'B');
--==>> 1 행 이(가) 삽입되었습니다. *7


COMMIT;
--==>> 커밋 완료

SELECT *
FROM TBL_AAA;
-==>>
/*
1	선혜연	A
1	선혜연	A
2	이상화	B
3	선혜연	A
4	박민지	C
5	이상화	A
6	한혜림	B
7	한혜림	B

-- 동명이인이 있을 수 있고 성적도 같다. 둘을 어떻게 구분?
*/

UPDATE TBL_AAA
SET GRADE = 'A'
WHERE NAME = '이상화' AND GRADE = 'B';
-- 성적B인 이상화 성적을 A로 바꾸려면?
--==>> 1 행 이(가) 업데이트되었습니다.

COMMIT;

SELECT *
FROM TBL_AAA;
-- 이제 상화도 구분 안되게 됨.
/*
1	선혜연	A
1	선혜연	A
2	이상화	A
3	선혜연	A
4	박민지	C
5	이상화	A
6	한혜림	B
7	한혜림	B
*/
-- BUT NO 번호를 사용하면 구분 가능하겠지?
-- SEQUENCE와 IDENTITY는 데이터적으로 쓰는 건 아니지만..
-- 식별용으로 필요함..!



--○ SEQUENCE 생성 (시퀀스, 주문번호)
--   → 사전적인 의미 : 1.(일련의) 연속적인 사건들 2.(사건, 행동 등의) 순서
--                       은행 번호표처럼 툭 치면 번호 나옴.. 겹치는 거 없음


CREATE SEQUENCE SEQ_BOARD -- 시퀀스 기본 생성 구문(MSSQL 의 IDENTITY와 동일한 개념)
START WITH 1              -- 시작값
INCREMENT BY 1            -- 증가값
NOMAXVALUE                -- 최대값 제한 없음
NOCACHE;                 -- 캐시 사용 안함(없음). 임시 저장 안한다. // 트래픽, 요정 사항이 많을 때 발행해서.. 나눠서 처리.... 맛집에서 번호표 받기 위한 줄을 또 서는 거 마냥..
--==>> Sequence SEQ_BOARD이(가) 생성되었습니다.
-- 첫째줄만 써도 시퀀스 만들어짐. 나머지는 옵션. 
-- 1부터 시작해서 1씩 증가, 맥스 밸류 없고 캐시 설정.(기본)


--○ 테이블 생성(TBL_BOARD)
CREATE TABLE TBL_BOARD           -- TBL_BOARD 이름 → 게시판
( NO        NUMBER               -- 게시물 번호      X  사용자가 직접 입력하나
, TITLE     VARCHAR2(50)         -- 게시물 제목      ○
, CONTENTS  VARCHAR2(2000)       -- 게시물 내용      ○
, NAME      VARCHAR2(20)         -- 게시물 작성자    △ 
, PW        VARCHAR2(20)         -- 게시물 패스워드  △ 
, CREATED   DATE DEFAULT SYSDATE -- 게시물 작성일    X
);
--==>> Table TBL_BOARD이(가) 생성되었습니다.

--○ 데이터 입력 → 게시판에 게시물 작성
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '앗싸~1등', '내가 1등이지롱~', '선혜연', 'JAVA006$', DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '건강관리', '다들 건강 챙깁시당', '이상화', 'JAVA006$', DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '오늘은', '저녁 뭐 먹지...', '박민지', 'JAVA006$', DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.


INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '오늘은', '미세먼지 없나?', '한혜림', 'JAVA006$', DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '공부하고싶은데', '집이너무멀어요', '김아별', 'JAVA006$', DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '질문있습니다', '쉬었다 하면 안되나요', '이유림', 'JAVA006$', DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '질문있습니다', '생각나면 다시 질문할게요', '이희주', 'JAVA006$', DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.

--○ 확인
SELECT *
FROM TBL_BOARD;
--==>>
/*
1	앗싸~1등	내가 1등이지롱~	            선혜연	JAVA006$	21/03/31
2	건강관리	다들 건강 챙깁시당      	    이상화	JAVA006$	21/03/31
3	오늘은	저녁 뭐 먹지...          	박민지	JAVA006$	21/03/31
4	오늘은	미세먼지 없나?	            한혜림	JAVA006$	21/03/31
5	공부하고싶은데	집이너무멀어요	    김아별	JAVA006$	21/03/31
6	질문있습니다	쉬었다 하면 안되나요 	이유림	JAVA006$	21/03/31
7	질문있습니다	생각나면 다시 질문할게요	이희주	JAVA006$	21/03/31
*/

--○ 커밋
COMMIT;
--==>> 커밋 완료.

 
--○ 게시물 삭제
DELETE
FROM TBL_BOARD
WHERE NO=4;
--==>> 1 행 이(가) 삭제되었습니다.


--○ 게시물 작성
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '졸려요', '전 그냥 잘래요', '이새롬', 'JAVA006$', DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.


--○ 게시물 삭제
DELETE
FROM TBL_BOARD
WHERE NO=8;
--==>> 1 행 이(가) 삭제되었습니다.


--○ 게시물 작성
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '저는요', '잘 지내고 있습니다', '장서현', 'JAVA006$', DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.

--○ 커밋
COMMIT;
--==>>

--○ 확인
SELECT *
FROM TBL_BOARD;
--==>>
/*
1	앗싸~1등	내가 1등이지롱~	            선혜연	JAVA006$	21/03/31
3	오늘은	저녁 뭐 먹지...          	박민지	JAVA006$	21/03/31
5	공부하고싶은데	집이너무멀어요	    김아별	JAVA006$	21/03/31
6	질문있습니다	쉬었다 하면 안되나요	    이유림	JAVA006$	21/03/31
7	질문있습니다	생각나면 다시 질문할게요	이희주	JAVA006$	21/03/31
9	저는요	잘 지내고 있습니다	        장서현	JAVA006$	21/03/31
-- 보기 안좋고.. 보안상 별로...
*/

SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "글번호"
     , TITLE "제목", NAME "작성자", CREATED "작성일"
FROM TBL_BOARD
ORDER BY 4 DESC;
--==>>
/*
6	저는요	        장서현	21/03/31
5	질문있습니다	    이희주	21/03/31
4	질문있습니다	    이유림	21/03/31
3	공부하고싶은데	김아별	21/03/31
2	오늘은	        박민지	21/03/31
1	앗싸~1등	        선혜연	21/03/31
-- 최신 글이 위에 오게 '보이도록' 하는 것..!
*/


--○ 게시물 작성
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '외로워도', '슬퍼도 나는 안울어', '박정준', 'JAVA006$', DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.


SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "글번호"
     , TITLE "제목", NAME "작성자", CREATED "작성일"
FROM TBL_BOARD
ORDER BY 4 DESC;
--==>>
/*
7	외로워도        	박정준	21/03/31
6	저는요	        장서현	21/03/31
5	질문있습니다  	이희주	21/03/31
4	질문있습니다  	이유림	21/03/31
3	공부하고싶은데	김아별	21/03/31
2	오늘은	        박민지	21/03/31
1	앗싸~1등	        선혜연	21/03/31
*/

--○ 게시물 삭제
DELETE
FROM TBL_BOARD
WHERE NO=7; -- 정준이가 쓴게 아니고.. 저장되어있는 번호가 지워짐


--○ 커밋
COMMIT;
--==>> 커밋 완료


SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "글번호"
     , TITLE "제목", NAME "작성자", CREATED "작성일"
FROM TBL_BOARD
ORDER BY 4 DESC;
--==>>
/*
6	외로워도	        박정준	21/03/31
5	저는요	        장서현	21/03/31
4	질문있습니다  	이유림	21/03/31
3	공부하고싶은데	김아별	21/03/31
2	오늘은	        박민지	21/03/31
1	앗싸~1등	        선혜연	21/03/31
*/

-------------------------------------------------------------------------------

--■■■ JOIN(조인) ■■■--
SELECT * 
FROM EMP;

SELECT *
FROM DEPT;

SELECT *
FROM SALGRADE;

스미스 800 1981-07-06 CLERK 20 연구부 달라스 1등급

이렇게 한번에 볼 수 있는 걸 왜 쪼갰을까?;


SELECT EMPNO, ENAME, JOB
FROM EMP
WHERE EMPNO=7369;

SELECT EMPNO, ENAME, JOB, HIREDATE, SAL, COMM
FROM EMP;

SELECT EMPNO
FROM EMP;

-- 퍼올리는 메모리 : 1번은 가장 적고 2번, 3번은 같다
-- 하나를 찾든 여러개를 찾든.. 하나를 퍼올리는건.. 비효율적이다..
