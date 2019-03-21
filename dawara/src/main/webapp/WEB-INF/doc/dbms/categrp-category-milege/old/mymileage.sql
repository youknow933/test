/**********************************/
/* Table Name: 내 마일리지 */
/**********************************/
CREATE TABLE mymlieage(
    mileage_no                        NUMBER(10)     NOT NULL    PRIMARY KEY,
    mem_no                            NUMBER(6)    NOT NULL,
    mcharge_no                        NUMBER(10)     NULL ,
    mymileage                         NUMBER(10)     DEFAULT 0     NOT NULL,
  FOREIGN KEY (mem_no) REFERENCES member (mem_no),
  FOREIGN KEY (mcharge_no) REFERENCES chargemileage (mcharge_no)
);

drop table mymlieage;

COMMENT ON TABLE mymlieage is '내 마일리지';
COMMENT ON COLUMN mymlieage.mileage_no is '마일리지 번호';
COMMENT ON COLUMN mymlieage.mem_no is '회원번호';
COMMENT ON COLUMN mymlieage.mcharge_no is '충전번호';
COMMENT ON COLUMN mymlieage.mymileage is '마일리지';