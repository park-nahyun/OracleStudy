SELECT USER
FROM DUAL;
--==>> HR


--○ EMPLOYEES 테이블의 직원들 SALARY 를 10% 인상한다.
--   단, 부서명이 'IT' 인 경우로 한정한다.
--  (변경된 결과를 확인 후 ROLLBACK)


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
-- 롤백 완료


--○ EMPLOYEE 테이블에서 JOB_TITLE 이 『Sales Maneger』인 사원들의
--   SALARY 를 해당 직무(직동)의 최고 급여(MAX_SALARY)로 수정한다.
--   단, 입사일이 2006년 이전(해당 년도 제외) 입사자에 한하여
--   적용할 수 있도록 처리한다.
--   (쿼리문 작성하여 결과 확인 후 ROLLBACK)




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

-- 확인용
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



--○ EMPLOYEES 테이블에서 SALARY 를
--   각 부서의 이름별로 다른 인상률을 적용하여 수정할 수 있도록 한다.
--   Finance → 10%
--   Executive → 15%
--   Accoungting → 20%
--   나머지 → 0%
--   (쿼리문 작성하여 결과 확인 후 ROLLBACK)

SELECT *
FROM DEPARTMENTS;

SELECT *
FROM EMPLOYEES;

UPDATE EMPLOYEES
SET SALARY = CASE DEPARTMENT_ID WHEN ('Finance'의 부서아이디)
                                THEN SALARY * 1.1
                                WHEN ('Executive'의 부서아이디)
                                THEN SALARY * 1.15
                                WHEN ('Accounting'의 부서아이디)
                                THEN SALARY * 1.2
                                ELSE SALARY * 
            END;
-- WHERE문 써도 되고 안 써도 된다.
-- SET에서 조건에 맞는 것만 바꾸면 되니까..
-- 아니면 WHERE에서 선택적으로 퍼올려서 바꾸면 됨..!


-- ('Finance'의 부서아이디)
SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'Finance';
--==>> 100

-- ('Executive'의 부서아이디)
SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'Executive';
--==>> 90        

-- ('Accounting'의 부서아이디)
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
--==>> 107개 행 이(가) 업데이트되었습니다.

-- WHERE 는 적게 퍼올려질수록 좋기 때문에 WHERE 이 있는 것이 낫다.


WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME IN ('Finance', 'Executive', 'Accounting'));
--==>> 11개 행 이(가) 업데이트 되었습니다.
ROLLBACK;



-- ■■■ DELETE ■■■ --

-- 1. 테이블에서 지정된 행(레코드)를 삭제하는 데 사용하는 구문.

-- 2. 형식 및 구조
-- DELETE [FROM] 테이블명
-- [WHERE 조건절];

SELECT *
FROM EMPLOYEES
WHERE EMPLOYEE_ID=198;


DELETE
FROM EMPLOYEES
WHERE EMPLOYEE_ID=198;


ROLLBACK;



--○ EMPLOYEES 테이블에서 직원들의 정보를 삭제한다.
--   단, 부서명이 'IT' 인 경우로 한정한다.

-- ※ 실제로는 EMPLOYEES 테이블의 데이터가(삭제하고자 하는 대상)
--    다른 테이블(혹은 자기 자신 테이블)에 의해 참조당하고 있는 경우
--    삭제되지 않을 수 있다는 사실을 염두해야 하며...
--    그에 대한 이유도 알아야 한다. 


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

--==>> 에러 발생 
/*
ORA-02292: integrity constraint (HR.DEPT_MGR_FK) violated - child record found
*/


-- ■■■ 뷰(VIEW) ■■■ --

-- 1. 뷰(VIEW)란 이미 특정한 데이터베이스 내에 존재하는
--    하나 이상의 테이블에서 사용자가 얻기 원하는 데이터들만을
--    정확하고 편하게 가져오기 위해여 사전에 원하는 컬럼들만 모아서
--    만들어놓은 가상의 테이블로 편의성 및 보안에 목적이 있다.
--    (테이블 내용을 다 보여주는 게 아니니까.., 원본 데이터 이름을 보여주지 않을 수도 있음..)

--    가상의 테이블이란 뷰가 실제로 존재하는 테이블(객체)이 아니라
--    하나 이상의 테이블에서 파생된 또 다른 정보를 볼 수 있는 방법이며
--    그 정보를 추출해내는 SQL 문장이라고 볼 수 있다.

-- 2. 형식 및 구조
--    CREATE [OR REPLACE] VIEW 뷰이름      -- 테이블, 사용자는 OR REPLACE 못들어감
--    [(ALIAS[, ALIAS, ...])]
--    AS
--    서브쿼리(SUBQUERY)
--    [WITH CHECK OPTION]                       
--    [WITH READ ONLY];                    -- 읽기 전용


--○ 뷰(VIEW) 생성
CREATE OR REPLACE VIEW VIEW_EMPLOYEES
AS
SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY, C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
  AND D.LOCATION_ID = L.LOCATION_ID(+)
  AND L.COUNTRY_ID = C.COUNTRY_ID(+)
  AND C.REGION_ID = R.REGION_ID(+);
  
--○ 뷰(VIEW) 조회
SELECT *
FROM VIEW_EMPLOYEES;

--○ 뷰(VIEW) 구조 확인
DESC VIEW_EMPLOYEES;
--==>>
/*

이름              널?       유형           
--------------- -------- ------------ 
FIRST_NAME               VARCHAR2(20) 
LAST_NAME       NOT NULL VARCHAR2(25) 
DEPARTMENT_NAME          VARCHAR2(30) 
CITY                     VARCHAR2(30) 
COUNTRY_NAME             VARCHAR2(40) 
REGION_NAME              VARCHAR2(25) 
*/


--○ 뷰(VIEW) 소스 확인       -- CHECK~!!!
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
  
  -- 결과문 복붙하면 뷰 만든 코드가 그대로 나옴 기억해
*/