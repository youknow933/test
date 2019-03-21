/**********************************/
/* Table Name: ���ϸ��� */
/**********************************/
CREATE TABLE mlieage(
    mileage_no                        NUMBER(10)     NOT NULL    PRIMARY KEY,
    mile_amount                       NUMBER(10)     DEFAULT 0     NOT NULL,
    mem_no                            NUMBER(6)    NOT NULL,
  FOREIGN KEY (mem_no) REFERENCES member (mem_no)
);

COMMENT ON TABLE mlieage is '���ϸ���';
COMMENT ON COLUMN mlieage.mileage_no is '���ϸ�����ȣ';
COMMENT ON COLUMN mlieage.mile_amount is '���ϸ���';
COMMENT ON COLUMN mlieage.mem_no is 'ȸ����ȣ';