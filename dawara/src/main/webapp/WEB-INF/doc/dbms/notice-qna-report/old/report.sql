
3. ��� �Ű� �Խ���

DROP TABLE report; 

CREATE TABLE report ( 
  rpt_no      NUMBER(10)           NOT NULL,
  mem_no      NUMBER(10)    NOT NULL ,
  rpt_write      VARCHAR(20)   NOT NULL ,
  rpt_email      VARCHAR(100)      NULL ,  
  rpt_title        VARCHAR(200)  NOT NULL , 
  rpt_content    VARCHAR(4000) NOT NULL , 
  rpt_passwd     VARCHAR(15)   NOT NULL , 
  rpt_cnt        NUMBER(10)           DEFAULT 0 NOT NULL , 
  rpt_rdate      DATE      NOT NULL , 
  rpt_web        VARCHAR(100)      NULL ,
  rpt_file1      VARCHAR(100)      NULL ,
  rpt_fstor1     VARCHAR(100)      NULL ,
  rpt_size1      NUMBER(10)        DEFAULT 0 NOT NULL ,
  rpt_visible    CHAR(1)       DEFAULT 'Y' NOT NULL ,  
  rpt_grpno    NUMBER(10)        NOT NULL ,
  rpt_indent   NUMBER(5)        DEFAULT 0       NOT NULL,
  rpt_ansnum   NUMBER(5)        DEFAULT 0       NOT NULL ,
  PRIMARY KEY (rpt_no),
  FOREIGN KEY (mem_no) REFERENCES member(mem_no)
)

drop table report;

COMMENT ON COLUMN report.rpt_no IS  '�� �Ϸ� ��ȣ';
COMMENT ON COLUMN report.mem_no IS 'ȸ�� ��ȣ';  -- ���ڵ带 �����ϴ� �÷�
COMMENT ON COLUMN report.rpt_write IS '�۾���';
COMMENT ON COLUMN report.rpt_email IS '�̸���';  
COMMENT ON COLUMN report.rpt_title IS '����';
COMMENT ON COLUMN report.rpt_content IS '�� ����'; 
COMMENT ON COLUMN report.rpt_passwd IS '�� �Ϸ� ��ȣ'; 
COMMENT ON COLUMN report.rpt_cnt IS '��ȸ��';
COMMENT ON COLUMN report.rpt_rdate IS '��� ��¥'; 
COMMENT ON COLUMN report.rpt_web IS 'URL';
COMMENT ON COLUMN report.rpt_file1 IS '���ϸ�';
COMMENT ON COLUMN report.rpt_fstor1 IS '���� ���� ���ϸ�';
COMMENT ON COLUMN report.rpt_size1 IS '���� ũ�� 1';
COMMENT ON COLUMN report.rpt_visible IS '�����';
COMMENT ON COLUMN report.rpt_grpno IS '�׷� ��ȣ';
COMMENT ON COLUMN report.rpt_indent IS '�亯 ����';
COMMENT ON COLUMN report.rpt_ansnum IS '�亯 ����';

2. �� �߰�(C: Create) 
-- ���ο� �� ���
-- rpt_grpno: �ִ밪 + 1
-- rpt_indent: 0, �亯�� �ƴϰ� �鿩���� �ʿ� ����.
-- rpt_ansnum: 0, �亯�� �ƴϰ� ���� ���� ���
INSERT INTO report(rpt_no, mem_no, rpt_write, rpt_email, rpt_title, rpt_content, rpt_passwd,
                  rpt_cnt, rpt_rdate, rpt_web, rpt_file1, rpt_fstor1, rpt_size1, rpt_visible,
                  rpt_grpno, rpt_indent, rpt_ansnum)
VALUES(1, 1, '�մ���', 'mail1', '�Ͼ� ���׶�� ����', '��ī������ �鹬��', '123',
           0, sysdate, 'http://art.incheon.go.kr', '���� ����1.jpg', '���� ����01.jpg',  1000, 'Y',
           1, 0, 0);
           -- 2.�� ���������� rpt_grpno�� IFNULL�� �̿��ؼ� �������״� ����� �����غ��� ��.
           
            
            
3. ��ü �� ���(S:Total Select List), �ֽű� ���� ��� 
   - ASC: ���� ����, DESC: ���� ���� 
   - substr(�÷���, ������ġ, ����), ������ġ 1���� ����: ���ڿ� �Ϻθ� ����
   - �Լ� ���� �÷����� �ſ� ��������� 
     'SUBSTR(rpt_rdate, 1, 10)' ������ as Ű����� 'rpt_rdate' ��ȯ�մϴ�. 

-- �Ű� �Խ� ��ȣ�� ��� �˻�
SELECT rpt_no, mem_no, rpt_write, rpt_email, rpt_title, rpt_cnt, 
          SUBSTR(rpt_rdate, 1, 10) as rpt_rdate, rpt_web, rpt_file1, rpt_fstor1, rpt_size1, rpt_visible, 
          rpt_grpno, rpt_indent, rpt_ansnum
FROM report
WHERE rpt_no = 1
ORDER BY rpt_grpno DESC, rpt_ansnum ASC;

 rpt_no  mem_no  rpt_write   rpt_email      rpt_title        rpt_cnt   rpt_rdate                  rpt_web                      rpt_file1           rpt_fstor1      rpt_size1   rpt_visible     rpt_grpno    rpt_indent   rpt_ansnum
 ----- ------  ------- --------- -------------- --- ----------- ---------------------------------- ------------ ---------------- ------ ---------- ----------  ------- -------- 
     1       1     �մ���   mail1   �Ű��մϴ�!!   0   2018-04-17 http://localhost.�˴ϴ�.�Ǹ�1.jsp  ��������1.jpg  ��������01.jps   1000       Y           1       0         0
 

4. report ��ȸ

1) ��ȸ�� ���� 
UPDATE report
SET rpt_cnt = rpt_cnt + 1
WHERE rpt_no=34;

2) 1���� �� ����(R:Read, PK ���) 
SELECT mem_no, rpt_write, rpt_email, rpt_title, rpt_cnt, 
        SUBSTR(rpt_rdate, 1, 10) as rpt_rdate, rpt_web, rpt_file1, rpt_fstor1, rpt_size1, rpt_visible, 
        rpt_grpno, rpt_indent, rpt_ansnum
FROM report
WHERE rpt_no=30;

 rpt_no  mem_no  rpt_write   rpt_email      rpt_title        rpt_cnt   rpt_rdate                  rpt_web                      rpt_file1           rpt_fstor1      rpt_size1   rpt_visible     rpt_grpno    rpt_indent   rpt_ansnum
 ----- ------  ------- --------- -------------- --- ----------- ---------------------------------- ------------ ---------------- ------ ---------- ----------  ------- -------- 
    30       1     �մ���   mail1   �Ű��մϴ�!!   0   2018-04-17 http://localhost.�˴ϴ�.�Ǹ�1.jsp  ��������1.jpg  ��������01.jps   1000       Y           1       0         0
 


5. �н����� �˻�
   - no_rpt_cnt(): �߻��� ���ڵ��� ���� ���, ���ڵ尡 ������ 0 ���
   
SELECT no_rpt_cnt(*) as rpt_cnt 
FROM report
WHERE rpt_no=1 AND rpt_passwd='123';

 rpt_cnt
 ---
   0

   
6. �� ����(U:Update), PK�� ���ڵ带 �����ϴ� ���� ����� ������ �������� 
   �����ϴ� ���� �������� ����. 
    
1) �۸� ���� 
UPDATE report
SET rpt_write='����', rpt_email='mail1@mail.com', rpt_title='���񺯰�',
      rpt_content='���� ����', rpt_web='http://localhost.�˴ϴ�.�˴ϴ�02.jpg'
WHERE rpt_no=1;
  
2) rpt_visible ����
UPDATE report
SET rpt_visible = 'Y'
WHERE rpt_no=1;

3) ���� ����
UPDATE report
SET rpt_file1='', rpt_size1=0
WHERE rpt_no=1;

4) ���ο� ���� ���
UPDATE report
SET rpt_file1='test.jpg', rpt_fstor1='test.jpg', rpt_size1=123
WHERE rpt_no=1;
 
5) ���� ��ü
UPDATE report
SET rpt_file1='new.jpg', rpt_fstor1='new.jpg', rpt_size1=123
WHERE rpt_no=1;


7. �� ����(D:Delete) 
DELETE FROM report
WHERE rpt_no = 49;

DELETE FROM report
WHERE rpt_no <= 4;

DELETE FROM report
WHERE rpt_no >= 11;


8. �˻� �� ���(S:Search List) 
    - ����� ���۽� �˻��� ������� �����ϸ� ��ü ������
      ��ü �˻����� �����ϴ�.
    - rpt_write, rpt_title, rpt_content �÷� ���

1) ����: 
    - WHERE rpt_write LIKE '�մ���'
       rpt_write �÷��� ���� '�մ���'�� ���ڵ� ���� ���

    - WHERE rpt_write LIKE '%�մ���%'
      rpt_write �÷��� ���� '�մ���'�� �� ���ڵ� ���� ���

    - WHERE rpt_write LIKE '�մ���%'
      rpt_write �÷��� ���� '�մ���'�� �����ϴ� ���ڵ� ���� ���

    - WHERE rpt_write LIKE '%�մ���'
      rpt_write �÷��� ���� '�մ���'�� �����ϴ� ���ڵ� ���� ���
   

2) �˻��� ���� �ʴ� ��� ��� ���ڵ� ��� 
SELECT rpt_write, rpt_email, rpt_title, rpt_cnt, 
        SUBSTRING(rpt_rdate, 1, 10) as rpt_rdate, rpt_web, rpt_file1, rpt_fstor1, rpt_size1, rpt_visible, 
        rpt_grpno, rpt_indent, rpt_ansnum
FROM report
ORDER BY rpt_no DESC;

3) �̸� �˻�
SELECT mem_no, rpt_write, rpt_email, rpt_title, rpt_cnt, 
        SUBSTRING(rpt_rdate, 1, 10) as rpt_rdate, rpt_web, rpt_file1, rpt_fstor1, rpt_size1, rpt_visible, 
        rpt_grpno, rpt_indent, rpt_ansnum
FROM report
WHERE rpt_write LIKE '%�Ʒι�%'
ORDER BY rpt_no DESC;
     
4) �������� �˻�   
SELECT mem_no, rpt_write, rpt_email, rpt_title, rpt_cnt, 
        SUBSTRING(rpt_rdate, 1, 10) as rpt_rdate, rpt_web, rpt_file1, rpt_fstor1, rpt_size1, rpt_visible, 
        rpt_grpno, rpt_indent, rpt_ansnum
FROM report
WHERE rpt_title LIKE '%�н�����%'
ORDER BY rpt_no DESC;
    
5) �������� �˻�
SELECT mem_no, rpt_write, rpt_email, rpt_title, rpt_cnt, 
        SUBSTRING(rpt_rdate, 1, 10) as rpt_rdate, rpt_web, rpt_file1, rpt_fstor1, rpt_size1, rpt_visible, 
        rpt_grpno, rpt_indent, rpt_ansnum
FROM report
WHERE rpt_content LIKE '%����%'
ORDER BY rpt_no DESC;

6) ����, �������� �˻�
SELECT mem_no, rpt_write, rpt_email, rpt_title, rpt_cnt, 
        SUBSTRING(rpt_rdate, 1, 10) as rpt_rdate, rpt_web, rpt_file1, rpt_fstor1, rpt_size1, rpt_visible, 
        rpt_grpno, rpt_indent, rpt_ansnum
FROM report
WHERE rpt_title LIKE '%����%' OR rpt_content LIKE '%����%'
ORDER BY rpt_no DESC;


9 ����¡
   - ����� ����¡ ������ �ʼ��� �մϴ�.
   
1) �˻��� ��ü ���ڵ� ��
SELECT no_rpt_cnt(rpt_no) as rpt_cnt 
FROM report
WHERE rpt_write LIKE '%�մ���%';

 rpt_cnt
 ---
   1
   
2) ����¡
SELECT mem_no, rpt_write, rpt_email, rpt_title, rpt_cnt, 
        SUBSTRING(rpt_rdate, 1, 10) as rpt_rdate, rpt_web, rpt_file1, rpt_fstor1, rpt_size1, rpt_visible, 
        rpt_grpno, rpt_indent, rpt_ansnum
FROM report
WHERE rpt_no= 1 AND rpt_write LIKE '%�մ���%'
ORDER BY rpt_grpno DESC, rpt_ansnum ASC
LIMIT 0, 5;

     
* �÷��� �߰�
ALTER TABLE report 
ADD COLUMN �߰��� �÷��� VARCHAR(100) AFTER rpt_visible;
 

10. �亯

1) ������ ��ϵ� �亯�� seqno ���� ó��
UPDATE report
SET rpt_ansnum = rpt_ansnum + 1
WHERE rpt_no= 1 AND rpt_grpno = 1 AND rpt_ansnum > �θ��� rpt_ansnum �÷��� ��;

UPDATE report
SET rpt_ansnum = rpt_ansnum + 1
WHERE rpt_no= 1 AND rpt_grpno = 1 AND rpt_ansnum > 0;

2) �亯 ���
-- rpt_grpno: �ִ밪 + 1
-- rpt_indent: 0, �亯�� �ƴϰ� �鿩���� �ʿ� ����.
-- rpt_ansnum: 0, �亯�� �ƴϰ� ���� ���� ���
INSERT INTO report(mem_no, rpt_write, rpt_email, rpt_title, rpt_cnt, 
                SUBSTRING(rpt_rdate, 1, 10) as rpt_rdate, rpt_web, rpt_file1, rpt_fstor1, rpt_size1, rpt_visible, 
                rpt_grpno, rpt_indent, rpt_ansnum)
VALUES(9999, '������', 'mail1', '�亯�Դϴ�.', 0,
        sysdate, 'http://���� ��ũ', '���� ����1.jpg', '���� ����01.jpg'  1000, 'Y',
           1, 1, 1);
