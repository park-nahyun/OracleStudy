SELECT USER
FROM DUAL;
--==>> HR


--■■■ DEFUALT 표현식 ■■■--

-- 1. INSERT 와 UPDATE 문에서
--    사용자가 전달하는 특정 값이 아닌
--    기본 값을 입력하도록 처리할 수 있다.


-- 2. 형식 및 구조
--    컬럼 명 데이터 타입 DEFAULT 기본값

-- 3. INSERT 명령 시 해당 컬럼에 입력될 값을 할당하지 않거나
--    DEFAULT 키워드를 활용하여 기본 값을 입력하도록 할 수 있다.

-- 4. DEFAULT 키워드와 다른 제약(NOT NULL 등) 표기가 같이 오는 경우
--    DEFAULT 키워드를 먼저 표기(작성)할 것을 권장한다.

--○ DEFAULT 표현식 실습
-- 테이블 생성
CREATE TABLE TBL_BOARD                          -- 게시판 테이블 생성
( SID       NUMBER          PRIMARY KEY         -- 게시물 번호 → 식별자(자동 증가)
, NAME      VARCHAR2(30)                        -- 게시물 작성자
, CONTENTS  VARCHAR2(2000)                      -- 게시물 내용
, WRITEDAY  DATE            DEFAULT SYSDATE     -- 게시물 작성일(현재 날짜 자동 입력)
, COMMENTS  NUMBER          DEFAULT 0           -- 게시물 댓글 개수(기본값 0)
, COUNTS    NUMBER          DEFAULT 0           -- 게시물 조회수(기본값 0)
);
--==>> Table TBL_BOARD이(가) 생성되었습니다.

--※ SID 를 자동 증가 값으로 운영하려면 시퀀스 객체가 필요하다.
--   자동으로 입력되는 컬럼은 사용자가 입력해야 하는 항목에서
--   제외시킬 수 있다.


-- 시퀀스 생성
CREATE SEQUENCE SEQ_BOARD
NOCACHE;
--==>> Sequence SEQ_BOARD이(가) 생성되었습니다.


-- 세선 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session이(가) 변경되었습니다.



-- 게시물 작성
INSERT INTO TBL_BOARD(SID, NAME, CONTENTS, WRITEDAY, COMMENTS, COUNTS)
VALUES(SEQ_BOARD.NEXTVAL, '이상화', '오라클에서 DEFAULT 표현식을 실습중입니다.'
     , TO_DATE('2021-04-06 11:01:13', 'YYYY-MM-DD HH24:MI:SS'), 0, 0);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD(SID, NAME, CONTENTS, WRITEDAY, COMMENTS, COUNTS)
VALUES(SEQ_BOARD.NEXTVAL, '소서현', '계속 실습중입니다.', SYSDATE, 0, 0);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD(SID, NAME, CONTENTS, WRITEDAY, COMMENTS, COUNTS)
VALUES(SEQ_BOARD.NEXTVAL, '이희주', '힘껏 실습중입니다.', DEFAULT, DEFAULT, DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD(SID, NAME, CONTENTS)  -- DEFAULT는 빼도 됨. 원래는 NULL이 되겠지만..여기선 디폴트가 있으므로...
VALUES(SEQ_BOARD.NEXTVAL, '선혜연', '힘껏 실습중입니다.');
--==>> 1 행 이(가) 삽입되었습니다.


SELECT *
FROM TBL_BOARD;
--==>>
/*
6	이상화	오라클에서 DEFAULT 표현식을 실습중입니다.	2021-04-06 11:01:13	0	0
7	소서현	계속 실습중입니다.	                    2021-04-07 09:33:32	0	0
8	이희주	힘껏 실습중입니다.	                    2021-04-07 09:33:35	0	0
9	선혜연	힘껏 실습중입니다.	                    2021-04-07 09:33:36	0	0
*/

COMMIT;
--==>> 커밋 완료


--○ DEFAULT 표현식 확인(조회)

SELECT *
FROM USER_TAB_COLUMNS
WHERE TABLE_NAME = 'TBL_BOARD';
--==>>
/*
TBL_BOARD	SID	        NUMBER			22			N	1													NO	NO		0		NO	YES	NONE
TBL_BOARD	NAME	    VARCHAR2		30			Y	2											CHAR_CS	30	NO	NO		30	B	NO	YES	NONE
TBL_BOARD	CONTENTS	VARCHAR2		2000		Y	3											CHAR_CS	2000	NO	NO		2000	B	NO	YES	NONE
TBL_BOARD	WRITEDAY	DATE			7			Y	4	8	"SYSDATE"											NO	NO		0		NO	YES	NONE
TBL_BOARD	COMMENTS	NUMBER			22			Y	5	2	"0"											NO	NO		0		NO	YES	NONE
TBL_BOARD	COUNTS	    NUMBER			22			Y	6	2	"0"											NO	NO		0		NO	YES	NONE
*/


SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE, DATA_DEFAULT
FROM USER_TAB_COLUMNS
WHERE TABLE_NAME = 'TBL_BOARD';
--==>>
/*
TBL_BOARD	SID	        NUMBER	    (null)
TBL_BOARD	NAME	    VARCHAR2	(null)
TBL_BOARD	CONTENTS	VARCHAR2	(null)
TBL_BOARD	WRITEDAY	DATE	    "SYSDATE"
TBL_BOARD	COMMENTS	NUMBER  	"0"
TBL_BOARD	COUNTS	    NUMBER	    "0"
*/


--○ 테이블 생성 이후 DEFAULT 표현식 추가  / 변경
ALTER TABLE 테이블명
MODIFY 컬럼명 [자료형] DEFAULT 기본값;


--○ 생성된 DEFAULT 표현식 제거(삭제)
ALTER TABLE 테이블명
MODIFY 컬럼명 [자료형] DEFAULT NULL;
