/**********************************/
/* Table Name: 거래상태 */
/**********************************/
CREATE TABLE DEALSTATE(
    DSTATE_NO                         NUMBER(1)    NOT NULL    PRIMARY KEY,
    DSTATE                            VARCHAR2(20)     NOT NULL,
    DSTATE_DATE                       DATE     NOT NULL
);

COMMENT ON TABLE DEALSTATE is '거래상태';
COMMENT ON COLUMN DEALSTATE.DSTATE_NO is '거래상태번호';
COMMENT ON COLUMN DEALSTATE.DSTATE is '거래상태';
COMMENT ON COLUMN DEALSTATE.DSTATE_DATE is '거래상태날짜';

delete from DEALSTATE;

INSERT INTO dealstate(dstate_no, dstate, dstate_date) VALUES (1, '등록', SYSDATE);
INSERT INTO dealstate(dstate_no, dstate, dstate_date) VALUES (2, '결제', SYSDATE);
INSERT INTO dealstate(dstate_no, dstate, dstate_date) VALUES (3, '물품발송', SYSDATE);
INSERT INTO dealstate(dstate_no, dstate, dstate_date) VALUES (4, '수취확인', SYSDATE);
INSERT INTO dealstate(dstate_no, dstate, dstate_date) VALUES (5, '구매 승인', SYSDATE);
INSERT INTO dealstate(dstate_no, dstate, dstate_date) VALUES (6, '판대 대금 전달', SYSDATE);
INSERT INTO dealstate(dstate_no, dstate, dstate_date) VALUES (7, '완료', SYSDATE);
INSERT INTO dealstate(dstate_no, dstate, dstate_date) VALUES (0, '취소', SYSDATE);

select * from dealstate;

 DSTATE_NO DSTATE   DSTATE_DATE
 --------- -------- ---------------------
         3 물품발송     2018-06-20 12:36:55.0
         4 수취확인     2018-06-20 12:36:56.0
         5 구매 승인    2018-06-20 12:36:57.0
         6 판대 대금 전달 2018-06-20 12:36:58.0
         7 완료       2018-06-20 12:36:59.0
         0 취소       2018-06-20 12:37:00.0
         1 등록       2018-06-20 12:36:53.0
         2 결제       2018-06-20 12:36:54.0
