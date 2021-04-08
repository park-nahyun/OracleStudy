--○ 과제로 생성한 함수 확인용
SELECT *
FROM TBL_INSA;

-- 나와야 할 결과물(함수 결과값과 비교할 결과값)
SELECT NAME "이름", BASICPAY "기본급", SUDANG "수당", BASICPAY * 12 + NVL(SUDANG, 0) "급여"
     , IBSADATE "입사일", SYSDATE, TRUNC((SYSDATE-IBSADATE)/365, 1) "근무년수"
FROM TBL_INSA;
--==>>
/*
홍길동	2610000	200000	31520000	98/10/11	21/04/09	22.5
이순신	1320000	200000	16040000	00/11/29	21/04/09	20.3
이순애	2550000	160000	30760000	99/02/25	21/04/09	22.1
김정훈	1954200	170000	23620400	00/10/01	21/04/09	20.5
한석봉	1420000	160000	17200000	04/08/13	21/04/09	16.6
                    :
                    :
*/

-- 함수 결과값
SELECT NAME "이름", FN_PAY(BASICPAY, SUDANG) "급여함수", FN_WORKYEAR(IBSADATE) "근무년함수"
FROM TBL_INSA;
--==>>
/*
홍길동	31520000	22.5
이순신	16040000	20.3
이순애	30760000	22.1
김정훈	23620400	20.5
한석봉	17200000	16.6
이기자	27330000	19.1
장인철	15150000	23
김영년	11545000	18.9
나윤균	10300400	17.5
김종서	30610000	23.6
유관순	12380000	20.7
정한국	10674000	21.4
조미숙	19315000	22.8
황진이	13330000	19.1
이현숙	12704000	21.7
이상헌	28350000	19.3
엄용수	11610000	20.6
이성길	10683000	16.6
박문수	27765000	21.3
유영희	10700000	17.5
홍길남	10620000	19.6
이영숙	23700000	18.1
김인수	30170000	26.1
김말자	22970000	21.6
우재옥	13360000	20.5
김숙남	12750000	18.6
김영길	28250000	20.4
이남신	10814000	19.6
김말숙	11164000	20.5
정정해	27772000	21.4
지재환	29560000	20.2
심심해	10668000	20.9
김미나	12344000	22.8
이정석	13360000	15.5
정영희	12740000	18.9
이재영	11714800	17.6
최석규	28387000	22.4
손인수	24150000	21.4
고순정	24280000	17.2
박세열	25330000	20.5
문길수	27750000	19.3
채정희	12440000	17.4
양미옥	13410000	17.5
지수환	12940000	17.2
홍원신	11672000	18
허경운	31950000	21.9
산마루	25312000	19.7
이기상	24706000	19.8
이미성	15730000	21
이미인	23503000	17.8
권영미	27224000	20.8
권옥경	12345000	20.5
김싱식	11628000	21.3
정상호	11874000	21.4
정한나	12104000	16.8
전용재	23600000	16.6
이미경	30400000	23.1
김신제	23580000	17.6
임수봉	10782000	19.5
김신애	10902000	19.5
*/
