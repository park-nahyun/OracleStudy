--○ TBL_INSA 테이블의 급여 계산 전용 함수를 정의한다.
--   급여는 (기본급*12)+수당 기반으로 연산을 수행한다.
--   함수명 : FN_PAY(기본급, 수당)

CREATE OR REPLACE FUNCTION FN_PAY
(
    NUM1     NUMBER    -- 기본급 매개변수
  , NUM2     NUMBER    -- 수당 매개변수
)
RETURN NUMBER           -- 리턴 자료형
IS
    -- 주요 변수 선언
    TOTAL    NUMBER;   -- 총 급여 담을 변수
BEGIN
    -- 연산
    TOTAL := NUM1*12 + NVL(NUM2, 0);
    RETURN TOTAL;
END;
--==>> Function FN_PAY이(가) 컴파일되었습니다.




--○ TBL_INSA 테이블의 입사일을 기준으로
--   현재까지의 근무년수를 반환하는 함수를 정의한다.
--   단, 근무년수는 소수점 이하 한자리까지 계산한다.
--   함수명 : FN_WORKYEAR(입사일)


CREATE OR REPLACE FUNCTION FN_WORKYEAR
(
    HDATE       DATE        -- 입사일 매개변수 
)
RETURN NUMBER               -- 리턴 자료형
IS
    -- 주요 변수 선언
    WORKY   NUMBER;         -- 근무년수 담을 변수 
BEGIN
    -- 연산
    WORKY := TRUNC((SYSDATE - HDATE)/365,1);
    RETURN WORKY;
END;