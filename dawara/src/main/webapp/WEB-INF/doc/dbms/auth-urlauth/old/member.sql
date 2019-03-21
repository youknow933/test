1) 회원 테이블 생성
CREATE TABLE member (
  mem_no       NUMBER(6) NOT NULL     PRIMARY KEY, -- 회원 번호, 레코드를 구분하는 컬럼 
  auth_no                            NUMBER(10)     NOT NULL, --인증 번호
  mem_id           VARCHAR(20)   NOT NULL UNIQUE, -- 아이디, 중복 안됨, 레코드를 구분 
  mem_pic       VARCHAR(100)    NULL,     -- 회원사진
  mem_pass    VARCHAR(60)   NOT NULL, -- 패스워드, 영숫자 조합
  mem_name    VARCHAR(20)   NOT NULL, -- 성명, 한글 10자 저장 가능
  mem_tel          VARCHAR(14)   NOT NULL, -- 전화번호
  mem_mail      VARCHAR(20)     NOT NULL, -- 이메일
  mem_job         VARCHAR(20)     NOT NULL, -- 회원직업
  mem_zipcode   VARCHAR(5)        NULL, -- 우편번호, 12345
  mem_addr1  VARCHAR(80)       NULL, -- 주소 1
  mem_addr2  VARCHAR(50)       NULL, -- 주소 2    
  mem_acc   NUMBER(6)   DEFAULT 0 NOT NULL,   -- 회원의 신고당한횟수
  mem_mile   NUMBER(9)   DEFAULT 0 NOT NULL,   -- 회원 마일리지(구매용)
  mem_confirm    VARCHAR(1)         DEFAULT 'N' NOT NULL, -- 이메일 링크 클릭 여부, Y:클릭, N:클릭안함
  mem_act   NUMBER(6) DEFAULT 3 NOT NULL, -- 회원 권한 번호
  mem_date     DATE             NOT NULL, -- 가입일    
    FOREIGN KEY (auth_no) REFERENCES AUTH (auth_no)
);

ALTER TABLE MEMBER ADD mem_mile NUMBER(9); --mem_mile 컬럼 추가
ALTER TABLE MEMBER RENAME COLUMN mem_rdate TO mem_date;
ALTER TABLE MEMBER RENAME COLUMN authno TO auth_no;

drop table member;

COMMENT ON TABLE member is '회원'; 
COMMENT ON COLUMN member.MEM_NO is '회원 번호';
COMMENT ON COLUMN member.auth_no is '인증 번호';
COMMENT ON COLUMN member.MEM_ID is '아이디';
COMMENT ON COLUMN member.MEM_PIC is '회원사진';
COMMENT ON COLUMN member.MEM_PASS is '패스워드';
COMMENT ON COLUMN member.MEM_NAME is '성명';
COMMENT ON COLUMN member.MEM_TEL is '전화번호';
COMMENT ON COLUMN member.MEM_MAIL is '이메일주소';
COMMENT ON COLUMN member.MEM_JOB is '회원직업';
COMMENT ON COLUMN member.mem_zipcode is '우편번호';
COMMENT ON COLUMN member.MEM_ADDR1 is '주소1';
COMMENT ON COLUMN member.MEM_ADDR2 is '주소2';
COMMENT ON COLUMN member.MEM_ACC is '신고횟수';
COMMENT ON COLUMN member.MEM_mile is '회원 마일리지';
COMMENT ON COLUMN member.MEM_CONFIRM is '메일확인여부';
COMMENT ON COLUMN member.MEM_ACT is '회원권한번호'; -- 1: 관리자, 2: 부관리자, 3: 일반회원, 4: 우수회원, 5:블랙리스트
COMMENT ON COLUMN member.mem_date is '가입일';

