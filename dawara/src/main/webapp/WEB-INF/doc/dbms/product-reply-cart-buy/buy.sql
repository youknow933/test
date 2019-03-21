��ǰ ���� +-- ���
              +-- COUNT
              +-- ����
              +-- ��ȸ
              
CREATE TABLE buy (
        buy_no      NUMBER(6)    NOT NULL PRIMARY KEY,
        pr_no         NUMBER(7)        NULL ,
        mem_no                  NUMBER(6)        NULL ,
        pay_no                  NUMBER(6)        NULL ,
        buy_rdate       DATE        NOT NULL, 
        buy_visible                 CHAR(1)            DEFAULT 'Y'      NOT NULL,     
        FOREIGN KEY (pr_no) REFERENCES product (pr_no),
        FOREIGN KEY (mem_no) REFERENCES member (mem_no),
        FOREIGN KEY (pay_no) REFERENCES payment (pay_no)
);

DROP TABLE buy
select * from member;
select * from product;
select * from buy;

ALTER TABLE BUY ADD buy_visible CHAR(1) DEFAULT 'Y'      NOT NULL; --mem_mile �÷� �߰�
ALTER TABLE BUY ADD buy_rdate  DATE  NOT NULL; --buy_rdate �÷� �߰�
ALTER TABLE BUY DROP COLUMN buy_rdate; --buy_rdate �÷� �߰�

1) ���̺� ����
DROP TABLE buy; 

COMMENT ON TABLE buy is '����';
COMMENT ON COLUMN buy.buy_no is '���� ��ȣ';
COMMENT ON COLUMN buy.pr_no is '��ǰ��ȣ';
COMMENT ON COLUMN buy.mem_no is 'ȸ�� ��ȣ';
COMMENT ON COLUMN buy.buy_rdate is '���� ��� ��¥';
COMMENT ON COLUMN buy.buy_visible is '��� ����';


INSERT INTO payment(pay_no, ship_no)
VALUES((SELECT NVL(MAX(pay_no),0) +1 as pay_no FROM payment),1);

select * from buy;

2)����
INSERT INTO buy(buy_no, pr_no, mem_no, pay_no, buy_rdate, buy_visible)
VALUES((SELECT NVL(MAX(buy_no), 0) + 1 as buy_no FROM buy),
            1, 1, 1, sysdate, 'Y'); 

3)���� ����
SELECT COUNT(*) as count
FROM buy;    

4)��ȸ
SELECT buy_no, pr_no, mem_no, pay_no,  buy_rdate, buy_visible
FROM buy;

4-1) buy�� pr_no == product�� pr_no
SELECT b.buy_no, b.pr_no, b.mem_no, p.pr_title, p.pr_thumbs, p.pr_state, p.pr_price, p.pr_rdate,pr_transaction
FROM buy b, product p
WHERE  b.pr_no = p.pr_no and b.mem_no =1
      ORDER BY b.buy_no DESC;
      
4-2)
SELECT b.buy_no, b.pr_no, b.mem_no, p.pr_title, p.pr_thumbs, p.pr_state, p.pr_price, p.pr_rdate,pr_transaction
FROM buy b, product p
WHERE  b.mem_no =p.mem_no and p.pr_visible='N'
      ORDER BY b.buy_no DESC;

 BUY_NO PR_NO MEM_NO PR_TITLE                PR_THUMBS  PR_STATE PR_PRICE PR_RDATE              PR_TRANSACTION
 ------ ----- ------ ----------------------- ---------- -------- -------- --------------------- --------------
      1     1      1 [�Ｚ����]PEN NT930QAA-K28A 0_Lg_t.jpg �߰�            800 2018-07-17 19:10:23.0 ���ŷ�

5)����
DELETE FROM buy
WHERE buy_no=2;




