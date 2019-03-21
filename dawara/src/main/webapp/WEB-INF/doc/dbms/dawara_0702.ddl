DROP TABLE MYMLIEAGE CASCADE CONSTRAINTS;
DROP TABLE CHARGEMILEAGE CASCADE CONSTRAINTS;
DROP TABLE CHARGEWAY CASCADE CONSTRAINTS;
DROP TABLE DEAL CASCADE CONSTRAINTS;
DROP TABLE URLAUTH CASCADE CONSTRAINTS;
DROP TABLE REPLY CASCADE CONSTRAINTS;
DROP TABLE CART CASCADE CONSTRAINTS;
DROP TABLE PRODUCT CASCADE CONSTRAINTS;
DROP TABLE SURF CASCADE CONSTRAINTS;
DROP TABLE CATEGORY CASCADE CONSTRAINTS;
DROP TABLE CATEGRP CASCADE CONSTRAINTS;
DROP TABLE REPORT CASCADE CONSTRAINTS;
DROP TABLE QNA CASCADE CONSTRAINTS;
DROP TABLE NOTICE CASCADE CONSTRAINTS;
DROP TABLE LOGIN CASCADE CONSTRAINTS;
DROP TABLE MEMBER CASCADE CONSTRAINTS;
DROP TABLE AUTH CASCADE CONSTRAINTS;

/**********************************/
/* Table Name: 권한 */
/**********************************/
CREATE TABLE AUTH(
		AUTH_NO                       		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		AUTH_INFO                     		VARCHAR2(100)		 NOT NULL
);

COMMENT ON TABLE AUTH is '권한';
COMMENT ON COLUMN AUTH.AUTH_NO is '권한 번호';
COMMENT ON COLUMN AUTH.AUTH_INFO is '권한 정보';


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
  FOREIGN KEY (AUTH_NO) REFERENCES AUTH (AUTH_NO),
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
/* Table Name: 로그인 */
/**********************************/
CREATE TABLE LOGIN(
		LOGIN_NO                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		MEM_NO                        		NUMBER(6)		 NOT NULL,
		LOGIN_IP                      		VARCHAR2(15)		 NOT NULL,
		LOGIN_DATE                    		DATE		 NOT NULL,
  FOREIGN KEY (MEM_NO) REFERENCES MEMBER (MEM_NO)
);

COMMENT ON TABLE LOGIN is '로그인';
COMMENT ON COLUMN LOGIN.LOGIN_NO is '로그인번호';
COMMENT ON COLUMN LOGIN.MEM_NO is '회원번호';
COMMENT ON COLUMN LOGIN.LOGIN_IP is 'login_ip';
COMMENT ON COLUMN LOGIN.LOGIN_DATE is '로그인날짜';


/**********************************/
/* Table Name: NOTICE */
/**********************************/
CREATE TABLE NOTICE(
		NO_NO                         		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		MEM_NO                        		NUMBER(10)		 NOT NULL,
		NO_TITLE                      		VARCHAR2(100)		 NOT NULL,
		NO_WRITE                      		VARCHAR2(15)		 NOT NULL,
		NO_RDATE                      		DATE		 NOT NULL,
		NO_QNA_CNT                    		NUMBER(10)		 NOT NULL,
		NO_QNA_CONTENTS               		VARCHAR2(4000)		 NOT NULL,
		NO_VISIBLE                    		CHAR(1)		 NOT NULL,
  FOREIGN KEY (MEM_NO) REFERENCES MEMBER (MEM_NO)
);

COMMENT ON TABLE NOTICE is 'NOTICE';
COMMENT ON COLUMN NOTICE.NO_NO is '번호';
COMMENT ON COLUMN NOTICE.MEM_NO is '관리자 번호';
COMMENT ON COLUMN NOTICE.NO_TITLE is '제목';
COMMENT ON COLUMN NOTICE.NO_WRITE is '글쓴이';
COMMENT ON COLUMN NOTICE.NO_RDATE is '등록일';
COMMENT ON COLUMN NOTICE.NO_QNA_CNT is '조회수';
COMMENT ON COLUMN NOTICE.NO_QNA_CONTENTS is '내용';
COMMENT ON COLUMN NOTICE.NO_VISIBLE is '공개 여부';


/**********************************/
/* Table Name: QNA */
/**********************************/
CREATE TABLE QNA(
		QNA_NO                        		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		MEM_NO                        		NUMBER(10)		 NOT NULL,
		QNA_WIRTE                     		VARCHAR2(20)		 NOT NULL,
		QNA_EMAIL                     		VARCHAR2(100)		 NULL ,
		NO_TITLE                      		VARCHAR2(200)		 NOT NULL,
		QNA_CONTENT                   		VARCHAR2(4000)		 NOT NULL,
		QNA_PASSWD                    		VARCHAR2(15)		 NOT NULL,
		QNA_CNT                       		NUMBER(10)		 NOT NULL,
		QNA_RDATE                     		DATE		 NOT NULL,
		QNA_WEB                       		VARCHAR2(100)		 NULL ,
		QNA_FILE1                     		VARCHAR2(100)		 NULL ,
		QNA_FSTOR1                    		VARCHAR2(100)		 NULL ,
		QNA_SIZE1                     		NUMBER(10)		 NOT NULL,
		QNA_VISIBLE                   		CHAR(1)		 NOT NULL,
		QNA_GRPNO                     		NUMBER(10)		 NOT NULL,
		QNA_INDENT                    		NUMBER(5)		 NOT NULL,
		QNA_ANSNUM                    		NUMBER(5)		 NOT NULL,
  FOREIGN KEY (MEM_NO) REFERENCES MEMBER (MEM_NO)
);

COMMENT ON TABLE QNA is 'QNA';
COMMENT ON COLUMN QNA.QNA_NO is '글 일련 번호';
COMMENT ON COLUMN QNA.MEM_NO is '회원 번호';
COMMENT ON COLUMN QNA.QNA_WIRTE is '글쓴이';
COMMENT ON COLUMN QNA.QNA_EMAIL is '이메일';
COMMENT ON COLUMN QNA.NO_TITLE is '제목';
COMMENT ON COLUMN QNA.QNA_CONTENT is '글 내용';
COMMENT ON COLUMN QNA.QNA_PASSWD is '글 일련 번호';
COMMENT ON COLUMN QNA.QNA_CNT is '조회수';
COMMENT ON COLUMN QNA.QNA_RDATE is '등록 날짜';
COMMENT ON COLUMN QNA.QNA_WEB is 'URL';
COMMENT ON COLUMN QNA.QNA_FILE1 is '파일명';
COMMENT ON COLUMN QNA.QNA_FSTOR1 is '실제 저장 파일명';
COMMENT ON COLUMN QNA.QNA_SIZE1 is '파일 크기 1';
COMMENT ON COLUMN QNA.QNA_VISIBLE is '숨기기';
COMMENT ON COLUMN QNA.QNA_GRPNO is '그룹 번호';
COMMENT ON COLUMN QNA.QNA_INDENT is '답변 차수';
COMMENT ON COLUMN QNA.QNA_ANSNUM is '답변 순서';


/**********************************/
/* Table Name: REPORT */
/**********************************/
CREATE TABLE REPORT(
		RPT_NO                        		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		MEM_NO                        		NUMBER(10)		 NOT NULL,
		RPT_WRITE                     		VARCHAR2(20)		 NOT NULL,
		RPT_EMAIL                     		VARCHAR2(100)		 NULL ,
		RPT_TITLE                     		VARCHAR2(200)		 NOT NULL,
		RPT_CONTENT                   		VARCHAR2(4000)		 NOT NULL,
		RPT_PASSWD                    		VARCHAR2(15)		 NOT NULL,
		RPT_CNT                       		NUMBER(10)		 NOT NULL,
		RPT_RDATE                     		DATE		 NOT NULL,
		RPT_WEB                       		VARCHAR2(100)		 NULL ,
		RPT_FILE1                     		VARCHAR2(100)		 NULL ,
		RPT_FSTOR1                    		VARCHAR2(100)		 NULL ,
		RPT_SIZE1                     		NUMBER(10)		 NOT NULL,
		RPT_VISIBLE                   		CHAR(1)		 NOT NULL,
		RPT_GRPNO                     		NUMBER(10)		 NOT NULL,
		RPT_INDENT                    		NUMBER(5)		 NOT NULL,
		RPT_ANSNUM                    		NUMBER(5)		 NOT NULL,
  FOREIGN KEY (MEM_NO) REFERENCES MEMBER (MEM_NO)
);

COMMENT ON TABLE REPORT is 'REPORT';
COMMENT ON COLUMN REPORT.RPT_NO is '글 일련 번호';
COMMENT ON COLUMN REPORT.MEM_NO is '회원 번호';
COMMENT ON COLUMN REPORT.RPT_WRITE is '글쓴이';
COMMENT ON COLUMN REPORT.RPT_EMAIL is '이메일';
COMMENT ON COLUMN REPORT.RPT_TITLE is '제목';
COMMENT ON COLUMN REPORT.RPT_CONTENT is '글 내용';
COMMENT ON COLUMN REPORT.RPT_PASSWD is '글 일련 번호';
COMMENT ON COLUMN REPORT.RPT_CNT is '조회수';
COMMENT ON COLUMN REPORT.RPT_RDATE is '등록 날짜';
COMMENT ON COLUMN REPORT.RPT_WEB is 'URL';
COMMENT ON COLUMN REPORT.RPT_FILE1 is '파일명';
COMMENT ON COLUMN REPORT.RPT_FSTOR1 is '실제 저장 파일명';
COMMENT ON COLUMN REPORT.RPT_SIZE1 is '파일 크기 1';
COMMENT ON COLUMN REPORT.RPT_VISIBLE is '숨기기';
COMMENT ON COLUMN REPORT.RPT_GRPNO is '그룹 번호';
COMMENT ON COLUMN REPORT.RPT_INDENT is '답변 차수';
COMMENT ON COLUMN REPORT.RPT_ANSNUM is '답변 순서';


/**********************************/
/* Table Name: 카테고리 그룹 */
/**********************************/
CREATE TABLE CATEGRP(
		GRP_NO                        		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		GRP_CLASSIFICATION            		NUMBER(1)		 NOT NULL,
		GRP_TITLE                     		VARCHAR2(50)		 NOT NULL,
		GRP_SEQNO                     		NUMBER(7)		 NOT NULL,
		GRP_VISIBLE                   		CHAR(1)		 NOT NULL,
		GRP_RDATE                     		DATE		 NOT NULL,
		MEM_NO                        		NUMBER(6)		 NULL ,
  FOREIGN KEY (MEM_NO) REFERENCES MEMBER (MEM_NO)
);

COMMENT ON TABLE CATEGRP is '카테고리 그룹';
COMMENT ON COLUMN CATEGRP.GRP_NO is '카테고리 그룹 번호';
COMMENT ON COLUMN CATEGRP.GRP_CLASSIFICATION is '카테고리 그룹 분류';
COMMENT ON COLUMN CATEGRP.GRP_TITLE is '그룹 이름';
COMMENT ON COLUMN CATEGRP.GRP_SEQNO is '출력 순서';
COMMENT ON COLUMN CATEGRP.GRP_VISIBLE is '출력 모드';
COMMENT ON COLUMN CATEGRP.GRP_RDATE is '그룹 생성일';
COMMENT ON COLUMN CATEGRP.MEM_NO is '회원 번호';


/**********************************/
/* Table Name: 카테고리 */
/**********************************/
CREATE TABLE CATEGORY(
		GORY_NO                       		NUMBER(7)		 NOT NULL		 PRIMARY KEY,
		GRP_NO                        		NUMBER(10)		 NOT NULL,
		MEM_NO                        		NUMBER(6)		 NOT NULL,
		GORY_TITLE                    		VARCHAR2(50)		 NOT NULL,
		GORY_SEQNO                    		NUMBER(3)		 NOT NULL,
		GORY_VISIBLE                  		CHAR(1)		 NOT NULL,
		GORY_IDS                      		VARCHAR2(100)		 NULL ,
		GORY_CNT                      		NUMBER(6)		 NOT NULL,
		GORY_RDATE                    		DATE		 NOT NULL,
  FOREIGN KEY (MEM_NO) REFERENCES MEMBER (MEM_NO),
  FOREIGN KEY (GRP_NO) REFERENCES CATEGRP (GRP_NO)
);

COMMENT ON TABLE CATEGORY is '카테고리';
COMMENT ON COLUMN CATEGORY.GORY_NO is '카테고리 번호';
COMMENT ON COLUMN CATEGORY.GRP_NO is '카테고리 그룹 번호';
COMMENT ON COLUMN CATEGORY.MEM_NO is '회원 번호';
COMMENT ON COLUMN CATEGORY.GORY_TITLE is '게시판 이름';
COMMENT ON COLUMN CATEGORY.GORY_SEQNO is '출력 순서';
COMMENT ON COLUMN CATEGORY.GORY_VISIBLE is '출력 모드';
COMMENT ON COLUMN CATEGORY.GORY_IDS is '접근 계정';
COMMENT ON COLUMN CATEGORY.GORY_CNT is '등록된 글 수';
COMMENT ON COLUMN CATEGORY.GORY_RDATE is '등록일';


/**********************************/
/* Table Name: 검색어 */
/**********************************/
CREATE TABLE SURF(
		SURF_NO                       		NUMBER(7)		 NOT NULL		 PRIMARY KEY,
		SURF_WORD                     		VARCHAR2(300)		 NOT NULL,
		SURF_CNT                      		NUMBER(7)		 NOT NULL,
		SURF_RDATE                    		DATE		 NOT NULL,
		MEM_NO                        		NUMBER(6)		 NOT NULL,
  FOREIGN KEY (MEM_NO) REFERENCES MEMBER (MEM_NO)
);

COMMENT ON TABLE SURF is '검색어';
COMMENT ON COLUMN SURF.SURF_NO is '컨텐츠 번호';
COMMENT ON COLUMN SURF.SURF_WORD is '검색어';
COMMENT ON COLUMN SURF.SURF_CNT is '조회수';
COMMENT ON COLUMN SURF.SURF_RDATE is '등록일';
COMMENT ON COLUMN SURF.MEM_NO is '회원 번호';


/**********************************/
/* Table Name: 상품 */
/**********************************/
CREATE TABLE PRODUCT(
		PR_NO                         		NUMBER(7)		 NOT NULL		 PRIMARY KEY,
		GORY_NO                       		NUMBER(7)		 NULL ,
		MEM_NO                        		NUMBER(6)		 NULL ,
		PR_MAKER                      		VARCHAR2(300)		 NOT NULL,
		PR_TITLE                      		VARCHAR2(300)		 NOT NULL,
		PR_CONTENTS                   		VARCHAR2(4000)		 NOT NULL,
		PR_THUMBS                     		VARCHAR2(1000)		 NULL ,
		PR_FILES                      		VARCHAR2(1000)		 NULL ,
		PR_SIZES                      		VARCHAR2(1000)		 NULL ,
		PR_CNT                        		NUMBER(7)		 NOT NULL,
		PR_RDATE                      		DATE		 NOT NULL,
		PR_YEAR                       		DATE		 NULL ,
		PR_WORD                       		VARCHAR2(100)		 NULL ,
		PR_PRICE                      		NUMBER(10)		 NOT NULL,
		PR_VISIBLE                    		CHAR(1)		 NOT NULL,
		PR_PAYMENT                    		CHAR(1)		 NOT NULL,
  FOREIGN KEY (GORY_NO) REFERENCES CATEGORY (GORY_NO),
  FOREIGN KEY (MEM_NO) REFERENCES MEMBER (MEM_NO)
);

COMMENT ON TABLE PRODUCT is '상품';
COMMENT ON COLUMN PRODUCT.PR_NO is '상품 번호';
COMMENT ON COLUMN PRODUCT.GORY_NO is '카테고리번호';
COMMENT ON COLUMN PRODUCT.MEM_NO is '회원 번호';
COMMENT ON COLUMN PRODUCT.PR_MAKER is '브랜드명';
COMMENT ON COLUMN PRODUCT.PR_TITLE is '제목';
COMMENT ON COLUMN PRODUCT.PR_CONTENTS is '내용';
COMMENT ON COLUMN PRODUCT.PR_THUMBS is 'thumbs 파일';
COMMENT ON COLUMN PRODUCT.PR_FILES is '파일들의 이름';
COMMENT ON COLUMN PRODUCT.PR_SIZES is '파일들의 크기';
COMMENT ON COLUMN PRODUCT.PR_CNT is '조회수';
COMMENT ON COLUMN PRODUCT.PR_RDATE is '등록일';
COMMENT ON COLUMN PRODUCT.PR_YEAR is '출판연도';
COMMENT ON COLUMN PRODUCT.PR_WORD is '검색어';
COMMENT ON COLUMN PRODUCT.PR_PRICE is '가격';
COMMENT ON COLUMN PRODUCT.PR_VISIBLE is '출력 여부';
COMMENT ON COLUMN PRODUCT.PR_PAYMENT is '결제';


/**********************************/
/* Table Name: 장바구니 */
/**********************************/
CREATE TABLE CART(
		CART_NO                       		NUMBER(6)		 NOT NULL		 PRIMARY KEY,
		PR_NO                         		NUMBER(7)		 NULL ,
		MEM_NO                        		NUMBER(6)		 NULL ,
		CART_RDATE                    		NUMBER(6)		 NULL ,
  FOREIGN KEY (MEM_NO) REFERENCES MEMBER (MEM_NO),
  FOREIGN KEY (PR_NO) REFERENCES PRODUCT (PR_NO)
);

COMMENT ON TABLE CART is '장바구니';
COMMENT ON COLUMN CART.CART_NO is '장바구니 번호';
COMMENT ON COLUMN CART.PR_NO is '상품번호';
COMMENT ON COLUMN CART.MEM_NO is '회원 번호';
COMMENT ON COLUMN CART.CART_RDATE is '장바구니 등록 날짜';


/**********************************/
/* Table Name: 댓글 */
/**********************************/
CREATE TABLE REPLY(
		RPL_NO                        		NUMBER(7)		 NOT NULL		 PRIMARY KEY,
		PR_NO                         		NUMBER(7)		 NULL ,
		MEM_NO                        		NUMBER(6)		 NULL ,
		RPL_CONTENTS                  		VARCHAR2(4000)		 NOT NULL,
		RPL_RDATE                     		DATE		 NOT NULL,
		RPL_VISIBLE                   		CHAR(1)		 NOT NULL,
		RPL_GRPNO                     		NUMBER(7)		 NOT NULL,
		RPL_INDENT                    		NUMBER(2)		 NOT NULL,
		RPL_ANSNUM                    		NUMBER(5)		 NOT NULL,
  FOREIGN KEY (PR_NO) REFERENCES PRODUCT (PR_NO),
  FOREIGN KEY (MEM_NO) REFERENCES MEMBER (MEM_NO)
);

COMMENT ON TABLE REPLY is '댓글';
COMMENT ON COLUMN REPLY.RPL_NO is '댓글 번호';
COMMENT ON COLUMN REPLY.PR_NO is '카테고리번호';
COMMENT ON COLUMN REPLY.MEM_NO is '회원 번호';
COMMENT ON COLUMN REPLY.RPL_CONTENTS is '내용';
COMMENT ON COLUMN REPLY.RPL_RDATE is '등록일';
COMMENT ON COLUMN REPLY.RPL_VISIBLE is '출력 여부';
COMMENT ON COLUMN REPLY.RPL_GRPNO is '그룹 번호';
COMMENT ON COLUMN REPLY.RPL_INDENT is '답변 차수';
COMMENT ON COLUMN REPLY.RPL_ANSNUM is '답변 번호';


/**********************************/
/* Table Name: 권한별 접근 URL */
/**********************************/
CREATE TABLE URLAUTH(
		URLAUTH_NO                    		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		URLAUTH_ADDRESS               		VARCHAR2(200)		 NOT NULL,
		AUTH_NO                       		NUMBER(10)		 NOT NULL,
  FOREIGN KEY (AUTH_NO) REFERENCES AUTH (AUTH_NO)
);

COMMENT ON TABLE URLAUTH is '권한별 접근 URL';
COMMENT ON COLUMN URLAUTH.URLAUTH_NO is '권한별 접근 URL 번호';
COMMENT ON COLUMN URLAUTH.URLAUTH_ADDRESS is '권한별 접근 URL 주소';
COMMENT ON COLUMN URLAUTH.AUTH_NO is '권한 번호';


/**********************************/
/* Table Name: 거래 */
/**********************************/
CREATE TABLE DEAL(
		deal_no                       		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		d_state                       		VARCHAR2(20)		 DEFAULT '거래중'		 NOT NULL,
		d_way                         		VARCHAR2(20)		 DEFAULT '택배거래'		 NOT NULL,
		d_date                        		DATE		 NOT NULL,
		d_check                       		CHAR(1)		 DEFAULT 'N'		 NOT NULL,
		d_memo                        		VARCHAR2(100)		 DEFAULT '메모'		 NULL ,
		mem_no                        		NUMBER(6)		 NOT NULL,
		pr_no                         		NUMBER(10)		 NOT NULL,
  FOREIGN KEY (mem_no) REFERENCES MEMBER (MEM_NO),
  FOREIGN KEY (pr_no) REFERENCES PRODUCT (PR_NO)
);

COMMENT ON TABLE DEAL is '거래';
COMMENT ON COLUMN DEAL.deal_no is '거래번호';
COMMENT ON COLUMN DEAL.d_state is '거래상태';
COMMENT ON COLUMN DEAL.d_way is '거래방법';
COMMENT ON COLUMN DEAL.d_date is '거래등록일';
COMMENT ON COLUMN DEAL.d_check is '거래확인';
COMMENT ON COLUMN DEAL.d_memo is '거래메모';
COMMENT ON COLUMN DEAL.mem_no is '회원번호';
COMMENT ON COLUMN DEAL.pr_no is '상품번호';


/**********************************/
/* Table Name: 충전수단 */
/**********************************/
CREATE TABLE CHARGEWAY(
		CWAY_NO                       		NUMBER(2)		 NOT NULL		 PRIMARY KEY,
		CWAY                          		VARCHAR2(20)		 NOT NULL
);

COMMENT ON TABLE CHARGEWAY is '충전수단';
COMMENT ON COLUMN CHARGEWAY.CWAY_NO is '충전수단번호';
COMMENT ON COLUMN CHARGEWAY.CWAY is '충전수단';


/**********************************/
/* Table Name: 마일리지 충전 */
/**********************************/
CREATE TABLE CHARGEMILEAGE(
		MCHARGE_NO                    		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		CWAY_NO                       		NUMBER(2)		 NOT NULL,
		CMILEAGE                      		NUMBER(10)		 NOT NULL,
		MEM_NO                        		NUMBER(6)		 NOT NULL,
		CMILEAGE_DATE                 		DATE		 NOT NULL,
  FOREIGN KEY (CWAY_NO) REFERENCES CHARGEWAY (CWAY_NO),
  FOREIGN KEY (MEM_NO) REFERENCES MEMBER (MEM_NO)
);

COMMENT ON TABLE CHARGEMILEAGE is '마일리지 충전';
COMMENT ON COLUMN CHARGEMILEAGE.MCHARGE_NO is '충전번호';
COMMENT ON COLUMN CHARGEMILEAGE.CWAY_NO is '충전수단번호';
COMMENT ON COLUMN CHARGEMILEAGE.CMILEAGE is '충전마일리지';
COMMENT ON COLUMN CHARGEMILEAGE.MEM_NO is '회원번호';
COMMENT ON COLUMN CHARGEMILEAGE.CMILEAGE_DATE is '충전날짜';


/**********************************/
/* Table Name: 내 마일리지 */
/**********************************/
CREATE TABLE MYMLIEAGE(
		MILEAGE_NO                    		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		MEM_NO                        		NUMBER(6)		 NOT NULL,
		MCHARGE_NO                    		NUMBER(10)		 NULL ,
		MYMILEAGE                     		NUMBER(10)		 NOT NULL,
  FOREIGN KEY (MEM_NO) REFERENCES MEMBER (MEM_NO),
  FOREIGN KEY (MCHARGE_NO) REFERENCES CHARGEMILEAGE (MCHARGE_NO)
);

COMMENT ON TABLE MYMLIEAGE is '내 마일리지';
COMMENT ON COLUMN MYMLIEAGE.MILEAGE_NO is '마일리지 번호';
COMMENT ON COLUMN MYMLIEAGE.MEM_NO is '회원번호';
COMMENT ON COLUMN MYMLIEAGE.MCHARGE_NO is '충전번호';
COMMENT ON COLUMN MYMLIEAGE.MYMILEAGE is '마일리지';


