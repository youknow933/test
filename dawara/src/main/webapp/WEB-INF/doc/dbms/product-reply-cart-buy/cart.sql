장바구니 +-- 등록
             +-- COUNT
             +-- 삭제
             +-- 조회
 

CREATE TABLE CART (
        cart_no      NUMBER(6)    NOT NULL PRIMARY KEY,
        pr_no         NUMBER(7)        NULL ,
        mem_no                  NUMBER(6)        NULL ,
  FOREIGN KEY (pr_no) REFERENCES product (pr_no),
  FOREIGN KEY (mem_no) REFERENCES member (mem_no)
);

COMMENT ON TABLE CART is '장바구니';
COMMENT ON COLUMN CART.cart_no is '장바구니 번호';
COMMENT ON COLUMN CART.pr_no is '상품번호';
COMMENT ON COLUMN CART.mem_no is '회원 번호';
 
select * from member;
select * from product;

1) 테이블 삭제
DROP TABLE CART; 

2)삽입
INSERT INTO cart(cart_no, pr_no, mem_no)
VALUES((SELECT NVL(MAX(cart_no), 0) + 1 as cart_no FROM cart), 2, 1); 

delete cart;




3)구매 갯수
SELECT COUNT(*) as count
FROM cart
WHERE pr_no=5 and mem_no = 2;

SELECT COUNT(*) as count
FROM cart
WHERE pr_no= #{pr_no}

4)조회
SELECT cart_no, pr_no, mem_no
FROM cart;

 CART_NO PR_NO MEM_NO
 ------- ----- ------
       1     2      1

5)삭제
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
       1     1      1 [삼성전자]PEN NT930QAA-K28A Lg_t.jpg  중고            800 2018-07-13 14:48:37.0 직거래


SELECT c.categrpno, c.name,
          t.categoryno, t.categrpno, t.title, t.seqno, t.visible, t.ids, t.cnt
FROM categrp c, category t  
WHERE c.categrpno = t.categrpno
ORDER BY c.categrpno ASC, t.seqno ASC;




