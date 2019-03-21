/**********************************/
/* Table Name: ���ϸ��� ���� */
/**********************************/
CREATE TABLE chargemileage(
    mcharge_no                        NUMBER(10)     NOT NULL    PRIMARY KEY,
    cway_no                           NUMBER(2)    NOT NULL,
    cmileage                          NUMBER(10)     NOT NULL,
    mem_no                            NUMBER(6)    NOT NULL,
    cmileage_date                             DATE     NOT NULL,
   FOREIGN KEY (cway_no) REFERENCES chargeway (cway_no),
   FOREIGN KEY (mem_no) REFERENCES member (mem_no)
);

drop table chargemilage;

COMMENT ON TABLE chargemileage is '���ϸ��� ����';
COMMENT ON COLUMN chargemileage.mcharge_no is '������ȣ';
COMMENT ON COLUMN chargemileage.cway_no is '�������ܹ�ȣ';
COMMENT ON COLUMN chargemileage.cmileage is '�������ϸ���';
COMMENT ON COLUMN chargemileage.mem_no is 'ȸ����ȣ';
COMMENT ON COLUMN chargemileage.cmileage_date is '������¥';
