--○ 접속된 사용자 확인
SELECT USER
FROM DUAL;
--==>> PNH


-- 컬럼명 데이터타입;
-- NUMBER은 숫자타입(길이. 10자리 숫자 구성하겠다~)
--○ 테이블 생성(테이블명 : TBL_ORAUSERTEST)

CREATE TABLE TBL_ORAUSERTEST
( NO    NUMBER(10) 
  ,NAME  VARCHAR2(30) 
);

--==>> 에러 발생
/*
CREATE TABLE TBL_ORAUSERTEST
( NO    NUMBER(10) 
  NAME  VARCHAR2(30) 
  
)
/*
오류 보고 -
ORA-01031: insufficient privileges
01031. 00000 -  "insufficient privileges"
*Cause:    An attempt was made to perform a database operation without
           the necessary privileges.
*Action:   Ask your database administrator or designated security
           administrator to grant you the necessary privileges
           */

--> 현재 pnh 계정은 CREATE SESSION 권한만 갖고 있으며
--  테이블을 생성할 수 있는 권한은 갖고 있지 않은 상태이다.
--  그러므로 관리자로부터 테이블 생성 권한을 부여받아야 한다.


--○ SYS로부터... CREATE TABLE 권한을 부여받은 후
--   다시 테이블 생성(테이블명 : TBL_ORAUSERTEST)
CREATE TABLE TBL_ORAUSERTEST
( NO    NUMBER(10) 
  ,NAME  VARCHAR2(30) 
);

--==>>
/*
오류 보고 -
ORA-01950: no privileges on tablespace 'TBS_EDUA'
01950. 00000 -  "no privileges on tablespace '%s'"          테이블스페이스는 TBS_EDUA로 아까 디폴트 해놓음.. 근데 이걸 얼마나 쓸지 공간 할당을 못 받음.. 
*Cause:    User does not have privileges to allocate an extent in the
           specified tablespace.
*Action:   Grant the user the appropriate system privileges or grant the user
           space resource on the tablespace.
*/

-- 할당량 : 개인용 운영체제는 오직 나를 위해서만 할당. 
-- 윈도우 서버용 운영체제는.. 여러 사람들이 리소스를 나눠 가질 수 있도록 구성해야함.
-- pnh는 집을 지을 사람이라는 허가는 받았지만 집 지을 땅은 없는 상태~! 위의 에러가 의미하는 것..!
--> 테이블 생성 권한(CREATE TABLE)까지 부여받은 상황이지만
--  pnh 사용자 계정의 기본 테이블 스페이스(DEFAULT TABLESPACE → TBS_EDUA)에 대한
--  할당량을 부여받지 못한 상태.
--  그러므로 이 테이블스페이스를 사용할 권한이 없다는 에러메세지를
--  오라클이 출력해 주고 있는 상황.


--○ SYS로부터... 테이블스페이스(TBS_EDUA)에 대한 할당량을 부여받은 이후
--   다시 테이블 생성(테이블명 : TBL_ORAUSERTEST)
CREATE TABLE TBL_ORAUSERTEST
( NO    NUMBER(10) 
  ,NAME  VARCHAR2(30) 
);
--==>> Table TBL_ORAUSERTEST이(가) 생성되었습니다.


-- ※ 자신에게 부여된 할당량 조회
SELECT *
FROM USER_TS_QUOTAS;
--==>> TBS_EDUA	65536	-1	8	-1	NO


--○ 생성된 테이블(TBL_ORAUSERTEST)이
--   어떤 테이블스페이스에 저장되어 있는지 조회
SELECT TABLE_NAME, TABLESPACE_NAME
FROM USER_TABLES;
--==>> TBL_ORAUSERTEST	TBS_EDUA