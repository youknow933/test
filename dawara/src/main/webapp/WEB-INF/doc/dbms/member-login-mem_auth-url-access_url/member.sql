SELECT COUNT(*) as cnt
FROM login
WHERE mem_no IN(SELECT mem_no FROM member WHERE auth_no=3);

SELECT COUNT(*) as cnt
    FROM access_url
    WHERE auth_no=1

SELECT COUNT(*) as cnt
FROM url
WHERE url_no IN(select url_no from access_url where auth_no=1);

SELECT url_no
FROM url
WHERE url LIKE '%read.do';

DROP TABLE LOGIN;
DROP TABLE MEMBER;
DROP TABLE AUTH;
DROP TABLE URL;
DROP TABLE ACCESS_URL;

select * from login;
select * from member;
select * from auth;
select * from url;
select * from access_url;
    
    
select * from login;
select * from member;
select * from auth;

update auth
set auth_no = 3
where auth_info = '일반회원'

DELETE FROM login
    WHERE mem_no IN(SELECT mem_no FROM member WHERE auth_no=5);

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
  mem_job         VARCHAR(20)     NOT NULL, -- 회원직업
  mem_sex         VARCHAR(10)     NOT NULL, -- 회원성별
  mem_zipcode   VARCHAR(5)        NULL, -- 우편번호, 12345
  mem_addr1  VARCHAR(100)       NULL, -- 주소 1
  mem_addr2  VARCHAR(80)       NULL, -- 주소 2    
  mem_acc   NUMBER(6)   DEFAULT 0 NOT NULL,   -- 회원의 신고당한횟수
  mem_mile   NUMBER(9)   DEFAULT 0 NOT NULL,   -- 회원 마일리지(구매용)
  auth_no   NUMBER(6) DEFAULT 2 NOT NULL, -- 회원 권한 번호
  mem_date     DATE             NOT NULL, -- 가입일    
  FOREIGN KEY (AUTH_NO) REFERENCES AUTH(AUTH_NO)
);

select * from member;

alter table member rename column authno to auth_no;
alter table member rename column mem_date to mem_rdate;
alter table member rename column mem_rdate to mem_date;
alter table member drop(mem_word);

ALTER TABLE MEMBER ADD(mem_word VARCHAR(1000)); 
ALTER TABLE MEMBER 

ALTER TABLE MEMBER MODIFY(MEM_SIZE NUMBER(10)    DEFAULT 0 NULL);

SELECT * FROM MEMBER;

ALTER TABLE MEMBER MODIFY AUTH VARCHAR(20) NULL;

DROP TABLE MEMBER;

DELETE TABLE FROM MEMBER;

COMMENT ON TABLE MEMBER is '회원';
COMMENT ON COLUMN MEMBER.MEM_NO is '회원 번호';
COMMENT ON COLUMN MEMBER.MEM_ID is '아이디';
COMMENT ON COLUMN MEMBER.MEM_PIC is '회원사진';
COMMENT ON COLUMN MEMBER.MEM_SIZE is '회원사진크기';
COMMENT ON COLUMN MEMBER.MEM_PASS is '패스워드';
COMMENT ON COLUMN MEMBER.MEM_NAME is '성명';
COMMENT ON COLUMN MEMBER.MEM_TEL is '전화번호';
COMMENT ON COLUMN MEMBER.MEM_MAIL is '이메일주소';
COMMENT ON COLUMN MEMBER.MEM_JOB is '회원직업';
COMMENT ON COLUMN MEMBER.MEM_SEX is '회원성별';
COMMENT ON COLUMN MEMBER.MEM_ZIPCODE is '우편번호';
COMMENT ON COLUMN MEMBER.MEM_ADDR1 is '주소1';
COMMENT ON COLUMN MEMBER.MEM_ADDR2 is '주소2';
COMMENT ON COLUMN MEMBER.MEM_ACC is '신고횟수';
COMMENT ON COLUMN MEMBER.MEM_MILE is '마일리지';
COMMENT ON COLUMN MEMBER.AUTH_NO is '회원권한번호'; -- 1: 관리자, 2: 부관리자, 3: 일반회원, 4: 우수회원, 5:블랙리스트
COMMENT ON COLUMN MEMBER.MEM_DATE is '가입일';

DROP TABLE member;

SELECT * FROM member;

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
INSERT INTO member(mem_no, mem_id, mem_pic, mem_size, mem_pass, mem_name, mem_tel, mem_mail, mem_job,
mem_sex, mem_zipcode, mem_addr1, mem_addr2, mem_acc, mem_mile, auth_no, mem_date)
VALUES ((SELECT NVL(MAX(mem_no), 0)+1 as mem_no FROM member),
'user53', 'hello.jpg', '15468720', '1234', '왕눈이', '000-0000-0000', 'test1@gmail.com', '학생', 'M', '12345', '서울시 종로구', '관철동', 0, 15000, 2, sysdate);

INSERT INTO member(mem_no, mem_id, mem_pic, mem_size, mem_pass, mem_name, mem_tel, mem_mail, mem_job,
mem_sex, mem_zipcode, mem_addr1, mem_addr2, mem_acc, mem_mile, auth_no, mem_date)
VALUES ((SELECT NVL(MAX(mem_no), 0)+1 as mem_no FROM member),
'admin', 'hello.jpg', '15468720', '1234', '왕눈이', '000-0000-0000', 'test1@gmail.com', '학생', 'M', '12345', '서울시 종로구', '관철동', 0, 15000, 2, sysdate);

1-2) 목록
- 검색을 하지 않는 경우, 전체 목록 출력

SELECT mem_no, mem_id, mem_pic, mem_size, mem_pass, mem_name, mem_tel, mem_mail, mem_job, 
mem_sex, mem_zipcode, mem_addr1, mem_addr2, mem_acc, mem_mile, auth_no, mem_date
FROM member
ORDER BY mem_no ASC;
 
  MEM_NO MEM_ID MEM_PIC        MEM_SIZE MEM_PASS MEM_NAME MEM_TEL       MEM_MAIL        MEM_JOB MEM_SEX MEM_ZIPCODE MEM_ADDR1                             MEM_ADDR2 MEM_ACC MEM_MILE AUTH_NO MEM_DATE
 ------ ------ -------------- -------- -------- -------- ------------- --------------- ------- ------- ----------- ------------------------------------- --------- ------- -------- ------- ---------------------
      3 admin  0_Koala.jpg      780831 1234     개발자      010-1234-5678 test1@gmail.com 회사원     M       12345       경기 성남시 분당구 판교역로 4 (백현동)               12311           0        0       1 2018-07-18 16:16:01.0
      4 user   0_Penguins.jpg   777835 1234     개발자      010-1598-7532 test1@gmail.com 학생      M       12345       경기 성남시 분당구 내정로 54 (정자동, 한솔마을주공6단지아파트) 11123           0        0       3 2018-07-18 16:18:42.0
      5 user53 hello.jpg      15468720 1234     왕눈이      000-0000-0000 test1@gmail.com 학생      M       12345       서울시 종로구                               관철동             0    15000       1 2018-07-18 18:32:23.0

1-3) 조회
* user1 회원 정보 보기
SELECT mem_no, mem_id, mem_pic, mem_size, mem_pass, mem_name, mem_tel, mem_mail, mem_job,
mem_sex, mem_zipcode, mem_addr1, mem_addr2, mem_acc, mem_mile, mem_date
FROM member
WHERE mem_no = 3;
 
 MEM_NO MEM_ID MEM_PIC     MEM_SIZE MEM_PASS MEM_NAME MEM_TEL       MEM_MAIL        MEM_JOB MEM_SEX MEM_ZIPCODE MEM_ADDR1               MEM_ADDR2 MEM_ACC MEM_MILE MEM_DATE
 ------ ------ ----------- -------- -------- -------- ------------- --------------- ------- ------- ----------- ----------------------- --------- ------- -------- ---------------------
      3 admin  0_Koala.jpg   780831 1234     개발자      010-1234-5678 test1@gmail.com 회사원     M       12345       경기 성남시 분당구 판교역로 4 (백현동) 12311           0        0 2018-07-18 16:16:01.0

SELECT mem_no, mem_id, mem_pic, mem_size, mem_pass, mem_name, mem_tel, mem_mail, mem_job,
mem_sex, mem_zipcode, mem_addr1, mem_addr2, mem_acc, mem_mile, mem_date
FROM member
WHERE mem_id = 'admin';
 
 MEM_NO MEM_ID MEM_PIC     MEM_SIZE MEM_PASS MEM_NAME MEM_TEL       MEM_MAIL        MEM_JOB MEM_SEX MEM_ZIPCODE MEM_ADDR1               MEM_ADDR2 MEM_ACC MEM_MILE MEM_DATE
 ------ ------ ----------- -------- -------- -------- ------------- --------------- ------- ------- ----------- ----------------------- --------- ------- -------- ---------------------
      3 admin  0_Koala.jpg   780831 1234     개발자      010-1234-5678 test1@gmail.com 회사원     M       12345       경기 성남시 분당구 판교역로 4 (백현동) 12311           0        0 2018-07-18 16:16:01.0

1-4) 수정
--일반회원의 정보수정
UPDATE member 
SET mem_name='호빵맨', mem_pic='hi.jpg', mem_mail='test1@yahoo.co.kr', mem_job='무직', 
      mem_tel='111-1111-1111', mem_zipcode='00000', mem_addr1='경기도', mem_addr2='파주시'
WHERE mem_no=3;

UPDATE member
SET auth_no = 1
WHERE mem_id='admin';

SELECT * FROM member;

 MEM_NO MEM_ID MEM_PIC        MEM_SIZE MEM_PASS MEM_NAME MEM_TEL       MEM_MAIL        AUTH MEM_JOB MEM_SEX MEM_ZIPCODE MEM_ADDR1                             MEM_ADDR2 MEM_ACC MEM_MILE AUTH_NO MEM_DATE
 ------ ------ -------------- -------- -------- -------- ------------- --------------- -------- ------- ------- ----------- ------------------------------------- --------- ------- -------- ------- ---------------------
      4 user   0_Penguins.jpg   777835 1234     개발자      010-1598-7532 test1@gmail.com NULL     학생      M       12345       경기 성남시 분당구 내정로 54 (정자동, 한솔마을주공6단지아파트) 11123           0        0       3 2018-07-18 16:18:42.0
      5 user53 hello.jpg      15468720 1234     왕눈이      000-0000-0000 test1@gmail.com NULL     학생      M       12345       서울시 종로구                               관철동             0    15000       1 2018-07-18 18:32:23.0
      3 admin  0_Koala.jpg      780831 1234     개발자      010-1234-5678 test1@gmail.com NULL     회사원     M       12345       경기 성남시 분당구 판교역로 4 (백현동)               12311           0        0       1 2018-07-18 16:16:01.0

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

 MEM_NO MEM_ID MEM_PIC MEM_SIZE MEM_PASS MEM_NAME MEM_TEL       MEM_MAIL          AUTH         MEM_JOB MEM_SEX MEM_ZIPCODE MEM_ADDR1 MEM_ADDR2 MEM_ACC MEM_MILE MEM_CONFIRM AUTH_NO MEM_DATE
 ------ ------ ------- -------- -------- -------- ------------- ----------------- ---------------- ------- ------- ----------- --------- --------- ------- -------- ----------- ------- ---------------------
      1 user1  hi.jpg  15468720 0000     호빵맨      111-1111-1111 test1@yahoo.co.kr AXD0123456789012 무직      남       00000       경기도       파주시             0        0 Y                 3 2018-06-21 15:05:42.0

1-6) 삭제
* 모두 삭제
DELETE FROM member;

DELETE FROM LOGIN;
 
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

SELECT login_no, mem_no, login_ip, login_date, login_agent
    FROM login
    WHERE mem_no=18
    ORDER BY login_no DESC;

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

SELECT COUNT(*) as cnt
FROM login
WHERE 1=1;

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

3-1) 권한 테이블 생성
CREATE TABLE AUTH(
    AUTH_NO               NUMBER(10)    NOT NULL    PRIMARY KEY,
    AUTH_INFO             VARCHAR2(100)    NOT NULL,
    AUTH_SEQNO          NUMBER(7)    DEFAULT 0     NOT NULL,
    AUTH_RDATE           DATE     NOT NULL
);

COMMENT ON TABLE AUTH is '권한그룹';
COMMENT ON COLUMN AUTH.AUTH_NO is '권한번호';
COMMENT ON COLUMN AUTH.AUTH_INFO is '권한정보';
COMMENT ON COLUMN AUTH.AUTH_SEQNO is '출력순서';
COMMENT ON COLUMN AUTH.AUTH_RDATE is '등록일자';

3-2) insert
- AUTH_INFO 1-관리자, 2-부관리자, 3-일반회원, 4-우수회원, 5-블랙리스트

INSERT INTO auth(auth_no, auth_info, auth_seqno, auth_rdate)
VALUES(1, '관리자', 1, sysdate);

3-3) 일련번호의 자동 생성
SELECT categrpno FROM categrp;

 CATEGRPNO
 ---------------

SELECT MAX(categrpno) FROM categrp; 
 
 MAX(CATEGRPNO)
 ----------------------
           NULL
           
SELECT MAX(categrpno) + 1 FROM categrp;           
           
 MAX(CATEGRPNO)+1
 --------------------------
             NULL

- null인 컬럼의 값을 0으로 변경후 연산
SELECT NVL(MAX(categrpno), 0) + 1 FROM categrp;

 NVL(MAX(CATEGRPNO),0)+1 <-- 컬럼명이 너무 큼
 -----------------------------------
                       1
                       
SELECT NVL(MAX(categrpno), 0) + 1 as categrpno FROM categrp;                       

 CATEGRPNO
 ---------------
         1
         
delete from auth
         
INSERT INTO auth(auth_no, auth_info, auth_seqno, auth_rdate)
VALUES(1, '최고관리자', 0, sysdate);

INSERT INTO auth(auth_no, auth_info, auth_seqno, auth_rdate)
VALUES((SELECT NVL(MAX(auth_no), 99) + 1 as auth_no FROM auth), '우수회원', 1, sysdate);

INSERT INTO auth(auth_no, auth_info, auth_seqno, auth_rdate)
VALUES((SELECT NVL(MAX(auth_no), 99) + 1 as auth_no FROM auth), '일반회원', 2, sysdate);

INSERT INTO auth(auth_no, auth_info, auth_seqno, auth_rdate)
VALUES((SELECT NVL(MAX(auth_no), 99) + 1 as auth_no FROM auth), '손님', 3, sysdate);
         
INSERT INTO auth(auth_no, auth_info, auth_seqno, auth_rdate)
VALUES((SELECT NVL(MAX(auth_no), 99) + 1 as auth_no FROM auth), '블랙리스트', 4, sysdate);
         
delete from auth;
select * from auth;
select * from member;
update member set auth_no = 1 where mem_id = 'admin';



3-4) 목록
SELECT auth_no, auth_info, auth_seqno, auth_rdate
FROM auth
ORDER BY auth_no ASC;

 AUTH_NO AUTH_INFO AUTH_SEQNO AUTH_RDATE
 ------- --------- ---------- ---------------------
       1 관리자                1 2018-07-18 16:07:15.0
       2 부관리자               1 2018-07-18 16:07:16.0
       3 일반회원               1 2018-07-18 16:07:17.0
       4 우수회원               1 2018-07-18 16:07:18.0
       5 블랙리스트              1 2018-07-18 16:07:19.0
 
3-5) 조회
SELECT auth_no, auth_info, auth_seqno, auth_rdate
FROM auth
WHERE auth_no = 1;
  
3-6) 수정
UPDATE auth
SET auth_info='성실회원', auth_seqno = 1
WHERE auth_no = 4;

SELECT auth_no, auth_info, auth_seqno, auth_rdate
FROM auth
ORDER BY auth_no ASC;

 AUTH_NO AUTH_INFO AUTH_SEQNO AUTH_RDATE
 ------- --------- ---------- ---------------------
       1 관리자                1 2018-07-18 16:07:15.0
       2 부관리자               1 2018-07-18 16:07:16.0
       3 일반회원               1 2018-07-18 16:07:17.0
       4 성실회원               1 2018-07-18 16:07:18.0
       5 블랙리스트              1 2018-07-18 16:07:19.0
 
3-7) 삭제
DELETE FROM auth
WHERE auth_no = 5;

4-1) 접속주소 테이블 생성
CREATE TABLE URL(
    URL_NO               NUMBER(10)    NOT NULL    PRIMARY KEY,
    URL             VARCHAR(300)    NOT NULL,
    URL_INFO      VARCHAR(300)    NULL,
    URL_SEQNO   NUMBER(7)    DEFAULT 0     NOT NULL,
    URL_RDATE           DATE     NOT NULL
);

COMMENT ON TABLE URL is '접속주소테이블';
COMMENT ON COLUMN URL.URL_NO is '접속주소번호';
COMMENT ON COLUMN URL.URL is '접속주소';
COMMENT ON COLUMN URL.URL_INFO is '접속주소정보';
COMMENT ON COLUMN URL.URL_SEQNO is '출력순서';
COMMENT ON COLUMN URL.URL_RDATE is '등록일자';

4-2) insert
- 각각의 url번호입력

4-3) 일련번호의 자동 생성
SELECT categrpno FROM categrp;

 CATEGRPNO
 ---------------

SELECT MAX(categrpno) FROM categrp; 
 
 MAX(CATEGRPNO)
 ----------------------
           NULL
           
SELECT MAX(categrpno) + 1 FROM categrp;           
           
 MAX(CATEGRPNO)+1
 --------------------------
             NULL

- null인 컬럼의 값을 0으로 변경후 연산
SELECT NVL(MAX(categrpno), 0) + 1 FROM categrp;

 NVL(MAX(CATEGRPNO),0)+1 <-- 컬럼명이 너무 큼
 -----------------------------------
                       1
                       
SELECT NVL(MAX(categrpno), 0) + 1 as categrpno FROM categrp;                       

 CATEGRPNO
 ---------------
         1

INSERT INTO url(url_no, url, url_info, url_seqno, url_rdate)
VALUES((SELECT NVL(MAX(url_no), 0) + 1 as url_no FROM url), '/member/passwd_update.do', '패스워드 변경 페이지', 1, sysdate);

INSERT INTO url(url_no, url, url_info, url_seqno, url_rdate)
VALUES((SELECT NVL(MAX(url_no), 0) + 1 as url_no FROM url), '/member/list_by_member.do', '회원목록페이지', 1, sysdate);

INSERT INTO url(url_no, url, url_info, url_seqno, url_rdate)
VALUES((SELECT NVL(MAX(url_no), 0) + 1 as url_no FROM url), '/member/list_by_login_admin.do', '회원 로그인 기록 조회페이지',1, sysdate);

4-4) 목록
SELECT url_no, url, url_info, url_seqno, url_rdate
FROM url
ORDER BY url_no ASC;

 URL_NO URL                            URL_INFO        URL_SEQNO URL_RDATE
 ------ ------------------------------ --------------- --------- ---------------------
      1 /member/passwd_update.do       패스워드 변경 페이지             1 2018-07-18 17:27:22.0
      2 /member/list_by_member.do      회원목록페이지                 1 2018-07-18 17:27:23.0
      3 /member/list_by_login_admin.do 회원 로그인 기록 조회페이지         1 2018-07-18 17:27:24.0

 
4-5) 조회
SELECT url_no, url, url_info, url_seqno, url_rdate
FROM url
WHERE url_no=1;
  
4-6) 수정
UPDATE url
SET url='/member/delete_confirm.jsp', url_info = '회원탈퇴 약관페이지'
WHERE url_no = 3;

SELECT url_no, url, url_info, url_seqno, url_rdate
FROM url
ORDER BY url_no ASC;

 URL_NO URL                        URL_INFO    URL_SEQNO URL_RDATE
 ------ -------------------------- ----------- --------- ---------------------
      1 /member/passwd_update.do   패스워드 변경 페이지         1 2018-07-18 17:27:22.0
      2 /member/list_by_member.do  회원목록페이지             1 2018-07-18 17:27:23.0
      3 /member/delete_confirm.jsp 회원탈퇴 약관페이지          1 2018-07-18 17:27:24.0

4-7) 삭제
DELETE FROM url
WHERE url_no = 3;

5-1) 회원 권한별 접근 URL 테이블 생성, count 사용
CREATE TABLE ACCESS_URL(
    ACCESS_URL_NO               NUMBER(10)    NOT NULL    PRIMARY KEY,
    AUTH_NO               NUMBER(10)    NOT NULL,
    URL_NO               NUMBER(10)    NOT NULL,
    ACCESS_URL_INFO      VARCHAR(300)    NULL,
    ACCESS_URL_SEQNO   NUMBER(7)    DEFAULT 0     NOT NULL,
    ACCESS_URL_RDATE           DATE     NOT NULL,
    FOREIGN KEY (AUTH_NO) REFERENCES AUTH(AUTH_NO),
    FOREIGN KEY (URL_NO) REFERENCES URL(URL_NO)
);

COMMENT ON TABLE ACCESS_URL is '권한별접근주소테이블';
COMMENT ON COLUMN ACCESS_URL.ACCESS_URL_NO is '권한별접근주소번호';
COMMENT ON COLUMN ACCESS_URL.AUTH_NO is '권한번호';
COMMENT ON COLUMN ACCESS_URL.URL_NO is '접속주소번호';
COMMENT ON COLUMN ACCESS_URL.ACCESS_URL_INFO is '접근주소정보';
COMMENT ON COLUMN ACCESS_URL.ACCESS_URL_SEQNO is '출력순서';
COMMENT ON COLUMN ACCESS_URL.ACCESS_URL_RDATE is '등록일자';

5-2) 입력
INSERT INTO access_url(access_url_no, auth_no, url_no, access_url_info, access_url_seqno, access_url_rdate)
VALUES((SELECT NVL(MAX(access_url_no), 0) + 1 as access_url_no FROM access_url), 
            1, 1, '관리자-패스워드변경페이지 접근', 1, sysdate);

INSERT INTO access_url(access_url_no, auth_no, url_no, access_url_info, access_url_seqno, access_url_rdate)
VALUES((SELECT NVL(MAX(access_url_no), 0) + 1 as access_url_no FROM access_url), 
            2, 1, '부관리자-패스워드변경페이지 접근', 1, sysdate);
            
INSERT INTO access_url(access_url_no, auth_no, url_no, access_url_info, access_url_seqno, access_url_rdate)
VALUES((SELECT NVL(MAX(access_url_no), 0) + 1 as access_url_no FROM access_url), 
            2, 2, '부관리자-회원목록페이지 접근', 1, sysdate);
            
5-3) 목록
SELECT access_url_no, auth_no, url_no, access_url_info, access_url_seqno, access_url_rdate
FROM access_url
ORDER BY access_url_no ASC;

 ACCESS_URL_NO AUTH_NO URL_NO ACCESS_URL_INFO   ACCESS_URL_SEQNO ACCESS_URL_RDATE
 ------------- ------- ------ ----------------- ---------------- ---------------------
             1       1      1 관리자-패스워드변경페이지 접근                 1 2018-07-18 18:10:47.0
             2       2      1 부관리자-패스워드변경페이지 접근                1 2018-07-18 18:10:48.0
             3       2      2 부관리자-회원목록페이지 접근                  1 2018-07-18 18:10:49.0
            
5-4) 접근 가능(1 : 접근 가능, 0 : 접근 불가)
SELECT COUNT(access_url_no) as cnt
FROM access_url
WHERE auth_no=2 AND url_no=2;

 CNT
 ---
   1
   
SELECT COUNT(access_url_no) as cnt
FROM access_url
WHERE auth_no=3 AND url_no=2;

 CNT
 ---
   0

5-5) 조회
SELECT access_url_no, auth_no, url_no, access_url_info, access_url_seqno, access_url_rdate
FROM access_url
WHERE auth_no = 2
ORDER BY access_url_no ASC;

 ACCESS_URL_NO AUTH_NO URL_NO ACCESS_URL_INFO   ACCESS_URL_SEQNO ACCESS_URL_RDATE
 ------------- ------- ------ ----------------- ---------------- ---------------------
             2       2      1 부관리자-패스워드변경페이지 접근                1 2018-07-18 18:10:48.0
             3       2      2 부관리자-회원목록페이지 접근                  1 2018-07-18 18:10:49.0

5-6) 수정
UPDATE access_url
SET auth_no=1
WHERE access_url_no = 3;

SELECT access_url_no, auth_no, url_no, access_url_info, access_url_seqno, access_url_rdate
FROM access_url
ORDER BY access_url_no ASC;

 ACCESS_URL_NO AUTH_NO URL_NO ACCESS_URL_INFO   ACCESS_URL_SEQNO ACCESS_URL_RDATE
 ------------- ------- ------ ----------------- ---------------- ---------------------
             1       1      1 관리자-패스워드변경페이지 접근                 1 2018-07-18 18:10:47.0
             2       2      1 부관리자-패스워드변경페이지 접근                1 2018-07-18 18:10:48.0
             3       1      2 부관리자-회원목록페이지 접근                  1 2018-07-18 18:10:49.0

5-7) 삭제
DELETE FROM access_url
WHERE url_no = 3;
