
SELECT USER
FROM DUAL;
--==>> SCOTT


--�� TBL_��� ���̺��� ��� ������ ����(����)�ϴ� ���ν����� �ۼ��Ѵ�.
--   ���ν��� �� : PRC_���_UPDATE(����ȣ, �����Ҽ���);


CREATE OR REPLACE PROCEDURE PRC_���_UPDATE
( 
    --�� �Ű����� ����
    V_����ȣ IN TBL_���.����ȣ%TYPE
  , V_������ IN TBL_���.������%TYPE              -- �������� �ٸ� !!!
)
IS
    --�� �ֿ� ���� ����
    V_��ǰ�ڵ�  TBL_��ǰ.��ǰ�ڵ�%TYPE;
    
    --�� �ֿ� ���� �߰� ����
    V_����������    TBL_���.������%TYPE;
    
    --�� �ֿ� ���� �߰� ����
    V_������  TBL_��ǰ.������%TYPE;

    --�� �ֿ� ����(����� ���� ����) �߰� ����
    USER_DEFINE_ERROR EXCEPTION;
    
    
BEGIN
    --�� ��ǰ�ڵ� �ľ�  / �� ���������� �ľ�       -- ����, ��ġ �߿�!!!        �� ���� ������ ��� ���� Ȯ��
    
    SELECT ��ǰ�ڵ�, ������ INTO V_��ǰ�ڵ�, V_����������
    FROM TBL_���
    WHERE ����ȣ = V_����ȣ;
    
    --�� ��� ���������� �����ؾ� �ϴ����� ���� �Ǵ� �ʿ�
    --   ���� ������ ������ �� ������ ������ Ȯ��
    
    SELECT ������ INTO V_������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    --�� �ľ��� �������� ���� ������ ���� �ǽ� ���� �Ǵ�
    --   (��������+���������� < ������������ �� ��Ȳ�̶��... ����� ���� �߻�)
    IF (V_������ + V_���������� < V_������)
        --THEN ���� �߻�;
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    --�� ����� ������ üũ(UPDATE �� TBL_��� / UPDATE �� TBL_��ǰ -- �� ��ǰ�� �ֱ� ������ �� ���̺��� UPDATE �ۿ� ����)
    UPDATE TBL_���
    SET ������ = V_������
    WHERE ����ȣ = V_����ȣ;
    
    UPDATE TBL_��ǰ
    SET ������ = V_������ + V_���������� - V_������
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    --�� Ŀ��
    COMMIT;
    
    --�� ���� ó��
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '��� ����~~!!!');
            ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;   
END;


-- �Ϻ��� DB�� �ƴϴ�.




--�� TBL_�԰� ���̺��� �԰������ ����(����)�ϴ� ���ν����� �ۼ��Ѵ�.
--   ���ν��� �� : PRC_�԰�_UPDATE(�԰��ȣ, �������԰����);

CREATE OR REPLACE PROCEDURE PRC_�԰�_UPDATE
( V_�԰��ȣ        IN TBL_�԰�.�԰��ȣ%TYPE
, V_�������԰����  IN TBL_�԰�.�԰����%TYPE
)
IS
    V_������ TBL_��ǰ.������%TYPE;
    V_�����԰���� TBL_�԰�.�԰����%TYPE;
    V_��ǰ�ڵ� TBL_��ǰ.��ǰ�ڵ�%TYPE;
    V_������ TBL_���.������%TYPE;
    USER_DEFINE_ERROR EXCEPTION;
BEGIN
    -- ��ǰ�ڵ�, �����԰����
    SELECT ��ǰ�ڵ�, �԰���� INTO V_��ǰ�ڵ�, V_�����԰����
    FROM TBL_�԰�
    WHERE V_�԰��ȣ = �԰��ȣ;
    
    -- ����������
    SELECT ������ INTO V_������
    FROM TBL_��ǰ
    WHERE V_��ǰ�ڵ� = ��ǰ�ڵ�;
    
    -- ������
    
    SELECT ������ INTO V_������
    FROM TBL_���
    WHERE V_��ǰ�ڵ� = ��ǰ�ڵ�;
    
    IF (V_������ - V_�����԰���� + V_�������԰���� <0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    UPDATE TBL_�԰�
    SET �԰���� = V_�������԰����
    WHERE V_�԰��ȣ = �԰��ȣ;
    
    UPDATE TBL_��ǰ
    SET ������ = V_������ - V_�����԰���� + V_�������԰����
    WHERE V_��ǰ�ڵ� = ��ǰ�ڵ�;
    
    --����ó��
    EXCEPTION
        WHEN USER_DEFINE_ERROR
             THEN RAISE_APPLICATION_ERROR(-20003, '�԰� ����~~!!!');
             ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;   
END;

--�� TBL_��� ���̺��� ��� ������ �����ϴ� ���ν����� �ۼ��Ѵ�.
--   ���ν��� �� : PRC_���_DELETE(����ȣ);
CREATE OR REPLACE PROCEDURE PRC_���_DELETE
(
 V_����ȣ IN TBL_���.����ȣ%TYPE
)
IS
    V_����������    TBL_���.������%TYPE;
    V_����������    TBL_��ǰ.������%TYPE;
    V_��ǰ�ڵ�        TBL_��ǰ.��ǰ�ڵ�%TYPE;
BEGIN
    -- ���� ������
    SELECT ������, ��ǰ�ڵ� INTO V_����������, V_��ǰ�ڵ�
    FROM TBL_���
    WHERE ����ȣ = V_����ȣ;
    -- ���� ���
    SELECT ������ INTO V_����������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    UPDATE TBL_���
    SET ������ = 0
    WHERE ����ȣ = V_����ȣ;
    
    /*
    DELETE 
    FROM TBL_���
    WHERE ����ȣ = V_����ȣ;
    */
    
    UPDATE TBL_��ǰ
    SET ������ = V_���������� + V_����������
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
END;

--�� TBL_�԰� ���̺��� �԰������ �����ϴ� ���ν����� �ۼ��Ѵ�.
--   ���ν��� �� : PRC_�԰�_DELETE(�԰��ȣ);

CREATE OR REPLACE PROCEDURE PRC_�԰�_DELETE
(
  V_�԰��ȣ IN TBL_�԰�.�԰��ȣ%TYPE
)
IS
    V_�����԰����    TBL_�԰�.�԰����%TYPE;
    V_����������    TBL_��ǰ.������%TYPE;
    V_��ǰ�ڵ�        TBL_��ǰ.��ǰ�ڵ�%TYPE;
    USER_DEFINE_ERROR EXCEPTION;
    
BEGIN
    
    SELECT �԰����, ��ǰ�ڵ� INTO V_�����԰����, V_��ǰ�ڵ�
    FROM TBL_�԰�
    WHERE �԰��ȣ = V_�԰��ȣ;
    -- ���� ���
    SELECT ������ INTO V_����������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    IF (V_���������� - V_�����԰���� <0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    UPDATE TBL_�԰�
    SET �԰���� = 0
    WHERE �԰��ȣ = V_�԰��ȣ;
    
    /*
    DELETE 
    FROM TBL_�԰�
    WHERE �԰��ȣ = V_�԰��ȣ;
    */
    
    UPDATE TBL_��ǰ
    SET ������ = V_���������� - V_�����԰����
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
   EXCEPTION
        WHEN USER_DEFINE_ERROR
             THEN RAISE_APPLICATION_ERROR(-20003, '�԰� ����~~!!!');
             ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK; 
END;





-------------------------------------------------------------------------

-- ���� Ŀ��(CURSUR) ���� --

-- 1. ����Ŭ���� �ϳ��� ���ڵ尡 �ƴ� ���� ���ڵ�� ������
--    �۾� �������� SQL ���� �����ϰ� �� �������� �߻��� ������ 
--    �����ϱ� ���Ͽ� Ŀ��(CURSUR)�� ����ϸ�,
--    Ŀ������ �Ͻ��� Ŀ���� �����Ŀ���� �ִ�.

-- 2. �Ͻ��� Ŀ���� ��� SQL ���� �����ϸ�,
--    SQL ���� �� ���� �ϳ��� ��(ROW)�� ����ϰ� �ȴ�.
--    �׷��� SQL ���� ������ �����(RESULT SET)��
--    ���� ��(ROW)���� ������ ���
--    Ŀ��(CURSUR)�� ��������� �����ؾ� ��(ROW)�� �ٷ� �� �ִ�.


-- 4�� 8�� ����^^ ������ �� ������ ���ͼ� �������� �ϸ� ������ �����ϴ� �� ��ü�� �Ұ����� ��Ȳ~ ���⼭ Ŀ�� ��޵�^^



--�� Ŀ�� �̿� �� ��Ȳ(���� �� ���� ��)
SET SERVEROUTPUT ON;

DECLARE
    V_NAME TBL_INSA.NAME%TYPE;
    V_TEL  TBL_INSA.TEL%TYPE;
    
BEGIN
    SELECT NAME, TEL INTO V_NAME, V_TEL
    FROM TBL_INSA
    WHERE NUM = 1001;
    
    DBMS_OUTPUT.PUT_LINE(V_NAME || ' , ' || V_TEL);
END;

--==>> ȫ�浿 , 011-2356-4528



SET SERVEROUTPUT ON;

DECLARE
    V_NAME TBL_INSA.NAME%TYPE;
    V_TEL  TBL_INSA.TEL%TYPE;
    
BEGIN
    SELECT NAME, TEL INTO V_NAME, V_TEL
    FROM TBL_INSA;          -- Ư�� ���ڵ尡 �ƴ� ��ü�� �̸�, ��ȣ�� �������ڴٴ� ��
    
    DBMS_OUTPUT.PUT_LINE(V_NAME || ' , ' || V_TEL);
END;
--==>> �����߻�
/*
ORA-01422: exact fetch returns more than requested number of rows
*/

--�� Ŀ�� �̿� �� ��Ȳ(���� �� ���� �� - �ݺ����� Ȱ���ϴ� ���)
DECLARE
    V_NAME  TBL_INSA.NAME%TYPE;
    V_TEL   TBL_INSA.TEL%TYPE;
    V_NUM   TBL_INSA.NUM%TYPE := 1001;
BEGIN
    LOOP
        SELECT NAME, TEL INTO V_NAME, V_TEL
        FROM TBL_INSA
        WHERE NUM = V_NUM;
        
        DBMS_OUTPUT.PUT_LINE(V_NAME || ' , ' || V_TEL);
        
        V_NUM := V_NUM + 1;
        
        EXIT WHEN V_NUM >= 1061;
    END LOOP;
END;
--==>>
/*
ȫ�浿 , 011-2356-4528
�̼��� , 010-4758-6532
�̼��� , 010-4231-1236
������ , 019-5236-4221
�Ѽ��� , 018-5211-3542
�̱��� , 010-3214-5357
����ö , 011-2345-2525
�迵�� , 016-2222-4444
������ , 019-1111-2222
������ , 011-3214-5555
������ , 010-8888-4422
���ѱ� , 018-2222-4242
���̼� , 019-6666-4444
Ȳ���� , 010-3214-5467
������ , 016-2548-3365
�̻��� , 010-4526-1234
����� , 010-3254-2542
�̼��� , 018-1333-3333
�ڹ��� , 017-4747-4848
������ , 011-9595-8585
ȫ�泲 , 011-9999-7575
�̿��� , 017-5214-5282
���μ� , 
�踻�� , 011-5248-7789
����� , 010-4563-2587
����� , 010-2112-5225
�迵�� , 019-8523-1478
�̳��� , 016-1818-4848
�踻�� , 016-3535-3636
������ , 019-6564-6752
����ȯ , 019-5552-7511
�ɽ��� , 016-8888-7474
��̳� , 011-2444-4444
������ , 011-3697-7412
������ , 
���翵 , 011-9999-9999
�ּ��� , 011-7777-7777
���μ� , 010-6542-7412
����� , 010-2587-7895
�ڼ��� , 016-4444-7777
����� , 016-4444-5555
ä���� , 011-5125-5511
��̿� , 016-8548-6547
����ȯ , 011-5555-7548
ȫ���� , 011-7777-7777
���� , 017-3333-33334
�긶�� , 018-0505-0505
�̱�� , 
�̹̼� , 010-6654-8854
�̹��� , 011-8585-5252
�ǿ��� , 011-5555-7548
�ǿ��� , 010-3644-5577
��̽� , 011-7585-7474
����ȣ , 016-1919-4242
���ѳ� , 016-2424-4242
������ , 010-7549-8654
�̹̰� , 016-6542-7546
����� , 010-2415-5444
�Ӽ��� , 011-4151-4154
��ž� , 011-4151-4444
*/

--�� Ŀ�� �̿� �� ��Ȳ(���� �� ���� ��)

DECLARE
    V_NAME  TBL_INSA.NAME%TYPE;
    V_TEL   TBL_INSA.TEL%TYPE;
    
    -- Ŀ�� �̿��� ���� Ŀ������ ����(�� Ŀ�� ����)
    CURSOR CUR_INSA_SELECT
    IS
    SELECT NAME, TEL
    FROM TBL_INSA;
    
    
BEGIN
    
    -- Ŀ�� ����
    OPEN CUR_INSA_SELECT;
    
    -- Ŀ�� �� ����������� �����͵� ó��(��Ƴ���)
    LOOP
    -- �� �� �� �� ������ ���� �������� ���� �� ��FETCH��
        FETCH CUR_INSA_SELECT INTO V_NAME, V_TEL;
        
        EXIT WHEN CUR_INSA_SELECT%NOTFOUND;
     
     
    --���
        DBMS_OUTPUT.PUT_LINE(V_NAME || ' , ' || V_TEL);
    END LOOP;
    CLOSE CUR_INSA_SELECT;
    
END;

--==>>
/*
ȫ�浿 , 011-2356-4528
�̼��� , 010-4758-6532
�̼��� , 010-4231-1236
������ , 019-5236-4221
�Ѽ��� , 018-5211-3542
�̱��� , 010-3214-5357
����ö , 011-2345-2525
�迵�� , 016-2222-4444
������ , 019-1111-2222
������ , 011-3214-5555
������ , 010-8888-4422
���ѱ� , 018-2222-4242
���̼� , 019-6666-4444
Ȳ���� , 010-3214-5467
������ , 016-2548-3365
�̻��� , 010-4526-1234
����� , 010-3254-2542
�̼��� , 018-1333-3333
�ڹ��� , 017-4747-4848
������ , 011-9595-8585
ȫ�泲 , 011-9999-7575
�̿��� , 017-5214-5282
���μ� , 
�踻�� , 011-5248-7789
����� , 010-4563-2587
����� , 010-2112-5225
�迵�� , 019-8523-1478
�̳��� , 016-1818-4848
�踻�� , 016-3535-3636
������ , 019-6564-6752
����ȯ , 019-5552-7511
�ɽ��� , 016-8888-7474
��̳� , 011-2444-4444
������ , 011-3697-7412
������ , 
���翵 , 011-9999-9999
�ּ��� , 011-7777-7777
���μ� , 010-6542-7412
����� , 010-2587-7895
�ڼ��� , 016-4444-7777
����� , 016-4444-5555
ä���� , 011-5125-5511
��̿� , 016-8548-6547
����ȯ , 011-5555-7548
ȫ���� , 011-7777-7777
���� , 017-3333-3333
�긶�� , 018-0505-0505
�̱�� , 
�̹̼� , 010-6654-8854
�̹��� , 011-8585-5252
�ǿ��� , 011-5555-7548
�ǿ��� , 010-3644-5577
��̽� , 011-7585-7474
����ȣ , 016-1919-4242
���ѳ� , 016-2424-4242
������ , 010-7549-8654
�̹̰� , 016-6542-7546
����� , 010-2415-5444
�Ӽ��� , 011-4151-4154
��ž� , 011-4151-4444
������ , 010-5555-5555
*/

--++ 1062   �ڹ���   960907-2234567   21/04/09   ����   010-6666-6666   ��ȹ��   �븮   5000000   500000
-- Ŀ�� �̿����� ���� �� --> ���� ���� �˾ƾ� ��


--------------------------------------------------------------------------------

--���� TRIGGER(Ʈ����) ����--

-- �������� �ǹ� : ��Ƽ�, �˹߽�Ű��, �߱��ϴ�, �����ϴ�.

-- 1. TRIGGER(Ʈ����)�� DML �۾� ��, INSERT, UPDATE, DELETE �� ���� �۾��� �Ͼ ��
--    �ڵ������� ����Ǵ�(���ߵǴ�, �˹ߵǴ�) ��ü��
--    �̿� ���� Ư¡�� �����Ͽ�(�ΰ�����) DML TRIGGER ��� �θ��⵵ �Ѵ�.
--    TRIGGER �� ������ ���Ἲ �� �ƴ϶�
--    ������ ���� �۾����� �θ� ���ȴ�.

--    ���ڵ����� �Ļ��� �� �� ����
--    ���߸��� Ʈ����� ����
--    �������� ���� ���� ���� ����
--    ���л굥���ͺ��̽� ��� �󿡼� ���� ���Ἲ ���� ����
--    �������� ���� ��Ģ ���� ����
--    �������� �̺�Ʈ �α� ����
--    �������� ���� ����
--    ������ ���̺� ���� ��������
--    �����̺� �׼��� ��� ����


-- 2. TRIGGER �������� COMMITM, ROLLBACK ���� ����� �� ����.

-- 3. Ư¡ �� ����

--  �� BEFORE STATEMENT TRIGGER
--     SQL ������ ����Ǳ� ���� �� ���忡 ���� �� �� ����  -- ���� �ϳ�(�ش��ϴ� ���� �ϳ��� üũ�ϴ°�)
--  �� BEFORE ROW TRIGGER
--     SQL ������ ����Ǳ� ����(DML �۾��� �������� ����)
--     �� ��(ROW)�� ���� �� ���� ����                      -- ������ ��(���ڵ帶�� üũ�ؾ� �ϴ°�)
--  �� AFTER STATEMENT TRIGGER
--     SQL ������ ����� �� �� ���忡 ���� �� �� ����
--  �� AFTER ROW TRIGGER
--     SQL ������ ����� �Ŀ�(DML �۾��� ������ �Ŀ�)
--     �� ��(ROW)�� ���� �� ���� ����


-- 4. ���� �� ����
/*
CREATE [OR REPLACE] TRIGGER Ʈ���Ÿ�
    [BEFORE] | [AFTER]
    �̺�Ʈ1 [OR �̺�Ʈ2 [OR �̺�Ʈ3]] ON ���̺��
    [FOR EACH ROW [WHEN TRIGGER ����]]
[DECLARE]
    -- ���� ����;
BEGIN 
    -- ���� ����;
END;
*/




--���� AFTER STATEMENT TRIGGER ��Ȳ �ǽ� ����--
-- �� DML �۾��� ���� �̺�Ʈ ���

--�� TRIGGER(Ʈ����) ����(TRG_EVENTLOG)
CREATE OR REPLACE TRIGGER TRG_EVENTLOG
        AFTER
        INSERT OR UPDATE OR DELETE ON TBL_TEST1
DECLARE
BEGIN
    -- �̺�Ʈ ���� ����(���ǹ��� ���� �б�)
    -- ���п� ���� Ű���� CHECK~!!!
    IF (INSERTING)
        THEN INSERT INTO TBL_EVENTLOG(MEMO)
            VALUES('INSERT �������� ����Ǿ����ϴ�.');
    ELSIF (UPDATING)
        THEN INSERT INTO TBL_EVENTLOG(MEMO)
            VALUES('UPDATE �������� ����Ǿ����ϴ�.');
    ELSIF (DELETING)
        THEN INSERT INTO TBL_EVENTLOG(MEMO)
            VALUES('DELETE �������� ����Ǿ����ϴ�.');
    END IF;
    
    --COMMIT;
    -- �� TRIGGER �������� COMMIT ���� ��� ����~!!!
    
END;
--==>> Trigger TRG_EVENTLOG��(��) �����ϵǾ����ϴ�.



--���� BEFORE STATEMENT TRIGGER ��Ȳ �ǽ� ����--
--�� DML �۾� ���� ���� �۾� ���ɿ��� Ȯ��
--   (���� ��å ��� / ���� ��Ģ ����)

--�� TRIGGER(Ʈ����) �ۼ�(TRG_TEST1_DML)

CREATE OR REPLACE TRIGGER TRG_TEST1_DML
        BEFORE
        INSERT OR UPDATE OR DELETE ON TBL_TEST1
BEGIN
    IF (�ð��� ���� 8�� �����̰ų�... ���� 6�� ���Ķ��...)
    THEN �۾��� ���� ���ϵ��� ó���ϰڴ�.
    
    END IF;
END;



CREATE OR REPLACE TRIGGER TRG_TEST1_DML
        BEFORE
        INSERT OR UPDATE OR DELETE ON TBL_TEST1
BEGIN
    IF (TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) < 8 OR 
       (TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) > 17   -- 18 �̶�� �ϸ� 18:04�п��� �ø� �������� �� 18�� �ǹǷ�...
    THEN ���ܸ� �߻���Ű���� �ϰڴ�.
    
    END IF;
END;



CREATE OR REPLACE TRIGGER TRG_TEST1_DML
    BEFORE 
    INSERT OR UPDATE OR DELETE ON TBL_TEST1
BEGIN
    IF (TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) < 8 OR
        TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) >= 18)
        THEN RAISE_APPLICATION_ERROR(-20005, '�۾��� 08 ~ 18:00 ������ �����մϴ�.');
    END IF;
    
    /*
    IF (TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) <= 7 OR
        TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) > 17)
        THEN ���ܸ� �߻���Ű���� �ϰڴ�.
    END IF;
    */
END;


--���� BEFORE ROW TRIGGER ��Ȳ �ǽ� ����--
--�� ���� ���谡 ������ ������(�ڽ�) ������ ���� �����ϴ� ��

-- ������ ����� �� ������ �θ� �����ϰ� �ִ� �ڽ��� �� ã��.
-- �θ� �����ϱ� '����'���� ���ư��� �ڽ��� �����ϰڴ�.

-- �� �θ� 14:00�ÿ� ����� --> �ð��� �ǵ����� �ڽ��� �����! ����� ��
DELETE
FROM TBL_TEST2
WHERE CODE = 1;
    
-- �� 13:59:59�� ����Ǵ� ��.. ���� �̷�. �� ���� ����� �� �� �ڵ�� ����.
--�� TRIGGER(Ʈ����) �ۼ�(TRG_TEST2_DELETE)
CREATE OR REPLACE TRIGGER TRG_TEST2_DELETE
          BEFORE
          DELETE ON TBL_TEST2
          FOR EACH ROW
DECLARE
BEGIN
    DELETE
    FROM TBL_TEST3
    WHERE CODE = :OLD.CODE;  -- 14�ÿ� �̹� ������ 1��.. �� OLD �� �����ͼ� ����� ��..
END;

--�� ��:OLD��
--   ���� �� ���� ��
--   (INSERT : �Է��ϱ� ���� �ڷ�, DELETE : �����ϱ� ���� �ڷ� ��, ������ �ڷ�)

--�� UPDATE �� DELETE + INSERT ... ������ �ִ� �� ����� ���ο� �� INSERT
--             �� �������� UPDATE �ϱ� ������ �ڷ�� :OLD
--             �� �������� UPDATE �� ���� �ڷ�� :NEW -- Ŀ���ؾ� ���̺� �ȿ� ����� ���� ��


--���� AFTER ROW TRIGGER ��Ȳ �ǽ� ����--
--�� ���� ���̺� ���� Ʈ����� ó��

-- TBL_��ǰ, TBL_�԰�, TBL_���
--    0         10  
--   10                   20    X
--  -10


--�� TBL_�԰� ���̺��� ������ �Է� ��(�԰� �̺�Ʈ �߻� ��)
--   TBL_��ǰ ���̺��� ������ ���� Ʈ���� �ۼ�
CREATE OR REPLACE TRIGGER TRG_IBGO
         AFTER 
         INSERT ON TBL_�԰�
         FOR EACH ROW
BEGIN
    IF (INSERTING)
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ + �����԰�Ǵ� �԰����
             WHERE ��ǰ�ڵ� = �����԰�Ǵ� ��ǰ�ڵ�;
    END IF;
END;


-- INSERT INTO TBL_�԰�(..��ǰ�ڵ�..�԰����..)
-- VALUES(.'H001'..10..);

CREATE OR REPLACE TRIGGER TRG_IBGO
         AFTER 
         INSERT ON TBL_�԰�
         FOR EACH ROW
BEGIN
    IF (INSERTING)
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ + :NEW.�԰����
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
    END IF;
END;


--�� TBL_��ǰ, TBL_�԰�, TBL_����� ���迡��
--   �԰����, �������� Ʈ����� ó���� �̷���� �� �ֵ���
--   TRG_IBGO Ʈ���Ÿ� �����Ѵ�.

CREATE OR REPLACE TRIGGER TRG_IBGO
         AFTER 
         INSERT OR UPDATE OR DELETE ON TBL_�԰�
         FOR EACH ROW
BEGIN
    IF (INSERTING)
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ + :NEW.�԰����
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
    END IF;
    
    IF (UPDATING)
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ - :OLD.�԰���� + :NEW.�԰����
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
    END IF;
    
    IF (DELETING)
         THEN UPDATE TBL_��ǰ
             SET ������ = ������ - :OLD.�԰���� 
             WHERE ��ǰ�ڵ� = :OLD.��ǰ�ڵ�;
    END IF;
END;



--�� TBL_��ǰ, TBL_�԰�, TBL_��� �� ���迡��
--   ������, �������� Ʈ����� ó���� �̷���� �� �ֵ���
--   TRG_CHULGO Ʈ���Ÿ� �����Ѵ�


CREATE OR REPLACE TRIGGER TRG_CHULGO
         AFTER 
         INSERT OR UPDATE OR DELETE ON TBL_���
         FOR EACH ROW
BEGIN
    IF (INSERTING)
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ - :NEW.������
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
    END IF;
    
    IF (UPDATING)
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ + :OLD.������ - :NEW.������
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
    END IF;
    
    IF (DELETING)
         THEN UPDATE TBL_��ǰ
             SET ������ = ������ + :OLD.������ 
             WHERE ��ǰ�ڵ� = :OLD.��ǰ�ڵ�;
    END IF;
    
END;