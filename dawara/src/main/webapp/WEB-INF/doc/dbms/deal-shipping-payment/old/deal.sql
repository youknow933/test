/**********************************/
/* Table Name: �ŷ� */
/**********************************/
CREATE TABLE deal(
    dealno                            NUMBER(10)     NOT NULL    PRIMARY KEY,
    sellno                            NUMBER(7)    NULL ,
  FOREIGN KEY (sellno) REFERENCES buysell (sellno)
);

COMMENT ON TABLE deal is '�ŷ�';
COMMENT ON COLUMN deal.dealno is '�ŷ���ȣ';
COMMENT ON COLUMN deal.sellno is '�ǸŹ�ȣ';