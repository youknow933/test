상품 +-- 등록(+사진)
       +-- 게시글 전체 목록
       +-- 카테고리별 목록
       +-- 전체 레코드 갯수
       +-- 한건의 레코드 조회
       +-- 조회수
       +-- 수정
       +-- 삭제
       +-- 검색(최신순, 가격, 생성일자, 메이커)
       +-- category별 검색
       +-- 거래신청 
              +-- 거래 연결
       +-- 페이징
       +-- 판매완료(pr_visible)
       
/**********************************/
/* Table Name: product 내용 */
/**********************************/

-- product만들기
CREATE TABLE product (
        pr_no          NUMBER(7)        NOT NULL        PRIMARY KEY,
        gory_no         NUMBER(7)        NULL ,
        mem_no                  NUMBER(6)        NULL ,
        pr_title                   VARCHAR2(300)        NOT NULL,
        pr_contents        CLOB               null,
        pr_thumbs              VARCHAR2(1000)                             NULL ,
        pr_files                   VARCHAR2(1000)                            NULL ,
        pr_sizes                  VARCHAR2(1000)                            NULL ,
        pr_cnt                    NUMBER(7)        DEFAULT 0       NOT NULL,
        pr_rdate                  DATE                                      NOT NULL,
        pr_buyyear                  DATE                                           NULL,
        pr_state      VARCHAR2(1000)        DEFAULT '중고'       NULL ,       --'신제품', '중고'
        pr_transaction      VARCHAR2(1000)        DEFAULT '직거래'       NULL ,  --'직거래', '택배'
        pr_local      VARCHAR2(1000)             NULL ,
        pr_buyprice                  NUMBER(10)      DEFAULT 0       NOT NULL,
        pr_price                  NUMBER(10)      DEFAULT 0       NOT NULL,
        pr_visible                 CHAR(1)            DEFAULT 'Y'      NOT NULL,     
        pr_payment                 CHAR(1)            DEFAULT 'N'      NOT NULL,     --N(no), Y(yes), I(ing)
  FOREIGN KEY (gory_no) REFERENCES category (gory_no),
  FOREIGN KEY (mem_no) REFERENCES member (mem_no)
);

ALTER TABLE MEMBER ADD mem_mile NUMBER(9); --mem_mile 컬럼 추가
ALTER TABLE PRODUCT ADD pr_contents CLOB  null; --mem_mile 컬럼 추가
ALTER TABLE PRODUCT ADD pr_prname  VARCHAR2(300) NULL; --mem_mile 컬럼 추가
ALTER TABLE PRODUCT ADD pr_maker  VARCHAR2(300)  DEFAULT'삼성' NOT NULL; --mem_mile 컬럼 추가
ALTER TABLE MEMBER RENAME COLUMN mem_rdate TO mem_date;
ALTER TABLE MEMBER RENAME COLUMN authno TO auth_no;
ALTER TABLE PRODUCT RENAME COLUMN pr_buyyear TO pr_buyyear;
ALTER TABLE MEMBER DROP COLUMN MEM_ACT;
ALTER TABLE PRODUCT DROP COLUMN pr_contents;
ALTER TABLE PRODUCT DROP COLUMN pr_maker;
ALTER TABLE PRODUCT ADD pr_buyprice  NUMBER(10)      DEFAULT 0       NOT NULL;


DROP TABLE product; 

  
COMMENT ON TABLE product is '상품';
COMMENT ON COLUMN product.pr_no is '상품 번호';
COMMENT ON COLUMN product.gory_no is '카테고리번호';
COMMENT ON COLUMN product.mem_no is '회원 번호';
COMMENT ON COLUMN product.pr_title is '제목';
COMMENT ON COLUMN product.pr_contents is '내용';
COMMENT ON COLUMN product.pr_thumbs is 'thumbs 파일';
COMMENT ON COLUMN product.pr_files is '파일들의 이름';
COMMENT ON COLUMN product.pr_sizes is '파일들의 크기';
COMMENT ON COLUMN product.pr_cnt is '조회수';
COMMENT ON COLUMN product.pr_buyyear is '구입 시기';
COMMENT ON COLUMN product.pr_rdate is '등록일';
COMMENT ON COLUMN product.pr_state is '제품 상태';
COMMENT ON COLUMN product.pr_transaction is '거래 방식';
COMMENT ON COLUMN product.pr_local is '거래 지역';
COMMENT ON COLUMN product.pr_buyprice is '구입 가격';
COMMENT ON COLUMN product.pr_price is '판매 가격';
COMMENT ON COLUMN product.pr_visible is '출력 여부';
COMMENT ON COLUMN product.pr_payment is '결제';


1) 카테고리(category) 참조 테이블 설정
-- 카테고리 테이블을 FK 컬럼으로 참조함으로 임시로 제작합니다.
-- 테이블명, PK 컬럼명은 설계시 지정된 것을 사용합니다.
INSERT INTO category(gory_no) VALUES(1);
INSERT INTO category(gory_no) VALUES(2);
INSERT INTO category(gory_no) VALUES(3);

2) 회원(category) 참조 테이블 설정
-- 회원 테이블을 FK 컬럼으로 참조함으로 임시로 제작합니다.
-- 테이블명, PK 컬럼명은 설계시 지정된 것을 사용합니다.
INSERT INTO member(mem_no) VALUES(1);
INSERT INTO member(mem_no) VALUES(2);
INSERT INTO member(mem_no) VALUES(3);

3) product 등록             
-- product 새글 등록
- 새로운 글, 답변 글에따라 등록 SQL차이가 있습니다.
- 새로운 글 등록은 새로운 그룹이 만들어지는 기능이 있습니다. MAX + 1
- gory_no 컬럼 1번 기준
- mem_no 컬럼 1번 기준

INSERT INTO product(pr_no, 
                  gory_no, mem_no, pr_title, pr_contents,  pr_thumbs, pr_files,
                  pr_sizes, pr_cnt,  pr_buyyear, pr_rdate, pr_state, pr_transaction, pr_local,  
                  pr_buyprice, pr_price, pr_visible, pr_payment)  
VALUES((SELECT NVL(MAX(pr_no), 0) + 1 as pr_no FROM product), 
            1, 1, '제목', '내용', 'summber_m.jpg', 'summber.jpg',
            0, 0, '2017-01-01', sysdate, '중고', '직거래', '서울',
            1000 , 1000, 'Y', 'N');        

       
            
4) 전체 목록(댓글 구현)

select * from product;


SELECT pr_no, 
           gory_no, mem_no,  pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, 
           pr_cnt,  pr_buyyear, pr_rdate, pr_state, pr_transaction, pr_local,  
           pr_buyprice, pr_price,  pr_visible, pr_payment
FROM product;

 PR_NO GORY_NO MEM_NO PR_TITLE PR_CONTENTS PR_THUMBS     PR_FILES    PR_SIZES PR_CNT PR_BUYYEAR            PR_RDATE              PR_STATE PR_TRANSACTION PR_LOCAL PR_BUYPRICE PR_PRICE PR_VISIBLE PR_PAYMENT
 ----- ------- ------ -------- ----------- ------------- ----------- -------- ------ --------------------- --------------------- -------- -------------- -------- ----------- -------- ---------- ----------
     1       1      1 제목       내용          summber_m.jpg summber.jpg 0             0 2017-01-01 00:00:00.0 2018-06-26 17:45:13.0 중고       직거래            서울              1000     1000 Y          N

     
SELECT pr_no, 
           gory_no, mem_no,  pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt,  pr_buyyear, pr_rdate, pr_state, pr_transaction, pr_local,  
           pr_buyprice, pr_price,  pr_visible, pr_payment
FROM product
WHERE pr_no = 1;

5) category 별 목록(댓글 구현)
SELECT pr_no, 
           gory_no, mem_no,  pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt,  pr_buyyear, pr_rdate, pr_state, pr_transaction, pr_local,  
           pr_buyprice, pr_price,  pr_visible, pr_payment
FROM product
WHERE gory_no=1
ORDER BY pr_no;

 PR_NO GORY_NO MEM_NO PR_TITLE PR_CONTENTS PR_THUMBS     PR_FILES    PR_SIZES PR_CNT PR_BUYYEAR            PR_RDATE              PR_STATE PR_TRANSACTION PR_LOCAL PR_BUYPRICE PR_PRICE PR_VISIBLE PR_PAYMENT
 ----- ------- ------ -------- ----------- ------------- ----------- -------- ------ --------------------- --------------------- -------- -------------- -------- ----------- -------- ---------- ----------
     1       1      1 제목       내용          summber_m.jpg summber.jpg 0             0 2017-01-01 00:00:00.0 2018-06-26 17:45:13.0 중고       직거래            서울              1000     1000 Y          N

6) 전체 카운트
SELECT COUNT(*) as count
FROM product;      

 COUNT
 -----
     1
     
7)조회
SELECT pr_no, 
           gory_no, mem_no,  pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt, 
           pr_buyyear, pr_rdate, pr_state, pr_transaction, pr_local,  
           pr_buyprice, pr_price,  pr_visible, pr_payment
FROM product
WHERE pr_no=1

 PR_NO GORY_NO MEM_NO PR_TITLE PR_CONTENTS PR_THUMBS     PR_FILES    PR_SIZES PR_CNT PR_BUYYEAR            PR_RDATE              PR_STATE PR_TRANSACTION PR_LOCAL PR_BUYPRICE PR_PRICE PR_VISIBLE PR_PAYMENT
 ----- ------- ------ -------- ----------- ------------- ----------- -------- ------ --------------------- --------------------- -------- -------------- -------- ----------- -------- ---------- ----------
     1       1      1 제목       내용          summber_m.jpg summber.jpg 0             0 2017-01-01 00:00:00.0 2018-06-26 17:45:13.0 중고       직거래            서울              1000     1000 Y          N

8)수정
UPDATE product
SET pr_title='겨울', pr_contents='손이시려워...',
     pr_thumbs='snow_t.jpg', pr_files='snow.jpg', pr_sizes=1500, pr_buyyear= '2017-01-01',
     pr_price=1500, pr_transaction = '택배', pr_local='서울/종각'
WHERE pr_no=1;

  UPDATE product
    SET pr_title=#{pr_title}, pr_contents=#{pr_contents:VARCHAR},
          pr_thumbs=#{pr_thumbs}, files=#{files}, pr_sizes=#{sizes},  pr_buyyear=#{pr_buyyear}, 
            pr_price=#{pr_price}, pr_transaction = #{pr_transaction}, pr_local=#{pr_local}
    WHERE pr_no=#{pr_no}

9) 삭제
DELETE FROM product
WHERE pr_no=1

select * from product
where mem_no=2 and pr_visible='N'

delete from reply
10) 검색(%: 없거나 하나 이상의 모든 문자)
-- pr_word LIKE '스프링' → pr_word = '스프링'
   ^스프링$
-- pr_word LIKE '%스프링' → pr_word = '잊지 못할 스프링'
   .*스프링$
-- pr_word LIKE '스프링%' → pr_word = '스프링에서~'
   ^스프링.*
-- pr_title LIKE '%겨울%' → pr_word = '유럽 여행은 스프링 꼭 방문해야~'
   .*스프링.*
   
   -- '스프링' 컬럼으로 검색
SELECT pr_no, 
           gory_no, mem_no,  pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt, 
           pr_buyyear, pr_rdate, pr_state, pr_transaction, pr_local,  
           pr_buyprice, pr_price,  pr_visible, pr_payment
 FROM product
WHERE gory_no=1 AND pr_title LIKE '%겨울%'
ORDER BY pr_no DESC;

 PR_NO GORY_NO MEM_NO PR_TITLE PR_CONTENTS PR_THUMBS  PR_FILES PR_SIZES PR_CNT PR_BUYYEAR            PR_RDATE              PR_STATE PR_TRANSACTION PR_LOCAL PR_BUYPRICE PR_PRICE PR_VISIBLE PR_PAYMENT
 ----- ------- ------ -------- ----------- ---------- -------- -------- ------ --------------------- --------------------- -------- -------------- -------- ----------- -------- ---------- ----------
     1       1      1 겨울       손이시려워...    snow_t.jpg snow.jpg 1500          0 2017-01-01 00:00:00.0 2018-06-26 17:45:13.0 중고       택배             서울              1000     1500 Y          N


11) 검색 및 전체 레코드 갯수
-- gory_no 컬럼이 1번이며 검색하지 않는 경우 레코드 갯수
SELECT COUNT(*) as pr_cnt
FROM product
WHERE gory_no=1;

 PR_CNT
 ------
      1



-- '스프링' 검색 레코드 갯수
SELECT COUNT(*) as pr_cnt
FROM product
WHERE  gory_no=1 AND pr_title LIKE '%겨울%';

 PR_CNT
 ------
      1
      
SELECT COUNT(*) as pr_cnt
 FROM product
        WHERE gory_no=1 AND pr_title LIKE '%겨울%';
        
 PR_CNT
 ------
      1


      
SELECT pr_no, 
           gory_no, mem_no,  pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt, 
           pr_buyyear, pr_rdate, pr_state, pr_transaction, pr_local,  
           pr_buyprice, pr_price,  pr_visible, pr_payment
      
      

12)페이징
SELECT pr_no, 
           gory_no, mem_no,  pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt, 
           pr_buyyear, pr_rdate, pr_state, pr_transaction, pr_local,  
           pr_buyprice, pr_price,  pr_visible, pr_payment, r
FROM(
       SELECT pr_no, 
           gory_no, mem_no,  pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt, 
           pr_buyyear, pr_rdate, pr_state, pr_transaction, pr_local,  
           pr_buyprice, pr_price,  pr_visible, pr_payment, rownum as r
         FROM(
                  SELECT pr_no, 
                  gory_no, mem_no,  pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt, 
                  pr_buyyear, pr_rdate, pr_state, pr_transaction, pr_local,  
                  pr_buyprice, pr_price,  pr_visible, pr_payment
                  FROM product
                  WHERE gory_no=1
                  ORDER BY pr_no DESC
         )
)
WHERE r >=1 AND r <= 3;

 PR_NO GORY_NO MEM_NO PR_TITLE PR_CONTENTS PR_THUMBS  PR_FILES PR_SIZES PR_CNT PR_BUYYEAR            PR_RDATE              PR_STATE PR_TRANSACTION PR_LOCAL PR_BUYPRICE PR_PRICE PR_VISIBLE PR_PAYMENT R
 ----- ------- ------ -------- ----------- ---------- -------- -------- ------ --------------------- --------------------- -------- -------------- -------- ----------- -------- ---------- ---------- -
     1       1      1 겨울       손이시려워...    snow_t.jpg snow.jpg 1500          0 2017-01-01 00:00:00.0 2018-06-26 17:45:13.0 중고       택배             서울              1000     1500 Y          N          1


-- 검색        
SELECT pr_no, 
           gory_no, mem_no,  pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt, 
           pr_buyyear, pr_rdate, pr_state, pr_transaction, pr_local,  
           pr_buyprice, pr_price,  pr_visible, pr_payment, r
FROM(
       SELECT pr_no, 
           gory_no, mem_no,  pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt, 
           pr_buyyear, pr_rdate, pr_state, pr_transaction, pr_local,  
           pr_buyprice, pr_price,  pr_visible, pr_payment, rownum as r
         FROM(
                  SELECT pr_no, 
                  gory_no, mem_no,  pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt, 
                  pr_buyyear, pr_rdate, pr_state, pr_transaction, pr_local,  
                  pr_buyprice, pr_price,  pr_visible, pr_payment
                  FROM product
                  WHERE gory_no=1 AND pr_title LIKE '%삼성%' AND pr_visible='N'
                  ORDER BY pr_no DESC
         )
)
WHERE r >=1 AND r <= 3;

-- 멤버별 검색
SELECT pr_no, 
           gory_no, mem_no,  pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt, 
           pr_buyyear, pr_rdate, pr_state, pr_transaction, pr_local,  
           pr_buyprice, pr_price,  pr_visible, pr_payment, r
FROM(
       SELECT pr_no, 
           gory_no, mem_no,  pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt, 
           pr_buyyear, pr_rdate, pr_state, pr_transaction, pr_local,  
           pr_buyprice, pr_price,  pr_visible, pr_payment, rownum as r
         FROM(
                  SELECT pr_no, 
                  gory_no, mem_no,  pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt, 
                  pr_buyyear, pr_rdate, pr_state, pr_transaction, pr_local,  
                  pr_buyprice, pr_price,  pr_visible, pr_payment
                  FROM product
                  WHERE  mem_no=1 
                  ORDER BY pr_no DESC
         )
)
WHERE r >=1 AND r <= 3;


 PR_NO GORY_NO MEM_NO PR_TITLE PR_CONTENTS PR_THUMBS  PR_FILES PR_SIZES PR_CNT PR_BUYYEAR            PR_RDATE              PR_STATE PR_TRANSACTION PR_LOCAL PR_BUYPRICE PR_PRICE PR_VISIBLE PR_PAYMENT R
 ----- ------- ------ -------- ----------- ---------- -------- -------- ------ --------------------- --------------------- -------- -------------- -------- ----------- -------- ---------- ---------- -
     1       1      1 겨울       손이시려워...    snow_t.jpg snow.jpg 1500          0 2017-01-01 00:00:00.0 2018-06-26 17:45:13.0 중고       택배             서울              1000     1500 Y          N          1

      
13)판매완료(pr_visible)
UPDATE product
SET pr_visible='N'
WHERE pr_no=2;

SELECT pr_no, 
           gory_no, mem_no,  pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt, 
           pr_buyyear, pr_rdate, pr_state, pr_transaction, pr_local,  
           pr_buyprice, pr_price,  pr_visible, pr_payment
FROM product;

 PR_NO GORY_NO MEM_NO PR_TITLE PR_CONTENTS PR_THUMBS  PR_FILES PR_SIZES PR_CNT PR_BUYYEAR            PR_RDATE              PR_STATE PR_TRANSACTION PR_LOCAL PR_BUYPRICE PR_PRICE PR_VISIBLE PR_PAYMENT
 ----- ------- ------ -------- ----------- ---------- -------- -------- ------ --------------------- --------------------- -------- -------------- -------- ----------- -------- ---------- ----------
     1       1      1 겨울       손이시려워...    snow_t.jpg snow.jpg 1500          0 2017-01-01 00:00:00.0 2018-06-26 17:45:13.0 중고       택배             서울              1000     1500 N          Y

SELECT *
FROM product
WHERE pr_visible = 'N' AND MEM_NO=1;

            
     




       
