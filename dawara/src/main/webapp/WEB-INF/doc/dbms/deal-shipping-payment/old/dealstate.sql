/**********************************/
/* Table Name: �ŷ����� */
/**********************************/
CREATE TABLE DEALSTATE(
    DSTATE_NO                         NUMBER(1)    NOT NULL    PRIMARY KEY,
    DSTATE                            VARCHAR2(20)     NOT NULL,
    DSTATE_DATE                       DATE     NOT NULL
);

COMMENT ON TABLE DEALSTATE is '�ŷ�����';
COMMENT ON COLUMN DEALSTATE.DSTATE_NO is '�ŷ����¹�ȣ';
COMMENT ON COLUMN DEALSTATE.DSTATE is '�ŷ�����';
COMMENT ON COLUMN DEALSTATE.DSTATE_DATE is '�ŷ����³�¥';

delete from DEALSTATE;

INSERT INTO dealstate(dstate_no, dstate, dstate_date) VALUES (1, '���', SYSDATE);
INSERT INTO dealstate(dstate_no, dstate, dstate_date) VALUES (2, '����', SYSDATE);
INSERT INTO dealstate(dstate_no, dstate, dstate_date) VALUES (3, '��ǰ�߼�', SYSDATE);
INSERT INTO dealstate(dstate_no, dstate, dstate_date) VALUES (4, '����Ȯ��', SYSDATE);
INSERT INTO dealstate(dstate_no, dstate, dstate_date) VALUES (5, '���� ����', SYSDATE);
INSERT INTO dealstate(dstate_no, dstate, dstate_date) VALUES (6, '�Ǵ� ��� ����', SYSDATE);
INSERT INTO dealstate(dstate_no, dstate, dstate_date) VALUES (7, '�Ϸ�', SYSDATE);
INSERT INTO dealstate(dstate_no, dstate, dstate_date) VALUES (0, '���', SYSDATE);

select * from dealstate;

 DSTATE_NO DSTATE   DSTATE_DATE
 --------- -------- ---------------------
         3 ��ǰ�߼�     2018-06-20 12:36:55.0
         4 ����Ȯ��     2018-06-20 12:36:56.0
         5 ���� ����    2018-06-20 12:36:57.0
         6 �Ǵ� ��� ���� 2018-06-20 12:36:58.0
         7 �Ϸ�       2018-06-20 12:36:59.0
         0 ���       2018-06-20 12:37:00.0
         1 ���       2018-06-20 12:36:53.0
         2 ����       2018-06-20 12:36:54.0
