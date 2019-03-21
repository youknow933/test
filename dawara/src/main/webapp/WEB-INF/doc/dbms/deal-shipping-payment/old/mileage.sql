/**********************************/
/* Table Name: 마일리지 */
/**********************************/
CREATE TABLE mlieage(
    mileage_no                        NUMBER(10)     NOT NULL    PRIMARY KEY,
    mile_amount                       NUMBER(10)     DEFAULT 0     NOT NULL,
    mem_no                            NUMBER(6)    NOT NULL,
  FOREIGN KEY (mem_no) REFERENCES member (mem_no)
);

COMMENT ON TABLE mlieage is '마일리지';
COMMENT ON COLUMN mlieage.mileage_no is '마일리지번호';
COMMENT ON COLUMN mlieage.mile_amount is '마일리지';
COMMENT ON COLUMN mlieage.mem_no is '회원번호';