/**********************************/
/* Table Name: 카테고리 그룹 */
/**********************************/
CREATE TABLE categrp(
		categrpno                     		NUMBER(10)		 NOT NULL		   PRIMARY KEY,
		classification                		CHAR(1)		     DEFAULT 1		 NOT NULL,
		name                      		    VARCHAR2(50)	 NOT NULL,
		seqno                         		NUMBER(7)		   DEFAULT 0		 NOT NULL,
		visible                       		CHAR(1)		     DEFAULT 'Y'  NOT NULL,
		rdate                         		DATE		       NOT NULL
);

COMMENT ON TABLE categrp is '카테고리 그룹';
COMMENT ON COLUMN categrp.categrpno is '카테고리 그룹번호';
COMMENT ON COLUMN categrp.classification is '카테고리 그룹분류';
COMMENT ON COLUMN categrp.name is '카테고리명';
COMMENT ON COLUMN categrp.seqno is '출력순서';
COMMENT ON COLUMN categrp.visible is '출력 모드';
COMMENT ON COLUMN categrp.rdate is '그룹 생성일';


/**********************************/
/* Table Name: 카테고리 */
/**********************************/
CREATE TABLE name(
		categoryno                    		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		categrpno                     		NUMBER(10)		 NULL ,
  FOREIGN KEY (categrpno) REFERENCES categrp (categrpno)
);

COMMENT ON TABLE name is '카테고리';
COMMENT ON COLUMN name.categoryno is '카테고리 번호';
COMMENT ON COLUMN name.categrpno is '카테고리그룹 번호';


/**********************************/
/* Table Name: 컨텐츠 */
/**********************************/
CREATE TABLE contents(
		contentsno                    		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		categoryno                    		NUMBER(10)		 NULL ,
  FOREIGN KEY (categoryno) REFERENCES name (categoryno)
);

COMMENT ON TABLE contents is '컨텐츠';
COMMENT ON COLUMN contents.contentsno is '콘텐츠 번호';
COMMENT ON COLUMN contents.categoryno is '카테고리 번호';


/**********************************/
/* Table Name: 권한(직책) */
/**********************************/
CREATE TABLE auth(
		authno                        		NUMBER(10)		 NOT NULL		 PRIMARY KEY
);

COMMENT ON TABLE auth is '권한(직책)';
COMMENT ON COLUMN auth.authno is '권한 번호';


/**********************************/
/* Table Name: 회원 */
/**********************************/
CREATE TABLE member(
		memberno                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		authno                        		NUMBER(10)		 NULL ,
  FOREIGN KEY (authno) REFERENCES auth (authno)
);

COMMENT ON TABLE member is '회원';
COMMENT ON COLUMN member.memberno is '회원 번호';
COMMENT ON COLUMN member.authno is '권한 번호';


/**********************************/
/* Table Name: 댓글, 상품평 */
/**********************************/
CREATE TABLE reply(
		replyno                       		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		contentsno                    		NUMBER(10)		 NULL ,
		memberno                      		NUMBER(10)		 NULL ,
  FOREIGN KEY (contentsno) REFERENCES contents (contentsno),
  FOREIGN KEY (memberno) REFERENCES member (memberno)
);

COMMENT ON TABLE reply is '댓글, 상품평';
COMMENT ON COLUMN reply.replyno is '댓글 번호';
COMMENT ON COLUMN reply.contentsno is '콘텐츠 번호';
COMMENT ON COLUMN reply.memberno is '회원 번호';


/**********************************/
/* Table Name: 사원 */
/**********************************/
CREATE TABLE admin(
		adminno                       		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		authno                        		NUMBER(10)		 NULL ,
  FOREIGN KEY (authno) REFERENCES auth (authno)
);

COMMENT ON TABLE admin is '사원';
COMMENT ON COLUMN admin.adminno is '사원 번호';
COMMENT ON COLUMN admin.authno is '권한 번호';


/**********************************/
/* Table Name: 접속 URL주소 */
/**********************************/
CREATE TABLE url(
		urlno                         		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		urlauthno                     		NUMBER(10)		 NULL 
);

COMMENT ON TABLE url is '접속 URL주소';
COMMENT ON COLUMN url.urlno is '접속 URL주소 번호';
COMMENT ON COLUMN url.urlauthno is '권한별 접근 URL 번호';


/**********************************/
/* Table Name: 권한별 접근 URL */
/**********************************/
CREATE TABLE urlauth(
		urlauthno                     		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		authno                        		NUMBER(10)		 NULL ,
		urlno                         		NUMBER(10)		 NULL ,
  FOREIGN KEY (authno) REFERENCES auth (authno),
  FOREIGN KEY (urlno) REFERENCES url (urlno)
);

COMMENT ON TABLE urlauth is '권한별 접근 URL';
COMMENT ON COLUMN urlauth.urlauthno is '권한별 접근 URL 번호';
COMMENT ON COLUMN urlauth.authno is '권한 번호';
COMMENT ON COLUMN urlauth.urlno is '접속 URL주소 번호';


/**********************************/
/* Table Name: 예약(행위) */
/**********************************/
CREATE TABLE reservation(
		reservationno                 		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		contentsno                    		NUMBER(10)		 NULL ,
		memberno                      		NUMBER(10)		 NULL ,
  FOREIGN KEY (contentsno) REFERENCES contents (contentsno),
  FOREIGN KEY (memberno) REFERENCES member (memberno)
);

COMMENT ON TABLE reservation is '예약(행위)';
COMMENT ON COLUMN reservation.reservationno is '예약 번호';
COMMENT ON COLUMN reservation.contentsno is '콘텐츠 번호';
COMMENT ON COLUMN reservation.memberno is '회원 번호';


/**********************************/
/* Table Name: 쇼핑 카트(객실 선택) */
/**********************************/
CREATE TABLE cart(
		cartno                        		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		contentsno                    		NUMBER(10)		 NULL ,
		memberno                      		NUMBER(10)		 NULL ,
  FOREIGN KEY (contentsno) REFERENCES contents (contentsno),
  FOREIGN KEY (memberno) REFERENCES member (memberno)
);

COMMENT ON TABLE cart is '쇼핑 카트(객실 선택)';
COMMENT ON COLUMN cart.cartno is '쇼핑카트 번호';
COMMENT ON COLUMN cart.contentsno is '콘텐츠 번호';
COMMENT ON COLUMN cart.memberno is '회원 번호';


/**********************************/
/* Table Name: 포인트 */
/**********************************/
CREATE TABLE point(
		pointno                       		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		memberno                      		NUMBER(10)		 NULL ,
  FOREIGN KEY (memberno) REFERENCES member (memberno)
);

COMMENT ON TABLE point is '포인트';
COMMENT ON COLUMN point.pointno is '포인트 번호';
COMMENT ON COLUMN point.memberno is '회원 번호';


/**********************************/
/* Table Name: 예약 항목 */
/**********************************/
CREATE TABLE resitem(
		reitemno                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		reservationno                 		NUMBER(10)		 NULL ,
  FOREIGN KEY (reservationno) REFERENCES reservation (reservationno)
);

COMMENT ON TABLE resitem is '예약 항목';
COMMENT ON COLUMN resitem.reitemno is '예약항목 번호';
COMMENT ON COLUMN resitem.reservationno is '예약 번호';


/**********************************/
/* Table Name: 설문조사 참여 */
/**********************************/
CREATE TABLE surveyparti(
		surveypartino                 		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		memberno                      		NUMBER(10)		 NULL ,
  FOREIGN KEY (memberno) REFERENCES member (memberno)
);

COMMENT ON TABLE surveyparti is '설문조사 참여';
COMMENT ON COLUMN surveyparti.surveypartino is '설문조사 참여번호';
COMMENT ON COLUMN surveyparti.memberno is '회원 번호';


/**********************************/
/* Table Name: 설문조사 */
/**********************************/
CREATE TABLE survey(
		surveyno                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		surveypartino                 		NUMBER(10)		 NULL ,
  FOREIGN KEY (surveypartino) REFERENCES surveyparti (surveypartino)
);

COMMENT ON TABLE survey is '설문조사';
COMMENT ON COLUMN survey.surveyno is '설문조사';
COMMENT ON COLUMN survey.surveypartino is '설문조사 참여번호';


/**********************************/
/* Table Name: 설문조사 항목 */
/**********************************/
CREATE TABLE surveyitem(
		surveyitemno                  		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		surveyno                      		NUMBER(10)		 NULL ,
  FOREIGN KEY (surveyno) REFERENCES survey (surveyno)
);

COMMENT ON TABLE surveyitem is '설문조사 항목';
COMMENT ON COLUMN surveyitem.surveyitemno is '설문조사 항목 번호';
COMMENT ON COLUMN surveyitem.surveyno is '설문조사';


/**********************************/
/* Table Name: 로그 */
/**********************************/
CREATE TABLE log(
		logno                         		NUMBER(10)		 NOT NULL		 PRIMARY KEY
);

COMMENT ON TABLE log is '로그';
COMMENT ON COLUMN log.logno is '로그 번호';


/**********************************/
/* Table Name: 갤러리 */
/**********************************/
CREATE TABLE gallery(
		galleryno                     		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		categoryno                    		NUMBER(10)		 NULL ,
  FOREIGN KEY (categoryno) REFERENCES name (categoryno)
);

COMMENT ON TABLE gallery is '갤러리';
COMMENT ON COLUMN gallery.galleryno is '갤러리 번호';
COMMENT ON COLUMN gallery.categoryno is '카테고리 번호';


/**********************************/
/* Table Name: 질문답변 */
/**********************************/
CREATE TABLE qna(
		qnano                         		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		categoryno                    		NUMBER(10)		 NULL ,
  FOREIGN KEY (categoryno) REFERENCES name (categoryno)
);

COMMENT ON TABLE qna is '질문답변';
COMMENT ON COLUMN qna.qnano is '질문답변 번호';
COMMENT ON COLUMN qna.categoryno is '카테고리 번호';


