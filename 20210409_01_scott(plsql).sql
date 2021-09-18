
--�� TBL_STUDENTS ���̺���
--   ��ȭ��ȣ�� �ּ� �����͸� �����ϴ�(�����ϴ�) ���ν����� �ۼ��Ѵ�.
--   ��, ID �� PW�� ��ġ�ϴ� ��쿡�� ������ �� �ֵ��� �Ѵ�.
--   ���ν��� �� : PRC_STUDENTS_UPDATE
/*
���� ��)
EXEC PRC_STUDENTS_UPDATE('superman', 'java0006$', '010-9999-9999', '��� �ϻ�');

���ν��� ȣ��� ó���� ���)
superman	������	010-9999-9999	��� �ϻ�
*/
UPDATE ���̺�� 
SET �������=�������� 
WHERE ����;

SELECT I.ID, I.PW, S.TEL, S.ADDR
FROM TBL_IDPW I JOIN TBL_STUDENTS S
ON I.ID = S.ID;


UPDATE (SELECT I.ID, I.PW, S.TEL, S.ADDR
FROM TBL_IDPW I JOIN TBL_STUDENTS S 
ON I.ID = S.ID)T
SET T.TEL = �Է¹�����ȭ��ȣ, T.ADDR = �Է¹����ּ�  
WHERE T.ID = �Է¹��� ���̵� AND T.PW = �Է¹����н�����;

CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
(
  V_ID        IN TBL_IDPW.ID%TYPE
, V_PW        IN TBL_IDPW.PW%TYPE
, V_TEL       IN TBL_STUDENTS.TEL%TYPE
, V_ADDR      IN TBL_STUDENTS.ADDR%TYPE
)
IS
BEGIN
    UPDATE TBL_STUDENTS
    SET
        TEL = V_TEL
      , ADDR = V_ADDR
    WHERE ID = V_ID AND V_PW = (SELECT PW
                                FROM TBL_IDPW
                                WHERE V_ID = ID);
    
    COMMIT;
    
END;
CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
(
  V_ID        IN TBL_IDPW.ID%TYPE
, V_PW        IN TBL_IDPW.PW%TYPE
, V_TEL       IN TBL_STUDENTS.TEL%TYPE
, V_ADDR      IN TBL_STUDENTS.ADDR%TYPE
)
IS
BEGIN
    UPDATE (SELECT I.ID, I.PW, S.TEL, S.ADDR
            FROM TBL_IDPW I JOIN TBL_STUDENTS S
            ON I.ID = S.ID)T
    SET T.TEL = V_TEL, T.ADDR = V_ADDR  
    WHERE T.ID = V_ID AND T.PW = V_PW;
    
    COMMIT;
    
END;




--�� TBL_INSA ���̺��� ������� �ű� ������ �Է� ���ν����� �ۼ��Ѵ�.
--  NUM, NAME, SSN. IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG
--  ������ ���� �ִ� ��� ���̺� ������ �Է� ��
--  NUM �׸�(�����ȣ)�� ����
--  ���� �ο��� �����ȣ ������ ��ȣ�� �� ���� ��ȣ��
--  �ڵ����� �Է� ó���� �� �ִ� ���ν����� �����Ѵ�.
--  ���ν����� : PRC_INSA_INSERT(NUM, NAME, SSN. IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
/*
���� ��)
EXEC PRC_INSA_INSERT('������', '971006-2234567', SYSDATE, '����', '010-5555-5555', '������'
                    , '�븮', 5000000, 500000);
                    
���ν����� ȣ��� ó���� ���)
1016 ������ 971006-2234567 SYSDATE ���� 010-5555-5555 ������ �븮 5000000 500000
*/

CREATE OR REPLACE PROCEDURE PRC_INSA_INSERT
(
     V_NAME       IN TBL_INSA.NAME%TYPE
    ,V_SSN        IN TBL_INSA.SSN%TYPE
    ,V_IBSADATE   IN TBL_INSA.IBSADATE%TYPE
    ,V_CITY       IN TBL_INSA.CITY%TYPE
    ,V_TEL        IN TBL_INSA.TEL%TYPE
    ,V_BUSEO      IN TBL_INSA.BUSEO%TYPE
    ,V_JIKWI      IN TBL_INSA.JIKWI%TYPE
    ,V_BASICPAY   IN TBL_INSA.BASICPAY%TYPE
    ,V_SUDANG     IN TBL_INSA.SUDANG%TYPE
)
IS
    V_NUM   TBL_INSA.NUM%TYPE;
    
BEGIN
    SELECT MAX(NUM)+1 INTO V_NUM
    FROM TBL_INSA;
    
    INSERT INTO TBL_INSA(NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG) 
    VALUES (V_NUM, V_NAME, V_SSN, V_IBSADATE, V_CITY, V_TEL, V_BUSEO, V_JIKWI, V_BASICPAY, V_SUDANG);
    
    COMMIT;
    
END;


--------------------------------------------------------------------------------

--�� TBL_��ǰ, TBL_�԰� ���̺��� �������
-- TBL_�԰� ���̺� ������ �Է� ��(��, �԰� �̺�Ʈ �߻� ��)
-- TBL_��ǰ ���̺��� �������� �Բ� ������ �� �ִ� ����� ����
-- ���ν����� �ۼ��Ѵ�.
-- ��, �� �������� �԰��ȣ�� �ڵ� ���� ó���ȴ�.(������ ��� x)
-- �� �԰��ȣ, ��ǰ�ڵ�, �԰�����, �԰����, �԰�ܰ�
-- ���ν����� : PRC_�԰�_INSERT(��ǰ�ڵ�, �԰����, �԰�ܰ�)

CREATE OR REPLACE PROCEDURE PRC_�԰�_INSERT
( V_��ǰ�ڵ�    IN TBL_�԰�.��ǰ�ڵ�%TYPE
, V_�԰����    IN TBL_�԰�.�԰����%TYPE
, V_�԰�ܰ�    IN TBL_�԰�.�԰�ܰ�%TYPE
)
IS
    V_�԰��ȣ TBL_�԰�.�԰��ȣ%TYPE;
BEGIN
    SELECT NVL(MAX(�԰��ȣ)+1, 1) INTO V_�԰��ȣ
    FROM TBL_�԰�;
    
    UPDATE TBL_��ǰ
    SET ������ = ������ + V_�԰����
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;

    INSERT INTO TBL_�԰�(�԰��ȣ, ��ǰ�ڵ�, �԰�����, �԰����, �԰�ܰ�)
    VALUES(V_�԰��ȣ, V_��ǰ�ڵ�, DEFAULT, V_�԰����, V_�԰�ܰ�);
END;


--�� TBL_�԰� ���̺� �԰� �̺�Ʈ �߻� ��
--  ���� ���̺��� ����Ǿ�� �ϴ� ����
--  �� INSERT �� TBL_�԰�
--    INSERT INTO TBL_�԰�(�԰��ȣ, ��ǰ�ڵ�, �԰�����, �԰����, �԰�ܰ�)
--    VALUES(1, 'H001', SYSDATE, 20, 900);
--  �� UPDATE �� TBL_��ǰ
--    UPDATE TBL_��ǰ
--    SET ������ = ���������� + 20(�� �԰����)
--    WHERE ��ǰ�ڵ�='H001';

CREATE OR REPLACE PROCEDURE PRC_�԰�_INSERT
( V_��ǰ�ڵ�    IN TBL_��ǰ.��ǰ�ڵ�%TYPE
, V_�԰����    IN TBL_�԰�.�԰����%TYPE
, V_�԰�ܰ�    IN TBL_�԰�.�԰�ܰ�%TYPE
)
IS
    V_�԰��ȣ TBL_�԰�.�԰��ȣ%TYPE;
BEGIN
    SELECT NVL(MAX(�԰��ȣ)+1, 1) INTO V_�԰��ȣ
    FROM TBL_�԰�;
    
    UPDATE TBL_��ǰ
    SET ������ = ������ + V_�԰����
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    INSERT INTO TBL_�԰�(�԰��ȣ, ��ǰ�ڵ�, �԰����, �԰�ܰ�)
    VALUES(V_�԰��ȣ, V_��ǰ�ڵ�, V_�԰����, V_�԰�ܰ�);
    
    -- Ŀ�� 
    COMMIT;
    
    -- ���� ó�� 
    EXCEPTION 
        WHEN OTHERS THEN ROLLBACK;
    -- �̻�(OTHERS) = ������ ������ ��Ȳ�� �ٸ� ��Ȳ�� �߻��ϸ�  �ѹ��ض�
END;




-- ���ν��� �������� ���� ó�� 

-- �ǽ� ���̺� ����(TBL_MEMBER) -> 20210409_scott.sql���� ����

-- TBL_MEMBER ���̺� �����͸� �Է��ϴ� ���ν����� ����
-- ��, �� ���ν����� ���� �����͸� �Է��� ���
-- CITY(����) �׸� '����', ' ���', ��õ'�� �Է� �����ϵ� �����Ѵ�
-- ���� ó���� �Ϸ��� �Ѵ�.
-- ���ν��� �� :PRC_MEMBER_INSERT(�̸�, ��ȭ��ȣ, ����)

CREATE OR REPLACE PROCEDURE PRC_MEMBER_INSERT
( V_NAME    IN TBL_MEMBER.NAME%TYPE
, V_TEL     IN TBL_MEMBER.TEL%TYPE
, V_CITY    IN TBL_MEMBER.CITY%TYPE
)
IS
    --���� ������ ������ ������ ���� �ʿ��� ������ ���� ����
    V_NUM   TBL_MEMBER.NUM%TYPE;
    
    -- ����� ���� ���ܿ� ���� ���� ����
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    --���ν����� ���� �Է� ó���� ���������� �����ؾ� �� ����������
    --�ƴ����� ���θ� ���� ���� Ȯ���� �� �ֵ��� �ڵ� ����
    IF (V_CITY NOT IN ('����','���','��õ'))
        --����, ��õ, ��� �� �ش��ϴ� ���� ���ٸ� ���� �߻�
        --�̶��� �ٷ� ���� ó�� �������� �̵���
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    --������ ������ �� ��Ƴ���
    SELECT NVL(MAX(NUM),0) INTO V_NUM   -- 0 OR �ִ밪
    FROM TBL_MEMBER;
    
    --������ ����(INSERT)
    INSERT INTO TBL_MEMBER(NUM,NAME,TEL,CITY)
    VALUES((V_NUM+1),V_NAME,V_TEL,V_CITY);
    
    --Ŀ��
    COMMIT;
    
    --���� ó��(JAVA������ throws)
    /*
    EXCEPTION
        WHEN �̷� ���ܶ��
            THEN �̷��� ó���ϰ�
                 --RAISE_APPLICATION_ERROR(-�����ڵ�, ����������)
                 --�����ڵ� 1~20000������ ����Ŭ���� �̹� ��� ��
        WHEN ���� ���ܶ��
            THEN ������ ó���ض�
    */
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001, '����,��õ,��⸸ �Է� �����մϴ�.');
                 ROLLBACK;  --INSERT �������� ���������� ������� �ʵ���
        WHEN OTHERS
            THEN ROLLBACK;
END;
--==>> Procedure PRC_MEMBER_INSERT��(��) �����ϵǾ����ϴ�.


-- TBL_��� ���̺� ������ �Է� ��(��, ��� �̺�Ʈ �߻� ��)
-- TBL_��ǰ ���̺��� �������� �����Ǵ� ���ν����� �ۼ��Ѵ�,
-- ��, ����ȣ�� �԰��ȣ�� ���������� �ڵ� ����.
-- ����, ��� ������ ��� �������� ���� ���
-- ��� �׼��� ����� �� �ֵ��� ó���Ѵ�.(��� �̷������ �ʵ���)
-- ���ν��� �� : PRC_���_INSERT(��ǰ�ڵ�, ������, ���ܰ�)

CREATE OR REPLACE PROCEDURE PRC_���_INSERT
( V_��ǰ�ڵ�    IN TBL_��ǰ.��ǰ�ڵ�%TYPE
, V_������    IN TBL_���.������%TYPE
, V_���ܰ�    IN TBL_���.���ܰ�%TYPE
)
IS    
    V_����ȣ  TBL_���.����ȣ%TYPE;   
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    -- ���� ����
    SELECT NVL(MAX(����ȣ)+1, 1) INTO V_����ȣ
    FROM TBL_���;
    
    IF ������ > ������
        THEN (UPDATE TBL_��ǰ 
              SET ������ = ������ - V_������
              WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�)
    ELSIF ������ < V_������  
        THEN RAISE USER_DEFINE_ERROR;
        
    INSERT INTO TBL_���(����ȣ, ��ǰ�ڵ�, ������, ���ܰ�)
    VALUES(V_����ȣ, V_��ǰ�ڵ�, V_������, V_���ܰ�);
        
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001, '��� �����մϴ�.');
                 ROLLBACK;  --INSERT �������� ���������� ������� �ʵ���
        WHEN OTHERS
            THEN ROLLBACK;
    
END;

--------------------------------------------------------------------------------
/*
CREATE OR REPLACE PROCEDURE PRC_���_INSERT
( V_��ǰ�ڵ�    IN TBL_��ǰ.��ǰ�ڵ�%TYPE
, V_������    IN TBL_���.������%TYPE
, V_���ܰ�    IN TBL_���.���ܰ�%TYPE
)
IS    
    -- �ֿ� ���� ���� 
    V_����ȣ  TBL_���.����ȣ%TYPE; 
    V_������  TBL_��ǰ.������%TYPE;
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    -- ������ ���� ������ ���� ���� Ȯ�� -> ���� ��� Ȯ�� -> ��� ������ ��
    SELECT ������ INTO V_������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    -- ��� ���������� ������ �� �������� ���� ���� Ȯ��
    -- (�ľ��� ���������� �������� ������ ���� ���)
    IF V_������ > V_������ 
        THEN RAISE USER_DEFINE_ERROR
    END IF;

    -- ������ ������ �� ��Ƴ���
    SELECT NVL(MAX(����ȣ)+1, 1) INTO V_����ȣ
    FROM TBL_���;
    
    -- ������ ����(insert -> tbl_���)   
    INSERT INTO TBL_���(����ȣ, ��ǰ�ڵ�, ������, ���ܰ�)
    VALUES(V_����ȣ, V_��ǰ�ڵ�, V_������, V_���ܰ�);
    
    -- ������ ����(update -> tbl_��ǰ)
    UPDATE TBL_��ǰ 
    SET ������ = ������ - V_������
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;

    COMMIT;
    
    
    -- ���� ó��    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '��� �����մϴ�.');
                 ROLLBACK;  --INSERT �������� ���������� ������� �ʵ���
        WHEN OTHERS
            THEN ROLLBACK;

END;
*/


--�� TBL_��� ���̺� ������ �Է� ��(��, ��� �̺�Ʈ �߻� ��)
--   TBL_��ǰ ���̺��� �������� �����Ǵ� ���ν����� �ۼ��Ѵ�.
--   ��, ����ȣ�� �԰��ȣ�� ���������� �ڵ� ����.
--   ����, ��� ������ ���������� ���� ���
--   ��� �׼��� ����� �� �ֵ��� ó���Ѵ�. (��� �̷������ �ʵ���)
--   ���ν��� ��: PRC_���_INSERT(��ǰ�ڵ�, ������, ���ܰ�)
CREATE OR REPLACE PROCEDURE PRC_���_INSERT
( V��ǰ�ڵ�     IN TBL_���.��ǰ�ڵ�%TYPE
, V������     IN TBL_���.������%TYPE
, V���ܰ�     IN TBL_���.���ܰ�%TYPE
)
IS
    --�ֿ� ���� ����
    V����ȣ           TBL_���.����ȣ%TYPE;
    V������           TBL_��ǰ.������%TYPE;
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    --������ ���� ������ ���� ���� Ȯ�� �� ���� ��� Ȯ�� �� ��� ������ ��
    SELECT ������ INTO V������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V��ǰ�ڵ�;
    
    --��� ���������� �������� �������� ���� ���� Ȯ��
    --(�ľ��� ���������� �������� ������ ���� �߻�)
    IF (V������ > V������)
        THEN RAISE USER_DEFINE_ERROR; 
    END IF;
    
    --������ ������ �� ��Ƴ���
    SELECT NVL(MAX(����ȣ),0) INTO V����ȣ
    FROM TBL_���;
    
    --������ ����(INSERT �� TBL_���)
    INSERT INTO TBL_���(����ȣ,��ǰ�ڵ�,������,���ܰ�)
    VALUES((V����ȣ+1),V��ǰ�ڵ�,V������,V���ܰ�);
    
    --������ ����(UPDATE �� TBL_��ǰ)
    UPDATE TBL_��ǰ
    SET ������ = ������ - V������
    WHERE ��ǰ�ڵ� = V��ǰ�ڵ�;
    
    --Ŀ��
    COMMIT;
    
    --����ó��
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '��� ������ ��� �������� ���� ��� ��ҵ˴ϴ�.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
END;
--==>> Procedure PRC_���_INSERT��(��) �����ϵǾ����ϴ�.



--�� TBL_��� ���̺��� ��� ������ ����(����)�ϴ� ���ν����� �ۼ��Ѵ�.
--   ���ν��� �� : PRC_���_UPDATE(����ȣ, �����Ҽ���);

CREATE OR REPLACE PROCEDURE PRC_���_UPDATE
( V_����ȣ    IN TBL_���.����ȣ%TYPE
, V_�����Ҽ���  IN TBL_��ǰ.������%TYPE
)
IS
  V_�����    TBL_��ǰ.������%TYPE;
  V_������    TBL_��ǰ.������%TYPE;
  V_������    TBL_���.������%TYPE;
  USER_DEFINE_ERROR     EXCEPTION;
  
BEGIN
   SELECT ������  INTO V_������
   FROM TBL_��ǰ WHERE ��ǰ�ڵ� = (SELECT ��ǰ�ڵ� FROM TBL_��� WHERE ����ȣ = V_����ȣ) ;
   SELECT ������ INTO V_������
   FROM TBL_��� WHERE ����ȣ = V_����ȣ;
   
   V_����� := V_������ + V_������;
    
    IF (V_�����Ҽ��� > V_�����)
        THEN RAISE USER_DEFINE_ERROR; 
    END IF;
    
   -- ������ �ԷµǸ� --> ���� ���� �ٽ� ��� ���ϱ�. ����� ������ ����
    UPDATE TBL_��ǰ 
    SET ������ = V_�����
    WHERE V_����ȣ=����ȣ;
    
    UPDATE TBL_��� 
    SET ������ = V_������
    WHERE V_����ȣ=����ȣ;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
             THEN RAISE_APPLICATION_ERROR(-20001, '��� �����մϴ�.');
             ROLLBACK; 
          WHEN OTHERS
              THEN ROLLBACK;
END;

DROP PROCEDURE PRC_���_UPDATE;