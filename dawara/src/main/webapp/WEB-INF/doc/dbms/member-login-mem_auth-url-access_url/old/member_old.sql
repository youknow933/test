--�ӽ����̺�(���� ���̺�)
- ���� ���̺�
- �����ں� ���� �ο�

CREATE TABLE AUTH(
    AUTH_NO                            NUMBER(10)    NOT NULL    PRIMARY KEY,
    AUTH_INFO                          VARCHAR2(100)    NOT NULL
);

drop table auth;
drop table admin;

COMMENT ON TABLE AUTH is '����';
COMMENT ON COLUMN AUTH.AUTH_NO is '���� ��ȣ';
COMMENT ON COLUMN AUTH.AUTH_INFO is '���� ����';

INSERT INTO auth(auth_no, auth_info)
VALUES (1, '������');
INSERT INTO auth(auth_no, auth_info)
VALUES (2, '�ΰ�����');
INSERT INTO auth(auth_no, auth_info)
VALUES (3, '�Ϲ�ȸ��');
INSERT INTO auth(auth_no, auth_info)
VALUES (4, '���ȸ��');
INSERT INTO auth(auth_no, auth_info)
VALUES (5, '������Ʈ');

SELECT * FROM auth;

SELECT COUNT(*) as cnt
FROM member
WHERE 1=1

    SELECT mem_no, mem_id, mem_name, mem_tel, mem_mail, mem_sex, 
              mem_zipcode, mem_addr1, mem_addr2, auth_no, mem_date, r
    FROM (
              SELECT mem_no, mem_id, mem_name, mem_tel, mem_mail, mem_sex, 
              mem_zipcode, mem_addr1, mem_addr2, auth_no, mem_date, rownum as r
              FROM (
                        SELECT mem_no, mem_id, mem_name, mem_tel, mem_mail, mem_sex, 
                                  mem_zipcode, mem_addr1, mem_addr2, auth_no, mem_date
                                  FROM member
                                  WHERE mem_id LIKE '%user1%'
                                  ORDER BY mem_no DESC
                        )
            );

1) ȸ�� ���̺� ����
CREATE TABLE member (
  mem_no       NUMBER(6) NOT NULL     PRIMARY KEY, -- ȸ�� ��ȣ, ���ڵ带 �����ϴ� �÷� 
  mem_id           VARCHAR(20)   NOT NULL UNIQUE, -- ���̵�, �ߺ� �ȵ�, ���ڵ带 ���� 
  mem_pic       VARCHAR(100)    NULL,     -- ȸ������
  mem_size       NUMBER(10)    DEFAULT 0 NULL,     -- ȸ������ ũ��
  mem_pass    VARCHAR(60)   NOT NULL, -- �н�����, ������ ����
  mem_name    VARCHAR(20)   NOT NULL, -- ����, �ѱ� 10�� ���� ����
  mem_tel          VARCHAR(14)   NOT NULL, -- ��ȭ��ȣ
  mem_mail      VARCHAR(20)     NOT NULL, -- �̸���
  mem_auth      VARCHAR(20)     NULL, -- �̸��� ����Ű
  mem_job         VARCHAR(20)     NOT NULL, -- ȸ������
  mem_sex         VARCHAR(10)     NOT NULL, -- ȸ������
  mem_zipcode   VARCHAR(5)        NULL, -- �����ȣ, 12345
  mem_addr1  VARCHAR(100)       NULL, -- �ּ� 1
  mem_addr2  VARCHAR(80)       NULL, -- �ּ� 2    
  mem_acc   NUMBER(6)   DEFAULT 0 NOT NULL,   -- ȸ���� �Ű����Ƚ��
  mem_mile   NUMBER(9)   DEFAULT 0 NOT NULL,   -- ȸ�� ���ϸ���(���ſ�)
  mem_confirm    VARCHAR(1)         DEFAULT 'N' NOT NULL, -- �̸��� ��ũ Ŭ�� ����, Y:Ŭ��, N:Ŭ������
  auth_no   NUMBER(6) DEFAULT 3 NOT NULL, -- ȸ�� ���� ��ȣ
  mem_date     DATE             NOT NULL, -- ������    
  FOREIGN KEY (AUTH_NO) REFERENCES AUTH(AUTH_NO)
);

alter table member rename column authno to auth_no;
alter table member rename column mem_date to mem_rdate;
alter table member rename column mem_rdate to mem_date;
alter table member drop(mem_word);

ALTER TABLE MEMBER ADD(mem_word VARCHAR(1000)); 
ALTER TABLE MEMBER 

ALTER TABLE MEMBER MODIFY(MEM_SIZE NUMBER(10)    DEFAULT 0 NULL);

SELECT * FROM MEMBER;

ALTER TABLE MEMBER MODIFY MEM_AUTH VARCHAR(20) NULL;

DROP TABLE MEMBER;

COMMENT ON TABLE MEMBER is 'ȸ��';
COMMENT ON COLUMN MEMBER.MEM_NO is 'ȸ�� ��ȣ';
COMMENT ON COLUMN MEMBER.MEM_ID is '���̵�';
COMMENT ON COLUMN MEMBER.MEM_PIC is 'ȸ������';
COMMENT ON COLUMN MEMBER.MEM_SIZE is 'ȸ������ũ��';
COMMENT ON COLUMN MEMBER.MEM_PASS is '�н�����';
COMMENT ON COLUMN MEMBER.MEM_NAME is '����';
COMMENT ON COLUMN MEMBER.MEM_TEL is '��ȭ��ȣ';
COMMENT ON COLUMN MEMBER.MEM_MAIL is '�̸����ּ�';
COMMENT ON COLUMN MEMBER.MEM_AUTH is '�̸�������Ű';
COMMENT ON COLUMN MEMBER.MEM_JOB is 'ȸ������';
COMMENT ON COLUMN MEMBER.MEM_SEX is 'ȸ������';
COMMENT ON COLUMN MEMBER.MEM_ZIPCODE is '�����ȣ';
COMMENT ON COLUMN MEMBER.MEM_ADDR1 is '�ּ�1';
COMMENT ON COLUMN MEMBER.MEM_ADDR2 is '�ּ�2';
COMMENT ON COLUMN MEMBER.MEM_ACC is '�Ű�Ƚ��';
COMMENT ON COLUMN MEMBER.MEM_MILE is '���ϸ���';
COMMENT ON COLUMN MEMBER.MEM_CONFIRM is '����Ȯ�ο���';
COMMENT ON COLUMN MEMBER.AUTH_NO is 'ȸ�����ѹ�ȣ'; -- 1: ������, 2: �ΰ�����, 3: �Ϲ�ȸ��, 4: ���ȸ��, 5:������Ʈ
COMMENT ON COLUMN MEMBER.MEM_DATE is '������';

DROP TABLE member;

SELECT * FROM member;

SELECT mem_no, mem_id, auth_no FROM member;

update member set auth_no = 1 where mem_no =2;

DROP TABLE login;

SELECT mem_no, mem_id, mem_name, mem_tel, mem_mail, mem_sex, 
              mem_zipcode, mem_addr1, mem_addr2, auth_no, mem_date
    FROM member
    WHERE mem_id LIKE '%' || 'user1' || '%'
    ORDER BY mem_no DESC

1-1) ���
* id �ߺ� Ȯ��
SELECT COUNT(mem_id) as cnt
FROM member
WHERE mem_id='user1';
 
 cnt
 ---
   0   �� �ߺ� ���� ����.
   
1-1) ��� 
-- ���� ȸ�� ����
INSERT INTO member(mem_no, mem_id, mem_pic, mem_size, mem_pass, mem_name, mem_tel, mem_mail, mem_auth, mem_job,
mem_sex, mem_zipcode, mem_addr1, mem_addr2, mem_confirm, mem_date)
VALUES ((SELECT NVL(MAX(mem_no), 0)+1 as mem_no FROM member),
'user53', 'hello.jpg', '15468720', '1234', '�մ���', '000-0000-0000', 'test1@gmail.com', 'AXD0123456789012', '�л�', '��', '12345', '����� ���α�', '��ö��', 'Y', sysdate);
 
INSERT INTO member(mem_no, mem_id, mem_pic, mem_size, mem_pass, mem_name, mem_tel, mem_mail, mem_auth, mem_job,
mem_sex, mem_zipcode, mem_addr1, mem_addr2, mem_confirm, mem_date)
VALUES ((SELECT NVL(MAX(mem_no), 0)+1 as mem_no FROM member),
'user12323', 'hello.jpg', '15468720', '1234', '�Ʒι�', '000-0000-0000', 'test1@gmail.com', 'AXD0123456789012', 'ȸ���', '��', '12345', '����� ���α�', '��ö��', 'Y', sysdate);

INSERT INTO member(mem_no, mem_id, mem_pass, mem_name, mem_tel, mem_mail, mem_auth, mem_job,
mem_sex, mem_zipcode, mem_addr1, mem_addr2, mem_confirm, mem_date)
VALUES ((SELECT NVL(MAX(mem_no), 0)+1 as mem_no FROM member),
'user553', '1234', '����', '000-0000-0000', 'test1@gmail.com', 'AXD0123456789012', '����', '��', '12345', '����� ���α�', '��ö��', 'Y', sysdate);

INSERT INTO member(mem_no, mem_id, mem_pass, mem_name, mem_tel, mem_mail, mem_auth, mem_job,
mem_sex, mem_zipcode, mem_addr1, mem_addr2, mem_confirm, mem_date, mem_word)
VALUES ((SELECT NVL(MAX(mem_no), 0)+1 as mem_no FROM member),
'user557', '1234', '����', '000-0000-0000', 'test1@gmail.com', 'AXD0123456789012', '����', '��', '12345', '����� ���α�', '��ö��', 'Y', sysdate,
'(user557, 1234, ����, test1@gmial.com)');

INSERT INTO member(mem_no, mem_id, mem_pass, mem_name, mem_tel, mem_mail, mem_auth, mem_job,
mem_sex, mem_zipcode, mem_addr1, mem_addr2, mem_confirm, mem_date)
VALUES ((SELECT NVL(MAX(mem_no), 0)+1 as mem_no FROM member),
'user15', '123456', '����', '000-0000-0000', 'test1@gmail.com', 'AXD0123456789012', '����', '��', '12345', '����� ���α�', '��ö��', 'Y', sysdate);


1-2) ���
- �˻��� ���� �ʴ� ���, ��ü ��� ���


 
SELECT mem_no, mem_id, mem_pic, mem_size, mem_pass, mem_name, mem_tel, mem_mail, mem_auth, mem_job, 
mem_sex, mem_zipcode, mem_addr1, mem_addr2, mem_acc, mem_mile, mem_confirm, mem_acc, mem_date
FROM member
ORDER BY mem_no ASC;
 
 MEM_NO MEM_ID MEM_PIC   MEM_SIZE MEM_PASS MEM_NAME MEM_TEL       MEM_MAIL        MEM_AUTH         MEM_JOB MEM_SEX MEM_ZIPCODE MEM_ADDR1 MEM_ADDR2 MEM_ACC MEM_MILE MEM_CONFIRM MEM_ACC MEM_DATE
 ------ ------ --------- -------- -------- -------- ------------- --------------- ---------------- ------- ------- ----------- --------- --------- ------- -------- ----------- ------- ---------------------
      1 user1  hello.jpg 15468720 1234     �մ���      000-0000-0000 test1@gmail.com AXD0123456789012 �л�      ��       12345       ����� ���α�   ��ö��             0        0 Y                 0 2018-06-21 15:05:42.0
      2 user2  hello.jpg 15468720 1234     �Ʒι�      000-0000-0000 test1@gmail.com AXD0123456789012 ȸ���     ��       12345       ����� ���α�   ��ö��             0        0 Y                 0 2018-06-21 15:05:43.0
      3 user3  NULL          NULL 1234     ����       000-0000-0000 test1@gmail.com AXD0123456789012 ����      ��       12345       ����� ���α�   ��ö��             0        0 Y                 0 2018-06-21 15:05:44.0
      
1-3) ��ȸ
* user1 ȸ�� ���� ����
SELECT mem_no, mem_id, mem_pic, mem_size, mem_pass, mem_name, mem_tel, mem_mail, mem_auth, mem_job,
mem_sex, mem_zipcode, mem_addr1, mem_addr2, mem_acc, mem_mile, mem_confirm, mem_date
FROM member
WHERE mem_no = 1;
 
 MEM_NO MEM_ID MEM_PIC   MEM_SIZE MEM_PASS MEM_NAME MEM_TEL       MEM_MAIL        MEM_AUTH         MEM_JOB MEM_SEX MEM_ZIPCODE MEM_ADDR1 MEM_ADDR2 MEM_ACC MEM_MILE MEM_CONFIRM MEM_DATE
 ------ ------ --------- -------- -------- -------- ------------- --------------- ---------------- ------- ------- ----------- --------- --------- ------- -------- ----------- ---------------------
      1 user1  hello.jpg 15468720 1234     �մ���      000-0000-0000 test1@gmail.com AXD0123456789012 �л�      ��       12345       ����� ���α�   ��ö��             0        0 Y           2018-06-21 15:05:42.0

SELECT mem_no, mem_id, mem_pic, mem_size, mem_pass, mem_name, mem_tel, mem_mail, mem_auth, mem_job, 
mem_sex, mem_zipcode, mem_addr1, mem_addr2, mem_acc, mem_mile, mem_confirm, mem_date
FROM member
WHERE mem_id = 'user1';
 
 MEM_NO MEM_ID MEM_PIC   MEM_SIZE MEM_PASS MEM_NAME MEM_TEL       MEM_MAIL        MEM_AUTH         MEM_JOB MEM_SEX MEM_ZIPCODE MEM_ADDR1 MEM_ADDR2 MEM_ACC MEM_MILE MEM_CONFIRM MEM_DATE
 ------ ------ --------- -------- -------- -------- ------------- --------------- ---------------- ------- ------- ----------- --------- --------- ------- -------- ----------- ---------------------
      1 user1  hello.jpg 15468720 1234     �մ���      000-0000-0000 test1@gmail.com AXD0123456789012 �л�      ��       12345       ����� ���α�   ��ö��             0        0 Y           2018-06-21 15:05:42.0

1-4) ����
--�Ϲ�ȸ���� ��������
UPDATE member 
SET mem_name='ȣ����', mem_pic='hi.jpg', mem_mail='test1@yahoo.co.kr', mem_job='����', 
      mem_tel='111-1111-1111', mem_zipcode='00000', mem_addr1='��⵵', mem_addr2='���ֽ�'
WHERE mem_no=1;

SELECT * FROM member;

 MEM_NO MEM_ID MEM_PIC   MEM_SIZE MEM_PASS MEM_NAME MEM_TEL       MEM_MAIL          MEM_AUTH         MEM_JOB MEM_SEX MEM_ZIPCODE MEM_ADDR1 MEM_ADDR2 MEM_ACC MEM_MILE MEM_CONFIRM AUTH_NO MEM_DATE
 ------ ------ --------- -------- -------- -------- ------------- ----------------- ---------------- ------- ------- ----------- --------- --------- ------- -------- ----------- ------- ---------------------
      1 user1  hi.jpg    15468720 1234     ȣ����      111-1111-1111 test1@yahoo.co.kr AXD0123456789012 ����      ��       00000       ��⵵       ���ֽ�             0        0 Y                 3 2018-06-21 15:05:42.0
      2 user2  hello.jpg 15468720 1234     �Ʒι�      000-0000-0000 test1@gmail.com   AXD0123456789012 ȸ���     ��       12345       ����� ���α�   ��ö��             0        0 Y                 3 2018-06-21 15:05:43.0
      3 user3  NULL          NULL 1234     ����       000-0000-0000 test1@gmail.com   AXD0123456789012 ����      ��       12345       ����� ���α�   ��ö��             0        0 Y                 3 2018-06-21 15:05:44.0

UPDATE member 
SET mem_id='user2'
WHERE mem_no=2;
      
1-5) �н����� ����
* �н����� �˻�
SELECT COUNT(mem_no) as cnt
FROM member
WHERE mem_no=1 AND mem_pass='1234';

 CNT
 ---
   1  -- mem_no=1���� pass����� 1234, ��ġ�ϱ� ������ 1
 
* �н����� ����
UPDATE member
SET mem_pass='0000'
WHERE mem_no=1;

SELECT * FROM member WHERE mem_no=1;

 MEM_NO MEM_ID MEM_PIC MEM_SIZE MEM_PASS MEM_NAME MEM_TEL       MEM_MAIL          MEM_AUTH         MEM_JOB MEM_SEX MEM_ZIPCODE MEM_ADDR1 MEM_ADDR2 MEM_ACC MEM_MILE MEM_CONFIRM AUTH_NO MEM_DATE
 ------ ------ ------- -------- -------- -------- ------------- ----------------- ---------------- ------- ------- ----------- --------- --------- ------- -------- ----------- ------- ---------------------
      1 user1  hi.jpg  15468720 0000     ȣ����      111-1111-1111 test1@yahoo.co.kr AXD0123456789012 ����      ��       00000       ��⵵       ���ֽ�             0        0 Y                 3 2018-06-21 15:05:42.0

1-6) ����
* ��� ����
DELETE FROM member;
 
* Ư�� ȸ�� ����
DELETE FROM member
WHERE mem_no=4;
 
 
1-7) �α���
SELECT COUNT(mem_no) as cnt
FROM member
WHERE mem_id='user1' AND mem_pass='1234';
 cnt
 ---
   0
 
* ������Ʈ ����� �߰� �÷� �ȳ�: �̸���, ����, ȸ�� ����, ����, ���

2) �α��� ���� ���̺� ����

DROP TABLE login;

SELECT * FROM login;
SELECT * FROM MEMBER;

CREATE TABLE login(
  login_no NUMBER(10)  NOT NULL, -- �⺻Ű
  mem_no NUMBER(6) NULL, -- �����ڰ� ȸ���̸� mem_no������
  login_ip  VARCHAR(15) NOT NULL, -- ������ ip
  login_date DATE  NOT NULL, -- ������ ���ӽð�
  login_agent VARCHAR(400) NOT NULL, --������ ������ ����
  PRIMARY KEY (login_no),
  FOREIGN KEY(mem_no)  REFERENCES member(mem_no)
);

SELECT COUNT(mem_no) as cnt
FROM login
WHERE mem_no=13;

drop table login;
  
COMMENT ON TABLE login is '�α���';
COMMENT ON COLUMN login.login_no is '�α��ι�ȣ';
COMMENT ON COLUMN login.mem_no is 'ȸ����ȣ';
COMMENT ON COLUMN login.login_ip is '�α��ξ�����';
COMMENT ON COLUMN login.login_date is '�α��γ�¥';
COMMENT ON COLUMN login.login_agent is '�����ں���������';

2-2) ��� 
-- ���� ȸ�� ����
INSERT INTO login(login_no, mem_no, login_ip, login_date)
VALUES ((SELECT NVL(MAX(login_no), 0)+1 as login_no FROM login), 1, '0.0.0.0', sysdate); 

INSERT INTO login(login_no, mem_no, login_ip, login_date)
VALUES ((SELECT NVL(MAX(login_no), 0)+1 as login_no FROM login), 2, '0.0.0.0', sysdate); 

INSERT INTO login(login_no, mem_no, login_ip, login_date)
VALUES ((SELECT NVL(MAX(login_no), 0)+1 as login_no FROM login), 1, '0.0.0.0', sysdate); 

2-3) ���
 
SELECT *
FROM login
ORDER BY login_no ASC;
 
 LOGIN_NO MEM_NO LOGIN_IP LOGIN_DATE
 -------- ------ -------- ---------------------
        1      1 0.0.0.0  2018-06-21 13:40:19.0
        2      2 0.0.0.0  2018-06-21 13:40:20.0
        3      1 0.0.0.0  2018-06-21 13:40:21.0
        
2-4) ��ȸ
* user1�� �α��� ��Ϻ���
SELECT login_no, mem_no, login_ip, login_date
FROM login
WHERE mem_no = 1;

 LOGIN_NO MEM_NO LOGIN_IP LOGIN_DATE
 -------- ------ -------- ---------------------
        1      1 0.0.0.0  2018-06-21 13:40:19.0
        3      1 0.0.0.0  2018-06-21 13:40:21.0

SELECT login_no, mem_no, login_ip, login_date
FROM login
WHERE login_ip = '0.0.0.0';
 
 LOGIN_NO MEM_NO LOGIN_IP LOGIN_DATE
 -------- ------ -------- ---------------------
        1      1 0.0.0.0  2018-06-21 13:40:19.0
        2      2 0.0.0.0  2018-06-21 13:40:20.0
        3      1 0.0.0.0  2018-06-21 13:40:21.0

2-5) ����
* ��� ����
DELETE FROM login;
 
* Ư�� ȸ�� �α��� ��� ����
DELETE FROM login
WHERE mem_no=1;

+�ֹ�, �ֹ���, ��ٱ���

DROP TABLE p_order;

3) �ֹ� ���̺� ����
CREATE TABLE p_order(
    ord_no    NUMBER(6) NOT NULL,
    ord_mem_no NUMBER(6) NOT NULL,
    ord_date    DATE NOT NULL,
    rec_name    VARCHAR(20) NOT NULL,
    rec_zipcode     VARCHAR(5) NULL,
    rec_addr1     VARCHAR(80) NULL,
    rec_addr2     VARCHAR(50) NULL,
    rec_tel     VARCHAR(14) NOT NULL,
    rec_cmt     VARCHAR(100) NULL,
    rec_sign    VARCHAR(20) NOT NULL,
    PRIMARY KEY (ord_no),
    CONSTRAINT ck_ord_memno FOREIGN KEY(ord_mem_no)
    REFERENCES p_member(mem_no)
);

COMMENT ON TABLE P_ORDER is '�ֹ�';
COMMENT ON COLUMN P_ORDER.ORD_NO is '�ֹ���ȣ';
COMMENT ON COLUMN P_ORDER.ORD_MEM_NO is '�ֹ�ȸ����ȣ';
COMMENT ON COLUMN P_ORDER.ORD_DATE is '�ֹ���¥';
COMMENT ON COLUMN P_ORDER.REC_NAME is '�������̸�';
COMMENT ON COLUMN P_ORDER.REC_ZIPCODE is '����ּ�1';
COMMENT ON COLUMN P_ORDER.REC_ADDR1 is '����ּ�2';
COMMENT ON COLUMN P_ORDER.REC_ADDR2 is '����ּ�3';
COMMENT ON COLUMN P_ORDER.REC_TEL is '��������ȭ��ȣ';
COMMENT ON COLUMN P_ORDER.REC_CMT is '��Ÿ����';
COMMENT ON COLUMN P_ORDER.REC_SIGN is '��������';

-------------�ӽ����̺�---------------------------------------------

DROP TABLE p_products;

CREATE TABLE p_products(
    products_no NUMBER(6) NOT NULL,
    PRIMARY KEY(products_no)
);

COMMENT ON TABLE P_PRODUCTS is '��ǰ';
COMMENT ON COLUMN P_PRODUCTS.PRODUCTS_NO is '��ǰ��ȣ';

----------------------------------------------------------------------

DROP TABLE p_ord_detail;

4) �ֹ��� ���̺� ����
CREATE TABLE p_ord_detail(
    ord_detail_no   NUMBER(6) NOT NULL,
    ord_detail_ord_no    NUMBER(6) NOT NULL,
    ord_detail_products_no  NUMBER(6) NOT NULL,
    ord_prodno VARCHAR(13) NOT NULL,
    ord_price NUMBER(9) NOT NULL,
    PRIMARY KEY (ord_detail_no),
    CONSTRAINT ck_ord_detail_ordno FOREIGN KEY(ord_detail_ord_no) REFERENCES p_order(ord_no),
    CONSTRAINT ck_ord_detail_products_no FOREIGN KEY(ord_detail_products_no) REFERENCES p_products(products_no)
);

COMMENT ON TABLE P_ORD_DETAIL is '�ֹ���';
COMMENT ON COLUMN P_ORD_DETAIL.ORD_DETAIL_NO is '�ֹ��󼼹�ȣ';
COMMENT ON COLUMN P_ORD_DETAIL.ORD_DETAIL_ORD_NO is '�ֹ���ȣ';
COMMENT ON COLUMN P_ORD_DETAIL.ORD_DETAIL_PRODUCTS_NO is '��ǰ��ȣ';
COMMENT ON COLUMN P_ORD_DETAIL.ORD_PRODNO is '�ֹ���ǰ����';
COMMENT ON COLUMN P_ORD_DETAIL.ORD_PRICE is '�ֹ���ǰ����';

DROP TABLE p_cart;

5) ��ٱ��� ���̺� ����
CREATE TABLE p_cart(
  cart_no NUMBER(6) NOT NULL,
  cart_mem_no NUMBER(6) NOT NULL,
  cart_prodname VARCHAR(20) NOT NULL,
  cart_price VARCHAR(13) NOT NULL,
  cart_prodno NUMBER(6) NOT NULL,
  PRIMARY KEY(cart_no),
  CONSTRAINT ck_cart_memno FOREIGN KEY(cart_mem_no) REFERENCES p_member(mem_no)
);
  
COMMENT ON TABLE P_CART is '��ٱ���';
COMMENT ON COLUMN P_CART.CART_NO is '��ٱ��Ϲ�ȣ';
COMMENT ON COLUMN P_CART.CART_MEM_NO is 'ȸ����ȣ';
COMMENT ON COLUMN P_CART.CART_PRODNAME is '��ǰ�̸�';
COMMENT ON COLUMN P_CART.CART_PRICE is '��ǰ����';
COMMENT ON COLUMN P_CART.CART_PRODNO is '��ǰ����';


1. ���

1) id �ߺ� Ȯ��
SELECT COUNT(id) as cnt
FROM member
WHERE id='user1';
 
 cnt
 ---
   0   �� �ߺ� ���� ����.
   
2) ���
- �Ϸù�ȣ ���� ��������
- MAX(mno): mno �÷��� ���߿� ���� ū ���� ����
- ���ڵ尡 ������ MAX �Լ��� ����� NULL�̵˴ϴ�.
SELECT MAX(mno) as mno FROM member;
 MNO
 ------
 NULL
 
 - NULL ���� ��Ģ������ ����� NULL�̵˴ϴ�. �ǹ� ����.
SELECT MAX(mno)+1 as mno FROM member;
 MNO
 ------
 NULL
 
 - NVL(��, ��ȯ�� ��): ���� NULL�̸� ��ȯ�� ������ ����, 
   NULL�� 0���� ����
SELECT NVL(MAX(mno), 0) as mno FROM member;
 MNO
 ------
   0
   
- NULL�� ó���ϸ鼭 ���ο� �ִ밪 ���� SQL
SELECT NVL(MAX(mno), 0)+1 as mno FROM member;
 MNO
 ------
   1
 
-- ���� ȸ�� ����
INSERT INTO member(mno, id, passwd, mname, tel, zipcode, address1, address2, mdate)
VALUES ((SELECT NVL(MAX(mno), 0)+1 as mno FROM member),
'user1', '1234', '�մ���', '000-0000-0000', '12345', '����� ���α�', '��ö��', sysdate);
 
INSERT INTO member(mno, id, passwd, mname, tel, zipcode, address1, address2, mdate)
VALUES ((SELECT NVL(MAX(mno), 0)+1 as mno FROM member),
'user2', '1234', '�մ���', '000-0000-0000', '12345', '����� ���α�', '��ö��', sysdate);
 
INSERT INTO member(mno, id, passwd, mname, tel, zipcode, address1, address2, mdate)
VALUES ((SELECT NVL(MAX(mno), 0)+1 as mno FROM member),
'user3', '1234', '�մ���', '000-0000-0000', '12345', '����� ���α�', '��ö��', sysdate);
 
-- �׷캰 ����ȸ�� ����
INSERT INTO member(mno, id, passwd, mname, tel, zipcode, address1, address2, mdate)
VALUES ((SELECT NVL(MAX(mno), 0)+1 as mno FROM member),
'team1', '1234', '������', '000-0000-0000', '12345', '����� ���α�', '��ö��', sysdate);
 
INSERT INTO member(mno, id, passwd, mname, tel, zipcode, address1, address2, mdate)
VALUES ((SELECT NVL(MAX(mno), 0)+1 as mno FROM member),
'team2', '1234', '���ۺ�����', '000-0000-0000', '12345', '����� ���α�', '��ö��', sysdate);
 
INSERT INTO member(mno, id, passwd, mname, tel, zipcode, address1, address2, mdate)
VALUES ((SELECT NVL(MAX(mno), 0)+1 as mno FROM member),
'team3', '1234', '��������', '000-0000-0000', '12345', '����� ���α�', '��ö��', sysdate);
 
 
2. ���
- �˻��� ���� �ʴ� ���, ��ü ��� ���
 
SELECT mno, id, passwd, mname, tel, zipcode, address1, address2, mdate
FROM member
ORDER BY mno ASC;
 
 mno id    passwd mname tel           zipcode address1 address2 mdate
 --- ----- ------ ----- ------------- ------- -------- -------- ---------------------
   1 user1 1234   �մ���   000-0000-0000 12345   ����� ���α�  ��ö��      2016-01-12 12:48:52.0
   2 user2 1234   �մ���   000-0000-0000 12345   ����� ���α�  ��ö��      2016-01-12 12:48:53.0
   3 user3 1234   �մ���   000-0000-0000 12345   ����� ���α�  ��ö��      2016-01-12 12:48:54.0
 
   
3. ��ȸ
 
1) user1 ��� ���� ����
SELECT mno, id, passwd, mname, tel, zipcode, address1, address2, mdate
FROM member
WHERE mno = 1;
 
 MNO ID    PASSWD MNAME TEL           ZIPCODE ADDRESS1 ADDRESS2 MDATE
 --- ----- ------ ----- ------------- ------- -------- -------- ---------------------
   1 user1 1234   �մ���   000-0000-0000 12345   ����� ���α�  ��ö��      2016-05-24 12:59:35.0
 
SELECT mno, id, passwd, mname, tel, zipcode, address1, address2, mdate
FROM member
WHERE id = 'user1';
 
 MNO ID    PASSWD MNAME TEL           ZIPCODE ADDRESS1 ADDRESS2 MDATE
 --- ----- ------ ----- ------------- ------- -------- -------- ---------------------
   1 user1 1234   �մ���   000-0000-0000 12345   ����� ���α�  ��ö��      2017-03-22 22:13:31.0
 
   
4. ����
UPDATE member 
SET mname='�Ʒι�', tel='111-1111-1111', zipcode='00000',
      address1='��⵵', address2='���ֽ�'
WHERE mno=1;
 
 
5. �н����� ����
1) �н����� �˻�
SELECT COUNT(mno) as cnt
FROM member
WHERE mno=1 AND passwd='1234';
 
2) �н����� ����
UPDATE member
SET passwd='0000'
WHERE mno=1;
 
 
6. ����
1) ��� ����
DELETE FROM member;
 
2) Ư�� ȸ�� ����
DELETE FROM member
WHERE mno=4;
 
 
7. �α���
SELECT COUNT(mno) as cnt
FROM member
WHERE id='user1' AND passwd='1234';
 cnt
 ---
   0
 
 
* ������Ʈ ����� �߰� �÷� �ȳ�: �̸���, ����, ȸ�� ����, ����, ���
  
 
-------------------------------------------------------------------------------------
 
 
 
 
- MySQL
�� /WEB-INF/doc/dbms/member_q.sql
-------------------------------------------------------------------------------------
1. ���̺� ����
DROP TABLE member;
 
CREATE TABLE member (
  mno INT NOT NULL AUTO_INCREMENT, -- ȸ�� ��ȣ, ���ڵ带 �����ϴ� �÷� 
  id           VARCHAR(20)   NOT NULL UNIQUE, -- ���̵�, �ߺ� �ȵ�, ���ڵ带 ���� 
  passwd    VARCHAR(20)   NOT NULL, -- �н�����, ������ ����
  mname    VARCHAR(20)   NOT NULL, -- ����, �ѱ� 10�� ���� ����
  tel          VARCHAR(14)   NOT NULL, -- ��ȭ��ȣ
  zipcode   VARCHAR(5)        NULL, -- �����ȣ, 12345
  address1  VARCHAR(80)       NULL, -- �ּ� 1
  address2  VARCHAR(50)       NULL, -- �ּ� 2
  mdate     DATETIME            NOT NULL, -- ������    
  PRIMARY KEY (mno)             -- �ѹ� ��ϵ� ���� �ߺ� �ȵ�
);
 
 
2. ���
 
1) id �ߺ� Ȯ��
SELECT COUNT(id) as cnt
FROM member
WHERE id='user1';
 
 cnt
 ---
   0   �� �ߺ� ���� ����.
   
2) ���
INSERT INTO member(id, passwd, mname, tel, zipcode, address1, address2, mdate)
VALUES ('user1', '1234', '�մ���', '000-0000-0000', '12345', '����� ���α�', '��ö��', now());
 
INSERT INTO member(id, passwd, mname, tel, zipcode, address1, address2, mdate)
VALUES ('user2', '1234', '�մ���', '000-0000-0000', '12345', '����� ���α�', '��ö��', now());
 
INSERT INTO member(id, passwd, mname, tel, zipcode, address1, address2, mdate)
VALUES ('user3', '1234', '�մ���', '000-0000-0000', '12345', '����� ���α�', '��ö��', now());
 
 
3. ���
- �˻��� ���� �ʴ� ���, ��ü ��� ���
 
SELECT mno, id, passwd, mname, tel, zipcode, address1, address2, mdate
FROM member
ORDER BY mno ASC;
 
 mno id    passwd mname tel           zipcode address1 address2 mdate
 --- ----- ------ ----- ------------- ------- -------- -------- ---------------------
   1 user1 1234   �մ���   000-0000-0000 12345   ����� ���α�  ��ö��      2016-01-12 12:48:52.0
   2 user2 1234   �մ���   000-0000-0000 12345   ����� ���α�  ��ö��      2016-01-12 12:48:53.0
   3 user3 1234   �մ���   000-0000-0000 12345   ����� ���α�  ��ö��      2016-01-12 12:48:54.0
 
 
   
3. ��ȸ
 
1) user1 ��� ���� ����
 
 
4. ����
 
 
5. ����
 
 
6. �˻�
 
 
7. ����¡
 
 
* ������Ʈ ����� �߰� �÷� �ȳ�: �̸���, ����, ȸ�� ����, ����, ���

SELECT mem_no, mem_id, mem_name, mem_tel, mem_mail, mem_job, mem_sex, 
              mem_zipcode, mem_addr1, mem_addr2, mem_date, r
    FROM (
              SELECT mem_no, mem_id, mem_name, mem_tel, mem_mail, mem_job, mem_sex, 
              mem_zipcode, mem_addr1, mem_addr2, mem_date, rownum as r
              FROM (
                        SELECT mem_no, mem_id, mem_name, mem_tel, mem_mail, mem_job, mem_sex, 
                                  mem_zipcode, mem_addr1, mem_addr2, mem_date
                        FROM member
                        ORDER BY mem_no DESC
              )            
    )
    WHERE r >= 1 AND r <= 15
    <!--     WHERE r >= #{startNum} AND r <= #{endNum} -->
  
-------------------------------------------------------------------------------------