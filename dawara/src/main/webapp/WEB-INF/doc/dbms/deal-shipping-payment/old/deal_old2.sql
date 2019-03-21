DROP TABLE receive CASCADE CONSTRAINTS;
DROP TABLE delivery CASCADE CONSTRAINTS;
DROP TABLE payment CASCADE CONSTRAINTS;
DROP TABLE deal CASCADE CONSTRAINTS;
DROP TABLE buy CASCADE CONSTRAINTS;
DROP TABLE product CASCADE CONSTRAINTS;
DROP TABLE charge CASCADE CONSTRAINTS;
DROP TABLE mlieage CASCADE CONSTRAINTS;
DROP TABLE member CASCADE CONSTRAINTS;

INSERT INTO auth(auth_no, auth_info) VALUES(1, '관리자');
INSERT INTO member(mem_no, auth_no, mem_id, mem_pass, mem_name, mem_tel, mem_mail, mem_job, mem_acc, mem_confirm, mem_date) VALUES((SELECT nvl(MAX(mem_no), 0) + 1 as mem_no FROM member), 1, 'schyyy', '123', 'SCH', '01022220000', 'schyyy@naver.com', '학생', 0, 'Y', SYSDATE);
INSERT INTO categrp(grp_no, grp_classification, grp_title, grp_seqno, grp_visible, grp_rdate) VALUES((SELECT NVL(MAX(grp_no), 0)+1 as grp_no FROM categrp), 1, 'SAMSUNG올웨이즈9', 1, 'Y', sysdate);
INSERT INTO category(gory_no, grp_no, mem_no, gory_title, gory_seqno, gory_visible, gory_ids, gory_cnt, gory_rdate) VALUES((SELECT NVL(MAX(gory_no), 0)+1 as gory_no FROM category), 1, 1, '삼성', 0, 'Y', 'ad', 1, sysdate);
INSERT INTO product(pr_no, pr_maker, pr_title, pr_contents, pr_cnt, pr_rdate, pr_price, pr_visible, pr_payment) VALUES((SELECT nvl(MAX(pr_no), 0) + 1 as pr_no FROM product), 'LG', '그램팝니다', '2018년 올데이그램 판매', 0, SYSDATE, 1000000, 'Y', 'Y');
INSERT INTO buy(mem_no, pr_no, mem_no, buy_rdate) VALUES((SELECT nvl(MAX(mem_no), 0) + 1 as mem_no FROM buy), 1, 1, SYSDATE);

/**********************************/
/* Table Name: 상품 거래 */
/**********************************/
CREATE TABLE deal(
    deal_no                           NUMBER(10)     NOT NULL,
    d_state                           VARCHAR2(20)     NOT NULL,
    d_way                             VARCHAR2(20)     NOT NULL,
    d_check                           CHAR(1)    DEFAULT 'N'     NULL ,
    d_date                            DATE     NOT NULL,
    mem_no                            NUMBER(10)     NULL ,
    pr_no                             NUMBER(10)     NULL ,
  FOREIGN KEY (mem_no) REFERENCES buy (mem_no),
  FOREIGN KEY (pr_no) REFERENCES product (pr_no)
);

COMMENT ON TABLE deal is '상품 거래';
COMMENT ON COLUMN deal.deal_no is '거래번호';
COMMENT ON COLUMN deal.d_state is '거래상태';
COMMENT ON COLUMN deal.d_way is '거래방법';
COMMENT ON COLUMN deal.d_check is '거래확인';
COMMENT ON COLUMN deal.d_date is '거래등록일';
COMMENT ON COLUMN deal.mem_no is '구매번호';
COMMENT ON COLUMN deal.pr_no is '상품번호';

SELECT deal_no, d_state, d_way, d_check, d_date, mem_no, pr_no
FROM deal;

DELETE FROM deal;

1) 거래 한 건 최초 등록

INSERT INTO deal(deal_no, d_state, d_way, d_date, mem_no, pr_no)
VALUES ((SELECT nvl(MAX(deal_no), 0) + 1 as deal_no FROM deal), '거래중', '택배거래', SYSDATE-1, 1, 1);

INSERT INTO deal(deal_no, d_state, d_way, d_date, mem_no, pr_no)
VALUES ((SELECT nvl(MAX(deal_no), 0) + 1 as deal_no FROM deal), '거래중', '직거래', SYSDATE-2, 1, 1);

INSERT INTO deal(deal_no, d_state, d_way, d_date, mem_no, pr_no)
VALUES ((SELECT nvl(MAX(deal_no), 0) + 1 as deal_no FROM deal), '거래중', '직거래', SYSDATE-3, 1, 1);

----------------------------------------------------------------------------------------

2) 조회
select DEAL_NO, D_STATE, D_WAY, D_CHECK, D_DATE, mem_no, PR_NO from deal;

 DEAL_NO D_STATE  D_WAY    D_CHECK D_DATE                mem_no PR_NO
 ------- -------- -------- ------- --------------------- ------ -----
       1 거래중   택배거래 N       2018-06-22 19:12:53.0      1     1
       2 거래중   택배거래 N       2018-06-25 17:10:55.0      1     1
       3 거래중   택배거래 N       2018-06-25 17:41:49.0      1     1
      12 거래완료 직거래   N       2018-06-26 15:56:10.0      1     1
      13 거래중   직거래   N       2018-06-26 15:56:19.0      1     1
       
-- 택배거래 조회
select DEAL_NO, D_STATE, D_WAY, D_CHECK, D_DATE, mem_no, PR_NO 
from deal
WHERE D_WAY = '택배거래';

 DEAL_NO D_STATE D_WAY    D_CHECK D_DATE                mem_no PR_NO
 ------- ------- -------- ------- --------------------- ------ -----
       1 거래중  택배거래 N       2018-06-22 19:12:53.0      1     1
       2 거래중  택배거래 N       2018-06-25 17:10:55.0      1     1
       3 거래중  택배거래 N       2018-06-25 17:41:49.0      1     1

-- 직거래 조회
select DEAL_NO, D_STATE, D_WAY, D_CHECK, D_DATE, mem_no, PR_NO 
from deal
WHERE D_WAY = '직거래';
     
 DEAL_NO D_STATE  D_WAY  D_CHECK D_DATE                mem_no PR_NO
 ------- -------- ------ ------- --------------------- ------ -----
      12 거래완료 직거래 N       2018-06-26 15:56:10.0      1     1
      13 거래중   직거래 N       2018-06-26 15:56:19.0      1     1

---------------------------------------------------------------------------------------

3) 수정      
-- 거래 수정      
UPDATE deal
SET d_state='거래완료', d_way='택배거래', d_check='Y'
WHERE deal_no = 12
     
4) 삭제
-- 한 건의 거래 삭제       
DELETE FROM deal
WHERE deal_no = 3;

---------------------------------------------------------------------------------------

5) 검색

-- '택배' 검색
SELECT DEAL_NO, D_STATE, D_WAY, D_CHECK, D_DATE, mem_no, PR_NO 
FROM deal
WHERE d_way LIKE '%택배%'
ORDER BY DEAL_NO DESC
;

 DEAL_NO D_STATE    D_WAY    D_CHECK D_DATE                mem_no PR_NO
 ------- ---------- -------- ------- --------------------- ------ -----
       6 거래완료   택배거래 N       2018-06-29 19:05:19.0      1     1
       5 수취확인중 택배거래 N       2018-06-29 19:05:15.0      1     1
       4 배송중     택배거래 N       2018-06-29 19:05:12.0      1     1
       3 거래진행중 택배거래 N       2018-06-29 19:05:08.0      1     1
       2 결제중     택배거래 N       2018-06-29 19:05:00.0      1     1
       1 거래중     택배거래 N       2018-06-28 17:45:40.0      1     1

-- '결제' 검색
SELECT DEAL_NO, D_STATE, D_WAY, D_CHECK, D_DATE, mem_no, PR_NO 
FROM deal
WHERE d_state LIKE '%결제%'
ORDER BY DEAL_NO DESC
;

 DEAL_NO D_STATE D_WAY    D_CHECK D_DATE                mem_no PR_NO
 ------- ------- -------- ------- --------------------- ------ -----
       7 결제중  택배거래 N       2018-06-29 19:06:40.0      1     1
       2 결제중  택배거래 N       2018-06-29 19:05:00.0      1     1


-- '완료' 검색
SELECT DEAL_NO, D_STATE, D_WAY, D_CHECK, D_DATE, mem_no, PR_NO 
FROM deal
WHERE d_state LIKE '%완료%' 
ORDER BY DEAL_NO DESC
;

 DEAL_NO D_STATE  D_WAY    D_CHECK D_DATE                mem_no PR_NO
 ------- -------- -------- ------- --------------------- ------ -----
       8 거래완료 택배거래 N       2018-06-29 19:07:08.0      1     1
       6 거래완료 택배거래 N       2018-06-29 19:05:19.0      1     1

-- 거래 날짜 '6월 28일' 검색
SELECT DEAL_NO, D_STATE, D_WAY, D_CHECK, D_DATE, mem_no, PR_NO 
FROM deal
WHERE TO_CHAR(d_date, 'MMDD') = '0628'
ORDER BY DEAL_NO DESC
;       

-- 거래 날짜 '6월 28일' 검색
SELECT DEAL_NO, D_STATE, D_WAY, D_CHECK, D_DATE, mem_no, PR_NO 
FROM deal
WHERE TO_CHAR(d_date, 'MMDD') = '0628'
ORDER BY DEAL_NO DESC
;

-- TO_CHAR(d_date, 'MMDD')
-- YYYYMMDDHH24MISS
-- YYYYMMDDHH12MISS

-- 2개의 특정날짜 사이의 데이터
-- YYYYMMDD로 하면 뒷 부분(시분초)가 0으로 세팅
-- M_TIME  between to_date('20031112', 'YYYYMMDD') and to_date('20031114', 'YYYYMMDD') + 1
-- 로 하면 12일, 13일 14일 모두가 포함

SELECT DEAL_NO, D_STATE, D_WAY, D_CHECK, D_DATE, mem_no, PR_NO 
FROM deal
WHERE d_date between to_date('180628', 'YYMMDD') and to_date('180629', 'YYMMDD') -- (180628 00:00:00 ~ 180629 00:00:00) => 180628
ORDER BY DEAL_NO DESC
;

 DEAL_NO D_STATE D_WAY D_CHECK D_DATE                mem_no PR_NO
 ------- ------- ----- ------- --------------------- ------ -----
       1 거래중  택배거래  N   2018-06-28 17:45:40.0      1     1

-- 180628 ~ 180629 거래 검색
       
SELECT DEAL_NO, D_STATE, D_WAY, D_CHECK, D_DATE, mem_no, PR_NO
FROM deal
WHERE d_date between to_date('180629', 'YYMMDD') and to_date('180629', 'YYMMDD') + 1
ORDER BY DEAL_NO DESC
;

 DEAL_NO D_STATE D_WAY  D_CHECK D_DATE                MEM_NO PR_NO
 ------- ------- ------ ------- --------------------- ------ -----
       5 거래중  직거래 N       2018-06-29 15:37:52.0      2     1
       4 거래중  직거래 N       2018-06-29 15:37:51.0      2     1

       
6) 날짜 검색 및 전체 레코드 갯수
-- 검색하지 않는 경우 전체 레코드 갯수
SELECT COUNT(*) as cnt
FROM deal
WHERE 1= 1

 CNT
 ---
   8
   
-- '180628~180628' 검색 레코드 갯수
SELECT COUNT(*) as cnt
FROM deal
WHERE d_date between to_date('180628', 'YYMMDD') and to_date('180628', 'YYMMDD') + 1
       
 CNT
 ---
   1
   
---------------------------------------------------------------------------------------

7) 페이징

       