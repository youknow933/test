/**********************************/
/* Table Name: �ŷ���� */
/**********************************/
CREATE TABLE DEALWAY(
    DWAY_NO                           NUMBER(2)    NOT NULL    PRIMARY KEY,
    DWAY                              VARCHAR2(20)     NOT NULL
);

COMMENT ON TABLE DEALWAY is '�ŷ����';
COMMENT ON COLUMN DEALWAY.DWAY_NO is '�ŷ������ȣ';
COMMENT ON COLUMN DEALWAY.DWAY is '�ŷ����';

INSERT INTO dealway(dway_no, dway) VALUES (1, '���ŷ�');
INSERT INTO dealway(dway_no, dway) VALUES (2, '�ù�ŷ�');

select * from dealway;