/**********************************/
/* Table Name: �� ���ϸ��� */
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
 
COMMENT ON TABLE myM is '�� ���ϸ���';
COMMENT ON COLUMN myM.mileage_no is '���ϸ��� ��ȣ';
COMMENT ON COLUMN myM.mem_no is 'ȸ����ȣ';
COMMENT ON COLUMN myM.cway_no is '������ȣ';
COMMENT ON COLUMN myM.char_m is '�������ϸ���';
COMMENT ON COLUMN myM.mymileage is '���ϸ���';
COMMENT ON COLUMN myM.cmileage_date is '������¥';


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
    WHERE m.cway_no = w.cway_no and mem_no=1 AND cway LIKE '%������%'
    

    
     SELECT m.mileage_no, m.mem_no, w.cway_no, w.cway,
               m.char_m, m.mymileage, m.cmileage_date
    FROM way w, myM m  
        WHERE w.cway_no = m.cway_no and mem_no=1 AND m.char_m LIKE '%1000%' or m.cmileage_date LIKE '%10:03%'
    ORDER BY mileage_no ASC