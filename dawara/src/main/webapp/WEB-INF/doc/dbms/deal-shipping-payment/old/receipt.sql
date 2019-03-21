/**********************************/
/* Table Name: 영수증 */
/**********************************/
CREATE TABLE receipt(
    receiptno                         NUMBER(10)     NOT NULL    PRIMARY KEY,
    SELLNO                            NUMBER(7)    NOT NULL,
    MEM_NO                            NUMBER(6)    NOT NULL,
    PAYSORT                           VARCHAR2(20)     NOT NULL,
    HOWMUCH                           NUMBER(15)     NOT NULL,
    PDATE                             DATE     NOT NULL,
    PAYCHECK                          CHAR(1)    NOT NULL,
    PMEMO                             VARCHAR2(50)     NULL ,
    mem_no                            NUMBER(6)    NULL ,
    signno                            NUMBER(10)     NULL ,
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