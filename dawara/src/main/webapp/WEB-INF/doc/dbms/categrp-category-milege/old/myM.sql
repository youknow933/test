/**********************************/
/* Table Name: 내 마일리지 */
/**********************************/
CREATE TABLE myM(
    mileage_no                        NUMBER(10)     NOT NULL    PRIMARY KEY,
    mem_no                            NUMBER(6)    NOT NULL,
    cway_no                             NUMBER(1)     NOT NULL ,
    char_m                         NUMBER(10)     DEFAULT 0     NOT NULL, 
    mymileage                         NUMBER(10)     DEFAULT 0     NOT NULL,
    cmileage_date                             DATE     NOT NULL,
  FOREIGN KEY (mem_no) REFERENCES member (mem_no),
  FOREIGN KEY (cway_no) REFERENCES way (cway_no)
); 

INSERT INTO myM(mileage_no, mem_no, cway_no, char_m, mymileage, cmileage_date)
VALUES ((SELECT NVL(MAX(mileage_no), 0)+1 as mileage_no FROM myM), 1, 1, 10000, 0, sysdate); 

select * from myM;
DROP TABLE myM CASCADE CONSTRAINTS; 
 
COMMENT ON TABLE myM is '내 마일리지';
COMMENT ON COLUMN myM.mileage_no is '마일리지 번호';
COMMENT ON COLUMN myM.mem_no is '회원번호';
COMMENT ON COLUMN myM.cway_no is '충전번호';
COMMENT ON COLUMN myM.char_m is '충전마일리지';
COMMENT ON COLUMN myM.mymileage is '마일리지';
COMMENT ON COLUMN myM.cmileage_date is '충전날짜';


SELECT mileage_no, mem_no, cway_no, char_m, mymileage, cmileage_date
FROM myM
WHERE char_m LIKE '%1000%'
ORDER BY mileage_no ASC;

SELECT COUNT(*) as cnt
FROM myM
WHERE char_m LIKE '%1000%'

 SELECT m.mileage_no, m.mem_no, w.cway_no, w.cway,
               m.char_m, m.mymileage, m.cmileage_date
    FROM way w, myM m  
        WHERE m.cway_no = w.cway_no and mem_no=1 AND m.char_m LIKE '%1000%'  
        
        WHERE m.cway_no = w.cway_no and mem_no=1 
        AND mem_no LIKE '%1%'  

        
    SELECT m.mileage_no, m.mem_no, w.cway_no, w.cway,
          m.char_m, m.mymileage, m.cmileage_date
    FROM way w, myM m  
    WHERE m.cway_no = w.cway_no and mem_no=1 AND cway LIKE '%무통장%'
    

    
     SELECT m.mileage_no, m.mem_no, w.cway_no, w.cway,
               m.char_m, m.mymileage, m.cmileage_date
    FROM way w, myM m  
        WHERE w.cway_no = m.cway_no and mem_no=1 AND m.char_m LIKE '%1000%' or m.cmileage_date LIKE '%10:03%'
    ORDER BY mileage_no ASC