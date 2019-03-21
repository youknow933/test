/**********************************/
/* Table Name: ���Ż�ǰ ���� */
/**********************************/
CREATE TABLE payment(
    payment_no                        NUMBER(10)     NOT NULL    PRIMARY KEY,
    pay_way                           VARCHAR2(20)     NOT NULL,
    pay_amount                        NUMBER(10)     NOT NULL,
    pay_check                         CHAR(1)    DEFAULT 'N'     NOT NULL,
    pay_date                          DATE     NOT NULL,
    mileage_no                        NUMBER(10)     NULL ,
  FOREIGN KEY (mileage_no) REFERENCES mlieage (mileage_no),
  FOREIGN KEY () REFERENCES deal ()
);

COMMENT ON TABLE payment is '���Ż�ǰ ����';
COMMENT ON COLUMN payment.payment_no is '������ȣ';
COMMENT ON COLUMN payment.pay_way is '��������';
COMMENT ON COLUMN payment.pay_amount is '�����ݾ�';
COMMENT ON COLUMN payment.pay_check is '����Ȯ��';
COMMENT ON COLUMN payment.pay_date is '������¥';
COMMENT ON COLUMN payment.mileage_no is '���ϸ�����ȣ';