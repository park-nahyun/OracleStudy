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




----------------20210412_02_SCOTT������ �׽�Ʈ ���-------------

--�� Ʈ���� ���� �� 
SELECT *
FROM TBL_�԰�;
--==>> ��ȸ ��� ����

SELECT *
FROM TBL_��ǰ;
--==>> H001	Ȩ����	1500	0


--�� �԰� ���̺� �԰� �̺�Ʈ �߻�

INSERT INTO TBL_�԰�(�԰��ȣ, ��ǰ�ڵ�, �԰�����, �԰����, �԰�ܰ�)
VALUES(1, 'H001', SYSDATE, 100, 1000);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

SELECT *
FROM TBL_�԰�;
--==>> 1	H001	21/04/13	100	1000

SELECT *
FROM TBL_��ǰ;
--==>> H001	Ȩ����	1500	100


--�� �԰� ���̺� �԰� ���� �߻�

UPDATE TBL_�԰�
SET �԰���� = 200
WHERE ��ǰ�ڵ� = 'H001';
--==>> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

SELECT *
FROM TBL_�԰�;
--==>> 1	H001	21/04/13	200	1000

SELECT *
FROM TBL_��ǰ;
--==>> H001	Ȩ����	1500	200



--�� �԰� ���̺� �԰� ���� ���� �߻�

DELETE
FROM TBL_�԰�
WHERE ��ǰ�ڵ� = 'H001';
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

SELECT *
FROM TBL_�԰�;
--==>> ��ȸ ��� ����

SELECT *
FROM TBL_��ǰ;
--==>> H001	Ȩ����	1500	0
