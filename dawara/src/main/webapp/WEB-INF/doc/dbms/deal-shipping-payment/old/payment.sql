
/**********************************/
/* Table Name: 결제 */
/**********************************/
CREATE TABLE payment(
    paymentno                         NUMBER(10)     NOT NULL    PRIMARY KEY,
    paysortno                         NUMBER(2)    NULL ,
    mem_no                            NUMBER(6)    NULL ,
    signno                            NUMBER(10)     NULL ,
    dealno                            NUMBER(10)     NULL ,
  FOREIGN KEY (dealno) REFERENCES deal (dealno),
  FOREIGN KEY (signno) REFERENCES paysign (signno),
  FOREIGN KEY (mem_no) REFERENCES member (mem_no)
);

COMMENT ON TABLE payment is '결제';
COMMENT ON COLUMN payment.paymentno is '결제번호';
COMMENT ON COLUMN payment.paysortno is '결제수단번호';
COMMENT ON COLUMN payment.mem_no is '회원번호';
COMMENT ON COLUMN payment.signno is '서명번호';
COMMENT ON COLUMN payment.dealno is '거래번호';


ALTER TABLE payment ADD CONSTRAINT IDX_payment_PK PRIMARY KEY (paymentno);

0. 테이블 드롭

DROP TABLE payment;

-------------------------------------------------------------------------------------
1. 등록

INSERT INTO payment(paymentno, sellno, memberno, paysort, howmuch, pdate, pname, paycheck)
VALUES ((SELECT NVL(MAX(paymentno), 0)+1 as paymentno FROM payment), 1, 1,
        '신용카드', 99000, SYSDATE, '송창현', 'Y');

INSERT INTO payment(paymentno, sellno, memberno, paysort, howmuch, pdate, pname, paycheck)
VALUES ((SELECT NVL(MAX(paymentno), 0)+1 as paymentno FROM payment), 1, 1,
        '계좌이체', 130000, SYSDATE-2, '송창현', 'N');

INSERT INTO payment(paymentno, sellno, memberno, paysort, howmuch, pdate, pname, paycheck)
VALUES ((SELECT NVL(MAX(paymentno), 0)+1 as paymentno FROM payment), 1, 1,
        '무통장입금', 210000, SYSDATE-1, '송창현', 'Y');

-------------------------------------------------------------------------------------

2. 목록
- 검색을 하지 않는 경우, 전체 목록 출력
 
SELECT paymentno, sellno, memberno, paysort, howmuch, pdate, pname, paycheck
FROM payment
ORDER BY paymentno ASC;
 
 PAYMENTNO MEMBERNO PAYSORT     HOWMUCH  PDATE                 PNAME  PAYCHECK
 --------- -------- ----------- -------- --------------------- ------ --------
         1        1 신용카드      99000  2018-06-08 17:22:00.0 송창현   Y
         2        1 계좌이체     130000  2018-06-06 17:22:34.0 송창현   N
         3        1 무통장입금   210000  2018-06-07 17:22:35.0 송창현   Y
 
   
3. 조회
 
1) 회원번호가 '1'인 회원가 '신용카드'로 결제한 결제내역 조회
SELECT paymentno, sellno, memberno, paysort, howmuch, pdate, pname, paycheck
FROM payment
WHERE memberno = 1 AND paysort = '신용카드';
 
 PAYMENTNO MEMBERNO PAYSORT HOWMUCH PDATE                 PNAME PAYCHECK
 --------- -------- ------- ------- --------------------- ----- --------
         1        1 신용카드  99000 2018-06-08 17:22:00.0 송창현   Y
 
2) 회원번호가 '1'인 회원의 결제내역 조회         
         
SELECT paymentno, sellno, memberno, paysort, howmuch, pdate, pname, paycheck
FROM payment
WHERE memberno = 1;
 
 PAYMENTNO MEMBERNO PAYSORT    HOWMUCH PDATE                 PNAME PAYCHECK
 --------- -------- ---------- ------- --------------------- ----- --------
         1        1 신용카드    99000 2018-06-08 17:22:00.0 송창현   Y
         2        1 계좌이체   130000 2018-06-06 17:22:34.0 송창현   N
         3        1 무통장입금 210000 2018-06-07 17:22:35.0 송창현   Y
 
   
4. 수정

1) 회원번호가 '1'인 회원의 결제번호가 '1'인 결제의 결제승인여부를 'Y'로 변경

UPDATE payment 
SET paycheck = 'Y'
WHERE memberno = 1 AND paymentno= 1;
 
2) 회원번호가 '1'인 회원의 결제번호가 '1'인 결제의 메모 수정

UPDATE payment 
SET pmemo = '옥션 의자 구매'
WHERE memberno = 1 AND paymentno= 1;
 
 
5. 삭제

1) 모든 결제내역 삭제
DELETE FROM payment;
 
2) 회원번호가 '1'인 회원의 결제내역 삭제
DELETE FROM payment
WHERE memberno = 1;
 
 
-------------------------------------------------------------------------------------