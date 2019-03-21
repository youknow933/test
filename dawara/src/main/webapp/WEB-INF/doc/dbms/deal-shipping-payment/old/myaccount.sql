/**********************************/
/* Table Name: 내 계좌 */
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

COMMENT ON TABLE myaccount is '내 계좌';
COMMENT ON COLUMN myaccount.account_number is '계좌번호';
COMMENT ON COLUMN myaccount.balance is '잔액';
COMMENT ON COLUMN myaccount.bankname is '은행명';
COMMENT ON COLUMN myaccount.depositor is '입금자';
COMMENT ON COLUMN myaccount.accountholder is '예금주';
COMMENT ON COLUMN myaccount.paysortno is '결제수단번호';