SELECT USER
FROM DUAL;
--==>> SCOTT


--○ 사용자로부터 입력받은 금액을 화폐 단위로 출력하는 프로그램을 작성한다.
--   단, 반환 금액은 편의상 1천원 미만, 10원 이상만 가능하다고 가정한다.
/*
실행 예)
바인딩 변수 입력 대화창 → 금액 입력 : 990

입력받음 금액 총액 : 990원
화폐단위 : 오백원 1, 백원 4, 오십원 1, 십원 4
*/

SET SERVEROUTPUT ON;

-- 방법1
ACCEPT N1 PROMPT '금액 입력';

DECLARE
     --○ 주요 변수 선언 및 초기화
    NUM1    NUMBER := &N1;                  -- 연산을 위해 담아둘 변수
    NUM500  NUMBER := 0;                    -- 500원 짜리 개수를 담아둘 변수
    NUM100  NUMBER := 0;                    -- 100원 짜리 개수를 담아둘 변수
    NUM50   NUMBER := 0;                    -- 50원 짜리 개수를 담아둘 변수
    NUM10   NUMBER := 0;                    -- 10원 짜리 개수를 담아둘 변수
BEGIN
    --○ 연산 및 처리
    NUM500 := TRUNC(NUM1/500, 0);
    NUM100 := TRUNC((NUM1/500 - TRUNC(NUM1/500, 0))*500/100, 0);
    NUM50  := TRUNC((NUM1-(NUM500*500+NUM100*100))/50, 0);
    NUM10  := TRUNC((NUM1-(NUM500*500+NUM100*100+NUM50*50))/10, 0);
    
    --○ 결과 출력
    DBMS_OUTPUT.PUT_LINE('화폐단위 : 오백원 ' || NUM500 || ', 백원 ' || NUM100 || ', 오십원 ' || NUM50 || ', 십원 ' || NUM10);
END;


-- 방법 2
ACCEPT N2 PROMPT '금액 입력 : ';
DECLARE
    -- 주요 변수 선언 및 초기화
    PRICE   NUMBER(3) := &N2;
BEGIN
    -- 연산 및 처리 & 결과 출력
    DBMS_OUTPUT.PUT_LINE('입력받은 금액 총액 : ' || PRICE || '원');
    
    DBMS_OUTPUT.PUT_LINE('오백원 ' || TRUNC(PRICE/500) 
                      || ', 백원 ' || TRUNC(MOD(PRICE, 500)/100)
                      || ', 오십원 ' || TRUNC(MOD(MOD(PRICE, 500), 100)/50)
                      || ', 십원 ' || TRUNC(MOD(MOD(MOD(PRICE, 500), 100), 50))/10);        
END;


-- 방법 3

ACCEPT INPUT PROMPT '금액 입력';

DECLARE
     --○ 주요 변수 선언 및 초기화
    MONEY   NUMBER := &INPUT;               -- 연산을 위해 담아둘 변수
    MONEY2  NUMBER := &INPUT;               -- 출력을 위해 담아둘 변수(연산 후 값이 변하니까)
    NUM500  NUMBER := 0;                    -- 500원 짜리 개수를 담아둘 변수
    NUM100  NUMBER := 0;                    -- 100원 짜리 개수를 담아둘 변수
    NUM50   NUMBER := 0;                    -- 50원 짜리 개수를 담아둘 변수
    NUM10   NUMBER := 0;                    -- 10원 짜리 개수를 담아둘 변수
BEGIN
    --○ 연산 및 처리
    -- MONEY 를 500으로 나눠서 몫을 취하고 나머지는 버린다. → 500원의 개수
    NUM500 := TRUNC(MONEY/500);
    
    -- MONEY 를 500으로 나눠서 몫을 취하고 나머지는 취한다. 
    MONEY  :=  MOD(MONEY, 500);
    
    -- MONEY 를 100으로 나눠서 몫을 취하고 나머지는 버린다. → 100원의 개수
    NUM100 := TRUNC(MONEY/100);
    
    -- MONEY 를 100으로 나눠서 몫을 취하고 나머지는 취한다. 
    MONEY  :=  MOD(MONEY, 100);
    
    -- MONEY 를 50으로 나눠서 몫을 취하고 나머지는 버린다. → 50원의 개수
    NUM50 := TRUNC(MONEY/50);
    
    -- MONEY 를 50으로 나눠서 몫을 취하고 나머지는 취한다. 
    MONEY  :=  MOD(MONEY, 50);
    
    -- MONEY 를 10으로 나눠서 몫을 취하고 나머지는 버린다. → 10원의 개수
    NUM10 := TRUNC(MONEY/10);
    
    --○ 결과 출력
    DBMS_OUTPUT.PUT_LINE('입력받은 금액 총액 : ' || MONEY2 || '원');
    DBMS_OUTPUT.PUT_LINE('화폐단위 : 오백원 ' || NUM500 || ', 백원 ' || NUM100 || ', 오십원 ' || NUM50 || ', 십원 ' || NUM10);
END;

--==>>
/*
입력받은 금액 총액 : 990원
화폐단위 : 오백원 1, 백원 4, 오십원 1, 십원 4


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/



--○ 기본 반복문
-- LOOP ~ END LOOP;


-- 1. 조건과 상관없이 무조건 반복하는 구문.

-- 2. 형식 및 구조
/*
LOOP
    -- 실행문;
    EXIT WHEN 조건;               -- 조건이 참인 경우 반복문을 빠져나간다.
END LOOP;
*/


--○ 1 부터 10 까지의 수 출력 (LOOP 문 활용)
DECLARE
    N       NUMBER;
BEGIN
    N   :=  1;
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        EXIT WHEN N >= 10;
        N := N + 1;                 -- N++;     N+=1;
    END LOOP;
END;
--==>>
/*
1
2
3
4
5
6
7
8
9
10


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


--○ WHILE 반복문
-- WHILE LOOP ~ END LOOP;

-- 1. 제어 조건이 TRUE 인 동안 일련의 문장을 반복하기 위해
--    WHILE LOOP 문장을 사용한다.
--    조건은 반복이 시작될 때 체크하게 되어
--    LOOP 내의 문장이 한 번도 수행되지 않을 경우도 있다.
--    LOOP 를 시작할 때 조건이 FALSE 이면 반복 문장을 탈출하게 된다.

-- 2. 형식 및 구조
/*
WHILE 조건 LOOP           -- 조건이 참인 경우 반복 수행
        -- 실행문;
END LOOP;
*/

--○ 1 부터 10 까지의 수 출력 (WHILE LOOP 문 활용)

DECLARE
    N   NUMBER;
BEGIN
    N := 0;
    WHILE N<10 LOOP
        N := N + 1;
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
--==>>
/*
1
2
3
4
5
6
7
8
9
10


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


--○ FOR 반복문
-- FOR LOOP ~ END LOOP;

-- 1. 『시작 수』에서 1씩 증가하여
--    『끝냄 수』가 될 때 까지 반복 수행한다.
-- 2. 형식 및 구조
/*
FOR 카운터 IN [REVERSE] 시작수 .. 끝냄수 LOOP
    -- 실행문;
END LOOP;
*/


--○ 1 부터 10 까지의 수 출력 (FOR LOOP 문 활용)
DECLARE
    N   NUMBER;     -- 카운터
BEGIN
    FOR N IN 1 .. 10 LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
--==>>
/*

PL/SQL 프로시저가 성공적으로 완료되었습니다.

1
2
3
4
5
6
7
8
9
10


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


--○ 사용자로부터 임의의 단(구구단)을 입력받아
--   해당 단수의 구구단을 출력하는 PL/SQL 구문을 작성한다.
--   LOOP, WHILE LOOP, FOR LOOP 를 통해 해결한다.

/*
실행 예)
바인딩 변수 입력 대화창 → 단을 입력하세요 : 2

2 * 1 = 2
2 * 2 = 4
2 * 3 = 6
    :
2 * 9 = 18
*/


-- 방법 1 LOOP
ACCEPT DAN INPUT PROMPT '단을 입력하세요';

DECLARE
    DAN     NUMBER := &DAN;     -- 사용자가 입력한 숫자
    GOB     NUMBER;     -- 1~9까지 곱해줄 숫자
BEGIN
    GOB  := 1;
    LOOP
        DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || GOB || ' = ' || DAN*GOB);
        EXIT WHEN GOB >= 9;
        
        GOB := GOB + 1;
    END LOOP;
END;
--==>>
/*
5 * 1 = 5
5 * 2 = 10
5 * 3 = 15
5 * 4 = 20
5 * 5 = 25
5 * 6 = 30
5 * 7 = 35
5 * 8 = 40
5 * 9 = 45
*/


-- 방법 2 WHILE LOOP
ACCEPT DAN INTO PROMPT '단을 입력하세요';
DECLARE
    DAN     NUMBER := &DAN;
    GOB     NUMBER;
BEGIN
    GOB := 0;
    WHILE GOB<9 LOOP
        GOB := GOB + 1;
        DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || GOB || ' = ' || DAN*GOB);
    END LOOP;
END;
--==>>
/*
2 * 1 = 2
2 * 2 = 4
2 * 3 = 6
2 * 4 = 8
2 * 5 = 10
2 * 6 = 12
2 * 7 = 14
2 * 8 = 16
2 * 9 = 18
*/

-- 방법 3 FOR LOOP
ACCEPT DAN INTO PROMPT '단을 입력하세요';
DECLARE
    DAN     NUMBER := &DAN;
    GOB     NUMBER;
BEGIN
    FOR GOB IN 1 .. 9 LOOP
        DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || GOB || ' = ' || DAN*GOB);
    END LOOP;
END;
--==>>
/*
5 * 1 = 5
5 * 2 = 10
5 * 3 = 15
5 * 4 = 20
5 * 5 = 25
5 * 6 = 30
5 * 7 = 35
5 * 8 = 40
5 * 9 = 45
*/
