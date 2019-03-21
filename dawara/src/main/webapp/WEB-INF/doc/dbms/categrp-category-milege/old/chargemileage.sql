/**********************************/
/* Table Name: 마일리지 충전 */
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

COMMENT ON TABLE chargemileage is '마일리지 충전';
COMMENT ON COLUMN chargemileage.mcharge_no is '충전번호';
COMMENT ON COLUMN chargemileage.cway_no is '충전수단번호';
COMMENT ON COLUMN chargemileage.cmileage is '충전마일리지';
COMMENT ON COLUMN chargemileage.mem_no is '회원번호';
COMMENT ON COLUMN chargemileage.cmileage_date is '충전날짜';
