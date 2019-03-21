/**********************************/
/* Table Name: �� ���ϸ��� */
/**********************************/
CREATE TABLE mymlieage(
    mileage_no                        NUMBER(10)     NOT NULL    PRIMARY KEY,
    mem_no                            NUMBER(6)    NOT NULL,
    mcharge_no                        NUMBER(10)     NULL ,
    mymileage                         NUMBER(10)     DEFAULT 0     NOT NULL,
  FOREIGN KEY (mem_no) REFERENCES member (mem_no),
  FOREIGN KEY (mcharge_no) REFERENCES chargemileage (mcharge_no)
);

drop table mymlieage;

COMMENT ON TABLE mymlieage is '�� ���ϸ���';
COMMENT ON COLUMN mymlieage.mileage_no is '���ϸ��� ��ȣ';
COMMENT ON COLUMN mymlieage.mem_no is 'ȸ����ȣ';
COMMENT ON COLUMN mymlieage.mcharge_no is '������ȣ';
COMMENT ON COLUMN mymlieage.mymileage is '���ϸ���';