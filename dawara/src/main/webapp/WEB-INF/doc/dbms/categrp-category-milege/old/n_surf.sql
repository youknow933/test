
DROP TABLE nsurf

CREATE TABLE nsurf (
        nsurfno              NUMBER(7)        NOT NULL        PRIMARY KEY,
        nsurfword          VARCHAR2(300)        NOT NULL,
        cnt                    NUMBER(7)        DEFAULT 0       NOT NULL,
        rdate                  DATE                                      NOT NULL,
        mem_no                  NUMBER(6)        NOT NULL ,
    
  FOREIGN KEY (mem_no) REFERENCES member (mem_no)
);

COMMENT ON TABLE nsurf is '�˻���';
COMMENT ON COLUMN nsurf.nsurfno is '������ ��ȣ';
COMMENT ON COLUMN nsurf.mem_no is 'ȸ�� ��ȣ';
COMMENT ON COLUMN nsurf.nsurfword is '�˻���';
COMMENT ON COLUMN nsurf.cnt is '��ȸ��';
COMMENT ON COLUMN nsurf.rdate is '�����';

1) ���(INSERT)            

INSERT INTO nsurf(nsurfno, nsurfword, cnt, rdate, mem_no)  
VALUES((SELECT NVL(MAX(nsurfno), 0) + 1 as nsurfno FROM nsurf),
            '�Ｚ', 0, sysdate, 1);

2) ���
SELECT nsurfno, nsurfword, cnt, rdate, mem_no
FROM nsurf

3) ��ü ī��Ʈ
SELECT COUNT(*) as count
FROM nsurf;

4) ��ȣ�� ��ȸ
SELECT nsurfno, nsurfword, cnt, rdate, mem_no
FROM nsurf
WHERE nsurfno=1; 

5) ����(UPDATE)
UPDATE nsurf
SET nsurfword='�Ｚ', nsurfno='1'
WHERE nsurfno=1;

6) ����(DELETE)
DELETE FROM nsurf
WHERE nsurfno=1

7) �˻�(%: ���ų� �ϳ� �̻��� ��� ����)
-- word LIKE '������' �� word = '������'
   ^������$
-- word LIKE '%������' �� word = '���� ���� ������'
   .*������$
-- word LIKE '������%' �� word = '����������~'
   ^������.*
-- word LIKE '%������%' �� word = '���� ������ ������ �� �湮�ؾ�~'
   .*������.*

-- '�Ｚ' �÷����� �˻�
SELECT nsurfno, nsurfword, cnt, rdate, mem_no
FROM nsurf
WHERE nsurfno=1 AND nsurfword LIKE '%�Ｚ%';

8) �˻� �� ��ü ���ڵ� ����
-- nsurfno �÷��� 1���̸� �˻����� �ʴ� ��� ���ڵ� ����
SELECT COUNT(*) as cnt
FROM nsurf
WHERE nsurfno=1;

-- '�Ｚ' �˻� ���ڵ� ����
SELECT COUNT(*) as cnt
FROM nsurf
WHERE nsurfno=1 AND nsurfword LIKE '%�Ｚ%';

9) ����¡ ����
-- step 1
SELECT nsurfno, nsurfword, cnt, rdate, mem_no
FROM nsurf
WHERE nsurfno=1
ORDER BY nsurfno DESC;
 
-- step 2         
SELECT nsurfno, nsurfword, cnt, rdate, mem_no, rownum as r
FROM(
         SELECT nsurfno, nsurfword, cnt, rdate, mem_no
         FROM nsurf
         WHERE nsurfno=1
         ORDER BY nsurfno DESC
);

-- step 3         
SELECT nsurfno, nsurfword, cnt, rdate, mem_no, r
FROM(
         SELECT nsurfno, nsurfword, cnt, rdate, mem_no, rownum as r
         FROM(
                  SELECT nsurfno, nsurfword, cnt, rdate, mem_no
                  FROM nsurf
                  WHERE nsurfno=1
                  ORDER BY nsurfno DESC
         )
)
WHERE r >=1 AND r <= 3;



-- �˻�        
SELECT nsurfno, nsurfword, cnt, rdate, mem_no, r
FROM(
         SELECT nsurfno, nsurfword, cnt, rdate, mem_no, rownum as r
         FROM(
                  SELECT nsurfno, nsurfword, cnt, rdate, mem_no
                  FROM nsurf
                  WHERE nsurfno=1 AND nsurfword LIKE '%�Ｚ%'
                  ORDER BY nsurfno DESC
         )
)
WHERE r >=1 AND r <= 3;
