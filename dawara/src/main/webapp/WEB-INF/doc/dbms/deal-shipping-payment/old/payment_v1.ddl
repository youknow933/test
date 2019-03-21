DROP TABLE payment CASCADE CONSTRAINTS;
DROP TABLE paysort CASCADE CONSTRAINTS;
DROP TABLE mywallet CASCADE CONSTRAINTS;
DROP TABLE member CASCADE CONSTRAINTS;
DROP TABLE mycash CASCADE CONSTRAINTS;
DROP TABLE PAYMENT CASCADE CONSTRAINTS;
DROP TABLE buysell CASCADE CONSTRAINTS;
DROP TABLE cardpay CASCADE CONSTRAINTS;
DROP TABLE bankpay CASCADE CONSTRAINTS;

/**********************************/
/* Table Name: 계좌결제 */
/**********************************/
CREATE TABLE bankpay(
		account_number                		NUMBER(20)		 NOT NULL		 PRIMARY KEY,
		paysortno                     		NUMBER(2)		 NOT NULL,
		bankname                      		VARCHAR2(20)		 NOT NULL,
		depositor                     		VARCHAR2(20)		 NOT NULL,
		accountholder                 		VARCHAR2(20)		 NOT NULL
);

COMMENT ON TABLE bankpay is '계좌결제';
COMMENT ON COLUMN bankpay.account_number is '계좌번호';
COMMENT ON COLUMN bankpay.paysortno is '결제수단번호';
COMMENT ON COLUMN bankpay.bankname is '은행명';
COMMENT ON COLUMN bankpay.depositor is '입금자';
COMMENT ON COLUMN bankpay.accountholder is '예금주';


/**********************************/
/* Table Name: 카드결제 */
/**********************************/
CREATE TABLE cardpay(
		cardnumber                    		NUMBER(16)		 NOT NULL		 PRIMARY KEY,
		paysortno                     		NUMBER(2)		 NULL ,
		bname                         		VARCHAR2(10)		 NOT NULL,
		cardsort                      		INTEGER(10)		 NOT NULL,
		owner                         		VARCHAR2(20)		 NOT NULL,
		seller                        		VARCHAR2(20)		 NULL ,
		expires                       		NUMBER(6)		 NOT NULL,
		memo                          		VARCHAR2(100)		 NULL 
);

COMMENT ON TABLE cardpay is '카드결제';
COMMENT ON COLUMN cardpay.cardnumber is '카드번호';
COMMENT ON COLUMN cardpay.paysortno is '결제수단번호';
COMMENT ON COLUMN cardpay.bname is '은행명';
COMMENT ON COLUMN cardpay.cardsort is '카드종류';
COMMENT ON COLUMN cardpay.owner is '카드주인';
COMMENT ON COLUMN cardpay.seller is '결제대상';
COMMENT ON COLUMN cardpay.expires is '만료날짜';
COMMENT ON COLUMN cardpay.memo is '메모';


/**********************************/
/* Table Name: 판매구매 */
/**********************************/
CREATE TABLE buysell(
		sellno                        		NUMBER(7)		 NOT NULL		 PRIMARY KEY
);

COMMENT ON TABLE buysell is '판매구매';
COMMENT ON COLUMN buysell.sellno is '판매번호';


/**********************************/
/* Table Name: 결제내역 */
/**********************************/
CREATE TABLE PAYMENT(
		PAYMENTNO                     		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		SELLNO                        		NUMBER(7)		 NOT NULL,
		MEM_NO                        		NUMBER(6)		 NOT NULL,
		PAYSORT                       		VARCHAR2(20)		 NOT NULL,
		HOWMUCH                       		NUMBER(15)		 NOT NULL,
		PDATE                         		DATE		 NOT NULL,
		PNAME                         		VARCHAR2(20)		 NOT NULL,
		PAYCHECK                      		CHAR(1)		 NOT NULL,
		PMEMO                         		VARCHAR2(50)		 NULL 
);

COMMENT ON TABLE PAYMENT is '결제내역';
COMMENT ON COLUMN PAYMENT.PAYMENTNO is '결제번호';
COMMENT ON COLUMN PAYMENT.SELLNO is '판매번호';
COMMENT ON COLUMN PAYMENT.MEM_NO is '회원번호';
COMMENT ON COLUMN PAYMENT.PAYSORT is '결제종류';
COMMENT ON COLUMN PAYMENT.HOWMUCH is '결제금액';
COMMENT ON COLUMN PAYMENT.PDATE is '결제날짜';
COMMENT ON COLUMN PAYMENT.PNAME is '결제한 사람';
COMMENT ON COLUMN PAYMENT.PAYCHECK is '결제승인여부';
COMMENT ON COLUMN PAYMENT.PMEMO is '결제메모';


/**********************************/
/* Table Name: 내 캐시 */
/**********************************/
CREATE TABLE mycash(
		mycash                        		NUMBER(15)		 NULL ,
		savedate                      		DATE		 NOT NULL,
		savecash                      		NUMBER(15)		 NULL ,
		usage                         		VARCHAR2(50)		 NOT NULL,
		memberno                      		NUMBER(6)		 NULL 
);

COMMENT ON TABLE mycash is '내 캐시';
COMMENT ON COLUMN mycash.mycash is '내 캐시';
COMMENT ON COLUMN mycash.savedate is '적립날짜';
COMMENT ON COLUMN mycash.savecash is '충전캐시';
COMMENT ON COLUMN mycash.usage is '사용처';
COMMENT ON COLUMN mycash.memberno is '회원번호';


/**********************************/
/* Table Name: 회원 */
/**********************************/
CREATE TABLE member(
		memberno                      		NUMBER(6)		 NOT NULL		 PRIMARY KEY,
		sellno                        		NUMBER(7)		 NULL ,
		PAYMENTNO                     		NUMBER(10)		 NULL ,
  FOREIGN KEY (sellno) REFERENCES buysell (sellno),
  FOREIGN KEY (PAYMENTNO) REFERENCES PAYMENT (PAYMENTNO),
  FOREIGN KEY () REFERENCES mycash ()
);

COMMENT ON TABLE member is '회원';
COMMENT ON COLUMN member.memberno is '회원번호';
COMMENT ON COLUMN member.sellno is '판매번호';
COMMENT ON COLUMN member.PAYMENTNO is '결제번호';


/**********************************/
/* Table Name: 내 지갑 */
/**********************************/
CREATE TABLE mywallet(
		paysort                       		VARCHAR2(10)		 NOT NULL,
		memberno                      		NUMBER(6)		 NULL ,
		account_number                		NUMBER(20)		 NULL ,
		cardnumber                    		NUMBER(16)		 NULL ,
  FOREIGN KEY (account_number) REFERENCES bankpay (account_number),
  FOREIGN KEY (cardnumber) REFERENCES cardpay (cardnumber),
  FOREIGN KEY (memberno) REFERENCES member (memberno)
);

COMMENT ON TABLE mywallet is '내 지갑';
COMMENT ON COLUMN mywallet.paysort is '결제종류';
COMMENT ON COLUMN mywallet.memberno is '회원번호';
COMMENT ON COLUMN mywallet.account_number is '계좌번호';
COMMENT ON COLUMN mywallet.cardnumber is '카드번호';


/**********************************/
/* Table Name: 결제수단 */
/**********************************/
CREATE TABLE paysort(
		paysortno                     		NUMBER(2)		 NOT NULL		 PRIMARY KEY,
		psortname                     		VARCHAR2(20)		 NOT NULL,
  FOREIGN KEY () REFERENCES mywallet ()
);

COMMENT ON TABLE paysort is '결제수단';
COMMENT ON COLUMN paysort.paysortno is '결제수단번호';
COMMENT ON COLUMN paysort.psortname is '결제수단명';


/**********************************/
/* Table Name: 결제 */
/**********************************/
CREATE TABLE payment(
		paymentno                     		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		paysortno                     		NUMBER(2)		 NULL ,
  FOREIGN KEY (paysortno) REFERENCES paysort (paysortno)
);

COMMENT ON TABLE payment is '결제';
COMMENT ON COLUMN payment.paymentno is '결제번호';
COMMENT ON COLUMN payment.paysortno is '결제수단번호';


