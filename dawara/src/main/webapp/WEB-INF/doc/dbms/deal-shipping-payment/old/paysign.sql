/**********************************/
/* Table Name: �������� */
/**********************************/
CREATE TABLE paysign(
    signno                            NUMBER(10)     NOT NULL    PRIMARY KEY,
    paysign                           CHAR(1)    DEFAULT 'N'     NOT NULL,
    sellersign                        VARCHAR2(20)     NOT NULL,
    buysign                           VARCHAR2(20)     NOT NULL,
    signdate                          DATE     NOT NULL
);

COMMENT ON TABLE paysign is '��������';
COMMENT ON COLUMN paysign.signno is '�����ȣ';
COMMENT ON COLUMN paysign.paysign is '�������ǿ���';
COMMENT ON COLUMN paysign.sellersign is '�Ǹ��ڼ���';
COMMENT ON COLUMN paysign.buysign is '�����ڼ���';
COMMENT ON COLUMN paysign.signdate is '����¥';


0. ���̺� ���

DROP TABLE payment;

select signno, paysign, sellersign, buysign, signdate

-------------------------------------------------------------------------------------
1. ���

INSERT INTO payment(paymentno, sellno, memberno, paysort, howmuch, pdate, pname, paycheck)
VALUES ((SELECT NVL(MAX(paymentno), 0)+1 as paymentno FROM payment), 1, 1,
        '�ſ�ī��', 99000, SYSDATE, '��â��', 'Y');

INSERT INTO payment(paymentno, sellno, memberno, paysort, howmuch, pdate, pname, paycheck)
VALUES ((SELECT NVL(MAX(paymentno), 0)+1 as paymentno FROM payment), 1, 1,
        '������ü', 130000, SYSDATE-2, '��â��', 'N');

INSERT INTO payment(paymentno, sellno, memberno, paysort, howmuch, pdate, pname, paycheck)
VALUES ((SELECT NVL(MAX(paymentno), 0)+1 as paymentno FROM payment), 1, 1,
        '�������Ա�', 210000, SYSDATE-1, '��â��', 'Y');

-------------------------------------------------------------------------------------

2. ���
- �˻��� ���� �ʴ� ���, ��ü ��� ���
 
SELECT paymentno, sellno, memberno, paysort, howmuch, pdate, pname, paycheck
FROM payment
ORDER BY paymentno ASC;
 
 PAYMENTNO MEMBERNO PAYSORT     HOWMUCH  PDATE                 PNAME  PAYCHECK
 --------- -------- ----------- -------- --------------------- ------ --------
         1        1 �ſ�ī��      99000  2018-06-08 17:22:00.0 ��â��   Y
         2        1 ������ü     130000  2018-06-06 17:22:34.0 ��â��   N
         3        1 �������Ա�   210000  2018-06-07 17:22:35.0 ��â��   Y
 
   
3. ��ȸ
 
1) ȸ����ȣ�� '1'�� ȸ���� '�ſ�ī��'�� ������ �������� ��ȸ
SELECT paymentno, sellno, memberno, paysort, howmuch, pdate, pname, paycheck
FROM payment
WHERE memberno = 1 AND paysort = '�ſ�ī��';
 
 PAYMENTNO MEMBERNO PAYSORT HOWMUCH PDATE                 PNAME PAYCHECK
 --------- -------- ------- ------- --------------------- ----- --------
         1        1 �ſ�ī��  99000 2018-06-08 17:22:00.0 ��â��   Y
 
2) ȸ����ȣ�� '1'�� ȸ���� �������� ��ȸ         
         
SELECT paymentno, sellno, memberno, paysort, howmuch, pdate, pname, paycheck
FROM payment
WHERE memberno = 1;
 
 PAYMENTNO MEMBERNO PAYSORT    HOWMUCH PDATE                 PNAME PAYCHECK
 --------- -------- ---------- ------- --------------------- ----- --------
         1        1 �ſ�ī��    99000 2018-06-08 17:22:00.0 ��â��   Y
         2        1 ������ü   130000 2018-06-06 17:22:34.0 ��â��   N
         3        1 �������Ա� 210000 2018-06-07 17:22:35.0 ��â��   Y
 
   
4. ����

1) ȸ����ȣ�� '1'�� ȸ���� ������ȣ�� '1'�� ������ �������ο��θ� 'Y'�� ����

UPDATE payment 
SET paycheck = 'Y'
WHERE memberno = 1 AND paymentno= 1;
 
2) ȸ����ȣ�� '1'�� ȸ���� ������ȣ�� '1'�� ������ �޸� ����

UPDATE payment 
SET pmemo = '���� ���� ����'
WHERE memberno = 1 AND paymentno= 1;
 
 
5. ����

1) ��� �������� ����
DELETE FROM payment;
 
2) ȸ����ȣ�� '1'�� ȸ���� �������� ����
DELETE FROM payment
WHERE memberno = 1;
 
 
-------------------------------------------------------------------------------------