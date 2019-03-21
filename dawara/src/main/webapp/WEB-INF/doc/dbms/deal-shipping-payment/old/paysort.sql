/**********************************/
/* Table Name: �������� */
/**********************************/
CREATE TABLE paysort(
    paysortno                         NUMBER(2)    NOT NULL    PRIMARY KEY,
    psortname                         VARCHAR2(20)     NOT NULL,
    paymentno                         NUMBER(10)     NULL ,
  FOREIGN KEY (paymentno) REFERENCES paysort (paymentno)
);

COMMENT ON TABLE paysort is '��������';
COMMENT ON COLUMN paysort.paysortno is '�������ܹ�ȣ';
COMMENT ON COLUMN paysort.psortname is '�������ܸ�';
COMMENT ON COLUMN paysort.paymentno is '������ȣ';

0. ���̺� ���

DROP TABLE paysort;

select paysortno, psortname, paymentno
from paysort

-------------------------------------------------------------------------------------
1. ���

INSERT INTO paysort(paysortno, psortname, paymentno)
VALUES ((SELECT NVL(MAX(paymentno), 0)+1 as paymentno FROM paysort), 1, 1,
        '�ſ�ī��', 99000, SYSDATE, '��â��', 'Y');

INSERT INTO paysort(paymentno, sellno, memberno, paysort, howmuch, pdate, pname, paycheck)
VALUES ((SELECT NVL(MAX(paymentno), 0)+1 as paymentno FROM paysort), 1, 1,
        '������ü', 130000, SYSDATE-2, '��â��', 'N');

INSERT INTO paysort(paymentno, sellno, memberno, paysort, howmuch, pdate, pname, paycheck)
VALUES ((SELECT NVL(MAX(paymentno), 0)+1 as paymentno FROM paysort), 1, 1,
        '�������Ա�', 210000, SYSDATE-1, '��â��', 'Y');

-------------------------------------------------------------------------------------

2. ���
- �˻��� ���� �ʴ� ���, ��ü ��� ���
 
SELECT paymentno, sellno, memberno, paysort, howmuch, pdate, pname, paycheck
FROM paysort
ORDER BY paymentno ASC;
 
 PAYMENTNO MEMBERNO PAYSORT     HOWMUCH  PDATE                 PNAME  PAYCHECK
 --------- -------- ----------- -------- --------------------- ------ --------
         1        1 �ſ�ī��      99000  2018-06-08 17:22:00.0 ��â��   Y
         2        1 ������ü     130000  2018-06-06 17:22:34.0 ��â��   N
         3        1 �������Ա�   210000  2018-06-07 17:22:35.0 ��â��   Y
 
   
3. ��ȸ
 
1) ȸ����ȣ�� '1'�� ȸ���� '�ſ�ī��'�� ������ �������� ��ȸ
SELECT paymentno, sellno, memberno, paysort, howmuch, pdate, pname, paycheck
FROM paysort
WHERE memberno = 1 AND paysort = '�ſ�ī��';
 
 PAYMENTNO MEMBERNO PAYSORT HOWMUCH PDATE                 PNAME PAYCHECK
 --------- -------- ------- ------- --------------------- ----- --------
         1        1 �ſ�ī��  99000 2018-06-08 17:22:00.0 ��â��   Y
 
2) ȸ����ȣ�� '1'�� ȸ���� �������� ��ȸ         
         
SELECT paymentno, sellno, memberno, paysort, howmuch, pdate, pname, paycheck
FROM paysort
WHERE memberno = 1;
 
 PAYMENTNO MEMBERNO PAYSORT    HOWMUCH PDATE                 PNAME PAYCHECK
 --------- -------- ---------- ------- --------------------- ----- --------
         1        1 �ſ�ī��    99000 2018-06-08 17:22:00.0 ��â��   Y
         2        1 ������ü   130000 2018-06-06 17:22:34.0 ��â��   N
         3        1 �������Ա� 210000 2018-06-07 17:22:35.0 ��â��   Y
 
   
4. ����

1) ȸ����ȣ�� '1'�� ȸ���� ������ȣ�� '1'�� ������ �������ο��θ� 'Y'�� ����

UPDATE paysort 
SET paycheck = 'Y'
WHERE memberno = 1 AND paymentno= 1;
 
2) ȸ����ȣ�� '1'�� ȸ���� ������ȣ�� '1'�� ������ �޸� ����

UPDATE paysort 
SET pmemo = '���� ���� ����'
WHERE memberno = 1 AND paymentno= 1;
 
 
5. ����

1) ��� �������� ����
DELETE FROM paysort;
 
2) ȸ����ȣ�� '1'�� ȸ���� �������� ����
DELETE FROM paysort
WHERE memberno = 1;
 
 
-------------------------------------------------------------------------------------