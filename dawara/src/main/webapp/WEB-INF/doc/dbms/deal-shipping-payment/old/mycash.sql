/**********************************/
/* Table Name: 내 캐시 */
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

COMMENT ON TABLE mycash is '내 캐시';
COMMENT ON COLUMN mycash.cashno is '캐시번호';
COMMENT ON COLUMN mycash.mycash is '내 캐시';
COMMENT ON COLUMN mycash.savedate is '적립날짜';
COMMENT ON COLUMN mycash.usedate is '사용날짜';
COMMENT ON COLUMN mycash.savecash is '충전캐시';
COMMENT ON COLUMN mycash.usecash is '캐시사용여부';
COMMENT ON COLUMN mycash.paysortno is '결제수단번호';