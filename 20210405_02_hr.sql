
SELECT USER
FROM DUAL;
--==>> HR

--------------------------------------------------------------------------------
--���� ����ȭ(Nomalization) ����--

--�� ����ȭ��?
--   �� ����� �����ͺ��̽� ������ �޸� ���� ���� ����
--   � �ϳ��� ���̺���... �ĺ��ڸ� ������ ���� ���� ���̺�� 
--   ������ ������ ���Ѵ�.


-- ex) �����̰�... �������� �Ǹ��Ѵ�.
--     ������Ʈ �� �ŷ�ó���� ����� �����ִ� ��ø�� ������
--     �����ͺ��̽�ȭ �Ϸ��� �Ѵ�.


-- ���̺�� : �ŷ�ó����
/*
  10Byte    10Byte   10Byte          10Byte     10Byte  10Byte  10Byte 
--------------------------------------------------------------------------------
�ŷ�óȸ��� ȸ���ּ� ȸ����ȭ        �ŷ�ó������ ���� �̸���   �޴���
--------------------------------------------------------------------------------
    LG      ���￩�ǵ� 02-3456-6789   ������       ���� shy@ha... 010-...
    LG      ���￩�ǵ� 02-3456-6789   �ڹ���       ���� pmj@ha... 010-...
    LG      ���￩�ǵ� 02-3456-6789   ��ƺ�       �븮 kab@ha... 010-...
    LG      ���￩�ǵ� 02-3456-6789   ������       ���� ajm@ha... 010-...
    SK      ����Ұ��� 02-1234-5678   ���ϸ�       ���� lhr@ha... 010-...
    LG      �λ굿���� 051-9999-9999  �̻���       �븮 lsr@ha... 010-...
--------------------------------------------------------------------------------
*/



--�� �� 1 ����ȭ
--> � �ϳ��� ���̺� �ݺ��Ǿ� �÷� ������ �����Ѵٸ�
--  ������ �ݺ��Ǿ� ������ �÷��� �и��Ͽ�
--  ���ο� ���̺��� ������ش�.


--> �� 1 ����ȭ�� �����ϴ� �������� �и��� ���̺���
--  �ݵ�� �θ� ���̺�� �ڽ� ���̺��� ���踦 ���� �ȴ�.

--> �θ� ���̺� �� �����޴� �÷� �� PRIMARY KEY(��������)
--  �ڽ� ���̺� �� �����ϴ� �÷� �� FOREIGN KEY(��������)

--> �����޴� �÷��� ���� Ư¡(�θ� ���̺�)
--  - �ݵ�� ������ ��(������)�� ���;� �Ѵ�.
--    ��, �ߺ��� ��(������)�� ����� �Ѵ�.
--  - NULL �� �־�� �ȵȴ�. (����־�� �ȵȴ�.)
--    ��, NOT NULL �̾�� �Ѵ�.

--> �� 1 ����ȭ�� �����ϴ� ��������
--  �θ� ���̺��� PRIMARY KEY ��
--  �׻� �ڽ� ���̺��� FOREIGN KEY �� ���̵ȴ�.
-- = �ݺ��ؼ� �����ϴ� ���� ������ �̰͸� ��Ƽ� ���� ���̺��� ����� ���� 1 ����ȭ.



/*
����) ���� ���ǵ� LG ��� ȸ�翡 �ٹ��ϴ� �ŷ�ó ���� �����
      �� 100�� ���̶�� �����Ѵ�.
      (�� ��(���ڵ�)�� 70Byte �̴�.)
      
      ��� ��... �����￩�ǵ����� ��ġ�� ��LG�� ���簡
      ����⺻�硻 ���� ����� �����ϰ� �Ǿ���.
      �̷� ����...
      ȸ�� �ּҴ� �����д硻���� �ٲ��
      ȸ�� ��ȭ��  ��031-1111-2222���� �ٲ�� �Ǿ���.
      
      �׷���... 100�� ���� ȸ���ּҿ� ȸ����ȭ�� �����ؾ� �Ѵ�.
            --> �� 1 ����ȭ�� �� �ٸ�? 1���� ȸ���ּҿ� ȸ�� ��ȭ�� �����ϸ� �ȴ�.
      
      - �� �� ����Ǿ�� �� ������ �� UPDATE ����
      
      UPDATE �ŷ�ó����
      SET ȸ���ּ� = '���д�', ȸ����ȭ = '031-1111-2222'
      WHERE �ŷ�óȸ���  = 'LG'
        AND ȸ���ּ� = '���￩�ǵ�';

        
     --> 100�� �� ���� �ϵ��ũ�󿡼� �о�ٰ�
         �޸𸮿� �ε�����־�� �Ѵ�.
         �� 100�� * 7Byte �� ���
         �ϵ��ũ�󿡼� �о�ٰ� �޸𸮿� �ε���� �־�� �Ѵٴ� ���̴�.
         
         --> �̴� ���̺��� ���谡 �߸��Ǿ����Ƿ�
             DB ������ ������ �޸� ���� ���� DOWN �� ���̴�.
             
             --> �׷��Ƿ� ����ȭ ������ �����ؾ� �Ѵ�.
      
              
        --> �� 1 ����ȭ�� �ߴٸ�
      UPDATE ȸ��
      SET ȸ���ּ� = '���д�', ȸ����ȭ = '031-1111-2222'
      WHERE ȸ��ID=10;
      
      --> 1 �� ���� �ϵ��ũ �󿡼� �о �޸𸮿� �ε�.
      --  ��, 1 * 40 Byte �� �ϵ��ũ �󿡼� �о�ٰ� �޸𸮿� �ε�~
      --  �̴� ���̺� ���谡 �� �� ��Ȳ.
      
      -- ����ȭ�� �����ϱ� �������� 100�� ���� ó���ؾ� �� ��������
      -- 1�Ǹ� ó���ϸ� �Ǵ� ������ �ٲ� ��Ȳ�̱� ������
      -- DB ������ �޸� �� ���� ���� ������ ó���� ���̴�.
*/

-- A. �ŷ�óȸ���, ȸ����ȭ

SELECT �ŷ�óȸ���, ȸ����ȭ             |   SELECT �ŷ�óȸ���, ȸ����ȭ   
FROM ȸ��                                |   FROM �ŷ�ó����                         
--> 3 * 40Byte                           |   --> 200�� * 70Byte


-- B. �ŷ�ó������, ����                  |   SELECT �ŷ�ó������, ����
SELECT �ŷ�ó������, ����                 |   FROM �ŷ�ó����
FROM ����                                |   --> 200�� * 70Byte
--> 200�� * 50Byte


-- C. �ŷ�óȸ���, �ŷ�ó������                |     SELECT �ŷ�óȸ���, �ŷ�ó������
SELECT ȸ��.�ŷ�óȸ���, ����.�ŷ�ó������     |      FROM �ŷ�ó����
FROM ȸ�� JOIN ����                            |      --> 200�� * 70Byte
ON ȸ��.ȸ��ID = ����.ȸ��ID;                  |
--> (ȸ��) + (����)                            |
--> (3 * 40Byte) + (200�� * 50Byte)

/*
- ���̺�� : �ֹ�
------------------------------------------------------------------------------------
    ��ID        ��ǰ�ڵ�              �ֹ�����            �ֹ�����
+++++++++++++++++++++++++++++++++++++++++++++++++++++++
                (P,K)
------------------------------------------------------------------------------------
PNH1227(�ڳ���)  SWK123(�����)    2021-02-04 11:11:11        50
HHR7733(������)  YPR234(���ĸ�)    2021-02-04 13:40:50        30
LHJ3361(������)  CPI110(������)    2021-02-05 10:22:30        20
LHJ3361(������)  SWK123(�����)    2021-02-06 17:00:20        20
LSH7654(�̻�ȭ)  CPI110(������)    2021-02-07 05:00:13        50
                            :
                            :
____________________________________________________________________________________
*/

-- ��ID�� �����̸Ӹ� Ű�� �����Ǹ� ���� �ٽô� �� ��..
-- ��ǰ�ڵ尡 �����̸Ӹ� Ű�� �Ǹ� ����� �ٽô� �� ��..
-- �ֹ����ڰ� �����̸Ӹ� Ű�� �Ǹ� ���� ����� ���ÿ� �� ��..
-- Ư�� �ϳ��� Ű�� �����̸Ӹ� Ű�� �Ǿ�� �ȵ�..
-- �����̸Ӹ� Ű�� ���̺� �� �ϳ��� �����ϴ�.
-- �׷��� �� Ű�� �����ϴ� �÷��� �������� �����ϴ�.
-- (��ID+��ǰ�ڵ�) �ϳ��� Ű~! ����..


/*
--�� �ϳ��� ���̺� �����ϴ� PRIMARY KEY �� �ִ� ������ 1���̴�.
--   ������, PRIMARY KEY �� �̷��(�����ϴ�) �÷��� ������ 
--   ����(�ټ�, ������)�� ���� �����ϴ�.
--   �÷� 1���θ� (���� �÷�) ������ PRIMARY KEY��
--   Single Primary Key ��� �Ѵ�.
--   (���� �����̸Ӹ� Ű)
--   �� �� �̻��� �÷����� ������ PRIMARY KEY��
--   Composite Primary Key ��� �θ���.
--   (���� �����̸Ӹ� Ű)
*/



/*
-- ���̺�� : ȸ�� �� �θ� ���̺�

  10Byte    10Byte   10Byte          10Byte     10Byte  10Byte  10Byte 
--------------------------------------------------------------------------------
ȸ��ID �ŷ�óȸ��� ȸ���ּ� ȸ����ȭ      
------
(�����޴� �÷� �� PRIMARY KEY)
--------------------------------------------------------------------------------
10        LG      ���￩�ǵ� 02-3456-6789  
20        LG      ���￩�ǵ� 02-3456-6789    
30        LG      ���￩�ǵ� 02-3456-6789   
--------------------------------------------------------------------------------

-- ���̺�� : ���� �� �ڽ� ���̺�

10Byte     10Byte  10Byte  10Byte   10Byte
--------------------------------------------------------------------------------
 �ŷ�ó������ ���� �̸���   �޴���    ȸ��ID
--------------------------------------------------------------------------------
������       ���� shy@ha... 010-...   10
�ڹ���       ���� pmj@ha... 010-...   10
��ƺ�       �븮 kab@ha... 010-...   10
������       ���� ajm@ha... 010-...   10
���ϸ�       ���� lhr@ha... 010-...   20
�̻���       �븮 lsr@ha... 010-...   30
                :
                :
--------------------------------------------------------------------------------
*/

--�� ���̺��� ����(�и�)�Ǳ� ���� ���·� ��ȸ

SELECT A.�ŷ�óȸ���, A.ȸ���ּ�, A.ȸ����ȭ        
     , B.�ŷ�ó������, B.����, B.�̸���, B.�޴���
FROM ȸ�� A, ���� B
WHERE A.ȸ��ID = B.ȸ��ID;
--==>> ������ ���·� ��ȸ�ϴµ� �̻� ����.


-- ����ȭ�� �ɰ��� �Ŵ�..
-- �� �ϴ� �Ŵ�? DB ���� �޸� ���� ���� ����~




--�� �� 2 ����ȭ
--> �� 1 ����ȭ�� ��ģ ��������� PRIMARY KEY �� SINGLE COLUMN �̶��
--  �� 2 ����ȭ�� �������� �ʴ´�.
--  ������, PRIMARY KEY �� COMPOSITE COLUMN �̶��
--  ��.��.�� �� 2 ����ȭ�� �����ؾ� �Ѵ�.

--> �ĺ��ڰ� �ƴ� �÷��� �ĺ��� ��ü �÷��� ���� �������̾�� �ϴµ�
--  �ĺ��� ��ü �÷��� �ƴ� �Ϻ� �ĺ��� �÷��� ���ؼ��� �������̶��
--  �̸� �и��Ͽ� ���̺��� �������ش�.
/*
���̺�� : ���� �� �θ� ���̺�
--------------------------------------------------------------------------
�����ȣ  �����   �����ڹ�ȣ  �����ڸ�   ���ǽ��ڵ� ���ǽǼ���
++++++++          ++++++++++
   ( P      ��      K )
--------------------------------------------------------------------------
JAVA101  �ڹٱ���   21         �念��     A403      ����ǽ��� 3�� 30�� �Ը�
JAVA102  �ڹ��߱�   22         �׽���     T502      ���ڰ��а� 5�� 20�� �Ը�
DB102    ����Ŭ�߱� 22         �׽���     A201      ����ǽ��� 2�� 50�� �Ը�
DB102    ����Ŭ�߱� 21         �念��     T502      ���ڰ��а� 5�� 20�� �Ը�
DB103    ����Ŭ�߱� 22         ����     A203      ����ǽ��� 2�� 30�� �Ը�
JSP105   JSP��ȭ    21         �念��     K101      �ι���ȸ�� 1�� 80�� �Ը�
                                :   
                                :
---------------------------------------------------------------------------

-- ���⼭ ������� '�����ȣ'���׸� �������̴�. �����ڸ��� �����ڹ�ȣ����..
-- �׷��� �����ȣ, �����/ ��� �Ѹ� ���� ���� ���̺��� ������ �Ѵ�.
-- �����ڹ�ȣ, �����ڸ� �� �Ѹ� �ִ� ���̺� ����...


���̺�� : ���� �� �ڽ� ���̺�
-----------------------------------------------------
�����ȣ    �����ڹ�ȣ      �й�      �л���      ����
=====================
      (F.K)
-----------------------------------------------------
 DB102         21         2102110    �弭��      80
 DB102         21         2102127    ������      76
                            :
                            :
-----------------------------------------------------
*/

--�� �� 3 ����ȭ
--> �ĺ��ڰ� �ƴ� �ķ��� �ĺ��ڰ� �ƴ� �÷��� �������� ��Ȳ�̶��
--  �̸� �и��Ͽ� ���ο� ���̺��� ������ �־�� �Ѵ�.

-- ������ ���ǽǼ����� ���ǽ��ڵ忡 ������.. ��׸� ���� ���̺��� �������� �Ѵ�.



--�� ����(Relation)�� ����

-- 1 : 1
--> �ǵ��� ���ؾ���
-- 1 : ��(MANY)
--> �� 1 ����ȭ�� ��ģ ��������� ��ǥ������ ��Ÿ���� �ٶ����� ����.
--  ������ �����ͺ��̽��� Ȱ���ϴ� �������� �߱��ؾ� �ϴ� ����.


-- ��(MANY) : ��(MANY)
--> ������ �𵨸������� ������ �� ������
--  ���� �������� �𵨸������� ������ �� ���� ����.


/*
���̺�� : �� (�� )                      ���̺�� : ��ǰ (��)
----------------------------             ---------------------------------
����ȣ  ����   �̸��� ...             ��ǰ�ڵ�    ��ǰ��     ��ǰ�ܰ�...  
++++++++                                  ++++++
----------------------------             ---------------------------------
1100      �Ҽ���   SSH@...                SWK123     �����      1500
1101      ������   CES@...                GGK        ���ڱ�       800
1102      ������   SHJ@...                GGC        �ڰ�ġ       700
            :                                           :
                    ���̺�� : �ֹ����(����)
                    ----------------------------------------------
                    ����ȣ    ��ǰ�ڵ�    �ֹ�����    �ֹ�����...
                    ====================
                    ----------------------------------------------
                    1100        SWK123      2021....    30  ...
                    1101        SWK123      2021....    20  ...
                    1102        GGC345      2021....    20  ...
                    1102        GGC345      2021....    20  ...
                    1103        SWK123      2021....    20  ...

                    ----------------------------------------------
            
*/


--�� �� 4 ����ȭ
--> ������ Ȯ���� ����� ���� ����:�١� ���踦 ��1:�١� ����� ��Ʈ���� ������
--  �� 4 ����ȭ�� ���� �����̴�.
--  �� �Ϲ������� �Ļ� ���̺� ����
--     �� ����:�١� ���踦 ��1:�١� ����� ���߸��� ���� ����.
-- �л�-���� ������ '������û' ���̺�, ��-��ǰ ������ '�ֹ�' ���̺��� ����� ��..

--�� ������ȭ(������ȭ)
/*
--A ��� �� ������ȭ�� �������� �ʴ� ���� �ٶ����� ���

���̺�� : �μ�          ���̺�� : ���
  10     10    10          10     10    10   10   10      10                  10
-------------------     ---------------------------------------             -------------
�μ���ȣ �μ��� �ּ�     �����ȣ ����� ���� �޿� �Ի��� �μ���ȣ      +       �μ���
++++++++                ++++++++                       =========(foreign key)
-------------------     ---------------------------------------             -------------
    10�� ��                       1,000,000�� ��
-------------------     ---------------------------------------             

>> ���� �м� �� ��ȸ �����
---------------------------
�μ���  �����  ����   �޿�
---------------------------

�� ���μ��� ���̺�� ������� ���̺��� JOIN ���� ���� ũ��
    (10 * 30Byte) + (100000 * 60Byte) = 300 + 60000000 = 60,000,300Byte

�� ������� ���̺��� ������ȭ ������ �� �� ���̺� �о�� ���� ũ��
   (��, �μ� ���̺��� �μ��� �÷��� ��� ���̺� �߰��� ���)
    1000000 * 70Byte = 70,000,000Byte �� ���� ��..
    
-- �� ����ȭ�� �ϴ� ���� �ٶ����ϴ�. 




--B ��� �� ����ȭ�� �����ϴ� ���� �ٶ����ϴ�.


���̺�� : �μ�          ���̺�� : ���
  10     10    10          10     10    10   10   10      10                  10
-------------------     ---------------------------------------             -------------
�μ���ȣ �μ��� �ּ�     �����ȣ ����� ���� �޿� �Ի��� �μ���ȣ      +       �μ���
++++++++                ++++++++                       =========(foreign key)
-------------------     ---------------------------------------             -------------
    500,000�� ��                    1,000,000�� ��
-------------------     ---------------------------------------             

>> ���� �м� �� ��ȸ �����
---------------------------
�μ���  �����  ����   �޿�
---------------------------

�� ���μ��� ���̺�� ������� ���̺��� JOIN ���� ���� ũ��
    (500,000 * 30Byte) + (100000 * 60Byte) = 15,000,000 + 60000000 = 75,000,000Byte

�� ������� ���̺��� ������ȭ ������ �� �� ���̺� �о�� ���� ũ��
   (��, �μ� ���̺��� �μ��� �÷��� ��� ���̺� �߰��� ���)
    1000000 * 70Byte = 70,000,000Byte �� ���� ��..
    
-- �� ������ȭ�� �ϴ� ���� �ٶ����ϴ�. 
-- ����ȭ �� ���� ���� �м�, ���� �д� ��Ȯ�� �Ǿ� �־�� ��..
-- �׷��� ����ȭ �� �� ������ȭ �� �� ���� ����..

*/

/*
1 : Ư�� �÷� ���� �ݺ��ؼ� ������ �� ��׸� �и��ؼ� ���̺��� ����� ��
   �̰� �����ϸ� �ݵ�� �θ�(�����޴�, �ĺ���)�� �ڽ�(�����ϴ�) ���̺��� �����.
   �ĺ����� Ư¡ ù ��°. ������ ���� ������ �Ѵ�. �� ��° not null�̾�� �Ѵ�.

  1 ����ȭ�� �ϰ� ����.. ���̺���.. �ǰ��ǰ�.. �����µ�...

2 : 1����ȭ�� ��ģ ���������.. '���� �����̸Ӹ� Ű'�� �ƴϳĿ� ���� 2����ȭ�� �����ȴ�.
    �� ���̺��� �ϳ��� �����̸Ӹ�Ű�� ����.
    �׷��� �����̸Ӹ� Ű �ϳ����� ���� ���� �÷��� ���� �����ϴ�.
    �� �� ��ĺ��ڵ��� ���� �����̸Ӹ� Ű�� �÷� �Ϻο��� ������ �Ѵٸ� 
    ���� ������ �ֵ��� �и��ؼ� ������ȭ�� �����ؾ� �Ѵ�.
    
3 : �ĺ��ڰ� �ƴ� �÷��� �ĺ��ڿ� �������̾�� �ϴµ�
    �ĺ��ڰ� �ƴ� �÷��� �ĺ��ڰ� �ƴ� �÷����� �������̶�� ���� ���̺��� �����ؾ� �Ѵ�.


4 : 4 ����ȭ ���� ���踦 �����ؾ� �Ѵ�. 
    1:1 ����� ���������� ���ؾ� ������ ��¿ �� ���� �Ǵ� ��찡 �ִ�.
    1:�� ����� ������ ������ ���̽����� ���� �ٶ����� ����.
    ��:�� ����� �������δ� ������ ������ ���������δ� �Ұ����� ����.
          �� �� ��:�� ���� �߰� ���� ������ �ϴ� �Ļ� ���̺��� ������
          ��:�� �� 1:��, 1:1 ������ �ɰ��� ��.
          
          
������ȭ : ������ ���� �ٽ� ��ġ�� ��. �׳� �ϴ� ���� �ƴ϶�.. ������ ���� ���� ���� �м�, ���並 �ϰ�
           ������ ���̺� �Ǽ��� �뷫 ����ϰ�.. ����ȭ/������ȭ ���� �޸� ũ�⸦ �� ���� ��
           ������ȭ�� ���� �� �޸𸮸� �Ƴ� �� �ִٸ� �� �� �����ϴ� ��.
*/


/*
���̺�� : ��� �� �θ� ���̺�
----------------------------------------------------------------------------------
�����ȣ    �����    �ֹι�ȣ   �Ի���     �޿�       ����
++++++++
----------------------------------------------------------------------------------
  7369      ������   9XXXXXX..  2010-X..  XXXXXX      ����
  7370      �谡��   9XXXXXX... 2011-X..  XXXXXX      ����
  7371      �輭��   9XXXXXX... 2010-X..  XXXXXX      ����
  7372      ��ƺ�   9XXXXXX... 2010-X..  XXXXXX      �븮
                            :
----------------------------------------------------------------------------------


���̺�� : ��� ���� �� �ڽ� ���̺�                                                               ���̺� : ��������
-------------------------------------------------------                                         -----------------
�ֹι�ȣ    �����ȣ    ����      ����                                                           ���賻��  �ڵ��
++++++++    ========                                                        
-------------------------------------------------------                                        ------------------
9XXXXX..    7369       �Ƴ�      ������                                                          ����         1
9XXXXX..    7370       ����      ������
9XXXXX..    7370       �Ƶ�      ������                                                           �Ƴ�        2
9XXXXX..    7371       ����      ������
                            :                                                                            :
-------------------------------------------------------                                         ---------------
-- ������? �ƺ����� �������� ��ȥ�ϸ� �������� ��ƺ��� �Ƴ��� ���� ���� ���� ����. �ֹι�ȣ �ϳ��� ����ϴϱ��~
-- 1����ȭ ö���ϰ� �ؾ���.. ����, ���� ��.. �ƺ�/�ƹ���.. �̷��� ȣĪ ���� ���Ѿ��� --> �� �ڵ�ȭ �ؾ� ��....
-- 1. ���� ������ �����Ͱ� �ԷµǴ� ��Ȳ�̶��... �� �ڵ�ȭ~!!!
-- 2. ���� �÷��� ���� �� �� �ִ� �����Ͷ��... �� �÷����� �������� �ʴ´�~!!!

-------------------------------------------------------------------
-- ......               �Ǹ���                 �ǸŻ��� �� �� �÷� ������ �򰥸��� ������..
-------------------------------------------------------------------
--                  2021-04-05                  �Ǹ���
--                                              �Ǹ� ����/�Ǹ� �Ϸ� .. �̷� �� �򰥸�����..

----------------------
-- �������       ����
----------------------
-- �� ��  ���̴� ���������� ������.. ���̸� �Է��ؼ� �־������ �ų� �����ؾ���..

-----------------------------------------------------------------------------------------
/*
-- �� ����

1. ����(relationship, relation)
    - ��� ��Ʈ��(entry)�� ���ϰ��� ������.
    - �� ��(column)�� ������ �̸��� ������ ������ ���ǹ��ϴ�.
    - ���̺��� ��� ��(row = Ʃ�� = tuple)�� �������� ������ ������ ���ǹ��ϴ�.

2. �Ӽ�(attribute)
    - ���̺��� ��(column)�� ��Ÿ����.
    - �ڷ��� �̸��� ���� �ּ� ���� ���� : ��ü�� ����, ���� ���
    - �Ϲ� ����(file)�� �׸�(������ = item = �ʵ� = field)�� �ش��Ѵ�.
    - ��ƼƼ(entity)�� Ư���� ���¸� ���
    - �Ӽ�(attribute)�� �̸��� ��� �޶�� �Ѵ�.
    
3. Ʃ�� = tuple = ��ƼƼ = entity
    - ���̺��� ��(row)
    - ������ �� ���� �Ӽ�(attribute)���� ����
    - ���� ���� ����
    - �Ϲ� ����(file)�� ���ڵ�(record)�� �ش��Ѵ�.
    - Ʃ�� ����(tuple variable)
        : Ʃ��(tuple)�� ����Ű�� ����, ��� Ʃ�� ������ ���������� �ϴ� ����
        
4. ������(domain)
    - �� �Ӽ�(attribute)�� ���� �� �ֵ��� ���� ������ ����
    - �Ӽ� ��� ������ ���� �ݵ�� ������ �ʿ�� ����
    - ��� �����̼ǿ��� ��� �Ӽ����� �������� ������(atomic)�̾�� ��.
    - ������ ������
        : �������� ���Ұ� �� �̻� �������� �� ���� ����ü�� ���� ��Ÿ��

5. �����̼�(relation)
    - ���� �ý��ۿ��� ���ϰ� ���� ����
    - �ߺ��� Ʃ��(tuple = entity = ��ƼƼ)�� �������� �ʴ´�.
        �� ��� ������(Ʃ���� ���ϼ�)
    - �����̼� = Ʃ��(��ƼƼ = entity)�� ����. ���� Ʃ���� ������ ���ǹ��ϴ�.
    - �Ӽ�(attribute)������ ������ ����.
*/

----------------------------------------------------------------------------------

--���� ���Ἲ(Integrity) ����--
/*
1. ���Ἲ���� ��ü ���Ἲ(Entity Integrity)
              ���� ���Ἲ(Relational Integrity)
              ������ ���Ἲ(Domain Integrity) �� �ִ�.
              
2. ��ü ���Ἲ
   ��ü ���Ἲ�� �����̼ǿ��� ����Ǵ� Ʃ��(tuple)��
   ���ϼ��� �����ϱ� ���� ���������̴�.
   
3. ���� ���Ἲ
   ���� ���Ἲ�� �����̼� ���� ������ �ϰ�����
   �����ϱ� ���� ���������̴�.

4. ������ ���Ἲ
   ������ ���Ἲ�� ��� ������ ���� ������
   �����ϱ� ���� ���������̴�.
   
5. ���������� ����

    - PRIMARY KEY(PK:P) �� �θ� ���̺��� �����޴� �÷�  �� �⺻Ű, �ĺ���
      �ش� �÷��� ���� �ݵ�� �����ؾ� �ϸ�, �����ؾ� �Ѵ�.
      (UNIQUE �� NOT NULL �� ���յ� ����)
      
    - FOREIGN KEY(FK:F:R) �� �ڽ� ���̺��� �����ϴ� �÷� �� �ܷ�Ű, �ܺ�Ű, ����Ű
      �ش� �÷��� ���� �����Ǵ� ���̺��� �÷� �����͵� �� �ϳ���
      ��ġ�ϰų� NULL �� ������.
      
    - UNIQUE(UK:U)
      ���̺� ������ �ش� �÷��� ���� �׻� �����ؾ� �Ѵ�.
      
    - NOT NULL(NN:CK:C)
      �ش� �÷��� NULL �� ������ �� ����.
      
    - CHECK(CK:C)
      �ش� �÷����� ���� ������ �������� ���� ������ ������ �����Ѵ�.
      
*/

---------------------------------------------------------------------------------

--���� PRIMARY KEY ����--
--1. ���̺� ���� �⺻ Ű�� �����Ѵ�.

--2. ���̺��� �� ���� �����ϰ� �ĺ��ϴ� �÷� �Ǵ� �÷��� �����̴�.
--   �⺻ Ű�� ���̺� �� �ִ� �ϳ��� �����Ѵ�.
--   �׷��� �ݵ�� �ϳ��� �÷����θ� �����Ǵ� ���� �ƴϴ�.
--   NULL �� �� ����, �̹� ���̺� �����ϰ� �ִ� �����͸�
--  �ٽ� �Է��� �� ������ ó���ȴ�.
--   UNIQUE INDEX �� �ڵ����� ����ȴ�.
--   (����Ŭ�� ��ü������ �����.)


-- 3. ���� �� ����
-- �� �÷� ������ ����
-- �÷��� ������Ÿ�� [CONSTRAINT CONSTRAINT��] PRIMARY KEY[(�÷���, ...)]

-- �� ���̺� ������ ����
-- �÷��� ������Ÿ��,
-- �÷��� ������Ÿ��,
-- CONSTRAINT CONSTRAINT�� PRIMARY KEY[(�÷���, ...)]

-- 4. CONSTRAINT �߰� �� CONSTRAINT���� �����ϸ�
--    ����Ŭ ������ �ڵ������� CONSTRAINT���� �ο��ϰ� �ȴ�.
--    �Ϲ������� CONSTRAINT���� �����̺��_�÷���_CONSTRAINT��
--    �������� ����Ѵ�.


--�� PK ���� �ǽ�(�� �÷� ������ ����)
-- ���̺� ����
CREATE TABLE TBL_TEST1
(
    COL1 NUMBER(5)              PRIMARY KEY
  , COL2 VARCHAR2(30)
);
--==>> Table TBL_TEST1��(��) �����Ǿ����ϴ�.


-- ������ �Է�
INSERT INTO TBL_TEST1(COL1, COL2) VALUES(1, 'TEST');
INSERT INTO TBL_TEST1(COL1, COL2) VALUES(2, 'ABCD');
INSERT INTO TBL_TEST1(COL1, COL2) VALUES(3, NULL);
INSERT INTO TBL_TEST1(COL1) VALUES(4); -- ���� ���� ����
INSERT INTO TBL_TEST1(COL1, COL2) VALUES(2, 'ABCD');    --> �����߻� : ORA-00001: unique constraint (HR.SYS_C007105) violated
INSERT INTO TBL_TEST1(COL1, COL2) VALUES(2, 'KKKK');    --> �����߻� 
INSERT INTO TBL_TEST1(COL1, COL2) VALUES(5, 'ABCD'); 
INSERT INTO TBL_TEST1(COL1, COL2) VALUES(NULL, NULL);   --> �����߻� 
INSERT INTO TBL_TEST1(COL1, COL2) VALUES(NULL, 'STUDY');    --> �����߻� 
INSERT INTO TBL_TEST1(COL2) VALUES('STUDY');    --> �����߻� 


COMMIT;
--==>> Ŀ�� �Ϸ�.

SELECT *
FROM TBL_TEST1;
--==>>
/*
1	TEST
2	ABCD
3	
4	
5	ABCD
*/

DESC TBL_TEST1;
--==>>
/*
�̸�   ��?       ����           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)     �� PK ���� Ȯ�� �Ұ�
COL2          VARCHAR2(30) 
*/


--�� �������� Ȯ��
SELECT *
FROM USER_CONSTRAINTS;
--==>>
/*
HR	REGION_ID_NN	C	REGIONS	"REGION_ID" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			14/05/29				
HR	REG_ID_PK	P	REGIONS					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			14/05/29	HR	REG_ID_PK		
HR	COUNTRY_ID_NN	C	COUNTRIES	"COUNTRY_ID" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			14/05/29				
HR	COUNTRY_C_ID_PK	P	COUNTRIES					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			14/05/29	HR	COUNTRY_C_ID_PK		
HR	COUNTR_REG_FK	R	COUNTRIES		HR	REG_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			14/05/29				
HR	LOC_CITY_NN	C	LOCATIONS	"CITY" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			14/05/29				
HR	LOC_ID_PK	P	LOCATIONS					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			14/05/29	HR	LOC_ID_PK		
HR	LOC_C_ID_FK	R	LOCATIONS		HR	COUNTRY_C_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			14/05/29				
HR	DEPT_NAME_NN	C	DEPARTMENTS	"DEPARTMENT_NAME" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			14/05/29				
HR	DEPT_ID_PK	P	DEPARTMENTS					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			14/05/29	HR	DEPT_ID_PK		
HR	DEPT_LOC_FK	R	DEPARTMENTS		HR	LOC_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			14/05/29				
HR	JOB_TITLE_NN	C	JOBS	"JOB_TITLE" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			14/05/29				
HR	JOB_ID_PK	P	JOBS					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			14/05/29	HR	JOB_ID_PK		
HR	EMP_LAST_NAME_NN	C	EMPLOYEES	"LAST_NAME" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			14/05/29				
HR	EMP_EMAIL_NN	C	EMPLOYEES	"EMAIL" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			14/05/29				
HR	EMP_HIRE_DATE_NN	C	EMPLOYEES	"HIRE_DATE" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			14/05/29				
HR	EMP_JOB_NN	C	EMPLOYEES	"JOB_ID" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			14/05/29				
HR	EMP_SALARY_MIN	C	EMPLOYEES	salary > 0				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			14/05/29				
HR	EMP_EMAIL_UK	U	EMPLOYEES					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			14/05/29	HR	EMP_EMAIL_UK		
HR	EMP_EMP_ID_PK	P	EMPLOYEES					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			14/05/29	HR	EMP_EMP_ID_PK		
HR	EMP_DEPT_FK	R	EMPLOYEES		HR	DEPT_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			14/05/29				
HR	EMP_JOB_FK	R	EMPLOYEES		HR	JOB_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			14/05/29				
HR	EMP_MANAGER_FK	R	EMPLOYEES		HR	EMP_EMP_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			14/05/29				
HR	DEPT_MGR_FK	R	DEPARTMENTS		HR	EMP_EMP_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			14/05/29				
HR	JHIST_EMPLOYEE_NN	C	JOB_HISTORY	"EMPLOYEE_ID" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			14/05/29				
HR	JHIST_START_DATE_NN	C	JOB_HISTORY	"START_DATE" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			14/05/29				
HR	JHIST_END_DATE_NN	C	JOB_HISTORY	"END_DATE" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			14/05/29				
HR	JHIST_JOB_NN	C	JOB_HISTORY	"JOB_ID" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			14/05/29				
HR	JHIST_DATE_INTERVAL	C	JOB_HISTORY	end_date > start_date				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			14/05/29				
HR	JHIST_EMP_ID_ST_DATE_PK	P	JOB_HISTORY					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			14/05/29	HR	JHIST_EMP_ID_ST_DATE_PK		
HR	JHIST_JOB_FK	R	JOB_HISTORY		HR	JOB_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			14/05/29				
HR	JHIST_EMP_FK	R	JOB_HISTORY		HR	EMP_EMP_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			14/05/29				
HR	JHIST_DEPT_FK	R	JOB_HISTORY		HR	DEPT_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			14/05/29				
HR	SYS_C004102	O	EMP_DETAILS_VIEW					ENABLED	NOT DEFERRABLE	IMMEDIATE	NOT VALIDATED	GENERATED NAME			14/05/29				
HR	SYS_C007105	P	TBL_TEST1					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	GENERATED NAME			21/04/05	HR	SYS_C007105		
*/

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME='TBL_TEST1';
--==>>
/*
HR	SYS_C007105	P	TBL_TEST1					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	GENERATED NAME			21/04/05	HR	SYS_C007105		
*/


--�� ���������� ������ �÷� Ȯ��(��ȸ)

SELECT *
FROM USER_CONS_COLUMNS;
--==>>
/*
HR	REGION_ID_NN	REGIONS	REGION_ID	
HR	REG_ID_PK	REGIONS	REGION_ID	1
HR	COUNTRY_ID_NN	COUNTRIES	COUNTRY_ID	
HR	COUNTRY_C_ID_PK	COUNTRIES	COUNTRY_ID	1
HR	COUNTR_REG_FK	COUNTRIES	REGION_ID	1
HR	LOC_ID_PK	LOCATIONS	LOCATION_ID	1
HR	LOC_CITY_NN	LOCATIONS	CITY	
HR	LOC_C_ID_FK	LOCATIONS	COUNTRY_ID	1
HR	DEPT_ID_PK	DEPARTMENTS	DEPARTMENT_ID	1
HR	DEPT_NAME_NN	DEPARTMENTS	DEPARTMENT_NAME	
HR	DEPT_MGR_FK	DEPARTMENTS	MANAGER_ID	1
HR	DEPT_LOC_FK	DEPARTMENTS	LOCATION_ID	1
HR	JOB_ID_PK	JOBS	JOB_ID	1
HR	JOB_TITLE_NN	JOBS	JOB_TITLE	
HR	EMP_EMP_ID_PK	EMPLOYEES	EMPLOYEE_ID	1
HR	EMP_LAST_NAME_NN	EMPLOYEES	LAST_NAME	
HR	EMP_EMAIL_NN	EMPLOYEES	EMAIL	
HR	EMP_EMAIL_UK	EMPLOYEES	EMAIL	1
HR	EMP_HIRE_DATE_NN	EMPLOYEES	HIRE_DATE	
HR	EMP_JOB_NN	EMPLOYEES	JOB_ID	
HR	EMP_JOB_FK	EMPLOYEES	JOB_ID	1
HR	EMP_SALARY_MIN	EMPLOYEES	SALARY	
HR	EMP_MANAGER_FK	EMPLOYEES	MANAGER_ID	1
HR	EMP_DEPT_FK	EMPLOYEES	DEPARTMENT_ID	1
HR	JHIST_EMPLOYEE_NN	JOB_HISTORY	EMPLOYEE_ID	
HR	JHIST_EMP_ID_ST_DATE_PK	JOB_HISTORY	EMPLOYEE_ID	1
HR	JHIST_EMP_FK	JOB_HISTORY	EMPLOYEE_ID	1
HR	JHIST_START_DATE_NN	JOB_HISTORY	START_DATE	
HR	JHIST_DATE_INTERVAL	JOB_HISTORY	START_DATE	
HR	JHIST_EMP_ID_ST_DATE_PK	JOB_HISTORY	START_DATE	2
HR	JHIST_END_DATE_NN	JOB_HISTORY	END_DATE	
HR	JHIST_DATE_INTERVAL	JOB_HISTORY	END_DATE	
HR	JHIST_JOB_NN	JOB_HISTORY	JOB_ID	
HR	JHIST_JOB_FK	JOB_HISTORY	JOB_ID	1
HR	JHIST_DEPT_FK	JOB_HISTORY	DEPARTMENT_ID	1
HR	SYS_C007105	TBL_TEST1	COL1	1
*/

SELECT *
FROM USER_CONS_COLUMNS
WHERE TABLE_NAME='TBL_TEST1';
--==>>
/*
HR	SYS_C007105	TBL_TEST1	COL1	1
*/


--�� ���������� ������ ������, �����, ���̺��, ��������, �÷��� �׸� ��ȸ

SELECT UC.OWNER, UC.CONSTRAINT_NAME, UC.TABLE_NAME
     , UC.CONSTRAINT_TYPE, UCC.COLUMN_NAME
FROM USER_CONSTRAINTS UC, USER_CONS_COLUMNS UCC
WHERE UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME
 AND UC.TABLE_NAME = 'TBL_TEST1';
--==>>
/*
HR	SYS_C007105	TBL_TEST1	P	COL1
    -----------
  ����Ŭ�� �ڵ����� �ٿ��� ���������� �̸�
*/
  
  --�� PK ���� �ǽ�(�� �÷� ������ ����)
-- ���̺� ����
CREATE TABLE TBL_TEST2
(
    COL1 NUMBER(5)              
  , COL2 VARCHAR2(30)
  , CONSTRAINT TEST2_COL1_PK PRIMARY KEY(COL1)
);


-- ������ �Է�
INSERT INTO TBL_TEST2(COL1, COL2) VALUES(1, 'TEST');
INSERT INTO TBL_TEST2(COL1, COL2) VALUES(2, 'ABCD');
INSERT INTO TBL_TEST2(COL1, COL2) VALUES(3, NULL);
INSERT INTO TBL_TEST2(COL1) VALUES(4); -- ���� ���� ����
INSERT INTO TBL_TEST2(COL1, COL2) VALUES(2, 'ABCD');    --> �����߻� : ORA-00001: unique constraint (HR.SYS_C007105) violated
INSERT INTO TBL_TEST2(COL1, COL2) VALUES(2, 'KKKK');    --> �����߻� 
INSERT INTO TBL_TEST2(COL1, COL2) VALUES(5, 'ABCD'); 
INSERT INTO TBL_TEST2(COL1, COL2) VALUES(NULL, NULL);   --> �����߻� 
INSERT INTO TBL_TEST2(COL1, COL2) VALUES(NULL, 'STUDY');    --> �����߻� 
INSERT INTO TBL_TEST2(COL2) VALUES('STUDY');    --> �����߻� 


-- Ŀ��
COMMIT;

SELECT *
FROM TBL_TEST2;
--==>>
/*
1	TEST
2	ABCD
3	
4	
5	ABCD
*/

--�� ���������� ������ ������, �����, ���̺��, ��������, �÷��� �׸� ��ȸ
SELECT UC.OWNER, UC.CONSTRAINT_NAME, UC.TABLE_NAME
     , UC.CONSTRAINT_TYPE, UCC.COLUMN_NAME
FROM USER_CONSTRAINTS UC, USER_CONS_COLUMNS UCC
WHERE UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME
 AND UC.TABLE_NAME = 'TBL_TEST2';
--==>>
/*
HR	TEST2_COL1_PK	TBL_TEST2	P	COL1
*/


--�� PK ���� �ǽ�(�� ���� �÷� PK ���� �� ���� �����̸Ӹ� Ű)
CREATE TABLE TBL_TEST3
( COL1 NUMBER(5)
, COL2 VARCHAR(30)
, CONSTRAINT TEST3_COL1_COL2_PK PRIMARY KEY(COL1, COL2)
);
--==>> Table TBL_TEST3��(��) �����Ǿ����ϴ�.

/*
--(X)
CREATE TABLE TBL_TEST3
( COL1 NUMBER(5)
, COL2 VARCHAR(30)
, CONSTRAINT TEST3_COL1_PK PRIMARY KEY(COL1)
, CONSTRAINT TEST3_COL1_PK PRIMARY KEY(COL2)    -- �ȵ�!! �����̸Ӹ� Ű �� �� ����� ��~!
);
*/


-- ������ �Է�
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(1, 'TEST');
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(2, 'ABCD');
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(3, NULL);      --> �����߻� 
INSERT INTO TBL_TEST3(COL1) VALUES(4);                  --> �����߻� 
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(2, 'ABCD');    --> �����߻� : ORA-00001: unique constraint (HR.SYS_C007105) violated
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(3, 'ABCD');    --> �ȴ�!!! �÷� �� �� ���ļ� �ϳ��� ������ ��(2)�� �̰��� �ٸ���!!!
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(1, 'ABCD');    --> �ȴ�
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(2, 'KKKK');    
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(5, 'ABCD'); 
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(NULL, NULL);  
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(NULL, 'STUDY');    
INSERT INTO TBL_TEST3(COL2) VALUES('STUDY');     


--Ŀ��
COMMIT;

SELECT *
FROM TBL_TEST3;
--==>>
/*
1	ABCD
1	TEST
2	ABCD
2	KKKK
3	ABCD
5	ABCD
*/

--�� PK ���� �ǽ�(�� ���̺� ���� ���� �������� �߰� �� PK ����)
CREATE TABLE TBL_TEST4
( COL1 NUMBER(5)
, COL2 VARCHAR(30)
);
--==>> Table TBL_TEST4��(��) �����Ǿ����ϴ�.

-- �� �̹� ������� �ִ� ���̺�
--    �ο��Ϸ��� ���������� ������ �����Ͱ� ���ԵǾ� ���� ���
--    �ش� ���̺� ���������� �߰��ϴ� ���� �Ұ����ϴ�.


-- �������� �߰�
ALTER TABLE TBL_TEST4
ADD CONSTRAINT TEST4_COL1_PK PRIMARY KEY(COL1);
-- ���̺� ������ �������� �����ؼ� ���ϴ��� �ϼ���~ �÷����� ����~
--==>> Table TBL_TEST4��(��) ����Ǿ����ϴ�.


--�� �������� Ȯ�ο� ���� ��(VIEW) ����
CREATE OR REPLACE VIEW VIEW_CONSTCHECK
AS
SELECT UC.OWNER "OWNER"
     , UC.CONSTRAINT_NAME "CONSTRAINT_NAME"
     , UC.TABLE_NAME "TABLE_NAME"
     , UC.CONSTRAINT_TYPE "CONSTRAINT_TYPE"
     , UC.SEARCH_CONDITION "SEARCH_CONDITION"
     , UC.DELETE_RULE "DELETE_RULE"
FROM USER_CONSTRAINTS UC JOIN USER_CONS_COLUMNS UCC
ON UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME;
--==>> View VIEW_CONSTCHECK��(��) �����Ǿ����ϴ�.

--�� ������ ��(VIEW)�� ���� �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST4';
--==>>
/*
HR	TEST4_COL1_PK	TBL_TEST4	P		
*/


-------------------------------------------------------------------------------------------------------

--���� UNIQUE(UK:U) ����--

-- 1. ���̺��� ������ �÷��� �����Ͱ� �ߺ����� �ʰ�
--    ���̺� ������ ������ �� �ֵ��� �����ϴ� ��������.
--    PRIMARY KEY �� ������ ��������������, NULL �� ����Ѵٴ� ���̰� �ִ�.
--    ���������� PRIMARY KEY �� ���������� UNIQUE INDEX �� �ڵ� �����ȴ�.
--    �ϳ��� ���̺� ������ UNIQUE ���������� ���� �� �����ϴ� ���� �����ϴ�.
--    ��, �ϳ��� ���̺� UNIQUE ���������� ���� �� ����� ���� 
--    �����ϴٴ� ���̴�.



-- 2. ���� �� ����
-- �� �÷� ������ ����
-- �÷��� ������Ÿ�� [CONSTRAINT CONSTRAINT��] UNIQUE

-- �� ���̺� ������ ����
-- �÷��� ������Ÿ��,
-- �÷��� ������Ÿ��,
-- CONSTRAINT CONSTRAINT�� UNIQUE(�÷���[, ...])

--�� UK ���� �ǽ�(�� �÷� ������ ����)
--   ���̺� ����
CREATE TABLE TBL_TEST5
( COL1 NUMBER(5)    PRIMARY KEY
, COL2 VARCHAR2(30) UNIQUE
);
--==>> Table TBL_TEST5��(��) �����Ǿ����ϴ�.



-- �������� ��ȸ
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME='TBL_TEST5';
--==>>
/*
HR	SYS_C007109	TBL_TEST5	P	   COL1	
HR	SYS_C007110	TBL_TEST5	U	   COL2	
*/

-- ������ �Է�
INSERT INTO TBL_TEST5(COL1, COL2) VALUES(1, 'TEST');
INSERT INTO TBL_TEST5(COL1, COL2) VALUES(2, 'ABCD');
INSERT INTO TBL_TEST5(COL1, COL2) VALUES(3, NULL);    
INSERT INTO TBL_TEST5(COL1) VALUES(4);               
INSERT INTO TBL_TEST5(COL1, COL2) VALUES(5, 'ABCD');    --> ���� �߻�.. �� ��° �÷� ����...
INSERT INTO TBL_TEST5(COL1, COL2) VALUES(5, NULL);   
INSERT INTO TBL_TEST5(COL1, COL2) VALUES(6, NULL);      --> NULL�� ���������� �������� �ʴ´�. ������ ���̶�� �� NULL�� ���ְ� �� ��....

SELECT *
FROM TBL_TEST5;

--Ŀ��
COMMIT;


--�� UK ���� �ǽ�(�� ���̺� ������ ����)
-- ���̺� ����
CREATE TABLE TBL_TEST6
( COL1 NUMBER(5)
, COL2 VARCHAR2(30)
, CONSTRAINT TEST6_COL1_PK PRIMARY KEY(COL1)
, CONSTRAINT TEST6_COL2_UK UNIQUE(COL2)
);
--==>> Table TBL_TEST6��(��) �����Ǿ����ϴ�.


-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME='TBL_TEST6';
--==>>
/*
HR	TEST6_COL1_PK	TBL_TEST6	P	COL1	
HR	TEST6_COL2_UK	TBL_TEST6	U	COL2	
*/


-- �÷� �����δ� �������� �̸� ���� ���ϴϱ� Ȯ���� �����
-- ���̺� ������ �ϱ�~!

--�� UK ���� �ǽ�(�� ���̺� ���� ���� �������� �߰� �� UK �������� �߰�)
-- ���̺� ����
CREATE TABLE TBL_TEST7
( COL1 NUMBER(5)
, COL2 VARCHAR2(30)
);
--==>> Table TBL_TEST7��(��) �����Ǿ����ϴ�.


-- �������� Ȯ��(��ȸ)
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME='TBL_TEST7';
--==>> ��ȸ ��� ����


-- ���� ���� �߰�
ALTER TABLE TBL_TEST7
ADD ( CONSTRAINT TEST7_COL1_PK PRIMARY KEY(COL1)
    , CONSTRAINT TEST7_COL2_UK UNIQUE(COL2) );
--==>> Table TBL_TEST7��(��) ����Ǿ����ϴ�.


-- �������� Ȯ��(��ȸ)
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME='TBL_TEST7';
--==>>
/*
HR	TEST7_COL1_PK	TBL_TEST7	P		COL1
HR	TEST7_COL2_UK	TBL_TEST7	U		COL2
*/