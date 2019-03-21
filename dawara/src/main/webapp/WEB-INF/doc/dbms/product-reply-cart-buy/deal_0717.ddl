DROP TABLE BUY CASCADE CONSTRAINTS;
DROP TABLE payment CASCADE CONSTRAINTS;
DROP TABLE DEAL CASCADE CONSTRAINTS;
DROP TABLE shipping CASCADE CONSTRAINTS;
DROP TABLE PRODUCT CASCADE CONSTRAINTS;
DROP TABLE MEMBER CASCADE CONSTRAINTS;

/**********************************/
/* Table Name: ȸ�� */
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

COMMENT ON TABLE MEMBER is 'ȸ��';
COMMENT ON COLUMN MEMBER.MEM_NO is 'ȸ�� ��ȣ';
COMMENT ON COLUMN MEMBER.AUTH_NO is '���� ��ȣ';
COMMENT ON COLUMN MEMBER.MEM_ID is '���̵�';
COMMENT ON COLUMN MEMBER.MEM_PIC is 'ȸ������';
COMMENT ON COLUMN MEMBER.MEM_PASS is '�н�����';
COMMENT ON COLUMN MEMBER.MEM_NAME is '����';
COMMENT ON COLUMN MEMBER.MEM_TEL is '��ȭ��ȣ';
COMMENT ON COLUMN MEMBER.MEM_MAIL is '�̸����ּ�';
COMMENT ON COLUMN MEMBER.MEM_JOB is 'ȸ������';
COMMENT ON COLUMN MEMBER.MEM_ZIPCODE is '�����ȣ';
COMMENT ON COLUMN MEMBER.MEM_ADDR1 is '�ּ�1';
COMMENT ON COLUMN MEMBER.MEM_ADDR2 is '�ּ�2';
COMMENT ON COLUMN MEMBER.MEM_ACC is '�Ű�Ƚ��';
COMMENT ON COLUMN MEMBER.MEM_CONFIRM is '����Ȯ�ο���';
COMMENT ON COLUMN MEMBER.MEM_DATE is '������';
COMMENT ON COLUMN MEMBER.MEM_MILE is 'ȸ�� ���ϸ���';


/**********************************/
/* Table Name: ��ǰ */
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

COMMENT ON TABLE PRODUCT is '��ǰ';
COMMENT ON COLUMN PRODUCT.PR_NO is '��ǰ ��ȣ';
COMMENT ON COLUMN PRODUCT.GORY_NO is 'ī�װ���ȣ';
COMMENT ON COLUMN PRODUCT.MEM_NO is 'ȸ�� ��ȣ';
COMMENT ON COLUMN PRODUCT.PR_TITLE is '����';
COMMENT ON COLUMN PRODUCT.PR_CONTENTS is '����';
COMMENT ON COLUMN PRODUCT.PR_THUMBS is 'thumbs ����';
COMMENT ON COLUMN PRODUCT.PR_FILES is '���ϵ��� �̸�';
COMMENT ON COLUMN PRODUCT.PR_SIZES is '���ϵ��� ũ��';
COMMENT ON COLUMN PRODUCT.PR_CNT is '��ȸ��';
COMMENT ON COLUMN PRODUCT.PR_RDATE is '�����';
COMMENT ON COLUMN PRODUCT.PR_BUYYEAR is '���� �ñ�';
COMMENT ON COLUMN PRODUCT.PR_STATE is '��ǰ ����';
COMMENT ON COLUMN PRODUCT.PR_TRANSACTION is '�ŷ� ���';
COMMENT ON COLUMN PRODUCT.PR_LOCAL is '�ŷ� ����';
COMMENT ON COLUMN PRODUCT.PR_BUYPRICE is '���� ����';
COMMENT ON COLUMN PRODUCT.PR_PRICE is '�Ǹ� ����';
COMMENT ON COLUMN PRODUCT.PR_VISIBLE is '��� ����';
COMMENT ON COLUMN PRODUCT.PR_PAYMENT is '����';
COMMENT ON COLUMN PRODUCT.mem_no is 'ȸ����ȣ';


/**********************************/
/* Table Name: ��ǰ ��� */
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

COMMENT ON TABLE shipping is '��ǰ ���';
COMMENT ON COLUMN shipping.ship_no is '��۹�ȣ';
COMMENT ON COLUMN shipping.ship_zipcode is '�����ȣ';
COMMENT ON COLUMN shipping.ship_addr1 is '�����1';
COMMENT ON COLUMN shipping.ship_addr2 is '�����2';
COMMENT ON COLUMN shipping.ship_rname is '��۹޴»��';
COMMENT ON COLUMN shipping.ship_rtel is '�޴»���޴���';
COMMENT ON COLUMN shipping.ship_memo is '��۽� ��û����';
COMMENT ON COLUMN shipping.ship_date is '�߼۳�¥';
COMMENT ON COLUMN shipping.ship_check is '�߼�Ȯ��';
COMMENT ON COLUMN shipping.PR_NO is '��ǰ ��ȣ';
COMMENT ON COLUMN shipping.MEM_NO is 'ȸ�� ��ȣ';


/**********************************/
/* Table Name: ��ǰ �ŷ� */
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

COMMENT ON TABLE DEAL is '��ǰ �ŷ�';
COMMENT ON COLUMN DEAL.DEAL_NO is '�ŷ���ȣ';
COMMENT ON COLUMN DEAL.D_STATE is '�ŷ�����';
COMMENT ON COLUMN DEAL.D_DATE is '�ŷ������';
COMMENT ON COLUMN DEAL.D_CHECK is '�ŷ�Ȯ��';
COMMENT ON COLUMN DEAL.D_MEMO is '�ŷ��޸�';
COMMENT ON COLUMN DEAL.MEM_NO is 'ȸ����ȣ';
COMMENT ON COLUMN DEAL.PR_NO is '��ǰ��ȣ';


/**********************************/
/* Table Name: ���� */
/**********************************/
CREATE TABLE payment(
		payment_no                    		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		ship_no                       		NUMBER(10)		 NULL ,
  FOREIGN KEY (ship_no) REFERENCES shipping (ship_no)
);

COMMENT ON TABLE payment is '����';
COMMENT ON COLUMN payment.payment_no is '������ȣ';
COMMENT ON COLUMN payment.ship_no is '��۹�ȣ';


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
COMMENT ON COLUMN BUY.payment_no is '������ȣ';


