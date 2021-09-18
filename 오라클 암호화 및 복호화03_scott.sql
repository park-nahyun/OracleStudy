SELECT USER
FROM DUAL;
--==>> SCOTT

-- �� �� �� �ۼ��� ��ȣȭ/��ȣȭ ��Ű�� �׽�Ʈ �� �� �� ?

CREATE TABLE TBL_EXAM
( ID    NUMBER
, PW    VARCHAR2(30)
);
--==>> Table TBL_EXAM��(��) �����Ǿ����ϴ�.

--�� ������ �Է�
INSERT INTO TBL_EXAM(ID, PW) VALUES(1, '0611');

--�� Ȯ��
SELECT *
FROM TBL_EXAM;
--==>> 1  0611


--�� �ѹ�
ROLLBACK;

--�� ��ȣȭ/��ȣȭ ��Ű���� ��ȣȭ �Լ��� Ȱ���� ������ �Է�
INSERT INTO TBL_EXAM(ID, PW) VALUES(1, CRYPTPACK.ENCRYPT('0611', 'SUPERMAN'));
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.



--�� Ȯ��
SELECT *
FROM TBL_EXAM;
-->> 1	x??@+

--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.

SELECT ID, CRYPTPACK.DECRYPT(PW, 'BATMAN') AS PW
FROM TBL_EXAM;
--==>> 1	?Q~?

SELECT ID, CRYPTPACK.DECRYPT(PW, 'SUPERMAN') AS PW
FROM TBL_EXAM;
--==>> 1	0611


