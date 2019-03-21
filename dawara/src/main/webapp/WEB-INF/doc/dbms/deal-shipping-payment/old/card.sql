/**********************************/
/* Table Name: ī�� */
/**********************************/
CREATE TABLE card(
    cardidno                          NUMBER(10)     NOT NULL    PRIMARY KEY,
    cardcompany                       VARCHAR2(20)     NOT NULL,
    cardnumber                        NUMBER(16)     NOT NULL,
    expires                           NUMBER(6)    NOT NULL,
    dealsortno                        NUMBER(2)    NULL ,
  FOREIGN KEY (dealsortno) REFERENCES dealsort (dealsortno)
);

COMMENT ON TABLE card is 'ī��';
COMMENT ON COLUMN card.cardidno is 'ī�屸�й�ȣ';
COMMENT ON COLUMN card.cardcompany is 'ī���';
COMMENT ON COLUMN card.cardnumber is 'ī���ȣ';
COMMENT ON COLUMN card.expires is 'ī�常����';
COMMENT ON COLUMN card.dealsortno is '�ŷ����ܹ�ȣ';


0. ���̺� ���

DROP TABLE card;

select cardidno, cardcompany, cardnumber, expires, dealsortno
from card;

-------------------------------------------------------------------------------------
1. ���

INSERT INTO card(cardidno, cardnumber, cardcompany, expires, dealsortno)
VALUES ((SELECT nvl(MAX(cardidno), 0) + 1 as cardidno FROM card), 
                           1111222211112222, '��������', 062022, 1);

INSERT INTO card(cardidno, cardnumber, cardcompany, expires, dealsortno)
VALUES ((SELECT nvl(MAX(cardidno), 0) + 1 as cardidno FROM card), 
                           2000313102026666, '�츮����', 062022, 2);

INSERT INTO card(cardidno, cardnumber, cardcompany, expires, dealsortno)
VALUES ((SELECT nvl(MAX(cardidno), 0) + 1 as cardidno FROM card), 
                           6060100182829595, '��������', 062022, 3);


-------------------------------------------------------------------------------------

2. ���
- �˻��� ���� �ʴ� ���, ��ü ��� ���
 
SELECT cardnumber, bname, cardsort, owner, expires, memo, paysortno
FROM card
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