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
/* Table Name: ȸ�� */
/**********************************/
CREATE TABLE member(
		mem_no                        		NUMBER(6)		 NOT NULL
);

COMMENT ON TABLE member is 'ȸ��';
COMMENT ON COLUMN member.mem_no is 'ȸ����ȣ';


/**********************************/
/* Table Name: �Ǹű��� */
/**********************************/
CREATE TABLE buysell(
		buysellno                     		NUMBER(10)		 NOT NULL
);

COMMENT ON TABLE buysell is '�Ǹű���';
COMMENT ON COLUMN buysell.buysellno is '�Ǹű��Ź�ȣ';


/**********************************/
/* Table Name: �ŷ� */
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

COMMENT ON TABLE deal is '�ŷ�';
COMMENT ON COLUMN deal.dealno is '�ŷ���ȣ';
COMMENT ON COLUMN deal.howmuch is '�ŷ��ݾ�';
COMMENT ON COLUMN deal.buysellno is '�Ǹű��Ź�ȣ';
COMMENT ON COLUMN deal.dealdate is '�ŷ���¥';
COMMENT ON COLUMN deal.sellersign is '�Ǹ��ڼ���';
COMMENT ON COLUMN deal.buyersign is '�����ڼ���';
COMMENT ON COLUMN deal.dealmemo is '�ŷ��޸�';
COMMENT ON COLUMN deal.mem_no is 'ȸ����ȣ';


/**********************************/
/* Table Name: �ŷ����� */
/**********************************/
CREATE TABLE dealsort(
		dealsortno                    		NUMBER(2)		 NOT NULL,
		dealsortname                  		VARCHAR2(20)		 NOT NULL,
		dealno                        		NUMBER(10)		 NULL 
);

COMMENT ON TABLE dealsort is '�ŷ�����';
COMMENT ON COLUMN dealsort.dealsortno is '�ŷ����ܹ�ȣ';
COMMENT ON COLUMN dealsort.dealsortname is '�ŷ�����';
COMMENT ON COLUMN dealsort.dealno is '�ŷ���ȣ';


/**********************************/
/* Table Name: �� ���� */
/**********************************/
CREATE TABLE mywallet(
		mem_no                        		NUMBER(6)		 NOT NULL,
		dealsortno                    		NUMBER(2)		 NULL 
);

COMMENT ON TABLE mywallet is '�� ����';
COMMENT ON COLUMN mywallet.mem_no is 'ȸ����ȣ';
COMMENT ON COLUMN mywallet.dealsortno is '�ŷ����ܹ�ȣ';


/**********************************/
/* Table Name: ī�� */
/**********************************/
CREATE TABLE card(
		cardidno                      		NUMBER(10)		 NOT NULL,
		cardcompany                   		VARCHAR2(10)		 NOT NULL,
		cardnumber                    		NUMBER(16)		 NOT NULL,
		expires                       		NUMBER(6)		 NOT NULL,
		dealsortno                    		NUMBER(2)		 NULL 
);

COMMENT ON TABLE card is 'ī��';
COMMENT ON COLUMN card.cardidno is 'ī�屸�й�ȣ';
COMMENT ON COLUMN card.cardcompany is 'ī���';
COMMENT ON COLUMN card.cardnumber is 'ī���ȣ';
COMMENT ON COLUMN card.expires is 'ī�常����';
COMMENT ON COLUMN card.dealsortno is '�ŷ����ܹ�ȣ';


/**********************************/
/* Table Name: �ŷ���� */
/**********************************/
CREATE TABLE dealway(
		dealwayno                     		NUMBER(10)		 NOT NULL,
		dealway                       		VARCHAR2(20)		 NOT NULL,
		dealno                        		NUMBER(10)		 NULL 
);

COMMENT ON TABLE dealway is '�ŷ����';
COMMENT ON COLUMN dealway.dealwayno is '�ŷ������ȣ';
COMMENT ON COLUMN dealway.dealway is '�ŷ����';
COMMENT ON COLUMN dealway.dealno is '�ŷ���ȣ';


/**********************************/
/* Table Name: �� ĳ�� */
/**********************************/
CREATE TABLE mycash(
		cashidno                      		NUMBER(10)		 NOT NULL,
		mycash                        		NUMBER(10)		 NULL ,
		addcashdate                   		DATE		 NULL ,
		mem_no                        		NUMBER(6)		 NOT NULL
);

COMMENT ON TABLE mycash is '�� ĳ��';
COMMENT ON COLUMN mycash.cashidno is 'ĳ�ñ��й�ȣ';
COMMENT ON COLUMN mycash.mycash is '�� ĳ��';
COMMENT ON COLUMN mycash.addcashdate is 'ĳ�õ����';
COMMENT ON COLUMN mycash.mem_no is 'ȸ����ȣ';


/**********************************/
/* Table Name: ĳ������ */
/**********************************/
CREATE TABLE earncash(
		earncashno                    		NUMBER(10)		 NOT NULL,
		savecash                      		NUMBER(15)		 NULL ,
		savedate                      		DATE		 NOT NULL,
		dealno                        		NUMBER(10)		 NOT NULL,
		cashidno                      		NUMBER(10)		 NULL 
);

COMMENT ON TABLE earncash is 'ĳ������';
COMMENT ON COLUMN earncash.earncashno is '����ĳ�ù�ȣ';
COMMENT ON COLUMN earncash.savecash is '����ĳ��';
COMMENT ON COLUMN earncash.savedate is '������¥';
COMMENT ON COLUMN earncash.dealno is '�ŷ���ȣ';
COMMENT ON COLUMN earncash.cashidno is 'ĳ�ñ��й�ȣ';


/**********************************/
/* Table Name: �� ī�� */
/**********************************/
CREATE TABLE mycard(
		cardidno                      		NUMBER(10)		 NOT NULL,
		addcarddate                   		DATE		 NOT NULL,
		mem_no                        		NUMBER(6)		 NOT NULL
);

COMMENT ON TABLE mycard is '�� ī��';
COMMENT ON COLUMN mycard.cardidno is 'ī�屸�й�ȣ';
COMMENT ON COLUMN mycard.addcarddate is 'ī������';
COMMENT ON COLUMN mycard.mem_no is 'ȸ����ȣ';


/**********************************/
/* Table Name: ���� */
/**********************************/
CREATE TABLE account(
		accountidno                   		NUMBER(10)		 NOT NULL,
		bankname                      		VARCHAR2(20)		 NOT NULL,
		accountnum                    		NUMBER(16)		 NOT NULL,
		depositor                     		VARCHAR2(20)		 NOT NULL,
		dealsortno                    		NUMBER(2)		 NULL 
);

COMMENT ON TABLE account is '����';
COMMENT ON COLUMN account.accountidno is '���±��й�ȣ';
COMMENT ON COLUMN account.bankname is '�����';
COMMENT ON COLUMN account.accountnum is '���¹�ȣ';
COMMENT ON COLUMN account.depositor is '������';
COMMENT ON COLUMN account.dealsortno is '�ŷ����ܹ�ȣ';


/**********************************/
/* Table Name: �� ���� */
/**********************************/
CREATE TABLE myaccount(
		accountidno                   		NUMBER(10)		 NOT NULL,
		accountadddate                		DATE		 NOT NULL,
		mem_no                        		NUMBER(6)		 NOT NULL
);

COMMENT ON TABLE myaccount is '�� ����';
COMMENT ON COLUMN myaccount.accountidno is '���±��й�ȣ';
COMMENT ON COLUMN myaccount.accountadddate is '���µ����';
COMMENT ON COLUMN myaccount.mem_no is 'ȸ����ȣ';



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

