/**********************************/
/* Table Name: 내 카드 */
/**********************************/
CREATE TABLE mycard(
    cardidno                          NUMBER(10)     NOT NULL    PRIMARY KEY,
    addcarddate                       DATE     NOT NULL,
    mem_no                            NUMBER(6)    NOT NULL,
  FOREIGN KEY (mem_no) REFERENCES mywallet (mem_no),
  FOREIGN KEY (cardidno) REFERENCES card (cardidno)
);

COMMENT ON TABLE mycard is '내 카드';
COMMENT ON COLUMN mycard.cardidno is '카드구분번호';
COMMENT ON COLUMN mycard.addcarddate is '카드등록일';
COMMENT ON COLUMN mycard.mem_no is '회원번호';


0. 테이블 드롭

DROP TABLE mycard;

select cardidno, cardsort, cardnumber, cardcompany, expires, mem_no
from mycard;

-------------------------------------------------------------------------------------
1. 등록

INSERT INTO mycard(cardidno, cardsort, cardnumber, cardcompany, expires, mem_no)
VALUES ((SELECT nvl(MAX(cardidno), 0) + 1 as cardidno FROM categrp), 
                            '신용카드', 1111222211112222, '국민은행', 062022, 1);

INSERT INTO mycard(cardidno, cardnumber, cardcompany, expires, mywalletno)
VALUES (2000313102026666, '우리은행', '체크카드', '송창현', 072021, '일상용', 11);

INSERT INTO mycard(cardidno, cardnumber, cardcompany, expires, mywalletno)
VALUES (6060100182829595, '신한은행', '신용카드', '송창현', 112020, '자동이체전용', 11);


-------------------------------------------------------------------------------------

2. 목록
- 검색을 하지 않는 경우, 전체 목록 출력
 
SELECT cardnumber, bname, cardsort, owner, expires, memo, paysortno
FROM mycard
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