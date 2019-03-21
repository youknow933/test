
0. ���̺� ����
DROP TABLE categrp;
 
1. ���̺� ����
CREATE TABLE categrp( 
    categrpno                       NUMBER(10)     NOT NULL    PRIMARY KEY,
    nclassification                     NUMBER(1)    DEFAULT 1     NOT NULL,
    categrptitle                                  VARCHAR2(50)     NOT NULL,
    nseqno                               NUMBER(7)    DEFAULT 0     NOT NULL,
    nvisible                              CHAR(1)    DEFAULT 'Y'     NOT NULL,
    rdate                                DATE     NOT NULL,
    mem_no                 NUMBER(6)                                 NULL,
    FOREIGN KEY (mem_no) REFERENCES MEMBER (mem_no)
); 

COMMENT ON TABLE categrp is 'ī�װ� �׷�';
COMMENT ON COLUMN categrp.categrpno is 'ī�װ� �׷� ��ȣ';
COMMENT ON COLUMN categrp.nclassification is 'ī�װ� �׷� �з�';
COMMENT ON COLUMN categrp.categrptitle is '�׷� �̸�';
COMMENT ON COLUMN categrp.nseqno is '��� ����';
COMMENT ON COLUMN categrp.nvisible is '��� ���';
COMMENT ON COLUMN categrp.rdate is '�׷� ������';
COMMENT ON COLUMN categrp.mem_no is 'ȸ�� ��ȣ';
  
2. ���(INSERT)
- nclassification: 1-SAMSUNG, 2-LG, 3-APPLE, 4-HP
- nvisible: Y, N

INSERT INTO categrp(categrpno, nclassification, categrptitle, nseqno, nvisible, rdate)
VALUES(1, 1, 'SAMSUNG�ÿ�����9', 1, 'Y', sysdate);

3. ����(DELETE)
DELETE FROM categrp;

4. �׷��ȣ�� �ڵ� ����
INSERT INTO categrp(categrpno, nclassification, categrptitle, nseqno, nvisible, rdate, mem_no)
VALUES((SELECT NVL(MAX(categrpno), 0) + 1 as categrpno FROM categrp), 1, '�Ｚ�ÿ�����9', 1, 'Y', sysdate, '1');

INSERT INTO categrp(categrpno, nclassification, categrptitle, nseqno, nvisible, rdate)
VALUES((SELECT NVL(MAX(categrpno), 0) + 1 as categrpno FROM categrp), 2, '�Ｚ�ÿ�����9', 1, 'Y', sysdate);

INSERT INTO categrp(categrpno, nclassification, categrptitle, nseqno, nvisible, rdate)
VALUES((SELECT NVL(MAX(categrpno), 0) + 1 as categrpno FROM categrp), 3, '�Ｚ�ÿ�����9', 1, 'Y', sysdate);

5. ���(SELECT)
SELECT categrpno, nclassification, categrptitle, nseqno, nvisible, rdate 
FROM categrp
ORDER BY categrpno ASC; 

6. ��ȸ
SELECT categrpno, nclassification, categrptitle, nseqno, nvisible, rdate 
FROM categrp
WHERE categrpno = 1;
  
7. ����(UPDATE)
UPDATE categrp
SET nclassification=1, categrptitle='�Ｚ�ÿ�����9', nseqno = 1, nvisible='Y'
WHERE categrpno = 1;

8. �׷��ȣ�� ����(CATEGRPNO DELETE)
DELETE FROM categrp
WHERE categrpno = 1;

9. �˻�(%: ���ų� �ϳ� �̻��� ��� ����)
-- word LIKE '������' �� word = '������'
   ^������$
-- word LIKE '%������' �� word = '���� ���� ������'
   .*������$
-- word LIKE '������%' �� word = '����������~'
   ^������.*
-- word LIKE '%������%' �� word = '���� ������ ������ �� �湮�ؾ�~'
   .*������.*
   
SELECT categrpno, nclassification, categrptitle, nseqno, nvisible, rdate 
FROM categrp=1 AND word LIKE '%�Ｚ%'
ORDER BY categrpno ASC;
         
10. ����¡
SELECT categrpno, nclassification, categrptitle, nseqno, nvisible, rdate 
FROM(
         SELECT categrpno, nclassification, categrptitle, nseqno, nvisible, rdate as r
         FROM(
                  SELECT categrpno, nclassification, categrptitle, nseqno, nvisible, rdate 
                  FROM categrp
                  WHERE categrp=1
                  ORDER BY categrpno DESC
         )
)
WHERE r >=1 AND r <= 3;

-- �˻�        
SELECT sellno, ncategoryno, title, content, thumbs, files, sizes, cnt,
          replycnt, rdate, word, r
FROM(
         SELECT sellno, ncategoryno, title, content,  thumbs, files, sizes, cnt,
                   replycnt, rdate, word, rownum as r
         FROM(
                  SELECT sellno, ncategoryno, title, content, thumbs, files, sizes, cnt,
                            replycnt, rdate, word
                  FROM sell
                  WHERE ncategoryno=1 AND word LIKE '%������%'
                  ORDER BY sellno DESC
         )
)
WHERE r >=1 AND r <= 3;

 SELLNO NCATEGORYNO TITLE CONTENT THUMBS       FILES       SIZES CNT REPLYCNT RDATE                 WORD                     R
 ------ ----------- ----- ------- ------------ ----------- ----- --- -------- --------------------- ------------------------ -
      3           1 ����    ����      summber.jpg  summber.jpg 0       0        0 2018-06-08 16:21:23.0 ������,spring,��,��,����,����,������ 1
      2           1 ����    ����      spring_m.jpg spring.jpg  0       0        0 2018-06-08 16:21:22.0 ������,spring,��,��,����,����,������ 2


