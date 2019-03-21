��� +-- ���
       +-- ��ȸ
       +-- ��� ��
       +-- ����ó��
       +-- ����
       +-- �亯
       +-- �ű� �亯�� �ֿ켱���� ����ϱ� ���� �亯 ���� ���
 
/**********************************/
/* Table Name: ī�װ� */
/**********************************/
CREATE TABLE reply (
        rpl_no          NUMBER(7)        NOT NULL        PRIMARY KEY,
        pr_no         NUMBER(7)        NULL ,
        mem_no                  NUMBER(6)        NULL ,
        rpl_contents              VARCHAR2(4000)       NOT NULL,
        rpl_rdate                  DATE                                      NOT NULL,
        rpl_visible                 CHAR(1)            DEFAULT 'Y'      NOT NULL,    
        rpl_grpno                 NUMBER(7)                              NOT NULL,
        rpl_indent                NUMBER(2)        DEFAULT 0       NOT NULL,
        rpl_ansnum              NUMBER(5)        DEFAULT 0       NOT NULL,
  FOREIGN KEY (pr_no) REFERENCES product (pr_no),
  FOREIGN KEY (mem_no) REFERENCES member (mem_no)
);
 
select * from member;
select * from product;

2) ���̺� ����
DROP TABLE reply; 

COMMENT ON TABLE reply is '���';
COMMENT ON COLUMN reply.rpl_no is '��� ��ȣ';
COMMENT ON COLUMN reply.pr_no is 'ī�װ���ȣ';
COMMENT ON COLUMN reply.mem_no is 'ȸ�� ��ȣ';
COMMENT ON COLUMN reply.rpl_contents is '����';
COMMENT ON COLUMN reply.rpl_rdate is '�����';
COMMENT ON COLUMN reply.rpl_visible is '��� ����';
COMMENT ON COLUMN reply.rpl_grpno is '�׷� ��ȣ';
COMMENT ON COLUMN reply.rpl_indent is '�亯 ����';
COMMENT ON COLUMN reply.rpl_ansnum is '�亯 ��ȣ';


1) ī�װ�(ncategory) ���� ���̺� ����
-- ī�װ� ���̺��� FK �÷����� ���������� �ӽ÷� �����մϴ�.
-- ���̺��, PK �÷����� ����� ������ ���� ����մϴ�.
INSERT INTO ncategory(pr_no) VALUES(1);
INSERT INTO ncategory(pr_no) VALUES(2);
INSERT INTO ncategory(pr_no) VALUES(3);

2) ȸ��(ncategory) ���� ���̺� ����
-- ȸ�� ���̺��� FK �÷����� ���������� �ӽ÷� �����մϴ�.
-- ���̺��, PK �÷����� ����� ������ ���� ����մϴ�.
INSERT INTO member(mem_no) VALUES(1);
INSERT INTO member(mem_no) VALUES(2);
INSERT INTO member(mem_no) VALUES(3);

3) reply ���             
-- reply ���� ���
- ���ο� ��, �亯 �ۿ����� ��� SQL���̰� �ֽ��ϴ�.
- ���ο� �� ����� ���ο� �׷��� ��������� ����� �ֽ��ϴ�. MAX + 1
- pr_no �÷� 1�� ����
- mem_no �÷� 1�� ����


INSERT INTO reply(rpl_no,
                  pr_no, mem_no, rpl_contents, rpl_rdate, rpl_visible,
                  rpl_grpno, rpl_indent, rpl_ansnum)  
VALUES((SELECT NVL(MAX(rpl_no), 0) + 1 as rpl_no FROM reply),
            2, 1, '����', sysdate, 'Y', 
           0, 0, 0);           
            
            
INSERT INTO reply(rpl_no,
                  pr_no, mem_no, rpl_contents, rpl_rdate, rpl_visible,
                  rpl_grpno, rpl_indent, rpl_ansnum)  
VALUES((SELECT NVL(MAX(rpl_no), 0) + 1 as rpl_no FROM reply),
           3, 1, '����', sysdate, 'Y', 
            (SELECT NVL(MAX(rpl_grpno), 0) + 1 as rpl_grpno FROM reply), 0, 0);       
            
            

            
       
            
4) ��ü ���(��� ����)

SELECT rpl_no,
           pr_no, mem_no,   rpl_contents, rpl_rdate, rpl_visible, rpl_grpno, rpl_indent, rpl_ansnum
FROM reply
order by rpl_rdate;

 RPL_NO PR_NO MEM_NO RPL_CONTENTS RPL_RDATE             RPL_VISIBLE RPL_GRPNO RPL_INDENT RPL_ANSNUM
 ------ ----- ------ ------------ --------------------- ----------- --------- ---------- ----------
      1     2      1 ����           2018-06-29 15:14:19.0 Y                   1          0          0
      2     3      1 ����           2018-06-29 15:14:20.0 Y                   2          0          0


5) ncategory �� ���(��� ����)
SELECT rpl_no,
           pr_no, mem_no,   rpl_contents, rpl_rdate, rpl_visible,  rpl_grpno, rpl_indent, rpl_ansnum
FROM reply
WHERE pr_no=1
ORDER BY rpl_no;


SELECT r.rpl_no, r.pr_no, r.mem_no, r.rpl_contents, r.rpl_rdate, r.rpl_visible,  
      r.rpl_grpno, r.rpl_indent, r.rpl_ansnum, m.mem_id
FROM reply r, member m
WHERE r.mem_no=m.mem_no
ORDER BY rpl_no;

SELECT c.cart_no, c.pr_no, c.mem_no, p.pr_title, p.pr_thumbs, p.pr_state, p.pr_price, p.pr_rdate,pr_transaction
FROM cart c, product p
WHERE  c.pr_no = p.pr_no and c.mem_no =1
      ORDER BY c.cart_no DESC;


 rpl_no pr_no mem_no rpl_contents rpl_rdate                 rpl_visible rpl_grpno rpl_indent rpl_ansnum
 ------- ---- ---- ------- --------------------- ------- ----- ------ ------
       1    1    1 ����      2018-06-11 15:12:38.0 Y           1      0      0



6) ��ü ī��Ʈ
SELECT COUNT(*) as count
FROM reply;      

 COUNT
 -----
     1
     
7)��ȸ
SELECT rpl_no,
           pr_no, mem_no,   rpl_contents, rpl_rdate, rpl_visible,  rpl_grpno, rpl_indent, rpl_ansnum
FROM reply
WHERE rpl_no=1; 

 RPL_NO PR_NO MEM_NO RPL_CONTENTS RPL_RDATE             RPL_VISIBLE RPL_GRPNO RPL_INDENT RPL_ANSNUM
 ------ ----- ------ ------------ --------------------- ----------- --------- ---------- ----------
      1     1      1 ����           2018-06-18 13:24:53.0 Y                   1          0          0



8)����
UPDATE reply
SET  rpl_contents='���̽÷���...', rpl_rdate=sysdate
WHERE rpl_no=1;

9) ����
DELETE FROM reply
WHERE rpl_no=1

10)pr_no ����
DELETE FROM reply
WHERE pr_no=1

select * From product;

10)�亯
    UPDATE reply
    SET rpl_ansnum = rpl_ansnum + 1
    WHERE rpl_grpno = 0 AND rpl_ansnum >= 0







            
     



