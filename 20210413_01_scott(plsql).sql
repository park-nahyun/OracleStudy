SELECT USER
FROM DUAL;
--==>> SCOTT

--���� PACKAGE(��Ű��) ����--

-- 1. PL/SQL �� ��Ű���� ����Ǵ� Ÿ��, ���α׷� ��ü,
--    ���� ���α׷�(PROCEDURE, FUNCTION ��)��
--    �������� ������� ������
--    ����Ŭ���� �����ϴ� ��Ű�� �� �ϳ��� �ٷ� ��DBMS_OUTPUT�� �̴�.

-- 2. ��Ű���� ���� ������ ������ ���Ǵ� ���� ���� ���ν����� �Լ���
--    �ϳ��� ��Ű���� ����� ���������ν� ���� ���������� ���ϰ�
--    ��ü ���α׷��� ���ȭ �� �� �ִ� ������ �ִ�.

-- 3. ��Ű���� ����(PACKAGE SPECIFICATION)��
--    ��ü��(PACKAGE BODY)�� �����Ǿ� ������,
--    �� �κп��� TYPE, CONSTRAINT, VARAIABLE, EXCEPTION, CURSOR,
--    SUBPROGRAM �� ����ǰ�
--    ��ü �κп��� �̵��� ���� ������ �����ϰ� �ȴ�.
--    �׸��� ȣ���� ������ ����Ű����.���ν����� ������ ������ �̿��ؾ� �Ѵ�.

-- 4. ���� �� ����(����)
/*
CREATE [OR REPLACE] PACKAGE ��Ű����
IS
    �������� ����;
    Ŀ�� ����;
    ���� ����;
    �Լ� ����;
    ���ν��� ����;
        :
        
END ��Ű����;
*/

-- 5. ���� �� ����(��ü��)
/*
CREATE [OR REPLACE] PACKAGE BODY ��Ű����
IS
    FUNCTION �Լ���[(�μ�, ...)]
    RETURN �ڷ���
    IS
        ���� ����;
    BEGIN
        �Լ� ��ü ���� �ڵ�;
        RETURN ��;
    END;
    
    PROCEDURE ���ν�����[(�μ�, ...)]
    IS
         ���� ����;
    RETURN
        ���ν��� ��ü ���� �ڵ�;
    END;
END ��Ű����;
*/


--�� �ֹι�ȣ �Է� �� ������ ��ȯ�ϴ� �Լ�
--   �� �Լ��� ������ҷ� ���ϴ� ��Ű�� �ۼ�

-- �Լ� �غ�
CREATE OR REPLACE FUNCTION FN_GENDER(V_SSN VARCHAR2)
RETURN VARCHAR2
IS
    V_RESULT VARCHAR(20);
BEGIN
    IF (SUBSTR(V_SSN, 8, 1) IN ('1', '3'))
        THEN V_RESULT := '����';
    ELSIF (SUBSTR(V_SSN, 8, 1) IN ('2', '4'))
        THEN V_RESULT := '����';
    ELSE
        V_RESULT := 'Ȯ�κҰ�';
    END IF;
    
    RETURN V_RESULT;
END;
--==>> Function FN_GENDER��(��) �����ϵǾ����ϴ�.

-- ��Ű�� ���

-- 1. ���� �ۼ�
CREATE OR REPLACE PACKAGE INSA_PACK
IS
    FUNCTION FN_GENDER(V_SSN VARCHAR2)
    RETURN VARCHAR2;
END INSA_PACK;
--==>> Package INSA_PACK��(��) �����ϵǾ����ϴ�.


-- 2. ��ü�� �ۼ�
CREATE OR REPLACE PACKAGE BODY INSA_PACK
IS

    CREATE OR REPLACE PACKAGE INSA_PACK
IS
    FUNCTION FN_GENDER(V_SSN VARCHAR2)
    RETURN VARCHAR2;
END INSA_PACK;
    CREATE OR REPLACE FUNCTION FN_GENDER(V_SSN VARCHAR2)
RETURN VARCHAR2
IS
    V_RESULT VARCHAR(20);
BEGIN
    IF (SUBSTR(V_SSN, 8, 1) IN ('1', '3'))
        THEN V_RESULT := '����';
    ELSIF (SUBSTR(V_SSN, 8, 1) IN ('2', '4'))
        THEN V_RESULT := '����';
    ELSE
        V_RESULT := 'Ȯ�κҰ�';
    END IF;
    
    RETURN V_RESULT;
END;
END INSA_PACK;


