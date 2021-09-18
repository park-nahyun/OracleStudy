-- PL/SQL ��ũ��Ʈ�� ���������� �����α�

SELECT USER
FROM DUAL;
--==>> SCOTT


-- ���� PL/SQL ���� --

-- 1. PL/SQL(Procedural Language extension to SQL) ��
--    ���α׷��� ����� Ư���� ������ SQL �� Ȯ���̸�,
--    ������ ���۰� ���� ������ PL/SQL �� ������ �ڵ� �ȿ� ���Եȴ�.
--    ����, PL/SQL �� ����ϸ� SQL �� �� �� ���� ������ �۾��� �����ϴ�.
--    ���⼭ �����������̶�� �ܾ ������ �ǹ̴�
--    � ���� � ������ ���� ��� �Ϸ�Ǵ���
--    �� ����� ��Ȯ�ϰ� �ڵ忡 ����Ѵٴ� ���� �ǹ��Ѵ�.


-- 2. PL/SQL �� ���������� ǥ���ϱ� ����
--    ������ ������ �� �ִ� ���,
--    ���� ������ ������ �� �ִ� ���,
--    ���� �帧�� ��Ʈ���� �� �ִ� ��� ���� �����Ѵ�.


-- 3. PL/SQL �� �� ������ �Ǿ�������
--    ���� ���� �κ�, ���� �κ�, ���� ó�� �κ���   -- ����, ���� ó���� �ʿ� ���ٸ� ���� ����..
--    �� �κ����� �����Ǿ� �ִ�.
--    ����, �ݵ�� ���� �κ��� �����ؾ� �ϸ�, ������ ������ ����.


-- 4. ���� �� ����
/*
[DECLARE]
    -- ����(declarations)
BEGIN
    -- ���๮(statements)
    
    [EXCEPTION]
        -- ���� ó����(exception handlers)
        
END;
*/
-- ���� ó���δ� ���๮ �ȿ� ���Ե� ��..


-- 5. ���� ����
/*
DECLARE
  ������ �ڷ���;
  ������ �ڷ��� := �ʱⰪ;           ���� ���� ���� �׿� �����Ѵ�~!
BEGIN
  PL/SQL ����;
END;
*/


SET SERVEROUTPUT ON;
--==>> �۾��� �Ϸ�Ǿ����ϴ�.(0.XXX��)
--> System.out.println()
--> = ��DBMS_OUTPUT.PUT_LINE()�� �� ����
--    ȭ�鿡 ����� ����ϱ� ���� ȯ�溯�� ����

-- SQL������ � �� �����̶� �����ݷ��� �ϳ����µ�
-- PLSQL������ �����ݷ��� ���� ���� ������ ������ �� ��Ƽ� �����ؾ� ��.


--�� ������ ������ ���� �����ϰ� ����ϴ� ���� �ۼ�
DECLARE

    -- �����
    D1 NUMBER :=10;
    D2 VARCHAR2(30) := 'HELLO';
    D3 VARCHAR2(20) := 'Oracle';
BEGIN
    -- �����
    DBMS_OUTPUT.PUT_LINE(D1);
    DBMS_OUTPUT.PUT_LINE(D2);
    DBMS_OUTPUT.PUT_LINE(D3);
END;
--==>>
/*
10
HELLO
Oracle


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/


--�� ������ ������ ���� �����ϰ� ����ϴ� ���� �ۼ�
DECLARE

    -- �����
    D1 NUMBER :=10;
    D2 VARCHAR2(30) := 'HELLO';
    D3 VARCHAR2(20) := 'Oracle';
BEGIN
    -- �����
    D1 := D1 * 10;       -- ����Ŭ���� ���մ��Կ�����(+=)�� ����.
    D2 := D2 || '����';
    D3 := D3 || 'World';
    
    DBMS_OUTPUT.PUT_LINE(D1);
    DBMS_OUTPUT.PUT_LINE(D2);
    DBMS_OUTPUT.PUT_LINE(D3);
END;
--==>>
/*
100
HELLO����
OracleWorld

PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/



--�� IF��(���ǹ�)
-- IF ~ END IF;
-- IF ~ THEN ~ ELSE ~ END IF;
-- IF ~ THEN ~ ELSIF ~ THEN ~ ELSIF ~ THEN ~ ELSE ~ END IF;

-- 1. PL/SQL �� IF ������ �ٸ� ����� IF ���ǹ��� ���� �����ϴ�.
--    ��ġ�ϴ� ���ǿ� ���� ���������� �۾��� ������ �� �ֵ��� �Ѵ�.
--    TRUE �̸� THEN �� ELSE ������ ������ �����ϰ�
--    FALSE �� NULL �̸� ELSE ��  END ������ ������ �����ϰ� �ȴ�.


--2. ���� �� ����
/*
IF ����
   THEN ó������;
ELSIF ����
   THEN ó������;
ELSIF ����
   THEN ó������;
ELSE
   ó������
END IF;
*/

--�� ������ ����ִ� ���� ����..
--   Exellent, Good, Fail �� �����Ͽ�
--   ����� ����ϴ� PL/SQL ������ �ۼ��Ѵ�.

DECLARE
    GRADE CHAR;
BEGIN
    GRADE := 'A';
    
    IF GRADE = 'A'
        THEN DBMS_OUTPUT.PUT_LINE('Excellent');
    ELSIF GRADE = 'B'
        THEN DBMS_OUTPUT.PUT_LINE('Good');
    ELSE  
        DBMS_OUTPUT.PUT_LINE('Fail');
    END IF;
END;
--==>>
/*

Excellent


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/


--�� CASE��(���ǹ�)
-- CASE ~ WHEN ~ THEN ~ ELSE ~ END CASE;

-- 1. ���� �� ����
/*
CASE ����
    WHEN ��1
        THEN ���๮;
    WHEN ��2
        THEN ���๮;
    ELSE
        ���๮;
END CASE;
*/


--�� ������ ����ִ� ���� ����..
--   Exellent, Good, Fail �� �����Ͽ�
--   ����� ����ϴ� PL/SQL ������ �ۼ��Ѵ�.
DECLARE
    GRADE CHAR;
BEGIN
    GRADE := 'A';
    
    CASE GRADE
        WHEN 'A'
            THEN DBMS_OUTPUT.PUT_LINE('Excellent');
        WHEN 'B'
            THEN DBMS_OUTPUT.PUT_LINE('Good');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Fail');
    END CASE;
END;
--==>>
/*
Excellent


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/



--�� �ܺ� �Է� ó��

--1. ACCEPT ��
-- ACCEPT ������ PROMPT '�޽���';
-- �ܺ� �����κ��� �Է¹��� �����͸� ���� ������ ������ ��
-- ��&�ܺκ����� ���·� �����ϰ� �ȴ�.

--�� ���� 2���� �ܺηκ���(����ڷκ���) �Է¹޾�
--   �̵��� ���� ����� ����ϴ� PL/SQL ������ �ۼ��Ѵ�.

ACCEPT N1 PROMPT 'ù ��° ������ �Է��ϼ���';
ACCEPT N2 PROMPT '�� ��° ������ �Է��ϼ���';

DECLARE
    -- �ֿ� ���� ���� �� �ʱ�ȭ
    NUM1    NUMBER := &N1;
    NUM2    NUMBER := &N2;
    TOTAL   NUMBER := 0;
BEGIN
    -- ���� �� ó��
    TOTAL := NUM1 + NUM2;
    -- ��� ���
    DBMS_OUTPUT.PUT_LINE(NUM1 || '+' || NUM2 || ' = ' || TOTAL);
END;
--==>>
/*
5+10 = 15


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/


--�� ����ڷκ��� �Է¹��� �ݾ��� ȭ�� ������ ����ϴ� ���α׷��� �ۼ��Ѵ�.
--   ��, ��ȯ �ݾ��� ���ǻ� 1õ�� �̸�, 10�� �̻� �����ϴٰ� �����Ѵ�.
/*
���� ��)
���ε� ���� �Է� ��ȭâ �� �ݾ� �Է� : 990

�Է¹��� �ݾ� �Ѿ� : 990��
ȭ����� : ����� 1, ��� 4, ���ʿ� 1, �ʿ� 4
*/

ACCEPT N1 PROMPT '�ݾ� �Է�';

DECLARE
    NUM1    NUMBER := &N1;
    NUM500  NUMBER;
    NUM100  NUMBER;
    NUM50   NUMBER;
    NUM10   NUMBER;
BEGIN
    NUM500 := TRUNC(NUM1/500, 0);
    NUM100 := TRUNC((NUM1/500 - TRUNC(NUM1/500, 0))*500/100, 0);
    NUM50  := TRUNC((NUM1-(NUM500*500+NUM100*100))/50, 0);
    NUM10  := TRUNC((NUM1-(NUM500*500+NUM100*100+NUM50*50))/10, 0);
    DBMS_OUTPUT.PUT_LINE('ȭ����� : ����� ' || NUM500 || ', ��� ' || NUM100 || ', ���ʿ� ' || NUM50 || ', �ʿ� ' || NUM10);
END;