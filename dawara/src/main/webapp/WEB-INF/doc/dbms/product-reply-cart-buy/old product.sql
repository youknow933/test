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
       
CREATE TABLE category (
  gory_no       NUMBER(6) NOT NULL, -- 카테고리 번호, 레코드를 구분하는 컬럼 
  PRIMARY KEY (gory_no)                  -- 한번 등록된 값은 중복 안됨
);


COMMENT ON TABLE category is '카테고리';
COMMENT ON COLUMN category.gory_no is '카테고리번호 번호';

DROP TABLE category; -- 카테고리 삭제

CREATE TABLE member (
  mem_no       NUMBER(6) NOT NULL, -- 멤버 번호, 레코드를 구분하는 컬럼 
  PRIMARY KEY (mem_no)                  -- 한번 등록된 값은 중복 안됨
);

INSERT INTO member(mem_no)
VALUES((SELECT NVL(MAX(mem_no), 0) + 1 as mem_no FROM member));

COMMENT ON TABLE member is '회원';
COMMENT ON COLUMN member.mem_no is '회원 번호';

DROP TABLE member; --멤버 삭제

/**********************************/
/* Table Name: product 내용 */
/**********************************/

-- product만들기
CREATE TABLE product (
        pr_no          NUMBER(7)        NOT NULL        PRIMARY KEY,
        gory_no         NUMBER(7)        NULL ,
        mem_no                  NUMBER(6)        NULL ,
        pr_maker                VARCHAR2(300)  DEFAULT '삼성'        NULL,
        pr_prname                   VARCHAR2(300)        NULL,
        pr_title                   VARCHAR2(300)        NOT NULL,
        pr_contents        CLOB               null,
        pr_thumbs              VARCHAR2(1000)                             NULL ,
        pr_files                   VARCHAR2(1000)                            NULL ,
        pr_sizes                  VARCHAR2(1000)                            NULL ,
        pr_cnt                    NUMBER(7)        DEFAULT 0       NOT NULL,
        pr_rdate                  DATE                                      NOT NULL,
        pr_year                  DATE                                           NULL,
        pr_word                  VARCHAR2(100)                              NULL,
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
ALTER TABLE PRODUCT RENAME COLUMN pr_buyyear TO pr_year;
ALTER TABLE MEMBER DROP COLUMN MEM_ACT;
ALTER TABLE PRODUCT DROP COLUMN pr_contents;
ALTER TABLE PRODUCT DROP COLUMN pr_maker;
ALTER TABLE PRODUCT ADD pr_buyprice  NUMBER(10)      DEFAULT 0       NOT NULL;


DROP TABLE product; 

  
COMMENT ON TABLE product is '상품';
COMMENT ON COLUMN product.pr_no is '상품 번호';
COMMENT ON COLUMN product.gory_no is '카테고리번호';
COMMENT ON COLUMN product.mem_no is '회원 번호';
COMMENT ON COLUMN product.pr_maker is '브랜드명';
COMMENT ON COLUMN product.pr_prname, is '제품명';
COMMENT ON COLUMN product.pr_title is '제목';
COMMENT ON COLUMN product.pr_contents is '내용';
COMMENT ON COLUMN product.pr_thumbs is 'thumbs 파일';
COMMENT ON COLUMN product.pr_files is '파일들의 이름';
COMMENT ON COLUMN product.pr_sizes is '파일들의 크기';
COMMENT ON COLUMN product.pr_cnt is '조회수';
COMMENT ON COLUMN product.pr_year is '구입 시기';
COMMENT ON COLUMN product.pr_rdate is '등록일';
COMMENT ON COLUMN product.pr_word is '검색어';
COMMENT ON COLUMN product.pr_price is '가격';
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
                  gory_no, mem_no, pr_maker, pr_prname, pr_title, pr_contents,  pr_thumbs, pr_files,
                  pr_sizes, pr_cnt,  pr_year, pr_rdate, 
                  pr_word, pr_price, pr_visible, pr_payment)  
VALUES((SELECT NVL(MAX(pr_no), 0) + 1 as pr_no FROM product), 
            1, 1,'삼성', '삼성 노트북',  '제목', '내용', 'summber_m.jpg', 'summber.jpg',
            0, 0, '2017-01-01', sysdate,
            '스프링,spring,봄,春,계절,냉이,개나리', 1000, 'Y', 'N');        

       
            
4) 전체 목록(댓글 구현)

select * from product;


SELECT pr_no, 
           gory_no, mem_no, pr_maker, pr_prname, pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt,  pr_year, pr_rdate, 
           pr_word, pr_price,  pr_visible, pr_payment
FROM product;

 PR_NO GORY_NO MEM_NO PR_MAKER PR_PRNAME PR_TITLE PR_CONTENTS PR_THUMBS     PR_FILES    PR_SIZES PR_CNT PR_YEAR               PR_RDATE              PR_WORD                  PR_PRICE PR_VISIBLE PR_PAYMENT
 ----- ------- ------ -------- --------- -------- ----------- ------------- ----------- -------- ------ --------------------- --------------------- ------------------------ -------- ---------- ----------
     1       1      1 삼성       NULL      겨울       NULL        snow_t.jpg    snow.jpg    1500          0 2017-01-01 00:00:00.0 2018-06-18 12:58:01.0 휴가                           1000 Y          N
     2       1      1 삼성       NULL      제목       NULL        summber_m.jpg summber.jpg 0             0 2017-01-01 00:00:00.0 2018-06-18 13:03:57.0 스프링,spring,봄,春,계절,냉이,개나리     1000 N          Y
     3       1      1 삼성       삼성 노트북    제목       내용          summber_m.jpg summber.jpg 0             0 2017-01-01 00:00:00.0 2018-06-21 11:59:12.0 스프링,spring,봄,春,계절,냉이,개나리     1000 Y          N

     
SELECT pr_no, 
           gory_no, mem_no, pr_maker, pr_prname, pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt,  pr_year, pr_rdate, 
           pr_word, pr_price,  pr_visible, pr_payment
FROM product
WHERE pr_no = 1;

5) category 별 목록(댓글 구현)
SELECT pr_no,
           gory_no, mem_no, pr_maker, pr_prname, pr_title, pr_contents, pr_thumbs, pr_files, pr_sizes, pr_cnt,  pr_year, pr_rdate,  pr_word
FROM product
WHERE gory_no=1
ORDER BY pr_no;

 PR_NO GORY_NO MEM_NO PR_MAKER PR_TITLE PR_CONTENTS PR_THUMBS     PR_FILES    PR_SIZES PR_CNT PR_YEAR               PR_RDATE              PR_WORD
 ----- ------- ------ -------- -------- ----------- ------------- ----------- -------- ------ --------------------- --------------------- ------------------------
     1       1      1 삼성       제목       내용          summber_m.jpg summber.jpg 0             0 2017-01-01 00:00:00.0 2018-06-18 12:58:01.0 스프링,spring,봄,春,계절,냉이,개나리

6) 전체 카운트
SELECT COUNT(*) as count
FROM product;      

 COUNT
 -----
     1
     
7)조회
SELECT pr_no, 
           gory_no, mem_no, pr_maker, pr_prname, pr_title, pr_contents, pr_thumbs, pr_files, pr_sizes, pr_cnt,  pr_year, pr_rdate,  pr_word
FROM product
WHERE pr_no=1; 

 PR_NO GORY_NO MEM_NO PR_MAKER PR_TITLE PR_CONTENTS PR_THUMBS     PR_FILES    PR_SIZES PR_CNT PR_YEAR               PR_RDATE              PR_WORD
 ----- ------- ------ -------- -------- ----------- ------------- ----------- -------- ------ --------------------- --------------------- ------------------------
     1       1      1 삼성       제목       내용          summber_m.jpg summber.jpg 0             0 2017-01-01 00:00:00.0 2018-06-18 12:58:01.0 스프링,spring,봄,春,계절,냉이,개나리

8)수정
UPDATE product
SET pr_title='겨울', pr_contents='손이시려워...',
     pr_thumbs='snow_t.jpg', pr_files='snow.jpg', pr_sizes=1500, pr_word='휴가'
WHERE pr_no=1;

9) 삭제
DELETE FROM product
WHERE pr_no=1

10) 검색(%: 없거나 하나 이상의 모든 문자)
-- pr_word LIKE '스프링' → pr_word = '스프링'
   ^스프링$
-- pr_word LIKE '%스프링' → pr_word = '잊지 못할 스프링'
   .*스프링$
-- pr_word LIKE '스프링%' → pr_word = '스프링에서~'
   ^스프링.*
-- pr_word LIKE '%스프링%' → pr_word = '유럽 여행은 스프링 꼭 방문해야~'
   .*스프링.*
   
   -- '스프링' 컬럼으로 검색
SELECT pr_no, 
          gory_no, pr_maker, pr_prname, mem_no, pr_title, pr_thumbs, pr_files, pr_sizes, pr_cnt,  pr_year, pr_rdate, pr_word
FROM product
WHERE gory_no=1 AND pr_word LIKE '%스프링%'
ORDER BY pr_no DESC;

 PR_NO GORY_NO PR_MAKER MEM_NO PR_TITLE PR_THUMBS     PR_FILES    PR_SIZES PR_CNT PR_YEAR               PR_RDATE              PR_WORD
 ----- ------- -------- ------ -------- ------------- ----------- -------- ------ --------------------- --------------------- ------------------------
     2       1 삼성            1 제목       summber_m.jpg summber.jpg 0             0 2017-01-01 00:00:00.0 2018-06-18 13:03:57.0 스프링,spring,봄,春,계절,냉이,개나리


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
WHERE  gory_no=1 AND pr_word LIKE '%여행%';

 PR_CNT
 ------
      15
SELECT COUNT(*) as pr_cnt
 FROM product
        WHERE gory_no=1 AND pr_word LIKE '%스프링%';
        
         PR_CNT
 ------
      2

      


12)페이징
SELECT pr_no,  gory_no, pr_maker, pr_prname, pr_title, pr_contents, pr_thumbs, pr_files, pr_sizes, pr_cnt,
           pr_year, pr_rdate, pr_word, r
FROM(
         SELECT pr_no,  gory_no, pr_maker, pr_prname, pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt,
                    pr_year,  pr_rdate, pr_word, rownum as r
         FROM(
                  SELECT pr_no,  gory_no, pr_maker, pr_prname, pr_title, pr_contents,pr_thumbs, pr_files, pr_sizes, pr_cnt,
                             pr_year, pr_rdate, pr_word
                  FROM product
                  WHERE gory_no=1
                  ORDER BY pr_no DESC
         )
)
WHERE r >=1 AND r <= 3;

 PR_NO GORY_NO PR_MAKER PR_TITLE PR_CONTENTS PR_THUMBS     PR_FILES    PR_SIZES PR_CNT PR_YEAR               PR_RDATE              PR_WORD                  R
 ----- ------- -------- -------- ----------- ------------- ----------- -------- ------ --------------------- --------------------- ------------------------ -
     2       1 삼성       제목       내용          summber_m.jpg summber.jpg 0             0 2017-01-01 00:00:00.0 2018-06-18 13:03:57.0 스프링,spring,봄,春,계절,냉이,개나리 1
     1       1 삼성       겨울       손이시려워...    snow_t.jpg    snow.jpg    1500          0 2017-01-01 00:00:00.0 2018-06-18 12:58:01.0 휴가                       2

-- 검색        
SELECT pr_no,  gory_no, pr_maker, pr_prname, pr_title, pr_contents, pr_thumbs, pr_files, pr_sizes, pr_cnt,
           pr_year, pr_rdate, pr_word, r
FROM(
         SELECT pr_no,  gory_no, pr_maker, pr_prname, pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt,
                    pr_year, pr_rdate, pr_word, rownum as r
         FROM(
                  SELECT pr_no,  gory_no, pr_maker, pr_prname, pr_title, pr_contents, pr_thumbs, pr_files, pr_sizes, pr_cnt,
                             pr_year, pr_rdate, pr_word
                  FROM product
                  WHERE gory_no=1 AND pr_word LIKE '%스프링%'
                  ORDER BY pr_no DESC
         )
)
WHERE r >=1 AND r <= 3;

 PR_NO GORY_NO PR_MAKER PR_TITLE PR_CONTENTS PR_THUMBS     PR_FILES    PR_SIZES PR_CNT PR_YEAR               PR_RDATE              PR_WORD                  R
 ----- ------- -------- -------- ----------- ------------- ----------- -------- ------ --------------------- --------------------- ------------------------ -
     2       1 삼성       제목       내용          summber_m.jpg summber.jpg 0             0 2017-01-01 00:00:00.0 2018-06-18 13:03:57.0 스프링,spring,봄,春,계절,냉이,개나리 1


-- 제목으로 검색        
SELECT pr_no,  gory_no, pr_maker, pr_prname, pr_title, pr_contents, pr_thumbs, pr_files, pr_sizes, pr_cnt,
           pr_year, pr_rdate, pr_word, r
FROM(
         SELECT pr_no,  gory_no, pr_maker, pr_prname, pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt,
                    pr_year, pr_rdate, pr_word, rownum as r
         FROM(
                  SELECT pr_no,  gory_no, pr_maker, pr_prname, pr_title, pr_contents, pr_thumbs, pr_files, pr_sizes, pr_cnt,
                             pr_year, pr_rdate, pr_word
                  FROM product
                  WHERE gory_no=1 AND pr_title LIKE '%제목%'
                  ORDER BY pr_no DESC
         )
)
WHERE r >=1 AND r <= 3;



 PR_NO GORY_NO PR_MAKER PR_TITLE PR_CONTENTS PR_THUMBS     PR_FILES    PR_SIZES PR_CNT PR_YEAR               PR_RDATE              PR_WORD                  R
 ----- ------- -------- -------- ----------- ------------- ----------- -------- ------ --------------------- --------------------- ------------------------ -
     2       1 삼성       제목       내용          summber_m.jpg summber.jpg 0             0 2017-01-01 00:00:00.0 2018-06-18 13:03:57.0 스프링,spring,봄,春,계절,냉이,개나리 1



      
select substr(pr_rdate,0,2) from product;
(to_char)???

-- 출판년도로 검색        
SELECT pr_no,  gory_no, pr_maker, pr_prname, pr_title, pr_contents, pr_thumbs, pr_files, pr_sizes, pr_cnt,
           pr_year, pr_rdate, pr_word, r
FROM(
         SELECT pr_no,  gory_no, pr_maker, pr_prname, pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt,
                    pr_year, pr_rdate, pr_word, rownum as r
         FROM(
                  SELECT pr_no,  gory_no, pr_maker, pr_prname, pr_title, pr_contents, pr_thumbs, pr_files, pr_sizes, pr_cnt,
                             pr_year, pr_rdate, pr_word
                  FROM product
                  WHERE gory_no=1 
                  ORDER BY pr_year DESC
         )
)
WHERE r >=1 AND r <= 3;


-- 브랜드명으로 검색        
SELECT pr_no,  gory_no, pr_maker, pr_prname, pr_title, pr_contents, pr_thumbs, pr_files, pr_sizes, pr_cnt,
           pr_year, pr_rdate, pr_word, r
FROM(
         SELECT pr_no,  gory_no, pr_maker, pr_prname, pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt,
                    pr_year, pr_rdate, pr_word, rownum as r
         FROM(
                  SELECT pr_no,  gory_no, pr_maker, pr_prname, pr_title, pr_contents, pr_thumbs, pr_files, pr_sizes, pr_cnt,
                             pr_year, pr_rdate, pr_word
                  FROM product
                  WHERE gory_no=1 AND pr_maker='삼성'
                  ORDER BY pr_no DESC
         )
)
WHERE r >=1 AND r <= 3;
 PR_NO GORY_NO PR_MAKER PR_TITLE PR_CONTENTS PR_THUMBS     PR_FILES    PR_SIZES PR_CNT PR_YEAR               PR_RDATE              PR_WORD                  R
 ----- ------- -------- -------- ----------- ------------- ----------- -------- ------ --------------------- --------------------- ------------------------ -
     2       1 삼성       제목       내용          summber_m.jpg summber.jpg 0             0 2017-01-01 00:00:00.0 2018-06-18 13:03:57.0 스프링,spring,봄,春,계절,냉이,개나리 1
     1       1 삼성       겨울       손이시려워...    snow_t.jpg    snow.jpg    1500          0 2017-01-01 00:00:00.0 2018-06-18 12:58:01.0 휴가                       2


-- 가격으로 검색        
SELECT pr_no,  gory_no, pr_maker, pr_prname, pr_title, pr_contents, pr_thumbs, pr_files, pr_sizes, pr_cnt,
           pr_year, pr_rdate, pr_word, r
FROM(
         SELECT pr_no,  gory_no, pr_maker, pr_prname, pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt,
                    pr_year, pr_rdate, pr_word, rownum as r
         FROM(
                  SELECT pr_no,  gory_no, pr_maker, pr_prname, pr_title, pr_contents, pr_thumbs, pr_files, pr_sizes, pr_cnt,
                             pr_year, pr_rdate, pr_word
                  FROM product
                  WHERE gory_no=1 
                  ORDER BY pr_price DESC
         )
)
WHERE r >=1 AND r <= 3;

 PR_NO GORY_NO PR_MAKER PR_TITLE PR_CONTENTS PR_THUMBS     PR_FILES    PR_SIZES PR_CNT PR_YEAR               PR_RDATE              PR_WORD                  R
 ----- ------- -------- -------- ----------- ------------- ----------- -------- ------ --------------------- --------------------- ------------------------ -
     2       1 삼성       제목       내용          summber_m.jpg summber.jpg 0             0 2017-01-01 00:00:00.0 2018-06-18 13:03:57.0 스프링,spring,봄,春,계절,냉이,개나리 1
     1       1 삼성       겨울       손이시려워...    snow_t.jpg    snow.jpg    1500          0 2017-01-01 00:00:00.0 2018-06-18 12:58:01.0 휴가                       2



      
13)판매완료(pr_visible)
UPDATE product
SET pr_payment='Y',pr_visible='N'
WHERE pr_no=2;

SELECT pr_no, 
           gory_no, mem_no, pr_maker, pr_prname, pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt,  pr_year, pr_rdate, 
           pr_word, pr_price,  pr_visible, pr_payment, pr_visible
FROM product;

 PR_NO GORY_NO MEM_NO PR_MAKER PR_TITLE PR_CONTENTS PR_THUMBS     PR_FILES    PR_SIZES PR_CNT PR_YEAR               PR_RDATE              PR_WORD                  PR_PRICE PR_VISIBLE PR_PAYMENT PR_VISIBLE
 ----- ------- ------ -------- -------- ----------- ------------- ----------- -------- ------ --------------------- --------------------- ------------------------ -------- ---------- ---------- ----------
     1       1      1 삼성       겨울       손이시려워...    snow_t.jpg    snow.jpg    1500          0 2017-01-01 00:00:00.0 2018-06-18 12:58:01.0 휴가                           1000 Y          N          Y
     2       1      1 삼성       제목       내용          summber_m.jpg summber.jpg 0             0 2017-01-01 00:00:00.0 2018-06-18 13:03:57.0 스프링,spring,봄,春,계절,냉이,개나리     1000 N          Y          N




            
     




       
