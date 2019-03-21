SELECT COUNT(*) as cnt
FROM login
WHERE mem_no IN(SELECT mem_no FROM member WHERE auth_no=3);

SELECT COUNT(*) as cnt
    FROM access_url
    WHERE auth_no=1

SELECT COUNT(*) as cnt
FROM url
WHERE url_no IN(select url_no from access_url where auth_no=1);

SELECT url_no
FROM url
WHERE url LIKE '%read.do';

DROP TABLE LOGIN;
DROP TABLE MEMBER;
DROP TABLE AUTH;
DROP TABLE URL;
DROP TABLE ACCESS_URL;

select * from login;
select * from member;
select * from auth;
select * from url;
select * from access_url;
    
    
select * from login;
select * from member;
select * from auth;

update auth
set auth_no = 3
where auth_info = '�Ϲ�ȸ��'

DELETE FROM login
    WHERE mem_no IN(SELECT mem_no FROM member WHERE auth_no=5);

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
  mem_job         VARCHAR(20)     NOT NULL, -- ȸ������
  mem_sex         VARCHAR(10)     NOT NULL, -- ȸ������
  mem_zipcode   VARCHAR(5)        NULL, -- �����ȣ, 12345
  mem_addr1  VARCHAR(100)       NULL, -- �ּ� 1
  mem_addr2  VARCHAR(80)       NULL, -- �ּ� 2    
  mem_acc   NUMBER(6)   DEFAULT 0 NOT NULL,   -- ȸ���� �Ű����Ƚ��
  mem_mile   NUMBER(9)   DEFAULT 0 NOT NULL,   -- ȸ�� ���ϸ���(���ſ�)
  auth_no   NUMBER(6) DEFAULT 2 NOT NULL, -- ȸ�� ���� ��ȣ
  mem_date     DATE             NOT NULL, -- ������    
  FOREIGN KEY (AUTH_NO) REFERENCES AUTH(AUTH_NO)
);

select * from member;

alter table member rename column authno to auth_no;
alter table member rename column mem_date to mem_rdate;
alter table member rename column mem_rdate to mem_date;
alter table member drop(mem_word);

ALTER TABLE MEMBER ADD(mem_word VARCHAR(1000)); 
ALTER TABLE MEMBER 

ALTER TABLE MEMBER MODIFY(MEM_SIZE NUMBER(10)    DEFAULT 0 NULL);

SELECT * FROM MEMBER;

ALTER TABLE MEMBER MODIFY AUTH VARCHAR(20) NULL;

DROP TABLE MEMBER;

DELETE TABLE FROM MEMBER;

COMMENT ON TABLE MEMBER is 'ȸ��';
COMMENT ON COLUMN MEMBER.MEM_NO is 'ȸ�� ��ȣ';
COMMENT ON COLUMN MEMBER.MEM_ID is '���̵�';
COMMENT ON COLUMN MEMBER.MEM_PIC is 'ȸ������';
COMMENT ON COLUMN MEMBER.MEM_SIZE is 'ȸ������ũ��';
COMMENT ON COLUMN MEMBER.MEM_PASS is '�н�����';
COMMENT ON COLUMN MEMBER.MEM_NAME is '����';
COMMENT ON COLUMN MEMBER.MEM_TEL is '��ȭ��ȣ';
COMMENT ON COLUMN MEMBER.MEM_MAIL is '�̸����ּ�';
COMMENT ON COLUMN MEMBER.MEM_JOB is 'ȸ������';
COMMENT ON COLUMN MEMBER.MEM_SEX is 'ȸ������';
COMMENT ON COLUMN MEMBER.MEM_ZIPCODE is '�����ȣ';
COMMENT ON COLUMN MEMBER.MEM_ADDR1 is '�ּ�1';
COMMENT ON COLUMN MEMBER.MEM_ADDR2 is '�ּ�2';
COMMENT ON COLUMN MEMBER.MEM_ACC is '�Ű�Ƚ��';
COMMENT ON COLUMN MEMBER.MEM_MILE is '���ϸ���';
COMMENT ON COLUMN MEMBER.AUTH_NO is 'ȸ�����ѹ�ȣ'; -- 1: ������, 2: �ΰ�����, 3: �Ϲ�ȸ��, 4: ���ȸ��, 5:������Ʈ
COMMENT ON COLUMN MEMBER.MEM_DATE is '������';

DROP TABLE member;

SELECT * FROM member;

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
INSERT INTO member(mem_no, mem_id, mem_pic, mem_size, mem_pass, mem_name, mem_tel, mem_mail, mem_job,
mem_sex, mem_zipcode, mem_addr1, mem_addr2, mem_acc, mem_mile, auth_no, mem_date)
VALUES ((SELECT NVL(MAX(mem_no), 0)+1 as mem_no FROM member),
'user53', 'hello.jpg', '15468720', '1234', '�մ���', '000-0000-0000', 'test1@gmail.com', '�л�', 'M', '12345', '����� ���α�', '��ö��', 0, 15000, 2, sysdate);

INSERT INTO member(mem_no, mem_id, mem_pic, mem_size, mem_pass, mem_name, mem_tel, mem_mail, mem_job,
mem_sex, mem_zipcode, mem_addr1, mem_addr2, mem_acc, mem_mile, auth_no, mem_date)
VALUES ((SELECT NVL(MAX(mem_no), 0)+1 as mem_no FROM member),
'admin', 'hello.jpg', '15468720', '1234', '�մ���', '000-0000-0000', 'test1@gmail.com', '�л�', 'M', '12345', '����� ���α�', '��ö��', 0, 15000, 2, sysdate);

1-2) ���
- �˻��� ���� �ʴ� ���, ��ü ��� ���

SELECT mem_no, mem_id, mem_pic, mem_size, mem_pass, mem_name, mem_tel, mem_mail, mem_job, 
mem_sex, mem_zipcode, mem_addr1, mem_addr2, mem_acc, mem_mile, auth_no, mem_date
FROM member
ORDER BY mem_no ASC;
 
  MEM_NO MEM_ID MEM_PIC        MEM_SIZE MEM_PASS MEM_NAME MEM_TEL       MEM_MAIL        MEM_JOB MEM_SEX MEM_ZIPCODE MEM_ADDR1                             MEM_ADDR2 MEM_ACC MEM_MILE AUTH_NO MEM_DATE
 ------ ------ -------------- -------- -------- -------- ------------- --------------- ------- ------- ----------- ------------------------------------- --------- ------- -------- ------- ---------------------
      3 admin  0_Koala.jpg      780831 1234     ������      010-1234-5678 test1@gmail.com ȸ���     M       12345       ��� ������ �д籸 �Ǳ����� 4 (������)               12311           0        0       1 2018-07-18 16:16:01.0
      4 user   0_Penguins.jpg   777835 1234     ������      010-1598-7532 test1@gmail.com �л�      M       12345       ��� ������ �д籸 ������ 54 (���ڵ�, �Ѽָ����ְ�6��������Ʈ) 11123           0        0       3 2018-07-18 16:18:42.0
      5 user53 hello.jpg      15468720 1234     �մ���      000-0000-0000 test1@gmail.com �л�      M       12345       ����� ���α�                               ��ö��             0    15000       1 2018-07-18 18:32:23.0

1-3) ��ȸ
* user1 ȸ�� ���� ����
SELECT mem_no, mem_id, mem_pic, mem_size, mem_pass, mem_name, mem_tel, mem_mail, mem_job,
mem_sex, mem_zipcode, mem_addr1, mem_addr2, mem_acc, mem_mile, mem_date
FROM member
WHERE mem_no = 3;
 
 MEM_NO MEM_ID MEM_PIC     MEM_SIZE MEM_PASS MEM_NAME MEM_TEL       MEM_MAIL        MEM_JOB MEM_SEX MEM_ZIPCODE MEM_ADDR1               MEM_ADDR2 MEM_ACC MEM_MILE MEM_DATE
 ------ ------ ----------- -------- -------- -------- ------------- --------------- ------- ------- ----------- ----------------------- --------- ------- -------- ---------------------
      3 admin  0_Koala.jpg   780831 1234     ������      010-1234-5678 test1@gmail.com ȸ���     M       12345       ��� ������ �д籸 �Ǳ����� 4 (������) 12311           0        0 2018-07-18 16:16:01.0

SELECT mem_no, mem_id, mem_pic, mem_size, mem_pass, mem_name, mem_tel, mem_mail, mem_job,
mem_sex, mem_zipcode, mem_addr1, mem_addr2, mem_acc, mem_mile, mem_date
FROM member
WHERE mem_id = 'admin';
 
 MEM_NO MEM_ID MEM_PIC     MEM_SIZE MEM_PASS MEM_NAME MEM_TEL       MEM_MAIL        MEM_JOB MEM_SEX MEM_ZIPCODE MEM_ADDR1               MEM_ADDR2 MEM_ACC MEM_MILE MEM_DATE
 ------ ------ ----------- -------- -------- -------- ------------- --------------- ------- ------- ----------- ----------------------- --------- ------- -------- ---------------------
      3 admin  0_Koala.jpg   780831 1234     ������      010-1234-5678 test1@gmail.com ȸ���     M       12345       ��� ������ �д籸 �Ǳ����� 4 (������) 12311           0        0 2018-07-18 16:16:01.0

1-4) ����
--�Ϲ�ȸ���� ��������
UPDATE member 
SET mem_name='ȣ����', mem_pic='hi.jpg', mem_mail='test1@yahoo.co.kr', mem_job='����', 
      mem_tel='111-1111-1111', mem_zipcode='00000', mem_addr1='��⵵', mem_addr2='���ֽ�'
WHERE mem_no=3;

UPDATE member
SET auth_no = 1
WHERE mem_id='admin';

SELECT * FROM member;

 MEM_NO MEM_ID MEM_PIC        MEM_SIZE MEM_PASS MEM_NAME MEM_TEL       MEM_MAIL        AUTH MEM_JOB MEM_SEX MEM_ZIPCODE MEM_ADDR1                             MEM_ADDR2 MEM_ACC MEM_MILE AUTH_NO MEM_DATE
 ------ ------ -------------- -------- -------- -------- ------------- --------------- -------- ------- ------- ----------- ------------------------------------- --------- ------- -------- ------- ---------------------
      4 user   0_Penguins.jpg   777835 1234     ������      010-1598-7532 test1@gmail.com NULL     �л�      M       12345       ��� ������ �д籸 ������ 54 (���ڵ�, �Ѽָ����ְ�6��������Ʈ) 11123           0        0       3 2018-07-18 16:18:42.0
      5 user53 hello.jpg      15468720 1234     �մ���      000-0000-0000 test1@gmail.com NULL     �л�      M       12345       ����� ���α�                               ��ö��             0    15000       1 2018-07-18 18:32:23.0
      3 admin  0_Koala.jpg      780831 1234     ������      010-1234-5678 test1@gmail.com NULL     ȸ���     M       12345       ��� ������ �д籸 �Ǳ����� 4 (������)               12311           0        0       1 2018-07-18 16:16:01.0

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

 MEM_NO MEM_ID MEM_PIC MEM_SIZE MEM_PASS MEM_NAME MEM_TEL       MEM_MAIL          AUTH         MEM_JOB MEM_SEX MEM_ZIPCODE MEM_ADDR1 MEM_ADDR2 MEM_ACC MEM_MILE MEM_CONFIRM AUTH_NO MEM_DATE
 ------ ------ ------- -------- -------- -------- ------------- ----------------- ---------------- ------- ------- ----------- --------- --------- ------- -------- ----------- ------- ---------------------
      1 user1  hi.jpg  15468720 0000     ȣ����      111-1111-1111 test1@yahoo.co.kr AXD0123456789012 ����      ��       00000       ��⵵       ���ֽ�             0        0 Y                 3 2018-06-21 15:05:42.0

1-6) ����
* ��� ����
DELETE FROM member;

DELETE FROM LOGIN;
 
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

SELECT login_no, mem_no, login_ip, login_date, login_agent
    FROM login
    WHERE mem_no=18
    ORDER BY login_no DESC;

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

SELECT COUNT(*) as cnt
FROM login
WHERE 1=1;

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

3-1) ���� ���̺� ����
CREATE TABLE AUTH(
    AUTH_NO               NUMBER(10)    NOT NULL    PRIMARY KEY,
    AUTH_INFO             VARCHAR2(100)    NOT NULL,
    AUTH_SEQNO          NUMBER(7)    DEFAULT 0     NOT NULL,
    AUTH_RDATE           DATE     NOT NULL
);

COMMENT ON TABLE AUTH is '���ѱ׷�';
COMMENT ON COLUMN AUTH.AUTH_NO is '���ѹ�ȣ';
COMMENT ON COLUMN AUTH.AUTH_INFO is '��������';
COMMENT ON COLUMN AUTH.AUTH_SEQNO is '��¼���';
COMMENT ON COLUMN AUTH.AUTH_RDATE is '�������';

3-2) insert
- AUTH_INFO 1-������, 2-�ΰ�����, 3-�Ϲ�ȸ��, 4-���ȸ��, 5-������Ʈ

INSERT INTO auth(auth_no, auth_info, auth_seqno, auth_rdate)
VALUES(1, '������', 1, sysdate);

3-3) �Ϸù�ȣ�� �ڵ� ����
SELECT categrpno FROM categrp;

 CATEGRPNO
 ---------------

SELECT MAX(categrpno) FROM categrp; 
 
 MAX(CATEGRPNO)
 ----------------------
           NULL
           
SELECT MAX(categrpno) + 1 FROM categrp;           
           
 MAX(CATEGRPNO)+1
 --------------------------
             NULL

- null�� �÷��� ���� 0���� ������ ����
SELECT NVL(MAX(categrpno), 0) + 1 FROM categrp;

 NVL(MAX(CATEGRPNO),0)+1 <-- �÷����� �ʹ� ŭ
 -----------------------------------
                       1
                       
SELECT NVL(MAX(categrpno), 0) + 1 as categrpno FROM categrp;                       

 CATEGRPNO
 ---------------
         1
         
delete from auth
         
INSERT INTO auth(auth_no, auth_info, auth_seqno, auth_rdate)
VALUES(1, '�ְ������', 0, sysdate);

INSERT INTO auth(auth_no, auth_info, auth_seqno, auth_rdate)
VALUES((SELECT NVL(MAX(auth_no), 99) + 1 as auth_no FROM auth), '���ȸ��', 1, sysdate);

INSERT INTO auth(auth_no, auth_info, auth_seqno, auth_rdate)
VALUES((SELECT NVL(MAX(auth_no), 99) + 1 as auth_no FROM auth), '�Ϲ�ȸ��', 2, sysdate);

INSERT INTO auth(auth_no, auth_info, auth_seqno, auth_rdate)
VALUES((SELECT NVL(MAX(auth_no), 99) + 1 as auth_no FROM auth), '�մ�', 3, sysdate);
         
INSERT INTO auth(auth_no, auth_info, auth_seqno, auth_rdate)
VALUES((SELECT NVL(MAX(auth_no), 99) + 1 as auth_no FROM auth), '������Ʈ', 4, sysdate);
         
delete from auth;
select * from auth;
select * from member;
update member set auth_no = 1 where mem_id = 'admin';



3-4) ���
SELECT auth_no, auth_info, auth_seqno, auth_rdate
FROM auth
ORDER BY auth_no ASC;

 AUTH_NO AUTH_INFO AUTH_SEQNO AUTH_RDATE
 ------- --------- ---------- ---------------------
       1 ������                1 2018-07-18 16:07:15.0
       2 �ΰ�����               1 2018-07-18 16:07:16.0
       3 �Ϲ�ȸ��               1 2018-07-18 16:07:17.0
       4 ���ȸ��               1 2018-07-18 16:07:18.0
       5 ������Ʈ              1 2018-07-18 16:07:19.0
 
3-5) ��ȸ
SELECT auth_no, auth_info, auth_seqno, auth_rdate
FROM auth
WHERE auth_no = 1;
  
3-6) ����
UPDATE auth
SET auth_info='����ȸ��', auth_seqno = 1
WHERE auth_no = 4;

SELECT auth_no, auth_info, auth_seqno, auth_rdate
FROM auth
ORDER BY auth_no ASC;

 AUTH_NO AUTH_INFO AUTH_SEQNO AUTH_RDATE
 ------- --------- ---------- ---------------------
       1 ������                1 2018-07-18 16:07:15.0
       2 �ΰ�����               1 2018-07-18 16:07:16.0
       3 �Ϲ�ȸ��               1 2018-07-18 16:07:17.0
       4 ����ȸ��               1 2018-07-18 16:07:18.0
       5 ������Ʈ              1 2018-07-18 16:07:19.0
 
3-7) ����
DELETE FROM auth
WHERE auth_no = 5;

4-1) �����ּ� ���̺� ����
CREATE TABLE URL(
    URL_NO               NUMBER(10)    NOT NULL    PRIMARY KEY,
    URL             VARCHAR(300)    NOT NULL,
    URL_INFO      VARCHAR(300)    NULL,
    URL_SEQNO   NUMBER(7)    DEFAULT 0     NOT NULL,
    URL_RDATE           DATE     NOT NULL
);

COMMENT ON TABLE URL is '�����ּ����̺�';
COMMENT ON COLUMN URL.URL_NO is '�����ּҹ�ȣ';
COMMENT ON COLUMN URL.URL is '�����ּ�';
COMMENT ON COLUMN URL.URL_INFO is '�����ּ�����';
COMMENT ON COLUMN URL.URL_SEQNO is '��¼���';
COMMENT ON COLUMN URL.URL_RDATE is '�������';

4-2) insert
- ������ url��ȣ�Է�

4-3) �Ϸù�ȣ�� �ڵ� ����
SELECT categrpno FROM categrp;

 CATEGRPNO
 ---------------

SELECT MAX(categrpno) FROM categrp; 
 
 MAX(CATEGRPNO)
 ----------------------
           NULL
           
SELECT MAX(categrpno) + 1 FROM categrp;           
           
 MAX(CATEGRPNO)+1
 --------------------------
             NULL

- null�� �÷��� ���� 0���� ������ ����
SELECT NVL(MAX(categrpno), 0) + 1 FROM categrp;

 NVL(MAX(CATEGRPNO),0)+1 <-- �÷����� �ʹ� ŭ
 -----------------------------------
                       1
                       
SELECT NVL(MAX(categrpno), 0) + 1 as categrpno FROM categrp;                       

 CATEGRPNO
 ---------------
         1

INSERT INTO url(url_no, url, url_info, url_seqno, url_rdate)
VALUES((SELECT NVL(MAX(url_no), 0) + 1 as url_no FROM url), '/member/passwd_update.do', '�н����� ���� ������', 1, sysdate);

INSERT INTO url(url_no, url, url_info, url_seqno, url_rdate)
VALUES((SELECT NVL(MAX(url_no), 0) + 1 as url_no FROM url), '/member/list_by_member.do', 'ȸ�����������', 1, sysdate);

INSERT INTO url(url_no, url, url_info, url_seqno, url_rdate)
VALUES((SELECT NVL(MAX(url_no), 0) + 1 as url_no FROM url), '/member/list_by_login_admin.do', 'ȸ�� �α��� ��� ��ȸ������',1, sysdate);

4-4) ���
SELECT url_no, url, url_info, url_seqno, url_rdate
FROM url
ORDER BY url_no ASC;

 URL_NO URL                            URL_INFO        URL_SEQNO URL_RDATE
 ------ ------------------------------ --------------- --------- ---------------------
      1 /member/passwd_update.do       �н����� ���� ������             1 2018-07-18 17:27:22.0
      2 /member/list_by_member.do      ȸ�����������                 1 2018-07-18 17:27:23.0
      3 /member/list_by_login_admin.do ȸ�� �α��� ��� ��ȸ������         1 2018-07-18 17:27:24.0

 
4-5) ��ȸ
SELECT url_no, url, url_info, url_seqno, url_rdate
FROM url
WHERE url_no=1;
  
4-6) ����
UPDATE url
SET url='/member/delete_confirm.jsp', url_info = 'ȸ��Ż�� ���������'
WHERE url_no = 3;

SELECT url_no, url, url_info, url_seqno, url_rdate
FROM url
ORDER BY url_no ASC;

 URL_NO URL                        URL_INFO    URL_SEQNO URL_RDATE
 ------ -------------------------- ----------- --------- ---------------------
      1 /member/passwd_update.do   �н����� ���� ������         1 2018-07-18 17:27:22.0
      2 /member/list_by_member.do  ȸ�����������             1 2018-07-18 17:27:23.0
      3 /member/delete_confirm.jsp ȸ��Ż�� ���������          1 2018-07-18 17:27:24.0

4-7) ����
DELETE FROM url
WHERE url_no = 3;

5-1) ȸ�� ���Ѻ� ���� URL ���̺� ����, count ���
CREATE TABLE ACCESS_URL(
    ACCESS_URL_NO               NUMBER(10)    NOT NULL    PRIMARY KEY,
    AUTH_NO               NUMBER(10)    NOT NULL,
    URL_NO               NUMBER(10)    NOT NULL,
    ACCESS_URL_INFO      VARCHAR(300)    NULL,
    ACCESS_URL_SEQNO   NUMBER(7)    DEFAULT 0     NOT NULL,
    ACCESS_URL_RDATE           DATE     NOT NULL,
    FOREIGN KEY (AUTH_NO) REFERENCES AUTH(AUTH_NO),
    FOREIGN KEY (URL_NO) REFERENCES URL(URL_NO)
);

COMMENT ON TABLE ACCESS_URL is '���Ѻ������ּ����̺�';
COMMENT ON COLUMN ACCESS_URL.ACCESS_URL_NO is '���Ѻ������ּҹ�ȣ';
COMMENT ON COLUMN ACCESS_URL.AUTH_NO is '���ѹ�ȣ';
COMMENT ON COLUMN ACCESS_URL.URL_NO is '�����ּҹ�ȣ';
COMMENT ON COLUMN ACCESS_URL.ACCESS_URL_INFO is '�����ּ�����';
COMMENT ON COLUMN ACCESS_URL.ACCESS_URL_SEQNO is '��¼���';
COMMENT ON COLUMN ACCESS_URL.ACCESS_URL_RDATE is '�������';

5-2) �Է�
INSERT INTO access_url(access_url_no, auth_no, url_no, access_url_info, access_url_seqno, access_url_rdate)
VALUES((SELECT NVL(MAX(access_url_no), 0) + 1 as access_url_no FROM access_url), 
            1, 1, '������-�н����庯�������� ����', 1, sysdate);

INSERT INTO access_url(access_url_no, auth_no, url_no, access_url_info, access_url_seqno, access_url_rdate)
VALUES((SELECT NVL(MAX(access_url_no), 0) + 1 as access_url_no FROM access_url), 
            2, 1, '�ΰ�����-�н����庯�������� ����', 1, sysdate);
            
INSERT INTO access_url(access_url_no, auth_no, url_no, access_url_info, access_url_seqno, access_url_rdate)
VALUES((SELECT NVL(MAX(access_url_no), 0) + 1 as access_url_no FROM access_url), 
            2, 2, '�ΰ�����-ȸ����������� ����', 1, sysdate);
            
5-3) ���
SELECT access_url_no, auth_no, url_no, access_url_info, access_url_seqno, access_url_rdate
FROM access_url
ORDER BY access_url_no ASC;

 ACCESS_URL_NO AUTH_NO URL_NO ACCESS_URL_INFO   ACCESS_URL_SEQNO ACCESS_URL_RDATE
 ------------- ------- ------ ----------------- ---------------- ---------------------
             1       1      1 ������-�н����庯�������� ����                 1 2018-07-18 18:10:47.0
             2       2      1 �ΰ�����-�н����庯�������� ����                1 2018-07-18 18:10:48.0
             3       2      2 �ΰ�����-ȸ����������� ����                  1 2018-07-18 18:10:49.0
            
5-4) ���� ����(1 : ���� ����, 0 : ���� �Ұ�)
SELECT COUNT(access_url_no) as cnt
FROM access_url
WHERE auth_no=2 AND url_no=2;

 CNT
 ---
   1
   
SELECT COUNT(access_url_no) as cnt
FROM access_url
WHERE auth_no=3 AND url_no=2;

 CNT
 ---
   0

5-5) ��ȸ
SELECT access_url_no, auth_no, url_no, access_url_info, access_url_seqno, access_url_rdate
FROM access_url
WHERE auth_no = 2
ORDER BY access_url_no ASC;

 ACCESS_URL_NO AUTH_NO URL_NO ACCESS_URL_INFO   ACCESS_URL_SEQNO ACCESS_URL_RDATE
 ------------- ------- ------ ----------------- ---------------- ---------------------
             2       2      1 �ΰ�����-�н����庯�������� ����                1 2018-07-18 18:10:48.0
             3       2      2 �ΰ�����-ȸ����������� ����                  1 2018-07-18 18:10:49.0

5-6) ����
UPDATE access_url
SET auth_no=1
WHERE access_url_no = 3;

SELECT access_url_no, auth_no, url_no, access_url_info, access_url_seqno, access_url_rdate
FROM access_url
ORDER BY access_url_no ASC;

 ACCESS_URL_NO AUTH_NO URL_NO ACCESS_URL_INFO   ACCESS_URL_SEQNO ACCESS_URL_RDATE
 ------------- ------- ------ ----------------- ---------------- ---------------------
             1       1      1 ������-�н����庯�������� ����                 1 2018-07-18 18:10:47.0
             2       2      1 �ΰ�����-�н����庯�������� ����                1 2018-07-18 18:10:48.0
             3       1      2 �ΰ�����-ȸ����������� ����                  1 2018-07-18 18:10:49.0

5-7) ����
DELETE FROM access_url
WHERE url_no = 3;
