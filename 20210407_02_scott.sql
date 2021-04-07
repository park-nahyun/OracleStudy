
SELECT USER
FROM DUAL;
--==>> SCOTT


--■■■ UPDATE ■■■--

-- 1. 테이블에서 기존 데이터를 변경하는 구문.

-- 2. 형식 및 구조
-- UPDATE 테이블명
-- SET 컬럼명=변경할 값[, 컬럼명=변경할 값, ....]
-- [WHERE 조건절]


SELECT *
FROM TBL_SAWON;


ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.


--○ TBL_SAWON 테이블에서 사원번호 1003번 사원의
--   주민번호를 『8303082234567』 로 수정한다.


UPDATE TBL_SAWON
SET JUBUN='8303082234567'
WHERE SANO=1003;


-- 실행 후 COMMIT 또는 ROLLBACK 을 반드시 선택적으로 실행
COMMIT;
--==>> 커밋 완


--○ TBL_SAWON 테이블에서 1005 사원의 입사일과 급여를
--   각각 2018-02-22, 2200 으로 변경한다.
UPDATE TBL_SAWON
SET HIREDATE= TO_DATE('2018-02-22', 'YYYY-MM-DD'), SAL=2200
WHERE SANO=1005;
--==>> 1 행 이(가) 업데이트되었습니다.



--확인
SELECT *
FROM TBL_SAWON;


-- 실행 후 COMMIT 또는 ROLLBACK 을 반드시 선택적으로 실행
COMMIT;
--==>> 커밋 완


--○ TBL_INSA 테이블 복사(데이터만)
CREATE TABLE TBL_INSABACKUP
AS
SELECT *
FROM TBL_INSA;
--==>> Table TBL_INSABACKUP이(가) 생성되었습니다.

SELECT *
FROM TBL_INSA;


--○ TBL_INSABACKUP 테이블에서
--   직위가 과장과 부장만 수당 10% 인상~!!!
UPDATE TBL_INSABACKUP
SET SUDANG=1.1*SUDANG
WHERE JIKWI IN ('부장', '과장');
--==>>15개 행 이(가) 업데이트되었습니다.


-- 확인
SELECT *
FROM TBL_INSABACKUP;

COMMIT;
--==>> 커밋 완.


--○ TBL_INSABACKUP 테이블에서 전화번호가 016, 017, 018, 019 로 시작하는
--   전화번호인 경우 이를 모두 010 으로 변경한다.
UPDATE TBL_INSABACKUP
SET TEL= '010' || SUBSTR(TEL, 4)  
WHERE SUBSTR(TEL, 1, 3) IN ('016', '017', '018', '019');
--==>> 24개 행 이(가) 업데이트되었습니다.

-- 확인
SELECT *
FROM TBL_INSABACKUP;

COMMIT;
--==>> 커밋 완.



--○ TBL_SAWON 테이블 백업
CREATE TABLE TBL_SAWONBACKUP
AS
SELECT *
FROM TBL_SAWON;
--==>> Table TBL_SAWONBACKUP이(가) 생성되었습니다.
--> TBL_SAWON 테이블의 데이터들만 백업을 수행
-- 즉, 다른 이름의 테이블 형태로 저장해 둔 상황

--○ 확인
SELECT *
FROM TBL_SAWONBACKUP;
SELECT *
FROM TBL_SAWON;


--○ 데이터 변경
UPDATE TBL_SAWON
SET SANAME = '이무림';

SELECT *
FROM TBL_SAWON;

COMMIT;

--위와 같이 UPDATE 처리 이후에 COMMIT을 수행하였기 때문에
--ROLLBACK은 불가능한 상황이다.
--하지만, TBL_SAWONBACKUP 테이블에 데이터를 백업해두었다.
--SANAME 컬럼의 내용만 추출하여 '이무림' 대신 넣어줄 수 있다는 것이다.

UPDATE TBL_SAWON
SET SANAME = (SELECT SANAME
              FROM TBL_SAWONBACKUP
              WHERE SANO = TBL_SAWON.SANO);
              
SELECT *
FROM TBL_SAWON;

COMMIT;

UPDATE TBL_SAWON
SET SANAME='김가영'
WHERE SANO=1001;

UPDATE TBL_SAWON
SET SANAME='김서현'
WHERE SANO=1002;
        :
        :
        

UPDATE TBL_SAWON
SET SANAME= TBL_SAWONBACKUP 테이블의 1004번 사원의 사원명;


UPDATE TBL_SAWON
SET SANAME=( SELECT SANAME
             FROM TBL_SAWONBACKUP
             WHERE SANO = TBL_SAWON.SANO);
             -- SANO를 하나씩 꺼내서 업데이트
             
    

        