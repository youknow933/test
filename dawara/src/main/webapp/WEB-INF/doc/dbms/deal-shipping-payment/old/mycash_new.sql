/**********************************/
/* Table Name: �� ĳ�� */
/**********************************/
CREATE TABLE mycash(
    cashno                            NUMBER(10)     NOT NULL    PRIMARY KEY,
    mycash                            NUMBER(15)     NULL ,
    savecash                          NUMBER(15)     NULL ,
    usecash                           NUMBER(15)     NULL ,
    savedate                          DATE     NOT NULL,
    usedate                           DATE     NOT NULL,
    mywalletno                        NUMBER(10)     NULL ,
  FOREIGN KEY (mywalletno) REFERENCES mywallet (mywalletno)
);

COMMENT ON TABLE mycash is '�� ĳ��';
COMMENT ON COLUMN mycash.cashno is 'ĳ�ù�ȣ';
COMMENT ON COLUMN mycash.mycash is '����ĳ��';
COMMENT ON COLUMN mycash.savecash is '����ĳ��';
COMMENT ON COLUMN mycash.usecash is '���ĳ��';
COMMENT ON COLUMN mycash.savedate is '������¥';
COMMENT ON COLUMN mycash.usedate is '��볯¥';
COMMENT ON COLUMN mycash.mywalletno is '������ȣ';