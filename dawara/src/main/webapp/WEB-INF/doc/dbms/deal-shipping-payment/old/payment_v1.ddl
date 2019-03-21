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
/* Table Name: ���°��� */
/**********************************/
CREATE TABLE bankpay(
		account_number                		NUMBER(20)		 NOT NULL		 PRIMARY KEY,
		paysortno                     		NUMBER(2)		 NOT NULL,
		bankname                      		VARCHAR2(20)		 NOT NULL,
		depositor                     		VARCHAR2(20)		 NOT NULL,
		accountholder                 		VARCHAR2(20)		 NOT NULL
);

COMMENT ON TABLE bankpay is '���°���';
COMMENT ON COLUMN bankpay.account_number is '���¹�ȣ';
COMMENT ON COLUMN bankpay.paysortno is '�������ܹ�ȣ';
COMMENT ON COLUMN bankpay.bankname is '�����';
COMMENT ON COLUMN bankpay.depositor is '�Ա���';
COMMENT ON COLUMN bankpay.accountholder is '������';


/**********************************/
/* Table Name: ī����� */
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

COMMENT ON TABLE cardpay is 'ī�����';
COMMENT ON COLUMN cardpay.cardnumber is 'ī���ȣ';
COMMENT ON COLUMN cardpay.paysortno is '�������ܹ�ȣ';
COMMENT ON COLUMN cardpay.bname is '�����';
COMMENT ON COLUMN cardpay.cardsort is 'ī������';
COMMENT ON COLUMN cardpay.owner is 'ī������';
COMMENT ON COLUMN cardpay.seller is '�������';
COMMENT ON COLUMN cardpay.expires is '���ᳯ¥';
COMMENT ON COLUMN cardpay.memo is '�޸�';


/**********************************/
/* Table Name: �Ǹű��� */
/**********************************/
CREATE TABLE buysell(
		sellno                        		NUMBER(7)		 NOT NULL		 PRIMARY KEY
);

COMMENT ON TABLE buysell is '�Ǹű���';
COMMENT ON COLUMN buysell.sellno is '�ǸŹ�ȣ';


/**********************************/
/* Table Name: �������� */
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

COMMENT ON TABLE PAYMENT is '��������';
COMMENT ON COLUMN PAYMENT.PAYMENTNO is '������ȣ';
COMMENT ON COLUMN PAYMENT.SELLNO is '�ǸŹ�ȣ';
COMMENT ON COLUMN PAYMENT.MEM_NO is 'ȸ����ȣ';
COMMENT ON COLUMN PAYMENT.PAYSORT is '��������';
COMMENT ON COLUMN PAYMENT.HOWMUCH is '�����ݾ�';
COMMENT ON COLUMN PAYMENT.PDATE is '������¥';
COMMENT ON COLUMN PAYMENT.PNAME is '������ ���';
COMMENT ON COLUMN PAYMENT.PAYCHECK is '�������ο���';
COMMENT ON COLUMN PAYMENT.PMEMO is '�����޸�';


/**********************************/
/* Table Name: �� ĳ�� */
/**********************************/
CREATE TABLE mycash(
		mycash                        		NUMBER(15)		 NULL ,
		savedate                      		DATE		 NOT NULL,
		savecash                      		NUMBER(15)		 NULL ,
		usage                         		VARCHAR2(50)		 NOT NULL,
		memberno                      		NUMBER(6)		 NULL 
);

COMMENT ON TABLE mycash is '�� ĳ��';
COMMENT ON COLUMN mycash.mycash is '�� ĳ��';
COMMENT ON COLUMN mycash.savedate is '������¥';
COMMENT ON COLUMN mycash.savecash is '����ĳ��';
COMMENT ON COLUMN mycash.usage is '���ó';
COMMENT ON COLUMN mycash.memberno is 'ȸ����ȣ';


/**********************************/
/* Table Name: ȸ�� */
/**********************************/
CREATE TABLE member(
		memberno                      		NUMBER(6)		 NOT NULL		 PRIMARY KEY,
		sellno                        		NUMBER(7)		 NULL ,
		PAYMENTNO                     		NUMBER(10)		 NULL ,
  FOREIGN KEY (sellno) REFERENCES buysell (sellno),
  FOREIGN KEY (PAYMENTNO) REFERENCES PAYMENT (PAYMENTNO),
  FOREIGN KEY () REFERENCES mycash ()
);

COMMENT ON TABLE member is 'ȸ��';
COMMENT ON COLUMN member.memberno is 'ȸ����ȣ';
COMMENT ON COLUMN member.sellno is '�ǸŹ�ȣ';
COMMENT ON COLUMN member.PAYMENTNO is '������ȣ';


/**********************************/
/* Table Name: �� ���� */
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

COMMENT ON TABLE mywallet is '�� ����';
COMMENT ON COLUMN mywallet.paysort is '��������';
COMMENT ON COLUMN mywallet.memberno is 'ȸ����ȣ';
COMMENT ON COLUMN mywallet.account_number is '���¹�ȣ';
COMMENT ON COLUMN mywallet.cardnumber is 'ī���ȣ';


/**********************************/
/* Table Name: �������� */
/**********************************/
CREATE TABLE paysort(
		paysortno                     		NUMBER(2)		 NOT NULL		 PRIMARY KEY,
		psortname                     		VARCHAR2(20)		 NOT NULL,
  FOREIGN KEY () REFERENCES mywallet ()
);

COMMENT ON TABLE paysort is '��������';
COMMENT ON COLUMN paysort.paysortno is '�������ܹ�ȣ';
COMMENT ON COLUMN paysort.psortname is '�������ܸ�';


/**********************************/
/* Table Name: ���� */
/**********************************/
CREATE TABLE payment(
		paymentno                     		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		paysortno                     		NUMBER(2)		 NULL ,
  FOREIGN KEY (paysortno) REFERENCES paysort (paysortno)
);

COMMENT ON TABLE payment is '����';
COMMENT ON COLUMN payment.paymentno is '������ȣ';
COMMENT ON COLUMN payment.paysortno is '�������ܹ�ȣ';


