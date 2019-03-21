DROP TABLE myaccount CASCADE CONSTRAINTS;
DROP TABLE account CASCADE CONSTRAINTS;
DROP TABLE mycard CASCADE CONSTRAINTS;
DROP TABLE earncash CASCADE CONSTRAINTS;
DROP TABLE mycash CASCADE CONSTRAINTS;
DROP TABLE dealway CASCADE CONSTRAINTS;
DROP TABLE card CASCADE CONSTRAINTS;
DROP TABLE mywallet CASCADE CONSTRAINTS;
DROP TABLE dealsort CASCADE CONSTRAINTS;
DROP TABLE deal CASCADE CONSTRAINTS;
DROP TABLE buysell CASCADE CONSTRAINTS;
DROP TABLE member CASCADE CONSTRAINTS;

/**********************************/
/* Table Name: 회원 */
/**********************************/
CREATE TABLE member(
		mem_no                        		NUMBER(6)		 NOT NULL
);

COMMENT ON TABLE member is '회원';
COMMENT ON COLUMN member.mem_no is '회원번호';


/**********************************/
/* Table Name: 판매구매 */
/**********************************/
CREATE TABLE buysell(
		buysellno                     		NUMBER(10)		 NOT NULL
);

COMMENT ON TABLE buysell is '판매구매';
COMMENT ON COLUMN buysell.buysellno is '판매구매번호';


/**********************************/
/* Table Name: 거래 */
/**********************************/
CREATE TABLE deal(
		dealno                        		NUMBER(10)		 NOT NULL,
		howmuch                       		NUMBER(15)		 NOT NULL,
		buysellno                     		NUMBER(10)		 NOT NULL,
		dealdate                      		DATE		 NOT NULL,
		sellersign                    		VARCHAR2(50)		 NOT NULL,
		buyersign                     		VARCHAR2(50)		 NOT NULL,
		dealmemo                      		VARCHAR2(100)		 NULL ,
		mem_no                        		NUMBER(6)		 NOT NULL
);

COMMENT ON TABLE deal is '거래';
COMMENT ON COLUMN deal.dealno is '거래번호';
COMMENT ON COLUMN deal.howmuch is '거래금액';
COMMENT ON COLUMN deal.buysellno is '판매구매번호';
COMMENT ON COLUMN deal.dealdate is '거래날짜';
COMMENT ON COLUMN deal.sellersign is '판매자서명';
COMMENT ON COLUMN deal.buyersign is '구매자서명';
COMMENT ON COLUMN deal.dealmemo is '거래메모';
COMMENT ON COLUMN deal.mem_no is '회원번호';


/**********************************/
/* Table Name: 거래수단 */
/**********************************/
CREATE TABLE dealsort(
		dealsortno                    		NUMBER(2)		 NOT NULL,
		dealsortname                  		VARCHAR2(20)		 NOT NULL,
		dealno                        		NUMBER(10)		 NULL 
);

COMMENT ON TABLE dealsort is '거래수단';
COMMENT ON COLUMN dealsort.dealsortno is '거래수단번호';
COMMENT ON COLUMN dealsort.dealsortname is '거래수단';
COMMENT ON COLUMN dealsort.dealno is '거래번호';


/**********************************/
/* Table Name: 내 지갑 */
/**********************************/
CREATE TABLE mywallet(
		mem_no                        		NUMBER(6)		 NOT NULL,
		dealsortno                    		NUMBER(2)		 NULL 
);

COMMENT ON TABLE mywallet is '내 지갑';
COMMENT ON COLUMN mywallet.mem_no is '회원번호';
COMMENT ON COLUMN mywallet.dealsortno is '거래수단번호';


/**********************************/
/* Table Name: 카드 */
/**********************************/
CREATE TABLE card(
		cardidno                      		NUMBER(10)		 NOT NULL,
		cardcompany                   		VARCHAR2(10)		 NOT NULL,
		cardnumber                    		NUMBER(16)		 NOT NULL,
		expires                       		NUMBER(6)		 NOT NULL,
		dealsortno                    		NUMBER(2)		 NULL 
);

COMMENT ON TABLE card is '카드';
COMMENT ON COLUMN card.cardidno is '카드구분번호';
COMMENT ON COLUMN card.cardcompany is '카드사';
COMMENT ON COLUMN card.cardnumber is '카드번호';
COMMENT ON COLUMN card.expires is '카드만료일';
COMMENT ON COLUMN card.dealsortno is '거래수단번호';


/**********************************/
/* Table Name: 거래방법 */
/**********************************/
CREATE TABLE dealway(
		dealwayno                     		NUMBER(10)		 NOT NULL,
		dealway                       		VARCHAR2(20)		 NOT NULL,
		dealno                        		NUMBER(10)		 NULL 
);

COMMENT ON TABLE dealway is '거래방법';
COMMENT ON COLUMN dealway.dealwayno is '거래방법번호';
COMMENT ON COLUMN dealway.dealway is '거래방법';
COMMENT ON COLUMN dealway.dealno is '거래번호';


/**********************************/
/* Table Name: 내 캐시 */
/**********************************/
CREATE TABLE mycash(
		cashidno                      		NUMBER(10)		 NOT NULL,
		mycash                        		NUMBER(10)		 NULL ,
		addcashdate                   		DATE		 NULL ,
		mem_no                        		NUMBER(6)		 NOT NULL
);

COMMENT ON TABLE mycash is '내 캐시';
COMMENT ON COLUMN mycash.cashidno is '캐시구분번호';
COMMENT ON COLUMN mycash.mycash is '내 캐시';
COMMENT ON COLUMN mycash.addcashdate is '캐시등록일';
COMMENT ON COLUMN mycash.mem_no is '회원번호';


/**********************************/
/* Table Name: 캐시적립 */
/**********************************/
CREATE TABLE earncash(
		earncashno                    		NUMBER(10)		 NOT NULL,
		savecash                      		NUMBER(15)		 NULL ,
		savedate                      		DATE		 NOT NULL,
		dealno                        		NUMBER(10)		 NOT NULL,
		cashidno                      		NUMBER(10)		 NULL 
);

COMMENT ON TABLE earncash is '캐시적립';
COMMENT ON COLUMN earncash.earncashno is '적립캐시번호';
COMMENT ON COLUMN earncash.savecash is '적립캐시';
COMMENT ON COLUMN earncash.savedate is '적립날짜';
COMMENT ON COLUMN earncash.dealno is '거래번호';
COMMENT ON COLUMN earncash.cashidno is '캐시구분번호';


/**********************************/
/* Table Name: 내 카드 */
/**********************************/
CREATE TABLE mycard(
		cardidno                      		NUMBER(10)		 NOT NULL,
		addcarddate                   		DATE		 NOT NULL,
		mem_no                        		NUMBER(6)		 NOT NULL
);

COMMENT ON TABLE mycard is '내 카드';
COMMENT ON COLUMN mycard.cardidno is '카드구분번호';
COMMENT ON COLUMN mycard.addcarddate is '카드등록일';
COMMENT ON COLUMN mycard.mem_no is '회원번호';


/**********************************/
/* Table Name: 계좌 */
/**********************************/
CREATE TABLE account(
		accountidno                   		NUMBER(10)		 NOT NULL,
		bankname                      		VARCHAR2(20)		 NOT NULL,
		accountnum                    		NUMBER(16)		 NOT NULL,
		depositor                     		VARCHAR2(20)		 NOT NULL,
		dealsortno                    		NUMBER(2)		 NULL 
);

COMMENT ON TABLE account is '계좌';
COMMENT ON COLUMN account.accountidno is '계좌구분번호';
COMMENT ON COLUMN account.bankname is '은행명';
COMMENT ON COLUMN account.accountnum is '계좌번호';
COMMENT ON COLUMN account.depositor is '예금주';
COMMENT ON COLUMN account.dealsortno is '거래수단번호';


/**********************************/
/* Table Name: 내 계좌 */
/**********************************/
CREATE TABLE myaccount(
		accountidno                   		NUMBER(10)		 NOT NULL,
		accountadddate                		DATE		 NOT NULL,
		mem_no                        		NUMBER(6)		 NOT NULL
);

COMMENT ON TABLE myaccount is '내 계좌';
COMMENT ON COLUMN myaccount.accountidno is '계좌구분번호';
COMMENT ON COLUMN myaccount.accountadddate is '계좌등록일';
COMMENT ON COLUMN myaccount.mem_no is '회원번호';



ALTER TABLE member ADD CONSTRAINT IDX_member_PK PRIMARY KEY (mem_no);

ALTER TABLE buysell ADD CONSTRAINT IDX_buysell_PK PRIMARY KEY (buysellno);

ALTER TABLE deal ADD CONSTRAINT IDX_deal_PK PRIMARY KEY (dealno);
ALTER TABLE deal ADD CONSTRAINT IDX_deal_FK0 FOREIGN KEY (mem_no) REFERENCES member (mem_no);
ALTER TABLE deal ADD CONSTRAINT IDX_deal_FK1 FOREIGN KEY (buysellno) REFERENCES buysell (buysellno);

ALTER TABLE dealsort ADD CONSTRAINT IDX_dealsort_PK PRIMARY KEY (dealsortno);
ALTER TABLE dealsort ADD CONSTRAINT IDX_dealsort_FK0 FOREIGN KEY (dealno) REFERENCES deal (dealno);

ALTER TABLE mywallet ADD CONSTRAINT IDX_mywallet_PK PRIMARY KEY (mem_no);
ALTER TABLE mywallet ADD CONSTRAINT IDX_mywallet_FK0 FOREIGN KEY (mem_no) REFERENCES member (mem_no);
ALTER TABLE mywallet ADD CONSTRAINT IDX_mywallet_FK1 FOREIGN KEY (dealsortno) REFERENCES dealsort (dealsortno);

ALTER TABLE card ADD CONSTRAINT IDX_card_PK PRIMARY KEY (cardidno);
ALTER TABLE card ADD CONSTRAINT IDX_card_FK0 FOREIGN KEY (dealsortno) REFERENCES dealsort (dealsortno);

ALTER TABLE dealway ADD CONSTRAINT IDX_dealway_PK PRIMARY KEY (dealwayno);
ALTER TABLE dealway ADD CONSTRAINT IDX_dealway_FK1 FOREIGN KEY (dealno) REFERENCES deal (dealno);

ALTER TABLE mycash ADD CONSTRAINT IDX_mycash_PK PRIMARY KEY (cashidno);
ALTER TABLE mycash ADD CONSTRAINT IDX_mycash_FK0 FOREIGN KEY (mem_no) REFERENCES mywallet (mem_no);

ALTER TABLE earncash ADD CONSTRAINT IDX_earncash_PK PRIMARY KEY (earncashno);
ALTER TABLE earncash ADD CONSTRAINT IDX_earncash_FK0 FOREIGN KEY (dealno) REFERENCES deal (dealno);
ALTER TABLE earncash ADD CONSTRAINT IDX_earncash_FK1 FOREIGN KEY (cashidno) REFERENCES mycash (cashidno);

ALTER TABLE mycard ADD CONSTRAINT IDX_mycard_PK PRIMARY KEY (cardidno);
ALTER TABLE mycard ADD CONSTRAINT IDX_mycard_FK0 FOREIGN KEY (mem_no) REFERENCES mywallet (mem_no);
ALTER TABLE mycard ADD CONSTRAINT IDX_mycard_FK1 FOREIGN KEY (cardidno) REFERENCES card (cardidno);

ALTER TABLE account ADD CONSTRAINT IDX_account_PK PRIMARY KEY (accountidno);
ALTER TABLE account ADD CONSTRAINT IDX_account_FK0 FOREIGN KEY (dealsortno) REFERENCES dealsort (dealsortno);

ALTER TABLE myaccount ADD CONSTRAINT IDX_myaccount_PK PRIMARY KEY (accountidno);
ALTER TABLE myaccount ADD CONSTRAINT IDX_myaccount_FK0 FOREIGN KEY (mem_no) REFERENCES mywallet (mem_no);
ALTER TABLE myaccount ADD CONSTRAINT IDX_myaccount_FK1 FOREIGN KEY (accountidno) REFERENCES account (accountidno);

