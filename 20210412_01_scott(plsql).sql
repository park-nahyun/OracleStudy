
SELECT USER
FROM DUAL;
--==>> SCOTT


--○ TBL_출고 테이블에서 출고 수량을 변경(수정)하는 프로시저를 작성한다.
--   프로시저 명 : PRC_출고_UPDATE(출고번호, 변경할수량);


CREATE OR REPLACE PROCEDURE PRC_출고_UPDATE
( 
    --① 매개변수 구성
    V_출고번호 IN TBL_출고.출고번호%TYPE
  , V_출고수량 IN TBL_출고.출고수량%TYPE              -- 재고수량과 다름 !!!
)
IS
    --③ 주요 변수 선언
    V_상품코드  TBL_상품.상품코드%TYPE;
    
    --⑤ 주요 변수 추가 선언
    V_이전출고수량    TBL_출고.출고수량%TYPE;
    
    --⑧ 주요 변수 추가 선언
    V_재고수량  TBL_상품.재고수량%TYPE;

    --⑩ 주요 변수(사용자 정의 예외) 추가 선언
    USER_DEFINE_ERROR EXCEPTION;
    
    
BEGIN
    --④ 상품코드 파악  / ⑥ 이전출고수량 파악       -- 순서, 위치 중요!!!        → 변경 이전의 출고 내역 확인
    
    SELECT 상품코드, 출고수량 INTO V_상품코드, V_이전출고수량
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;
    
    --⑦ 출고를 정상적으로 수행해야 하는지의 여부 판단 필요
    --   변경 이전의 출고수량 및 현재의 재고수량 확인
    
    SELECT 재고수량 INTO V_재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    --⑨ 파악한 재고수량에 따라 데이터 변경 실시 여부 판단
    --   (『재고수량+이전출고수량 < 현재출고수량』 인 상황이라면... 사용자 예외 발생)
    IF (V_재고수량 + V_이전출고수량 < V_출고수량)
        --THEN 예외 발생;
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    --② 수행된 쿼리문 체크(UPDATE → TBL_출고 / UPDATE → TBL_상품 -- 새 상품을 넣기 전까지 이 테이블에는 UPDATE 밖에 없음)
    UPDATE TBL_출고
    SET 출고수량 = V_출고수량
    WHERE 출고번호 = V_출고번호;
    
    UPDATE TBL_상품
    SET 재고수량 = V_재고수량 + V_이전출고수량 - V_출고수량
    WHERE 상품코드 = V_상품코드;
    
    --⑪ 커밋
    COMMIT;
    
    --⑫ 예외 처리
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '재고 부족~~!!!');
            ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;   
END;


-- 완벽한 DB가 아니다.




--○ TBL_입고 테이블에서 입고수량을 변경(수정)하는 프로시저를 작성한다.
--   프로시저 명 : PRC_입고_UPDATE(입고번호, 변경할입고수량);

CREATE OR REPLACE PROCEDURE PRC_입고_UPDATE
( V_입고번호        IN TBL_입고.입고번호%TYPE
, V_변경할입고수량  IN TBL_입고.입고수량%TYPE
)
IS
    V_재고수량 TBL_상품.재고수량%TYPE;
    V_이전입고수량 TBL_입고.입고수량%TYPE;
    V_상품코드 TBL_상품.상품코드%TYPE;
    V_출고수량 TBL_출고.출고수량%TYPE;
    USER_DEFINE_ERROR EXCEPTION;
BEGIN
    -- 상품코드, 이전입고수량
    SELECT 상품코드, 입고수량 INTO V_상품코드, V_이전입고수량
    FROM TBL_입고
    WHERE V_입고번호 = 입고번호;
    
    -- 이전재고수량
    SELECT 재고수량 INTO V_재고수량
    FROM TBL_상품
    WHERE V_상품코드 = 상품코드;
    
    -- 출고수량
    
    SELECT 출고수량 INTO V_출고수량
    FROM TBL_출고
    WHERE V_상품코드 = 상품코드;
    
    IF (V_재고수량 - V_이전입고수량 + V_변경할입고수량 <0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    UPDATE TBL_입고
    SET 입고수량 = V_변경할입고수량
    WHERE V_입고번호 = 입고번호;
    
    UPDATE TBL_상품
    SET 재고수량 = V_재고수량 - V_이전입고수량 + V_변경할입고수량
    WHERE V_상품코드 = 상품코드;
    
    --예외처리
    EXCEPTION
        WHEN USER_DEFINE_ERROR
             THEN RAISE_APPLICATION_ERROR(-20003, '입고량 부족~~!!!');
             ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;   
END;

--○ TBL_출고 테이블에서 출고 수량을 삭제하는 프로시저를 작성한다.
--   프로시저 명 : PRC_출고_DELETE(출고번호);
CREATE OR REPLACE PROCEDURE PRC_출고_DELETE
(
 V_출고번호 IN TBL_출고.출고번호%TYPE
)
IS
    V_이전출고수량    TBL_출고.출고수량%TYPE;
    V_이전재고수량    TBL_상품.재고수량%TYPE;
    V_상품코드        TBL_상품.상품코드%TYPE;
BEGIN
    -- 이전 출고수량
    SELECT 출고수량, 상품코드 INTO V_이전출고수량, V_상품코드
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;
    -- 이전 재고
    SELECT 재고수량 INTO V_이전재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    UPDATE TBL_출고
    SET 출고수량 = 0
    WHERE 출고번호 = V_출고번호;
    
    /*
    DELETE 
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;
    */
    
    UPDATE TBL_상품
    SET 재고수량 = V_이전재고수량 + V_이전출고수량
    WHERE 상품코드 = V_상품코드;
END;

--○ TBL_입고 테이블에서 입고수량을 삭제하는 프로시저를 작성한다.
--   프로시저 명 : PRC_입고_DELETE(입고번호);

CREATE OR REPLACE PROCEDURE PRC_입고_DELETE
(
  V_입고번호 IN TBL_입고.입고번호%TYPE
)
IS
    V_이전입고수량    TBL_입고.입고수량%TYPE;
    V_이전재고수량    TBL_상품.재고수량%TYPE;
    V_상품코드        TBL_상품.상품코드%TYPE;
    USER_DEFINE_ERROR EXCEPTION;
    
BEGIN
    
    SELECT 입고수량, 상품코드 INTO V_이전입고수량, V_상품코드
    FROM TBL_입고
    WHERE 입고번호 = V_입고번호;
    -- 이전 재고
    SELECT 재고수량 INTO V_이전재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    IF (V_이전재고수량 - V_이전입고수량 <0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    UPDATE TBL_입고
    SET 입고수량 = 0
    WHERE 입고번호 = V_입고번호;
    
    /*
    DELETE 
    FROM TBL_입고
    WHERE 입고번호 = V_입고번호;
    */
    
    UPDATE TBL_상품
    SET 재고수량 = V_이전재고수량 - V_이전입고수량
    WHERE 상품코드 = V_상품코드;
    
   EXCEPTION
        WHEN USER_DEFINE_ERROR
             THEN RAISE_APPLICATION_ERROR(-20003, '입고량 부족~~!!!');
             ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK; 
END;





-------------------------------------------------------------------------

-- ■■■ 커서(CURSUR) ■■■ --

-- 1. 오라클에서 하나의 레코드가 아닌 여러 레코드로 구성된
--    작업 영역에서 SQL 문을 실행하고 그 과정에서 발생한 정보를 
--    저장하기 위하여 커서(CURSUR)를 사용하며,
--    커서에는 암시적 커서와 명시적커서가 있다.

-- 2. 암시적 커서는 모든 SQL 문에 존재하며,
--    SQL 실행 후 오직 하나의 행(ROW)만 출력하게 된다.
--    그러나 SQL 문을 실행한 결과물(RESULT SET)이
--    여러 행(ROW)으로 구성된 경우
--    커서(CURSUR)를 명시적으로 선언해야 행(ROW)을 다룰 수 있다.


-- 4월 8일 참고^^ 여러개 행 정보를 얻어와서 담으려고 하면 변수에 저장하는 것 자체가 불가능한 상황~ 여기서 커서 언급됨^^



--○ 커서 이용 전 상황(단일 행 접근 시)
SET SERVEROUTPUT ON;

DECLARE
    V_NAME TBL_INSA.NAME%TYPE;
    V_TEL  TBL_INSA.TEL%TYPE;
    
BEGIN
    SELECT NAME, TEL INTO V_NAME, V_TEL
    FROM TBL_INSA
    WHERE NUM = 1001;
    
    DBMS_OUTPUT.PUT_LINE(V_NAME || ' , ' || V_TEL);
END;

--==>> 홍길동 , 011-2356-4528



SET SERVEROUTPUT ON;

DECLARE
    V_NAME TBL_INSA.NAME%TYPE;
    V_TEL  TBL_INSA.TEL%TYPE;
    
BEGIN
    SELECT NAME, TEL INTO V_NAME, V_TEL
    FROM TBL_INSA;          -- 특정 레코드가 아닌 전체의 이름, 번호를 가져오겠다는 뜻
    
    DBMS_OUTPUT.PUT_LINE(V_NAME || ' , ' || V_TEL);
END;
--==>> 에러발생
/*
ORA-01422: exact fetch returns more than requested number of rows
*/

--○ 커서 이용 전 상황(다중 행 접근 시 - 반복문을 활용하는 경우)
DECLARE
    V_NAME  TBL_INSA.NAME%TYPE;
    V_TEL   TBL_INSA.TEL%TYPE;
    V_NUM   TBL_INSA.NUM%TYPE := 1001;
BEGIN
    LOOP
        SELECT NAME, TEL INTO V_NAME, V_TEL
        FROM TBL_INSA
        WHERE NUM = V_NUM;
        
        DBMS_OUTPUT.PUT_LINE(V_NAME || ' , ' || V_TEL);
        
        V_NUM := V_NUM + 1;
        
        EXIT WHEN V_NUM >= 1061;
    END LOOP;
END;
--==>>
/*
홍길동 , 011-2356-4528
이순신 , 010-4758-6532
이순애 , 010-4231-1236
김정훈 , 019-5236-4221
한석봉 , 018-5211-3542
이기자 , 010-3214-5357
장인철 , 011-2345-2525
김영년 , 016-2222-4444
나윤균 , 019-1111-2222
김종서 , 011-3214-5555
유관순 , 010-8888-4422
정한국 , 018-2222-4242
조미숙 , 019-6666-4444
황진이 , 010-3214-5467
이현숙 , 016-2548-3365
이상헌 , 010-4526-1234
엄용수 , 010-3254-2542
이성길 , 018-1333-3333
박문수 , 017-4747-4848
유영희 , 011-9595-8585
홍길남 , 011-9999-7575
이영숙 , 017-5214-5282
김인수 , 
김말자 , 011-5248-7789
우재옥 , 010-4563-2587
김숙남 , 010-2112-5225
김영길 , 019-8523-1478
이남신 , 016-1818-4848
김말숙 , 016-3535-3636
정정해 , 019-6564-6752
지재환 , 019-5552-7511
심심해 , 016-8888-7474
김미나 , 011-2444-4444
이정석 , 011-3697-7412
정영희 , 
이재영 , 011-9999-9999
최석규 , 011-7777-7777
손인수 , 010-6542-7412
고순정 , 010-2587-7895
박세열 , 016-4444-7777
문길수 , 016-4444-5555
채정희 , 011-5125-5511
양미옥 , 016-8548-6547
지수환 , 011-5555-7548
홍원신 , 011-7777-7777
허경운 , 017-3333-33334
산마루 , 018-0505-0505
이기상 , 
이미성 , 010-6654-8854
이미인 , 011-8585-5252
권영미 , 011-5555-7548
권옥경 , 010-3644-5577
김싱식 , 011-7585-7474
정상호 , 016-1919-4242
정한나 , 016-2424-4242
전용재 , 010-7549-8654
이미경 , 016-6542-7546
김신제 , 010-2415-5444
임수봉 , 011-4151-4154
김신애 , 011-4151-4444
*/

--○ 커서 이용 후 상황(다중 행 접근 시)

DECLARE
    V_NAME  TBL_INSA.NAME%TYPE;
    V_TEL   TBL_INSA.TEL%TYPE;
    
    -- 커서 이용을 위한 커서변수 선언(→ 커서 정의)
    CURSOR CUR_INSA_SELECT
    IS
    SELECT NAME, TEL
    FROM TBL_INSA;
    
    
BEGIN
    
    -- 커서 오픈
    OPEN CUR_INSA_SELECT;
    
    -- 커서 시 쏟아져나오는 데이터들 처리(잡아내기)
    LOOP
    -- 한 행 한 행 끄집어 내어 가져오는 행위 → 『FETCH』
        FETCH CUR_INSA_SELECT INTO V_NAME, V_TEL;
        
        EXIT WHEN CUR_INSA_SELECT%NOTFOUND;
     
     
    --출력
        DBMS_OUTPUT.PUT_LINE(V_NAME || ' , ' || V_TEL);
    END LOOP;
    CLOSE CUR_INSA_SELECT;
    
END;

--==>>
/*
홍길동 , 011-2356-4528
이순신 , 010-4758-6532
이순애 , 010-4231-1236
김정훈 , 019-5236-4221
한석봉 , 018-5211-3542
이기자 , 010-3214-5357
장인철 , 011-2345-2525
김영년 , 016-2222-4444
나윤균 , 019-1111-2222
김종서 , 011-3214-5555
유관순 , 010-8888-4422
정한국 , 018-2222-4242
조미숙 , 019-6666-4444
황진이 , 010-3214-5467
이현숙 , 016-2548-3365
이상헌 , 010-4526-1234
엄용수 , 010-3254-2542
이성길 , 018-1333-3333
박문수 , 017-4747-4848
유영희 , 011-9595-8585
홍길남 , 011-9999-7575
이영숙 , 017-5214-5282
김인수 , 
김말자 , 011-5248-7789
우재옥 , 010-4563-2587
김숙남 , 010-2112-5225
김영길 , 019-8523-1478
이남신 , 016-1818-4848
김말숙 , 016-3535-3636
정정해 , 019-6564-6752
지재환 , 019-5552-7511
심심해 , 016-8888-7474
김미나 , 011-2444-4444
이정석 , 011-3697-7412
정영희 , 
이재영 , 011-9999-9999
최석규 , 011-7777-7777
손인수 , 010-6542-7412
고순정 , 010-2587-7895
박세열 , 016-4444-7777
문길수 , 016-4444-5555
채정희 , 011-5125-5511
양미옥 , 016-8548-6547
지수환 , 011-5555-7548
홍원신 , 011-7777-7777
허경운 , 017-3333-3333
산마루 , 018-0505-0505
이기상 , 
이미성 , 010-6654-8854
이미인 , 011-8585-5252
권영미 , 011-5555-7548
권옥경 , 010-3644-5577
김싱식 , 011-7585-7474
정상호 , 016-1919-4242
정한나 , 016-2424-4242
전용재 , 010-7549-8654
이미경 , 016-6542-7546
김신제 , 010-2415-5444
임수봉 , 011-4151-4154
김신애 , 011-4151-4444
한혜림 , 010-5555-5555
*/

--++ 1062   박민지   960907-2234567   21/04/09   서울   010-6666-6666   기획부   대리   5000000   500000
-- 커서 이용하지 않을 때 --> 시작 값을 알아야 함


--------------------------------------------------------------------------------

--■■■ TRIGGER(트리거) ■■■--

-- 사전적인 의미 : 방아쇠, 촉발시키다, 야기하다, 유발하다.

-- 1. TRIGGER(트리거)란 DML 작업 즉, INSERT, UPDATE, DELETE 와 같은 작업이 일어날 대
--    자동적으로 실행되는(유발되는, 촉발되는) 객체로
--    이와 같은 특징을 강조하여(부각시켜) DML TRIGGER 라고 부르기도 한다.
--    TRIGGER 는 데이터 무결성 뿐 아니라
--    다음과 같은 작업에도 널리 사용된다.

--    ·자동으로 파생된 열 값 생성
--    ·잘못된 트랜잭션 방지
--    ·복잡한 보안 권한 강제 수행
--    ·분산데이터베이스 노드 상에서 참조 무결성 강제 수행
--    ·복잡한 업무 규칙 강제 적용
--    ·투명한 이벤트 로깅 제공
--    ·복잡한 감사 제공
--    ·동기 테이블 복제 유지관리
--    ·테이블 액세스 통계 수집


-- 2. TRIGGER 내에서는 COMMITM, ROLLBACK 문을 사용할 수 없다.

-- 3. 특징 및 종류

--  · BEFORE STATEMENT TRIGGER
--     SQL 구문이 실행되기 전에 그 문장에 대해 한 번 실행  -- 문장 하나(해당하는 문장 하나만 체크하는가)
--  · BEFORE ROW TRIGGER
--     SQL 구문이 실행되기 전에(DML 작업을 수행하지 전에)
--     각 행(ROW)에 대해 한 번씩 실행                      -- 각각의 행(레코드마다 체크해야 하는가)
--  · AFTER STATEMENT TRIGGER
--     SQL 구문이 실행된 후 그 문장에 대해 한 번 실행
--  · AFTER ROW TRIGGER
--     SQL 구문이 실행된 후에(DML 작업을 수행한 후에)
--     각 행(ROW)에 대해 한 번씩 실행


-- 4. 형식 및 구조
/*
CREATE [OR REPLACE] TRIGGER 트리거명
    [BEFORE] | [AFTER]
    이벤트1 [OR 이벤트2 [OR 이벤트3]] ON 테이블명
    [FOR EACH ROW [WHEN TRIGGER 조건]]
[DECLARE]
    -- 선언 구문;
BEGIN 
    -- 실행 구문;
END;
*/




--■■■ AFTER STATEMENT TRIGGER 상황 실습 ■■■--
-- ※ DML 작업에 대한 이벤트 기록

--○ TRIGGER(트리거) 생성(TRG_EVENTLOG)
CREATE OR REPLACE TRIGGER TRG_EVENTLOG
        AFTER
        INSERT OR UPDATE OR DELETE ON TBL_TEST1
DECLARE
BEGIN
    -- 이벤트 종류 구분(조건문을 통한 분기)
    -- 구분에 대한 키워드 CHECK~!!!
    IF (INSERTING)
        THEN INSERT INTO TBL_EVENTLOG(MEMO)
            VALUES('INSERT 쿼리문이 수행되었습니다.');
    ELSIF (UPDATING)
        THEN INSERT INTO TBL_EVENTLOG(MEMO)
            VALUES('UPDATE 쿼리문이 수행되었습니다.');
    ELSIF (DELETING)
        THEN INSERT INTO TBL_EVENTLOG(MEMO)
            VALUES('DELETE 쿼리문이 수행되었습니다.');
    END IF;
    
    --COMMIT;
    -- ※ TRIGGER 내에서는 COMMIT 구문 사용 금지~!!!
    
END;
--==>> Trigger TRG_EVENTLOG이(가) 컴파일되었습니다.



--■■■ BEFORE STATEMENT TRIGGER 상황 실습 ■■■--
--※ DML 작업 수행 전에 작업 가능여부 확인
--   (보안 정책 허용 / 업무 규칙 적용)

--○ TRIGGER(트리거) 작성(TRG_TEST1_DML)

CREATE OR REPLACE TRIGGER TRG_TEST1_DML
        BEFORE
        INSERT OR UPDATE OR DELETE ON TBL_TEST1
BEGIN
    IF (시간이 오전 8시 이전이거나... 오후 6시 이후라면...)
    THEN 작업을 하지 못하도록 처리하겠다.
    
    END IF;
END;



CREATE OR REPLACE TRIGGER TRG_TEST1_DML
        BEFORE
        INSERT OR UPDATE OR DELETE ON TBL_TEST1
BEGIN
    IF (TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) < 8 OR 
       (TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) > 17   -- 18 이라고 하면 18:04분에서 시만 추출했을 때 18이 되므로...
    THEN 예외를 발생시키도록 하겠다.
    
    END IF;
END;



CREATE OR REPLACE TRIGGER TRG_TEST1_DML
    BEFORE 
    INSERT OR UPDATE OR DELETE ON TBL_TEST1
BEGIN
    IF (TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) < 8 OR
        TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) >= 18)
        THEN RAISE_APPLICATION_ERROR(-20005, '작업은 08 ~ 18:00 까지만 가능합니다.');
    END IF;
    
    /*
    IF (TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) <= 7 OR
        TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) > 17)
        THEN 예외를 발생시키도록 하겠다.
    END IF;
    */
END;


--■■■ BEFORE ROW TRIGGER 상황 실습 ■■■--
--※ 참조 관계가 설정된 데이터(자식) 삭제를 먼저 수행하는 모델

-- 각각의 행들을 다 뒤져서 부모를 참조하고 있는 자식을 다 찾음.
-- 부모를 제거하기 '이전'으로 돌아가서 자식을 제거하겠다.

-- ① 부모를 14:00시에 지운다 --> 시간을 되돌려서 자식을 지운다! 기억할 것
DELETE
FROM TBL_TEST2
WHERE CODE = 1;
    
-- ② 13:59:59에 수행되는 것.. ①은 미래. 즉 ①이 실행될 때 이 코드는 없다.
--○ TRIGGER(트리거) 작성(TRG_TEST2_DELETE)
CREATE OR REPLACE TRIGGER TRG_TEST2_DELETE
          BEFORE
          DELETE ON TBL_TEST2
          FOR EACH ROW
DECLARE
BEGIN
    DELETE
    FROM TBL_TEST3
    WHERE CODE = :OLD.CODE;  -- 14시에 이미 지워진 1번.. 즉 OLD 를 데려와서 지우는 것..
END;

--※ 『:OLD』
--   참조 전 열의 값
--   (INSERT : 입력하기 이전 자료, DELETE : 삭제하기 이전 자료 즉, 삭제할 자료)

--※ UPDATE → DELETE + INSERT ... 기존에 있던 걸 지우고 새로운 걸 INSERT
--             이 과정에서 UPDATE 하기 이전의 자료는 :OLD
--             이 과정에서 UPDATE 한 후의 자료는 :NEW -- 커밋해야 테이블 안에 제대로 들어가는 것


--■■■ AFTER ROW TRIGGER 상황 실습 ■■■--
--※ 참조 테이블 관련 트랜잭션 처리

-- TBL_상품, TBL_입고, TBL_출고
--    0         10  
--   10                   20    X
--  -10


--○ TBL_입고 테이블의 데이터 입력 시(입고 이벤트 발생 시)
--   TBL_상품 테이블의 재고수량 변동 트리거 작성
CREATE OR REPLACE TRIGGER TRG_IBGO
         AFTER 
         INSERT ON TBL_입고
         FOR EACH ROW
BEGIN
    IF (INSERTING)
        THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 + 새로입고되는 입고수량
             WHERE 상품코드 = 새로입고되는 상품코드;
    END IF;
END;


-- INSERT INTO TBL_입고(..상품코드..입고수량..)
-- VALUES(.'H001'..10..);

CREATE OR REPLACE TRIGGER TRG_IBGO
         AFTER 
         INSERT ON TBL_입고
         FOR EACH ROW
BEGIN
    IF (INSERTING)
        THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 + :NEW.입고수량
             WHERE 상품코드 = :NEW.상품코드;
    END IF;
END;


--○ TBL_상품, TBL_입고, TBL_출고의 관계에서
--   입고수량, 재고수량의 트랜잭션 처리가 이루어질 수 있도록
--   TRG_IBGO 트리거를 수정한다.

CREATE OR REPLACE TRIGGER TRG_IBGO
         AFTER 
         INSERT OR UPDATE OR DELETE ON TBL_입고
         FOR EACH ROW
BEGIN
    IF (INSERTING)
        THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 + :NEW.입고수량
             WHERE 상품코드 = :NEW.상품코드;
    END IF;
    
    IF (UPDATING)
        THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 - :OLD.입고수량 + :NEW.입고수량
             WHERE 상품코드 = :NEW.상품코드;
    END IF;
    
    IF (DELETING)
         THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 - :OLD.입고수량 
             WHERE 상품코드 = :OLD.상품코드;
    END IF;
END;



--○ TBL_상품, TBL_입고, TBL_출고 의 관계에서
--   출고수량, 재고수량의 트랜잭션 처리가 이루어질 수 있도록
--   TRG_CHULGO 트리거를 수정한다


CREATE OR REPLACE TRIGGER TRG_CHULGO
         AFTER 
         INSERT OR UPDATE OR DELETE ON TBL_출고
         FOR EACH ROW
BEGIN
    IF (INSERTING)
        THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 - :NEW.출고수량
             WHERE 상품코드 = :NEW.상품코드;
    END IF;
    
    IF (UPDATING)
        THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 + :OLD.출고수량 - :NEW.출고수량
             WHERE 상품코드 = :NEW.상품코드;
    END IF;
    
    IF (DELETING)
         THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 + :OLD.출고수량 
             WHERE 상품코드 = :OLD.상품코드;
    END IF;
    
END;