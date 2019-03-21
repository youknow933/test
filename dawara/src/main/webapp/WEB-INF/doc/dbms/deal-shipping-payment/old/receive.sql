/**********************************/
/* Table Name: ��ۻ�ǰ ����Ȯ�� */
/**********************************/
CREATE TABLE receive(
    receive_no                        NUMBER(10)     DEFAULT 'N'     NOT NULL    PRIMARY KEY,
    r_check                           CHAR(1)    DEFAULT 'N'     NOT NULL,
    r_cdate                           DATE     NOT NULL,
    delivery_no                       NUMBER(10)     NULL ,
  FOREIGN KEY (delivery_no) REFERENCES delivery (delivery_no)
);

COMMENT ON TABLE receive is '��ۻ�ǰ ����Ȯ��';
COMMENT ON COLUMN receive.receive_no is '�����ȣ';
COMMENT ON COLUMN receive.r_check is '����Ȯ��';
COMMENT ON COLUMN receive.r_cdate is '����Ȯ�γ�¥';
COMMENT ON COLUMN receive.delivery_no is '��۹�ȣ';