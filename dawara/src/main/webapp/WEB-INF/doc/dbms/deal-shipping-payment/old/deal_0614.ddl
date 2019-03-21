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
/* Table Name: 회원 */
/**********************************/
CREATE TABLE member(
		mem_no                        		NUMBER(6)		 NOT NULL		 PRIMARY KEY
);

COMMENT ON TABLE member is '회원';
COMMENT ON COLUMN member.mem_no is '회원번호';


/**********************************/
/* Table Name: 충전수단 */
/**********************************/
CREATE TABLE chargeway(
		cway_no                       		NUMBER(2)		 NOT NULL		 PRIMARY KEY,
		cway                          		VARCHAR2(20)		 NOT NULL
);

COMMENT ON TABLE chargeway is '충전수단';
COMMENT ON COLUMN chargeway.cway_no is '충전수단번호';
COMMENT ON COLUMN chargeway.cway is '충전수단';


/**********************************/
/* Table Name: 판매구매 */
/**********************************/
CREATE TABLE buysell(
		buysell_no                    		NUMBER(10)		 NOT NULL		 PRIMARY KEY
);

COMMENT ON TABLE buysell is '판매구매';
COMMENT ON COLUMN buysell.buysell_no is '판매구매번호';


/**********************************/
/* Table Name: 거래방법 */
/**********************************/
CREATE TABLE dealway(
		dway_no                       		NUMBER(2)		 NOT NULL		 PRIMARY KEY,
		dway                          		VARCHAR2(20)		 NOT NULL
);

COMMENT ON TABLE dealway is '거래방법';
COMMENT ON COLUMN dealway.dway_no is '거래방법번호';
COMMENT ON COLUMN dealway.dway is '거래방법';


/**********************************/
/* Table Name: 거래상태 */
/**********************************/
CREATE TABLE dealstate(
		dstate_no                     		NUMBER(1)		 NOT NULL		 PRIMARY KEY,
		dstate                        		VARCHAR2(20)		 NOT NULL,
		dsdate                        		DATE		 NULL 
);

COMMENT ON TABLE dealstate is '거래상태';
COMMENT ON COLUMN dealstate.dstate_no is '거래상태번호';
COMMENT ON COLUMN dealstate.dstate is '거래상태';
COMMENT ON COLUMN dealstate.dsdate is '거래상태날짜';


/**********************************/
/* Table Name: 수취확인 */
/**********************************/
CREATE TABLE receivecheck(
		rcheck_no                     		NUMBER(1)		 NOT NULL		 PRIMARY KEY,
		rcheck                        		CHAR(1)		 DEFAULT 'N'		 NOT NULL,
		rdate                         		DATE		 NULL 
);

COMMENT ON TABLE receivecheck is '수취확인';
COMMENT ON COLUMN receivecheck.rcheck_no is '수취확인번호';
COMMENT ON COLUMN receivecheck.rcheck is '수취확인여부';
COMMENT ON COLUMN receivecheck.rdate is '수취날짜';


/**********************************/
/* Table Name: 거래 */
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

COMMENT ON TABLE deal is '거래';
COMMENT ON COLUMN deal.deal_no is '거래번호';
COMMENT ON COLUMN deal.usemileage is '사용마일리지';
COMMENT ON COLUMN deal.ddate is '거래날짜';
COMMENT ON COLUMN deal.dmemo is '거래메모';
COMMENT ON COLUMN deal.mem_no is '회원번호';
COMMENT ON COLUMN deal.buysell_no is '판매구매번호';
COMMENT ON COLUMN deal.dway_no is '거래방법번호';
COMMENT ON COLUMN deal.dstate_no is '거래상태번호';
COMMENT ON COLUMN deal.rcheck_no is '수취확인번호';


/**********************************/
/* Table Name: 마일리지 충전 */
/**********************************/
CREATE TABLE chargemileage(
		mcharge_no                    		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		cway_no                       		NUMBER(2)		 NOT NULL,
		cmileage                      		NUMBER(10)		 NOT NULL,
		cdate                             DATE     NOT NULL,
  FOREIGN KEY (cway_no) REFERENCES chargeway (cway_no)
);

COMMENT ON TABLE chargemileage is '마일리지 충전';
COMMENT ON COLUMN chargemileage.mcharge_no is '충전번호';
COMMENT ON COLUMN chargemileage.cway_no is '충전수단번호';
COMMENT ON COLUMN chargemileage.cmileage is '충전마일리지';
COMMENT ON COLUMN chargemileage.cdate is '충전날짜';


/**********************************/
/* Table Name: 내 마일리지 */
/**********************************/
CREATE TABLE mymlieage(
		mem_no                        		NUMBER(6)		 NOT NULL,
		mcharge_no                    		NUMBER(10)		 NULL ,
		mymileage                     		NUMBER(10)		 DEFAULT 0		 NOT NULL,
  FOREIGN KEY (mem_no) REFERENCES member (mem_no),
  FOREIGN KEY (mcharge_no) REFERENCES chargemileage (mcharge_no)
);

COMMENT ON TABLE mymlieage is '내 마일리지';
COMMENT ON COLUMN mymlieage.mem_no is '회원번호';
COMMENT ON COLUMN mymlieage.mcharge_no is '충전번호';
COMMENT ON COLUMN mymlieage.mymileage is '마일리지';


