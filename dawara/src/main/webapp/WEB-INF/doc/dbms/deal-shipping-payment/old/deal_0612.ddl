DROP TABLE deal CASCADE CONSTRAINTS;
DROP TABLE dealway CASCADE CONSTRAINTS;
DROP TABLE buysell CASCADE CONSTRAINTS;
DROP TABLE dealsort CASCADE CONSTRAINTS;
DROP TABLE mywallet CASCADE CONSTRAINTS;
DROP TABLE mycard CASCADE CONSTRAINTS;
DROP TABLE mycash CASCADE CONSTRAINTS;
DROP TABLE member CASCADE CONSTRAINTS;

/**********************************/
/* Table Name: 회원 */
/**********************************/
CREATE TABLE member(
		mem_no                        		NUMBER(6)		 NOT NULL		 PRIMARY KEY
);

COMMENT ON TABLE member is '회원';
COMMENT ON COLUMN member.mem_no is '회원번호';


/**********************************/
/* Table Name: 내 캐시 */
/**********************************/
CREATE TABLE mycash(
		cashno                        		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		mycash                        		NUMBER(15)		 NULL ,
		savecash                      		NUMBER(15)		 NULL ,
		usecash                       		NUMBER(15)		 NULL ,
		savedate                      		DATE		 NOT NULL,
		usedate                       		DATE		 NOT NULL,
		mywalletno                    		NUMBER(10)		 NULL ,
		dealno                        		NUMBER(10)		 NULL 
);

COMMENT ON TABLE mycash is '내 캐시';
COMMENT ON COLUMN mycash.cashno is '캐시번호';
COMMENT ON COLUMN mycash.mycash is '현재캐시';
COMMENT ON COLUMN mycash.savecash is '적립캐시';
COMMENT ON COLUMN mycash.usecash is '사용캐시';
COMMENT ON COLUMN mycash.savedate is '적립날짜';
COMMENT ON COLUMN mycash.usedate is '사용날짜';
COMMENT ON COLUMN mycash.mywalletno is '지갑번호';
COMMENT ON COLUMN mycash.dealno is '거래번호';


/**********************************/
/* Table Name: 내 카드 */
/**********************************/
CREATE TABLE mycard(
		cardidno                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		cardsort                      		VARCHAR2(20)		 NULL ,
		cardnumber                    		NUMBER(16)		 NOT NULL,
		cardcompany                   		VARCHAR2(10)		 NOT NULL,
		expires                       		NUMBER(6)		 NOT NULL
);

COMMENT ON TABLE mycard is '내 카드';
COMMENT ON COLUMN mycard.cardidno is '카드식별번호';
COMMENT ON COLUMN mycard.cardsort is '카드분류';
COMMENT ON COLUMN mycard.cardnumber is '카드번호';
COMMENT ON COLUMN mycard.cardcompany is '카드사';
COMMENT ON COLUMN mycard.expires is '카드만료일';


/**********************************/
/* Table Name: 내 지갑 */
/**********************************/
CREATE TABLE mywallet(
		mem_no                        		NUMBER(6)		 NOT NULL		 PRIMARY KEY,
		cashno                        		NUMBER(10)		 NULL ,
		cardidno                      		NUMBER(10)		 NULL ,
  FOREIGN KEY (mem_no) REFERENCES member (mem_no),
  FOREIGN KEY (cashno) REFERENCES mycash (cashno),
  FOREIGN KEY (cardidno) REFERENCES mycard (cardidno)
);

COMMENT ON TABLE mywallet is '내 지갑';
COMMENT ON COLUMN mywallet.mem_no is '회원번호';
COMMENT ON COLUMN mywallet.cashno is '캐시번호';
COMMENT ON COLUMN mywallet.cardidno is '카드식별번호';


/**********************************/
/* Table Name: 거래수단 */
/**********************************/
CREATE TABLE dealsort(
		dealsortno                    		NUMBER(2)		 NOT NULL		 PRIMARY KEY,
		dealsortname                  		VARCHAR2(20)		 NOT NULL,
		mem_no                        		NUMBER(6)		 NULL ,
  FOREIGN KEY (mem_no) REFERENCES mywallet (mem_no)
);

COMMENT ON TABLE dealsort is '거래수단';
COMMENT ON COLUMN dealsort.dealsortno is '거래수단번호';
COMMENT ON COLUMN dealsort.dealsortname is '거래수단명';
COMMENT ON COLUMN dealsort.mem_no is '회원번호';


/**********************************/
/* Table Name: 팝니다삽니다 */
/**********************************/
CREATE TABLE buysell(
		buysellno                     		NUMBER(10)		 NOT NULL		 PRIMARY KEY
);

COMMENT ON TABLE buysell is '팝니다삽니다';
COMMENT ON COLUMN buysell.buysellno is '팝니다삽니다번호';


/**********************************/
/* Table Name: 거래방식 */
/**********************************/
CREATE TABLE dealway(
		dealwayno                     		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		dealway                       		VARCHAR2(20)		 NOT NULL,
		dealno                        		NUMBER(10)		 NULL 
);

COMMENT ON TABLE dealway is '거래방식';
COMMENT ON COLUMN dealway.dealwayno is '거래방식번호';
COMMENT ON COLUMN dealway.dealway is '거래방식명';
COMMENT ON COLUMN dealway.dealno is '거래번호';


/**********************************/
/* Table Name: 거래 */
/**********************************/
CREATE TABLE deal(
		dealno                        		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		dealsortno                    		NUMBER(2)		 NULL ,
		howmuch                       		NUMBER(15)		 NOT NULL,
		dealdate                      		DATE		 NOT NULL,
		sellersign                    		VARCHAR2(50)		 NOT NULL,
		buyersign                     		VARCHAR2(50)		 NOT NULL,
		dealmemo                      		VARCHAR2(100)		 NULL ,
		mem_no                        		NUMBER(6)		 NULL ,
		buysellno                     		NUMBER(10)		 NULL ,
		dealwayno                     		NUMBER(10)		 NULL ,
  FOREIGN KEY (dealsortno) REFERENCES dealsort (dealsortno),
  FOREIGN KEY (mem_no) REFERENCES member (mem_no),
  FOREIGN KEY (buysellno) REFERENCES buysell (buysellno),
  FOREIGN KEY (dealwayno) REFERENCES dealway (dealwayno)
);

COMMENT ON TABLE deal is '거래';
COMMENT ON COLUMN deal.dealno is '거래번호';
COMMENT ON COLUMN deal.dealsortno is '거래수단번호';
COMMENT ON COLUMN deal.howmuch is '거래금액';
COMMENT ON COLUMN deal.dealdate is '거래날짜';
COMMENT ON COLUMN deal.sellersign is '판매자서명';
COMMENT ON COLUMN deal.buyersign is '구매자서명';
COMMENT ON COLUMN deal.dealmemo is '거래메모';
COMMENT ON COLUMN deal.mem_no is '회원번호';
COMMENT ON COLUMN deal.buysellno is '팝니다삽니다번호';
COMMENT ON COLUMN deal.dealwayno is '거래방식번호';


