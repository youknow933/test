/**********************************/
/* Table Name: 거래 */
/**********************************/
CREATE TABLE deal(
    dealno                            NUMBER(10)     NOT NULL    PRIMARY KEY,
    sellno                            NUMBER(7)    NULL ,
  FOREIGN KEY (sellno) REFERENCES buysell (sellno)
);

COMMENT ON TABLE deal is '거래';
COMMENT ON COLUMN deal.dealno is '거래번호';
COMMENT ON COLUMN deal.sellno is '판매번호';