/**********************************/
/* Table Name: 구매상품 결제 */
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

COMMENT ON TABLE payment is '구매상품 결제';
COMMENT ON COLUMN payment.payment_no is '결제번호';
COMMENT ON COLUMN payment.pay_way is '결제수단';
COMMENT ON COLUMN payment.pay_amount is '결제금액';
COMMENT ON COLUMN payment.pay_check is '결제확인';
COMMENT ON COLUMN payment.pay_date is '결제날짜';
COMMENT ON COLUMN payment.mileage_no is '마일리지번호';