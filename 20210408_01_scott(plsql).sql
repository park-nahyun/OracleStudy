SELECT USER
FROM DUAL;
--==>> SCOTT


--�� ����ڷκ��� �Է¹��� �ݾ��� ȭ�� ������ ����ϴ� ���α׷��� �ۼ��Ѵ�.
--   ��, ��ȯ �ݾ��� ���ǻ� 1õ�� �̸�, 10�� �̻� �����ϴٰ� �����Ѵ�.
/*
���� ��)
���ε� ���� �Է� ��ȭâ �� �ݾ� �Է� : 990

�Է¹��� �ݾ� �Ѿ� : 990��
ȭ����� : ����� 1, ��� 4, ���ʿ� 1, �ʿ� 4
*/

SET SERVEROUTPUT ON;

-- ���1
ACCEPT N1 PROMPT '�ݾ� �Է�';

DECLARE
     --�� �ֿ� ���� ���� �� �ʱ�ȭ
    NUM1    NUMBER := &N1;                  -- ������ ���� ��Ƶ� ����
    NUM500  NUMBER := 0;                    -- 500�� ¥�� ������ ��Ƶ� ����
    NUM100  NUMBER := 0;                    -- 100�� ¥�� ������ ��Ƶ� ����
    NUM50   NUMBER := 0;                    -- 50�� ¥�� ������ ��Ƶ� ����
    NUM10   NUMBER := 0;                    -- 10�� ¥�� ������ ��Ƶ� ����
BEGIN
    --�� ���� �� ó��
    NUM500 := TRUNC(NUM1/500, 0);
    NUM100 := TRUNC((NUM1/500 - TRUNC(NUM1/500, 0))*500/100, 0);
    NUM50  := TRUNC((NUM1-(NUM500*500+NUM100*100))/50, 0);
    NUM10  := TRUNC((NUM1-(NUM500*500+NUM100*100+NUM50*50))/10, 0);
    
    --�� ��� ���
    DBMS_OUTPUT.PUT_LINE('ȭ����� : ����� ' || NUM500 || ', ��� ' || NUM100 || ', ���ʿ� ' || NUM50 || ', �ʿ� ' || NUM10);
END;


-- ��� 2
ACCEPT N2 PROMPT '�ݾ� �Է� : ';
DECLARE
    -- �ֿ� ���� ���� �� �ʱ�ȭ
    PRICE   NUMBER(3) := &N2;
BEGIN
    -- ���� �� ó�� & ��� ���
    DBMS_OUTPUT.PUT_LINE('�Է¹��� �ݾ� �Ѿ� : ' || PRICE || '��');
    
    DBMS_OUTPUT.PUT_LINE('����� ' || TRUNC(PRICE/500) 
                      || ', ��� ' || TRUNC(MOD(PRICE, 500)/100)
                      || ', ���ʿ� ' || TRUNC(MOD(MOD(PRICE, 500), 100)/50)
                      || ', �ʿ� ' || TRUNC(MOD(MOD(MOD(PRICE, 500), 100), 50))/10);        
END;


-- ��� 3

ACCEPT INPUT PROMPT '�ݾ� �Է�';

DECLARE
     --�� �ֿ� ���� ���� �� �ʱ�ȭ
    MONEY   NUMBER := &INPUT;               -- ������ ���� ��Ƶ� ����
    MONEY2  NUMBER := &INPUT;               -- ����� ���� ��Ƶ� ����(���� �� ���� ���ϴϱ�)
    NUM500  NUMBER := 0;                    -- 500�� ¥�� ������ ��Ƶ� ����
    NUM100  NUMBER := 0;                    -- 100�� ¥�� ������ ��Ƶ� ����
    NUM50   NUMBER := 0;                    -- 50�� ¥�� ������ ��Ƶ� ����
    NUM10   NUMBER := 0;                    -- 10�� ¥�� ������ ��Ƶ� ����
BEGIN
    --�� ���� �� ó��
    -- MONEY �� 500���� ������ ���� ���ϰ� �������� ������. �� 500���� ����
    NUM500 := TRUNC(MONEY/500);
    
    -- MONEY �� 500���� ������ ���� ���ϰ� �������� ���Ѵ�. 
    MONEY  :=  MOD(MONEY, 500);
    
    -- MONEY �� 100���� ������ ���� ���ϰ� �������� ������. �� 100���� ����
    NUM100 := TRUNC(MONEY/100);
    
    -- MONEY �� 100���� ������ ���� ���ϰ� �������� ���Ѵ�. 
    MONEY  :=  MOD(MONEY, 100);
    
    -- MONEY �� 50���� ������ ���� ���ϰ� �������� ������. �� 50���� ����
    NUM50 := TRUNC(MONEY/50);
    
    -- MONEY �� 50���� ������ ���� ���ϰ� �������� ���Ѵ�. 
    MONEY  :=  MOD(MONEY, 50);
    
    -- MONEY �� 10���� ������ ���� ���ϰ� �������� ������. �� 10���� ����
    NUM10 := TRUNC(MONEY/10);
    
    --�� ��� ���
    DBMS_OUTPUT.PUT_LINE('�Է¹��� �ݾ� �Ѿ� : ' || MONEY2 || '��');
    DBMS_OUTPUT.PUT_LINE('ȭ����� : ����� ' || NUM500 || ', ��� ' || NUM100 || ', ���ʿ� ' || NUM50 || ', �ʿ� ' || NUM10);
END;

--==>>
/*
�Է¹��� �ݾ� �Ѿ� : 990��
ȭ����� : ����� 1, ��� 4, ���ʿ� 1, �ʿ� 4


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/



--�� �⺻ �ݺ���
-- LOOP ~ END LOOP;


-- 1. ���ǰ� ������� ������ �ݺ��ϴ� ����.

-- 2. ���� �� ����
/*
LOOP
    -- ���๮;
    EXIT WHEN ����;               -- ������ ���� ��� �ݺ����� ����������.
END LOOP;
*/


--�� 1 ���� 10 ������ �� ��� (LOOP �� Ȱ��)
DECLARE
    N       NUMBER;
BEGIN
    N   :=  1;
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        EXIT WHEN N >= 10;
        N := N + 1;                 -- N++;     N+=1;
    END LOOP;
END;
--==>>
/*
1
2
3
4
5
6
7
8
9
10


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/


--�� WHILE �ݺ���
-- WHILE LOOP ~ END LOOP;

-- 1. ���� ������ TRUE �� ���� �Ϸ��� ������ �ݺ��ϱ� ����
--    WHILE LOOP ������ ����Ѵ�.
--    ������ �ݺ��� ���۵� �� üũ�ϰ� �Ǿ�
--    LOOP ���� ������ �� ���� ������� ���� ��쵵 �ִ�.
--    LOOP �� ������ �� ������ FALSE �̸� �ݺ� ������ Ż���ϰ� �ȴ�.

-- 2. ���� �� ����
/*
WHILE ���� LOOP           -- ������ ���� ��� �ݺ� ����
        -- ���๮;
END LOOP;
*/

--�� 1 ���� 10 ������ �� ��� (WHILE LOOP �� Ȱ��)

DECLARE
    N   NUMBER;
BEGIN
    N := 0;
    WHILE N<10 LOOP
        N := N + 1;
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
--==>>
/*
1
2
3
4
5
6
7
8
9
10


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/


--�� FOR �ݺ���
-- FOR LOOP ~ END LOOP;

-- 1. ������ �������� 1�� �����Ͽ�
--    ������ ������ �� �� ���� �ݺ� �����Ѵ�.
-- 2. ���� �� ����
/*
FOR ī���� IN [REVERSE] ���ۼ� .. ������ LOOP
    -- ���๮;
END LOOP;
*/


--�� 1 ���� 10 ������ �� ��� (FOR LOOP �� Ȱ��)
DECLARE
    N   NUMBER;     -- ī����
BEGIN
    FOR N IN 1 .. 10 LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
--==>>
/*

PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

1
2
3
4
5
6
7
8
9
10


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/


--�� ����ڷκ��� ������ ��(������)�� �Է¹޾�
--   �ش� �ܼ��� �������� ����ϴ� PL/SQL ������ �ۼ��Ѵ�.
--   LOOP, WHILE LOOP, FOR LOOP �� ���� �ذ��Ѵ�.

/*
���� ��)
���ε� ���� �Է� ��ȭâ �� ���� �Է��ϼ��� : 2

2 * 1 = 2
2 * 2 = 4
2 * 3 = 6
    :
2 * 9 = 18
*/


-- ��� 1 LOOP
ACCEPT DAN INPUT PROMPT '���� �Է��ϼ���';

DECLARE
    DAN     NUMBER := &DAN;     -- ����ڰ� �Է��� ����
    GOB     NUMBER;     -- 1~9���� ������ ����
BEGIN
    GOB  := 1;
    LOOP
        DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || GOB || ' = ' || DAN*GOB);
        EXIT WHEN GOB >= 9;
        
        GOB := GOB + 1;
    END LOOP;
END;
--==>>
/*
5 * 1 = 5
5 * 2 = 10
5 * 3 = 15
5 * 4 = 20
5 * 5 = 25
5 * 6 = 30
5 * 7 = 35
5 * 8 = 40
5 * 9 = 45
*/


-- ��� 2 WHILE LOOP
ACCEPT DAN INTO PROMPT '���� �Է��ϼ���';
DECLARE
    DAN     NUMBER := &DAN;
    GOB     NUMBER;
BEGIN
    GOB := 0;
    WHILE GOB<9 LOOP
        GOB := GOB + 1;
        DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || GOB || ' = ' || DAN*GOB);
    END LOOP;
END;
--==>>
/*
2 * 1 = 2
2 * 2 = 4
2 * 3 = 6
2 * 4 = 8
2 * 5 = 10
2 * 6 = 12
2 * 7 = 14
2 * 8 = 16
2 * 9 = 18
*/

-- ��� 3 FOR LOOP
ACCEPT DAN INTO PROMPT '���� �Է��ϼ���';
DECLARE
    DAN     NUMBER := &DAN;
    GOB     NUMBER;
BEGIN
    FOR GOB IN 1 .. 9 LOOP
        DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || GOB || ' = ' || DAN*GOB);
    END LOOP;
END;
--==>>
/*
5 * 1 = 5
5 * 2 = 10
5 * 3 = 15
5 * 4 = 20
5 * 5 = 25
5 * 6 = 30
5 * 7 = 35
5 * 8 = 40
5 * 9 = 45
*/
