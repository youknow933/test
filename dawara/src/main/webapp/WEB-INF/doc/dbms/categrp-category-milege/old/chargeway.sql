/**********************************/
/* Table Name: �������� */
/**********************************/
CREATE TABLE chargeway(
    cway_no                           NUMBER(2)    NOT NULL    PRIMARY KEY,
    cway                              VARCHAR2(20)     NOT NULL
);

COMMENT ON TABLE chargeway is '��������';
COMMENT ON COLUMN chargeway.cway_no is '�������ܹ�ȣ';
COMMENT ON COLUMN chargeway.cway is '��������';

1) ���ҹ�� ���

INSERT INTO chargeway(cway_no, cway) VALUES (1, 'ī��');
INSERT INTO chargeway(cway_no, cway) VALUES (2, '������ü');
INSERT INTO chargeway(cway_no, cway) VALUES (3, '�������Ա�');

--delete from chargeway;

select * from chargeway;

