0. ���̺� ����
DROP TABLE categrp;

�θ����̺� ��������
DROP TABLE categrp CASCADE CONSTRAINTS; 
DROP TABLE category CASCADE CONSTRAINTS; 
DROP TABLE member CASCADE CONSTRAINTS; 
DROP TABLE surf CASCADE CONSTRAINTS; 

CREATE TABLE member (
  mem_no       NUMBER(6) NOT NULL, -- ȸ�� ��ȣ, ���ڵ带 �����ϴ� �÷� 
  PRIMARY KEY (mem_no)                  -- �ѹ� ��ϵ� ���� �ߺ� �ȵ�
);  

CREATE TABLE categrp (
  categrpno       NUMBER(6) NOT NULL, -- ȸ�� ��ȣ, ���ڵ带 �����ϴ� �÷� 
  PRIMARY KEY (categrpno)                  -- �ѹ� ��ϵ� ���� �ߺ� �ȵ�
);

DROP TABLE categrp;
DROP TABLE member;

SELECT * FROM member;
SELECT * FROM categrp;

DELETE FROM categrp
where categrpno =4;

1. ���̺� ����
CREATE TABLE category(
  categoryno        NUMBER(7)                                NOT NULL,
  categrpno         NUMBER(10)                               NOT NULL ,
  ntitle          VARCHAR2(50)                            NOT NULL,
  nseqno               NUMBER(3)        DEFAULT 1         NOT NULL,
  nvisible               CHAR(1)            DEFAULT 'Y'        NOT NULL,
  nids                    VARCHAR2(100)                          NULL,
  rdate                  DATE                                          NOT NULL,
  PRIMARY KEY(categoryno),
  FOREIGN KEY (categrpno) REFERENCES categrp (categrpno)
);

DROP TABLE category;
DROP TABLE buysell;
DROP TABLE reply;

COMMENT ON TABLE category is 'ī�װ�';
COMMENT ON COLUMN category.categoryno is 'ī�װ� ��ȣ';
COMMENT ON COLUMN category.categrpno is 'ī�װ� �׷� ��ȣ';
COMMENT ON COLUMN category.ntitle is '�Խ��� �̸�';
COMMENT ON COLUMN category.nseqno is '��� ����';
COMMENT ON COLUMN category.nvisible is '��� ���';
COMMENT ON COLUMN category.nids is '���� ����';
COMMENT ON COLUMN category.cnt is '��ϵ� �� ��';
COMMENT ON COLUMN category.rdate is '�����';

�ӽ� parent key

INSERT INTO member(mem_no) VALUES(1);
INSERT INTO member(mem_no) VALUES(2);
INSERT INTO member(mem_no) VALUES(3);

INSERT INTO categrp(categrpno) VALUES(1);
INSERT INTO categrp(categrpno) VALUES(2);
INSERT INTO categrp(categrpno) VALUES(3);

2. ���(INSERT)
INSERT INTO category(categoryno, categrpno, mem_no, ntitle, nseqno, nvisible, nids, rdate)
VALUES((SELECT NVL(MAX(categoryno), 0)+1 as categoryno FROM category), 1, 1, '�Ｚ', 1, 'Y', 'ad', sysdate);

INSERT INTO category(categoryno, categrpno, mem_no, ntitle, nseqno, nvisible, nids, rdate)
VALUES((SELECT NVL(MAX(categoryno), 0)+1 as categoryno FROM category), 2, 2, '����', 1, 'Y', 'ad', sysdate);

INSERT INTO category(categoryno, categrpno, mem_no, ntitle, nseqno, nvisible, nids, rdate)
VALUES((SELECT NVL(MAX(categoryno), 0)+1 as categoryno FROM category), 3, 3, 'LG', 1, 'Y', 'ad', sysdate);

3. ���(SELECT)
SELECT categoryno, categrpno, ntitle, nseqno, nvisible, nids, rdate
FROM category  
ORDER BY categrpno ASC, nseqno ASC;

4. ��ȸ
SELECT categoryno, categrpno, ntitle, nseqno, nvisible, nids
FROM category 
WHERE categoryno=1;

5. ����(UPDATE)
UPDATE category
SET ntitle='����', nseqno=1, nvisible='N', nids='admin1/user1/user2'
WHERE categoryno=1;
   
6. ī�װ���ȣ�� ����(DELETE)
DELETE FROM category
WHERE categrpno = 7;

