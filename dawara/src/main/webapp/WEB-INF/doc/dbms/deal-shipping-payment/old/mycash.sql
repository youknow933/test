/**********************************/
/* Table Name: �� ĳ�� */
/**********************************/
CREATE TABLE mycash(
    cashno                            NUMBER(10)     NOT NULL    PRIMARY KEY,
    mycash                            NUMBER(15)     NULL ,
    savedate                          DATE     NOT NULL,
    usedate                           DATE     NOT NULL,
    savecash                          NUMBER(15)     NULL ,
    usecash                           CHAR(1)    DEFAULT 'N'     NOT NULL,
    paysortno                         NUMBER(2)    NULL ,
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