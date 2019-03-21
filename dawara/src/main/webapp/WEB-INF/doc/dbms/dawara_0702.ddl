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
/* Table Name: ���� */
/**********************************/
CREATE TABLE AUTH(
		AUTH_NO                       		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		AUTH_INFO                     		VARCHAR2(100)		 NOT NULL
);

COMMENT ON TABLE AUTH is '����';
COMMENT ON COLUMN AUTH.AUTH_NO is '���� ��ȣ';
COMMENT ON COLUMN AUTH.AUTH_INFO is '���� ����';


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
  FOREIGN KEY (AUTH_NO) REFERENCES AUTH (AUTH_NO),
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
/* Table Name: �α��� */
/**********************************/
CREATE TABLE LOGIN(
		LOGIN_NO                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		MEM_NO                        		NUMBER(6)		 NOT NULL,
		LOGIN_IP                      		VARCHAR2(15)		 NOT NULL,
		LOGIN_DATE                    		DATE		 NOT NULL,
  FOREIGN KEY (MEM_NO) REFERENCES MEMBER (MEM_NO)
);

COMMENT ON TABLE LOGIN is '�α���';
COMMENT ON COLUMN LOGIN.LOGIN_NO is '�α��ι�ȣ';
COMMENT ON COLUMN LOGIN.MEM_NO is 'ȸ����ȣ';
COMMENT ON COLUMN LOGIN.LOGIN_IP is 'login_ip';
COMMENT ON COLUMN LOGIN.LOGIN_DATE is '�α��γ�¥';


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
COMMENT ON COLUMN NOTICE.NO_NO is '��ȣ';
COMMENT ON COLUMN NOTICE.MEM_NO is '������ ��ȣ';
COMMENT ON COLUMN NOTICE.NO_TITLE is '����';
COMMENT ON COLUMN NOTICE.NO_WRITE is '�۾���';
COMMENT ON COLUMN NOTICE.NO_RDATE is '�����';
COMMENT ON COLUMN NOTICE.NO_QNA_CNT is '��ȸ��';
COMMENT ON COLUMN NOTICE.NO_QNA_CONTENTS is '����';
COMMENT ON COLUMN NOTICE.NO_VISIBLE is '���� ����';


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
COMMENT ON COLUMN QNA.QNA_NO is '�� �Ϸ� ��ȣ';
COMMENT ON COLUMN QNA.MEM_NO is 'ȸ�� ��ȣ';
COMMENT ON COLUMN QNA.QNA_WIRTE is '�۾���';
COMMENT ON COLUMN QNA.QNA_EMAIL is '�̸���';
COMMENT ON COLUMN QNA.NO_TITLE is '����';
COMMENT ON COLUMN QNA.QNA_CONTENT is '�� ����';
COMMENT ON COLUMN QNA.QNA_PASSWD is '�� �Ϸ� ��ȣ';
COMMENT ON COLUMN QNA.QNA_CNT is '��ȸ��';
COMMENT ON COLUMN QNA.QNA_RDATE is '��� ��¥';
COMMENT ON COLUMN QNA.QNA_WEB is 'URL';
COMMENT ON COLUMN QNA.QNA_FILE1 is '���ϸ�';
COMMENT ON COLUMN QNA.QNA_FSTOR1 is '���� ���� ���ϸ�';
COMMENT ON COLUMN QNA.QNA_SIZE1 is '���� ũ�� 1';
COMMENT ON COLUMN QNA.QNA_VISIBLE is '�����';
COMMENT ON COLUMN QNA.QNA_GRPNO is '�׷� ��ȣ';
COMMENT ON COLUMN QNA.QNA_INDENT is '�亯 ����';
COMMENT ON COLUMN QNA.QNA_ANSNUM is '�亯 ����';


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
COMMENT ON COLUMN REPORT.RPT_NO is '�� �Ϸ� ��ȣ';
COMMENT ON COLUMN REPORT.MEM_NO is 'ȸ�� ��ȣ';
COMMENT ON COLUMN REPORT.RPT_WRITE is '�۾���';
COMMENT ON COLUMN REPORT.RPT_EMAIL is '�̸���';
COMMENT ON COLUMN REPORT.RPT_TITLE is '����';
COMMENT ON COLUMN REPORT.RPT_CONTENT is '�� ����';
COMMENT ON COLUMN REPORT.RPT_PASSWD is '�� �Ϸ� ��ȣ';
COMMENT ON COLUMN REPORT.RPT_CNT is '��ȸ��';
COMMENT ON COLUMN REPORT.RPT_RDATE is '��� ��¥';
COMMENT ON COLUMN REPORT.RPT_WEB is 'URL';
COMMENT ON COLUMN REPORT.RPT_FILE1 is '���ϸ�';
COMMENT ON COLUMN REPORT.RPT_FSTOR1 is '���� ���� ���ϸ�';
COMMENT ON COLUMN REPORT.RPT_SIZE1 is '���� ũ�� 1';
COMMENT ON COLUMN REPORT.RPT_VISIBLE is '�����';
COMMENT ON COLUMN REPORT.RPT_GRPNO is '�׷� ��ȣ';
COMMENT ON COLUMN REPORT.RPT_INDENT is '�亯 ����';
COMMENT ON COLUMN REPORT.RPT_ANSNUM is '�亯 ����';


/**********************************/
/* Table Name: ī�װ� �׷� */
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

COMMENT ON TABLE CATEGRP is 'ī�װ� �׷�';
COMMENT ON COLUMN CATEGRP.GRP_NO is 'ī�װ� �׷� ��ȣ';
COMMENT ON COLUMN CATEGRP.GRP_CLASSIFICATION is 'ī�װ� �׷� �з�';
COMMENT ON COLUMN CATEGRP.GRP_TITLE is '�׷� �̸�';
COMMENT ON COLUMN CATEGRP.GRP_SEQNO is '��� ����';
COMMENT ON COLUMN CATEGRP.GRP_VISIBLE is '��� ���';
COMMENT ON COLUMN CATEGRP.GRP_RDATE is '�׷� ������';
COMMENT ON COLUMN CATEGRP.MEM_NO is 'ȸ�� ��ȣ';


/**********************************/
/* Table Name: ī�װ� */
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

COMMENT ON TABLE CATEGORY is 'ī�װ�';
COMMENT ON COLUMN CATEGORY.GORY_NO is 'ī�װ� ��ȣ';
COMMENT ON COLUMN CATEGORY.GRP_NO is 'ī�װ� �׷� ��ȣ';
COMMENT ON COLUMN CATEGORY.MEM_NO is 'ȸ�� ��ȣ';
COMMENT ON COLUMN CATEGORY.GORY_TITLE is '�Խ��� �̸�';
COMMENT ON COLUMN CATEGORY.GORY_SEQNO is '��� ����';
COMMENT ON COLUMN CATEGORY.GORY_VISIBLE is '��� ���';
COMMENT ON COLUMN CATEGORY.GORY_IDS is '���� ����';
COMMENT ON COLUMN CATEGORY.GORY_CNT is '��ϵ� �� ��';
COMMENT ON COLUMN CATEGORY.GORY_RDATE is '�����';


/**********************************/
/* Table Name: �˻��� */
/**********************************/
CREATE TABLE SURF(
		SURF_NO                       		NUMBER(7)		 NOT NULL		 PRIMARY KEY,
		SURF_WORD                     		VARCHAR2(300)		 NOT NULL,
		SURF_CNT                      		NUMBER(7)		 NOT NULL,
		SURF_RDATE                    		DATE		 NOT NULL,
		MEM_NO                        		NUMBER(6)		 NOT NULL,
  FOREIGN KEY (MEM_NO) REFERENCES MEMBER (MEM_NO)
);

COMMENT ON TABLE SURF is '�˻���';
COMMENT ON COLUMN SURF.SURF_NO is '������ ��ȣ';
COMMENT ON COLUMN SURF.SURF_WORD is '�˻���';
COMMENT ON COLUMN SURF.SURF_CNT is '��ȸ��';
COMMENT ON COLUMN SURF.SURF_RDATE is '�����';
COMMENT ON COLUMN SURF.MEM_NO is 'ȸ�� ��ȣ';


/**********************************/
/* Table Name: ��ǰ */
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

COMMENT ON TABLE PRODUCT is '��ǰ';
COMMENT ON COLUMN PRODUCT.PR_NO is '��ǰ ��ȣ';
COMMENT ON COLUMN PRODUCT.GORY_NO is 'ī�װ���ȣ';
COMMENT ON COLUMN PRODUCT.MEM_NO is 'ȸ�� ��ȣ';
COMMENT ON COLUMN PRODUCT.PR_MAKER is '�귣���';
COMMENT ON COLUMN PRODUCT.PR_TITLE is '����';
COMMENT ON COLUMN PRODUCT.PR_CONTENTS is '����';
COMMENT ON COLUMN PRODUCT.PR_THUMBS is 'thumbs ����';
COMMENT ON COLUMN PRODUCT.PR_FILES is '���ϵ��� �̸�';
COMMENT ON COLUMN PRODUCT.PR_SIZES is '���ϵ��� ũ��';
COMMENT ON COLUMN PRODUCT.PR_CNT is '��ȸ��';
COMMENT ON COLUMN PRODUCT.PR_RDATE is '�����';
COMMENT ON COLUMN PRODUCT.PR_YEAR is '���ǿ���';
COMMENT ON COLUMN PRODUCT.PR_WORD is '�˻���';
COMMENT ON COLUMN PRODUCT.PR_PRICE is '����';
COMMENT ON COLUMN PRODUCT.PR_VISIBLE is '��� ����';
COMMENT ON COLUMN PRODUCT.PR_PAYMENT is '����';


/**********************************/
/* Table Name: ��ٱ��� */
/**********************************/
CREATE TABLE CART(
		CART_NO                       		NUMBER(6)		 NOT NULL		 PRIMARY KEY,
		PR_NO                         		NUMBER(7)		 NULL ,
		MEM_NO                        		NUMBER(6)		 NULL ,
		CART_RDATE                    		NUMBER(6)		 NULL ,
  FOREIGN KEY (MEM_NO) REFERENCES MEMBER (MEM_NO),
  FOREIGN KEY (PR_NO) REFERENCES PRODUCT (PR_NO)
);

COMMENT ON TABLE CART is '��ٱ���';
COMMENT ON COLUMN CART.CART_NO is '��ٱ��� ��ȣ';
COMMENT ON COLUMN CART.PR_NO is '��ǰ��ȣ';
COMMENT ON COLUMN CART.MEM_NO is 'ȸ�� ��ȣ';
COMMENT ON COLUMN CART.CART_RDATE is '��ٱ��� ��� ��¥';


/**********************************/
/* Table Name: ��� */
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

COMMENT ON TABLE REPLY is '���';
COMMENT ON COLUMN REPLY.RPL_NO is '��� ��ȣ';
COMMENT ON COLUMN REPLY.PR_NO is 'ī�װ���ȣ';
COMMENT ON COLUMN REPLY.MEM_NO is 'ȸ�� ��ȣ';
COMMENT ON COLUMN REPLY.RPL_CONTENTS is '����';
COMMENT ON COLUMN REPLY.RPL_RDATE is '�����';
COMMENT ON COLUMN REPLY.RPL_VISIBLE is '��� ����';
COMMENT ON COLUMN REPLY.RPL_GRPNO is '�׷� ��ȣ';
COMMENT ON COLUMN REPLY.RPL_INDENT is '�亯 ����';
COMMENT ON COLUMN REPLY.RPL_ANSNUM is '�亯 ��ȣ';


/**********************************/
/* Table Name: ���Ѻ� ���� URL */
/**********************************/
CREATE TABLE URLAUTH(
		URLAUTH_NO                    		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		URLAUTH_ADDRESS               		VARCHAR2(200)		 NOT NULL,
		AUTH_NO                       		NUMBER(10)		 NOT NULL,
  FOREIGN KEY (AUTH_NO) REFERENCES AUTH (AUTH_NO)
);

COMMENT ON TABLE URLAUTH is '���Ѻ� ���� URL';
COMMENT ON COLUMN URLAUTH.URLAUTH_NO is '���Ѻ� ���� URL ��ȣ';
COMMENT ON COLUMN URLAUTH.URLAUTH_ADDRESS is '���Ѻ� ���� URL �ּ�';
COMMENT ON COLUMN URLAUTH.AUTH_NO is '���� ��ȣ';


/**********************************/
/* Table Name: �ŷ� */
/**********************************/
CREATE TABLE DEAL(
		deal_no                       		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		d_state                       		VARCHAR2(20)		 DEFAULT '�ŷ���'		 NOT NULL,
		d_way                         		VARCHAR2(20)		 DEFAULT '�ù�ŷ�'		 NOT NULL,
		d_date                        		DATE		 NOT NULL,
		d_check                       		CHAR(1)		 DEFAULT 'N'		 NOT NULL,
		d_memo                        		VARCHAR2(100)		 DEFAULT '�޸�'		 NULL ,
		mem_no                        		NUMBER(6)		 NOT NULL,
		pr_no                         		NUMBER(10)		 NOT NULL,
  FOREIGN KEY (mem_no) REFERENCES MEMBER (MEM_NO),
  FOREIGN KEY (pr_no) REFERENCES PRODUCT (PR_NO)
);

COMMENT ON TABLE DEAL is '�ŷ�';
COMMENT ON COLUMN DEAL.deal_no is '�ŷ���ȣ';
COMMENT ON COLUMN DEAL.d_state is '�ŷ�����';
COMMENT ON COLUMN DEAL.d_way is '�ŷ����';
COMMENT ON COLUMN DEAL.d_date is '�ŷ������';
COMMENT ON COLUMN DEAL.d_check is '�ŷ�Ȯ��';
COMMENT ON COLUMN DEAL.d_memo is '�ŷ��޸�';
COMMENT ON COLUMN DEAL.mem_no is 'ȸ����ȣ';
COMMENT ON COLUMN DEAL.pr_no is '��ǰ��ȣ';


/**********************************/
/* Table Name: �������� */
/**********************************/
CREATE TABLE CHARGEWAY(
		CWAY_NO                       		NUMBER(2)		 NOT NULL		 PRIMARY KEY,
		CWAY                          		VARCHAR2(20)		 NOT NULL
);

COMMENT ON TABLE CHARGEWAY is '��������';
COMMENT ON COLUMN CHARGEWAY.CWAY_NO is '�������ܹ�ȣ';
COMMENT ON COLUMN CHARGEWAY.CWAY is '��������';


/**********************************/
/* Table Name: ���ϸ��� ���� */
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

COMMENT ON TABLE CHARGEMILEAGE is '���ϸ��� ����';
COMMENT ON COLUMN CHARGEMILEAGE.MCHARGE_NO is '������ȣ';
COMMENT ON COLUMN CHARGEMILEAGE.CWAY_NO is '�������ܹ�ȣ';
COMMENT ON COLUMN CHARGEMILEAGE.CMILEAGE is '�������ϸ���';
COMMENT ON COLUMN CHARGEMILEAGE.MEM_NO is 'ȸ����ȣ';
COMMENT ON COLUMN CHARGEMILEAGE.CMILEAGE_DATE is '������¥';


/**********************************/
/* Table Name: �� ���ϸ��� */
/**********************************/
CREATE TABLE MYMLIEAGE(
		MILEAGE_NO                    		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		MEM_NO                        		NUMBER(6)		 NOT NULL,
		MCHARGE_NO                    		NUMBER(10)		 NULL ,
		MYMILEAGE                     		NUMBER(10)		 NOT NULL,
  FOREIGN KEY (MEM_NO) REFERENCES MEMBER (MEM_NO),
  FOREIGN KEY (MCHARGE_NO) REFERENCES CHARGEMILEAGE (MCHARGE_NO)
);

COMMENT ON TABLE MYMLIEAGE is '�� ���ϸ���';
COMMENT ON COLUMN MYMLIEAGE.MILEAGE_NO is '���ϸ��� ��ȣ';
COMMENT ON COLUMN MYMLIEAGE.MEM_NO is 'ȸ����ȣ';
COMMENT ON COLUMN MYMLIEAGE.MCHARGE_NO is '������ȣ';
COMMENT ON COLUMN MYMLIEAGE.MYMILEAGE is '���ϸ���';


