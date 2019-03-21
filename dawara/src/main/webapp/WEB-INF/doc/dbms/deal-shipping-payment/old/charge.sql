/**********************************/
/* Table Name: ���ϸ��� ���� */
/**********************************/
CREATE TABLE charge(
    charge_no                         NUMBER(10)     NOT NULL    PRIMARY KEY,
    ch_mileage                        NUMBER(10)     NOT NULL,
    ch_date                           DATE     NOT NULL,
    ch_way                            VARCHAR2(20)     NOT NULL,
    mem_no                            NUMBER(6)    NOT NULL,
    mileage_no                        NUMBER(10)     NOT NULL,
  FOREIGN KEY (mem_no) REFERENCES member (mem_no),
  FOREIGN KEY (mileage_no) REFERENCES mlieage (mileage_no)
);

COMMENT ON TABLE charge is '���ϸ��� ����';
COMMENT ON COLUMN charge.charge_no is '������ȣ';
COMMENT ON COLUMN charge.ch_mileage is '�������ϸ���';
COMMENT ON COLUMN charge.ch_date is '������¥';
COMMENT ON COLUMN charge.ch_way is '��������';
COMMENT ON COLUMN charge.mem_no is 'ȸ����ȣ';
COMMENT ON COLUMN charge.mileage_no is '���ϸ�����ȣ';