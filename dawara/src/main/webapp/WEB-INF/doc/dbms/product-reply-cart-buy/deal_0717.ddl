DROP TABLE BUY CASCADE CONSTRAINTS;
DROP TABLE payment CASCADE CONSTRAINTS;
DROP TABLE DEAL CASCADE CONSTRAINTS;
DROP TABLE shipping CASCADE CONSTRAINTS;
DROP TABLE PRODUCT CASCADE CONSTRAINTS;
DROP TABLE MEMBER CASCADE CONSTRAINTS;

/**********************************/
/* Table Name: 회원 */
/**********************************/
CREATE TABLE MEMBER(
		MEM_NO                        		NUMBER(6)		 NOT NULL		 PRIMARY KEY,
		AUTH_NO                       		NUMBER(10)		 NOT NULL,
		MEM_ID                        		VARCHAR2(20)		 NOT NULL,
		MEM_PIC                       		VARCHAR2(100)		 NULL ,
		MEM_PASS                      		VARCHAR2(60)		 NOT NULL,
		MEM_NAME                      		VARCHAR2(20)		 NOT NULL,
		MEM_TEL                       		VARCHAR2(14)		 NOT NULL,
		MEM_MAIL                      		VARCHAR2(20)		 NOT NULL,
		MEM_JOB                       		VARCHAR2(20)		 NOT NULL,
		MEM_ZIPCODE                   		VARCHAR2(5)		 NULL ,
		MEM_ADDR1                     		VARCHAR2(80)		 NULL ,
		MEM_ADDR2                     		VARCHAR2(50)		 NULL ,
		MEM_ACC                       		NUMBER(6)		 NOT NULL,
		MEM_CONFIRM                   		VARCHAR2(1)		 NOT NULL,
		MEM_DATE                      		DATE		 NOT NULL,
		MEM_MILE                      		NUMBER(9)		 NULL ,
  CONSTRAINT SYS_C007769 UNIQUE (MEM_ID)
);

COMMENT ON TABLE MEMBER is '회원';
COMMENT ON COLUMN MEMBER.MEM_NO is '회원 번호';
COMMENT ON COLUMN MEMBER.AUTH_NO is '인증 번호';
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
COMMENT ON COLUMN MEMBER.MEM_MILE is '회원 마일리지';


/**********************************/
/* Table Name: 상품 */
/**********************************/
CREATE TABLE PRODUCT(
		PR_NO                         		NUMBER(7)		 NOT NULL		 PRIMARY KEY,
		GORY_NO                       		NUMBER(7)		 NULL ,
		MEM_NO                        		NUMBER(6)		 NULL ,
		PR_TITLE                      		VARCHAR2(300)		 NOT NULL,
		PR_CONTENTS                   		CLOB(4000)		 NULL ,
		PR_THUMBS                     		VARCHAR2(1000)		 NULL ,
		PR_FILES                      		VARCHAR2(1000)		 NULL ,
		PR_SIZES                      		VARCHAR2(1000)		 NULL ,
		PR_CNT                        		NUMBER(7)		 NOT NULL,
		PR_RDATE                      		DATE		 NOT NULL,
		PR_BUYYEAR                    		DATE		 NULL ,
		PR_STATE                      		VARCHAR2(1000)		 NULL ,
		PR_TRANSACTION                		VARCHAR2(1000)		 NULL ,
		PR_LOCAL                      		VARCHAR2(1000)		 NULL ,
		PR_BUYPRICE                   		NUMBER(10)		 NOT NULL,
		PR_PRICE                      		NUMBER(10)		 NOT NULL,
		PR_VISIBLE                    		CHAR(1)		 NOT NULL,
		PR_PAYMENT                    		CHAR(1)		 NOT NULL,
		mem_no                        		NUMBER(6)		 NULL ,
  FOREIGN KEY (MEM_NO) REFERENCES MEMBER (MEM_NO)
);

COMMENT ON TABLE PRODUCT is '상품';
COMMENT ON COLUMN PRODUCT.PR_NO is '상품 번호';
COMMENT ON COLUMN PRODUCT.GORY_NO is '카테고리번호';
COMMENT ON COLUMN PRODUCT.MEM_NO is '회원 번호';
COMMENT ON COLUMN PRODUCT.PR_TITLE is '제목';
COMMENT ON COLUMN PRODUCT.PR_CONTENTS is '내용';
COMMENT ON COLUMN PRODUCT.PR_THUMBS is 'thumbs 파일';
COMMENT ON COLUMN PRODUCT.PR_FILES is '파일들의 이름';
COMMENT ON COLUMN PRODUCT.PR_SIZES is '파일들의 크기';
COMMENT ON COLUMN PRODUCT.PR_CNT is '조회수';
COMMENT ON COLUMN PRODUCT.PR_RDATE is '등록일';
COMMENT ON COLUMN PRODUCT.PR_BUYYEAR is '구입 시기';
COMMENT ON COLUMN PRODUCT.PR_STATE is '제품 상태';
COMMENT ON COLUMN PRODUCT.PR_TRANSACTION is '거래 방식';
COMMENT ON COLUMN PRODUCT.PR_LOCAL is '거래 지역';
COMMENT ON COLUMN PRODUCT.PR_BUYPRICE is '구입 가격';
COMMENT ON COLUMN PRODUCT.PR_PRICE is '판매 가격';
COMMENT ON COLUMN PRODUCT.PR_VISIBLE is '출력 여부';
COMMENT ON COLUMN PRODUCT.PR_PAYMENT is '결제';
COMMENT ON COLUMN PRODUCT.mem_no is '회원번호';


/**********************************/
/* Table Name: 상품 배송 */
/**********************************/
CREATE TABLE shipping(
		ship_no                       		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		ship_zipcode                  		VARCHAR2(5)		 NOT NULL,
		ship_addr1                    		VARCHAR2(80)		 NOT NULL,
		ship_addr2                    		VARCHAR2(50)		 NOT NULL,
		ship_rname                    		VARCHAR2(20)		 NOT NULL,
		ship_rtel                     		VARCHAR2(14)		 NOT NULL,
		ship_memo                     		VARCHAR2(100)		 NULL ,
		ship_date                     		DATE		 NOT NULL,
		ship_check                    		CHAR(1)		 DEFAULT 'N'		 NOT NULL,
		PR_NO                         		NUMBER(7)		 NOT NULL,
		MEM_NO                        		NUMBER(6)		 NULL ,
  FOREIGN KEY (PR_NO) REFERENCES PRODUCT (PR_NO)
);

COMMENT ON TABLE shipping is '상품 배송';
COMMENT ON COLUMN shipping.ship_no is '배송번호';
COMMENT ON COLUMN shipping.ship_zipcode is '우편번호';
COMMENT ON COLUMN shipping.ship_addr1 is '배송지1';
COMMENT ON COLUMN shipping.ship_addr2 is '배송지2';
COMMENT ON COLUMN shipping.ship_rname is '배송받는사람';
COMMENT ON COLUMN shipping.ship_rtel is '받는사람휴대폰';
COMMENT ON COLUMN shipping.ship_memo is '배송시 요청사항';
COMMENT ON COLUMN shipping.ship_date is '발송날짜';
COMMENT ON COLUMN shipping.ship_check is '발송확인';
COMMENT ON COLUMN shipping.PR_NO is '상품 번호';
COMMENT ON COLUMN shipping.MEM_NO is '회원 번호';


/**********************************/
/* Table Name: 상품 거래 */
/**********************************/
CREATE TABLE DEAL(
		DEAL_NO                       		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		D_STATE                       		VARCHAR2(20)		 NOT NULL,
		D_DATE                        		DATE		 NOT NULL,
		D_CHECK                       		CHAR(1)		 NOT NULL,
		D_MEMO                        		VARCHAR2(100)		 NULL ,
		MEM_NO                        		NUMBER(6)		 NOT NULL,
		PR_NO                         		NUMBER(10)		 NOT NULL,
  FOREIGN KEY (PR_NO) REFERENCES PRODUCT (PR_NO)
);

COMMENT ON TABLE DEAL is '상품 거래';
COMMENT ON COLUMN DEAL.DEAL_NO is '거래번호';
COMMENT ON COLUMN DEAL.D_STATE is '거래상태';
COMMENT ON COLUMN DEAL.D_DATE is '거래등록일';
COMMENT ON COLUMN DEAL.D_CHECK is '거래확인';
COMMENT ON COLUMN DEAL.D_MEMO is '거래메모';
COMMENT ON COLUMN DEAL.MEM_NO is '회원번호';
COMMENT ON COLUMN DEAL.PR_NO is '상품번호';


/**********************************/
/* Table Name: 결제 */
/**********************************/
CREATE TABLE payment(
		payment_no                    		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		ship_no                       		NUMBER(10)		 NULL ,
  FOREIGN KEY (ship_no) REFERENCES shipping (ship_no)
);

COMMENT ON TABLE payment is '결제';
COMMENT ON COLUMN payment.payment_no is '결제번호';
COMMENT ON COLUMN payment.ship_no is '배송번호';


/**********************************/
/* Table Name: BUY */
/**********************************/
CREATE TABLE BUY(
		BUY_NO                        		NUMBER(6)		 NOT NULL		 PRIMARY KEY,
		PR_NO                         		NUMBER(7)		 NULL ,
		MEM_NO                        		NUMBER(6)		 NULL ,
		BUY_RDATE                     		DATE		 NOT NULL,
		BUY_VISIBLE                   		CHAR(1)		 NOT NULL,
		payment_no                    		NUMBER(10)		 NULL ,
  FOREIGN KEY (MEM_NO) REFERENCES MEMBER (MEM_NO),
  FOREIGN KEY (PR_NO) REFERENCES PRODUCT (PR_NO),
  FOREIGN KEY (payment_no) REFERENCES payment (payment_no)
);

COMMENT ON TABLE BUY is 'BUY';
COMMENT ON COLUMN BUY.BUY_NO is 'BUY_NO';
COMMENT ON COLUMN BUY.PR_NO is 'PR_NO';
COMMENT ON COLUMN BUY.MEM_NO is 'MEM_NO';
COMMENT ON COLUMN BUY.BUY_RDATE is 'BUY_RDATE';
COMMENT ON COLUMN BUY.BUY_VISIBLE is 'BUY_VISIBLE';
COMMENT ON COLUMN BUY.payment_no is '결제번호';


