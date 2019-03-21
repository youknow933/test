/**********************************/
/* Table Name: �� ī�� */
/**********************************/
CREATE TABLE mycard(
    cardidno                          NUMBER(10)     NOT NULL    PRIMARY KEY,
    addcarddate                       DATE     NOT NULL,
    mem_no                            NUMBER(6)    NOT NULL,
  FOREIGN KEY (mem_no) REFERENCES mywallet (mem_no),
  FOREIGN KEY (cardidno) REFERENCES card (cardidno)
);

COMMENT ON TABLE mycard is '�� ī��';
COMMENT ON COLUMN mycard.cardidno is 'ī�屸�й�ȣ';
COMMENT ON COLUMN mycard.addcarddate is 'ī������';
COMMENT ON COLUMN mycard.mem_no is 'ȸ����ȣ';


0. ���̺� ���

DROP TABLE mycard;

select cardidno, cardsort, cardnumber, cardcompany, expires, mem_no
from mycard;

-------------------------------------------------------------------------------------
1. ���

INSERT INTO mycard(cardidno, cardsort, cardnumber, cardcompany, expires, mem_no)
VALUES ((SELECT nvl(MAX(cardidno), 0) + 1 as cardidno FROM categrp), 
                            '�ſ�ī��', 1111222211112222, '��������', 062022, 1);

INSERT INTO mycard(cardidno, cardnumber, cardcompany, expires, mywalletno)
VALUES (2000313102026666, '�츮����', 'üũī��', '��â��', 072021, '�ϻ��', 11);

INSERT INTO mycard(cardidno, cardnumber, cardcompany, expires, mywalletno)
VALUES (6060100182829595, '��������', '�ſ�ī��', '��â��', 112020, '�ڵ���ü����', 11);


-------------------------------------------------------------------------------------

2. ���
- �˻��� ���� �ʴ� ���, ��ü ��� ���
 
SELECT cardnumber, bname, cardsort, owner, expires, memo, paysortno
FROM mycard
ORDER BY expires DESC;
 
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
 
 
----------------------------------------------------------------------------