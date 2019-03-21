
3. ��� �Ű� ���̺� ����

SELECT * FROM report

DROP TABLE report; 

CREATE TABLE report ( 
  report_no       NUMBER(10)           NOT NULL , 
  mem_no       NUMBER(10)    NOT NULL ,
  report_title      VARCHAR(100)  NOT NULL , 
  report_write     VARCHAR(20)   NOT NULL ,
  report_passwd     VARCHAR(15)   NOT NULL , 
  report_rdate      DATE      NOT NULL , 
  report_grpno                 NUMBER(7)  NOT NULL,
  report_cnt        NUMBER(10)           DEFAULT 0 NOT NULL , 
  report_contents    VARCHAR(4000) NOT NULL , 
  report_web        VARCHAR(100)      NULL ,
  report_files      VARCHAR(1000)      NULL ,
  report_sizes      VARCHAR(1000)        DEFAULT 0  NULL ,
  report_thumbs        VARCHAR(1000)     NULL ,
  report_visible    CHAR(1)       DEFAULT 'N' NOT NULL ,  
  report_indent   NUMBER(5)        DEFAULT 0       NOT NULL,
  report_ansnum   NUMBER(5)        DEFAULT 0       NOT NULL ,
 -- word        VARCHAR2(100) NULL,
  PRIMARY KEY (report_no),
  FOREIGN KEY (mem_no) REFERENCES member(mem_no)
) 

COMMENT ON COLUMN report.report_no IS  '�� �Ϸ� ��ȣ';
COMMENT ON COLUMN report.mem_no IS 'ȸ�� ��ȣ';  
COMMENT ON COLUMN report.report_title IS '����';
COMMENT ON COLUMN report.report_write IS '�۾���';
COMMENT ON COLUMN report.report_passwd IS '�� �Ϸ� ��ȣ'; 
COMMENT ON COLUMN report.report_rdate IS '��� ��¥'; 
COMMENT ON COLUMN report.report_grpno is '�׷��ȣ';
COMMENT ON COLUMN report.report_cnt IS '��ȸ��';
COMMENT ON COLUMN report.report_contents IS '�� ����'; 
COMMENT ON COLUMN report.report_web IS 'URL';
COMMENT ON COLUMN report.report_files IS '���ϸ�';
COMMENT ON COLUMN report.report_sizes IS '���� ũ��';
COMMENT ON COLUMN report.report_thumbs IS '�����';
COMMENT ON COLUMN report.report_visible IS '�����';
COMMENT ON COLUMN report.report_indent IS '�亯 ����';
COMMENT ON COLUMN report.report_ansnum IS '�亯 ����';
--COMMENT ON COLUMN report.word IS '�˻���';




2. �� �߰�(C: Create) 
-- ���ο� �� ���
-- report_grpno: �ִ밪 + 1
-- report_indent: 0, �亯�� �ƴϰ� �鿩���� �ʿ� ����.
-- report_ansnum: 0, �亯�� �ƴϰ� ���� ���� ���
INSERT INTO report(report_no, mem_no, report_title, report_write, report_passwd, report_rdate, report_grpno, report_cnt,  
                 report_contents, report_web, report_files, report_sizes, report_thumbs, report_visible,
                 report_indent, report_ansnum, word)
VALUES((SELECT NVL(MAX(report_no), 0)+1 AS report_no FROM report), 1, '�Ű� ����', '������1', 123, sysdate, (SELECT NVL(MAX(report_grpno), 0) + 1 as report_grpno FROM report), '0',
        '����', 'http://art.incheon.go.kr', '���� ����1.jpg', '���� ũ��',  '�����', 'N',
          1, 0, '�˻���');
            
            
3. ��ü �� ���(S:Total Select List), �ֽű� ���� ��� 
   - ASC: ���� ����, DESC: ���� ���� 
   - substring(�÷���, ������ġ, ����), ������ġ 1���� ����: ���ڿ� �Ϻθ� ����
   - �Լ� ���� �÷����� �ſ� ��������� 
     'SUBSTR(report_rdate, 1, 10)' ������ as Ű����� 'report_rdate' ��ȯ�մϴ�. 
     
     
-- ��� ��ȣ �˻����� �Ű� ���� Ȯ��
SELECT report_no, mem_no, report_title, report_write, report_passwd, SUBSTR(report_rdate, 1, 10) as report_rdate, report_grpno, report_cnt,  
        report_contents, report_web, report_files, report_sizes, report_thumbs, report_visible,
        report_indent, report_ansnum
FROM report
WHERE mem_no = 1
ORDER BY report_no DESC, report_ansnum ASC;

 report_no  mem_no  report_wirte   report_email      no_title        report_cnt   report_rdate                  report_web                      report_file1           report_fstor1      report_size1   report_visible     report_grpno    report_indent   report_ansnum
 ----- ------  ------- --------- -------------- --- ----------- ---------------------------------- ------------ ---------------- ------ ---------- ----------  ------- -------- 
     1       1     �մ���   mail1   �Ű��Դϴ�!!   0   18/06/12 http://localhost.�˴ϴ�.�Ǹ�1.jsp  ��������1.jpg  ��������01.jps   1000       Y           1       0         0
 

4. report ��ȸ

1) ��ȸ�� ���� 
UPDATE report
SET report_cnt = report_cnt + 1
WHERE report_no=34;

2) 1���� �� ����(R:Read, PK ���) 
SELECT report_no, mem_no, report_title, report_write, report_passwd, SUBSTR(report_rdate, 1, 10) as report_rdate, report_grpno, report_cnt,  
        report_contents, report_web, report_files, report_sizes, report_thumbs, report_visible,
        report_indent, report_ansnum
FROM report
WHERE report_no=30;

 report_no  mem_no  report_wirte   report_email      no_title        report_cnt   report_rdate                  report_web                      report_file1           report_fstor1      report_size1   report_visible     report_grpno    report_indent   report_ansnum
 ----- ------  ------- --------- -------------- --- ----------- ---------------------------------- ------------ ---------------- ------ ---------- ----------  ------- -------- 
    30       1     �մ���   mail1   �Ű��Դϴ�!!   0   2018-04-17 http://localhost.�˴ϴ�.�Ǹ�1.jsp  ��������1.jpg  ��������01.jps   1000       Y           1       0         0
 

    select * from report;
    

5. �н����� �˻�
   - no_report_cnt(): �߻��� ���ڵ��� ���� ���, ���ڵ尡 ������ 0 ���
   
SELECT no_report_cnt(*) as report_cnt 
FROM report
WHERE report_no=1 AND report_passwd='123';

 report_cnt
 ---
   0

   
6. �� ����(U:Update), PK�� ���ڵ带 �����ϴ� ���� ����� ������ �������� 
   �����ϴ� ���� �������� ����. 
    
1) �۸� ���� 
UPDATE report
SET report_wirte='����', report_email='mail1@mail.com', no_title='���񺯰�',
      report_contents='���� ����', report_web='http://localhost.�˴ϴ�.�˴ϴ�02.jpg'
WHERE report_no=1;
  
2) report_visible ����
UPDATE report
SET report_visible = 'Y'
WHERE report_no=1;

3) ���� ����
UPDATE report
SET report_file1='', report_size1=0
WHERE report_no=1;

4) ���ο� ���� ���
UPDATE report
SET report_file1='test.jpg', report_fstor1='test.jpg', report_size1=123
WHERE report_no=1;
 
5) ���� ��ü
UPDATE report
SET report_file1='new.jpg', report_fstor1='new.jpg', report_size1=123
WHERE report_no=1;


7. �� ����(D:Delete) 
DELETE FROM report
WHERE report_no = 49;

DELETE FROM report
WHERE report_no <= 4;

DELETE FROM report
WHERE report_no >= 11;


8. �˻� �� ���(S:Search List) 
    - ����� ���۽� �˻��� ������� �����ϸ� ��ü ������
      ��ü �˻����� �����ϴ�.
    - report_wirte, no_title, report_contents �÷� ���

1) ����: 
    - WHERE report_wirte LIKE '�մ���'
       report_wirte �÷��� ���� '�մ���'�� ���ڵ� ���� ���

    - WHERE report_wirte LIKE '%�մ���%'
      report_wirte �÷��� ���� '�մ���'�� �� ���ڵ� ���� ���

    - WHERE report_wirte LIKE '�մ���%'
      report_wirte �÷��� ���� '�մ���'�� �����ϴ� ���ڵ� ���� ���

    - WHERE report_wirte LIKE '%�մ���'
      report_wirte �÷��� ���� '�մ���'�� �����ϴ� ���ڵ� ���� ���
   

2) �˻��� ���� �ʴ� ��� ��� ���ڵ� ��� 
SELECT report_wirte, report_email, no_title, report_cnt, 
        SUBSTR(report_rdate, 1, 10) as report_rdate, report_web, report_file1, report_fstor1, report_size1, report_visible, 
        report_grpno, report_indent, report_ansnum
FROM report
ORDER BY report_no DESC;

3) �̸� �˻�
SELECT mem_no, report_wirte, report_email, no_title, report_cnt, 
        SUBSTR(report_rdate, 1, 10) as report_rdate, report_web, report_file1, report_fstor1, report_size1, report_visible, 
        report_grpno, report_indent, report_ansnum
FROM report
WHERE report_wirte LIKE '%�Ʒι�%'
ORDER BY report_no DESC;
     
4) �������� �˻�   
SELECT mem_no, report_wirte, report_email, no_title, report_cnt, 
        SUBSTR(report_rdate, 1, 10) as report_rdate, report_web, report_file1, report_fstor1, report_size1, report_visible, 
        report_grpno, report_indent, report_ansnum
FROM report
WHERE no_title LIKE '%�н�����%'
ORDER BY report_no DESC;
    
5) �������� �˻�
SELECT mem_no, report_wirte, report_email, no_title, report_cnt, 
        SUBSTR(report_rdate, 1, 10) as report_rdate, report_web, report_file1, report_fstor1, report_size1, report_visible, 
        report_grpno, report_indent, report_ansnum
FROM report
WHERE report_contents LIKE '%����%'
ORDER BY report_no DESC;

6) ����, �������� �˻�
SELECT mem_no, report_wirte, report_email, no_title, report_cnt, 
        SUBSTR(report_rdate, 1, 10) as report_rdate, report_web, report_file1, report_fstor1, report_size1, report_visible, 
        report_grpno, report_indent, report_ansnum
FROM report
WHERE no_title LIKE '%����%' OR report_contents LIKE '%����%'
ORDER BY report_no DESC;


9 ����¡
   - ����� ����¡ ������ �ʼ��� �մϴ�.
   
1) �˻��� ��ü ���ڵ� ��
SELECT no_report_cnt(report_no) as report_cnt 
FROM report
WHERE report_wirte LIKE '%�մ���%';

 report_cnt
 ---
   1
   
2) ����¡
SELECT mem_no, report_wirte, report_email, no_title, report_cnt, 
        SUBSTR(report_rdate, 1, 10) as report_rdate, report_web, report_file1, report_fstor1, report_size1, report_visible, 
        report_grpno, report_indent, report_ansnum
FROM report
WHERE report_no= 1 AND report_wirte LIKE '%�մ���%'
ORDER BY report_grpno DESC, report_ansnum ASC
LIMIT 0, 5;

     
* �÷��� �߰�
ALTER TABLE report 
ADD COLUMN �߰��� �÷��� VARCHAR(100) AFTER report_visible;
 

10. �亯

1) ������ ��ϵ� �亯�� seqno ���� ó��
UPDATE report
SET report_ansnum = report_ansnum + 1
WHERE report_no= 1 AND report_grpno = 1 AND report_ansnum > �θ��� report_ansnum �÷��� ��;

UPDATE report
SET report_ansnum = report_ansnum + 1
WHERE report_no= 1 AND report_grpno = 1 AND report_ansnum > 0;

2) �亯 ���
-- report_grpno: �ִ밪 + 1
-- report_indent: 0, �亯�� �ƴϰ� �鿩���� �ʿ� ����.
-- report_ansnum: 0, �亯�� �ƴϰ� ���� ���� ���
INSERT INTO report(mem_no, report_wirte, report_email, no_title, report_cnt, 
                SUBSTR(report_rdate, 1, 10) as report_rdate, report_web, report_file1, report_fstor1, report_size1, report_visible, 
                report_grpno, report_indent, report_ansnum)
VALUES(9999, '������', 'mail1', '�亯�Դϴ�.', 0,
        sysdate, 'http://�Ű� ��ũ', '���� ����1.jpg', '���� ����01.jpg'  1000, 'Y',
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
SELECT * FROM report

-- qna �Խù��� ��ȣ�� ��й�ȣ Ȯ��
SELECT COUNT(report_passwd) as cnt
FROM report
WHERE report_passwd=123 AND report_no=1 