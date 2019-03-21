/**********************************/
/* Table Name: 마일리지 충전 */
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

COMMENT ON TABLE charge is '마일리지 충전';
COMMENT ON COLUMN charge.charge_no is '충전번호';
COMMENT ON COLUMN charge.ch_mileage is '충전마일리지';
COMMENT ON COLUMN charge.ch_date is '충전날짜';
COMMENT ON COLUMN charge.ch_way is '충전수단';
COMMENT ON COLUMN charge.mem_no is '회원번호';
COMMENT ON COLUMN charge.mileage_no is '마일리지번호';