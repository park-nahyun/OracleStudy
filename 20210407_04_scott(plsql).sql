-- PL/SQL 워크시트는 독립적으로 만들어두기

SELECT USER
FROM DUAL;
--==>> SCOTT


-- ■■■ PL/SQL ■■■ --

-- 1. PL/SQL(Procedural Language extension to SQL) 은
--    프로그래밍 언어의 특성을 가지는 SQL 의 확장이며,
--    데이터 조작과 질의 문장은 PL/SQL 의 절차적 코드 안에 포함된다.
--    또한, PL/SQL 을 사용하면 SQL 로 할 수 없는 절차적 작업이 가능하다.
--    여기서 『절차적』이라는 단어가 가지는 의미는
--    어떤 것이 어떤 과정을 거쳐 어떻게 완료되는지
--    그 방법을 정확하게 코드에 기술한다는 것을 의미한다.


-- 2. PL/SQL 은 절차적으로 표현하기 위해
--    변수를 선언할 수 있는 기능,
--    참과 거짓을 구별할 수 있는 기능,
--    실행 흐름을 컨트롤할 수 있는 기능 등을 제공한다.


-- 3. PL/SQL 은 블럭 구조로 되어있으며
--    블럭은 선언 부분, 실행 부분, 예외 처리 부분의   -- 선언, 예외 처리는 필요 없다면 생략 가능..
--    세 부분으로 구성되어 있다.
--    또한, 반드시 실행 부분은 존재해야 하며, 구조는 다음과 같다.


-- 4. 형식 및 구조
/*
[DECLARE]
    -- 선언문(declarations)
BEGIN
    -- 실행문(statements)
    
    [EXCEPTION]
        -- 예외 처리문(exception handlers)
        
END;
*/
-- 예외 처리부는 실행문 안에 포함된 것..


-- 5. 변수 선언
/*
DECLARE
  변수명 자료형;
  변수명 자료형 := 초기값;           우측 항을 좌측 항에 대입한다~!
BEGIN
  PL/SQL 구문;
END;
*/


SET SERVEROUTPUT ON;
--==>> 작업이 완료되었습니다.(0.XXX초)
--> System.out.println()
--> = 『DBMS_OUTPUT.PUT_LINE()』 을 통해
--    화면에 결과를 출력하기 위한 환경변수 설정

-- SQL에서는 어떤 긴 구문이라도 세미콜론이 하나였는데
-- PLSQL에서는 세미콜론이 여러 개기 때문에 무조건 블럭 잡아서 실행해야 함.


--○ 변수에 임의의 값을 대입하고 출력하는 구문 작성
DECLARE

    -- 선언부
    D1 NUMBER :=10;
    D2 VARCHAR2(30) := 'HELLO';
    D3 VARCHAR2(20) := 'Oracle';
BEGIN
    -- 실행부
    DBMS_OUTPUT.PUT_LINE(D1);
    DBMS_OUTPUT.PUT_LINE(D2);
    DBMS_OUTPUT.PUT_LINE(D3);
END;
--==>>
/*
10
HELLO
Oracle


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


--○ 변수에 임의의 값을 대입하고 출력하는 구문 작성
DECLARE

    -- 선언부
    D1 NUMBER :=10;
    D2 VARCHAR2(30) := 'HELLO';
    D3 VARCHAR2(20) := 'Oracle';
BEGIN
    -- 실행부
    D1 := D1 * 10;       -- 오라클에는 복합대입연산자(+=)가 없다.
    D2 := D2 || '민지';
    D3 := D3 || 'World';
    
    DBMS_OUTPUT.PUT_LINE(D1);
    DBMS_OUTPUT.PUT_LINE(D2);
    DBMS_OUTPUT.PUT_LINE(D3);
END;
--==>>
/*
100
HELLO민지
OracleWorld

PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/



--○ IF문(조건문)
-- IF ~ END IF;
-- IF ~ THEN ~ ELSE ~ END IF;
-- IF ~ THEN ~ ELSIF ~ THEN ~ ELSIF ~ THEN ~ ELSE ~ END IF;

-- 1. PL/SQL 의 IF 문장은 다른 언어의 IF 조건문과 거의 유사하다.
--    일치하는 조건에 따라 선택적으로 작업을 수행할 수 있도록 한다.
--    TRUE 이면 THEN 과 ELSE 사이의 문장을 수행하고
--    FALSE 나 NULL 이면 ELSE 와  END 사이의 문장을 수행하게 된다.


--2. 형식 및 구조
/*
IF 조건
   THEN 처리구문;
ELSIF 조건
   THEN 처리구문;
ELSIF 조건
   THEN 처리구문;
ELSE
   처리구문
END IF;
*/

--○ 변수에 들어있는 값에 따라..
--   Exellent, Good, Fail 로 구분하여
--   결과를 출력하는 PL/SQL 구문을 작성한다.

DECLARE
    GRADE CHAR;
BEGIN
    GRADE := 'A';
    
    IF GRADE = 'A'
        THEN DBMS_OUTPUT.PUT_LINE('Excellent');
    ELSIF GRADE = 'B'
        THEN DBMS_OUTPUT.PUT_LINE('Good');
    ELSE  
        DBMS_OUTPUT.PUT_LINE('Fail');
    END IF;
END;
--==>>
/*

Excellent


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


--○ CASE문(조건문)
-- CASE ~ WHEN ~ THEN ~ ELSE ~ END CASE;

-- 1. 형식 및 구조
/*
CASE 변수
    WHEN 값1
        THEN 실행문;
    WHEN 값2
        THEN 실행문;
    ELSE
        실행문;
END CASE;
*/


--○ 변수에 들어있는 값에 따라..
--   Exellent, Good, Fail 로 구분하여
--   결과를 출력하는 PL/SQL 구문을 작성한다.
DECLARE
    GRADE CHAR;
BEGIN
    GRADE := 'A';
    
    CASE GRADE
        WHEN 'A'
            THEN DBMS_OUTPUT.PUT_LINE('Excellent');
        WHEN 'B'
            THEN DBMS_OUTPUT.PUT_LINE('Good');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Fail');
    END CASE;
END;
--==>>
/*
Excellent


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/



--○ 외부 입력 처리

--1. ACCEPT 문
-- ACCEPT 변수명 PROMPT '메시지';
-- 외부 변수로부터 입력받은 데이터를 내부 변수에 전달할 때
-- 『&외부변수명』 형태로 접근하게 된다.

--○ 정수 2개를 외부로부터(사용자로부터) 입력받아
--   이들의 덧셈 결과를 출력하는 PL/SQL 구문을 작성한다.

ACCEPT N1 PROMPT '첫 번째 정수를 입력하세요';
ACCEPT N2 PROMPT '두 번째 정수를 입력하세요';

DECLARE
    -- 주요 변수 선언 및 초기화
    NUM1    NUMBER := &N1;
    NUM2    NUMBER := &N2;
    TOTAL   NUMBER := 0;
BEGIN
    -- 연산 및 처리
    TOTAL := NUM1 + NUM2;
    -- 결과 출력
    DBMS_OUTPUT.PUT_LINE(NUM1 || '+' || NUM2 || ' = ' || TOTAL);
END;
--==>>
/*
5+10 = 15


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


--○ 사용자로부터 입력받은 금액을 화폐 단위로 출력하는 프로그램을 작성한다.
--   단, 반환 금액은 편의상 1천원 미만, 10원 이상만 가능하다고 가정한다.
/*
실행 예)
바인딩 변수 입력 대화창 → 금액 입력 : 990

입력받음 금액 총액 : 990원
화폐단위 : 오백원 1, 백원 4, 오십원 1, 십원 4
*/

ACCEPT N1 PROMPT '금액 입력';

DECLARE
    NUM1    NUMBER := &N1;
    NUM500  NUMBER;
    NUM100  NUMBER;
    NUM50   NUMBER;
    NUM10   NUMBER;
BEGIN
    NUM500 := TRUNC(NUM1/500, 0);
    NUM100 := TRUNC((NUM1/500 - TRUNC(NUM1/500, 0))*500/100, 0);
    NUM50  := TRUNC((NUM1-(NUM500*500+NUM100*100))/50, 0);
    NUM10  := TRUNC((NUM1-(NUM500*500+NUM100*100+NUM50*50))/10, 0);
    DBMS_OUTPUT.PUT_LINE('화폐단위 : 오백원 ' || NUM500 || ', 백원 ' || NUM100 || ', 오십원 ' || NUM50 || ', 십원 ' || NUM10);
END;