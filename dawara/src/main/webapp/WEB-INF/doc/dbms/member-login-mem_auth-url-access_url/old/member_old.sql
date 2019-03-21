--임시테이블(권한 테이블)
- 권한 테이블
- 가입자별 권한 부여

CREATE TABLE AUTH(
    AUTH_NO                            NUMBER(10)    NOT NULL    PRIMARY KEY,
    AUTH_INFO                          VARCHAR2(100)    NOT NULL
);

drop table auth;
drop table admin;

COMMENT ON TABLE AUTH is '권한';
COMMENT ON COLUMN AUTH.AUTH_NO is '권한 번호';
COMMENT ON COLUMN AUTH.AUTH_INFO is '권한 정보';

INSERT INTO auth(auth_no, auth_info)
VALUES (1, '관리자');
INSERT INTO auth(auth_no, auth_info)
VALUES (2, '부관리자');
INSERT INTO auth(auth_no, auth_info)
VALUES (3, '일반회원');
INSERT INTO auth(auth_no, auth_info)
VALUES (4, '우수회원');
INSERT INTO auth(auth_no, auth_info)
VALUES (5, '블랙리스트');

SELECT * FROM auth;

SELECT COUNT(*) as cnt
FROM member
WHERE 1=1

    SELECT mem_no, mem_id, mem_name, mem_tel, mem_mail, mem_sex, 
              mem_zipcode, mem_addr1, mem_addr2, auth_no, mem_date, r
    FROM (
              SELECT mem_no, mem_id, mem_name, mem_tel, mem_mail, mem_sex, 
              mem_zipcode, mem_addr1, mem_addr2, auth_no, mem_date, rownum as r
              FROM (
                        SELECT mem_no, mem_id, mem_name, mem_tel, mem_mail, mem_sex, 
                                  mem_zipcode, mem_addr1, mem_addr2, auth_no, mem_date
                                  FROM member
                                  WHERE mem_id LIKE '%user1%'
                                  ORDER BY mem_no DESC
                        )
            );

1) 회원 테이블 생성
CREATE TABLE member (
  mem_no       NUMBER(6) NOT NULL     PRIMARY KEY, -- 회원 번호, 레코드를 구분하는 컬럼 
  mem_id           VARCHAR(20)   NOT NULL UNIQUE, -- 아이디, 중복 안됨, 레코드를 구분 
  mem_pic       VARCHAR(100)    NULL,     -- 회원사진
  mem_size       NUMBER(10)    DEFAULT 0 NULL,     -- 회원사진 크기
  mem_pass    VARCHAR(60)   NOT NULL, -- 패스워드, 영숫자 조합
  mem_name    VARCHAR(20)   NOT NULL, -- 성명, 한글 10자 저장 가능
  mem_tel          VARCHAR(14)   NOT NULL, -- 전화번호
  mem_mail      VARCHAR(20)     NOT NULL, -- 이메일
  mem_auth      VARCHAR(20)     NULL, -- 이메일 인증키
  mem_job         VARCHAR(20)     NOT NULL, -- 회원직업
  mem_sex         VARCHAR(10)     NOT NULL, -- 회원성별
  mem_zipcode   VARCHAR(5)        NULL, -- 우편번호, 12345
  mem_addr1  VARCHAR(100)       NULL, -- 주소 1
  mem_addr2  VARCHAR(80)       NULL, -- 주소 2    
  mem_acc   NUMBER(6)   DEFAULT 0 NOT NULL,   -- 회원의 신고당한횟수
  mem_mile   NUMBER(9)   DEFAULT 0 NOT NULL,   -- 회원 마일리지(구매용)
  mem_confirm    VARCHAR(1)         DEFAULT 'N' NOT NULL, -- 이메일 링크 클릭 여부, Y:클릭, N:클릭안함
  auth_no   NUMBER(6) DEFAULT 3 NOT NULL, -- 회원 권한 번호
  mem_date     DATE             NOT NULL, -- 가입일    
  FOREIGN KEY (AUTH_NO) REFERENCES AUTH(AUTH_NO)
);

alter table member rename column authno to auth_no;
alter table member rename column mem_date to mem_rdate;
alter table member rename column mem_rdate to mem_date;
alter table member drop(mem_word);

ALTER TABLE MEMBER ADD(mem_word VARCHAR(1000)); 
ALTER TABLE MEMBER 

ALTER TABLE MEMBER MODIFY(MEM_SIZE NUMBER(10)    DEFAULT 0 NULL);

SELECT * FROM MEMBER;

ALTER TABLE MEMBER MODIFY MEM_AUTH VARCHAR(20) NULL;

DROP TABLE MEMBER;

COMMENT ON TABLE MEMBER is '회원';
COMMENT ON COLUMN MEMBER.MEM_NO is '회원 번호';
COMMENT ON COLUMN MEMBER.MEM_ID is '아이디';
COMMENT ON COLUMN MEMBER.MEM_PIC is '회원사진';
COMMENT ON COLUMN MEMBER.MEM_SIZE is '회원사진크기';
COMMENT ON COLUMN MEMBER.MEM_PASS is '패스워드';
COMMENT ON COLUMN MEMBER.MEM_NAME is '성명';
COMMENT ON COLUMN MEMBER.MEM_TEL is '전화번호';
COMMENT ON COLUMN MEMBER.MEM_MAIL is '이메일주소';
COMMENT ON COLUMN MEMBER.MEM_AUTH is '이메일인증키';
COMMENT ON COLUMN MEMBER.MEM_JOB is '회원직업';
COMMENT ON COLUMN MEMBER.MEM_SEX is '회원성별';
COMMENT ON COLUMN MEMBER.MEM_ZIPCODE is '우편번호';
COMMENT ON COLUMN MEMBER.MEM_ADDR1 is '주소1';
COMMENT ON COLUMN MEMBER.MEM_ADDR2 is '주소2';
COMMENT ON COLUMN MEMBER.MEM_ACC is '신고횟수';
COMMENT ON COLUMN MEMBER.MEM_MILE is '마일리지';
COMMENT ON COLUMN MEMBER.MEM_CONFIRM is '메일확인여부';
COMMENT ON COLUMN MEMBER.AUTH_NO is '회원권한번호'; -- 1: 관리자, 2: 부관리자, 3: 일반회원, 4: 우수회원, 5:블랙리스트
COMMENT ON COLUMN MEMBER.MEM_DATE is '가입일';

DROP TABLE member;

SELECT * FROM member;

SELECT mem_no, mem_id, auth_no FROM member;

update member set auth_no = 1 where mem_no =2;

DROP TABLE login;

SELECT mem_no, mem_id, mem_name, mem_tel, mem_mail, mem_sex, 
              mem_zipcode, mem_addr1, mem_addr2, auth_no, mem_date
    FROM member
    WHERE mem_id LIKE '%' || 'user1' || '%'
    ORDER BY mem_no DESC

1-1) 등록
* id 중복 확인
SELECT COUNT(mem_id) as cnt
FROM member
WHERE mem_id='user1';
 
 cnt
 ---
   0   ← 중복 되지 않음.
   
1-1) 등록 
-- 개인 회원 기준
INSERT INTO member(mem_no, mem_id, mem_pic, mem_size, mem_pass, mem_name, mem_tel, mem_mail, mem_auth, mem_job,
mem_sex, mem_zipcode, mem_addr1, mem_addr2, mem_confirm, mem_date)
VALUES ((SELECT NVL(MAX(mem_no), 0)+1 as mem_no FROM member),
'user53', 'hello.jpg', '15468720', '1234', '왕눈이', '000-0000-0000', 'test1@gmail.com', 'AXD0123456789012', '학생', '남', '12345', '서울시 종로구', '관철동', 'Y', sysdate);
 
INSERT INTO member(mem_no, mem_id, mem_pic, mem_size, mem_pass, mem_name, mem_tel, mem_mail, mem_auth, mem_job,
mem_sex, mem_zipcode, mem_addr1, mem_addr2, mem_confirm, mem_date)
VALUES ((SELECT NVL(MAX(mem_no), 0)+1 as mem_no FROM member),
'user12323', 'hello.jpg', '15468720', '1234', '아로미', '000-0000-0000', 'test1@gmail.com', 'AXD0123456789012', '회사원', '여', '12345', '서울시 종로구', '관철동', 'Y', sysdate);

INSERT INTO member(mem_no, mem_id, mem_pass, mem_name, mem_tel, mem_mail, mem_auth, mem_job,
mem_sex, mem_zipcode, mem_addr1, mem_addr2, mem_confirm, mem_date)
VALUES ((SELECT NVL(MAX(mem_no), 0)+1 as mem_no FROM member),
'user553', '1234', '투투', '000-0000-0000', 'test1@gmail.com', 'AXD0123456789012', '무직', '여', '12345', '서울시 종로구', '관철동', 'Y', sysdate);

INSERT INTO member(mem_no, mem_id, mem_pass, mem_name, mem_tel, mem_mail, mem_auth, mem_job,
mem_sex, mem_zipcode, mem_addr1, mem_addr2, mem_confirm, mem_date, mem_word)
VALUES ((SELECT NVL(MAX(mem_no), 0)+1 as mem_no FROM member),
'user557', '1234', '투투', '000-0000-0000', 'test1@gmail.com', 'AXD0123456789012', '무직', '여', '12345', '서울시 종로구', '관철동', 'Y', sysdate,
'(user557, 1234, 투투, test1@gmial.com)');

INSERT INTO member(mem_no, mem_id, mem_pass, mem_name, mem_tel, mem_mail, mem_auth, mem_job,
mem_sex, mem_zipcode, mem_addr1, mem_addr2, mem_confirm, mem_date)
VALUES ((SELECT NVL(MAX(mem_no), 0)+1 as mem_no FROM member),
'user15', '123456', '투투', '000-0000-0000', 'test1@gmail.com', 'AXD0123456789012', '무직', '여', '12345', '서울시 종로구', '관철동', 'Y', sysdate);


1-2) 목록
- 검색을 하지 않는 경우, 전체 목록 출력


 
SELECT mem_no, mem_id, mem_pic, mem_size, mem_pass, mem_name, mem_tel, mem_mail, mem_auth, mem_job, 
mem_sex, mem_zipcode, mem_addr1, mem_addr2, mem_acc, mem_mile, mem_confirm, mem_acc, mem_date
FROM member
ORDER BY mem_no ASC;
 
 MEM_NO MEM_ID MEM_PIC   MEM_SIZE MEM_PASS MEM_NAME MEM_TEL       MEM_MAIL        MEM_AUTH         MEM_JOB MEM_SEX MEM_ZIPCODE MEM_ADDR1 MEM_ADDR2 MEM_ACC MEM_MILE MEM_CONFIRM MEM_ACC MEM_DATE
 ------ ------ --------- -------- -------- -------- ------------- --------------- ---------------- ------- ------- ----------- --------- --------- ------- -------- ----------- ------- ---------------------
      1 user1  hello.jpg 15468720 1234     왕눈이      000-0000-0000 test1@gmail.com AXD0123456789012 학생      남       12345       서울시 종로구   관철동             0        0 Y                 0 2018-06-21 15:05:42.0
      2 user2  hello.jpg 15468720 1234     아로미      000-0000-0000 test1@gmail.com AXD0123456789012 회사원     여       12345       서울시 종로구   관철동             0        0 Y                 0 2018-06-21 15:05:43.0
      3 user3  NULL          NULL 1234     투투       000-0000-0000 test1@gmail.com AXD0123456789012 무직      여       12345       서울시 종로구   관철동             0        0 Y                 0 2018-06-21 15:05:44.0
      
1-3) 조회
* user1 회원 정보 보기
SELECT mem_no, mem_id, mem_pic, mem_size, mem_pass, mem_name, mem_tel, mem_mail, mem_auth, mem_job,
mem_sex, mem_zipcode, mem_addr1, mem_addr2, mem_acc, mem_mile, mem_confirm, mem_date
FROM member
WHERE mem_no = 1;
 
 MEM_NO MEM_ID MEM_PIC   MEM_SIZE MEM_PASS MEM_NAME MEM_TEL       MEM_MAIL        MEM_AUTH         MEM_JOB MEM_SEX MEM_ZIPCODE MEM_ADDR1 MEM_ADDR2 MEM_ACC MEM_MILE MEM_CONFIRM MEM_DATE
 ------ ------ --------- -------- -------- -------- ------------- --------------- ---------------- ------- ------- ----------- --------- --------- ------- -------- ----------- ---------------------
      1 user1  hello.jpg 15468720 1234     왕눈이      000-0000-0000 test1@gmail.com AXD0123456789012 학생      남       12345       서울시 종로구   관철동             0        0 Y           2018-06-21 15:05:42.0

SELECT mem_no, mem_id, mem_pic, mem_size, mem_pass, mem_name, mem_tel, mem_mail, mem_auth, mem_job, 
mem_sex, mem_zipcode, mem_addr1, mem_addr2, mem_acc, mem_mile, mem_confirm, mem_date
FROM member
WHERE mem_id = 'user1';
 
 MEM_NO MEM_ID MEM_PIC   MEM_SIZE MEM_PASS MEM_NAME MEM_TEL       MEM_MAIL        MEM_AUTH         MEM_JOB MEM_SEX MEM_ZIPCODE MEM_ADDR1 MEM_ADDR2 MEM_ACC MEM_MILE MEM_CONFIRM MEM_DATE
 ------ ------ --------- -------- -------- -------- ------------- --------------- ---------------- ------- ------- ----------- --------- --------- ------- -------- ----------- ---------------------
      1 user1  hello.jpg 15468720 1234     왕눈이      000-0000-0000 test1@gmail.com AXD0123456789012 학생      남       12345       서울시 종로구   관철동             0        0 Y           2018-06-21 15:05:42.0

1-4) 수정
--일반회원의 정보수정
UPDATE member 
SET mem_name='호빵맨', mem_pic='hi.jpg', mem_mail='test1@yahoo.co.kr', mem_job='무직', 
      mem_tel='111-1111-1111', mem_zipcode='00000', mem_addr1='경기도', mem_addr2='파주시'
WHERE mem_no=1;

SELECT * FROM member;

 MEM_NO MEM_ID MEM_PIC   MEM_SIZE MEM_PASS MEM_NAME MEM_TEL       MEM_MAIL          MEM_AUTH         MEM_JOB MEM_SEX MEM_ZIPCODE MEM_ADDR1 MEM_ADDR2 MEM_ACC MEM_MILE MEM_CONFIRM AUTH_NO MEM_DATE
 ------ ------ --------- -------- -------- -------- ------------- ----------------- ---------------- ------- ------- ----------- --------- --------- ------- -------- ----------- ------- ---------------------
      1 user1  hi.jpg    15468720 1234     호빵맨      111-1111-1111 test1@yahoo.co.kr AXD0123456789012 무직      남       00000       경기도       파주시             0        0 Y                 3 2018-06-21 15:05:42.0
      2 user2  hello.jpg 15468720 1234     아로미      000-0000-0000 test1@gmail.com   AXD0123456789012 회사원     여       12345       서울시 종로구   관철동             0        0 Y                 3 2018-06-21 15:05:43.0
      3 user3  NULL          NULL 1234     투투       000-0000-0000 test1@gmail.com   AXD0123456789012 무직      여       12345       서울시 종로구   관철동             0        0 Y                 3 2018-06-21 15:05:44.0

UPDATE member 
SET mem_id='user2'
WHERE mem_no=2;
      
1-5) 패스워드 변경
* 패스워드 검사
SELECT COUNT(mem_no) as cnt
FROM member
WHERE mem_no=1 AND mem_pass='1234';

 CNT
 ---
   1  -- mem_no=1번의 pass워드는 1234, 일치하기 때문에 1
 
* 패스워드 수정
UPDATE member
SET mem_pass='0000'
WHERE mem_no=1;

SELECT * FROM member WHERE mem_no=1;

 MEM_NO MEM_ID MEM_PIC MEM_SIZE MEM_PASS MEM_NAME MEM_TEL       MEM_MAIL          MEM_AUTH         MEM_JOB MEM_SEX MEM_ZIPCODE MEM_ADDR1 MEM_ADDR2 MEM_ACC MEM_MILE MEM_CONFIRM AUTH_NO MEM_DATE
 ------ ------ ------- -------- -------- -------- ------------- ----------------- ---------------- ------- ------- ----------- --------- --------- ------- -------- ----------- ------- ---------------------
      1 user1  hi.jpg  15468720 0000     호빵맨      111-1111-1111 test1@yahoo.co.kr AXD0123456789012 무직      남       00000       경기도       파주시             0        0 Y                 3 2018-06-21 15:05:42.0

1-6) 삭제
* 모두 삭제
DELETE FROM member;
 
* 특정 회원 삭제
DELETE FROM member
WHERE mem_no=4;
 
 
1-7) 로그인
SELECT COUNT(mem_no) as cnt
FROM member
WHERE mem_id='user1' AND mem_pass='1234';
 cnt
 ---
   0
 
* 프로젝트 설계시 추가 컬럼 안내: 이메일, 별명, 회원 사진, 직업, 등급

2) 로그인 내역 테이블 생성

DROP TABLE login;

SELECT * FROM login;
SELECT * FROM MEMBER;

CREATE TABLE login(
  login_no NUMBER(10)  NOT NULL, -- 기본키
  mem_no NUMBER(6) NULL, -- 접속자가 회원이면 mem_no가져옴
  login_ip  VARCHAR(15) NOT NULL, -- 접속자 ip
  login_date DATE  NOT NULL, -- 접속자 접속시간
  login_agent VARCHAR(400) NOT NULL, --접속자 브라우저 정보
  PRIMARY KEY (login_no),
  FOREIGN KEY(mem_no)  REFERENCES member(mem_no)
);

SELECT COUNT(mem_no) as cnt
FROM login
WHERE mem_no=13;

drop table login;
  
COMMENT ON TABLE login is '로그인';
COMMENT ON COLUMN login.login_no is '로그인번호';
COMMENT ON COLUMN login.mem_no is '회원번호';
COMMENT ON COLUMN login.login_ip is '로그인아이피';
COMMENT ON COLUMN login.login_date is '로그인날짜';
COMMENT ON COLUMN login.login_agent is '접속자브라우저정보';

2-2) 등록 
-- 개인 회원 기준
INSERT INTO login(login_no, mem_no, login_ip, login_date)
VALUES ((SELECT NVL(MAX(login_no), 0)+1 as login_no FROM login), 1, '0.0.0.0', sysdate); 

INSERT INTO login(login_no, mem_no, login_ip, login_date)
VALUES ((SELECT NVL(MAX(login_no), 0)+1 as login_no FROM login), 2, '0.0.0.0', sysdate); 

INSERT INTO login(login_no, mem_no, login_ip, login_date)
VALUES ((SELECT NVL(MAX(login_no), 0)+1 as login_no FROM login), 1, '0.0.0.0', sysdate); 

2-3) 목록
 
SELECT *
FROM login
ORDER BY login_no ASC;
 
 LOGIN_NO MEM_NO LOGIN_IP LOGIN_DATE
 -------- ------ -------- ---------------------
        1      1 0.0.0.0  2018-06-21 13:40:19.0
        2      2 0.0.0.0  2018-06-21 13:40:20.0
        3      1 0.0.0.0  2018-06-21 13:40:21.0
        
2-4) 조회
* user1의 로그인 기록보기
SELECT login_no, mem_no, login_ip, login_date
FROM login
WHERE mem_no = 1;

 LOGIN_NO MEM_NO LOGIN_IP LOGIN_DATE
 -------- ------ -------- ---------------------
        1      1 0.0.0.0  2018-06-21 13:40:19.0
        3      1 0.0.0.0  2018-06-21 13:40:21.0

SELECT login_no, mem_no, login_ip, login_date
FROM login
WHERE login_ip = '0.0.0.0';
 
 LOGIN_NO MEM_NO LOGIN_IP LOGIN_DATE
 -------- ------ -------- ---------------------
        1      1 0.0.0.0  2018-06-21 13:40:19.0
        2      2 0.0.0.0  2018-06-21 13:40:20.0
        3      1 0.0.0.0  2018-06-21 13:40:21.0

2-5) 삭제
* 모두 삭제
DELETE FROM login;
 
* 특정 회원 로그인 기록 삭제
DELETE FROM login
WHERE mem_no=1;

+주문, 주문상세, 장바구니

DROP TABLE p_order;

3) 주문 테이블 생성
CREATE TABLE p_order(
    ord_no    NUMBER(6) NOT NULL,
    ord_mem_no NUMBER(6) NOT NULL,
    ord_date    DATE NOT NULL,
    rec_name    VARCHAR(20) NOT NULL,
    rec_zipcode     VARCHAR(5) NULL,
    rec_addr1     VARCHAR(80) NULL,
    rec_addr2     VARCHAR(50) NULL,
    rec_tel     VARCHAR(14) NOT NULL,
    rec_cmt     VARCHAR(100) NULL,
    rec_sign    VARCHAR(20) NOT NULL,
    PRIMARY KEY (ord_no),
    CONSTRAINT ck_ord_memno FOREIGN KEY(ord_mem_no)
    REFERENCES p_member(mem_no)
);

COMMENT ON TABLE P_ORDER is '주문';
COMMENT ON COLUMN P_ORDER.ORD_NO is '주문번호';
COMMENT ON COLUMN P_ORDER.ORD_MEM_NO is '주문회원번호';
COMMENT ON COLUMN P_ORDER.ORD_DATE is '주문날짜';
COMMENT ON COLUMN P_ORDER.REC_NAME is '수령인이름';
COMMENT ON COLUMN P_ORDER.REC_ZIPCODE is '배송주소1';
COMMENT ON COLUMN P_ORDER.REC_ADDR1 is '배송주소2';
COMMENT ON COLUMN P_ORDER.REC_ADDR2 is '배송주소3';
COMMENT ON COLUMN P_ORDER.REC_TEL is '수령인전화번호';
COMMENT ON COLUMN P_ORDER.REC_CMT is '기타사항';
COMMENT ON COLUMN P_ORDER.REC_SIGN is '결제수단';

-------------임시테이블---------------------------------------------

DROP TABLE p_products;

CREATE TABLE p_products(
    products_no NUMBER(6) NOT NULL,
    PRIMARY KEY(products_no)
);

COMMENT ON TABLE P_PRODUCTS is '상품';
COMMENT ON COLUMN P_PRODUCTS.PRODUCTS_NO is '상품번호';

----------------------------------------------------------------------

DROP TABLE p_ord_detail;

4) 주문상세 테이블 생성
CREATE TABLE p_ord_detail(
    ord_detail_no   NUMBER(6) NOT NULL,
    ord_detail_ord_no    NUMBER(6) NOT NULL,
    ord_detail_products_no  NUMBER(6) NOT NULL,
    ord_prodno VARCHAR(13) NOT NULL,
    ord_price NUMBER(9) NOT NULL,
    PRIMARY KEY (ord_detail_no),
    CONSTRAINT ck_ord_detail_ordno FOREIGN KEY(ord_detail_ord_no) REFERENCES p_order(ord_no),
    CONSTRAINT ck_ord_detail_products_no FOREIGN KEY(ord_detail_products_no) REFERENCES p_products(products_no)
);

COMMENT ON TABLE P_ORD_DETAIL is '주문상세';
COMMENT ON COLUMN P_ORD_DETAIL.ORD_DETAIL_NO is '주문상세번호';
COMMENT ON COLUMN P_ORD_DETAIL.ORD_DETAIL_ORD_NO is '주문번호';
COMMENT ON COLUMN P_ORD_DETAIL.ORD_DETAIL_PRODUCTS_NO is '상품번호';
COMMENT ON COLUMN P_ORD_DETAIL.ORD_PRODNO is '주문상품갯수';
COMMENT ON COLUMN P_ORD_DETAIL.ORD_PRICE is '주문상품가격';

DROP TABLE p_cart;

5) 장바구니 테이블 생성
CREATE TABLE p_cart(
  cart_no NUMBER(6) NOT NULL,
  cart_mem_no NUMBER(6) NOT NULL,
  cart_prodname VARCHAR(20) NOT NULL,
  cart_price VARCHAR(13) NOT NULL,
  cart_prodno NUMBER(6) NOT NULL,
  PRIMARY KEY(cart_no),
  CONSTRAINT ck_cart_memno FOREIGN KEY(cart_mem_no) REFERENCES p_member(mem_no)
);
  
COMMENT ON TABLE P_CART is '장바구니';
COMMENT ON COLUMN P_CART.CART_NO is '장바구니번호';
COMMENT ON COLUMN P_CART.CART_MEM_NO is '회원번호';
COMMENT ON COLUMN P_CART.CART_PRODNAME is '상품이름';
COMMENT ON COLUMN P_CART.CART_PRICE is '상품가격';
COMMENT ON COLUMN P_CART.CART_PRODNO is '상품갯수';


1. 등록

1) id 중복 확인
SELECT COUNT(id) as cnt
FROM member
WHERE id='user1';
 
 cnt
 ---
   0   ← 중복 되지 않음.
   
2) 등록
- 일련번호 산출 서브쿼리
- MAX(mno): mno 컬럼의 값중에 가장 큰 값을 산출
- 레코드가 없으면 MAX 함수의 결과는 NULL이됩니다.
SELECT MAX(mno) as mno FROM member;
 MNO
 ------
 NULL
 
 - NULL 값은 사칙연산의 결과도 NULL이됩니다. 의미 없음.
SELECT MAX(mno)+1 as mno FROM member;
 MNO
 ------
 NULL
 
 - NVL(값, 변환할 값): 값이 NULL이면 변환할 값으로 변경, 
   NULL을 0으로 변경
SELECT NVL(MAX(mno), 0) as mno FROM member;
 MNO
 ------
   0
   
- NULL을 처리하면서 새로운 최대값 산출 SQL
SELECT NVL(MAX(mno), 0)+1 as mno FROM member;
 MNO
 ------
   1
 
-- 개인 회원 기준
INSERT INTO member(mno, id, passwd, mname, tel, zipcode, address1, address2, mdate)
VALUES ((SELECT NVL(MAX(mno), 0)+1 as mno FROM member),
'user1', '1234', '왕눈이', '000-0000-0000', '12345', '서울시 종로구', '관철동', sysdate);
 
INSERT INTO member(mno, id, passwd, mname, tel, zipcode, address1, address2, mdate)
VALUES ((SELECT NVL(MAX(mno), 0)+1 as mno FROM member),
'user2', '1234', '왕눈이', '000-0000-0000', '12345', '서울시 종로구', '관철동', sysdate);
 
INSERT INTO member(mno, id, passwd, mname, tel, zipcode, address1, address2, mdate)
VALUES ((SELECT NVL(MAX(mno), 0)+1 as mno FROM member),
'user3', '1234', '왕눈이', '000-0000-0000', '12345', '서울시 종로구', '관철동', sysdate);
 
-- 그룹별 공유회원 기준
INSERT INTO member(mno, id, passwd, mname, tel, zipcode, address1, address2, mdate)
VALUES ((SELECT NVL(MAX(mno), 0)+1 as mno FROM member),
'team1', '1234', '개발팀', '000-0000-0000', '12345', '서울시 종로구', '관철동', sysdate);
 
INSERT INTO member(mno, id, passwd, mname, tel, zipcode, address1, address2, mdate)
VALUES ((SELECT NVL(MAX(mno), 0)+1 as mno FROM member),
'team2', '1234', '웹퍼블리셔팀', '000-0000-0000', '12345', '서울시 종로구', '관철동', sysdate);
 
INSERT INTO member(mno, id, passwd, mname, tel, zipcode, address1, address2, mdate)
VALUES ((SELECT NVL(MAX(mno), 0)+1 as mno FROM member),
'team3', '1234', '디자인팀', '000-0000-0000', '12345', '서울시 종로구', '관철동', sysdate);
 
 
2. 목록
- 검색을 하지 않는 경우, 전체 목록 출력
 
SELECT mno, id, passwd, mname, tel, zipcode, address1, address2, mdate
FROM member
ORDER BY mno ASC;
 
 mno id    passwd mname tel           zipcode address1 address2 mdate
 --- ----- ------ ----- ------------- ------- -------- -------- ---------------------
   1 user1 1234   왕눈이   000-0000-0000 12345   서울시 종로구  관철동      2016-01-12 12:48:52.0
   2 user2 1234   왕눈이   000-0000-0000 12345   서울시 종로구  관철동      2016-01-12 12:48:53.0
   3 user3 1234   왕눈이   000-0000-0000 12345   서울시 종로구  관철동      2016-01-12 12:48:54.0
 
   
3. 조회
 
1) user1 사원 정보 보기
SELECT mno, id, passwd, mname, tel, zipcode, address1, address2, mdate
FROM member
WHERE mno = 1;
 
 MNO ID    PASSWD MNAME TEL           ZIPCODE ADDRESS1 ADDRESS2 MDATE
 --- ----- ------ ----- ------------- ------- -------- -------- ---------------------
   1 user1 1234   왕눈이   000-0000-0000 12345   서울시 종로구  관철동      2016-05-24 12:59:35.0
 
SELECT mno, id, passwd, mname, tel, zipcode, address1, address2, mdate
FROM member
WHERE id = 'user1';
 
 MNO ID    PASSWD MNAME TEL           ZIPCODE ADDRESS1 ADDRESS2 MDATE
 --- ----- ------ ----- ------------- ------- -------- -------- ---------------------
   1 user1 1234   왕눈이   000-0000-0000 12345   서울시 종로구  관철동      2017-03-22 22:13:31.0
 
   
4. 수정
UPDATE member 
SET mname='아로미', tel='111-1111-1111', zipcode='00000',
      address1='경기도', address2='파주시'
WHERE mno=1;
 
 
5. 패스워드 변경
1) 패스워드 검사
SELECT COUNT(mno) as cnt
FROM member
WHERE mno=1 AND passwd='1234';
 
2) 패스워드 수정
UPDATE member
SET passwd='0000'
WHERE mno=1;
 
 
6. 삭제
1) 모두 삭제
DELETE FROM member;
 
2) 특정 회원 삭제
DELETE FROM member
WHERE mno=4;
 
 
7. 로그인
SELECT COUNT(mno) as cnt
FROM member
WHERE id='user1' AND passwd='1234';
 cnt
 ---
   0
 
 
* 프로젝트 설계시 추가 컬럼 안내: 이메일, 별명, 회원 사진, 직업, 등급
  
 
-------------------------------------------------------------------------------------
 
 
 
 
- MySQL
▷ /WEB-INF/doc/dbms/member_q.sql
-------------------------------------------------------------------------------------
1. 테이블 구조
DROP TABLE member;
 
CREATE TABLE member (
  mno INT NOT NULL AUTO_INCREMENT, -- 회원 번호, 레코드를 구분하는 컬럼 
  id           VARCHAR(20)   NOT NULL UNIQUE, -- 아이디, 중복 안됨, 레코드를 구분 
  passwd    VARCHAR(20)   NOT NULL, -- 패스워드, 영숫자 조합
  mname    VARCHAR(20)   NOT NULL, -- 성명, 한글 10자 저장 가능
  tel          VARCHAR(14)   NOT NULL, -- 전화번호
  zipcode   VARCHAR(5)        NULL, -- 우편번호, 12345
  address1  VARCHAR(80)       NULL, -- 주소 1
  address2  VARCHAR(50)       NULL, -- 주소 2
  mdate     DATETIME            NOT NULL, -- 가입일    
  PRIMARY KEY (mno)             -- 한번 등록된 값은 중복 안됨
);
 
 
2. 등록
 
1) id 중복 확인
SELECT COUNT(id) as cnt
FROM member
WHERE id='user1';
 
 cnt
 ---
   0   ← 중복 되지 않음.
   
2) 등록
INSERT INTO member(id, passwd, mname, tel, zipcode, address1, address2, mdate)
VALUES ('user1', '1234', '왕눈이', '000-0000-0000', '12345', '서울시 종로구', '관철동', now());
 
INSERT INTO member(id, passwd, mname, tel, zipcode, address1, address2, mdate)
VALUES ('user2', '1234', '왕눈이', '000-0000-0000', '12345', '서울시 종로구', '관철동', now());
 
INSERT INTO member(id, passwd, mname, tel, zipcode, address1, address2, mdate)
VALUES ('user3', '1234', '왕눈이', '000-0000-0000', '12345', '서울시 종로구', '관철동', now());
 
 
3. 목록
- 검색을 하지 않는 경우, 전체 목록 출력
 
SELECT mno, id, passwd, mname, tel, zipcode, address1, address2, mdate
FROM member
ORDER BY mno ASC;
 
 mno id    passwd mname tel           zipcode address1 address2 mdate
 --- ----- ------ ----- ------------- ------- -------- -------- ---------------------
   1 user1 1234   왕눈이   000-0000-0000 12345   서울시 종로구  관철동      2016-01-12 12:48:52.0
   2 user2 1234   왕눈이   000-0000-0000 12345   서울시 종로구  관철동      2016-01-12 12:48:53.0
   3 user3 1234   왕눈이   000-0000-0000 12345   서울시 종로구  관철동      2016-01-12 12:48:54.0
 
 
   
3. 조회
 
1) user1 사원 정보 보기
 
 
4. 수정
 
 
5. 삭제
 
 
6. 검색
 
 
7. 페이징
 
 
* 프로젝트 설계시 추가 컬럼 안내: 이메일, 별명, 회원 사진, 직업, 등급

SELECT mem_no, mem_id, mem_name, mem_tel, mem_mail, mem_job, mem_sex, 
              mem_zipcode, mem_addr1, mem_addr2, mem_date, r
    FROM (
              SELECT mem_no, mem_id, mem_name, mem_tel, mem_mail, mem_job, mem_sex, 
              mem_zipcode, mem_addr1, mem_addr2, mem_date, rownum as r
              FROM (
                        SELECT mem_no, mem_id, mem_name, mem_tel, mem_mail, mem_job, mem_sex, 
                                  mem_zipcode, mem_addr1, mem_addr2, mem_date
                        FROM member
                        ORDER BY mem_no DESC
              )            
    )
    WHERE r >= 1 AND r <= 15
    <!--     WHERE r >= #{startNum} AND r <= #{endNum} -->
  
-------------------------------------------------------------------------------------