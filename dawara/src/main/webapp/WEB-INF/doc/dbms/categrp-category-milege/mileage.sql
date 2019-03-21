/**********************************/
/* Table Name: mileage ���� */
/**********************************/

CREATE TABLE mileage(
    mileage_no                        NUMBER(10)     NOT NULL    PRIMARY KEY,
    mem_no                            NUMBER(6)    NOT NULL,
    char_m                         NUMBER(10)     DEFAULT 0     NOT NULL, 
    mymileage                         NUMBER(10)     DEFAULT 0     NOT NULL,
    cway                              VARCHAR2(20)     NOT NULL,
    cway_no                         NUMBER(10)    NOT NULL,
    cmileage_date                             DATE     NOT NULL,
  FOREIGN KEY (mem_no) REFERENCES member (mem_no)
); 

INSERT INTO mileage(mileage_no, mem_no, char_m, mymileage, cway, cway_no, cmileage_date)
VALUES ((SELECT NVL(MAX(mileage_no), 0)+1 as mileage_no FROM mileage), 1, 10000, 0, 'ī��', 1, sysdate); 

select * from mileage;
DROP TABLE mileage CASCADE CONSTRAINTS; 
 
COMMENT ON TABLE mileage is '�� ���ϸ���';
COMMENT ON COLUMN mileage.mileage_no is '���ϸ��� ��ȣ';
COMMENT ON COLUMN mileage.mem_no is 'ȸ����ȣ';
COMMENT ON COLUMN mileage.char_m is '�������ϸ���';
COMMENT ON COLUMN mileage.mymileage is '���ϸ���';
COMMENT ON COLUMN mileage.cway is '�������';
COMMENT ON COLUMN mileage.cway_no is '������ȣ';
COMMENT ON COLUMN mileage.cmileage_date is '������¥';

 SELECT mileage_no, mem_no, char_m, mymileage, cway, cmileage_date
    FROM mileage
    ORDER BY mileage_no ASC 
    
    
       SELECT mileage_no, mem_no, cway, char_m, mymileage, cmileage_date
    FROM mileage   
    ORDER BY mileage_no ASC 
    
    
   SELECT COUNT(*) as cnt
    FROM mileage
      WHERE mem_no LIKE '%1%' or char_m LIKE '%1000%' or cway LIKE '%������ü%'
      WHERE char_m LIKE '%%' 
      WHERE cway LIKE '%%'
       WHERE cway LIKE '' or 
                  char_m LIKE '' or 
                  mem_no LIKE '' 
                  
                  
                    SELECT mileage_no, mem_no, cway, cway_no, char_m, mymileage, cmileage_date, r
    FROM (
              SELECT mileage_no, mem_no, cway, cway_no, char_m, mymileage, cmileage_date, rownum as r
              FROM (
                        SELECT mileage_no, mem_no, cway, cway_no, char_m, mymileage, cmileage_date
                        FROM mileage
  
      WHERE mem_no LIKE '%1%'))
      
        UPDATE mileage
    SET cway='�ڵ���'
    WHERE mileage_no = 5