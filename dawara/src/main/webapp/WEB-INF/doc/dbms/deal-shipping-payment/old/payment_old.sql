0. ���̺� ���

DROP TABLE payment;

�Ǹ� ���̺�
CREATE TABLE sell (
    SELLNO                         NUMBER(7)     NOT NULL,
    
  PRIMARY KEY (SELLNO)
);
    
ȸ�� ���̺�
CREATE TABLE p_member (
    mem_no                         NUMBER(6)     NOT NULL,
    
  PRIMARY KEY (mem_no)
);

/**********************************/
/* Table Name: �������� */
/**********************************/
CREATE TABLE PAYMENT(
    PAYMENTNO                         NUMBER(10)    NOT NULL,
    SELLNO                            NUMBER(7)     NOT NULL,
    mem_no                            NUMBER(6)     NOT NULL, 
    PAYSORT                           VARCHAR2(20)  NOT NULL,
    HOWMUCH                           NUMBER(15)    NOT NULL,
    PDATE                             DATE          NOT NULL,
    PNAME                             VARCHAR2(20)  NOT NULL,
    PAYCHECK                          CHAR(1)       NOT NULL,
    PMEMO                             VARCHAR2(50)  NULL,
    
  PRIMARY KEY (paymentno) ,
  FOREIGN KEY (sellno) REFERENCES sell (sellno),
  FOREIGN KEY (mem_no) REFERENCES p_member (mem_no)
);

COMMENT ON TABLE payment is '��������';
COMMENT ON COLUMN payment.paymentno is '������ȣ';
COMMENT ON COLUMN payment.sellno is '�ǸŹ�ȣ'; -- sell ����
COMMENT ON COLUMN payment.mem_no is 'ȸ����ȣ'; -- p_member ����
COMMENT ON COLUMN payment.paysort is '��������';
COMMENT ON COLUMN payment.howmuch is '�����ݾ�';
COMMENT ON COLUMN payment.pdate is '������¥';
COMMENT ON COLUMN payment.pname is '������ ���';
COMMENT ON COLUMN payment.paycheck is '�������ο���';
COMMENT ON COLUMN payment.pmemo is '������ ���� �޸�';


ALTER TABLE payment ADD CONSTRAINT IDX_payment_PK PRIMARY KEY (paymentno);

0. ���̺� ���

DROP TABLE payment;

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