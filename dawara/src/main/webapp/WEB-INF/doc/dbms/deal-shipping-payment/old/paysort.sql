/**********************************/
/* Table Name: 결제수단 */
/**********************************/
CREATE TABLE paysort(
    paysortno                         NUMBER(2)    NOT NULL    PRIMARY KEY,
    psortname                         VARCHAR2(20)     NOT NULL,
    paymentno                         NUMBER(10)     NULL ,
  FOREIGN KEY (paymentno) REFERENCES paysort (paymentno)
);

COMMENT ON TABLE paysort is '결제수단';
COMMENT ON COLUMN paysort.paysortno is '결제수단번호';
COMMENT ON COLUMN paysort.psortname is '결제수단명';
COMMENT ON COLUMN paysort.paymentno is '결제번호';

0. 테이블 드롭

DROP TABLE paysort;

select paysortno, psortname, paymentno
from paysort

-------------------------------------------------------------------------------------
1. 등록

INSERT INTO paysort(paysortno, psortname, paymentno)
VALUES ((SELECT NVL(MAX(paymentno), 0)+1 as paymentno FROM paysort), 1, 1,
        '신용카드', 99000, SYSDATE, '송창현', 'Y');

INSERT INTO paysort(paymentno, sellno, memberno, paysort, howmuch, pdate, pname, paycheck)
VALUES ((SELECT NVL(MAX(paymentno), 0)+1 as paymentno FROM paysort), 1, 1,
        '계좌이체', 130000, SYSDATE-2, '송창현', 'N');

INSERT INTO paysort(paymentno, sellno, memberno, paysort, howmuch, pdate, pname, paycheck)
VALUES ((SELECT NVL(MAX(paymentno), 0)+1 as paymentno FROM paysort), 1, 1,
        '무통장입금', 210000, SYSDATE-1, '송창현', 'Y');

-------------------------------------------------------------------------------------

2. 목록
- 검색을 하지 않는 경우, 전체 목록 출력
 
SELECT paymentno, sellno, memberno, paysort, howmuch, pdate, pname, paycheck
FROM paysort
ORDER BY paymentno ASC;
 
 PAYMENTNO MEMBERNO PAYSORT     HOWMUCH  PDATE                 PNAME  PAYCHECK
 --------- -------- ----------- -------- --------------------- ------ --------
         1        1 신용카드      99000  2018-06-08 17:22:00.0 송창현   Y
         2        1 계좌이체     130000  2018-06-06 17:22:34.0 송창현   N
         3        1 무통장입금   210000  2018-06-07 17:22:35.0 송창현   Y
 
   
3. 조회
 
1) 회원번호가 '1'인 회원가 '신용카드'로 결제한 결제내역 조회
SELECT paymentno, sellno, memberno, paysort, howmuch, pdate, pname, paycheck
FROM paysort
WHERE memberno = 1 AND paysort = '신용카드';
 
 PAYMENTNO MEMBERNO PAYSORT HOWMUCH PDATE                 PNAME PAYCHECK
 --------- -------- ------- ------- --------------------- ----- --------
         1        1 신용카드  99000 2018-06-08 17:22:00.0 송창현   Y
 
2) 회원번호가 '1'인 회원의 결제내역 조회         
         
SELECT paymentno, sellno, memberno, paysort, howmuch, pdate, pname, paycheck
FROM paysort
WHERE memberno = 1;
 
 PAYMENTNO MEMBERNO PAYSORT    HOWMUCH PDATE                 PNAME PAYCHECK
 --------- -------- ---------- ------- --------------------- ----- --------
         1        1 신용카드    99000 2018-06-08 17:22:00.0 송창현   Y
         2        1 계좌이체   130000 2018-06-06 17:22:34.0 송창현   N
         3        1 무통장입금 210000 2018-06-07 17:22:35.0 송창현   Y
 
   
4. 수정

1) 회원번호가 '1'인 회원의 결제번호가 '1'인 결제의 결제승인여부를 'Y'로 변경

UPDATE paysort 
SET paycheck = 'Y'
WHERE memberno = 1 AND paymentno= 1;
 
2) 회원번호가 '1'인 회원의 결제번호가 '1'인 결제의 메모 수정

UPDATE paysort 
SET pmemo = '옥션 의자 구매'
WHERE memberno = 1 AND paymentno= 1;
 
 
5. 삭제

1) 모든 결제내역 삭제
DELETE FROM paysort;
 
2) 회원번호가 '1'인 회원의 결제내역 삭제
DELETE FROM paysort
WHERE memberno = 1;
 
 
-------------------------------------------------------------------------------------