/**********************************/
/* Table Name: 카드 */
/**********************************/
CREATE TABLE card(
    cardidno                          NUMBER(10)     NOT NULL    PRIMARY KEY,
    cardcompany                       VARCHAR2(20)     NOT NULL,
    cardnumber                        NUMBER(16)     NOT NULL,
    expires                           NUMBER(6)    NOT NULL,
    dealsortno                        NUMBER(2)    NULL ,
  FOREIGN KEY (dealsortno) REFERENCES dealsort (dealsortno)
);

COMMENT ON TABLE card is '카드';
COMMENT ON COLUMN card.cardidno is '카드구분번호';
COMMENT ON COLUMN card.cardcompany is '카드사';
COMMENT ON COLUMN card.cardnumber is '카드번호';
COMMENT ON COLUMN card.expires is '카드만료일';
COMMENT ON COLUMN card.dealsortno is '거래수단번호';


0. 테이블 드롭

DROP TABLE card;

select cardidno, cardcompany, cardnumber, expires, dealsortno
from card;

-------------------------------------------------------------------------------------
1. 등록

INSERT INTO card(cardidno, cardnumber, cardcompany, expires, dealsortno)
VALUES ((SELECT nvl(MAX(cardidno), 0) + 1 as cardidno FROM card), 
                           1111222211112222, '국민은행', 062022, 1);

INSERT INTO card(cardidno, cardnumber, cardcompany, expires, dealsortno)
VALUES ((SELECT nvl(MAX(cardidno), 0) + 1 as cardidno FROM card), 
                           2000313102026666, '우리은행', 062022, 2);

INSERT INTO card(cardidno, cardnumber, cardcompany, expires, dealsortno)
VALUES ((SELECT nvl(MAX(cardidno), 0) + 1 as cardidno FROM card), 
                           6060100182829595, '신한은행', 062022, 3);


-------------------------------------------------------------------------------------

2. 목록
- 검색을 하지 않는 경우, 전체 목록 출력
 
SELECT cardnumber, bname, cardsort, owner, expires, memo, paysortno
FROM card
ORDER BY expires DESC;
 
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
 
 
----------------------------------------------------------------------------