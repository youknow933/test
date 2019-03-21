
0. ���̺� ����
DROP TABLE categrp;
 
1. ���̺� ����
CREATE TABLE categrp( 
    grp_no                NUMBER(10)    NOT NULL     PRIMARY KEY,
    grp_classification    NUMBER(1)     DEFAULT 1    NOT NULL,
    grp_title             VARCHAR2(50)  NOT NULL,
    grp_seqno             NUMBER(7)     DEFAULT 0    NOT NULL,
    grp_visible           CHAR(1)       DEFAULT 'Y'  NOT NULL,
    grp_rdate             DATE                       NOT NULL,
    mem_no                NUMBER(6)                  NULL,
    FOREIGN KEY (mem_no)  REFERENCES MEMBER (mem_no)
); 

COMMENT ON TABLE categrp is 'ī�װ� �׷�';
COMMENT ON COLUMN categrp.grp_no is 'ī�װ� �׷� ��ȣ';
COMMENT ON COLUMN categrp.grp_classification is 'ī�װ� �׷� �з�';
COMMENT ON COLUMN categrp.grp_title is '�׷� �̸�';
COMMENT ON COLUMN categrp.grp_seqno   is '��� ����';
COMMENT ON COLUMN categrp.grp_visible is '��� ���';
COMMENT ON COLUMN categrp.grp_rdate is '�׷� ������';
COMMENT ON COLUMN categrp.mem_no is 'ȸ�� ��ȣ';
  
2. ���(INSERT)
- grp_classification: 1-SAMSUNG, 2-LG, 3-APPLE, 4-HP
- grp_visible: Y, N

INSERT INTO categrp(grp_no, grp_classification, grp_title, grp_seqno, grp_visible, grp_rdate)
VALUES(1, 1, 'SAMSUNG�ÿ�����9', 1, 'Y', sysdate);

3. ����(DELETE)
DELETE FROM categrp;

4. �׷��ȣ�� �ڵ� ����
INSERT INTO categrp(grp_no, grp_classification, grp_title, grp_seqno, grp_visible, grp_rdate)
VALUES((SELECT NVL(MAX(grp_no), 0) + 1 as grp_no FROM categrp), 1, '��Ʈ��', 1, 'Y', sysdate);

INSERT INTO categrp(grp_no, grp_classification, grp_title, grp_seqno, grp_visible, grp_rdate)
VALUES((SELECT NVL(MAX(grp_no), 0) + 1 as grp_no FROM categrp), 2, 'LG', 1, 'Y', sysdate);

INSERT INTO categrp(grp_no, grp_classification, grp_title, grp_seqno, grp_visible, grp_rdate)
VALUES((SELECT NVL(MAX(grp_no), 0) + 1 as grp_no FROM categrp), 3, 'APPLE', 1, 'Y', sysdate);

5. ���(SELECT)
SELECT grp_no, grp_classification, grp_title, grp_seqno, grp_visible, grp_rdate 
FROM categrp
ORDER BY grp_no ASC; 

6. ��ȸ
SELECT grp_no, grp_classification, grp_title, grp_seqno, grp_visible, grp_rdate 
FROM categrp
WHERE grp_no = 1;
  
7. ����(UPDATE)
UPDATE categrp
SET grp_classification=1, grp_title='�Ｚ�ÿ�����9', grp_seqno = 1, grp_visible='Y'
WHERE grp_no = 1;

8. �׷��ȣ�� ����(grp_no DELETE)
DELETE FROM categrp
WHERE grp_no = 1;

9. �˻�(%: ���ų� �ϳ� �̻��� ��� ����)
-- word LIKE '������' �� word = '������'
   ^������$
-- word LIKE '%������' �� word = '���� ���� ������'
   .*������$
-- word LIKE '������%' �� word = '����������~'
   ^������.*
-- word LIKE '%������%' �� word = '���� ������ ������ �� �湮�ؾ�~'
   .*������.*
   
SELECT grp_no, grp_classification, grp_title, grp_seqno, grp_visible, grp_rdate 
FROM grp_no=1 AND word LIKE '%�Ｚ%'
ORDER BY grp_no ASC;
         
10. ����¡
SELECT grp_no, grp_classification, grp_title, grp_seqno, grp_visible, grp_rdate 
FROM(
         SELECT grp_no, grp_classification, grp_title, grp_seqno, grp_visible, grp_rdate as r
         FROM(
                  SELECT grp_no, grp_classification, grp_title, grp_seqno, grp_visible, grp_rdate 
                  FROM categrp
                  WHERE grp_no=1
                  ORDER BY grp_no DESC
         )
)
WHERE r >=1 AND r <= 3;

-- �˻�        
SELECT sellno, ncategoryno, title, content, thumbs, files, sizes, cnt,
          replycnt, grp_rdate, word, r
FROM(
         SELECT sellno, ncategoryno, title, content,  thumbs, files, sizes, cnt,
                   replycnt, grp_rdate, word, rownum as r
         FROM(
                  SELECT sellno, ncategoryno, title, content, thumbs, files, sizes, cnt,
                            replycnt, grp_rdate, word
                  FROM sell
                  WHERE ncategoryno=1 AND word LIKE '%������%'
                  ORDER BY sellno DESC
         )
)
WHERE r >=1 AND r <= 3;

 SELLNO NCATEGORYNO TITLE CONTENT THUMBS       FILES       SIZES CNT REPLYCNT grp_rdate                 WORD                     R
 ------ ----------- ----- ------- ------------ ----------- ----- --- -------- --------------------- ------------------------ -
      3           1 ����    ����      summber.jpg  summber.jpg 0       0        0 2018-06-08 16:21:23.0 ������,spring,��,��,����,����,������ 1
      2           1 ����    ����      spring_m.jpg spring.jpg  0       0        0 2018-06-08 16:21:22.0 ������,spring,��,��,����,����,������ 2


