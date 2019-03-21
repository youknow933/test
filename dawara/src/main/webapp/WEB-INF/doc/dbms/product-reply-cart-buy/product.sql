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
       
/**********************************/
/* Table Name: product ���� */
/**********************************/

-- product�����
CREATE TABLE product (
        pr_no          NUMBER(7)        NOT NULL        PRIMARY KEY,
        gory_no         NUMBER(7)        NULL ,
        mem_no                  NUMBER(6)        NULL ,
        pr_title                   VARCHAR2(300)        NOT NULL,
        pr_contents        CLOB               null,
        pr_thumbs              VARCHAR2(1000)                             NULL ,
        pr_files                   VARCHAR2(1000)                            NULL ,
        pr_sizes                  VARCHAR2(1000)                            NULL ,
        pr_cnt                    NUMBER(7)        DEFAULT 0       NOT NULL,
        pr_rdate                  DATE                                      NOT NULL,
        pr_buyyear                  DATE                                           NULL,
        pr_state      VARCHAR2(1000)        DEFAULT '�߰�'       NULL ,       --'����ǰ', '�߰�'
        pr_transaction      VARCHAR2(1000)        DEFAULT '���ŷ�'       NULL ,  --'���ŷ�', '�ù�'
        pr_local      VARCHAR2(1000)             NULL ,
        pr_buyprice                  NUMBER(10)      DEFAULT 0       NOT NULL,
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
ALTER TABLE PRODUCT RENAME COLUMN pr_buyyear TO pr_buyyear;
ALTER TABLE MEMBER DROP COLUMN MEM_ACT;
ALTER TABLE PRODUCT DROP COLUMN pr_contents;
ALTER TABLE PRODUCT DROP COLUMN pr_maker;
ALTER TABLE PRODUCT ADD pr_buyprice  NUMBER(10)      DEFAULT 0       NOT NULL;


DROP TABLE product; 

  
COMMENT ON TABLE product is '��ǰ';
COMMENT ON COLUMN product.pr_no is '��ǰ ��ȣ';
COMMENT ON COLUMN product.gory_no is 'ī�װ���ȣ';
COMMENT ON COLUMN product.mem_no is 'ȸ�� ��ȣ';
COMMENT ON COLUMN product.pr_title is '����';
COMMENT ON COLUMN product.pr_contents is '����';
COMMENT ON COLUMN product.pr_thumbs is 'thumbs ����';
COMMENT ON COLUMN product.pr_files is '���ϵ��� �̸�';
COMMENT ON COLUMN product.pr_sizes is '���ϵ��� ũ��';
COMMENT ON COLUMN product.pr_cnt is '��ȸ��';
COMMENT ON COLUMN product.pr_buyyear is '���� �ñ�';
COMMENT ON COLUMN product.pr_rdate is '�����';
COMMENT ON COLUMN product.pr_state is '��ǰ ����';
COMMENT ON COLUMN product.pr_transaction is '�ŷ� ���';
COMMENT ON COLUMN product.pr_local is '�ŷ� ����';
COMMENT ON COLUMN product.pr_buyprice is '���� ����';
COMMENT ON COLUMN product.pr_price is '�Ǹ� ����';
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
                  gory_no, mem_no, pr_title, pr_contents,  pr_thumbs, pr_files,
                  pr_sizes, pr_cnt,  pr_buyyear, pr_rdate, pr_state, pr_transaction, pr_local,  
                  pr_buyprice, pr_price, pr_visible, pr_payment)  
VALUES((SELECT NVL(MAX(pr_no), 0) + 1 as pr_no FROM product), 
            1, 1, '����', '����', 'summber_m.jpg', 'summber.jpg',
            0, 0, '2017-01-01', sysdate, '�߰�', '���ŷ�', '����',
            1000 , 1000, 'Y', 'N');        

       
            
4) ��ü ���(��� ����)

select * from product;


SELECT pr_no, 
           gory_no, mem_no,  pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, 
           pr_cnt,  pr_buyyear, pr_rdate, pr_state, pr_transaction, pr_local,  
           pr_buyprice, pr_price,  pr_visible, pr_payment
FROM product;

 PR_NO GORY_NO MEM_NO PR_TITLE PR_CONTENTS PR_THUMBS     PR_FILES    PR_SIZES PR_CNT PR_BUYYEAR            PR_RDATE              PR_STATE PR_TRANSACTION PR_LOCAL PR_BUYPRICE PR_PRICE PR_VISIBLE PR_PAYMENT
 ----- ------- ------ -------- ----------- ------------- ----------- -------- ------ --------------------- --------------------- -------- -------------- -------- ----------- -------- ---------- ----------
     1       1      1 ����       ����          summber_m.jpg summber.jpg 0             0 2017-01-01 00:00:00.0 2018-06-26 17:45:13.0 �߰�       ���ŷ�            ����              1000     1000 Y          N

     
SELECT pr_no, 
           gory_no, mem_no,  pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt,  pr_buyyear, pr_rdate, pr_state, pr_transaction, pr_local,  
           pr_buyprice, pr_price,  pr_visible, pr_payment
FROM product
WHERE pr_no = 1;

5) category �� ���(��� ����)
SELECT pr_no, 
           gory_no, mem_no,  pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt,  pr_buyyear, pr_rdate, pr_state, pr_transaction, pr_local,  
           pr_buyprice, pr_price,  pr_visible, pr_payment
FROM product
WHERE gory_no=1
ORDER BY pr_no;

 PR_NO GORY_NO MEM_NO PR_TITLE PR_CONTENTS PR_THUMBS     PR_FILES    PR_SIZES PR_CNT PR_BUYYEAR            PR_RDATE              PR_STATE PR_TRANSACTION PR_LOCAL PR_BUYPRICE PR_PRICE PR_VISIBLE PR_PAYMENT
 ----- ------- ------ -------- ----------- ------------- ----------- -------- ------ --------------------- --------------------- -------- -------------- -------- ----------- -------- ---------- ----------
     1       1      1 ����       ����          summber_m.jpg summber.jpg 0             0 2017-01-01 00:00:00.0 2018-06-26 17:45:13.0 �߰�       ���ŷ�            ����              1000     1000 Y          N

6) ��ü ī��Ʈ
SELECT COUNT(*) as count
FROM product;      

 COUNT
 -----
     1
     
7)��ȸ
SELECT pr_no, 
           gory_no, mem_no,  pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt, 
           pr_buyyear, pr_rdate, pr_state, pr_transaction, pr_local,  
           pr_buyprice, pr_price,  pr_visible, pr_payment
FROM product
WHERE pr_no=1

 PR_NO GORY_NO MEM_NO PR_TITLE PR_CONTENTS PR_THUMBS     PR_FILES    PR_SIZES PR_CNT PR_BUYYEAR            PR_RDATE              PR_STATE PR_TRANSACTION PR_LOCAL PR_BUYPRICE PR_PRICE PR_VISIBLE PR_PAYMENT
 ----- ------- ------ -------- ----------- ------------- ----------- -------- ------ --------------------- --------------------- -------- -------------- -------- ----------- -------- ---------- ----------
     1       1      1 ����       ����          summber_m.jpg summber.jpg 0             0 2017-01-01 00:00:00.0 2018-06-26 17:45:13.0 �߰�       ���ŷ�            ����              1000     1000 Y          N

8)����
UPDATE product
SET pr_title='�ܿ�', pr_contents='���̽÷���...',
     pr_thumbs='snow_t.jpg', pr_files='snow.jpg', pr_sizes=1500, pr_buyyear= '2017-01-01',
     pr_price=1500, pr_transaction = '�ù�', pr_local='����/����'
WHERE pr_no=1;

  UPDATE product
    SET pr_title=#{pr_title}, pr_contents=#{pr_contents:VARCHAR},
          pr_thumbs=#{pr_thumbs}, files=#{files}, pr_sizes=#{sizes},  pr_buyyear=#{pr_buyyear}, 
            pr_price=#{pr_price}, pr_transaction = #{pr_transaction}, pr_local=#{pr_local}
    WHERE pr_no=#{pr_no}

9) ����
DELETE FROM product
WHERE pr_no=1

select * from product
where mem_no=2 and pr_visible='N'

delete from reply
10) �˻�(%: ���ų� �ϳ� �̻��� ��� ����)
-- pr_word LIKE '������' �� pr_word = '������'
   ^������$
-- pr_word LIKE '%������' �� pr_word = '���� ���� ������'
   .*������$
-- pr_word LIKE '������%' �� pr_word = '����������~'
   ^������.*
-- pr_title LIKE '%�ܿ�%' �� pr_word = '���� ������ ������ �� �湮�ؾ�~'
   .*������.*
   
   -- '������' �÷����� �˻�
SELECT pr_no, 
           gory_no, mem_no,  pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt, 
           pr_buyyear, pr_rdate, pr_state, pr_transaction, pr_local,  
           pr_buyprice, pr_price,  pr_visible, pr_payment
 FROM product
WHERE gory_no=1 AND pr_title LIKE '%�ܿ�%'
ORDER BY pr_no DESC;

 PR_NO GORY_NO MEM_NO PR_TITLE PR_CONTENTS PR_THUMBS  PR_FILES PR_SIZES PR_CNT PR_BUYYEAR            PR_RDATE              PR_STATE PR_TRANSACTION PR_LOCAL PR_BUYPRICE PR_PRICE PR_VISIBLE PR_PAYMENT
 ----- ------- ------ -------- ----------- ---------- -------- -------- ------ --------------------- --------------------- -------- -------------- -------- ----------- -------- ---------- ----------
     1       1      1 �ܿ�       ���̽÷���...    snow_t.jpg snow.jpg 1500          0 2017-01-01 00:00:00.0 2018-06-26 17:45:13.0 �߰�       �ù�             ����              1000     1500 Y          N


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
WHERE  gory_no=1 AND pr_title LIKE '%�ܿ�%';

 PR_CNT
 ------
      1
      
SELECT COUNT(*) as pr_cnt
 FROM product
        WHERE gory_no=1 AND pr_title LIKE '%�ܿ�%';
        
 PR_CNT
 ------
      1


      
SELECT pr_no, 
           gory_no, mem_no,  pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt, 
           pr_buyyear, pr_rdate, pr_state, pr_transaction, pr_local,  
           pr_buyprice, pr_price,  pr_visible, pr_payment
      
      

12)����¡
SELECT pr_no, 
           gory_no, mem_no,  pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt, 
           pr_buyyear, pr_rdate, pr_state, pr_transaction, pr_local,  
           pr_buyprice, pr_price,  pr_visible, pr_payment, r
FROM(
       SELECT pr_no, 
           gory_no, mem_no,  pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt, 
           pr_buyyear, pr_rdate, pr_state, pr_transaction, pr_local,  
           pr_buyprice, pr_price,  pr_visible, pr_payment, rownum as r
         FROM(
                  SELECT pr_no, 
                  gory_no, mem_no,  pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt, 
                  pr_buyyear, pr_rdate, pr_state, pr_transaction, pr_local,  
                  pr_buyprice, pr_price,  pr_visible, pr_payment
                  FROM product
                  WHERE gory_no=1
                  ORDER BY pr_no DESC
         )
)
WHERE r >=1 AND r <= 3;

 PR_NO GORY_NO MEM_NO PR_TITLE PR_CONTENTS PR_THUMBS  PR_FILES PR_SIZES PR_CNT PR_BUYYEAR            PR_RDATE              PR_STATE PR_TRANSACTION PR_LOCAL PR_BUYPRICE PR_PRICE PR_VISIBLE PR_PAYMENT R
 ----- ------- ------ -------- ----------- ---------- -------- -------- ------ --------------------- --------------------- -------- -------------- -------- ----------- -------- ---------- ---------- -
     1       1      1 �ܿ�       ���̽÷���...    snow_t.jpg snow.jpg 1500          0 2017-01-01 00:00:00.0 2018-06-26 17:45:13.0 �߰�       �ù�             ����              1000     1500 Y          N          1


-- �˻�        
SELECT pr_no, 
           gory_no, mem_no,  pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt, 
           pr_buyyear, pr_rdate, pr_state, pr_transaction, pr_local,  
           pr_buyprice, pr_price,  pr_visible, pr_payment, r
FROM(
       SELECT pr_no, 
           gory_no, mem_no,  pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt, 
           pr_buyyear, pr_rdate, pr_state, pr_transaction, pr_local,  
           pr_buyprice, pr_price,  pr_visible, pr_payment, rownum as r
         FROM(
                  SELECT pr_no, 
                  gory_no, mem_no,  pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt, 
                  pr_buyyear, pr_rdate, pr_state, pr_transaction, pr_local,  
                  pr_buyprice, pr_price,  pr_visible, pr_payment
                  FROM product
                  WHERE gory_no=1 AND pr_title LIKE '%�Ｚ%' AND pr_visible='N'
                  ORDER BY pr_no DESC
         )
)
WHERE r >=1 AND r <= 3;

-- ����� �˻�
SELECT pr_no, 
           gory_no, mem_no,  pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt, 
           pr_buyyear, pr_rdate, pr_state, pr_transaction, pr_local,  
           pr_buyprice, pr_price,  pr_visible, pr_payment, r
FROM(
       SELECT pr_no, 
           gory_no, mem_no,  pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt, 
           pr_buyyear, pr_rdate, pr_state, pr_transaction, pr_local,  
           pr_buyprice, pr_price,  pr_visible, pr_payment, rownum as r
         FROM(
                  SELECT pr_no, 
                  gory_no, mem_no,  pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt, 
                  pr_buyyear, pr_rdate, pr_state, pr_transaction, pr_local,  
                  pr_buyprice, pr_price,  pr_visible, pr_payment
                  FROM product
                  WHERE  mem_no=1 
                  ORDER BY pr_no DESC
         )
)
WHERE r >=1 AND r <= 3;


 PR_NO GORY_NO MEM_NO PR_TITLE PR_CONTENTS PR_THUMBS  PR_FILES PR_SIZES PR_CNT PR_BUYYEAR            PR_RDATE              PR_STATE PR_TRANSACTION PR_LOCAL PR_BUYPRICE PR_PRICE PR_VISIBLE PR_PAYMENT R
 ----- ------- ------ -------- ----------- ---------- -------- -------- ------ --------------------- --------------------- -------- -------------- -------- ----------- -------- ---------- ---------- -
     1       1      1 �ܿ�       ���̽÷���...    snow_t.jpg snow.jpg 1500          0 2017-01-01 00:00:00.0 2018-06-26 17:45:13.0 �߰�       �ù�             ����              1000     1500 Y          N          1

      
13)�ǸſϷ�(pr_visible)
UPDATE product
SET pr_visible='N'
WHERE pr_no=2;

SELECT pr_no, 
           gory_no, mem_no,  pr_title, pr_contents,  pr_thumbs, pr_files, pr_sizes, pr_cnt, 
           pr_buyyear, pr_rdate, pr_state, pr_transaction, pr_local,  
           pr_buyprice, pr_price,  pr_visible, pr_payment
FROM product;

 PR_NO GORY_NO MEM_NO PR_TITLE PR_CONTENTS PR_THUMBS  PR_FILES PR_SIZES PR_CNT PR_BUYYEAR            PR_RDATE              PR_STATE PR_TRANSACTION PR_LOCAL PR_BUYPRICE PR_PRICE PR_VISIBLE PR_PAYMENT
 ----- ------- ------ -------- ----------- ---------- -------- -------- ------ --------------------- --------------------- -------- -------------- -------- ----------- -------- ---------- ----------
     1       1      1 �ܿ�       ���̽÷���...    snow_t.jpg snow.jpg 1500          0 2017-01-01 00:00:00.0 2018-06-26 17:45:13.0 �߰�       �ù�             ����              1000     1500 N          Y

SELECT *
FROM product
WHERE pr_visible = 'N' AND MEM_NO=1;

            
     




       
