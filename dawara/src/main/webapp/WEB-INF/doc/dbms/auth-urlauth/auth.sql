drop table buysell;
drop table card;
drop table MYMLIEAGE;
drop table CHARGEMILEAGE;
drop table CHARGEWAY;

drop table dealstate;
drop table dealway;
drop table notice;
drop table report;
drop table payway;
drop table qna;
drop table savecash;
drop table savepoint;


drop table deal;     
drop table shipping;

drop table buy;      
drop table cart;     
drop table reply;    
drop table product;

drop table category; 
drop table categrp; 
drop table surf;    

drop table notice;
drop table qna;
drop table report;

drop table login;
drop table member;
drop table mem_auth;
drop table URL;
drop table ACCESS_URL;
drop table urlauth;
drop table auth;
----------------------------------------
delete from deal;
delete from shipping;

delete from buy;
delete from product;
delete from cart;
delete from reply;

delete from category;
delete from categrp;
delete from surf;

delete from login;
delete from member;

delete from urlauth;
delete from auth;

/**********************************/ 
/* Table Name: 권한 */
/**********************************/

1. 테이블
- 권한 테이블
- 가입자별 권한 부여
CREATE TABLE AUTH(
    AUTH_NO                            NUMBER(10)    NOT NULL    PRIMARY KEY,
    AUTH_INFO                          VARCHAR2(100)    NOT NULL
);

COMMENT ON TABLE AUTH is '권한';
COMMENT ON COLUMN AUTH.AUTH_NO is '권한 번호';
COMMENT ON COLUMN AUTH.AUTH_INFO is '권한 정보';

select * from auth


2. 등록
- 권한 등록
  INSERT INTO auth(AUTH_NO, AUTH_INFO)   
  VALUES((select nvl(max(auth_no), 0) + 1 as auth_no from auth), '관리자');
  
--  INSERT INTO auth(AUTH_NO, AUTH_INFO)   
--  VALUES((select nvl(max(auth_no), 0) + 1 as auth_no from auth), '보조 관리자');
  
  INSERT INTO auth(AUTH_NO, AUTH_INFO)    
  VALUES((select nvl(max(auth_no), 0) + 1 as auth_no from auth), '일반 회원');
  
--  INSERT INTO auth(AUTH_NO, AUTH_INFO)    
--  VALUES((select nvl(max(auth_no), 0) + 1 as auth_no from auth), '우수 회원');
  
  INSERT INTO auth(AUTH_NO, AUTH_INFO)    
  VALUES((select nvl(max(auth_no), 0) + 1 as auth_no from auth), '블랙 리스트');
  
--  INSERT INTO auth(AUTH_NO, AUTH_INFO)    
--  VALUES((select nvl(max(auth_no), 0) + 1 as auth_no from auth), '탈퇴 회원');



3. 목록 
- 권한 목록
  SELECT AUTH_NO, AUTH_INFO
  FROM auth
  ORDER BY AUTH_NO;     

 AUTH_NO AUTH_INFO
 ------- ---------
       1 관리자
       2 보조 관리자
       3 일반 회원
       4 우수 회원
       5 블랙 리스트
       6 탈퇴 회원

      

4. 조회
- 권한 번호가 '3'인 권한의 권한 정보 조회
  SELECT AUTH_NO, AUTH_INFO
  FROM auth
  WHERE AUTH_NO = '3';

 AUTH_NO AUTH_INFO
 ------- ---------
       3 일반 회원
      
  

5. 수정
- 권한 번호가 '5'인 권한의 권한 정보를 '관심 회원' 으로 변경
  UPDATE auth
  SET auth_info = '관심 회원'
  WHERE auth_no = '5';
  
  SELECT auth_no, auth_info
  FROM auth
  WHERE auth_no = '5';
  
 AUTH_NO AUTH_INFO
 ------- ---------
       5 관심 회원
  
  

6. 삭제
- 권한 번호가 '5'인 권한을 삭제
  DELETE FROM auth
  WHERE auth_no = '5';
  
  SELECT auth_no, auth_info
  FROM auth
  WHERE auth_no = '5';

 AUTH_NO AUTH_INFO
 ------- ---------
 


/**********************************/
/* Table Name: 회원 */
/**********************************/

CREATE TABLE MEMBER(
    MEM_NO                            NUMBER(6)    NOT NULL    PRIMARY KEY,
    AUTH_NO                            NUMBER(10)     NOT NULL,
    CREDITNO                          NUMBER(10)     NOT NULL,
    MEM_ID                            VARCHAR2(20)     NOT NULL,
    MEM_PIC                           VARCHAR2(100)    NULL ,
    MEM_PASS                          VARCHAR2(60)     NOT NULL,
    MEM_NAME                          VARCHAR2(20)     NOT NULL,
    MEM_TEL                           VARCHAR2(14)     NOT NULL,
    MEM_MAIL                          VARCHAR2(20)     NOT NULL,
    MEM_JOB                           VARCHAR2(20)     NOT NULL,
    MEM_ZIPCODE                       VARCHAR2(5)    NULL ,
    MEM_ADDR1                         VARCHAR2(80)     NULL ,
    MEM_ADDR2                         VARCHAR2(50)     NULL ,
    MEM_ACC                           NUMBER(6)    NOT NULL,
    MEM_CONFIRM                       VARCHAR2(1)    NOT NULL,
    MEM_DATE                          DATE     NOT NULL,
  FOREIGN KEY (AUTH_NO) REFERENCES AUTH (AUTH_NO),
  FOREIGN KEY (CREDITNO) REFERENCES CREDIT (CREDITNO),
  CONSTRAINT SYS_C007461 UNIQUE (MEM_ID)
);
 
COMMENT ON TABLE MEMBER is '회원';
COMMENT ON COLUMN MEMBER.MEM_NO is '회원 번호';
COMMENT ON COLUMN MEMBER.AUTH_NO is '권한 번호';
COMMENT ON COLUMN MEMBER.CREDITNO is '신용등급 번호';
COMMENT ON COLUMN MEMBER.MEM_ID is '아이디';
COMMENT ON COLUMN MEMBER.MEM_PIC is '회원사진';
COMMENT ON COLUMN MEMBER.MEM_PASS is '패스워드';
COMMENT ON COLUMN MEMBER.MEM_NAME is '성명';
COMMENT ON COLUMN MEMBER.MEM_TEL is '전화번호';
COMMENT ON COLUMN MEMBER.MEM_MAIL is '이메일주소';
COMMENT ON COLUMN MEMBER.MEM_JOB is '회원직업';
COMMENT ON COLUMN MEMBER.MEM_ZIPCODE is '우편번호';
COMMENT ON COLUMN MEMBER.MEM_ADDR1 is '주소1';
COMMENT ON COLUMN MEMBER.MEM_ADDR2 is '주소2';
COMMENT ON COLUMN MEMBER.MEM_ACC is '신고횟수';
COMMENT ON COLUMN MEMBER.MEM_CONFIRM is '메일확인여부';
COMMENT ON COLUMN MEMBER.MEM_DATE is '가입일';


SELECT auth_no, auth_info
FROM auth
WHERE auth_info LIKE '%호구%'
order by auth_no ASC
 

SELECT auth_no, auth_info, r
FROM(
         SELECT auth_no, auth_info, rownum as r
         FROM (
                   SELECT auth_no, auth_info 
                   FROM auth
                   ORDER BY auth_no ASC
         )  
)
WHERE r>=1 AND r <=3;



