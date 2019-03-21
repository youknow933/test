/**********************************/
/* Table Name: ������ */
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