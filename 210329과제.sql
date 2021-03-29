
--○ 과제
--   본인이 태어나서 현재까지...
--   얼마만큼의 일, 시간, 분, 초를 살았는지...
--   조회하는 쿼리문을 구성한다.

/*
----------------------------------------------------------------------
현재 시각               | 태어난 시각          | 일  | 시간 | 분 | 초
----------------------------------------------------------------------
2021-03-29 14:34:27     | 1992-08-13 22:00:00 | 110 | 3    | 15 | 33
----------------------------------------------------------------------
*/




-- 날짜 형식 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';


-- 태어났을 때부터 지금까지를 초로 계산

SELECT (SYSDATE - TO_DATE('1992-08-13 22:00:00', 'YYYY-MM-DD HH24:MI:SS'))*(24*60*60)
FROM DUAL;


SELECT 현재 시각, 태어난 시각, 일, 시간, 분, 초
FROM DUAL;


방법1)

SELECT SYSDATE
     , 전체 초를 분으로 환산한 나머지 → 초 EX) 2000000초 → 333분 20.XX초 → 20초
     , 전체 초를 시로 환산한 나머지 → 분                → 5시간 33분 XX초 → 33분
     , 전체 초를 일로 환산한 나머지 → 시                → 2일 XXX시간 → 2일
FROM DUAL;

SELECT SYSDATE
     , TO_DATE('1992-08-13 22:00:00') "태어난 시각"
     , TRUNC(SYSDATE - TO_DATE('1992-08-13 22:00:00')) "일"
     , TRUNC(MOD((SYSDATE - TO_DATE('1992-08-13 22:00:00'))*24, 24)) "시간"
     , TRUNC(MOD((SYSDATE - TO_DATE('1992-08-13 22:00:00'))*24*60, 60)) "분"
     , TRUNC(MOD((SYSDATE - TO_DATE('1992-08-13 22:00:00'))*24*60*60, 60)) "초"
FROM DUAL;
--==>> 2021-03-30 00:27:08	1992-08-13 22:00:00	10455	2	27	7


