
SELECT USER
FROM DUAL;
--==>> SCOTT


ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.


--○ 문제
-- TBL_SAWON 테이블을 활용하여 다음과 같은 항목들을 조회한다.
-- 사원번호, 사원명, 주민번호, 성별, 현재 나이, 입사일
-- , 정년퇴직일, 근무일수, 남은 일수, 급여, 보너스

-- 단, 현재 나이는 한국 나이 계산법에 따라 연산을 수행한다.
-- 또한, 정년퇴직일은 해당 직원의 나이가 한국나이로 60세가 되는 해(년도)의
-- 그 직원의 입사 월, 일로 연산을 수행한다.
-- 그리고 보너스는 1000일 이상 2000일 미만 근무한 사원은
-- 그 사원의 원래 급여 기준 30% 지급,
-- 2000일 이상 근무한 사원은
-- 그 사원의 원래 급여 기준 50% 지급을 할 수 있도록 처리한다.


SELECT *
FROM TBL_SAWON;
 

-- 태어난 년도 완성

SELECT TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1900
FROM TBL_SAWON;

SELECT CASE SUBSTR(JUBUN, 1, 1) WHEN '0' THEN TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 2000 
                                        ELSE TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1900
       END "나이"               
FROM TBL_SAWON;


SELECT SYSDATE "1"
      , ADD_MONTHS(SYSDATE, 2) "2"
      , ADD_MONTHS(SYSDATE, 3) "3"
      , ADD_MONTHS(SYSDATE, -2) "4"
      , ADD_MONTHS(SYSDATE, -3) "5"
FROM DUAL;

SELECT CASE SUBSTR(JUBUN, 1, 1) WHEN '0' THEN TO_DATE(EXTRACT (YEAR FROM ADD_MONTHS(SYSDATE, (60 - (2021 - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 2000) + 1))*12)) || SUBSTR(HIREDATE,5))
                                        ELSE TO_DATE(EXTRACT (YEAR FROM ADD_MONTHS(SYSDATE, (60 - (2021 - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1900) + 1))*12)) || SUBSTR(HIREDATE,5))
         END "정년 퇴직일"
FROM TBL_SAWON;



SELECT *
FROM TBL_SAWON;

-- 정년 퇴직 나이
(현재 나이) + x = 60
X = 60 - 현재나이
현재 년도 + X = 정년 퇴직 년도;



-- 풀이(내가 한 것)

SELECT SANO "사원번호" , SANAME "사원명", JUBUN "주민번호"
     , CASE WHEN SUBSTR(JUBUN, 7, 1)  IN('1', '3') THEN '남성' 
            ELSE '여성'  -- 바람직하지 않음
       END "성별"
     , CASE SUBSTR(JUBUN, 1, 1) WHEN '0' THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 2000) + 1 
                               ELSE EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1900) + 1             
       END "현재 나이"               
     , HIREDATE "입사일"
     , CASE SUBSTR(JUBUN, 1, 1) WHEN '0' THEN TO_DATE(EXTRACT (YEAR FROM ADD_MONTHS(SYSDATE, (60 - (EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 2000) + 1))*12)) || SUBSTR(HIREDATE,5))
                               ELSE TO_DATE(EXTRACT (YEAR FROM ADD_MONTHS(SYSDATE, (60 - (EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1900) + 1))*12)) || SUBSTR(HIREDATE,5))
       END "정년 퇴직일"
     , TRUNC(SYSDATE - HIREDATE) "근무일수"
     , CASE SUBSTR(JUBUN, 1, 1) WHEN '0' THEN TRUNC(TO_DATE(EXTRACT (YEAR FROM ADD_MONTHS(SYSDATE, (60 - (EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 2000) + 1))*12)) || SUBSTR(HIREDATE,5)) - SYSDATE)
                               ELSE TRUNC(TO_DATE(EXTRACT (YEAR FROM ADD_MONTHS(SYSDATE, (60 - (EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1900) + 1))*12)) || SUBSTR(HIREDATE,5)) - SYSDATE)
       END "남은 일수"
     , SAL "급여"
     , CASE WHEN TRUNC(SYSDATE - HIREDATE) >= 1000 AND TRUNC(SYSDATE - HIREDATE) < 2000  THEN SAL*0.3
            ELSE SAL*0.5
       END "보너스"
     -- , '나현언니 안녕 메롱 ㅎㅎㅎ' "누군가의 메시지"
FROM TBL_SAWON;


-- TBL_SAWON 테이블에 존재하는 사원들의
-- 입사일(HIREDATE) 컬럼에서 월, 일만 조회하기

SELECT SANAME, HIREDATE, TO_CHAR(HIREDATE, 'MM-DD')
FROM TBL_SAWON;
--==>>
/*
김가영	2001-01-03	01-03
김서현	2010-11-05	11-05
김아별	1999-08-16	08-16
이유림	2008-02-02	02-02
정주희	2009-07-15	07-15
한혜림	2009-07-15	07-15
이하이	2010-06-05	06-05
아이유	2012-07-13	07-13
정준이	2007-07-08	07-08
이이제	2008-12-10	12-10
선동열	1990-10-10	10-10
선우선	2002-10-10	10-10
선우용녀	1991-11-11	11-11
남주혁	2010-05-05	05-05
남궁선	2012-08-14	08-14
남이	    1990-08-14	08-14
*/

SELECT SANAME, HIREDATE, TO_CHAR(HIREDATE,'MM')|| '-' || TO_CHAR(HIREDATE,'DD')
FROM TBL_SAWON;
--==>>
/*
김가영	2001-01-03	01-03
김서현	2010-11-05	11-05
김아별	1999-08-16	08-16
이유림	2008-02-02	02-02
정주희	2009-07-15	07-15
한혜림	2009-07-15	07-15
이하이	2010-06-05	06-05
아이유	2012-07-13	07-13
정준이	2007-07-08	07-08
이이제	2008-12-10	12-10
선동열	1990-10-10	10-10
선우선	2002-10-10	10-10
선우용녀	1991-11-11	11-11
남주혁	2010-05-05	05-05
남궁선	2012-08-14	08-14
남이  	1990-08-14	08-14
*/


-- 사원번호, 사원명, 주민번호, 성별, 현재나이, 입사일
-- , 정년퇴직일, 근무일수, 남은일수, 급여, 보너스

--① 사원번호, 사원명, 주민번호, 성별, 현재 나이, 입사일, 급여

SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
     , CASE WHEN 주민번호 7번째자리 1개가 '1' 또는 '3' THEN '남자' 
            WHEN 주민번호 7번째자리 1개가 '2' 또는 '4' THEN '여자'
            ELSE "성별확인불가"
       END "성별"
FROM TBL_SAWON;



SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남자' 
            WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여자'
            ELSE "성별확인불가"
       END "성별"
FROM TBL_SAWON;


SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
     -- 성별
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남자' 
            WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여자'
            ELSE '성별확인불가'
       END "성별"
     -- 현재나이 = 현재년도 - 태어난년도 + 1 (1900년대 생 / 2000년대 생)
     , CASE WHEN 1900년대 생이라면...
            THEN 현재년도 - (주민번호 앞 두 자리 + 1899)
            WHEN 2000년대 생이라면...
            THEN 현재년도 - (주민번호 앞 두 자리 + 1999)
            ELSE -1 -- 컬럼은 하나.. 결과 값은 숫자.. 아닌 경우에는 문자로 지정 못함.. 컬럼의 형식을 정할 수 없으므로
       END "현재 나이"
FROM TBL_SAWON;



SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
     -- 성별
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남자' 
            WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여자'
            ELSE '성별확인불가'
       END "성별"
     -- 현재나이 = 현재년도 - 태어난년도 + 1 (1900년대 생 / 2000년대 생)
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
            WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
            ELSE -1 -- 컬럼은 하나.. 결과 값은 숫자.. 아닌 경우에는 문자로 지정 못함.. 컬럼의 형식을 정할 수 없으므로
       END "현재 나이"
FROM TBL_SAWON;


SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
     -- 성별
      , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') THEN '남자'
             WHEN SUBSTR(JUBUN,7,1) IN ('2','4') THEN '여자'
             ELSE '성별확인불가'
        END "성별"
      , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1', '2')
             THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2) + 1899))
             WHEN SUBSTR(JUBUN,7,1) IN ('3', '4')
             THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2) + 1999))
             ELSE -1        
       END "현재 나이"
    , HIREDATE "입사일"
    , SAL "급여"
FROM TBL_SAWON;

--==>>
/*
1001	김가영	9402252234567	여자	28	2001-01-03	3000
1002	    김서현	9412272234567	여자	28	2010-11-05	2000
1003	김아별	9303082234567	여자	29	1999-08-16	5000
1004	이유림	9609142234567	여자	26	2008-02-02	4000
1005	정주희	9712242234567	여자	25	2009-07-15	2000
1006	한혜림	9710062234567	여자	25	2009-07-15	2000
1007	이하이	0405064234567	여자	18	2010-06-05	1000
1008	아이유	0103254234567	여자	21	2012-07-13	3000
1009	정준이	9804251234567	남자	24	2007-07-08	4000
1010	이이제	0204254234567	여자	20	2008-12-10	2000
1011	선동열	7505071234567	남자	47	1990-10-10	3000
101 2	선우선	9912122234567	여자	23	2002-10-10	2000
1013	선우용녀	7101092234567	여자	51	1991-11-11	1000
1014	남주혁	0203043234567	남자	20	2010-05-05	2000
1015	남궁선	0512123234567	남자	17	2012-08-14	1000
1016	남이	    7012121234567	남자	52	1990-08-14	2000
*/



-- FROM 절에서 SELECT 1차 처리(서브쿼리) 한 뒤 활용~!
-- FROM절 서브쿼리를 인라인 뷰라고 한다.


SELECT T.사원번호, T.사원명, T.주민번호, T.성별, T.현재나이, T.입사일  
       -- 정년퇴직일
       -- 정년퇴직년도 → 해당 직원의 나이가 한국나이로 60세가 되는 해
       -- 현재 나이가... 58세...  2년 후 2021 → 2023
       -- 현재 나이가... 35세... 25년 후 2021 → 2046
       -- ADD_MONTHS(SYSDATE, 남은년수*12)
       --                     ------- 
       --                     60 - 현재나이
       -- ADD_MONTHS(SYSDATE, (60 - 현재나이) * 12)
       -- TO_CHAR(ADD_MONTHS(SYSDATE, (60 - 현재나이) * 12), 'YYYY') → 정년퇴직 년도만 추출
       -- T0_CHAR(입사일, 'MM-DD')                                   → 입사월일만 추출
       -- TO_CHAR(ADD_MONTHS(SYSDATE, (60 - 현재나이) * 12), 'YYYY') || '-' || T0_CHAR(입사일, 'MM-DD') 
        , TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.현재나이) * 12), 'YYYY') || '-' || TO_CHAR(T.입사일, 'MM-DD')
       -- 근무일수
       -- 근무일수 = 현재일 - 입사일
       -- , TRUNC(SYSDATE - T.입사일) "근무일수"
       -- 남은일수 = 정년퇴직일 - 현재일
       -- ,TRUNC(TO_DATE(정년퇴직문자열, 'YYYY-MM-DD') - SYSDATE)) "남은일수"
        , TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.현재나이) * 12), 'YYYY') || '-' || TO_CHAR(T.입사일, 'MM-DD'), 'YYYY-MM-DD') - SYSDATE)
       
       -- 급여
       , T.급여
       
       -- 보너스
       -- 근무일수가 1000일 이상 2000일 미만 → 원래 급여의 30%
       -- 근무일수가 2000일 이상             → 원래 급여의 30%
       -- 나머지           →  0   
       , CASE WHEN TRUNC(SYSDATE - T.입사일) >= 2000 THEN T.급여 *0.5
              WHEN TRUNC(SYSDATE - T.입사일) >= 1000 THEN T.급여 *0.3    
              ELSE 0
         END "보너스"
FROM
(
    SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
        -- 성별
        , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남자' 
               WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여자'
               ELSE '성별확인불가' 
          END "성별"
        -- 현재나이 = 현재년도 - 태어난년도 + 1 (1900년대 생 / 2000년대 생)
        , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
               THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
               WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
               THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
              ELSE 0
         END "현재나이"
        , HIREDATE "입사일"
        , SAL "급여"
    FROM TBL_SAWON
)T;

--==>>
/*
1001	김가영	9402252234567	여성	28	2001-01-03	2053-01-03	7391	11601	3000	1500
1002	    김서현	9412272234567	여성	28	2010-11-05	2053-11-05	3798	11907	2000	1000
1003	김아별	9303082234567	여성	29	1999-08-16	2052-08-16	7897	11461	5000	2500
1004	이유림	9609142234567	여성	26	2008-02-02	2055-02-02	4805	12361	4000	2000
1005	정주희	9712242234567	여성	25	2009-07-15	2056-07-15	4276	12890	2000	1000
1006	한혜림	9710062234567	여성	25	2009-07-15	2056-07-15	4276	12890	2000	1000
1007	이하이	0405064234567	여성	18	2010-06-05	2063-06-05	3951	15406	1000	500
1008	아이유	0103254234567	여성	21	2012-07-13	2060-07-13	3182	14349	3000	1500
1009	정준이	9804251234567	남성	24	2007-07-08	2057-07-08	5014	13248	4000	2000
1010	이이제	0204254234567	여성	20	2008-12-10	2061-12-10	4493	14864	2000	1000
1011	선동열	7505071234567	남성	47	1990-10-10	2034-10-10	11129	4941	3000	1500
1012	    선우선	9912122234567	여성	23	2002-10-10	2058-10-10	6746	13707	2000	1000
1013	선우용녀	7101092234567	여성	51	1991-11-11	2030-11-11	10732	3512	1000	500
1014	남주혁	0203043234567	남성	20	2010-05-05	2061-05-05	3982	14645	2000	1000
1015	남궁선	0512123234567	남성	17	2012-08-14	2064-08-14	3150	15842	1000	500
1016	남이	    7012121234567	남성	52	1990-08-14	2029-08-14	11186	3058	2000	1000
*/


-- 상기 내용에서... 특정 근무일수의 사원을 확인해야 한다거나...
-- 특정 보너스 금액을 받는 사원을 확인해야 할 경우가 생길 수 있다.
-- 이와 같은 경우... 해당 쿼리문을 다시 구성하는 번거로움을 줄일 수 있도록
-- 뷰(VIEW)를 만들어 저장해 둘 수 있다.
-- 데이터는 테이블에만 저장~! 뷰에 저장되는 것 아님!
-- 뷰는 쿼리문이 저장되어 있는 것!


CREATE OR REPLACE VIEW VIEW_SAWON
AS
SELECT T.사원번호, T.사원명, T.주민번호, T.성별, T.현재나이, T.입사일
     , TO_CHAR(ADD_MONTHS(SYSDATE, (60-T.현재나이)*12),'YYYY') || '-' || TO_CHAR(T.입사일,'MM-DD') "정년퇴직일"
     , TRUNC(SYSDATE-T.입사일) "근무일수"
     , TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE, (60-T.현재나이)*12),'YYYY') || '-' || TO_CHAR(T.입사일,'MM-DD'),'YYYY-MM-DD')-SYSDATE) "남은일수"
     , T.급여
     , CASE WHEN TRUNC(SYSDATE-T.입사일)>=2000 THEN T.급여 *0.5
            WHEN TRUNC(SYSDATE-T.입사일)>=1000 THEN T.급여 *0.3 
            ELSE 0
       END "보너스"
FROM
(
    SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
         , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') THEN '남자'
                WHEN SUBSTR(JUBUN,7,1) IN ('2','4') THEN '여자'
                ELSE '성별 확인 불가'
           END "성별"
         , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2))+1899)
                WHEN SUBSTR(JUBUN,7,1) IN ('3','4')
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2))+1999)
                ELSE -1
           END "현재나이"
         , HIREDATE "입사일"
         , SAL "급여"
    FROM TBL_SAWON
)T;
--==>> View VIEW_SAWON이(가) 생성되었습니다.


SELECT *
FROM TBL_SAWON;
--==>> 현재T : 1001	김가영	9402252234567	2001-01-03	3000

SELECT *
FROM VIEW_SAWON;
--==>> 현재V : 1001	김가영	9402252234567	여자	28	2001-01-03	2053-01-03	7391	11601	3000	1500


--○ VIEW 생성 이후 데이터 변경
UPDATE TBL_SAWON
SET HIREDATE=SYSDATE, SAL=100
WHERE SANO=1001;
--==>> 1 행 이(가) 업데이트되었습니다.


--○ 확인
SELECT *
FROM TBL_SAWON;


--○ 커밋
COMMIT;
--==>> 커밋 완료.


SELECT *
FROM TBL_SAWON;
-- 변경전T : 1001	김가영	9402252234567	2001-01-03	3000
-- 변경후T : 1001	김가영	9402252234567	2021-03-30	100

SELECT *
FROM VIEW_SAWON;
-- 변경전T : 1001	김가영	9402252234567	여자	28	2001-01-03	2053-01-03	7391	11601	3000	1500
-- 변경후V : 1001	김가영	9402252234567	여자	28	2021-03-30	2053-03-30	0	    11687	100 	0

--○ 문제
-- 서브쿼리를 활용하여 TBL_SAWON 테이블을 다음과 같이 조회할 수 있도록 한다.
/*
-----------------------------------------------------------------------
    사원명     성별      현재나이       급여       나이보너스
-----------------------------------------------------------------------

단, 나이보너스는 현재 나이가 40세 이상이면 급여의 70%
    30세 이상 40세 미만이면 급여의 50%
    20세 이상 30세 미만이면 급여의 30%로 한다.
    
또한, 완성된 조회 구문을 기반으로
VIEW_SAWON2 라는 이름의 뷰(VIEW)를 생성한다.
*/



SELECT T.사원명, T.성별, T.현재나이, T.급여 
        -- T.* 해도 됨
       , CASE WHEN T.현재나이 >=40 THEN T.급여*0.7
              WHEN T.현재나이 >=30 THEN T.급여*0.5
              WHEN T.현재나이 >=20 THEN T.급여*0.3
         ELSE 0
         END "나이보너스"
FROM
( SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
        , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남자' 
               WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여자'
               ELSE '성별확인불가' 
          END "성별"
        , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
               THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
               WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
               THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
              ELSE 0
         END "현재나이"
        , HIREDATE "입사일"
        , SAL "급여"
    FROM TBL_SAWON
)T;

--==>> 
/*
김가영	여자  	28	100	      30
김서현	여자	    28	2000	     600
김아별	여자	    29	5000	1500
이유림	여자	    26	4000	1200
정주희	여자	    25	2000     600
한혜림	여자	    25	2000	     600
이하이	여자	    18	1000	   0
아이유	여자  	21	3000	 900
정준이	남자  	24	4000	1200
이이제	여자  	20	2000	     600
선동열	남자  	47	3000	2100
선우선	여자	    23	2000	     600
선우용녀	여자	    51	1000	 700
남주혁	남자	    20	2000	     600
남궁선	남자  	17	1000       0
남이	    남자	    52	2000	    1400
*/


CREATE OR REPLACE VIEW VIEW_SAWON2
AS
SELECT T.사원명, T.성별, T.현재나이, T.급여 
       , CASE WHEN T.현재나이 >=40 THEN T.급여*0.7
              WHEN T.현재나이 >=30 THEN T.급여*0.5
              WHEN T.현재나이 >=20 THEN T.급여*0.3
         ELSE 0
         END "나이보너스"
FROM
( SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
        , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남자' 
               WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여자'
               ELSE '성별확인불가' 
          END "성별"
        , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
               THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
               WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
               THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
              ELSE 0
         END "현재나이"
        , HIREDATE "입사일"
        , SAL "급여"
    FROM TBL_SAWON
)T;
--==>> View VIEW_SAWON2이(가) 생성되었습니다.



--○ 생성된(VIEW_SAWON2) 확인
SELECT *
FROM VIEW_SAWON2;
--==>> 
/*
김가영	여자  	28	100	      30
김서현	여자	    28	2000	     600
김아별	여자	    29	5000	1500
이유림	여자	    26	4000	1200
정주희	여자	    25	2000     600
한혜림	여자	    25	2000	     600
이하이	여자	    18	1000	   0
아이유	여자  	21	3000	 900
정준이	남자  	24	4000	1200
이이제	여자  	20	2000	     600
선동열	남자  	47	3000	2100
선우선	여자	    23	2000	     600
선우용녀	여자	    51	1000	 700
남주혁	남자	    20	2000	     600
남궁선	남자  	17	1000       0
남이	    남자	    52	2000	    1400
*/


--------------------------------------------------------------------------------

--○ RANK() → 등수(순위)를 반환하는 함수
SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서번호", SAL "급여"
       , RANK() OVER(ORDER BY SAL DESC) "전체급여순위"
FROM EMP;
--==>>
/*
7839	KING	    10	5000	1
7902    	FORD	    20	3000	2
7788	SCOTT	20	3000	2
7566	JONES	20	2975	    4
7698	BLAKE	30	2850    	5
7782    	CLARK	10	2450    	6
7499	ALLEN	30	1600	7
7844	TURNER	30	1500	8
7934	MILLER	10	1300	9
7521	    WARD    	30	1250	    10
7654	MARTIN	30	1250    	10
7876	ADAMS	20	1100	12
7900	JAMES	30	950 	13
7369	SMITH	20	800 	14
*/



SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서번호", SAL "급여"
       , RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) "부서내급여순위"
       , RANK() OVER(ORDER BY SAL DESC) "전체급여순위"
FROM EMP;
--==>>
/*
7839	KING	    10	5000	1	1
7902    	FORD    	20	3000	1	2
7788	SCOTT	20	3000	1	2
7566	JONES	20	2975	    3	4
7698	BLAKE	30	2850	    1	5
7782	    CLARK	10	2450    	2	6
7499	ALLEN	30	1600	2	7
7844	TURNER	30	1500	3	8
7934	MILLER	10	1300	3	9
7521	    WARD	    30	1250    	4	10
7654	MARTIN	30	1250	    4	10
7876	ADAMS	20	1100	4	12
7900	JAMES	30	950	    6	13
7369	SMITH	20	800	    5	14
*/


SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서번호", SAL "급여"
       , RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) "부서내급여순위"
       , RANK() OVER(ORDER BY SAL DESC) "전체급여순위"
FROM EMP
ORDER BY 3, 4 DESC;
--==>>
/*
7839	KING    	10	5000	1	1
7782    	CLARK	10	2450	    2	6
7934	MILLER	10	1300	3	9
7902	    FORD    	20	3000	1	2
7788	SCOTT	20	3000	1	2
7566	JONES	20	2975    	3	4
7876	ADAMS	20	1100	4	12
7369	SMITH	20	800	    5	14
7698	BLAKE	30	2850	    1	5
7499	ALLEN	30	1600	2	7
7844	TURNER	30	1500	3	8
7654	MARTIN	30	1250	    4	10
7521    	WARD    	30	1250	    4	10
7900	JAMES	30	950	    6	13
*/


--○ DENSE_RANK() → 서열을 반환하는 함수

SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서번호", SAL "급여"
       , DENSE_RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) "부서내급여서열"
       , DENSE_RANK() OVER(ORDER BY SAL DESC) "전체급여서열"
FROM EMP
ORDER BY 3, 4 DESC;
-- 1등이 2명이라도 다음 순위는 3등이 아니라 2등이 되는 것
--==>>
/*
7839	KING	    10	5000	1	1
778 2	CLARK	10	2450    	2	5
7934	MILLER	10	1300	3	8
7902    	FORD	    20	3000	1	2
7788	SCOTT	20	3000	1	2
7566	JONES	20	2975	    2	3
7876	ADAMS	20	1100	3	10
7369	SMITH	20	800	    4	12
7698	BLAKE	30	2850	    1	4
7499	ALLEN	30	1600	2	6
7844	TURNER	30	1500	3	7
7654	MARTIN	30	1250	    4	9
7521    	WARD	    30	1250    	4	9
7900	JAMES	30	950	    5	11
*/


SELECT *
FROM TBL_EMP;

--○ EMP 테이블의 사원 정보를
--   사원명, 부서번호, 연봉, 부서내 연봉순위, 전체 연봉순위 항목으로 조회한다.
SELECT ENAME "사원명", DEPTNO "부서번호"
     , NVL2(COMM, SAL*12+COMM, SAL*12) "연봉"
     , RANK() OVER(PARTITION BY DEPTNO ORDER BY NVL2(COMM, SAL*12+COMM, SAL*12) DESC) "부서내연봉순위"
     , RANK() OVER(ORDER BY NVL2(COMM, SAL*12+COMM, SAL*12) DESC) "전체연봉순위"
FROM TBL_EMP
ORDER BY 2, 3 DESC;
--==>>
/*
KING	    10	60000	1	1
CLARK	10	29400	2	6
MILLER	10	15600	3	10
FORD	    20	36000	1	2
SCOTT	20	36000	1	2
JONES	20	35700	3	4
ADAMS	20	13200	4	12
SMITH	20	9600	5	14
BLAKE	30	34200	1	5
ALLEN	30	19500	2	7
TURNER	30	18000	3	8
MARTIN	30	16400	4	9
WARD    	30	15500	5	11
JAMES	30	11400	6	13
*/


SELECT T.*
     , RANK() OVER(PARTITION BY T.부서번호 ORDER BY T.연봉 DESC) "부서내연봉순위"
     , RANK() OVER(ORDER BY T.연봉 DESC) "전체연봉순위"
FROM
(
SELECT ENAME "사원명", DEPTNO "부서번호"
     , SAL*12+NVL(COMM,0) "연봉"
FROM EMP
) T
ORDER BY 2,3 DESC;
--==>> 위와 같은 결과

--○ EMP 테이블에서 전체 연봉 순위가 1등부터 5등까지만...
-- 사원명, 부서번호, 연봉, 전체연봉순위 항목으로 조회한다

SELECT T.*
FROM
(
SELECT ENAME "사원명", DEPTNO "부서번호", SAL*12+NVL(COMM, 0) "연봉"
     , RANK() OVER(ORDER BY SAL*12+NVL(COMM, 0)) "전체연봉순위"
FROM TBL_EMP
) T
WHERE T.전체연봉순위 <= 5;
--==>>
/*
SMITH	20	9600	1
JAMES	30	11400	2
ADAMS	20	13200	3
WARD	    30	15500	4
MILLER	10	15600	5
*/


SELECT ENAME "사원명", DEPTNO "부서번호", SAL*12+NVL(COMM, 0) "연봉"
     , RANK() OVER(ORDER BY SAL*12+NVL(COMM, 0)) "전체연봉순위"
FROM TBL_EMP
WHERE RANK() OVER(ORDER BY SAL*12+NVL(COMM, 0)) <= 5;
--==>> 에러발생
/*
ORA-30483: window  functions are not allowed here
30483. 00000 -  "window  functions are not allowed here"
*Cause:    Window functions are allowed only in the SELECT list of a query.
           And, window function cannot be an argument to another window or group
           function.
*Action:
660행, 37열에서 오류 발생
*/
--※ 위의 내용은 RANK() OVER() 합수를 WHERE 조건절에서 사용한 경우이며
--   이 함수는 WHERE 조건절에서 사용할 수 없기 때문에 발생하는 에러이다.
--   이 경우, 우리는 INLINE VIEW 를 활용하여 풀이해야 한다.



--○ EMP 테이블에서 각 부서별로 연봉 등수가 1등부터 2등까지만 조회한다.
--   사원번호, 사원명, 부서번호, 연봉, 부서내연봉등수, 전체연봉등수

SELECT T.*
FROM
(
    SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서번호", SAL*12+NVL(COMM, 0) "연봉"
         , RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL*12+NVL(COMM,0) DESC) "부서내연봉등수"
         , RANK() OVER(ORDER BY SAL*12+NVL(COMM,0) DESC) "전체연봉등수"
    FROM TBL_EMP
) T
WHERE T.부서내연봉등수 <= 2
ORDER BY 3, 4 DESC;
--==>>
/*
7839	KING	    10	60000	1	1
7782	    CLARK	10	29400	2	6
7902    	FORD	    20	36000	1	2
7788	SCOTT	20	36000	1	2
7698	BLAKE	30	34200	1	5
7499	ALLEN	30	19500	2	7
*/

SELECT T.*
FROM
(
    SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서번호", SAL*12+NVL(COMM, 0) "연봉"
         , DENSE_RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL*12+NVL(COMM,0) DESC) "부서내연봉등수"
         , DENSE_RANK() OVER(ORDER BY SAL*12+NVL(COMM,0) DESC) "전체연봉등수"
    FROM TBL_EMP
) T
WHERE T.부서내연봉등수 <= 2
ORDER BY 3, 4 DESC;

SELECT T.*
FROM
(
    SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서번호", SAL*12+NVL(COMM, 0) "연봉"
         , DENSE_RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL*12+NVL(COMM,0) DESC) "부서내연봉등수"
         , DENSE_RANK() OVER(ORDER BY SAL*12+NVL(COMM,0) DESC) "전체연봉등수"
    FROM TBL_EMP
) T
WHERE T.부서내연봉등수 IN(1,2)
ORDER BY 3, 4 DESC;
--==>>
/*
7839	KING    	10	60000	1	1
7782	    CLARK	10	29400	2	5
7902    	FORD    	20	36000	1	2
7788	SCOTT	20	36000	1	2
7566	JONES	20	35700	2	3
7698	BLAKE	30	34200	1	4
7499	ALLEN	30	19500	2	6
*/



--■■■ 그룹 함수 ■■■--

-- SUM() 합, AVG() 평균, COUNT() 카운트, MAX() 최대값, MIN() 최소값
-- , VARIANCE() 분산, STDDEV() 표준편차

--※ 그룹 함수의 가장 큰 특징은
--   처리해야 할 데이터들 중 NULL 이 존재하면
--   이 NULL 은 제외하고 연산을 수행한다는 것이다.


-- SUM()
-- EMP 테이블을 대상으로 전체 사원들의 급여 총합을 조회한다.
SELECT SUM(SAL)
FROM EMP;
--==>> 29025 → 800 + 1600 + 1250 + ... + 1300

SELECT SUM(COMM)
FROM EMP;
--==>> 2200  → 300 + 500 +1400 + 0
-- NULL 연산 했는데도 NULL이 안나온다..


-- COUNT()
-- 행의 개수 조회하여 결과값 반환
SELECT COUNT(ENAME)
FROM EMP;
--==>> 14

SELECT COUNT(COMM)
FROM EMP;
--==>> 4
-- 레코드가 4개가 있는 게 아님. NULL를 COUNT에서 제외했다는 뜻..


SELECT COUNT(*)
FROM EMP;
--==>> 14



-- AVG()
-- 평균 반환

SELECT SUM(SAL) / COUNT(SAL) "1", AVG(SAL) "2"
FROM EMP;
--==>>
/*
2073.214285714285714285714285714285714286	
2073.214285714285714285714285714285714286
*/

SELECT AVG(COMM)
FROM EMP;
--==>> 550  → 직원들의 수당 평균


SELECT SUM(COMM)/COUNT(COMM)
FROM EMP;
--==>> 550


SELECT SUM(COMM)/COUNT(*)
FROM EMP;
--==>> 157.142857142857142857142857142857142857




--※ 표준편차의 제곱이 분산
--   분산의 제곱근이 표준편차
SELECT AVG(SAL), VARIANCE(SAL), STDDEV(SAL)
FROM EMP;
--==>>
/*
2073.214285714285714285714285714285714286	
1398313.87362637362637362637362637362637	
1182.503223516271699458653359613061928508
*/

SELECT POWER(STDDEV(SAL), 2), VARIANCE(SAL)
FROM EMP;
--==>>
/*
1398313.87362637362637362637362637362637	
1398313.87362637362637362637362637362637
*/

SELECT STDDEV(SAL), SQRT(VARIANCE(SAL))
FROM EMP;
--==>>
/*
1182.503223516271699458653359613061928508	
1182.503223516271699458653359613061928508
*/


-- MAX() / MIN()
-- 최대값 / 최소값 반환
SELECT MAX(SAL), MIN(SAL)
FROM EMP;
--==>> 5000	800


--※ 주의
SELECT ENAME, SUM(SAL)
FROM EMP;
-- 왼쪽은 14건, 오른쪽은 단일 건.. 이렇게 보여줄 방법 ㄴㄴ
--==>> 에러 발생
/*
ORA-00937: not a single-group group function
00937. 00000 -  "not a single-group group function"
*Cause:    
*Action:
838행, 8열에서 오류 발생
단일건과 그룹함수 함께 보여줄 수 없음..
*/


SELECT DEPTNO, SUM(SAL)
FROM EMP;
--==>>
--==>> 에러 발생
/*
ORA-00937: not a single-group group function
00937. 00000 -  "not a single-group group function"
*Cause:    
*Action:
838행, 8열에서 오류 발생
단일건과 그룹함수 함께 보여줄 수 없음..
*/


SELECT DEPTNO, SUM(SAL)
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;
--==>>
/*
10	8750
20	10875
30	9400
그룹별.. 그.. 보여주게 하는..
*/



SELECT DEPTNO "부서번호", SUM(SAL) "급여합"
FROM EMP
GROUP BY ROLLUP(DEPTNO); -- 전체 그룹에 대한 정보(소계)
--==>>
/*
10	    8750
20	    10875
30	    9400
(NULL)	29025
*/


SELECT *
FROM TBL_EMP;


--○ 데이터 입력
INSERT INTO TBL_EMP VALUES
(8001, '수지', 'CLERK', 7566, SYSDATE, 1500, 10, NULL);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_EMP VALUES
(8002, '아이유', 'CLERK', 7566, SYSDATE, 1000, 0, NULL);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_EMP VALUES
(8003, '정유미', 'SALESMAN', 7698, SYSDATE, 2000, NULL, NULL);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_EMP VALUES
(8004, '이제훈', 'SALESMAN', 7698, SYSDATE, 2500, NULL, NULL);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_EMP VALUES
(8005, '한지민', 'SALESMAN', 7698, SYSDATE, 1000, NULL, NULL);
--==>> 1 행 이(가) 삽입되었습니다.

SELECT *
FROM TBL_EMP;


--○ 커밋
COMMIT;
--==>> 커밋 완료.


SELECT DEPTNO "부서번호", SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO); -- 전체 그룹에 대한 정보(소계)
--==>>
/*
10	    8750
20	    10875
30	    9400
(NULL)	8000        -- 부서번호가 NULL 인 데이터들끼리의 급여 합
(NULL)	37025       -- 모든 부서의 급여 합
*/


-- 위에서 조회한 내용을 아래와 같이 조회될 수 있도록 쿼리문을 구성한다.
/*
부서번호 급여합
------  -------
10	    8750
20	    10875
30	    9400
인턴 	8000        -- 부서번호가 NULL 인 데이터들끼리의 급여 합
모든부서	37025       -- 모든 부서의 급여 합
*/

-- 천재인 나의 풀이
SELECT NVL(T.부서번호, '모든부서') "부서번호", SUM(T.급여합) "급여합" -- T.급여합 왜 안되는가?
FROM(
    SELECT NVL(TO_CHAR(DEPTNO), '인턴') "부서번호", SUM(SAL) "급여합"
    FROM TBL_EMP
    GROUP BY DEPTNO -- 전체 그룹에 대한 정보(소계)
) T
GROUP BY ROLLUP(T.부서번호);



-- 쌤 풀이
SELECT CASE DEPTNO WHEN NULL THEN '인턴'
                   ELSE DEPTNO
       END "부서번호"
FROM TBL_EMP;
--==>> 에러발생
/*
ORA-00932: inconsistent datatypes: expected CHAR got NUMBER
00932. 00000 -  "inconsistent datatypes: expected %s got %s"
*Cause:    
*Action:
964행, 29열에서 오류 발생
*/



SELECT CASE WHEN DEPTNO IS NULL THEN '인턴'
                   ELSE TO_CHAR(DEPTNO)
       END "부서번호"
FROM TBL_EMP;
--==>>
/*
20
30
30
20
30
30
10
20
10
30
20
30
20
10
인턴
인턴
인턴
인턴
인턴
*/


SELECT CASE WHEN DEPTNO IS NULL THEN '인턴'
                   ELSE TO_CHAR(DEPTNO)
       END "부서번호"
     , SUM(SAL) "급여합" 
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	8750
20	10875
30	9400
인턴	8000
인턴	37025
-- GROUP BY가 SELECT보다 먼저 파싱되니까~!
*/


SELECT NVL(DEPTNO, '인턴') "부서번호", SUM(SAL) "급여합"  --DEPTNO는 숫자, '인턴'은 문자
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==> 에러 발생


SELECT NVL(TO_CHAR(DEPTNO), '인턴') "부서번호", SUM(SAL) "급여합"  --DEPTNO는 숫자, '인턴'은 문자
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==> 여전히 인턴 두 번..



--※ GROUPING()
SELECT CASE WHEN DEPTNO IS NULL AND GROUPING(DEPTNO) = 0 THEN '인턴'
            WHEN DEPTNO IS NULL AND GROUPING(DEPTNO) = 1 THEN '모든부서'
            ELSE TO_CHAR(DEPTNO)
       END "부서번호"
     , SUM(SAL) "급여합", GROUPING(DEPTNO) "그루핑결과"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);




ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
SELECT ROUND((TO_DATE(TO_CHAR(SYSDATE, 'YYYY-MM-DD') || ' ' ||'17:50:00') - SYSDATE)*24*60) "존버"
FROM DUAL;

-- 오라클은 NULL은 가장 큰 값으로 간주한다...