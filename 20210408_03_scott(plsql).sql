SET SERVEROUTPUT ON;
--==>> �۾��� �Ϸ�Ǿ����ϴ�.

SELECT USER
FROM DUAL;


-- SCOTT_TBL_INSA ���̺��� ���� ���� ������ ���� ���� ������ ����
-- (�ݺ��� Ȱ�� ���)
DECLARE
    VINSA   TBL_INSA%ROWTYPE;
    VNUM    TBL_INSA.NUM%TYPE := 1001;
BEGIN
    LOOP
        SELECT NAME, TEL, BUSEO
            INTO VINSA.NAME, VINSA.TEL, VINSA.BUSEO
        FROM TBL_INSA
        WHERE NUM = VNUM;
        
        DBMS_OUTPUT.PUT_LINE(VINSA.NAME || ' - ' || VINSA.TEL || ' - ' || VINSA.BUSEO);
        
        EXIT WHEN VNUM >= 1060;
        
        VNUM := VNUM + 1;       -- VNUM �� 1��ŭ ����
        
    END LOOP;

END;
--==>>
/*
ȫ�浿 - 011-2356-4528 - ��ȹ��
�̼��� - 010-4758-6532 - �ѹ���
�̼��� - 010-4231-1236 - ���ߺ�
������ - 019-5236-4221 - ������
�Ѽ��� - 018-5211-3542 - �ѹ���
�̱��� - 010-3214-5357 - ���ߺ�
����ö - 011-2345-2525 - ���ߺ�
�迵�� - 016-2222-4444 - ȫ����
������ - 019-1111-2222 - �λ��
������ - 011-3214-5555 - ������
������ - 010-8888-4422 - ������
���ѱ� - 018-2222-4242 - ȫ����
���̼� - 019-6666-4444 - ȫ����
Ȳ���� - 010-3214-5467 - ���ߺ�
������ - 016-2548-3365 - �ѹ���
�̻��� - 010-4526-1234 - ���ߺ�
����� - 010-3254-2542 - ���ߺ�
�̼��� - 018-1333-3333 - ���ߺ�
�ڹ��� - 017-4747-4848 - �λ��
������ - 011-9595-8585 - �����
ȫ�泲 - 011-9999-7575 - ���ߺ�
�̿��� - 017-5214-5282 - ��ȹ��
���μ� -  - ������
�踻�� - 011-5248-7789 - ��ȹ��
����� - 010-4563-2587 - ������
����� - 010-2112-5225 - ������
�迵�� - 019-8523-1478 - �ѹ���
�̳��� - 016-1818-4848 - �λ��
�踻�� - 016-3535-3636 - �ѹ���
������ - 019-6564-6752 - �ѹ���
����ȯ - 019-5552-7511 - ��ȹ��
�ɽ��� - 016-8888-7474 - �����
��̳� - 011-2444-4444 - ������
������ - 011-3697-7412 - ��ȹ��
������ -  - ���ߺ�
���翵 - 011-9999-9999 - �����
�ּ��� - 011-7777-7777 - ȫ����
���μ� - 010-6542-7412 - ������
����� - 010-2587-7895 - ������
�ڼ��� - 016-4444-7777 - �λ��
����� - 016-4444-5555 - �����
ä���� - 011-5125-5511 - ���ߺ�
��̿� - 016-8548-6547 - ������
����ȯ - 011-5555-7548 - ������
ȫ���� - 011-7777-7777 - ������
���� - 017-3333-3333 - �ѹ���
�긶�� - 018-0505-0505 - ������
�̱�� -  - ���ߺ�
�̹̼� - 010-6654-8854 - ���ߺ�
�̹��� - 011-8585-5252 - ȫ����
�ǿ��� - 011-5555-7548 - ������
�ǿ��� - 010-3644-5577 - ��ȹ��
��̽� - 011-7585-7474 - �����
����ȣ - 016-1919-4242 - ȫ����
���ѳ� - 016-2424-4242 - ������
������ - 010-7549-8654 - ������
�̹̰� - 016-6542-7546 - �����
����� - 010-2415-5444 - ��ȹ��
�Ӽ��� - 011-4151-4154 - ���ߺ�
��ž� - 011-4151-4444 - ���ߺ�
*/


----------------------------------------------------------------------------------------------------------------------

--���� FUNCTION(�Լ�) ����--

-- 1. �Լ��� �ϳ� �̻��� PL/SQL ������ ������ �����ƾ����
--    �ڵ带 �ٽ� ����� �� �ֵ��� ĸ��ȭ �ϴµ� ���ȴ�.
--    ����Ŭ������ ����Ŭ�� ���ǵ� �⺻ ���� �Լ��� ����ϰų�
--    ���� ������ �Լ��� ���� �� �ִ�. (�� ����� ���� �Լ�)
--    �� ����� ���� �Լ��� �ý��� �Լ�ó�� �������� ȣ���ϰų�
--    ���� ���ν���ó�� EXECUTE ���� ���� ������ �� �ִ�.



-- 2. ���� �� ����
/*
CREATE [OR REPLACE] FUNCTION �Լ���
[(
    �Ű�����1 �ڷ���
  , �Ű�����2 �ڷ���
)]
RETURN ������Ÿ��
IS                                                              -- DECLARE �� IS�� �� ��.. �Լ� ����
        -- �ֿ� ���� ����(���� ����)
BEGIN   
        -- ���๮;
        ...
        RETURN ��;
        
        [EXCEPTION]
            -- ���� ó�� ����;
END;
*/

--�� ����� ���� �Լ�(������ �Լ�)��
--   IN �Ķ����(�Է� �Ű�����)�� ����� �� ������
--   �ݵ�� ��ȯ�� ���� ������Ÿ���� RETURN ���� �����ؾ� �ϰ�,
--   FUNCTION �� �ݵ�� ���� ���� ��ȯ�Ѵ�.


--�� TBL_INSA ���̺��� �������
--   �ֹι�ȣ�� ������ ������ ��ȸ�Ѵ�.
SELECT NAME, SSN, DECODE( SUBSTR(SSN, 8, 1), 1, '����', 2, '����', 'Ȯ�κҰ�') "����"
FROM TBL_INSA;


--�� FUNCTION ����
-- �Լ��� : FN_GENDER()
--                   �� SSN(�ֹε�Ϲ�ȣ) �� 'YYMMDD-NNNNNNN'

-- �Ű����� ��������
-- FN_GENDER(, , ) �ĸ��� ����...
CREATE OR REPLACE FUNCTION FN_GENDER
(
    VSSN    VARCHAR2             -- �Ű����� : �ڸ���(����) ���� ����, �����ݷ� ����.     
)   
RETURN VARCHAR2 -- ���ڳ�, ���ڳ� ��ȯ�ϴϱ�       -- ��ȯ�ڷ��� : �ڸ���(����) ���� ����
IS
    -- �ֿ� ���� ����
    VRESULT VARCHAR2(20);    
BEGIN
    -- ���� �� ó��
    IF( SUBSTR(VSSN, 8, 1) IN ('1', '3') )
        THEN VRESULT := '����';
    ELSIF ( SUBSTR(VSSN, 8, 1) IN ('2', '4') )
        THEN VRESULT := '����';
    ELSE
        VRESULT := '����Ȯ�κҰ�';
    END IF;
    
    -- ���� ����� ��ȯ
    RETURN VRESULT;
END;

--==>> Function FN_GENDER��(��) �����ϵǾ����ϴ�.


--�� ������ ���� �� ���� �Ű�����(�Է� �Ķ����)�� �Ѱܹ޾�
--   A �� B ���� ���� ��ȯ�ϴ� ����� ���� �Լ��� �ۼ��Ѵ�.
--   �Լ��� : FN_POW()

/*
��� ��)
SELECT FN_POW(10, 3)
FROM DUAL;
--==>> 1000
*/

CREATE OR REPLACE FUNCTION FN_POW
(
    NUM1    NUMBER
 ,  NUM2    NUMBER 
)
RETURN NUMBER
IS
    -- �ֿ� ���� ����
    PRESULT NUMBER := 1;      -- ��� �� �ִ� ����
    COUN    NUMBER;  -- ī����
BEGIN
    -- ���� �� ó��
    FOR COUN IN 1 .. NUM2 LOOP
    PRESULT := PRESULT * NUM1;
    END LOOP;
    RETURN PRESULT;
END;

--==>> Function FN_POW��(��) �����ϵǾ����ϴ�.




--�� TBL_INSA ���̺��� �޿� ��� ���� �Լ��� �����Ѵ�.
--   �޿��� (�⺻��*12)+���� ������� ������ �����Ѵ�.
--   �Լ��� : FN_PAY(�⺻��, ����)

CREATE OR REPLACE FUNCTION FN_PAY
(
    NUM1     NUMBER    -- �⺻�� �Ű�����
  , NUM2     NUMBER    -- ���� �Ű�����
)
RETURN NUMBER           -- ���� �ڷ���
IS
    -- �ֿ� ���� ����
    TOTAL    NUMBER;   -- �� �޿� ���� ����
    TOTAL := NUM1*12 + NVL(NUM2, 0);
    RETURN TOTAL;
BEGIN
END;


--�� TBL_INSA ���̺��� �Ի����� ��������
--   ��������� �ٹ������ ��ȯ�ϴ� �Լ��� �����Ѵ�.
--   ��, �ٹ������ �Ҽ��� ���� ���ڸ����� ����Ѵ�.
--   �Լ��� : FN_WORKYEAR(�Ի���)




---------------------------------------------------------------------------------

--�� ����

-- 1. INSERT, UPDATE, DELETE, (MERGE)
--==>> DML(Data Manipulation Language)
-- COMMIT / ROLLBACK �� �ʿ��ϴ�.

-- 2. CREATE, DROP, ALTER, (TRUNCATE)
--==>> DDL(Data Definition Language)

-- �����ϸ� �ڵ����� COMMIT �ȴ�.

-- 3. GRANT, REVOKE
--==>> DCL(Date Control Language)
-- �����ϸ� �ڵ����� COMMIT �ȴ�.

-- 4. COMMIT, ROLLBACK
--==>> TCL(Transaction Control Language)


-- ���� PL/SQL�� �� DML��, TCL���� ��� �����ϴ�.
-- ���� PL/SQL�� �� DML��, DDL��, DCL��, TCL�� ��� �����ϴ�.

-- �� ���� SQL (����PL/SQL)
--> �⺻������ ����ϴ� SQL ������
--  PL/SQL ���� �ȿ� SQL ������ ���� �����ϴ� ���
--> �ۼ��� ���� ������ ����.

-- �� ���� SQL (����PL/SQL) �� EXECUTE IMMEDIATE
--> �ϼ����� ���� SQL ������ �������
--  ���� �� ���� ������ ���ڿ� ���� �Ǵ� ���ڿ� ����� ����
--  SQL ������ �������� �ϼ��Ͽ� �����ϴ� ���
--> ������ ���ǵ��� ���� SQL �� ������ �� �ϼ�/Ȯ���Ͽ� ������ �� �ִ�.
--  DML, TCL �ܿ��� DDL, DCL, TCL ����� �����ϴ�.
---------------------------------------------------------------------------------


--���� PROCEDURE(���ν���) ����--

-- 1. PL/SQL ���� ���� ��ǥ���� ������ ������ ���ν�����
--    �����ڰ� ���� �ۼ��ؾ� �ϴ� ������ �帧��
--    �̸� �ۼ��Ͽ� �����ͺ��̽� ���� ������ �ξ��ٰ�
--   �ʿ��� ������ ȣ���Ͽ� ������ �� �ֵ��� ó���� �ִ� �����̴�.

-- 2. ���� �� ����
/*
CREATE [OR REPLACE] PROCEDURE ���ν�����
[( �Ű����� IN ������Ÿ��
 , �Ű����� OUT ������Ÿ��
 , �Ű����� INOUT ������Ÿ��
)]
IS
    [-- �ֿ� ���� ����;]
BEGIN
    -- ���� ����;
    [EXCEPTION
        -- ���� ó�� ����;]
END;
*/


--�� FUNCTION �� ������ ��...
--     ��RETURN ��ȯ�ڷ����� �κ��� �������� ������,
--     ��RETURN���� ��ü�� �������� ������,
--     ���ν��� ���� �� �Ѱ��ְ� �Ǵ� �Ű������� ������
--     IN, OUT, INOUT ���� ���еȴ�.

-- 3. ����(ȣ��)
/*
EXEC[UTE] ���ν�����[(�μ�1, �μ�2)];
*/


--�� INSERT ���� ������ ���ν����� �ۼ� (INSERT ���ν���)

-- �ǽ� ���̺� ����(TBL_STUDENTS) �� 20210408_04_scott.sql ����
-- �ǽ� ���̺� ����(TBL_IDPW) ��  20210408_04_scott.sql ����

-- ���ν��� ����
-- ���ν����� : PRC_STUDENTS_INSERT(���̵�, �н�����, �̸�, ��ȭ��ȣ, �ּ�)


-- �Է� �Ű� ���� : 
-- ��� �Ű� ���� : ���� ������ ���� �� A�� �� ������ ��� ��Ƽ� �ִµ� �� �� �� �׸���.. ��� �Ű� ����..
-- ����� �Ű� ���� : ���� �� ��Ƽ� �ָ� �� �׸��� ��� ��� �ִ�..��.. ����� �Ű� ����..

CREATE OR REPLACE PROCEDURE PRC_STUDENTS_INSERT
( V_ID      IN TBL_STUDENTS.ID%TYPE        -- Ȥ�� TBL_IDPW.ID%TYPE
, V_PW      IN TBL_IDPW.PW%TYPE
, V_NAME    IN TBL_STUDENTS.NAME%TYPE
, V_TEL     IN TBL_STUDENTS.TEL%TYPE
, V_ADDR    IN TBL_STUDENTS.ADDR%TYPE  
)
IS
BEGIN
    -- TBL_IDPW ���̺� ������ �Է�
    INSERT INTO TBL_IDPW(ID, PW)
    VALUES(V_ID, V_PW);
    
    -- TBL_STUDENTS ���̺� ������ �Է�
    INSERT INTO TBL_STUDENTS(ID, NAME, TEL, ADDR)
    VALUES(V_ID, V_NAME, V_TEL, V_ADDR);
    
    -- Ŀ��
    COMMIT;
END;
--==>> Procedure PRC_STUDENTS_INSERT��(��) �����ϵǾ����ϴ�.




-- �ǽ� ���̺� ����(TBL_SUNGJUK) �� 20210408_04_scott.sql ����

--�� ������ �Է� ��
--   Ư�� �׸��� ������(�й�, �̸�, ��������, ��������, ��������)�� �Է��ϸ�
--   ���������� ����, ���, ��� �׸��� �԰� �Է� ó���� �� �ֵ��� �ϴ�
--   ���ν����� �ۼ��Ѵ�(�����Ѵ�).
--   ���ν����� : PRC_SUNGJUK_INSERT()
/*
���� ��)
EXEC PRC_SUNGJUK_INSERT(1, '������', 90, 80, 70)

���ν��� ȣ��� ó���� ���
�й�     �̸�     ��������     ��������     ��������    ����     ���     ���
 1      ������     90            80           70       240      80        B
*/

CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_INSERT
( V_HAKBUN  IN TBL_SUNGJUK.HAKBUN%TYPE
, V_NAME    IN TBL_SUNGJUK.NAME%TYPE
, V_KOR     IN TBL_SUNGJUK.KOR%TYPE
, V_ENG     IN TBL_SUNGJUK.ENG%TYPE
, V_MAT     IN TBL_SUNGJUK.MAT%TYPE
)
IS
BEGIN
    -- ������ �Է�
    INSERT INTO TBL_SUNGJUK(HAKBUN, NAME, KOR, ENG, MAT, TOT, AVG, GRADE)
    VALUES(V_HAKBUN, V_NAME, V_KOR, V_ENG, V_MAT, V_KOR+V_ENG+V_MAT, (V_KOR+V_ENG+V_MAT)/3
    , CASE WHEN (V_KOR+V_ENG+V_MAT/3) >= 90 THEN 'A'
           WHEN (V_KOR+V_ENG+V_MAT/3) >= 80 THEN 'B'
           WHEN (V_KOR+V_ENG+V_MAT/3) >= 70 THEN 'C'
           WHEN (V_KOR+V_ENG+V_MAT/3) >= 60 THEN 'D'
           ELSE 'F' END);
    
    -- Ŀ��
    COMMIT;
END;
--==>> Procedure PRC_SUNGJUK_INSERT��(��) �����ϵǾ����ϴ�.


CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_INSERT2
( V_HAKBUN  IN TBL_SUNGJUK.HAKBUN%TYPE
, V_NAME    IN TBL_SUNGJUK.NAME%TYPE
, V_KOR     IN TBL_SUNGJUK.KOR%TYPE
, V_ENG     IN TBL_SUNGJUK.ENG%TYPE
, V_MAT     IN TBL_SUNGJUK.MAT%TYPE
)
IS
    V_TOT   TBL_SUNGJUK.TOT%TYPE := V_KOR+V_ENG+V_MAT;
    V_AVG   TBL_SUNGJUK.AVG%TYPE  := (V_KOR+V_ENG+V_MAT)/3;
    V_GRADE TBL_SUNGJUK.GRADE%TYPE  := CASE WHEN (V_KOR+V_ENG+V_MAT/3) >= 90 THEN 'A'
                             WHEN (V_KOR+V_ENG+V_MAT/3) >= 80 THEN 'B'
                              WHEN (V_KOR+V_ENG+V_MAT/3) >= 70 THEN 'C'
                             WHEN (V_KOR+V_ENG+V_MAT/3) >= 60 THEN 'D'
                            ELSE 'F' END;
BEGIN
    -- ������ �Է�
    INSERT INTO TBL_SUNGJUK(HAKBUN, NAME, KOR, ENG, MAT, TOT, AVG, GRADE)
    VALUES(V_HAKBUN, V_NAME, V_KOR, V_ENG, V_MAT, V_TOT, V_AVG
    , V_GRADE);
    
    -- Ŀ��
    COMMIT;
END;
--==>> Procedure PRC_SUNGJUK_INSERT2��(��) �����ϵǾ����ϴ�.


CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_INSERT3
( V_HAKBUN  IN TBL_SUNGJUK.HAKBUN%TYPE
, V_NAME    IN TBL_SUNGJUK.NAME%TYPE
, V_KOR     IN TBL_SUNGJUK.KOR%TYPE
, V_ENG     IN TBL_SUNGJUK.ENG%TYPE
, V_MAT     IN TBL_SUNGJUK.MAT%TYPE
)
IS
    V_TOT   TBL_SUNGJUK.TOT%TYPE; 
    V_AVG   TBL_SUNGJUK.AVG%TYPE; 
    V_GRADE TBL_SUNGJUK.GRADE%TYPE; 
BEGIN
    -- �Ʒ��� ������ ������ ���ؼ���
    -- ������ �����鿡 ���� ��Ƴ��� �Ѵ�. (V_TOT, V_AVG, V_GRADE)
    
    V_TOT := V_KOR+V_ENG+V_MAT;
    V_AVG := V_TOT/3;
    
    IF (V_AVG >= 90)
        THEN V_GRADE := 'A';
    ELSIF (V_AVG >= 80)
        THEN V_GRADE := 'B';
    ELSIF (V_AVG >= 70)
        THEN V_GRADE := 'C';
    ELSIF (V_AVG >= 60)
        THEN V_GRADE := 'D';
    ELSE
        V_GRADE := 'F';
    END IF;
    
    -- INSERT ������ ����
    INSERT INTO TBL_SUNGJUK(HAKBUN, NAME, KOR, ENG, MAT, TOT, AVG, GRADE)
    VALUES(V_HAKBUN, V_NAME, V_KOR, V_ENG, V_MAT, V_TOT, V_AVG, V_GRADE);
    
    -- Ŀ��
    COMMIT;

END;



--�� TBL_SUNGJUK ���̺���
--   Ư�� �л��� ����(�й�, ��������, ��������, ��������)
--   ������ ���� �� ����, ���, ��ޱ��� �����ϴ� ���ν����� �ۼ��Ѵ�.
--   ���ν��� �� : PRC_SUNGJUK_UPDATE

/*
���� ��)
EXEC PRC_SUNGJUK_UPDATE(1, 50, 50, 50);

���ν��� ȣ��� ó���� ���
�й�  �̸�   ��������    ��������    ��������  ����   ���  ���
1	������	  50	     10	          20	   80	26.7	F
*/


CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_UPDATE

( V_HAKBUN  IN TBL_SUNGJUK.HAKBUN%TYPE
, V_KOR     IN TBL_SUNGJUK.KOR%TYPE
, V_ENG     IN TBL_SUNGJUK.ENG%TYPE
, V_MAT     IN TBL_SUNGJUK.MAT%TYPE
)
IS
    -- UPDATE �������� �����ϴµ� �ʿ��� �ֿ� ���� ����
    V_TOT   TBL_SUNGJUK.TOT%TYPE; 
    V_AVG   TBL_SUNGJUK.AVG%TYPE; 
    V_GRADE TBL_SUNGJUK.GRADE%TYPE; 
BEGIN
    V_TOT := V_KOR+V_ENG+V_MAT;
    V_AVG := V_TOT/3;
    
    IF (V_AVG >= 90)
        THEN V_GRADE := 'A';
    ELSIF (V_AVG >= 80)
        THEN V_GRADE := 'B';
    ELSIF (V_AVG >= 70)
        THEN V_GRADE := 'C';
    ELSIF (V_AVG >= 60)
        THEN V_GRADE := 'D';
    ELSE
        V_GRADE := 'F';
    END IF;
    
    -- UPDATE ������ ����
    UPDATE TBL_SUNGJUK
    SET
      KOR = V_KOR
    , ENG = V_ENG
    , MAT = V_MAT
    , TOT = V_TOT
    , AVG = V_AVG
    , GRADE = V_GRADE
    
    WHERE HAKBUN = V_HAKBUN;
    -- Ŀ��
    COMMIT;
END;
--==>> Procedure PRC_SUNGJUK_UPDATE��(��) �����ϵǾ����ϴ�.


--�� TBL_STUDENTS ���̺���
--   ��ȭ��ȣ�� �ּ� �����͸� �����ϴ�(�����ϴ�) ���ν����� �ۼ��Ѵ�.
--   ��, ID �� PW �� ��ġ�ϴ� ��쿡�� ������ ������ �� �ִ�.
--   ���ν��� �� : PRC_STUDENTS_UPDATE
/*
���� ��:
EXEC PRC_STUDENTS_UPDATE('superman', 'java006$', '010-9999-9999', '��� �ϻ�');

���ν��� ȣ��� ó���� ���
superman    ������     010-9999-9999   ��� �ϻ�
*/
CREATE PROCEDURE PRC_STUDENTS_UPDATE
(
     V_ID    IN TBL_IDPW.ID%TYPE
   , V_PW    IN TBL_IDPW.PW%TYPE
   , V_TEL   IN TBL_STUDENTS.TEL%TYPE
   , V_ADDR  IN TBL_STUDENTS.ADDR%TYPE
)
IS
BEGIN
    UPDATE  TBL_STUDENTS
    SET (SELECT TEL
         FROM TBL_STUDENTS T1, TBL_IDPW T2
         WHERE T1.ID = T2.ID) = V_TEL
      , (SELECT ADDR
         FROM TBL_STUDENTS T1, TBL_IDPW T2
         WHERE T1.ID = T2.ID) = V_ADDR
    WHERE (SELECT ID FROM TBL_IDPW) = V_ID AND (SELECT PW FROM TBL_IDPW) = V_PW;
END;

DROP PROCEDURE PRC_STUDENTS_UPDATE;