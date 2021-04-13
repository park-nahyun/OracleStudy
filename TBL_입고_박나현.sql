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




----------------20210412_02_SCOTT에서의 테스트 결과-------------

--○ 트리거 실행 전 
SELECT *
FROM TBL_입고;
--==>> 조회 결과 없음

SELECT *
FROM TBL_상품;
--==>> H001	홈런볼	1500	0


--○ 입고 테이블에 입고 이벤트 발생

INSERT INTO TBL_입고(입고번호, 상품코드, 입고일자, 입고수량, 입고단가)
VALUES(1, 'H001', SYSDATE, 100, 1000);
--==>> 1 행 이(가) 삽입되었습니다.

SELECT *
FROM TBL_입고;
--==>> 1	H001	21/04/13	100	1000

SELECT *
FROM TBL_상품;
--==>> H001	홈런볼	1500	100


--○ 입고 테이블에 입고 수정 발생

UPDATE TBL_입고
SET 입고수량 = 200
WHERE 상품코드 = 'H001';
--==>> 1 행 이(가) 업데이트되었습니다.

SELECT *
FROM TBL_입고;
--==>> 1	H001	21/04/13	200	1000

SELECT *
FROM TBL_상품;
--==>> H001	홈런볼	1500	200



--○ 입고 테이블에 입고 내역 삭제 발생

DELETE
FROM TBL_입고
WHERE 상품코드 = 'H001';
--==>> 1 행 이(가) 삭제되었습니다.

SELECT *
FROM TBL_입고;
--==>> 조회 결과 없음

SELECT *
FROM TBL_상품;
--==>> H001	홈런볼	1500	0
