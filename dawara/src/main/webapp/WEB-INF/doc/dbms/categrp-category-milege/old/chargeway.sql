/**********************************/
/* Table Name: 충전수단 */
/**********************************/
CREATE TABLE chargeway(
    cway_no                           NUMBER(2)    NOT NULL    PRIMARY KEY,
    cway                              VARCHAR2(20)     NOT NULL
);

COMMENT ON TABLE chargeway is '충전수단';
COMMENT ON COLUMN chargeway.cway_no is '충전수단번호';
COMMENT ON COLUMN chargeway.cway is '충전수단';

1) 지불방법 등록

INSERT INTO chargeway(cway_no, cway) VALUES (1, '카드');
INSERT INTO chargeway(cway_no, cway) VALUES (2, '계좌이체');
INSERT INTO chargeway(cway_no, cway) VALUES (3, '무통장입금');

--delete from chargeway;

select * from chargeway;

