drop table buy;
DROP TABLE payment CASCADE CONSTRAINTS;

/**********************************/
/* Table Name: 결제 */
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

COMMENT ON TABLE payment is '결제';
COMMENT ON COLUMN payment.pay_no is '결제번호';
COMMENT ON COLUMN payment.pay_amount is '결제금액';
COMMENT ON COLUMN payment.pay_way is '결제수단';
COMMENT ON COLUMN payment.pay_date is '결제일';
COMMENT ON COLUMN payment.pay_memo is '결제메모';
COMMENT ON COLUMN payment.ship_no is '배송번호';
COMMENT ON COLUMN payment.mem_no is '회원번호';

-- ALTER TABLE payment RENAME COLUMN payment_no TO pay_no;

SELECT pay_no, pay_amount, pay_way, pay_date, pay_memo, ship_no, mem_no FROM payment;

DELETE FROM payment;

------------------------------------------------------------------------------------------------------------------------------------------------------
1) 거래 한 건 최초 등록
------------------------------------------------------------------------------------------------------------------------------------------------------

-- 등록하면서 ship_no(PK)로 shipping테이블을 참조해서 shipping 테이블의 pr_no(PK)로 product테이블에 있는 pr_price(판매가격)을 등록
INSERT INTO payment(pay_no, 
                    pay_amount, 
                    pay_way, pay_date, pay_memo, ship_no, mem_no)
VALUES ((SELECT nvl(MAX(pay_no), 0) + 1 as pay_no FROM payment),
        (select pr_price from product where pr_no = (select pr_no from shipping where ship_no = 1)),
                    '신용카드', SYSDATE, '메모메모메모메모',                                    1, 2);

INSERT INTO payment(pay_no, 
                    pay_amount, 
                    pay_way, pay_date, pay_memo, ship_no, mem_no)
VALUES ((SELECT nvl(MAX(pay_no), 0) + 1 as pay_no FROM payment),
        (select pr_price from product where pr_no = (select pr_no from shipping where ship_no = 1)),
                    '신용카드', SYSDATE, '메모메모메모메모',                                    1, 2);


------------------------------------------------------------------------------------------------------------------------------------------------------
2) 목록
------------------------------------------------------------------------------------------------------------------------------------------------------

-- 전체 결제 목록
SELECT pay_no, pay_amount, pay_way, pay_date, pay_memo, ship_no, mem_no 
FROM payment;

-- mem_no=2인 회원의 결제 목록
SELECT pay_no, pay_amount, pay_way, pay_date, pay_memo, ship_no, mem_no 
FROM payment
WHERE mem_no=2;

------------------------------------------------------------------------------------------------------------------------------------------------------
3) 수정
------------------------------------------------------------------------------------------------------------------------------------------------------

-- 메모 수정
UPDATE payment
SET pay_memo = '메모수정메모수정'
WHERE pay_no = 1;

SELECT pay_no, pay_amount, pay_way, pay_date, pay_memo, ship_no, mem_no 
FROM payment;


------------------------------------------------------------------------------------------------------------------------------------------------------
4) 삭제
------------------------------------------------------------------------------------------------------------------------------------------------------

DELETE FROM payment;


DELETE FROM payment WHERE pay_no = 1;

------------------------------------------------------------------------------------------------------------------------------------------------------
5) 검색
------------------------------------------------------------------------------------------------------------------------------------------------------


------------------------------------------------------------------------------------------------------------------------------------------------------
6) 레코드 갯수
------------------------------------------------------------------------------------------------------------------------------------------------------


------------------------------------------------------------------------------------------------------------------------------------------------------
7) 페이징
------------------------------------------------------------------------------------------------------------------------------------------------------




------------------------------------------------------------------------------------------------------------------------------------------------------




