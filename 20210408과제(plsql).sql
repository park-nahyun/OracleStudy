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
BEGIN
    -- ����
    TOTAL := NUM1*12 + NVL(NUM2, 0);
    RETURN TOTAL;
END;
--==>> Function FN_PAY��(��) �����ϵǾ����ϴ�.




--�� TBL_INSA ���̺��� �Ի����� ��������
--   ��������� �ٹ������ ��ȯ�ϴ� �Լ��� �����Ѵ�.
--   ��, �ٹ������ �Ҽ��� ���� ���ڸ����� ����Ѵ�.
--   �Լ��� : FN_WORKYEAR(�Ի���)


CREATE OR REPLACE FUNCTION FN_WORKYEAR
(
    HDATE       DATE        -- �Ի��� �Ű����� 
)
RETURN NUMBER               -- ���� �ڷ���
IS
    -- �ֿ� ���� ����
    WORKY   NUMBER;         -- �ٹ���� ���� ���� 
BEGIN
    -- ����
    WORKY := TRUNC((SYSDATE - HDATE)/365,1);
    RETURN WORKY;
END;