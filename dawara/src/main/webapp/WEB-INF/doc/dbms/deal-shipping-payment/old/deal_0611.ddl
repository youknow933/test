DROP TABLE cash CASCADE CONSTRAINTS;
DROP TABLE deal CASCADE CONSTRAINTS;
DROP TABLE dealway CASCADE CONSTRAINTS;
DROP TABLE buysell CASCADE CONSTRAINTS;
DROP TABLE dealsort CASCADE CONSTRAINTS;
DROP TABLE mycard CASCADE CONSTRAINTS;
DROP TABLE mywallet CASCADE CONSTRAINTS;
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
/* Table Name: �� ���� */
/**********************************/
CREATE TABLE mywallet(
		mem_no                        		NUMBER(6)		 NOT NULL		 PRIMARY KEY,
  FOREIGN KEY (mem_no) REFERENCES member (mem_no)
);

COMMENT ON TABLE mywallet is '�� ����';
COMMENT ON COLUMN mywallet.mem_no is 'ȸ����ȣ';


/**********************************/
/* Table Name: �� ī�� */
/**********************************/
CREATE TABLE mycard(
		cardidno                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		cardsort                      		VARCHAR2(20)		 NULL ,
		cardnumber                    		NUMBER(16)		 NOT NULL,
		cardcompany                   		VARCHAR2(10)		 NOT NULL,
		expires                       		NUMBER(6)		 NOT NULL,
		mem_no                        		NUMBER(6)		 NULL ,
		dealsortno                    		NUMBER(2)		 NULL ,
  FOREIGN KEY (mem_no) REFERENCES mywallet (mem_no)
);

COMMENT ON TABLE mycard is '�� ī��';
COMMENT ON COLUMN mycard.cardidno is 'ī��ĺ���ȣ';
COMMENT ON COLUMN mycard.cardsort is 'ī��з�';
COMMENT ON COLUMN mycard.cardnumber is 'ī���ȣ';
COMMENT ON COLUMN mycard.cardcompany is 'ī���';
COMMENT ON COLUMN mycard.expires is 'ī�常����';
COMMENT ON COLUMN mycard.mem_no is 'ȸ����ȣ';
COMMENT ON COLUMN mycard.dealsortno is '�ŷ����ܹ�ȣ';


/**********************************/
/* Table Name: �ŷ����� */
/**********************************/
CREATE TABLE dealsort(
		dealsortno                    		NUMBER(2)		 NOT NULL		 PRIMARY KEY,
		dealsortname                  		VARCHAR2(20)		 NOT NULL,
		mem_no                        		NUMBER(6)		 NULL ,
  FOREIGN KEY (mem_no) REFERENCES mywallet (mem_no)
);

COMMENT ON TABLE dealsort is '�ŷ�����';
COMMENT ON COLUMN dealsort.dealsortno is '�ŷ����ܹ�ȣ';
COMMENT ON COLUMN dealsort.dealsortname is '�ŷ����ܸ�';
COMMENT ON COLUMN dealsort.mem_no is 'ȸ����ȣ';


/**********************************/
/* Table Name: �˴ϴٻ�ϴ� */
/**********************************/
CREATE TABLE buysell(
		buysellno                     		NUMBER(10)		 NOT NULL		 PRIMARY KEY
);

COMMENT ON TABLE buysell is '�˴ϴٻ�ϴ�';
COMMENT ON COLUMN buysell.buysellno is '�˴ϴٻ�ϴٹ�ȣ';


/**********************************/
/* Table Name: �ŷ���� */
/**********************************/
CREATE TABLE dealway(
		dealwayno                     		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		dealway                       		VARCHAR2(20)		 NOT NULL,
		dealno                        		NUMBER(10)		 NULL 
);

COMMENT ON TABLE dealway is '�ŷ����';
COMMENT ON COLUMN dealway.dealwayno is '�ŷ���Ĺ�ȣ';
COMMENT ON COLUMN dealway.dealway is '�ŷ���ĸ�';
COMMENT ON COLUMN dealway.dealno is '�ŷ���ȣ';


/**********************************/
/* Table Name: �ŷ� */
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

COMMENT ON TABLE deal is '�ŷ�';
COMMENT ON COLUMN deal.dealno is '�ŷ���ȣ';
COMMENT ON COLUMN deal.dealsortno is '�ŷ����ܹ�ȣ';
COMMENT ON COLUMN deal.howmuch is '�ŷ��ݾ�';
COMMENT ON COLUMN deal.dealdate is '�ŷ���¥';
COMMENT ON COLUMN deal.sellersign is '�Ǹ��ڼ���';
COMMENT ON COLUMN deal.buyersign is '�����ڼ���';
COMMENT ON COLUMN deal.dealmemo is '�ŷ��޸�';
COMMENT ON COLUMN deal.mem_no is 'ȸ����ȣ';
COMMENT ON COLUMN deal.buysellno is '�˴ϴٻ�ϴٹ�ȣ';
COMMENT ON COLUMN deal.dealwayno is '�ŷ���Ĺ�ȣ';


/**********************************/
/* Table Name: ĳ������ */
/**********************************/
CREATE TABLE cash(
		cashno                        		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		mycash                        		NUMBER(15)		 NULL ,
		savecash                      		NUMBER(15)		 NULL ,
		usecash                       		NUMBER(15)		 NULL ,
		savedate                      		DATE		 NOT NULL,
		usedate                       		DATE		 NOT NULL,
		mywalletno                    		NUMBER(10)		 NULL ,
		dealno                        		NUMBER(10)		 NULL 
);

COMMENT ON TABLE cash is 'ĳ������';
COMMENT ON COLUMN cash.cashno is 'ĳ�ù�ȣ';
COMMENT ON COLUMN cash.mycash is '����ĳ��';
COMMENT ON COLUMN cash.savecash is '����ĳ��';
COMMENT ON COLUMN cash.usecash is '���ĳ��';
COMMENT ON COLUMN cash.savedate is '������¥';
COMMENT ON COLUMN cash.usedate is '��볯¥';
COMMENT ON COLUMN cash.mywalletno is '������ȣ';
COMMENT ON COLUMN cash.dealno is '�ŷ���ȣ';


