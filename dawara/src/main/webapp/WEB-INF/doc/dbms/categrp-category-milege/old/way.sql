/**********************************/
/* Table Name: 충전수단 */
/**********************************/
CREATE TABLE way( 
    cway_no                           NUMBER(2)    NOT NULL    PRIMARY KEY,
    cway                              VARCHAR2(20)     NOT NULL
);

COMMENT ON TABLE way is '충전수단';
COMMENT ON COLUMN way.cway_no is '충전수단번호';
COMMENT ON COLUMN way.cway is '충전수단';

INSERT INTO way(cway_no, cway)
VALUES ((SELECT NVL(MAX(cway_no), 0)+1 as cway_no FROM way), 1); 


drop table way;

1) 지불방법 등록

delete from way;

INSERT INTO way(cway_no, cway) VALUES (1, '카드');
INSERT INTO way(cway_no, cway) VALUES (2, '계좌이체');
INSERT INTO way(cway_no, cway) VALUES (3, '무통장입금');
INSERT INTO way(cway_no, cway) VALUES (4, '핸드폰');

--delete from chargeway;

select * from way; 
DROP TABLE way CASCADE CONSTRAINTS; 

 SELECT  m.mileage_no, m.mem_no, w.cway_no, w.cway,
               m.char_m, m.mymileage, m.cmileage_date
    FROM way w, myM m  
    WHERE w.cway_no = m.cway_no
    ORDER BY m.mileage_no ASC 
