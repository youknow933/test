1. �������� notice ���̺� ���� 
-----------------------------------------------------------------------------------
1. notice ���̺� ����

CREATE TABLE notice(
  no_no     NUMBER(10)                                NOT NULL,
  mem_no     NUMBER(10)                                NOT NULL,
  no_title        VARCHAR(100)                                NOT NULL,
  no_write      VARCHAR(15)                                 NOT NULL,
  no_rdate       DATE                                           NOT NULL,
  no_cnt        NUMBER(10)        DEFAULT 0           NOT NULL,
  no_contents    VARCHAR(4000)                             NOT NULL,
  no_visible     CHAR(1)          DEFAULT 'Y'          NOT NULL,
  no_seqno        NUMBER(10)       DEFAULT 0 NOT NULL,
  no_files        VARCHAR(1000)                            NULL ,
  no_sizes        VARCHAR(1000)                            NULL ,
  no_thumbs        VARCHAR(1000)                            NULL ,
  --indent        NUMBER(2)       DEFAULT 0           NOT NULL,
  --ansnum        NUMBER(5)     DEFAULT 0           NOT NULL ,
  word        VARCHAR2(100) NULL,
  PRIMARY KEY(no_no),
  FOREIGN KEY(mem_no) REFERENCES member(mem_no)
);
COMMENT ON COLUMN notice.no_no IS '���� �� ��ȣ';
COMMENT ON COLUMN notice.mem_no IS '������ ��ȣ';
COMMENT ON COLUMN notice.no_title IS '����';
COMMENT ON COLUMN notice.no_write IS '�۾���';
COMMENT ON COLUMN notice.no_rdate IS '�����';
COMMENT ON COLUMN notice.no_cnt IS '��ȸ��';
COMMENT ON COLUMN notice.no_contents IS '����';
COMMENT ON COLUMN notice.no_visible IS '���� ����';
COMMENT ON COLUMN notice.no_files IS '����';
COMMENT ON COLUMN notice.no_sizes IS '����ũ��';
COMMENT ON COLUMN notice.no_thumbs IS '���������';
--COMMENT ON COLUMN notice.indent IS '�ε�Ʈ';
--COMMENT ON COLUMN notice.ansnum IS '�亯 ��ȣ';
COMMENT ON COLUMN notice.word IS '�˻���';

ALTER TABLE notice add(no_files VARCHAR(1000));
ALTER TABLE notice add(no_sizes VARCHAR(1000));
ALTER TABLE notice add(no_thumbs VARCHAR(1000));
--ALTER TABLE notice add(indent NUMBER(2) DEFAULT 0 NOT NULL);
--ALTER TABLE notice add(ansnum NUMBER(5) DEFAULT 0 NOT NULL);
ALTER TABLE notice add(word VARCHAR2(100) NULL);

SELECT * FROM notice;
   
SELECT no_no, mem_no, no_title, no_write, no_rdate, no_cnt, no_contents, no_visible, no_seqno, no_files, no_sizes, no_thumbs, word
FROM notice 
WHERE mem_no=1

2. ���̺� ����
DROP TABLE notice;


3. ���
-- �������� �� ��ȣ, ��� ������ �ڵ� ����
-- mem_no ��� ��ȣ

-- �亯 ��� x 
INSERT INTO notice(no_no, mem_no, no_title, no_contents, no_write, no_rdate,  no_files, no_sizes, no_thumbs, word)
VALUES((SELECT NVL(MAX(no_no), 0)+1 AS no_no FROM notice), 1, '�α��� ���� ����555', '�α��� ���� ����111', '������1', sysdate, '����', '���� ũ��', '�����', '�˻���');



-- �亯 ��� ���� �� ���
INSERT INTO notice(no_no, mem_no, no_title, no_contents, no_write, no_rdate,  no_files, no_sizes, no_thumbs, indent, ansnum, word)
VALUES((SELECT NVL(MAX(no_no), 0)+1 AS no_no FROM notice), 1, '�α��� ���� ����555', '�α��� ���� ����111', '������1', sysdate, '����', '���� ũ��', '�����', 0, 0, '�˻���');



INSERT INTO notice(no_no, mem_no, no_title, no_contents, no_write, no_rdate)
VALUES((SELECT NVL(MAX(no_no), 0)+1 AS no_no FROM notice), 1, '�α��� ���� ����555', '�α��� ���� ����111', '������1', sysdate);

INSERT INTO notice(no_no, mem_no, no_title, no_write, no_rdate, no_cnt, no_contents, no_visible, no_seqno)
VALUES((SELECT NVL(MAX(no_no), 0)+1 AS no_no FROM notice), 1, '��������1', '������1', sysdate, 0, '÷�� ����', 'Y', (SELECT NVL(MAX(no_seqno), 0)+1 AS no_seqno FROM notice));

INSERT INTO notice(no_no, mem_no, no_title, no_write, no_rdate, no_cnt, no_contents, no_visible, no_seqno)
VALUES((SELECT NVL(MAX(no_no), 0)+1 AS no_no FROM notice), 1, '��������2', '������1', sysdate, 0, '÷�� ����', 'Y', (SELECT NVL(MAX(no_seqno), 0)+1 AS no_seqno FROM notice));

INSERT INTO notice(no_no, mem_no, no_title, no_write, no_rdate, no_cnt, no_contents, no_visible, no_seqno)
VALUES((SELECT NVL(MAX(no_no), 0)+1 AS no_no FROM notice), 2, '��������3', '������2', sysdate, 0, '÷�� ����', 'Y', (SELECT NVL(MAX(no_seqno), 0)+1 AS no_seqno FROM notice));




4. ���
SELECT no_no, mem_no, no_title, no_write, no_rdate, no_cnt, no_contents, no_visible, no_seqno, no_files, no_sizes, no_thumbs, word
FROM notice
ORDER BY no_no ASC;

 no_no  mem_no   no_title     no_write         no_rdate                   no_cnt      no_contents    no_visible    no_seqno
 --------  -------- --------- ----- ---------------------------  ------------- ---------- ----------
        1   1     ��������1 ������1   2017-08-21 12:14:50.0         0           ����      Y      1
        2   1     ��������2 ������1   2017-08-21 12:15:28.0         0           ����      Y      2
        3   2     ��������3 ������2   2017-08-21 12:15:45.0         0           ����      Y      3


-- �ϳ��� �÷��� �ƴ϶� ���ڵ� ��ü�� ������ �̵���.        
SELECT no_no, mem_no, no_title, no_write, no_rdate, no_cnt, no_contents no_visible, no_seqno, no_files, no_sizes, no_thumbs, word
FROM notice
ORDER BY no_no DESC; 

 no_no  mem_no   no_title     no_write         no_rdate                   no_cnt      no_contents    no_visible    no_seqno
 --------  -------- --------- ----- ---------------------------  ------------- ---------- ----------
        3   2     ��������3 ������2   2017-08-21 12:15:45.0         0           ����      Y      3
        2   1     ��������2 ������1   2017-08-21 12:15:28.0         0           ����      Y      2
        1   1     ��������1 ������1   2017-08-21 12:14:50.0         0           ����      Y      1

 
5. ��ȸ
SELECT no_no, mem_no, no_title, no_write, no_rdate, no_cnt, no_contents, no_visible, no_seqno, no_files, no_sizes, no_thumbs, word
FROM notice
WHERE no_no = 1;

 no_no  mem_no   no_title     no_write         no_rdate                   no_cnt      no_contents    no_visible       no_seqno
 --------  -------- --------- ----- ---------------------------  ------------- ---------- ----------
        1   1     ��������1 ������1   2017-08-21 12:14:50.0         0           ����      Y            1

6. ����
1) ��� ���ڵ� ����(����)
UPDATE notice
SET no_title='��������1', no_write = '������1';

 no_no  mem_no   no_title     no_write         no_rdate                   no_cnt      no_contents    no_visible      no_seqno
 --------  -------- --------- ----- ---------------------------  ------------- ---------- ----------
        1   1     ��������1 ������1   2017-08-21 12:14:50.0         0           ����      Y        1
        1   1     ��������1 ������1   2017-08-21 12:14:50.0         0           ����      Y        2
        1   1     ��������1 ������1   2017-08-21 12:14:50.0         0           ����      Y        3

2) 1�� ���ڵ常 ����(����)
UPDATE notice
SET no_title='���� ����123', no_contents='���� ����1', no_visible='N'
WHERE no_no = 1;

SELECT no_no, mem_no, no_title, no_write, no_rdate, no_cnt, no_contents, no_visible, no_seqno, no_files, no_sizes, no_thumbs, word
FROM notice
WHERE no_no = 1;

 no_no  mem_no   no_title     no_write         no_rdate                   no_cnt      no_contents    no_visible       no_seqno
 --------  -------- ---------  ----- ---------------------------  ------------- ---------- ----------
        1   1     ���� ����123  ������1   2017-08-21 12:14:50.0         0           ����      Y           1        
7. ����
-- ��ü ����
DELETE FROM notice;



SELECT * FROM notice

-- �̹��� �ϳ� ���� (������ ������ �����ϰ�, �ٽ� �о�鿩�� ������Ʈ �ؾ� �� 18.07.06.)
    UPDATE notice
    SET no_files=NULL, no_sizes=NULL, no_thumbs=NULL
    WHERE no_no=4 AND no_files='0_coffee01.jpg' AND no_sizes='11325' AND no_thumbs='0_coffee01_t.jpg'

    
-- '����'��ư Ŭ�� �� ÷���� �� �����..
    UPDATE notice
    SET no_files=NULL, no_sizes=NULL, no_thumbs=NULL
    WHERE no_no=4
    

1) �ϳ��� ���ڵ常 ����(����)
DELETE FROM notice
WHERE no_no = 1;

SELECT no_no, mem_no, no_title, no_write, no_rdate, no_cnt, no_contents, no_visible, no_seqno, no_files, no_sizes, no_thumbs, word
FROM notice
ORDER BY no_no ASC;

 no_no  mem_no   no_title     no_write         no_rdate                   no_cnt      no_contents    no_visible
 --------  -------- ---------  ----- ---------------------------  ------------- ---------- ----------
        3   2     ��������3 ������2   2017-08-21 12:15:45.0         0           ����      Y
        2   1     ��������2 ������1   2017-08-21 12:15:28.0         0           ����      Y

2) ��� ���ڵ� ����(����)        
DELETE FROM notice;

3) ���ڵ� ����
SELECT no_cnt(*) as qna_cnt
FROM notice;

 qna_cnt
 ---
   0
 
