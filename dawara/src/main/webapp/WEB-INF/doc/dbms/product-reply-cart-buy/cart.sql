��ٱ��� +-- ���
             +-- COUNT
             +-- ����
             +-- ��ȸ
 

CREATE TABLE CART (
        cart_no      NUMBER(6)    NOT NULL PRIMARY KEY,
        pr_no         NUMBER(7)        NULL ,
        mem_no                  NUMBER(6)        NULL ,
  FOREIGN KEY (pr_no) REFERENCES product (pr_no),
  FOREIGN KEY (mem_no) REFERENCES member (mem_no)
);

COMMENT ON TABLE CART is '��ٱ���';
COMMENT ON COLUMN CART.cart_no is '��ٱ��� ��ȣ';
COMMENT ON COLUMN CART.pr_no is '��ǰ��ȣ';
COMMENT ON COLUMN CART.mem_no is 'ȸ�� ��ȣ';
 
select * from member;
select * from product;

1) ���̺� ����
DROP TABLE CART; 

2)����
INSERT INTO cart(cart_no, pr_no, mem_no)
VALUES((SELECT NVL(MAX(cart_no), 0) + 1 as cart_no FROM cart), 2, 1); 

delete cart;




3)���� ����
SELECT COUNT(*) as count
FROM cart
WHERE pr_no=5 and mem_no = 2;

SELECT COUNT(*) as count
FROM cart
WHERE pr_no= #{pr_no}

4)��ȸ
SELECT cart_no, pr_no, mem_no
FROM cart;

 CART_NO PR_NO MEM_NO
 ------- ----- ------
       1     2      1

5)����
DELETE FROM cart
WHERE cart_no=2;

DELETE FROM cart
WHERE pr_no=2;

select * from product;
6)join

SELECT c.cart_no, c.pr_no, c.mem_no, p.pr_title, p.pr_thumbs, p.pr_state, p.pr_price, p.pr_rdate,pr_transaction
FROM cart c, product p
WHERE  c.pr_no = p.pr_no and c.mem_no =1
      ORDER BY c.cart_no DESC;


      
      
 CART_NO PR_NO MEM_NO PR_TITLE                PR_THUMBS PR_STATE PR_PRICE PR_RDATE              PR_TRANSACTION
 ------- ----- ------ ----------------------- --------- -------- -------- --------------------- --------------
       1     1      1 [�Ｚ����]PEN NT930QAA-K28A Lg_t.jpg  �߰�            800 2018-07-13 14:48:37.0 ���ŷ�


SELECT c.categrpno, c.name,
          t.categoryno, t.categrpno, t.title, t.seqno, t.visible, t.ids, t.cnt
FROM categrp c, category t  
WHERE c.categrpno = t.categrpno
ORDER BY c.categrpno ASC, t.seqno ASC;




