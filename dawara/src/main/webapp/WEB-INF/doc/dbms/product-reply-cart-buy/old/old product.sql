��ǰ +-- ���(+����)
       +-- �Խñ� ��ü ���
       +-- ī�װ��� ���
       +-- ��ü ���ڵ� ����
       +-- �Ѱ��� ���ڵ� ��ȸ
       +-- ��ȸ��
       +-- ����
       +-- ����
       +-- �˻�(�ֽż�, ����, ��������, ����Ŀ)
       +-- category�� �˻�
       +-- �ŷ���û 
              +-- �ŷ� ����
       +-- ����¡
       +-- �ǸſϷ�(pr_visible)
       
CREATE TABLE category (
  gory_no       NUMBER(6) NOT NULL, -- ī�װ� ��ȣ, ���ڵ带 �����ϴ� �÷� 
  PRIMARY KEY (gory_no)                  -- �ѹ� ��ϵ� ���� �ߺ� �ȵ�
);


COMMENT ON TABLE category is 'ī�װ�';
COMMENT ON COLUMN category.gory_no is 'ī�װ���ȣ ��ȣ';

DROP TABLE category; -- ī�װ� ����

CREATE TABLE member (
  mem_no       NUMBER(6) NOT NULL, -- ��� ��ȣ, ���ڵ带 �����ϴ� �÷� 
  PRIMARY KEY (mem_no)                  -- �ѹ� ��ϵ� ���� �ߺ� �ȵ�
);

INSERT INTO member(mem_no)
VALUES((SELECT NVL(MAX(mem_no), 0) + 1 as mem_no FROM member));

COMMENT ON TABLE member is 'ȸ��';
COMMENT ON COLUMN member.mem_no is 'ȸ�� ��ȣ';

DROP TABLE member; --��� ����

/**********************************/
/* Table Name: product ���� */
/**********************************/

-- product�����
CREATE TABLE product (
        pr_no          NUMBER(7)        NOT NULL        PRIMARY KEY,
        gory_no         NUMBER(7)        NULL ,
        mem_no                  NUMBER(6)        NULL ,
        pr_maker                VARCHAR2(300)  DEFAULT '�Ｚ'        NULL,
        pr_prname                   VARCHAR2(300)        NULL,
        pr_title                   VARCHAR2(300)        NOT NULL,
        pr_contents        CLOB               null,
        pr_thumbs              VARCHAR2(1000)                             NULL ,
        pr_files                   VARCHAR2(1000)                            NULL ,
        pr_sizes                  VARCHAR2(1000)                            NULL ,
        pr_cnt                    NUMBER(7)        DEFAULT 0       NOT NULL,
        pr_rdate                  DATE                                      NOT NULL,
        pr_year                  DATE                                           NULL,
        pr_word                  VARCHAR2(100)                              NULL,
        pr_price                  NUMBER(10)      DEFAULT 0       NOT NULL,
        pr_visible                 CHAR(1)            DEFAULT 'Y'      NOT NULL,     
        pr_payment                 CHAR(1)            DEFAULT 'N'      NOT NULL,     --N(no), Y(yes), I(ing)
  FOREIGN KEY (gory_no) REFERENCES category (gory_no),
  FOREIGN KEY (mem_no) REFERENCES member (mem_no)
);

ALTER TABLE MEMBER ADD mem_mile NUMBER(9); --mem_mile �÷� �߰�
ALTER TABLE PRODUCT ADD pr_contents CLOB  null; --mem_mile �÷� �߰�
ALTER TABLE PRODUCT ADD pr_prname  VARCHAR2(300) NULL; --mem_mile �÷� �߰�
ALTER TABLE PRODUCT ADD pr_maker  VARCHAR2(300)  DEFAULT'�Ｚ' NOT NULL; --mem_mile �÷� �߰�
ALTER TABLE MEMBER RENAME COLUMN mem_rdate TO mem_date;
ALTER TABLE MEMBER RENAME COLUMN authno TO auth_no;
ALTER TABLE PRODUCT RENAME COLUMN pr_buyyear TO pr_year;
ALTER TABLE MEMBER DROP COLUMN MEM_ACT;
ALTER TABLE PRODUCT DROP COLUMN pr_contents;
ALTER TABLE PRODUCT DROP COLUMN pr_maker;
ALTER TABLE PRODUCT ADD pr_buyprice  NUMBER(10)      DEFAULT 0       NOT NULL;


DROP TABLE product; 

  
COMMENT ON TABLE product is '��ǰ';
COMMENT ON COLUMN product.pr_no is '��ǰ ��ȣ';
COMMENT ON COLUMN product.gory_no is 'ī�װ���ȣ';
COMMENT ON COLUMN product.mem_no is 'ȸ�� ��ȣ';
COMMENT ON COLUMN product.pr_maker is '�귣���';
COMMENT ON COLUMN product.pr_prname, is '��ǰ��';
COMMENT ON COLUMN product.pr_title is '����';
COMMENT ON COLUMN product.pr_contents is '����';
COMMENT ON COLUMN product.pr_thumbs is 'thumbs ����';
COMMENT ON COLUMN product.pr_files is '���ϵ��� �̸�';
COMMENT ON COLUMN product.pr_sizes is '���ϵ��� ũ��';
COMMENT ON COLUMN product.pr_cnt is '��ȸ��';
COMMENT ON COLUMN product.pr_year is '���� �ñ�';
COMMENT ON COLUMN product.pr_rdate is '�����';
COMMENT ON COLUMN product.pr_word is '�˻���';
COMMENT ON COLUMN product.pr_price is '����';
COMMENT ON COLUMN product.pr_visible is '��� ����';
COMMENT ON COLUMN product.pr_payment is '����';


1) ī�װ�(category) ���� ���̺� ����
-- ī�װ� ���̺��� FK �÷����� ���������� �ӽ÷� �����մϴ�.
-- ���̺��, PK �÷����� ����� ������ ���� ����մϴ�.
INSERT INTO category(gory_no) VALUES(1);
INSERT INTO category(gory_no) VALUES(2);
INSERT INTO category(gory_no) VALUES(3);

2) ȸ��(category) ���� ���̺� ����
-- ȸ�� ���̺��� FK �÷����� ���������� �ӽ÷� �����մϴ�.
-- ���̺��, PK �÷����� ����� ������ ���� ����մϴ�.
INSERT INTO member(mem_no) VALUES(1);
INSERT INTO member(mem_no) VALUES(2);
INSERT INTO member(mem_no) VALUES(3);

3) product ���             
-- product ���� ���
- ���ο� ��, �亯 �ۿ����� ��� SQL���̰� �ֽ��ϴ�.
- ���ο� �� ����� ���ο� �׷��� ��������� ����� �ֽ��ϴ�. MAX + 1
- gory_no �÷� 1�� ����
- mem_no �÷� 1�� ����

INSERT INTO product(pr_no, 
                  gory_no, mem_no, pr_maker, pr_prname, pr_title, pr_contents,  pr_thumbs, pr_files,
                  pr_sizes, pr_cnt,  pr_year, pr_rdate, 
                  pr_word, pr_price, pr_visible, pr_payment)  
VALUES((SELECT NVL(MAX(pr_no), 0) + 1 as pr_no FROM product), 
            1, 1,'�Ｚ', '�Ｚ ��Ʈ��',  '����', '����', 'summber_m.jpg', 'summber.jpg',
            0, 0, '2017-01-01', sysdate,
            '������,spring,��,��,����,����,������', 1000, 'Y', 'N');        

       
            
4) ��ü ���(��� ����)

select * from product;


SELECT pr_no, 
           gory_no, mem_no, pr_maker, pr_prname, pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt,  pr_year, pr_rdate, 
           pr_word, pr_price,  pr_visible, pr_payment
FROM product;

 PR_NO GORY_NO MEM_NO PR_MAKER PR_PRNAME PR_TITLE PR_CONTENTS PR_THUMBS     PR_FILES    PR_SIZES PR_CNT PR_YEAR               PR_RDATE              PR_WORD                  PR_PRICE PR_VISIBLE PR_PAYMENT
 ----- ------- ------ -------- --------- -------- ----------- ------------- ----------- -------- ------ --------------------- --------------------- ------------------------ -------- ---------- ----------
     1       1      1 �Ｚ       NULL      �ܿ�       NULL        snow_t.jpg    snow.jpg    1500          0 2017-01-01 00:00:00.0 2018-06-18 12:58:01.0 �ް�                           1000 Y          N
     2       1      1 �Ｚ       NULL      ����       NULL        summber_m.jpg summber.jpg 0             0 2017-01-01 00:00:00.0 2018-06-18 13:03:57.0 ������,spring,��,��,����,����,������     1000 N          Y
     3       1      1 �Ｚ       �Ｚ ��Ʈ��    ����       ����          summber_m.jpg summber.jpg 0             0 2017-01-01 00:00:00.0 2018-06-21 11:59:12.0 ������,spring,��,��,����,����,������     1000 Y          N

     
SELECT pr_no, 
           gory_no, mem_no, pr_maker, pr_prname, pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt,  pr_year, pr_rdate, 
           pr_word, pr_price,  pr_visible, pr_payment
FROM product
WHERE pr_no = 1;

5) category �� ���(��� ����)
SELECT pr_no,
           gory_no, mem_no, pr_maker, pr_prname, pr_title, pr_contents, pr_thumbs, pr_files, pr_sizes, pr_cnt,  pr_year, pr_rdate,  pr_word
FROM product
WHERE gory_no=1
ORDER BY pr_no;

 PR_NO GORY_NO MEM_NO PR_MAKER PR_TITLE PR_CONTENTS PR_THUMBS     PR_FILES    PR_SIZES PR_CNT PR_YEAR               PR_RDATE              PR_WORD
 ----- ------- ------ -------- -------- ----------- ------------- ----------- -------- ------ --------------------- --------------------- ------------------------
     1       1      1 �Ｚ       ����       ����          summber_m.jpg summber.jpg 0             0 2017-01-01 00:00:00.0 2018-06-18 12:58:01.0 ������,spring,��,��,����,����,������

6) ��ü ī��Ʈ
SELECT COUNT(*) as count
FROM product;      

 COUNT
 -----
     1
     
7)��ȸ
SELECT pr_no, 
           gory_no, mem_no, pr_maker, pr_prname, pr_title, pr_contents, pr_thumbs, pr_files, pr_sizes, pr_cnt,  pr_year, pr_rdate,  pr_word
FROM product
WHERE pr_no=1; 

 PR_NO GORY_NO MEM_NO PR_MAKER PR_TITLE PR_CONTENTS PR_THUMBS     PR_FILES    PR_SIZES PR_CNT PR_YEAR               PR_RDATE              PR_WORD
 ----- ------- ------ -------- -------- ----------- ------------- ----------- -------- ------ --------------------- --------------------- ------------------------
     1       1      1 �Ｚ       ����       ����          summber_m.jpg summber.jpg 0             0 2017-01-01 00:00:00.0 2018-06-18 12:58:01.0 ������,spring,��,��,����,����,������

8)����
UPDATE product
SET pr_title='�ܿ�', pr_contents='���̽÷���...',
     pr_thumbs='snow_t.jpg', pr_files='snow.jpg', pr_sizes=1500, pr_word='�ް�'
WHERE pr_no=1;

9) ����
DELETE FROM product
WHERE pr_no=1

10) �˻�(%: ���ų� �ϳ� �̻��� ��� ����)
-- pr_word LIKE '������' �� pr_word = '������'
   ^������$
-- pr_word LIKE '%������' �� pr_word = '���� ���� ������'
   .*������$
-- pr_word LIKE '������%' �� pr_word = '����������~'
   ^������.*
-- pr_word LIKE '%������%' �� pr_word = '���� ������ ������ �� �湮�ؾ�~'
   .*������.*
   
   -- '������' �÷����� �˻�
SELECT pr_no, 
          gory_no, pr_maker, pr_prname, mem_no, pr_title, pr_thumbs, pr_files, pr_sizes, pr_cnt,  pr_year, pr_rdate, pr_word
FROM product
WHERE gory_no=1 AND pr_word LIKE '%������%'
ORDER BY pr_no DESC;

 PR_NO GORY_NO PR_MAKER MEM_NO PR_TITLE PR_THUMBS     PR_FILES    PR_SIZES PR_CNT PR_YEAR               PR_RDATE              PR_WORD
 ----- ------- -------- ------ -------- ------------- ----------- -------- ------ --------------------- --------------------- ------------------------
     2       1 �Ｚ            1 ����       summber_m.jpg summber.jpg 0             0 2017-01-01 00:00:00.0 2018-06-18 13:03:57.0 ������,spring,��,��,����,����,������


11) �˻� �� ��ü ���ڵ� ����
-- gory_no �÷��� 1���̸� �˻����� �ʴ� ��� ���ڵ� ����
SELECT COUNT(*) as pr_cnt
FROM product
WHERE gory_no=1;

 PR_CNT
 ------
      1



-- '������' �˻� ���ڵ� ����
SELECT COUNT(*) as pr_cnt
FROM product
WHERE  gory_no=1 AND pr_word LIKE '%����%';

 PR_CNT
 ------
      15
SELECT COUNT(*) as pr_cnt
 FROM product
        WHERE gory_no=1 AND pr_word LIKE '%������%';
        
         PR_CNT
 ------
      2

      


12)����¡
SELECT pr_no,  gory_no, pr_maker, pr_prname, pr_title, pr_contents, pr_thumbs, pr_files, pr_sizes, pr_cnt,
           pr_year, pr_rdate, pr_word, r
FROM(
         SELECT pr_no,  gory_no, pr_maker, pr_prname, pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt,
                    pr_year,  pr_rdate, pr_word, rownum as r
         FROM(
                  SELECT pr_no,  gory_no, pr_maker, pr_prname, pr_title, pr_contents,pr_thumbs, pr_files, pr_sizes, pr_cnt,
                             pr_year, pr_rdate, pr_word
                  FROM product
                  WHERE gory_no=1
                  ORDER BY pr_no DESC
         )
)
WHERE r >=1 AND r <= 3;

 PR_NO GORY_NO PR_MAKER PR_TITLE PR_CONTENTS PR_THUMBS     PR_FILES    PR_SIZES PR_CNT PR_YEAR               PR_RDATE              PR_WORD                  R
 ----- ------- -------- -------- ----------- ------------- ----------- -------- ------ --------------------- --------------------- ------------------------ -
     2       1 �Ｚ       ����       ����          summber_m.jpg summber.jpg 0             0 2017-01-01 00:00:00.0 2018-06-18 13:03:57.0 ������,spring,��,��,����,����,������ 1
     1       1 �Ｚ       �ܿ�       ���̽÷���...    snow_t.jpg    snow.jpg    1500          0 2017-01-01 00:00:00.0 2018-06-18 12:58:01.0 �ް�                       2

-- �˻�        
SELECT pr_no,  gory_no, pr_maker, pr_prname, pr_title, pr_contents, pr_thumbs, pr_files, pr_sizes, pr_cnt,
           pr_year, pr_rdate, pr_word, r
FROM(
         SELECT pr_no,  gory_no, pr_maker, pr_prname, pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt,
                    pr_year, pr_rdate, pr_word, rownum as r
         FROM(
                  SELECT pr_no,  gory_no, pr_maker, pr_prname, pr_title, pr_contents, pr_thumbs, pr_files, pr_sizes, pr_cnt,
                             pr_year, pr_rdate, pr_word
                  FROM product
                  WHERE gory_no=1 AND pr_word LIKE '%������%'
                  ORDER BY pr_no DESC
         )
)
WHERE r >=1 AND r <= 3;

 PR_NO GORY_NO PR_MAKER PR_TITLE PR_CONTENTS PR_THUMBS     PR_FILES    PR_SIZES PR_CNT PR_YEAR               PR_RDATE              PR_WORD                  R
 ----- ------- -------- -------- ----------- ------------- ----------- -------- ------ --------------------- --------------------- ------------------------ -
     2       1 �Ｚ       ����       ����          summber_m.jpg summber.jpg 0             0 2017-01-01 00:00:00.0 2018-06-18 13:03:57.0 ������,spring,��,��,����,����,������ 1


-- �������� �˻�        
SELECT pr_no,  gory_no, pr_maker, pr_prname, pr_title, pr_contents, pr_thumbs, pr_files, pr_sizes, pr_cnt,
           pr_year, pr_rdate, pr_word, r
FROM(
         SELECT pr_no,  gory_no, pr_maker, pr_prname, pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt,
                    pr_year, pr_rdate, pr_word, rownum as r
         FROM(
                  SELECT pr_no,  gory_no, pr_maker, pr_prname, pr_title, pr_contents, pr_thumbs, pr_files, pr_sizes, pr_cnt,
                             pr_year, pr_rdate, pr_word
                  FROM product
                  WHERE gory_no=1 AND pr_title LIKE '%����%'
                  ORDER BY pr_no DESC
         )
)
WHERE r >=1 AND r <= 3;



 PR_NO GORY_NO PR_MAKER PR_TITLE PR_CONTENTS PR_THUMBS     PR_FILES    PR_SIZES PR_CNT PR_YEAR               PR_RDATE              PR_WORD                  R
 ----- ------- -------- -------- ----------- ------------- ----------- -------- ------ --------------------- --------------------- ------------------------ -
     2       1 �Ｚ       ����       ����          summber_m.jpg summber.jpg 0             0 2017-01-01 00:00:00.0 2018-06-18 13:03:57.0 ������,spring,��,��,����,����,������ 1



      
select substr(pr_rdate,0,2) from product;
(to_char)???

-- ���ǳ⵵�� �˻�        
SELECT pr_no,  gory_no, pr_maker, pr_prname, pr_title, pr_contents, pr_thumbs, pr_files, pr_sizes, pr_cnt,
           pr_year, pr_rdate, pr_word, r
FROM(
         SELECT pr_no,  gory_no, pr_maker, pr_prname, pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt,
                    pr_year, pr_rdate, pr_word, rownum as r
         FROM(
                  SELECT pr_no,  gory_no, pr_maker, pr_prname, pr_title, pr_contents, pr_thumbs, pr_files, pr_sizes, pr_cnt,
                             pr_year, pr_rdate, pr_word
                  FROM product
                  WHERE gory_no=1 
                  ORDER BY pr_year DESC
         )
)
WHERE r >=1 AND r <= 3;


-- �귣������� �˻�        
SELECT pr_no,  gory_no, pr_maker, pr_prname, pr_title, pr_contents, pr_thumbs, pr_files, pr_sizes, pr_cnt,
           pr_year, pr_rdate, pr_word, r
FROM(
         SELECT pr_no,  gory_no, pr_maker, pr_prname, pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt,
                    pr_year, pr_rdate, pr_word, rownum as r
         FROM(
                  SELECT pr_no,  gory_no, pr_maker, pr_prname, pr_title, pr_contents, pr_thumbs, pr_files, pr_sizes, pr_cnt,
                             pr_year, pr_rdate, pr_word
                  FROM product
                  WHERE gory_no=1 AND pr_maker='�Ｚ'
                  ORDER BY pr_no DESC
         )
)
WHERE r >=1 AND r <= 3;
 PR_NO GORY_NO PR_MAKER PR_TITLE PR_CONTENTS PR_THUMBS     PR_FILES    PR_SIZES PR_CNT PR_YEAR               PR_RDATE              PR_WORD                  R
 ----- ------- -------- -------- ----------- ------------- ----------- -------- ------ --------------------- --------------------- ------------------------ -
     2       1 �Ｚ       ����       ����          summber_m.jpg summber.jpg 0             0 2017-01-01 00:00:00.0 2018-06-18 13:03:57.0 ������,spring,��,��,����,����,������ 1
     1       1 �Ｚ       �ܿ�       ���̽÷���...    snow_t.jpg    snow.jpg    1500          0 2017-01-01 00:00:00.0 2018-06-18 12:58:01.0 �ް�                       2


-- �������� �˻�        
SELECT pr_no,  gory_no, pr_maker, pr_prname, pr_title, pr_contents, pr_thumbs, pr_files, pr_sizes, pr_cnt,
           pr_year, pr_rdate, pr_word, r
FROM(
         SELECT pr_no,  gory_no, pr_maker, pr_prname, pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt,
                    pr_year, pr_rdate, pr_word, rownum as r
         FROM(
                  SELECT pr_no,  gory_no, pr_maker, pr_prname, pr_title, pr_contents, pr_thumbs, pr_files, pr_sizes, pr_cnt,
                             pr_year, pr_rdate, pr_word
                  FROM product
                  WHERE gory_no=1 
                  ORDER BY pr_price DESC
         )
)
WHERE r >=1 AND r <= 3;

 PR_NO GORY_NO PR_MAKER PR_TITLE PR_CONTENTS PR_THUMBS     PR_FILES    PR_SIZES PR_CNT PR_YEAR               PR_RDATE              PR_WORD                  R
 ----- ------- -------- -------- ----------- ------------- ----------- -------- ------ --------------------- --------------------- ------------------------ -
     2       1 �Ｚ       ����       ����          summber_m.jpg summber.jpg 0             0 2017-01-01 00:00:00.0 2018-06-18 13:03:57.0 ������,spring,��,��,����,����,������ 1
     1       1 �Ｚ       �ܿ�       ���̽÷���...    snow_t.jpg    snow.jpg    1500          0 2017-01-01 00:00:00.0 2018-06-18 12:58:01.0 �ް�                       2



      
13)�ǸſϷ�(pr_visible)
UPDATE product
SET pr_payment='Y',pr_visible='N'
WHERE pr_no=2;

SELECT pr_no, 
           gory_no, mem_no, pr_maker, pr_prname, pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt,  pr_year, pr_rdate, 
           pr_word, pr_price,  pr_visible, pr_payment, pr_visible
FROM product;

 PR_NO GORY_NO MEM_NO PR_MAKER PR_TITLE PR_CONTENTS PR_THUMBS     PR_FILES    PR_SIZES PR_CNT PR_YEAR               PR_RDATE              PR_WORD                  PR_PRICE PR_VISIBLE PR_PAYMENT PR_VISIBLE
 ----- ------- ------ -------- -------- ----------- ------------- ----------- -------- ------ --------------------- --------------------- ------------------------ -------- ---------- ---------- ----------
     1       1      1 �Ｚ       �ܿ�       ���̽÷���...    snow_t.jpg    snow.jpg    1500          0 2017-01-01 00:00:00.0 2018-06-18 12:58:01.0 �ް�                           1000 Y          N          Y
     2       1      1 �Ｚ       ����       ����          summber_m.jpg summber.jpg 0             0 2017-01-01 00:00:00.0 2018-06-18 13:03:57.0 ������,spring,��,��,����,����,������     1000 N          Y          N




            
     




       
