DROP TABLE receipt CASCADE CONSTRAINTS;
DROP TABLE mywallet CASCADE CONSTRAINTS;
DROP TABLE mycash CASCADE CONSTRAINTS;
DROP TABLE mycard CASCADE CONSTRAINTS;
DROP TABLE myaccount CASCADE CONSTRAINTS;
DROP TABLE paysort CASCADE CONSTRAINTS;
DROP TABLE payment CASCADE CONSTRAINTS;
DROP TABLE paysign CASCADE CONSTRAINTS;
DROP TABLE deal CASCADE CONSTRAINTS;
DROP TABLE buysell CASCADE CONSTRAINTS;
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
/* Table Name: 판매구매 */
/**********************************/
CREATE TABLE buysell(
		sellno                        		NUMBER(7)		 NOT NULL		 PRIMARY KEY,
		mem_no                        		NUMBER(6)		 NULL ,
  FOREIGN KEY (mem_no) REFERENCES member (mem_no)
);

COMMENT ON TABLE buysell is '판매구매';
COMMENT ON COLUMN buysell.sellno is '판매번호';
COMMENT ON COLUMN buysell.mem_no is '회원번호';


/**********************************/
/* Table Name: 거래 */
/**********************************/
CREATE TABLE deal(
		dealno                        		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		sellno                        		NUMBER(7)		 NULL ,
  FOREIGN KEY (sellno) REFERENCES buysell (sellno)
);

COMMENT ON TABLE deal is '거래';
COMMENT ON COLUMN deal.dealno is '거래번호';
COMMENT ON COLUMN deal.sellno is '판매번호';


/**********************************/
/* Table Name: 결제서명 */
/**********************************/
CREATE TABLE paysign(
		signno                        		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		paysign                       		CHAR(1)		 DEFAULT 'N'		 NOT NULL,
		sellersign                    		VARCHAR2(20)		 NOT NULL,
		buysign                       		VARCHAR2(20)		 NOT NULL,
		agreedate                     		DATE		 NOT NULL
);

COMMENT ON TABLE paysign is '결제서명';
COMMENT ON COLUMN paysign.signno is '서명번호';
COMMENT ON COLUMN paysign.paysign is '결제동의여부';
COMMENT ON COLUMN paysign.sellersign is '판매자서명';
COMMENT ON COLUMN paysign.buysign is '구매자서명';
COMMENT ON COLUMN paysign.agreedate is '동의날짜';


/**********************************/
/* Table Name: 결제 */
/**********************************/
CREATE TABLE payment(
		paymentno                     		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		paysortno                     		NUMBER(2)		 NULL ,
		mem_no                        		NUMBER(6)		 NULL ,
		signno                        		NUMBER(10)		 NULL ,
		dealno                        		NUMBER(10)		 NULL ,
  FOREIGN KEY (dealno) REFERENCES deal (dealno),
  FOREIGN KEY (signno) REFERENCES paysign (signno),
  FOREIGN KEY (mem_no) REFERENCES member (mem_no)
);

COMMENT ON TABLE payment is '결제';
COMMENT ON COLUMN payment.paymentno is '결제번호';
COMMENT ON COLUMN payment.paysortno is '결제수단번호';
COMMENT ON COLUMN payment.mem_no is '회원번호';
COMMENT ON COLUMN payment.signno is '서명번호';
COMMENT ON COLUMN payment.dealno is '거래번호';


/**********************************/
/* Table Name: 결제수단 */
/**********************************/
CREATE TABLE paysort(
		paysortno                     		NUMBER(2)		 NOT NULL		 PRIMARY KEY,
		psortname                     		VARCHAR2(20)		 NOT NULL,
		paymentno                     		NUMBER(10)		 NULL ,
  FOREIGN KEY (paymentno) REFERENCES payment (paymentno)
);

COMMENT ON TABLE paysort is '결제수단';
COMMENT ON COLUMN paysort.paysortno is '결제수단번호';
COMMENT ON COLUMN paysort.psortname is '결제수단명';
COMMENT ON COLUMN paysort.paymentno is '결제번호';


/**********************************/
/* Table Name: 내 계좌 */
/**********************************/
CREATE TABLE myaccount(
		account_number                		NUMBER(20)		 NOT NULL		 PRIMARY KEY,
		balance                       		NUMBER(15)		 NOT NULL,
		bankname                      		VARCHAR2(20)		 NOT NULL,
		depositor                     		VARCHAR2(20)		 NOT NULL,
		accountholder                 		VARCHAR2(20)		 NOT NULL,
		paysortno                     		NUMBER(2)		 NULL ,
  FOREIGN KEY (paysortno) REFERENCES paysort (paysortno)
);

COMMENT ON TABLE myaccount is '내 계좌';
COMMENT ON COLUMN myaccount.account_number is '계좌번호';
COMMENT ON COLUMN myaccount.balance is '잔액';
COMMENT ON COLUMN myaccount.bankname is '은행명';
COMMENT ON COLUMN myaccount.depositor is '입금자';
COMMENT ON COLUMN myaccount.accountholder is '예금주';
COMMENT ON COLUMN myaccount.paysortno is '결제수단번호';


/**********************************/
/* Table Name: 내 카드 */
/**********************************/
CREATE TABLE mycard(
		cardnumber                    		NUMBER(16)		 NOT NULL		 PRIMARY KEY,
		bname                         		VARCHAR2(10)		 NOT NULL,
		cardsort                      		VARCHAR2(20)		 NOT NULL,
		owner                         		VARCHAR2(20)		 NOT NULL,
		expires                       		NUMBER(6)		 NOT NULL,
		memo                          		VARCHAR2(100)		 NULL ,
		paysortno                     		NUMBER(2)		 NULL ,
  FOREIGN KEY (paysortno) REFERENCES paysort (paysortno)
);

COMMENT ON TABLE mycard is '내 카드';
COMMENT ON COLUMN mycard.cardnumber is '카드번호';
COMMENT ON COLUMN mycard.bname is '은행명';
COMMENT ON COLUMN mycard.cardsort is '카드종류';
COMMENT ON COLUMN mycard.owner is '카드주인';
COMMENT ON COLUMN mycard.expires is '만료날짜';
COMMENT ON COLUMN mycard.memo is '메모';
COMMENT ON COLUMN mycard.paysortno is '결제수단번호';


/**********************************/
/* Table Name: 내 캐시 */
/**********************************/
CREATE TABLE mycash(
		cashno                        		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		mycash                        		NUMBER(15)		 NULL ,
		savedate                      		DATE		 NOT NULL,
		usedate                       		DATE		 NOT NULL,
		savecash                      		NUMBER(15)		 NULL ,
		usecash                       		CHAR(1)		 DEFAULT 'N'		 NOT NULL,
		paysortno                     		NUMBER(2)		 NULL ,
  FOREIGN KEY (paysortno) REFERENCES paysort (paysortno)
);

COMMENT ON TABLE mycash is '내 캐시';
COMMENT ON COLUMN mycash.cashno is '캐시번호';
COMMENT ON COLUMN mycash.mycash is '내 캐시';
COMMENT ON COLUMN mycash.savedate is '적립날짜';
COMMENT ON COLUMN mycash.usedate is '사용날짜';
COMMENT ON COLUMN mycash.savecash is '충전캐시';
COMMENT ON COLUMN mycash.usecash is '캐시사용여부';
COMMENT ON COLUMN mycash.paysortno is '결제수단번호';


/**********************************/
/* Table Name: 내 지갑 */
/**********************************/
CREATE TABLE mywallet(
		mywalletno                    		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		mem_no                        		NUMBER(6)		 NULL ,
		account_number                		NUMBER(20)		 NULL ,
		cardnumber                    		NUMBER(16)		 NULL ,
		cashno                        		NUMBER(10)		 NULL ,
  FOREIGN KEY (mem_no) REFERENCES member (mem_no),
  FOREIGN KEY (account_number) REFERENCES myaccount (account_number),
  FOREIGN KEY (cardnumber) REFERENCES mycard (cardnumber),
  FOREIGN KEY (cashno) REFERENCES mycash (cashno)
);

COMMENT ON TABLE mywallet is '내 지갑';
COMMENT ON COLUMN mywallet.mywalletno is '지갑번호';
COMMENT ON COLUMN mywallet.mem_no is '회원번호';
COMMENT ON COLUMN mywallet.account_number is '계좌번호';
COMMENT ON COLUMN mywallet.cardnumber is '카드번호';
COMMENT ON COLUMN mywallet.cashno is '캐시번호';


/**********************************/
/* Table Name: 영수증 */
/**********************************/
CREATE TABLE receipt(
		receiptno                     		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		SELLNO                        		NUMBER(7)		 NOT NULL,
		MEM_NO                        		NUMBER(6)		 NOT NULL,
		PAYSORT                       		VARCHAR2(20)		 NOT NULL,
		HOWMUCH                       		NUMBER(15)		 NOT NULL,
		PDATE                         		DATE		 NOT NULL,
		PAYCHECK                      		CHAR(1)		 NOT NULL,
		PMEMO                         		VARCHAR2(50)		 NULL ,
		mem_no                        		NUMBER(6)		 NULL ,
		signno                        		NUMBER(10)		 NULL ,
  FOREIGN KEY (mem_no) REFERENCES member (mem_no),
  FOREIGN KEY (signno) REFERENCES paysign (signno)
);

COMMENT ON TABLE receipt is '영수증';
COMMENT ON COLUMN receipt.receiptno is '영수증번호';
COMMENT ON COLUMN receipt.SELLNO is '판매번호';
COMMENT ON COLUMN receipt.MEM_NO is '회원번호';
COMMENT ON COLUMN receipt.PAYSORT is '결제종류';
COMMENT ON COLUMN receipt.HOWMUCH is '결제금액';
COMMENT ON COLUMN receipt.PDATE is '결제날짜';
COMMENT ON COLUMN receipt.PAYCHECK is '결제승인여부';
COMMENT ON COLUMN receipt.PMEMO is '결제메모';
COMMENT ON COLUMN receipt.mem_no is '회원번호';
COMMENT ON COLUMN receipt.signno is '서명번호';


