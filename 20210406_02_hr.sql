
SELECT USER
FROM DUAL;
--==>> HR


--■■■ 팀별 실습 과제 ■■■--

-- HR 샘플 스키마 ERD 를 이용한 테이블 구성

-- 팀별로... HR 스키마에 있는 기본 테이블(7개)
-- CONTRIES / DEPARTMENTS / EMPLOYEES / JOBS / JOB_HISTORY
-- / LOCATIONS / REGIONS
-- 을 똑같이 새로 구성한다.


-- 단, 생성하는 테이블 이름은 『테이블명+팀번호』
-- COUNTRIES04 / DEPARTMENTS04 / EMPLOYEES04 / JOBS04 / JOB_HISTORY04
-- / LOCATIONS04 / REGIONS04
-- 과 같이 구성한다.


-- 1. 기존 테이블의 정보 수집
-- 2. 테이블 생성(컬럼 이름, 자료형, DEFAULT 표현식, NOT NULL 등...)
--    제약조건 설정(PK, UK, FK, CK, ... NN)
-- 3. 작성 후 데이터 입력(데이터 입력 순서도 유의미 할 것)
-- 4. 제출 항목
--     - 20210406_03_hr_팀별실습과제_4조.sql
--     - 후기_4조.txt
-- 5. 제출 기한
--    금일 오후 17:40 까지


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