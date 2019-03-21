/**********************************/
/* Table Name: 거래방법 */
/**********************************/
CREATE TABLE DEALWAY(
    DWAY_NO                           NUMBER(2)    NOT NULL    PRIMARY KEY,
    DWAY                              VARCHAR2(20)     NOT NULL
);

COMMENT ON TABLE DEALWAY is '거래방법';
COMMENT ON COLUMN DEALWAY.DWAY_NO is '거래방법번호';
COMMENT ON COLUMN DEALWAY.DWAY is '거래방법';

INSERT INTO dealway(dway_no, dway) VALUES (1, '직거래');
INSERT INTO dealway(dway_no, dway) VALUES (2, '택배거래');

select * from dealway;