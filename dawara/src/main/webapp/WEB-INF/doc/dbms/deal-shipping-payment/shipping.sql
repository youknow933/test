
DROP TABLE shipping;
    
/**********************************/
/* Table Name: 상품 택배거래 */
/**********************************/
CREATE TABLE shipping(
    ship_no           NUMBER(10)                NOT NULL PRIMARY KEY,
    ship_zipcode      VARCHAR2(5)               NOT NULL,
    ship_addr1        VARCHAR2(80)              NOT NULL,
    ship_addr2        VARCHAR2(50)              NOT NULL,
    ship_rname        VARCHAR2(20)              NOT NULL,
    ship_rtel         VARCHAR2(14)              NOT NULL,
    ship_memo         VARCHAR2(100)             NULL,
    ship_date         DATE                      NOT NULL,
    ship_check        CHAR(1)       DEFAULT 'N' NOT NULL,
    PR_NO             NUMBER(7)                 NOT NULL,
    MEM_NO            NUMBER(6)                 NULL,
  FOREIGN KEY (PR_NO) REFERENCES product (PR_NO),
  FOREIGN KEY (MEM_NO) REFERENCES member (MEM_NO)
);

-- ALTER TABLE shipping ADD CONSTRAINT ship_no PRIMARY KEY (ship_no);

COMMENT ON TABLE shipping is '상품 택배거래';
COMMENT ON COLUMN shipping.ship_no is '배송번호';
COMMENT ON COLUMN shipping.ship_zipcode is '우편번호';
COMMENT ON COLUMN shipping.ship_addr1 is '배송지1';
COMMENT ON COLUMN shipping.ship_addr2 is '배송지2';
COMMENT ON COLUMN shipping.ship_rname is '받는 사람';
COMMENT ON COLUMN shipping.ship_rtel is '받는 사람 연락처';
COMMENT ON COLUMN shipping.ship_memo is '배송시 요청사항';
COMMENT ON COLUMN shipping.ship_date is '택배거래등록일';
COMMENT ON COLUMN shipping.ship_check is '발송확인';
COMMENT ON COLUMN shipping.PR_NO is '상품 번호';
COMMENT ON COLUMN shipping.MEM_NO is '회원 번호';

SELECT ship_no, ship_zipcode, ship_addr1, ship_addr2, ship_rname, ship_rtel, ship_memo, ship_date, ship_check, pr_no, mem_no
FROM shipping;

DELETE FROM shipping;

------------------------------------------------------------------------------------------------------------------------------------------------------
1) 거래 한 건 최초 등록
------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO shipping(SHIP_NO, 
                     SHIP_ZIPCODE, SHIP_ADDR1, SHIP_ADDR2, SHIP_RNAME, SHIP_RTEL, SHIP_MEMO, SHIP_DATE, PR_NO, MEM_NO)
VALUES ((SELECT nvl(MAX(SHIP_NO), 0) + 1 as SHIP_NO FROM shipping),
                      '00001', '서울 종로구 ...', '코아빌딩 20-3', '받는사람1', '010-0101-0101', '배송 전 연락주세요1', SYSDATE, 1, 2);

INSERT INTO shipping(SHIP_NO, 
                     SHIP_ZIPCODE, SHIP_ADDR1, SHIP_ADDR2, SHIP_RNAME, SHIP_RTEL, SHIP_MEMO, SHIP_DATE, PR_NO, MEM_NO)
VALUES ((SELECT nvl(MAX(SHIP_NO), 0) + 1 as SHIP_NO FROM shipping),
                      '00002', '서울 서대문구 ...', '북아현 20-3', '받는사람2', '010-0202-0202', '배송 전 연락주세요2', SYSDATE, 2, 2);

INSERT INTO shipping(SHIP_NO, 
                     SHIP_ZIPCODE, SHIP_ADDR1, SHIP_ADDR2, SHIP_RNAME, SHIP_RTEL, SHIP_MEMO, SHIP_DATE, PR_NO, MEM_NO)
VALUES ((SELECT nvl(MAX(SHIP_NO), 0) + 1 as SHIP_NO FROM shipping),
                      '00003', '서울 관악구 ...', '관악산 20-3', '받는사람3', '010-0000-0003', '배송 전 연락주세요3', SYSDATE, 1, 2);

INSERT INTO shipping(SHIP_NO, 
                     SHIP_ZIPCODE, SHIP_ADDR1, SHIP_ADDR2, SHIP_RNAME, SHIP_RTEL, SHIP_MEMO, SHIP_DATE, PR_NO, MEM_NO)
VALUES ((SELECT nvl(MAX(SHIP_NO), 0) + 1 as SHIP_NO FROM shipping),
                      '00004', '서울 용산구 ...', '용산 20-3', '받는사람4', '010-0000-0004', '배송 전 연락주세요4', SYSDATE, 2, 2);


--------------------------------------------------------------------------------------------------------------------------------------------------------
2) 목록
--------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT * FROM shipping;

-- 1번 상품 판매자의 상품과 판매자 정보
-- Product_MemberVO 조인
SELECT p.pr_no, p.pr_title, p.pr_buyyear, p.pr_state, p.pr_buyprice, p.pr_price,
	      m.mem_no as "pr_mem_no", m.mem_name as "pr_mem_name", m.mem_tel as	"pr_mem_tel",
				m.mem_zipcode as "pr_mem_zipcode", m.mem_addr1 as "pr_mem_addr1", m.mem_addr2 as "pr_mem_addr2"
FROM product p, member m
WHERE p.pr_no = 1 and p.mem_no = m.mem_no

SELECT p.pr_no,
       m.mem_no as pr_mem_no, 
       m.mem_name as pr_mem_name, 
       m.mem_tel as pr_mem_tel, 
       m.mem_mail as pr_mem_mail,
       m.mem_zipcode as pr_mem_zipcode, 
       m.mem_addr1 as pr_mem_addr1, 
       m.mem_addr2 as pr_mem_addr2
FROM product p, member m
WHERE p.mem_no = m.mem_no and p.pr_no = 1

select * from member;
select * from product;

 PR_NO PR_TITLE PR_BUYYEAR            PR_STATE PR_BUYPRICE PR_PRICE pr_mem_no pr_mem_name pr_mem_tel  pr_mem_zipcode pr_mem_addr1 pr_mem_addr2
 ----- -------- --------------------- -------- ----------- -------- --------- ----------- ----------- -------------- ------------ ------------
     1 제목     2017-01-01 00:00:00.0 중고            1000     1000         1 SCH         01022220000 00001          서울 종로구 ...   코아빌딩 20-3
     
-- 전체 목록
SELECT SHIP_NO, SHIP_ZIPCODE, SHIP_ADDR1, SHIP_ADDR2, SHIP_RNAME, SHIP_RTEL, SHIP_MEMO, SHIP_DATE, SHIP_CHECK, PR_NO, MEM_NO
FROM shipping;

 SHIP_NO SHIP_ZIPCODE SHIP_ADDR1  SHIP_ADDR2 SHIP_RNAME SHIP_RTEL     SHIP_MEMO   SHIP_DATE             SHIP_CHECK PR_NO MEM_NO
 ------- ------------ ----------- ---------- ---------- ------------- ----------- --------------------- ---------- ----- ------
       1 00001        서울 종로구 ...  코아빌딩 20-3  받는사람1      010-0101-0101 배송 전 연락주세요1 2018-07-10 16:30:54.0 N              1      2
       2 00002        서울 서대문구 ... 북아현 20-3   받는사람2      010-0202-0202 배송 전 연락주세요2 2018-07-10 16:30:55.0 N              2      2
       3 00003        서울 관악구 ...  관악산 20-3   받는사람3      010-0000-0003 배송 전 연락주세요3 2018-07-10 16:30:56.0 N              3      2

       
SELECT SHIP_NO, SHIP_ZIPCODE, SHIP_DATE      
FROM shipping
WHERE ship_date = 
ORDER BY ship_date desc;
       
       
---------------------------------------------------------------------------------------------------
3) 수정
---------------------------------------------------------------------------------------------------
UPDATE shipping
SET ship_zipcode = #{ship_zipcode}, ship_addr1 = #{ship_addr1}, ship_addr2 = #{ship_addr2}, 
    ship_rtel = #{ship_rtel}, ship_memo = #{ship_memo}, ship_check = #{ship_memo}
WHERE ship_no = 2

-- 받는사람 연락처 수정
UPDATE shipping
SET ship_rtel = '010-2222-2222'
WHERE ship_no = 2

---------------------------------------------------------------------------------------------------
4) 삭제
---------------------------------------------------------------------------------------------------
-- 택배거래 한건 삭제
DELETE FROM shipping
WHERE ship_no = 1

---------------------------------------------------------------------------------------------------
5) 검색
---------------------------------------------------------------------------------------------------
-- 지역
	-- 2번 회원의 서울에 배송된 택배거래 내역
	SELECT concat('(' || ship_zipcode || ') ', concat(ship_addr1 || ' ', ship_addr2)) ship_address
	FROM shipping
	WHERE mem_no = 2 and concat('(' || ship_zipcode || ') ', concat(ship_addr1 || ' ', ship_addr2)) LIKE '%서울%'
	
-- 연락처 검색
	-- 전체 번호 검색
	SELECT ship_rtel
	FROM shipping
	WHERE ship_rtel = '010-3333-0000'
	
	 SHIP_RTEL
	 -------------
	 010-3333-0000
	 
	-- 연락처 뒷자리 4자리가 0000인 택배거래 목록
	SELECT ship_rtel
	FROM shipping
	WHERE substr(ship_rtel, 10, 5) = '0000' 
	
	 SHIP_RTEL
	 -------------
	 010-3333-0000

-- 등록일 검색
	-- 7월달에 등록한 택배거래 목록
	SELECT ship_date 
	from shipping
	where substr(ship_date, 4, 2) = 07;
	
	 SHIP_DATE
	 ---------------------
	 2018-07-13 10:21:12.0

	-- 2018년에 등록한 택배거래 목록
	SELECT ship_date 
	from shipping
	where substr(ship_date, 1, 2) = 18;
	
	 SHIP_DATE
	 ---------------------
	 2018-07-13 10:21:12.0

-- 발송여부
-- 받는사람

    SELECT ship_no, ship_zipcode, ship_addr1, ship_addr2, ship_rname, ship_rtel, 
           ship_memo, ship_date, ship_check, pr_no, mem_no
    FROM shipping
        WHERE mem_no=2 AND ship_check LIKE '%N%' 
        
SELECT ship_no, ship_zipcode, ship_addr1, ship_addr2, ship_rname, ship_rtel, 
       ship_memo, substr(ship_date,0,8), ship_check, pr_no, mem_no
FROM shipping
WHERE mem_no=2 AND substr(ship_date,0,8) LIKE '%07%' 

    SELECT ship_no, ship_zipcode, ship_addr1, ship_addr2, ship_rname, ship_rtel, 
           ship_memo, ship_date, ship_check, pr_no, mem_no
    FROM shipping
    WHERE mem_no=2 AND concat(ship_zipcode, concat(ship_addr1, ship_addr2)) LIKE '%북아현%' 
    
    SELECT COUNT(*) as cnt
    FROM shipping
    WHERE mem_no=2 AND concat(ship_zipcode, concat(ship_addr1, ship_addr2)) LIKE '%북아현%' 

    
    SELECT ship_no, ship_zipcode, ship_addr1, ship_addr2, ship_rname, ship_rtel, 
           ship_memo, ship_date, ship_check, pr_no, mem_no
    FROM shipping
    WHERE mem_no=2 AND concat(ship_zipcode, concat(ship_addr1, ship_addr2)) LIKE '%아%'
    
    
    SELECT ship_no, ship_zipcode, ship_addr1, ship_addr2, ship_rname, ship_rtel, 
           ship_memo, ship_date, ship_check, pr_no, mem_no
    FROM shipping
    WHERE mem_no=2
    AND concat(ship_zipcode, concat(ship_addr1, ship_addr2)) LIKE '%아%' 
    OR ship_rname LIKE '%아%' 
    OR ship_rtel LIKE '%아%' 
    OR ship_date LIKE '%아%' 
    OR ship_check LIKE '%아%' 
    
    
    

---------------------------------------------------------------------------------------------------
6) 검색및 전체 레코드 갯수
---------------------------------------------------------------------------------------------------

SELECT COUNT(*) as cnt
FROM shipping
WHERE mem_no = 2 AND concat('(' || ship_zipcode || ') ', concat(ship_addr1 || ' ', ship_addr2)) LIKE '%서울%' <!-- 주소를 검색하는 경우 --> 

 CNT
 ---
   1   
   
SELECT COUNT(*) as cnt
FROM deal
WHERE mem_no=2 AND concat(ship_zipcode, concat(ship_addr1, ship_addr2)) LIKE '%서울%';
---------------------------------------------------------------------------------------------------
7) 페이징
---------------------------------------------------------------------------------------------------

SELECT B.*, r
FROM(
    SELECT A.*, rownum as r
    FROM (
        SELECT ship_no, ship_zipcode, ship_addr1, ship_addr2, ship_rname, ship_rtel, 
              ship_memo, ship_date, ship_check, pr_no, mem_no
        FROM shipping
            WHERE mem_no = 2 
            AND concat(ship_zipcode, concat(ship_addr1, ship_addr2)) LIKE '%아%' 
					    OR ship_rname LIKE '%아%' 
					    OR ship_rtel LIKE '%아%' 
					    OR ship_date LIKE '%아%' 
					    OR ship_check LIKE '%아%' 
        ORDER BY ship_no
        ) A
    ) B
WHERE r >= 1 AND r <= 5
    
 SHIP_NO SHIP_ZIPCODE SHIP_ADDR1                SHIP_ADDR2 SHIP_RNAME SHIP_RTEL     SHIP_MEMO   SHIP_DATE             SHIP_CHECK PR_NO MEM_NO R R
 ------- ------------ ------------------------- ---------- ---------- ------------- ----------- --------------------- ---------- ----- ------ - -
       1 00001        서울 종로구 ...                코아빌딩 20-3  받는사람1      010-0101-0101 배송 전 연락주세요1 2018-07-16 06:35:12.0 N              1      2 1 1
       2 63275        제주특별자치도 제주시 가령골길 1 (일도2동) 관철동        아로미        000-0000-0000 배송 전 연락주세요2 2018-07-16 06:35:13.0 N              2      2 2 2
       4 44648        울산 남구 거마로 5 (옥동)          관철동        아로미        000-0000-0000 배송 전 연락주세요3 2018-07-16 06:35:37.0 N              1      2 3 3

SELECT B.*, r
FROM(
    SELECT A.*, rownum as r
    FROM (
        SELECT ship_no, ship_zipcode, ship_addr1, ship_addr2, ship_rname, ship_rtel, 
              ship_memo, ship_date, ship_check, pr_no, mem_no
        FROM shipping
            WHERE mem_no = 2 
            AND concat(ship_zipcode, concat(ship_addr1, ship_addr2)) LIKE '%아%' 
              OR ship_rname LIKE '%아%' 
              OR ship_rtel LIKE '%아%' 
              OR ship_date LIKE '%아%' 
              OR ship_check LIKE '%아%' 
        ORDER BY ship_no
        ) A
    ) B
WHERE r >= 1 AND r <= 5    

 SHIP_NO SHIP_ZIPCODE SHIP_ADDR1                     SHIP_ADDR2 SHIP_RNAME SHIP_RTEL     SHIP_MEMO   SHIP_DATE             SHIP_CHECK PR_NO MEM_NO R R
 ------- ------------ ------------------------------ ---------- ---------- ------------- ----------- --------------------- ---------- ----- ------ - -
       1 00001        서울 종로구 ...                     코아빌딩 20-3  받는사람1      010-0101-0101 배송 전 연락주세요1 2018-07-16 06:35:12.0 N              1      2 1 1
       2 63275        제주특별자치도 제주시 가령골길 1 (일도2동)      관철동        아로미        000-0000-0000 배송 전 연락주세요2 2018-07-16 06:35:13.0 N              2      2 2 2
       4 44648        울산 남구 거마로 5 (옥동)               관철동        아로미        000-0000-0000 배송 전 연락주세요3 2018-07-16 06:35:37.0 N              1      2 3 3
       5 48060        부산 해운대구 APEC로 17 (우동, 센텀리더스마크) 관철동        아로미        000-0000-0000 NULL        2018-07-16 09:40:30.0 N              2      2 4 4
       6 12345        서울시 종로구                        관철동        아로미        000-0000-0000 NULL        2018-07-17 14:07:04.0 N              2      2 5 5

---------------------------------------------------------------------------------------------------




