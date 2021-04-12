
SELECT USER
FROM DUAL;
--==>> SCOTT

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.


SELECT *
FROM TBL_입고;
--==>>
/*
1	H001	2021-04-09	20	400
2	H002	2021-04-09	30	500
3	H003	2021-04-09	40	600
4	H004	2021-04-09	50	700
5	H005	2021-04-09	60	800
6	H006	2021-04-09	70	900
7	H007	2021-04-09	80	1000
8	C001	2021-04-09	30	800
9	C002	2021-04-09	40	900
10	C003	2021-04-09	50	1000
11	C004	2021-04-09	60	1100
12	C005	2021-04-09	70	1200
13	C006	2021-04-09	80	1300
14	C007	2021-04-09	90	1400
15	E001	2021-04-09	80	990
16	E002	2021-04-09	70	880
17	E003	2021-04-09	60	770
18	E004	2021-04-09	50	660
19	E005	2021-04-09	40	550
20	E006	2021-04-09	30	440
21	E007	2021-04-09	20	330
*/
SELECT *
FROM TBL_출고;
--==>>
/*
1	H001	2021-04-12	1	1100
2	H002	2021-04-12	2	1200
3	H003	2021-04-12	3	1300
4	H004	2021-04-12	4	1400
5	H005	2021-04-12	5	1500
6	H006	2021-04-12	6	1600
7	H007	2021-04-12	7	1700
8	C001	2021-04-12	1	1100
9	C002	2021-04-12	2	1200
10	C003	2021-04-12	3	1300
11	C004	2021-04-12	4	1400
12	C005	2021-04-12	5	1500
13	C006	2021-04-12	6	1600
14	C007	2021-04-12	7	1700
15	E001	2021-04-12	2	1900
16	E002	2021-04-12	3	1910
17	E003	2021-04-12	4	1920
18	E004	2021-04-12	5	1930
19	E005	2021-04-12	6	1940
20	E006	2021-04-12	7	1950
21	E007	2021-04-12	8	1960
*/
SELECT *
FROM TBL_상품;
--==>>
/*
H001	홈런볼	1500	19
H002	새우깡	1200	28
H003	자갈치	1000	37
H004	감자깡	 900	46
H005	꼬깔콘	1100	55
H006	꼬북칩	2000	64
H007	맛동산	1700	73
C001	다이제	2000	29
C002	사브레	1800	38
C003	에이스	1700	47
C004	버터링	1900	56
C005	아이비	1700	65
C006	웨하스	1200	74
C007	오레오	1900	83
E001	엠엔엠 	 600	78
E002	아폴로	 500	67
E003	쫀드기	 300	56
E004	비틀즈	 600	45
E005	마이쮸	 800	34
E006	에그몽	 900	23
E007	차카니	 900	12
*/

--○ 생성된 프로시저 정상 작동여부 확인
-- → 프로시저 호출
-- 『재고19/출고1』인 홈런볼 출고내역 변경
EXEC PRC_출고_UPDATE(1,21);
--==>> 에러 발생 
-- ORA-20002: 재고 부족~~!!!

SELECT *
FROM TBL_입고;
SELECT *
FROM TBL_출고;
SELECT *
FROM TBL_상품;

EXEC PRC_출고_UPDATE(1,20);
--==>>PL/SQL 프로시저가 성공적으로 완료되었습니다.

SELECT *
FROM TBL_상품;
--==>>
/*
H001	홈런볼	1500	 0
H002	새우깡	1200	28
H003	자갈치	1000	37
H004	감자깡	 900	46
H005	꼬깔콘	1100	55
H006	꼬북칩	2000	64
H007	맛동산	1700	73
C001	다이제	2000	29
C002	사브레	1800	38
C003	에이스	1700	47
C004	버터링	1900	56
C005	아이비	1700	65
C006	웨하스	1200	74
C007	오레오	1900	83
E001	엠엔엠	 600	78
E002	아폴로	 500	67
E003	쫀드기	 300	56
E004	비틀즈	 600	45
E005	마이쮸	 800	34
E006	에그몽	 900	23
E007	차카니	 900	12
*/


SELECT *
FROM TBL_출고
--==>> 1	H001	2021-04-12	20	1100

ROLLBACK;

SELECT *
FROM TBL_입고;

SELECT *
FROM TBL_상품;

EXEC PRC_입고_UPDATE(1,23);

EXEC PRC_입고_DELETE(1);

EXEC PRC_출고_DELETE(1);



---------------------------------------------------------------------------------------

--○ 트리거 실습 관련 테이블 생성(TBL_TEST1)
CREATE TABLE TBL_TEST1
( ID    NUMBER
, NAME  VARCHAR2(30)
, TEL   VARCHAR2(60)
);
--==>> Table TBL_TEST1이(가) 생성되었습니다.

--○ 생성된 테이블에 제약조건 추가
--   ID 컬럼에 PK 제약조건 지정

ALTER TABLE TBL_TEST1
ADD CONSTRAINT TEST1_ID_PK PRIMARY KEY(ID);
--==>> Table TBL_TEST1이(가) 변경되었습니다.


--○ 트리거 실습 관련 테이블 생성(TBL_EVENTLOG)
CREATE TABLE TBL_EVENTLOG
( MEMO VARCHAR2(200)
, INJA DATE DEFAULT SYSDATE
);
--==>> Table TBL_EVENTLOG이(가) 생성되었습니다.

SELECT *
FROM TBL_TEST1;
--==>> 조회 결과 없음

SELECT *
FROM TBL_EVENTLOG;
--==>> 조회 결과 없음


--○ 날짜 세션 정보 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session이(가) 변경되었습니다.



--○ TBL_TEST1 테이블의 데이터 삽입
INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(1, '김가영', '010-1111-1111');
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(2, '김서현', '010-2222-2222');
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(3, '이유림', '010-3333-3333');
--==>> 1 행 이(가) 삽입되었습니다.


--○ TBL_TEST1 테이블의 데이터 업데이트
UPDATE TBL_TEST1
SET NAME = '김나영'
WHERE ID = 1;
---==>> 1 행 이(가) 업데이트되었습니다.

UPDATE TBL_TEST1
SET NAME = '김다영'
WHERE ID = 1;
---==>> 1 행 이(가) 업데이트되었습니다.

UPDATE TBL_TEST1
SET NAME = '김동현'
WHERE ID = 2;
---==>> 1 행 이(가) 업데이트되었습니다.


--○ TBL_TEST1 테이블의 데이터 삭제

DELETE
FROM TBL_TEST1
WHERE ID = 3;
--==>> 1 행 이(가) 삭제되었습니다.

DELETE
FROM TBL_TEST1
WHERE ID = 2;
--==>> 1 행 이(가) 삭제되었습니다.

DELETE
FROM TBL_TEST1
WHERE ID = 1;
--==>> 1 행 이(가) 삭제되었습니다.


--○ 확인
SELECT *
FROM TBL_TEST1;


--○ TBL_EVENTLOG
SELECT *
FROM TBL_EVENTLOG;
--==>>
/*
INSERT 쿼리문이 수행되었습니다.	2021-04-12 15:23:14
INSERT 쿼리문이 수행되었습니다.	2021-04-12 15:23:14
INSERT 쿼리문이 수행되었습니다.	2021-04-12 15:23:14
UPDATE 쿼리문이 수행되었습니다.	2021-04-12 15:23:38
UPDATE 쿼리문이 수행되었습니다.	2021-04-12 15:23:57
UPDATE 쿼리문이 수행되었습니다.	2021-04-12 15:24:16
DELETE 쿼리문이 수행되었습니다.	2021-04-12 15:25:17
DELETE 쿼리문이 수행되었습니다.	2021-04-12 15:25:24
DELETE 쿼리문이 수행되었습니다.	2021-04-12 15:25:38
*/


--○ 오라클 서버의 시간이 16:03 인 상태로 테스트
INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(4, '박민지', '010-4444-4444');
--==>> 1 행 이(가) 삽입되었습니다.


UPDATE TBL_TEST1
SET TEL = '010-4141-4141'
WHERE ID = 4;
--==>> 1 행 이(가) 업데이트되었습니다.

DELETE
FROM TBL_TEST1
WHERE ID = 4;
--==>> 1 행 이(가) 삭제되었습니다.


COMMIT;

--○ 오라클 서버의 시간을 19:07 인 상태로 테스트
INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(5, '심혜진', '010-5555-5555');
--==>> 에러 발생
/*
ORA-20005: 작업은 08 ~ 18:00 까지만 가능합니다.
*/


--○ BEFORE ROW TRIGGER 실습 진행을 위한 테이블 생성(TBL_TEST2) → 부모 테이블
CREATE TABLE TBL_TEST2
( CODE NUMBER
, NAME VARCHAR2(40)
, CONSTRAINT TEST2_CODE_PK PRIMARY KEY(CODE)
);
--==>> Table TBL_TEST2이(가) 생성되었습니다.

--○ BEFORE ROW TRIGGER 실습 진행을 위한 테이블 생성(TBL_TEST3) → 자식테이블
CREATE TABLE TBL_TEST3
( SID    NUMBER
, CODE   NUMBER
, SU     NUMBER
, CONSTRAINT TEST3_SID_PK PRIMARY KEY(SID)
, CONSTRAINT TEST3_CODE_FK FOREIGN KEY(CODE)
             REFERENCES TBL_TEST2(CODE)
);


--○ 부모 테이블에 데이터 입력
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(1, '냉장고');
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(2, '세탁기');
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(3, '건조기');

SELECT *
FROM TBL_TEST2;
--==>>
/*
1	냉장고
2	세탁기
3	건조기
*/

COMMIT;
--==>> 커밋 완료.


--○ 자식 테이블에 데이터 입력

INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(1, 1, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(2, 1, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(3, 1, 40);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(4, 2, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(5, 2, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(6, 2, 40);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(7, 1, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(8, 2, 20);
--==>> 1 행 이(가) 삽입되었습니다. * 8

SELECT *
FROM TBL_TEST3;
--==>>
/*
1	1	20
2	1	30
3	1	40
4	2	20
5	2	30
6	2	40
7	1	20
8	2	20
*/

COMMIT;
--==>> 커밋 완료.


SELECT C.SID, P.CODE, P.NAME, C.SU
FROM TBL_TEST2 P JOIN TBL_TEST3 C
ON P.CODE = C.CODE;


DELETE
FROM TBL_TEST2
WHERE CODE=1;
--==>> 에러발생
/*
ORA-02292: integrity constraint (SCOTT.TEST3_CODE_FK) violated - child record found
*/


DELETE
FROM TBL_TEST2
WHERE CODE=3;
--==>> 1 행 이(가) 삭제되었습니다.



--○ 트리거 작성 이후 다시 테스트
DELETE
FROM TBL_TEST2
WHERE CODE=1;
--==>> 1 행 이(가) 삭제되었습니다.

SELECT * 
FROM TBL_TEST2;

SELECT * 
FROM TBL_TEST3;

COMMIT;
--==>> 커밋 완료;


--○ 트리거 실습 전에 테이블 정리
TRUNCATE TABLE TBL_입고;
--==>> Table TBL_입고이(가) 잘렸습니다.

TRUNCATE TABLE TBL_출고;
--==>> Table TBL_출고이(가) 잘렸습니다.


UPDATE TBL_상품
SET 재고수량 = 0;
--==>> 21개 행 이(가) 업데이트되었습니다.

COMMIT;
--==>> 커밋 완료


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

