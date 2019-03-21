
2. QnA �Խ��� ���̺� ����

SELECT * FROM qna

DROP TABLE qna; 

CREATE TABLE qna ( 
  qna_no       NUMBER(10)           NOT NULL , 
  mem_no       NUMBER(10)    NOT NULL ,
  qna_title      VARCHAR(100)  NOT NULL , 
  qna_write     VARCHAR(20)   NOT NULL ,
  qna_passwd     VARCHAR(15)   NOT NULL , 
  qna_rdate      DATE      NOT NULL , 
  qna_grpno                 NUMBER(7)  NOT NULL,
  qna_cnt        NUMBER(10)           DEFAULT 0 NOT NULL , 
  qna_contents    VARCHAR(4000) NOT NULL , 
  qna_web        VARCHAR(100)      NULL ,
  qna_files      VARCHAR(1000)      NULL ,
  qna_sizes      VARCHAR(1000)        DEFAULT 0  NULL ,
  qna_thumbs        VARCHAR(1000)     NULL ,
  qna_visible    CHAR(1)       DEFAULT 'N' NOT NULL ,  
  qna_indent   NUMBER(5)        DEFAULT 0       NOT NULL,
  qna_ansnum   NUMBER(5)        DEFAULT 0       NOT NULL ,
 -- word        VARCHAR2(100) NULL,
  PRIMARY KEY (qna_no),
  FOREIGN KEY (mem_no) REFERENCES member(mem_no)
) 

COMMENT ON COLUMN qna.qna_no IS  '�� �Ϸ� ��ȣ';
COMMENT ON COLUMN qna.mem_no IS 'ȸ�� ��ȣ';  
COMMENT ON COLUMN qna.qna_title IS '����';
COMMENT ON COLUMN qna.qna_write IS '�۾���';
COMMENT ON COLUMN qna.qna_passwd IS '�� �Ϸ� ��ȣ'; 
COMMENT ON COLUMN qna.qna_rdate IS '��� ��¥'; 
COMMENT ON COLUMN qna.qna_grpno is '�׷��ȣ';
COMMENT ON COLUMN qna.qna_cnt IS '��ȸ��';
COMMENT ON COLUMN qna.qna_contents IS '�� ����'; 
COMMENT ON COLUMN qna.qna_web IS 'URL';
COMMENT ON COLUMN qna.qna_files IS '���ϸ�';
COMMENT ON COLUMN qna.qna_sizes IS '���� ũ��';
COMMENT ON COLUMN qna.qna_thumbs IS '�����';
COMMENT ON COLUMN qna.qna_visible IS '�����';
COMMENT ON COLUMN qna.qna_indent IS '�亯 ����';
COMMENT ON COLUMN qna.qna_ansnum IS '�亯 ����';

--COMMENT ON COLUMN qna.word IS '�˻���';


2. �� �߰�(C: Create) 
-- ���ο� �� ���
-- qna_grpno: �ִ밪 + 1
-- qna_indent: 0, �亯�� �ƴϰ� �鿩���� �ʿ� ����.
-- qna_ansnum: 0, �亯�� �ƴϰ� ���� ���� ���
INSERT INTO qna(qna_no, mem_no, qna_title, qna_write, qna_passwd, qna_rdate, qna_grpno, qna_cnt,  
                 qna_contents, qna_web, qna_files, qna_sizes, qna_thumbs, qna_visible,
                 qna_indent, qna_ansnum)
VALUES((SELECT NVL(MAX(qna_no), 0)+1 AS qna_no FROM qna), 1, '���� ����', '������1', 123, sysdate, (SELECT NVL(MAX(qna_grpno), 0) + 1 as qna_grpno FROM qna), '0',
        '����', 'http://art.incheon.go.kr', '���� ����1.jpg', '���� ũ��',  '�����', 'N',
          1, 0);
            
            
3. ��ü �� ���(S:Total Select List), �ֽű� ���� ��� 
   - ASC: ���� ����, DESC: ���� ���� 
   - substring(�÷���, ������ġ, ����), ������ġ 1���� ����: ���ڿ� �Ϻθ� ����
   - �Լ� ���� �÷����� �ſ� ��������� 
     'SUBSTR(qna_rdate, 1, 10)' ������ as Ű����� 'qna_rdate' ��ȯ�մϴ�. 
     
     
-- ��� ��ȣ �˻����� ���� ���� Ȯ��
SELECT qna_no, mem_no, qna_title, qna_write, qna_passwd, SUBSTR(qna_rdate, 1, 10) as qna_rdate, qna_grpno, qna_cnt,  
        qna_contents, qna_web, qna_files, qna_sizes, qna_thumbs, qna_visible,
        qna_indent, qna_ansnum
FROM qna
WHERE mem_no = 1
ORDER BY qna_no DESC, qna_ansnum ASC;

 qna_no  mem_no  qna_wirte   qna_email      no_title        qna_cnt   qna_rdate                  qna_web                      qna_file1           qna_fstor1      qna_size1   qna_visible     qna_grpno    qna_indent   qna_ansnum
 ----- ------  ------- --------- -------------- --- ----------- ---------------------------------- ------------ ---------------- ------ ---------- ----------  ------- -------- 
     1       1     �մ���   mail1   �����Դϴ�!!   0   18/06/12 http://localhost.�˴ϴ�.�Ǹ�1.jsp  ��������1.jpg  ��������01.jps   1000       Y           1       0         0
 

4. qna ��ȸ

1) ��ȸ�� ���� 
UPDATE qna
SET qna_cnt = qna_cnt + 1
WHERE qna_no=34;

2) 1���� �� ����(R:Read, PK ���) 
SELECT qna_no, mem_no, qna_title, qna_write, qna_passwd, SUBSTR(qna_rdate, 1, 10) as qna_rdate, qna_grpno, qna_cnt,  
        qna_contents, qna_web, qna_files, qna_sizes, qna_thumbs, qna_visible,
        qna_indent, qna_ansnum
FROM qna
WHERE qna_no=30;

 qna_no  mem_no  qna_wirte   qna_email      no_title        qna_cnt   qna_rdate                  qna_web                      qna_file1           qna_fstor1      qna_size1   qna_visible     qna_grpno    qna_indent   qna_ansnum
 ----- ------  ------- --------- -------------- --- ----------- ---------------------------------- ------------ ---------------- ------ ---------- ----------  ------- -------- 
    30       1     �մ���   mail1   �����Դϴ�!!   0   2018-04-17 http://localhost.�˴ϴ�.�Ǹ�1.jsp  ��������1.jpg  ��������01.jps   1000       Y           1       0         0
 


5. �н����� �˻�
   - no_qna_cnt(): �߻��� ���ڵ��� ���� ���, ���ڵ尡 ������ 0 ���
   
SELECT no_qna_cnt(*) as qna_cnt 
FROM qna
WHERE qna_no=1 AND qna_passwd='123';

 qna_cnt
 ---
   0

   
6. �� ����(U:Update), PK�� ���ڵ带 �����ϴ� ���� ����� ������ �������� 
   �����ϴ� ���� �������� ����. 
    
1) �۸� ���� 
UPDATE qna
SET qna_wirte='����', qna_email='mail1@mail.com', no_title='���񺯰�',
      qna_contents='���� ����', qna_web='http://localhost.�˴ϴ�.�˴ϴ�02.jpg'
WHERE qna_no=1;
  
2) qna_visible ����
UPDATE qna
SET qna_visible = 'Y'
WHERE qna_no=1;

3) ���� ����
UPDATE qna
SET qna_file1='', qna_size1=0
WHERE qna_no=1;

4) ���ο� ���� ���
UPDATE qna
SET qna_file1='test.jpg', qna_fstor1='test.jpg', qna_size1=123
WHERE qna_no=1;
 
5) ���� ��ü
UPDATE qna
SET qna_file1='new.jpg', qna_fstor1='new.jpg', qna_size1=123
WHERE qna_no=1;


7. �� ����(D:Delete) 
DELETE FROM qna
WHERE qna_no = 49;

DELETE FROM qna
WHERE qna_no <= 4;

DELETE FROM qna
WHERE qna_no >= 11;


8. �˻� �� ���(S:Search List) 
    - ����� ���۽� �˻��� ������� �����ϸ� ��ü ������
      ��ü �˻����� �����ϴ�.
    - qna_wirte, no_title, qna_contents �÷� ���

1) ����: 
    - WHERE qna_wirte LIKE '�մ���'
       qna_wirte �÷��� ���� '�մ���'�� ���ڵ� ���� ���

    - WHERE qna_wirte LIKE '%�մ���%'
      qna_wirte �÷��� ���� '�մ���'�� �� ���ڵ� ���� ���

    - WHERE qna_wirte LIKE '�մ���%'
      qna_wirte �÷��� ���� '�մ���'�� �����ϴ� ���ڵ� ���� ���

    - WHERE qna_wirte LIKE '%�մ���'
      qna_wirte �÷��� ���� '�մ���'�� �����ϴ� ���ڵ� ���� ���
   

2) �˻��� ���� �ʴ� ��� ��� ���ڵ� ��� 
SELECT qna_wirte, qna_email, no_title, qna_cnt, 
        SUBSTR(qna_rdate, 1, 10) as qna_rdate, qna_web, qna_file1, qna_fstor1, qna_size1, qna_visible, 
        qna_grpno, qna_indent, qna_ansnum
FROM qna
ORDER BY qna_no DESC;

3) �̸� �˻�
SELECT mem_no, qna_wirte, qna_email, no_title, qna_cnt, 
        SUBSTR(qna_rdate, 1, 10) as qna_rdate, qna_web, qna_file1, qna_fstor1, qna_size1, qna_visible, 
        qna_grpno, qna_indent, qna_ansnum
FROM qna
WHERE qna_wirte LIKE '%�Ʒι�%'
ORDER BY qna_no DESC;
     
4) �������� �˻�   
SELECT mem_no, qna_wirte, qna_email, no_title, qna_cnt, 
        SUBSTR(qna_rdate, 1, 10) as qna_rdate, qna_web, qna_file1, qna_fstor1, qna_size1, qna_visible, 
        qna_grpno, qna_indent, qna_ansnum
FROM qna
WHERE no_title LIKE '%�н�����%'
ORDER BY qna_no DESC;
    
5) �������� �˻�
SELECT mem_no, qna_wirte, qna_email, no_title, qna_cnt, 
        SUBSTR(qna_rdate, 1, 10) as qna_rdate, qna_web, qna_file1, qna_fstor1, qna_size1, qna_visible, 
        qna_grpno, qna_indent, qna_ansnum
FROM qna
WHERE qna_contents LIKE '%����%'
ORDER BY qna_no DESC;

6) ����, �������� �˻�
SELECT mem_no, qna_wirte, qna_email, no_title, qna_cnt, 
        SUBSTR(qna_rdate, 1, 10) as qna_rdate, qna_web, qna_file1, qna_fstor1, qna_size1, qna_visible, 
        qna_grpno, qna_indent, qna_ansnum
FROM qna
WHERE no_title LIKE '%����%' OR qna_contents LIKE '%����%'
ORDER BY qna_no DESC;


9 ����¡
   - ����� ����¡ ������ �ʼ��� �մϴ�.
   
1) �˻��� ��ü ���ڵ� ��
SELECT no_qna_cnt(qna_no) as qna_cnt 
FROM qna
WHERE qna_wirte LIKE '%�մ���%';

 qna_cnt
 ---
   1
   
2) ����¡
SELECT mem_no, qna_wirte, qna_email, no_title, qna_cnt, 
        SUBSTR(qna_rdate, 1, 10) as qna_rdate, qna_web, qna_file1, qna_fstor1, qna_size1, qna_visible, 
        qna_grpno, qna_indent, qna_ansnum
FROM qna
WHERE qna_no= 1 AND qna_wirte LIKE '%�մ���%'
ORDER BY qna_grpno DESC, qna_ansnum ASC
LIMIT 0, 5;

     
* �÷��� �߰�
ALTER TABLE qna 
ADD COLUMN �߰��� �÷��� VARCHAR(100) AFTER qna_visible;
 

10. �亯

1) ������ ��ϵ� �亯�� seqno ���� ó��
UPDATE qna
SET qna_ansnum = qna_ansnum + 1
WHERE qna_no= 1 AND qna_grpno = 1 AND qna_ansnum > �θ��� qna_ansnum �÷��� ��;

UPDATE qna
SET qna_ansnum = qna_ansnum + 1
WHERE qna_no= 1 AND qna_grpno = 1 AND qna_ansnum > 0;

2) �亯 ���
-- qna_grpno: �ִ밪 + 1
-- qna_indent: 0, �亯�� �ƴϰ� �鿩���� �ʿ� ����.
-- qna_ansnum: 0, �亯�� �ƴϰ� ���� ���� ���
INSERT INTO qna(mem_no, qna_wirte, qna_email, no_title, qna_cnt, 
                SUBSTR(qna_rdate, 1, 10) as qna_rdate, qna_web, qna_file1, qna_fstor1, qna_size1, qna_visible, 
                qna_grpno, qna_indent, qna_ansnum)
VALUES(9999, '������', 'mail1', '�亯�Դϴ�.', 0,
        sysdate, 'http://���� ��ũ', '���� ����1.jpg', '���� ����01.jpg'  1000, 'Y',
           1, 1, 1);

-----------------------------------------------------------------------------------
-- �亯 ���� ����
15) �亯
[�亯 ����]
-- 1���� ���� �亯 ��Ͽ�: grpno: 1, indent: 1, ansnum: 1
SELECT * FROM member;
SELECT * FROM categrp;
SELECT * FROM category;
 
�� ���ο� �亯�� �ֽ����� ����ϱ����� ���� �亯�� �ڷ� �̷�ϴ�.
-- ��� ���� �켱 ������ 1�� ������, 1�� -> 2��
UPDATE contents
SET ansnum = ansnum + 1
WHERE categoryno=1 AND grpno = 1 AND ansnum > 0;
 
-- 2����� �켱 ������ 1�� ������, 2�� -> 3��
UPDATE contents
SET ansnum = ansnum + 1
WHERE categoryno=1 AND grpno = 1 AND ansnum > 1;
 
-- 3����� �켱 ������ 1�� ������, 3�� -> 4��
UPDATE contents
SET ansnum = ansnum + 1
WHERE categoryno=1 AND grpno = 1 AND ansnum > 2;
 
-- 6����� �켱 ������ 1�� ������, 6�� -> 7��
UPDATE contents
SET ansnum = ansnum + 1
WHERE categoryno=1 AND grpno = 1 AND ansnum > 5;
 
 
�� �亯 ���
- categoryno: FK, mno: FK
 
INSERT INTO contents(contentsno,
                          categoryno, mno, title, content, good, thumbs, files, sizes, cnt, replycnt, rdate, 
                          grpno, indent, ansnum, word)  
VALUES((SELECT NVL(MAX(contentsno), 0) + 1 as contentsno FROM contents),
            1, 1, '����', '����',0, 'summer_m.jpg', 'summer.jpg', 0, 0, 0, sysdate,
            1, 1, 1,'');
 
 
�� �亯�� ���� ���� ���� ����    
SELECT contentsno, categoryno, title, content, good, thumbs, files, sizes, cnt,
          replycnt, rdate, word, grpno, indent, ansnum, r
FROM(
         SELECT contentsno, categoryno, title, content, good, thumbs, files, sizes, cnt,
                   replycnt, rdate, word, grpno, indent, ansnum, rownum as r
         FROM(
                  SELECT contentsno, categoryno, title, content, good, thumbs, files, sizes, cnt,
                            replycnt, rdate, word, grpno, indent, ansnum
                  FROM contents
                  WHERE categoryno=6 AND word LIKE '%swiss%'
                  ORDER BY grpno DESC, ansnum ASC
         )
)
WHERE r >=1 AND r <= 3;
 
 
 
========================================================
========================================================
SELECT * FROM qna

-- qna �Խù��� ��ȣ�� ��й�ȣ Ȯ��
SELECT COUNT(qna_passwd) as cnt
FROM qna
WHERE qna_passwd=123 AND qna_no=10 
