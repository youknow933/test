/**********************************/
/* Table Name: �� ���� */
/**********************************/
CREATE TABLE myaccount(
    account_number                    NUMBER(20)     NOT NULL    PRIMARY KEY,
    balance                           NUMBER(15)     NOT NULL,
    bankname                          VARCHAR2(20)     NOT NULL,
    depositor                         VARCHAR2(20)     NOT NULL,
    accountholder                     VARCHAR2(20)     NOT NULL,
    paysortno                         NUMBER(2)    NULL ,
  FOREIGN KEY (paysortno) REFERENCES paysort (paysortno)
);

COMMENT ON TABLE myaccount is '�� ����';
COMMENT ON COLUMN myaccount.account_number is '���¹�ȣ';
COMMENT ON COLUMN myaccount.balance is '�ܾ�';
COMMENT ON COLUMN myaccount.bankname is '�����';
COMMENT ON COLUMN myaccount.depositor is '�Ա���';
COMMENT ON COLUMN myaccount.accountholder is '������';
COMMENT ON COLUMN myaccount.paysortno is '�������ܹ�ȣ';