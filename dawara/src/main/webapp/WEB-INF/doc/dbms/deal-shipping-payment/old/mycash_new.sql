/**********************************/
/* Table Name: 내 캐시 */
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

COMMENT ON TABLE mycash is '내 캐시';
COMMENT ON COLUMN mycash.cashno is '캐시번호';
COMMENT ON COLUMN mycash.mycash is '현재캐시';
COMMENT ON COLUMN mycash.savecash is '적립캐시';
COMMENT ON COLUMN mycash.usecash is '사용캐시';
COMMENT ON COLUMN mycash.savedate is '적립날짜';
COMMENT ON COLUMN mycash.usedate is '사용날짜';
COMMENT ON COLUMN mycash.mywalletno is '지갑번호';