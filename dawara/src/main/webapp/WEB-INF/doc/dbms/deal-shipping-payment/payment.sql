drop table buy;
DROP TABLE payment CASCADE CONSTRAINTS;

/**********************************/
/* Table Name: ���� */
/**********************************/
CREATE TABLE payment(
    pay_no                        NUMBER(10)     NOT NULL    PRIMARY KEY,
    pay_amount                        NUMBER(10)     NOT NULL,
    pay_way                           VARCHAR2(30)   NOT NULL,
    pay_date                          DATE           NOT NULL,
    pay_memo                          VARCHAR2(100)    NULL ,
    ship_no                           NUMBER(10)     NOT NULL,
    mem_no                           NUMBER(6)     NOT NULL,
  FOREIGN KEY (ship_no) REFERENCES shipping (ship_no),
  FOREIGN KEY (MEM_NO) REFERENCES member (MEM_NO)
);

COMMENT ON TABLE payment is '����';
COMMENT ON COLUMN payment.pay_no is '������ȣ';
COMMENT ON COLUMN payment.pay_amount is '�����ݾ�';
COMMENT ON COLUMN payment.pay_way is '��������';
COMMENT ON COLUMN payment.pay_date is '������';
COMMENT ON COLUMN payment.pay_memo is '�����޸�';
COMMENT ON COLUMN payment.ship_no is '��۹�ȣ';
COMMENT ON COLUMN payment.mem_no is 'ȸ����ȣ';

-- ALTER TABLE payment RENAME COLUMN payment_no TO pay_no;

SELECT pay_no, pay_amount, pay_way, pay_date, pay_memo, ship_no, mem_no FROM payment;

DELETE FROM payment;

------------------------------------------------------------------------------------------------------------------------------------------------------
1) �ŷ� �� �� ���� ���
------------------------------------------------------------------------------------------------------------------------------------------------------

-- ����ϸ鼭 ship_no(PK)�� shipping���̺��� �����ؼ� shipping ���̺��� pr_no(PK)�� product���̺� �ִ� pr_price(�ǸŰ���)�� ���
INSERT INTO payment(pay_no, 
                    pay_amount, 
                    pay_way, pay_date, pay_memo, ship_no, mem_no)
VALUES ((SELECT nvl(MAX(pay_no), 0) + 1 as pay_no FROM payment),
        (select pr_price from product where pr_no = (select pr_no from shipping where ship_no = 1)),
                    '�ſ�ī��', SYSDATE, '�޸�޸�޸�޸�',                                    1, 2);

INSERT INTO payment(pay_no, 
                    pay_amount, 
                    pay_way, pay_date, pay_memo, ship_no, mem_no)
VALUES ((SELECT nvl(MAX(pay_no), 0) + 1 as pay_no FROM payment),
        (select pr_price from product where pr_no = (select pr_no from shipping where ship_no = 1)),
                    '�ſ�ī��', SYSDATE, '�޸�޸�޸�޸�',                                    1, 2);


------------------------------------------------------------------------------------------------------------------------------------------------------
2) ���
------------------------------------------------------------------------------------------------------------------------------------------------------

-- ��ü ���� ���
SELECT pay_no, pay_amount, pay_way, pay_date, pay_memo, ship_no, mem_no 
FROM payment;

-- mem_no=2�� ȸ���� ���� ���
SELECT pay_no, pay_amount, pay_way, pay_date, pay_memo, ship_no, mem_no 
FROM payment
WHERE mem_no=2;

------------------------------------------------------------------------------------------------------------------------------------------------------
3) ����
------------------------------------------------------------------------------------------------------------------------------------------------------

-- �޸� ����
UPDATE payment
SET pay_memo = '�޸�����޸����'
WHERE pay_no = 1;

SELECT pay_no, pay_amount, pay_way, pay_date, pay_memo, ship_no, mem_no 
FROM payment;


------------------------------------------------------------------------------------------------------------------------------------------------------
4) ����
------------------------------------------------------------------------------------------------------------------------------------------------------

DELETE FROM payment;


DELETE FROM payment WHERE pay_no = 1;

------------------------------------------------------------------------------------------------------------------------------------------------------
5) �˻�
------------------------------------------------------------------------------------------------------------------------------------------------------


------------------------------------------------------------------------------------------------------------------------------------------------------
6) ���ڵ� ����
------------------------------------------------------------------------------------------------------------------------------------------------------


------------------------------------------------------------------------------------------------------------------------------------------------------
7) ����¡
------------------------------------------------------------------------------------------------------------------------------------------------------




------------------------------------------------------------------------------------------------------------------------------------------------------




