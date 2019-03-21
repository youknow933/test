/**********************************/
/* Table Name: 배송상품 수취확인 */
/**********************************/
CREATE TABLE receive(
    receive_no                        NUMBER(10)     DEFAULT 'N'     NOT NULL    PRIMARY KEY,
    r_check                           CHAR(1)    DEFAULT 'N'     NOT NULL,
    r_cdate                           DATE     NOT NULL,
    delivery_no                       NUMBER(10)     NULL ,
  FOREIGN KEY (delivery_no) REFERENCES delivery (delivery_no)
);

COMMENT ON TABLE receive is '배송상품 수취확인';
COMMENT ON COLUMN receive.receive_no is '수취번호';
COMMENT ON COLUMN receive.r_check is '수취확인';
COMMENT ON COLUMN receive.r_cdate is '수취확인날짜';
COMMENT ON COLUMN receive.delivery_no is '배송번호';