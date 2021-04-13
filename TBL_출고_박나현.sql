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



----------------20210412_02_SCOTT에서의 테스트 결과-------------

--○ 트리거 실행 전 

INSERT INTO TBL_입고(입고번호, 상품코드, 입고일자, 입고수량, 입고단가)
VALUES(1, 'H001', SYSDATE, 200, 1000);
--==>> 1 행 이(가) 삽입되었습니다.

SELECT *
FROM TBL_출고;
--==>> 조회 결과 없음

SELECT *
FROM TBL_상품;
--==>> H001	홈런볼	1500	200


--○ 출고 테이블에 출고 이벤트 발생

INSERT INTO TBL_출고(출고번호, 상품코드, 출고일자, 출고수량, 출고단가)
VALUES(1, 'H001', SYSDATE, 100, 1200);
--==>> 1 행 이(가) 삽입되었습니다.

SELECT *
FROM TBL_출고;
--==>> 1	H001	21/04/13	100	1200

SELECT *
FROM TBL_상품;
--==>> H001	홈런볼	1500	100


--○ 출고 테이블에 출고 수정 발생

UPDATE TBL_출고
SET 출고수량 = 50
WHERE 상품코드 = 'H001';
--==>> 1 행 이(가) 업데이트되었습니다.

SELECT *
FROM TBL_출고;
--==>> 1	H001	21/04/13	50	1200
     
SELECT *
FROM TBL_상품;
--==>> H001	홈런볼	1500	150



--○ 출고 테이블에 출고 삭제 발생

DELETE
FROM TBL_출고
WHERE 상품코드 = 'H001';
--==>> 1 행 이(가) 삭제되었습니다.

SELECT *
FROM TBL_출고;
--==>> 조회 결과 없음
     
SELECT *
FROM TBL_상품;
--==>> H001	홈런볼	1500	200