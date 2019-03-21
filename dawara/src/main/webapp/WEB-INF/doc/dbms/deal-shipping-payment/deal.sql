DROP TABLE receive CASCADE CONSTRAINTS;
DROP TABLE delivery CASCADE CONSTRAINTS;
DROP TABLE payment CASCADE CONSTRAINTS;
DROP TABLE deal CASCADE CONSTRAINTS;
DROP TABLE product CASCADE CONSTRAINTS;
DROP TABLE charge CASCADE CONSTRAINTS;
DROP TABLE mlieage CASCADE CONSTRAINTS;
DROP TABLE member CASCADE CONSTRAINTS;

INSERT INTO auth(auth_no, auth_info) VALUES(1, '관리자');
INSERT INTO member(mem_no, auth_no, mem_id, mem_pass, mem_name, mem_tel, mem_mail, mem_job, mem_acc, mem_confirm, mem_date) VALUES((SELECT nvl(MAX(mem_no), 0) + 1 as mem_no FROM member), 1, 'schyyy', '123', 'SCH', '01022220000', 'schyyy@naver.com', '학생', 0, 'Y', SYSDATE);
INSERT INTO member(mem_no, auth_no, mem_id, mem_pass, mem_name, mem_tel, mem_mail, mem_job, mem_acc, mem_confirm, mem_date) VALUES((SELECT nvl(MAX(mem_no), 0) + 1 as mem_no FROM member), 1, 'buyer', '123', 'BYU', '01033330000', 'buyer@naver.com', '학생', 0, 'Y', SYSDATE);
INSERT INTO categrp(grp_no, grp_classification, grp_title, grp_seqno, grp_visible, grp_rdate) VALUES((SELECT NVL(MAX(grp_no), 0)+1 as grp_no FROM categrp), 1, 'SAMSUNG올웨이즈9', 1, 'Y', sysdate);
INSERT INTO category(gory_no, grp_no, mem_no, gory_title, gory_seqno, gory_visible, gory_ids, gory_cnt, gory_rdate) VALUES((SELECT NVL(MAX(gory_no), 0)+1 as gory_no FROM category), 1, 1, '삼성', 0, 'Y', 'ad', 1, sysdate);
INSERT INTO product(pr_no, pr_maker, pr_title, pr_contents, pr_cnt, pr_rdate, pr_price, pr_visible, pr_payment) VALUES((SELECT nvl(MAX(pr_no), 0) + 1 as pr_no FROM product), 'LG', '그램팝니다', '2018년 올데이그램 판매', 0, SYSDATE, 1000000, 'Y', 'Y');

/**********************************/
/* Table Name: 상품 거래 */
/**********************************/
CREATE TABLE DEAL(
    deal_no      NUMBER(10)                            NOT NULL    PRIMARY KEY,
    d_state      VARCHAR2(20)     DEFAULT '거래중'     NOT NULL,
    d_way        VARCHAR2(20)     DEFAULT '택배거래'   NOT NULL,
    d_date       DATE                                  NOT NULL,
    d_check      CHAR(1)          DEFAULT 'N'          NOT NULL,
    d_memo       VARCHAR2(100)    DEFAULT '메모'       NULL ,
    mem_no       NUMBER(6)                             NOT NULL,
    pr_no        NUMBER(10)                            NOT NULL,
  FOREIGN KEY (mem_no) REFERENCES MEMBER (MEM_NO),
  FOREIGN KEY (pr_no) REFERENCES PRODUCT (PR_NO)
);

COMMENT ON TABLE DEAL is '상품 거래';
COMMENT ON COLUMN DEAL.deal_no is '거래번호';
COMMENT ON COLUMN DEAL.d_state is '거래상태';
COMMENT ON COLUMN DEAL.d_way is '거래방법';
COMMENT ON COLUMN DEAL.d_date is '거래등록일';
COMMENT ON COLUMN DEAL.d_check is '거래확인';
COMMENT ON COLUMN DEAL.d_memo is '거래메모';
COMMENT ON COLUMN DEAL.mem_no is '회원번호';
COMMENT ON COLUMN DEAL.pr_no is '상품번호';

SELECT deal_no, d_state, d_way, d_check, d_date, d_check, mem_no, pr_no
FROM deal;

DELETE FROM deal;

----------------------------------------------------------------------------------------
1) 거래 한 건 최초 등록
----------------------------------------------------------------------------------------
INSERT INTO deal(deal_no, d_state, d_way, d_date, mem_no, pr_no)
VALUES ((SELECT nvl(MAX(deal_no), 0) + 1 as deal_no FROM deal), '거래중', '택배거래', SYSDATE-1, 2, 1);

INSERT INTO deal(deal_no, d_state, d_way, d_date, mem_no, pr_no)
VALUES ((SELECT nvl(MAX(deal_no), 0) + 1 as deal_no FROM deal), '거래중', '택배거래', SYSDATE-1, 2, 1);

INSERT INTO deal(deal_no, d_state, d_way, d_date, mem_no, pr_no)
VALUES ((SELECT nvl(MAX(deal_no), 0) + 1 as deal_no FROM deal), '거래중', '직거래', SYSDATE-2, 2, 1);

INSERT INTO deal(deal_no, d_state, d_way, d_date, mem_no, pr_no)
VALUES ((SELECT nvl(MAX(deal_no), 0) + 1 as deal_no FROM deal), '거래중', '직거래', SYSDATE-3, 2, 1);

INSERT INTO deal(deal_no, d_state, d_way, d_date, mem_no, pr_no)
VALUES ((SELECT nvl(MAX(deal_no), 0) + 1 as deal_no FROM deal), '거래중', '직거래', SYSDATE-3, 2, 1);

----------------------------------------------------------------------------------------
2) 목록
----------------------------------------------------------------------------------------
select DEAL_NO, D_STATE, D_WAY, D_CHECK, D_DATE, d_check, d_memo, mem_no, PR_NO 
from deal;

 DEAL_NO D_STATE D_WAY    D_CHECK D_DATE                D_CHECK D_MEMO MEM_NO PR_NO
 ------- ------- -------- ------- --------------------- ------- ------ ------ -----
       1 거래중  택배거래 N       2018-07-01 15:37:48.0 N       메모        2     1
       2 거래중  택배거래 N       2018-07-01 15:37:49.0 N       메모        2     1
       3 거래중  직거래   N       2018-06-30 15:37:50.0 N       메모        2     1
       4 거래중  직거래   N       2018-06-29 15:37:51.0 N       메모        2     1
       5 거래중  직거래   N       2018-06-29 15:37:52.0 N       메모        2     1
       
-- 택배거래 조회
select DEAL_NO, D_STATE, D_WAY, D_CHECK, D_DATE, d_check, d_memo, mem_no, PR_NO
from deal
WHERE D_WAY = '택배거래';

 DEAL_NO D_STATE D_WAY    D_CHECK D_DATE                D_CHECK D_MEMO MEM_NO PR_NO
 ------- ------- -------- ------- --------------------- ------- ------ ------ -----
       1 거래중  택배거래 N       2018-07-01 15:37:48.0 N       메모        2     1
       2 거래중  택배거래 N       2018-07-01 15:37:49.0 N       메모        2     1

-- 직거래 조회
select DEAL_NO, D_STATE, D_WAY, D_CHECK, D_DATE, d_check, d_memo, mem_no, PR_NO
from deal
WHERE D_WAY = '직거래';
     
 DEAL_NO D_STATE D_WAY  D_CHECK D_DATE                D_CHECK D_MEMO MEM_NO PR_NO
 ------- ------- ------ ------- --------------------- ------- ------ ------ -----
       3 거래중  직거래 N       2018-06-30 15:37:50.0 N       메모        2     1
       4 거래중  직거래 N       2018-06-29 15:37:51.0 N       메모        2     1
       5 거래중  직거래 N       2018-06-29 15:37:52.0 N       메모        2     1


---------------------------------------------------------------------------------------
3) 수정      
---------------------------------------------------------------------------------------
-- 거래 완료로 수정      
UPDATE deal
SET d_state='거래완료', d_way='택배거래', d_check='Y'
WHERE deal_no = 12
     
---------------------------------------------------------------------------------------
4) 삭제
---------------------------------------------------------------------------------------
-- 한 건의 거래 삭제       
DELETE FROM deal
WHERE deal_no = 3;


---------------------------------------------------------------------------------------
5) 검색
---------------------------------------------------------------------------------------
-- '택배' 검색
SELECT DEAL_NO, D_STATE, D_WAY, D_CHECK, D_DATE, d_check, d_memo, mem_no, PR_NO
FROM deal
WHERE d_way LIKE '%택배%'
ORDER BY DEAL_NO DESC
;

 DEAL_NO D_STATE D_WAY    D_CHECK D_DATE                D_CHECK D_MEMO MEM_NO PR_NO
 ------- ------- -------- ------- --------------------- ------- ------ ------ -----
       2 거래중  택배거래 N       2018-07-01 15:37:49.0 N       메모        2     1
       1 거래중  택배거래 N       2018-07-01 15:37:48.0 N       메모        2     1

-- '결제' 검색
SELECT DEAL_NO, D_STATE, D_WAY, D_CHECK, D_DATE, d_check, d_memo, mem_no, PR_NO
FROM deal
WHERE d_state LIKE '%결제%'
ORDER BY DEAL_NO DESC
;

 DEAL_NO D_STATE D_WAY    D_CHECK D_DATE                BUY_NO PR_NO
 ------- ------- -------- ------- --------------------- ------ -----
       7 결제중  택배거래 N       2018-06-29 19:06:40.0      1     1
       2 결제중  택배거래 N       2018-06-29 19:05:00.0      1     1


-- '완료' 검색
SELECT DEAL_NO, D_STATE, D_WAY, D_CHECK, D_DATE, d_check, d_memo, mem_no, PR_NO
FROM deal
WHERE d_state LIKE '%완료%' 
ORDER BY DEAL_NO DESC
;

 DEAL_NO D_STATE  D_WAY    D_CHECK D_DATE                BUY_NO PR_NO
 ------- -------- -------- ------- --------------------- ------ -----
       8 거래완료 택배거래 N       2018-06-29 19:07:08.0      1     1
       6 거래완료 택배거래 N       2018-06-29 19:05:19.0      1     1

-- 거래 날짜 '6월 28일' 검색
SELECT DEAL_NO, D_STATE, D_WAY, D_CHECK, D_DATE, d_check, d_memo, mem_no, PR_NO
FROM deal
WHERE TO_CHAR(d_date, 'MMDD') = '0628'
ORDER BY DEAL_NO DESC
;       

-- 거래 날짜 '6월 28일' 검색
SELECT DEAL_NO, D_STATE, D_WAY, D_CHECK, D_DATE, d_check, d_memo, mem_no, PR_NO
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

SELECT DEAL_NO, D_STATE, D_WAY, D_CHECK, D_DATE, d_check, d_memo, mem_no, PR_NO
FROM deal
WHERE d_date between to_date('180628', 'YYMMDD') and to_date('180629', 'YYMMDD') -- (180628 00:00:00 ~ 180629 00:00:00) => 180628
ORDER BY DEAL_NO DESC
;

 DEAL_NO D_STATE D_WAY D_CHECK D_DATE                BUY_NO PR_NO
 ------- ------- ----- ------- --------------------- ------ -----
       1 거래중  택배거래  N   2018-06-28 17:45:40.0      1     1

-- 180628 ~ 180629 거래 검색
       
SELECT DEAL_NO, D_STATE, D_WAY, D_CHECK, D_DATE, d_check, d_memo, mem_no, PR_NO
FROM deal
WHERE d_date between to_date('180628', 'YYMMDD') and to_date('180629', 'YYMMDD') + 1
ORDER BY DEAL_NO DESC
;

 DEAL_NO D_STATE D_WAY  D_CHECK D_DATE                D_CHECK D_MEMO MEM_NO PR_NO
 ------- ------- ------ ------- --------------------- ------- ------ ------ -----
       5 거래중  직거래 N       2018-06-29 15:37:52.0 N       메모        2     1
       4 거래중  직거래 N       2018-06-29 15:37:51.0 N       메모        2     1

       
---------------------------------------------------------------------------------------
6) 날짜 검색 및 전체 레코드 갯수
---------------------------------------------------------------------------------------
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
   
--  판매자, 구매자 이름 출력
                m.mem_id, m.mem_name, m.mem_tel, m.mem_mail,

SELECT distinct p.pr_no, p.pr_title, p.pr_price, p.pr_rdate, p.mem_no as seller_no, (SELECT distinct m.mem_name as seller FROM member m, product p WHERE p.mem_no = m.mem_no) as seller, 
                d.deal_no, d.d_state, d.d_way, d.d_check, d.d_date, d.mem_no as buyer_no, (SELECT distinct m.mem_name as buyer FROM member m, deal d WHERE d.mem_no = m.mem_no) as buyer 
FROM product p, deal d
WHERE d.d_date between to_date(180630, 'YYMMDD') and to_date(180630, 'YYMMDD') + 1
ORDER BY d.deal_no DESC;
   
 PR_NO PR_TITLE PR_PRICE PR_RDATE              SELLER_NO SELLER DEAL_NO D_STATE D_WAY  D_CHECK D_DATE                BUYER_NO BUYER
 ----- -------- -------- --------------------- --------- ------ ------- ------- ------ ------- --------------------- -------- -----
     1 제목         1000 2018-07-01 23:54:41.0         1 SCH          3 거래중  직거래 N       2018-06-30 15:37:50.0        2 BYU


 PR_NO PR_TITLE PR_PRICE PR_RDATE              SELLER_NO MEM_ID MEM_NAME MEM_TEL     MEM_MAIL         DEAL_NO D_STATE D_WAY  D_CHECK D_DATE                BUYER_NO (SELECTDISTINCTM.MEM_NAMEASSELLERFROMMEMBERM,PRODUCTPWHEREP.MEM_NO=M.MEM_NO) (SELECTDISTINCTM.MEM_NAMEASBUYERFROMMEMBERM,DEALDWHERED.MEM_NO=M.MEM_NO)
 ----- -------- -------- --------------------- --------- ------ -------- ----------- ---------------- ------- ------- ------ ------- --------------------- -------- ---------------------------------------------------------------------------- ------------------------------------------------------------------------
     1 제목         1000 2018-07-01 23:54:41.0         1 buyer  BYU      01033330000 buyer@naver.com        3 거래중  직거래 N       2018-06-30 15:37:50.0        2 SCH                                                                          BYU
     1 제목         1000 2018-07-01 23:54:41.0         1 schyyy SCH      01022220000 schyyy@naver.com       3 거래중  직거래 N       2018-06-30 15:37:50.0        2 SCH                                                                          BYU

 PR_NO PR_TITLE PR_PRICE PR_RDATE              SELLER_NO MEM_ID MEM_NAME MEM_TEL     MEM_MAIL         DEAL_NO D_STATE D_WAY  D_CHECK D_DATE                BUYER_NO SELLER BUYER
 ----- -------- -------- --------------------- --------- ------ -------- ----------- ---------------- ------- ------- ------ ------- --------------------- -------- ------ -----
     1 제목         1000 2018-07-01 23:54:41.0         1 buyer  BYU      01033330000 buyer@naver.com        3 거래중  직거래 N       2018-06-30 15:37:50.0        2 SCH    BYU
     1 제목         1000 2018-07-01 23:54:41.0         1 schyyy SCH      01022220000 schyyy@naver.com       3 거래중  직거래 N       2018-06-30 15:37:50.0        2 SCH    BYU
     


---------------------------------------------------------------------------------------
7) 페이징
---------------------------------------------------------------------------------------
SELECT distinct d.deal_no, d.d_state, d.d_way, d.d_check, d.d_date, 
                p.mem_no as seller_no, (SELECT distinct m.mem_name FROM member m, product p WHERE p.mem_no = m.mem_no) as seller, 
                p.pr_title, p.pr_price, 
                d.mem_no as buyer_no, (SELECT distinct m.mem_name FROM member m, deal d WHERE d.mem_no = m.mem_no) as buyer 
FROM product p, deal d
ORDER BY d.deal_no DESC;

 DEAL_NO D_STATE D_WAY    D_CHECK D_DATE                SELLER_NO SELLER PR_TITLE PR_PRICE BUYER_NO BUYER
 ------- ------- -------- ------- --------------------- --------- ------ -------- -------- -------- -----
      10 거래중  직거래   N       2018-06-30 19:44:26.0         1 SCH    제목        1000         2 BYU
       9 거래중  직거래   N       2018-06-30 19:44:25.0         1 SCH    제목        1000         2 BYU
       8 거래중  직거래   N       2018-07-01 19:44:24.0         1 SCH    제목        1000         2 BYU
       7 거래중  택배거래 N       2018-07-02 19:44:23.0         1 SCH    제목        1000         2 BYU
       6 거래중  택배거래 N       2018-07-02 19:44:22.0         1 SCH    제목        1000         2 BYU
       5 거래중  직거래   N       2018-06-29 15:37:52.0         1 SCH    제목        1000         2 BYU
       4 거래중  직거래   N       2018-06-29 15:37:51.0         1 SCH    제목        1000         2 BYU
       3 거래중  직거래   N       2018-06-30 15:37:50.0         1 SCH    제목        1000         2 BYU
       2 거래중  택배거래 N       2018-07-01 15:37:49.0         1 SCH    제목        1000         2 BYU
       1 거래중  택배거래 N       2018-07-01 15:37:48.0         1 SCH    제목        1000         2 BYU

    SELECT p.pr_no, p.pr_title, p.pr_price, p.pr_rdate, p.mem_no as seller_no,
          (SELECT distinct m.mem_name FROM member m, product p WHERE p.mem_no = m.mem_no) as seller,
          d.deal_no, d.d_state, d.d_way, d.d_check, d.d_date, d.mem_no as buyer_no,
          (SELECT distinct m.mem_name FROM member m, deal d WHERE d.mem_no = m.mem_no) as buyer, r
    FROM(
          SELECT p.pr_no, p.pr_title, p.pr_price, p.pr_rdate, p.mem_no as seller_no,
                (SELECT distinct m.mem_name FROM member m, product p WHERE p.mem_no = m.mem_no) as seller,
                d.deal_no, d.d_state, d.d_way, d.d_check, d.d_date, d.mem_no as buyer_no,
                (SELECT distinct m.mem_name FROM member m, deal d WHERE d.mem_no = m.mem_no) as buyer, rownum as r
          FROM (
                SELECT p.pr_no, p.pr_title, p.pr_price, p.pr_rdate, p.mem_no as seller_no,
                      (SELECT distinct m.mem_name FROM member m, product p WHERE p.mem_no = m.mem_no) as seller,
                      d.deal_no, d.d_state, d.d_way, d.d_check, d.d_date, d.mem_no as buyer_no,
                      (SELECT distinct m.mem_name FROM member m, deal d WHERE d.mem_no = m.mem_no) as buyer
                FROM product p, deal d
                ORDER BY d.deal_no
          )
    )
    WHERE r >= 1 AND r <= 3;

SELECT p.pr_no, p.pr_title, p.pr_price, p.pr_rdate, p.mem_no as seller_no,
      (SELECT distinct m.mem_name FROM member m, product p WHERE p.mem_no = m.mem_no) as seller,
      d.deal_no, d.d_state, d.d_way, d.d_check, d.d_date, d.mem_no as buyer_no,
      (SELECT distinct m.mem_name FROM member m, deal d WHERE d.mem_no = m.mem_no) as buyer, rownum as r
FROM (
      SELECT p.pr_no, p.pr_title, p.pr_price, p.pr_rdate, p.mem_no as seller_no,
            (SELECT distinct m.mem_name FROM member m WHERE p.mem_no = m.mem_no) as seller,
            d.deal_no, d.d_state, d.d_way, d.d_check, d.d_date, d.mem_no as buyer_no,
            (SELECT distinct m.mem_name FROM member m WHERE d.mem_no = m.mem_no) as buyer
      FROM product p, deal d
      ORDER BY d.deal_no
) 


SELECT distinct d.deal_no, d.d_state, d.d_way, d.d_check, d.d_date, 
                p.mem_no as seller_no, (SELECT distinct m.mem_name FROM member m, product p WHERE p.mem_no = m.mem_no) as seller, 
                p.pr_title, p.pr_price, 
                d.mem_no as buyer_no, (SELECT distinct m.mem_name FROM member m, deal d WHERE d.mem_no = m.mem_no) as buyer 
FROM (
      SELECT distinct d.deal_no, d.d_state, d.d_way, d.d_check, d.d_date, 
                      p.mem_no as seller_no, (SELECT distinct m.mem_name FROM member m, product p WHERE p.mem_no = m.mem_no) as seller, 
                      p.pr_title, p.pr_price, 
                      d.mem_no as buyer_no, (SELECT distinct m.mem_name FROM member m, deal d WHERE d.mem_no = m.mem_no) as buyer 
      FROM (
            SELECT distinct d.deal_no, d.d_state, d.d_way, d.d_check, d.d_date, 
                            p.mem_no as seller_no, (SELECT distinct m.mem_name FROM member m, product p WHERE p.mem_no = m.mem_no) as seller, 
                            p.pr_title, p.pr_price, 
                            d.mem_no as buyer_no, (SELECT distinct m.mem_name FROM member m, deal d WHERE d.mem_no = m.mem_no) as buyer 
            FROM product p, deal d
      )
)
ORDER BY d.deal_no DESC;

                <choose>
                  <when test="startDate == null or startDate == ''">
                    WHERE p.pr_no = d.pr_no
                  </when>
                  <otherwise>
                    WHERE p.pr_no = d.pr_no and d.d_date between to_date(180629, 'YYMMDD') and to_date(180630, 'YYMMDD') + 1
                  </otherwise>
                </choose>

                
                
SELECT b.*
FROM (
      SELECT a.*, rownum as r
      FROM (
            SELECT distinct d.deal_no, d.d_state, d.d_way, d.d_check, d.d_date,
                            p.mem_no as seller_no, (SELECT distinct m.mem_name FROM member m, product p WHERE p.mem_no = m.mem_no) as seller,
                            p.pr_title, p.pr_price,
                            d.mem_no as buyer_no, (SELECT distinct m.mem_name FROM member m, deal d WHERE d.mem_no = m.mem_no) as buyer
            FROM product p, deal d
            ORDER BY d.deal_no
      ) a
) b
WHERE r >= 1 AND r <= 3;


--------------------------------------------------------------------------------------------------------


SELECT B.*, r
    FROM(
        SELECT A.*, rownum as r
        FROM (
            SELECT p.pr_no, p.pr_title, p.pr_price, p.pr_rdate, p.mem_no as seller_no,
                (SELECT distinct m.mem_name FROM member m, product p WHERE p.mem_no = m.mem_no) as seller,
                d.deal_no, d.d_state, d.d_way, d.d_check, d.d_date, d.mem_no as buyer_no,
                (SELECT distinct m.mem_name FROM member m, product p WHERE d.mem_no = m.mem_no) as buyer
            FROM product p, deal d
              --<!-- 날짜 검색 시 -->
              --<!-- startDate ~ endDate -->
              --<if test="startDate != null or startDate != '' and endDate != null or endDate != ''">
                WHERE p.pr_no = d.pr_no and d.d_date < '180716'
              --</if>
              --<!--           ~ endDate -->
              --<if test="startDate == null or startDate == '' and endDate != null or endDate != ''">
                --WHERE p.pr_no = d.pr_no and d.d_date between to_date(#{startDate}, 'YYMMDD') and to_date(#{endDate}, 'YYMMDD') + 1
              --</if>
              --<!-- startDate ~         -->
              --<if test="startDate != null or startDate != '' and endDate == null or endDate == ''">
                --WHERE p.pr_no = d.pr_no and d.d_date between to_date(#{startDate}, 'YYMMDD') and to_date(#{endDate}, 'YYMMDD') + 1
              --</if>
            ORDER BY d.deal_no
            ) A
        ) B
    WHERE r >= 1 AND r <= 5


    SELECT B.*, r
    FROM(
        SELECT A.*, rownum as r
        FROM (
            SELECT p.pr_no, p.pr_title, p.pr_price, p.pr_rdate, p.mem_no as seller_no,
                (SELECT distinct m.mem_name FROM member m, product p WHERE p.mem_no = m.mem_no) AS seller,
                d.deal_no, d.d_state, d.d_way, d.d_check, d.d_date, d.mem_no as buyer_no,
                (SELECT distinct m.mem_name FROM member m, product p WHERE d.mem_no = m.mem_no) AS buyer
            FROM product p, deal d
            WHERE p.pr_no = d.pr_no AND d.d_date BETWEEN (SELECT d_date FROM (SELECT d_date, rownum FROM deal ORDER BY d_date ) WHERE rownum=1) AND '180716'
            ORDER BY d.deal_no
            ) A
        ) B
    WHERE r >= 1 AND r <= 5

    
    
    SELECT d_date FROM (SELECT d_date, rownum FROM deal ORDER BY d_date DESC) WHERE rownum=1
    
-- (180716 ~ ) 검색
SELECT B.*, r
FROM(
    SELECT A.*, rownum as r
    FROM (
        SELECT p.pr_no, p.pr_title, p.pr_price, p.pr_rdate, p.mem_no as seller_no,
            (SELECT distinct m.mem_name FROM member m, product p WHERE p.mem_no = m.mem_no) AS seller,
            d.deal_no, d.d_state, d.d_way, d.d_check, d.d_date, d.mem_no as buyer_no,
            (SELECT distinct m.mem_name FROM member m, product p WHERE d.mem_no = m.mem_no) AS buyer
        FROM product p, deal d
				  WHERE p.pr_no = d.pr_no   
				  AND d.d_date BETWEEN '180716' AND (SELECT d_date FROM (SELECT d_date, rownum FROM deal ORDER BY d_date DESC) WHERE rownum=1)
        ORDER BY d.deal_no
        ) A
    ) B
    
    
-- ( ~ 180716) 검색
SELECT B.*, r
FROM(
    SELECT A.*, rownum as r
    FROM (
        SELECT p.pr_no, p.pr_title, p.pr_price, p.pr_rdate, p.mem_no as seller_no,
            (SELECT distinct m.mem_name FROM member m, product p WHERE p.mem_no = m.mem_no) AS seller,
            d.deal_no, d.d_state, d.d_way, d.d_check, d.d_date, d.mem_no as buyer_no,
            (SELECT distinct m.mem_name FROM member m, product p WHERE d.mem_no = m.mem_no) AS buyer
        FROM product p, deal d
        WHERE p.pr_no = d.pr_no AND d.d_date BETWEEN (SELECT d_date FROM (SELECT d_date, rownum FROM deal ORDER BY d_date ) WHERE rownum=1) AND to_date('180716', 'YYMMDD') + 1
        ORDER BY d.deal_no
        ) A
    ) B
    
-- ( ~ 180716) 검색
with product_deal as (SELECT p.pr_no, p.pr_title, p.pr_price, p.pr_rdate, p.mem_no as seller_no,
            (SELECT distinct m.mem_name FROM member m, product p WHERE p.mem_no = m.mem_no) AS seller,
            d.deal_no, d.d_state, d.d_way, d.d_check, d.d_date, d.mem_no as buyer_no,
            (SELECT distinct m.mem_name FROM member m, product p WHERE d.mem_no = m.mem_no) AS buyer
        FROM product p, deal d)
SELECT B.*, r
FROM(
    SELECT A.*, rownum as r
    FROM (
        SELECT p.pr_no, p.pr_title, p.pr_price, p.pr_rdate, p.mem_no as seller_no,
            (SELECT distinct m.mem_name FROM member m, product p WHERE p.mem_no = m.mem_no) AS seller,
            d.deal_no, d.d_state, d.d_way, d.d_check, d.d_date, d.mem_no as buyer_no,
            (SELECT distinct m.mem_name FROM member m, product p WHERE d.mem_no = m.mem_no) AS buyer
        FROM product p, deal d
        WHERE p.pr_no = d.pr_no AND d.d_date <= to_date('180716', 'YYMMDD') + 1 and seller = '왕눈이'
        ORDER BY d.deal_no
        ) A
    ) B
    
    
SELECT X.*, JUMSU
FROM (
    SELECT ID, NAME, ADDRESS, ((GRADE * 10)-4) AS JUMSU
    FROM SAMPLETBL 
) AS X
WHERE JUMSU > 5    
    
SELECT B.*, r
FROM(
    SELECT A.*, rownum as r
    FROM (
        SELECT p.pr_no, p.pr_title, p.pr_price, p.pr_rdate, p.mem_no as seller_no,
            (SELECT distinct m.mem_name FROM member m, product p WHERE p.mem_no = m.mem_no) AS seller,
            d.deal_no, d.d_state, d.d_way, d.d_check, d.d_date, d.mem_no as buyer_no,
            (SELECT distinct m.mem_name FROM member m, product p WHERE d.mem_no = m.mem_no) AS buyer
        FROM product p, deal d
        WHERE p.pr_no = d.pr_no AND d.d_date <= to_date('180716', 'YYMMDD') + 1 
        ORDER BY d.deal_no
        )  A
    )  B
    where seller = '왕눈이'
    
    
WITH pdjoin AS (SELECT p.pr_no, p.pr_title, p.pr_price, p.pr_rdate, p.mem_no as seller_no,
            (SELECT distinct m.mem_name FROM member m, product p WHERE p.mem_no = m.mem_no) AS seller,
            d.deal_no, d.d_state, d.d_way, d.d_check, d.d_date, d.mem_no as buyer_no,
            (SELECT distinct m.mem_name FROM member m, product p WHERE d.mem_no = m.mem_no) AS buyer
        FROM product p, deal d)
SELECT seller, buyer FROM pdjoin;



            SELECT p.pr_no, p.pr_title, p.pr_price, p.pr_rdate, p.mem_no as seller_no, s.seller,
                   d.deal_no, d.d_state, d.d_way, d.d_check, d.d_date, d.mem_no as buyer_no, b.buyer
            FROM product p, deal d, member m
                (SELECT distinct m.mem_name as seller FROM member m, product p WHERE p.mem_no = m.mem_no) s, 
                (SELECT distinct m.mem_name as buyer FROM member m, deal d WHERE d.mem_no = 2) b
            WHERE p.pr_no = d.pr_no
            
            select m.mem_no, m.mem_name, d.deal_no, d.mem_no from member m, deal d where d.mem_no = m.mem_no and m.mem_no = 2
            SELECT d_date FROM (SELECT d_date, rownum FROM deal ORDER BY d_date ) WHERE rownum=1
            
select deal_no, mem_no, pr_no from deal -- mem_no = 2, 6
            
 DEAL_NO MEM_NO PR_NO
 ------- ------ -----
       1      2     1
       2      2     1
       3      2     1
       4      2     1
       5      2     1
       6      6     3
       7      6     3
       
SELECT d.deal_no, d.d_date, d.mem_no as buyer_no,
      (SELECT distinct m.mem_name as buyer FROM member m, deal d WHERE d.mem_no = 2 AND m.mem_no = 2) as buyer,
       p.pr_no, p.mem_no as seller_no, 
      (SELECT distinct m.mem_name as seller FROM member m, product p WHERE p.mem_no = m.mem_no) as seller
FROM product p, deal d, member m
WHERE p.pr_no = d.pr_no 
and m.mem_no = 2

select * from deal

SELECT m.mem_no, m.mem_name as buyer, d.deal_no, d.mem_no, d.pr_no
FROM member m, deal d 
WHERE d.mem_no = m.mem_no AND m.mem_no = 6

       
            
select * from product  -- mem_no = 1
            
 PR_NO GORY_NO MEM_NO PR_TITLE                PR_CONTENTS PR_THUMBS PR_FILES PR_SIZES PR_CNT PR_RDATE              PR_BUYYEAR            PR_STATE PR_TRANSACTION PR_LOCAL PR_BUYPRICE PR_PRICE PR_VISIBLE PR_PAYMENT
 ----- ------- ------ ----------------------- ----------- --------- -------- -------- ------ --------------------- --------------------- -------- -------------- -------- ----------- -------- ---------- ----------
     1       1      1 [삼성전자]PEN NT930QAA-K28A 크리스마스에 갔던곳  NULL      NULL     NULL          0 2018-07-17 16:13:37.0 2017-01-01 00:00:00.0 중고       직거래            서울/종각           1000      800 Y          N
     2       1      1 그램                      크리스마스에 갔던곳  NULL      NULL     NULL          0 2018-07-17 18:31:39.0 2017-01-01 00:00:00.0 중고       직거래            서울/종각           1000    80000 Y          N
     3       1      1 [삼성전자]PEN NT930QAA-K28A 크리스마스에 갔던곳  NULL      NULL     NULL          0 2018-07-20 17:21:24.0 2017-01-01 00:00:00.0 중고       직거래            서울/종각           1000      800 Y          N

     
select mem_no from member -- mem_no = 1 ~ 6
select ship_no, mem_no from shipping -- mem_no = 2    
select pay_no, mem_no from payment -- mem_no = 2
            
            
SELECT B.*
FROM(
    SELECT rownum as r, A.* 
    FROM (
        SELECT p.pr_no, p.pr_title, p.pr_price, p.pr_rdate, p.mem_no as seller_no, 
              (SELECT distinct m.mem_name as seller FROM member m, product p WHERE p.mem_no = m.mem_no) as seller,
              d.deal_no, d.d_state, d.d_way, d.d_check, d.d_date, d.mem_no as buyer_no,
              (SELECT distinct m.mem_name as buyer FROM member m, deal d WHERE d.mem_no = m.mem_no AND m.mem_no = 2) as buyer
        FROM product p, deal d
        --WHERE p.pr_no = d.pr_no
          WHERE p.pr_no = d.pr_no AND d.d_date BETWEEN (SELECT d_date FROM (SELECT d_date, rownum FROM deal ORDER BY d_date ) WHERE rownum=1) AND to_date('180717', 'YYMMDD') + 1
        --WHERE p.pr_no = d.pr_no AND d.d_date BETWEEN to_date('180716', 'YYMMDD') AND to_date('180717', 'YYMMDD') + 1
        --WHERE p.pr_no = d.pr_no AND d.d_date BETWEEN to_date('180717', 'YYMMDD') AND SYSDATE
	            AND (d.d_state LIKE '%구%' 
	            OR d.d_way LIKE '%구%' 
	            OR d.d_check LIKE '%구%' 
	            OR p.pr_title LIKE '%구%' 
	            OR p.pr_price LIKE '%구%' 
	            OR (SELECT distinct m.mem_name FROM member m, deal d WHERE d.mem_no = m.mem_no AND m.mem_no = 2) LIKE '%구%' 
	            OR (SELECT distinct m.mem_name FROM member m, product p WHERE p.mem_no = m.mem_no) LIKE '%구%') 
        ORDER BY d.deal_no
        ) A
    ) B

    
SELECT p.pr_no, p.pr_title, p.pr_price, p.pr_rdate, p.mem_no as seller_no,
                (SELECT distinct m.mem_name FROM member m, product p WHERE p.mem_no = m.mem_no) AS seller,
                d.deal_no, d.d_state, d.d_way, d.d_check, d.d_date, d.mem_no as buyer_no,
                (SELECT distinct m.mem_name FROM member m, deal d WHERE d.mem_no = m.mem_no and m.mem_no = 3) AS buyer
            FROM product p, deal d
            WHERE p.pr_no = d.pr_no    
    
    