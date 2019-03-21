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
/* Table Name: ȸ�� */
/**********************************/
CREATE TABLE member(
		mem_no                        		NUMBER(6)		 NOT NULL		 PRIMARY KEY
);

COMMENT ON TABLE member is 'ȸ��';
COMMENT ON COLUMN member.mem_no is 'ȸ����ȣ';


/**********************************/
/* Table Name: �Ǹű��� */
/**********************************/
CREATE TABLE buysell(
		sellno                        		NUMBER(7)		 NOT NULL		 PRIMARY KEY,
		mem_no                        		NUMBER(6)		 NULL ,
  FOREIGN KEY (mem_no) REFERENCES member (mem_no)
);

COMMENT ON TABLE buysell is '�Ǹű���';
COMMENT ON COLUMN buysell.sellno is '�ǸŹ�ȣ';
COMMENT ON COLUMN buysell.mem_no is 'ȸ����ȣ';


/**********************************/
/* Table Name: �ŷ� */
/**********************************/
CREATE TABLE deal(
		dealno                        		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		sellno                        		NUMBER(7)		 NULL ,
  FOREIGN KEY (sellno) REFERENCES buysell (sellno)
);

COMMENT ON TABLE deal is '�ŷ�';
COMMENT ON COLUMN deal.dealno is '�ŷ���ȣ';
COMMENT ON COLUMN deal.sellno is '�ǸŹ�ȣ';


/**********************************/
/* Table Name: �������� */
/**********************************/
CREATE TABLE paysign(
		signno                        		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		paysign                       		CHAR(1)		 DEFAULT 'N'		 NOT NULL,
		sellersign                    		VARCHAR2(20)		 NOT NULL,
		buysign                       		VARCHAR2(20)		 NOT NULL,
		agreedate                     		DATE		 NOT NULL
);

COMMENT ON TABLE paysign is '��������';
COMMENT ON COLUMN paysign.signno is '�����ȣ';
COMMENT ON COLUMN paysign.paysign is '�������ǿ���';
COMMENT ON COLUMN paysign.sellersign is '�Ǹ��ڼ���';
COMMENT ON COLUMN paysign.buysign is '�����ڼ���';
COMMENT ON COLUMN paysign.agreedate is '���ǳ�¥';


/**********************************/
/* Table Name: ���� */
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

COMMENT ON TABLE payment is '����';
COMMENT ON COLUMN payment.paymentno is '������ȣ';
COMMENT ON COLUMN payment.paysortno is '�������ܹ�ȣ';
COMMENT ON COLUMN payment.mem_no is 'ȸ����ȣ';
COMMENT ON COLUMN payment.signno is '�����ȣ';
COMMENT ON COLUMN payment.dealno is '�ŷ���ȣ';


/**********************************/
/* Table Name: �������� */
/**********************************/
CREATE TABLE paysort(
		paysortno                     		NUMBER(2)		 NOT NULL		 PRIMARY KEY,
		psortname                     		VARCHAR2(20)		 NOT NULL,
		paymentno                     		NUMBER(10)		 NULL ,
  FOREIGN KEY (paymentno) REFERENCES payment (paymentno)
);

COMMENT ON TABLE paysort is '��������';
COMMENT ON COLUMN paysort.paysortno is '�������ܹ�ȣ';
COMMENT ON COLUMN paysort.psortname is '�������ܸ�';
COMMENT ON COLUMN paysort.paymentno is '������ȣ';


/**********************************/
/* Table Name: �� ���� */
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

COMMENT ON TABLE myaccount is '�� ����';
COMMENT ON COLUMN myaccount.account_number is '���¹�ȣ';
COMMENT ON COLUMN myaccount.balance is '�ܾ�';
COMMENT ON COLUMN myaccount.bankname is '�����';
COMMENT ON COLUMN myaccount.depositor is '�Ա���';
COMMENT ON COLUMN myaccount.accountholder is '������';
COMMENT ON COLUMN myaccount.paysortno is '�������ܹ�ȣ';


/**********************************/
/* Table Name: �� ī�� */
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

COMMENT ON TABLE mycard is '�� ī��';
COMMENT ON COLUMN mycard.cardnumber is 'ī���ȣ';
COMMENT ON COLUMN mycard.bname is '�����';
COMMENT ON COLUMN mycard.cardsort is 'ī������';
COMMENT ON COLUMN mycard.owner is 'ī������';
COMMENT ON COLUMN mycard.expires is '���ᳯ¥';
COMMENT ON COLUMN mycard.memo is '�޸�';
COMMENT ON COLUMN mycard.paysortno is '�������ܹ�ȣ';


/**********************************/
/* Table Name: �� ĳ�� */
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

COMMENT ON TABLE mycash is '�� ĳ��';
COMMENT ON COLUMN mycash.cashno is 'ĳ�ù�ȣ';
COMMENT ON COLUMN mycash.mycash is '�� ĳ��';
COMMENT ON COLUMN mycash.savedate is '������¥';
COMMENT ON COLUMN mycash.usedate is '��볯¥';
COMMENT ON COLUMN mycash.savecash is '����ĳ��';
COMMENT ON COLUMN mycash.usecash is 'ĳ�û�뿩��';
COMMENT ON COLUMN mycash.paysortno is '�������ܹ�ȣ';


/**********************************/
/* Table Name: �� ���� */
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

COMMENT ON TABLE mywallet is '�� ����';
COMMENT ON COLUMN mywallet.mywalletno is '������ȣ';
COMMENT ON COLUMN mywallet.mem_no is 'ȸ����ȣ';
COMMENT ON COLUMN mywallet.account_number is '���¹�ȣ';
COMMENT ON COLUMN mywallet.cardnumber is 'ī���ȣ';
COMMENT ON COLUMN mywallet.cashno is 'ĳ�ù�ȣ';


/**********************************/
/* Table Name: ������ */
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

COMMENT ON TABLE receipt is '������';
COMMENT ON COLUMN receipt.receiptno is '��������ȣ';
COMMENT ON COLUMN receipt.SELLNO is '�ǸŹ�ȣ';
COMMENT ON COLUMN receipt.MEM_NO is 'ȸ����ȣ';
COMMENT ON COLUMN receipt.PAYSORT is '��������';
COMMENT ON COLUMN receipt.HOWMUCH is '�����ݾ�';
COMMENT ON COLUMN receipt.PDATE is '������¥';
COMMENT ON COLUMN receipt.PAYCHECK is '�������ο���';
COMMENT ON COLUMN receipt.PMEMO is '�����޸�';
COMMENT ON COLUMN receipt.mem_no is 'ȸ����ȣ';
COMMENT ON COLUMN receipt.signno is '�����ȣ';


