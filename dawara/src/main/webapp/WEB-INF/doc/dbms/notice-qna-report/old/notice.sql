1. �������� notice ���̺� ���� 
-----------------------------------------------------------------------------------
1. notice ���̺� ����

CREATE TABLE notice(
  no_no     NUMBER(10)                                NOT NULL,
  mem_no     NUMBER(10)                                NOT NULL,
  no_title        VARCHAR(100)                                NOT NULL,
  no_write      VARCHAR(15)                                 NOT NULL,
  no_rdate       DATE                                           NOT NULL,
  no_qna_cnt        NUMBER(10)        DEFAULT 0           NOT NULL,
  no_qna_contents    VARCHAR(4000)                             NOT NULL,
  no_visible     CHAR(1)               DEFAULT 'Y'          NOT NULL,
  PRIMARY KEY(no_no),
  FOREIGN KEY(mem_no) REFERENCES member(mem_no)
);
COMMENT ON COLUMN notice.no_no IS '��ȣ';
COMMENT ON COLUMN notice.mem_no IS '������ ��ȣ';
COMMENT ON COLUMN notice.no_title IS '����';
COMMENT ON COLUMN notice.no_write IS '�۾���';
COMMENT ON COLUMN notice.no_rdate IS '�����';
COMMENT ON COLUMN notice.no_qna_cnt IS '��ȸ��';
COMMENT ON COLUMN notice.no_qna_contents IS '����';
COMMENT ON COLUMN notice.no_visible IS '���� ����';


2. ���̺� ����
DROP TABLE notice;

3. ���
- PK �÷��� ������.
INSERT INTO notice(no_no, mem_no, no_title, no_write, no_rdate, no_qna_cnt, no_qna_contents, no_visible)
VALUES(1, '111', '��������1', '������1', sysdate, 0, '÷�� ����', 'Y');

INSERT INTO notice(no_no, mem_no, no_title, no_write, no_rdate, no_qna_cnt, no_qna_contents, no_visible)
VALUES(2, '111','��������2', '������1', sysdate, 0, '÷�� ����', 'Y');

INSERT INTO notice(no_no, mem_no, no_title, no_write, no_rdate, no_qna_cnt, no_qna_contents, no_visible)
VALUES(3, '111', '��������3', '������2', sysdate, 0, '÷�� ����', 'Y');



4. ���
SELECT no_no, mem_no, no_title, no_write, no_rdate, no_qna_cnt, no_qna_contents, no_visible
FROM notice
ORDER BY no_no ASC;

 no_no  mem_no   no_title     no_write         no_rdate                   no_qna_cnt      no_qna_contents    no_visible
 --------  -------- --------- ----- ---------------------------  ------------- ---------- ----------
        1   111     ��������1 ������1   2017-08-21 12:14:50.0         0           ����      Y
        2   111     ��������2 ������1   2017-08-21 12:15:28.0         0           ����      Y
        3   112     ��������3 ������2   2017-08-21 12:15:45.0         0           ����      Y


-- �ϳ��� �÷��� �ƴ϶� ���ڵ� ��ü�� ������ �̵���.        
SELECT no_no, mem_no, no_title, no_write, no_rdate, no_qna_cnt, no_qna_contents no_visible
FROM notice
ORDER BY no_no DESC; 

 no_no  mem_no   no_title     no_write         no_rdate                   no_qna_cnt      no_qna_contents    no_visible
 --------  -------- --------- ----- ---------------------------  ------------- ---------- ----------
        3   112     ��������3 ������2   2017-08-21 12:15:45.0         0           ����      Y
        2   111     ��������2 ������1   2017-08-21 12:15:28.0         0           ����      Y
        1   111     ��������1 ������1   2017-08-21 12:14:50.0         0           ����      Y

 
5. ��ȸ
SELECT no_no, mem_no, no_title, no_write, no_rdate, no_qna_cnt, no_qna_contents, no_visible
FROM notice
WHERE no_no = 1;

 no_no  mem_no   no_title     no_write         no_rdate                   no_qna_cnt      no_qna_contents    no_visible
 --------  -------- --------- ----- ---------------------------  ------------- ---------- ----------
        1   111     ��������1 ������1   2017-08-21 12:14:50.0         0           ����      Y

6. ����
1) ��� ���ڵ� ����(����)
UPDATE notice
SET no_title='��������1', no_write = '������1';

 no_no  mem_no   no_title     no_write         no_rdate                   no_qna_cnt      no_qna_contents    no_visible
 --------  -------- --------- ----- ---------------------------  ------------- ---------- ----------
        1   111     ��������1 ������1   2017-08-21 12:14:50.0         0           ����      Y
        1   111     ��������1 ������1   2017-08-21 12:14:50.0         0           ����      Y
        1   111     ��������1 ������1   2017-08-21 12:14:50.0         0           ����      Y

2) 1�� ���ڵ常 ����(����)
UPDATE notice
SET no_title='���� ����1'
WHERE no_no = 1;

SELECT no_no, mem_no, no_title, no_write, no_rdate, no_qna_cnt, no_qna_contents, no_visible
FROM notice
WHERE no_no = 1;

 no_no  mem_no   no_title     no_write         no_rdate                   no_qna_cnt      no_qna_contents    no_visible
 --------  -------- ---------  ----- ---------------------------  ------------- ---------- ----------
        1   111     ���� ����1  ������1   2017-08-21 12:14:50.0         0           ����      Y        
7. ����
1) �ϳ��� ���ڵ常 ����(����)
DELETE FROM notice
WHERE no_no = 1;

SELECT no_no, mem_no, no_title, no_write, no_rdate, no_qna_cnt, no_qna_contents, no_visible
FROM notice
ORDER BY no_no ASC;

 no_no  mem_no   no_title     no_write         no_rdate                   no_qna_cnt      no_qna_contents    no_visible
 --------  -------- ---------  ----- ---------------------------  ------------- ---------- ----------
        3   112     ��������3 ������2   2017-08-21 12:15:45.0         0           ����      Y
        2   111     ��������2 ������1   2017-08-21 12:15:28.0         0           ����      Y

2) ��� ���ڵ� ����(����)        
DELETE FROM notice;

3) ���ڵ� ����
SELECT no_qna_cnt(*) as qna_cnt
FROM notice;

 qna_cnt
 ---
   0
 
 
 
 
========================================================
========================================================

