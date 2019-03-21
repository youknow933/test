DROP TABLE mymlieage CASCADE CONSTRAINTS;
DROP TABLE chargemileage CASCADE CONSTRAINTS;
DROP TABLE deal CASCADE CONSTRAINTS;
DROP TABLE receivecheck CASCADE CONSTRAINTS;
DROP TABLE dealstate CASCADE CONSTRAINTS;
DROP TABLE dealway CASCADE CONSTRAINTS;
DROP TABLE buysell CASCADE CONSTRAINTS;
DROP TABLE chargeway CASCADE CONSTRAINTS;
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
/* Table Name: �������� */
/**********************************/
CREATE TABLE chargeway(
		cway_no                       		NUMBER(2)		 NOT NULL		 PRIMARY KEY,
		cway                          		VARCHAR2(20)		 NOT NULL
);

COMMENT ON TABLE chargeway is '��������';
COMMENT ON COLUMN chargeway.cway_no is '�������ܹ�ȣ';
COMMENT ON COLUMN chargeway.cway is '��������';


/**********************************/
/* Table Name: �Ǹű��� */
/**********************************/
CREATE TABLE buysell(
		buysell_no                    		NUMBER(10)		 NOT NULL		 PRIMARY KEY
);

COMMENT ON TABLE buysell is '�Ǹű���';
COMMENT ON COLUMN buysell.buysell_no is '�Ǹű��Ź�ȣ';


/**********************************/
/* Table Name: �ŷ���� */
/**********************************/
CREATE TABLE dealway(
		dway_no                       		NUMBER(2)		 NOT NULL		 PRIMARY KEY,
		dway                          		VARCHAR2(20)		 NOT NULL
);

COMMENT ON TABLE dealway is '�ŷ����';
COMMENT ON COLUMN dealway.dway_no is '�ŷ������ȣ';
COMMENT ON COLUMN dealway.dway is '�ŷ����';


/**********************************/
/* Table Name: �ŷ����� */
/**********************************/
CREATE TABLE dealstate(
		dstate_no                     		NUMBER(1)		 NOT NULL		 PRIMARY KEY,
		dstate                        		VARCHAR2(20)		 NOT NULL,
		dsdate                        		DATE		 NULL 
);

COMMENT ON TABLE dealstate is '�ŷ�����';
COMMENT ON COLUMN dealstate.dstate_no is '�ŷ����¹�ȣ';
COMMENT ON COLUMN dealstate.dstate is '�ŷ�����';
COMMENT ON COLUMN dealstate.dsdate is '�ŷ����³�¥';


/**********************************/
/* Table Name: ����Ȯ�� */
/**********************************/
CREATE TABLE receivecheck(
		rcheck_no                     		NUMBER(1)		 NOT NULL		 PRIMARY KEY,
		rcheck                        		CHAR(1)		 DEFAULT 'N'		 NOT NULL,
		rdate                         		DATE		 NULL 
);

COMMENT ON TABLE receivecheck is '����Ȯ��';
COMMENT ON COLUMN receivecheck.rcheck_no is '����Ȯ�ι�ȣ';
COMMENT ON COLUMN receivecheck.rcheck is '����Ȯ�ο���';
COMMENT ON COLUMN receivecheck.rdate is '���볯¥';


/**********************************/
/* Table Name: �ŷ� */
/**********************************/
CREATE TABLE deal(
		deal_no                       		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		usemileage                    		NUMBER(10)		 NOT NULL,
		ddate                         		DATE		 NOT NULL,
		dmemo                         		VARCHAR2(100)		 NULL ,
		mem_no                        		NUMBER(6)		 NOT NULL,
		buysell_no                    		NUMBER(10)		 NOT NULL,
		dway_no                       		NUMBER(10)		 NOT NULL,
		dstate_no                     		NUMBER(1)		 NULL ,
		rcheck_no                     		INTEGER(10)		 NULL ,
  FOREIGN KEY (mem_no) REFERENCES member (mem_no),
  FOREIGN KEY (buysell_no) REFERENCES buysell (buysell_no),
  FOREIGN KEY (dway_no) REFERENCES dealway (dway_no),
  FOREIGN KEY (dstate_no) REFERENCES dealstate (dstate_no),
  FOREIGN KEY (rcheck_no) REFERENCES receivecheck (rcheck_no)
);

COMMENT ON TABLE deal is '�ŷ�';
COMMENT ON COLUMN deal.deal_no is '�ŷ���ȣ';
COMMENT ON COLUMN deal.usemileage is '��븶�ϸ���';
COMMENT ON COLUMN deal.ddate is '�ŷ���¥';
COMMENT ON COLUMN deal.dmemo is '�ŷ��޸�';
COMMENT ON COLUMN deal.mem_no is 'ȸ����ȣ';
COMMENT ON COLUMN deal.buysell_no is '�Ǹű��Ź�ȣ';
COMMENT ON COLUMN deal.dway_no is '�ŷ������ȣ';
COMMENT ON COLUMN deal.dstate_no is '�ŷ����¹�ȣ';
COMMENT ON COLUMN deal.rcheck_no is '����Ȯ�ι�ȣ';


/**********************************/
/* Table Name: ���ϸ��� ���� */
/**********************************/
CREATE TABLE chargemileage(
		mcharge_no                    		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		cway_no                       		NUMBER(2)		 NOT NULL,
		cmileage                      		NUMBER(10)		 NOT NULL,
		cdate                             DATE     NOT NULL,
  FOREIGN KEY (cway_no) REFERENCES chargeway (cway_no)
);

COMMENT ON TABLE chargemileage is '���ϸ��� ����';
COMMENT ON COLUMN chargemileage.mcharge_no is '������ȣ';
COMMENT ON COLUMN chargemileage.cway_no is '�������ܹ�ȣ';
COMMENT ON COLUMN chargemileage.cmileage is '�������ϸ���';
COMMENT ON COLUMN chargemileage.cdate is '������¥';


/**********************************/
/* Table Name: �� ���ϸ��� */
/**********************************/
CREATE TABLE mymlieage(
		mem_no                        		NUMBER(6)		 NOT NULL,
		mcharge_no                    		NUMBER(10)		 NULL ,
		mymileage                     		NUMBER(10)		 DEFAULT 0		 NOT NULL,
  FOREIGN KEY (mem_no) REFERENCES member (mem_no),
  FOREIGN KEY (mcharge_no) REFERENCES chargemileage (mcharge_no)
);

COMMENT ON TABLE mymlieage is '�� ���ϸ���';
COMMENT ON COLUMN mymlieage.mem_no is 'ȸ����ȣ';
COMMENT ON COLUMN mymlieage.mcharge_no is '������ȣ';
COMMENT ON COLUMN mymlieage.mymileage is '���ϸ���';


