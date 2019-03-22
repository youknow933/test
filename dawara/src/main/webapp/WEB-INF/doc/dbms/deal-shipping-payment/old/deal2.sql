DROP TABLE receive CASCADE CONSTRAINTS;
DROP TABLE delivery CASCADE CONSTRAINTS;
DROP TABLE payment CASCADE CONSTRAINTS;
DROP TABLE deal CASCADE CONSTRAINTS;
DROP TABLE product CASCADE CONSTRAINTS;
DROP TABLE charge CASCADE CONSTRAINTS;
DROP TABLE mlieage CASCADE CONSTRAINTS;
DROP TABLE member CASCADE CONSTRAINTS;

INSERT INTO auth(auth_no, auth_info) VALUES(1, '������');
INSERT INTO member(mem_no, auth_no, mem_id, mem_pass, mem_name, mem_tel, mem_mail, mem_job, mem_acc, mem_confirm, mem_date) 
VALUES((SELECT nvl(MAX(mem_no), 0) + 1 as mem_no FROM member), 1, 'schyyy', '123', 'SCH', '01022220000', 'schyyy@naver.com', '�л�', 0, 'Y', SYSDATE);
INSERT INTO member(mem_no, auth_no, mem_id, mem_pass, mem_name, mem_tel, mem_mail, mem_job, mem_acc, mem_confirm, mem_date) 
VALUES((SELECT nvl(MAX(mem_no), 0) + 1 as mem_no FROM member), 1, 'BUYBUYBUY', '123', 'BUY', '01033330000', 'buy@naver.com', '�л�', 0, 'Y', SYSDATE);
INSERT INTO categrp(grp_no, grp_classification, grp_title, grp_seqno, grp_visible, grp_rdate) VALUES((SELECT NVL(MAX(grp_no), 0)+1 as grp_no FROM categrp), 1, 'SAMSUNG�ÿ�����9', 1, 'Y', sysdate);
INSERT INTO category(gory_no, grp_no, mem_no, gory_title, gory_seqno, gory_visible, gory_ids, gory_cnt, gory_rdate) VALUES((SELECT NVL(MAX(gory_no), 0)+1 as gory_no FROM category), 1, 1, '�Ｚ', 0, 'Y', 'ad', 1, sysdate);
INSERT INTO product(pr_no, pr_maker, pr_title, pr_contents, pr_cnt, pr_rdate, pr_price, pr_visible, pr_payment) VALUES((SELECT nvl(MAX(pr_no), 0) + 1 as pr_no FROM product), 'LG', '�׷��˴ϴ�', '2018�� �õ��̱׷� �Ǹ�', 0, SYSDATE, 1000000, 'Y', 'Y');
INSERT INTO buy(mem_no, pr_no, mem_no, buy_rdate) VALUES((SELECT nvl(MAX(mem_no), 0) + 1 as mem_no FROM buy), 1, 1, SYSDATE);

select * from member;

/**********************************/
/* Table Name: ��ǰ �ŷ� */
/**********************************/
CREATE TABLE deal(
    deal_no                           NUMBER(10)     NOT NULL PRIMARY KEY,
    d_state                           VARCHAR2(20)     NOT NULL,
    d_way                             VARCHAR2(20)     NOT NULL,
    d_check                           CHAR(1)    DEFAULT 'N'     NULL ,
    d_date                            DATE     NOT NULL,
    mem_no                            NUMBER(10)     NULL ,
    pr_no                             NUMBER(10)     NULL ,
  FOREIGN KEY (mem_no) REFERENCES buy (mem_no),
  FOREIGN KEY (pr_no) REFERENCES product (pr_no)
);

COMMENT ON TABLE deal is '��ǰ �ŷ�';
COMMENT ON COLUMN deal.deal_no is '�ŷ���ȣ';
COMMENT ON COLUMN deal.d_state is '�ŷ�����';
COMMENT ON COLUMN deal.d_way is '�ŷ����';
COMMENT ON COLUMN deal.d_check is '�ŷ�Ȯ��';
COMMENT ON COLUMN deal.d_date is '�ŷ������';
COMMENT ON COLUMN deal.mem_no is '���Ź�ȣ';
COMMENT ON COLUMN deal.pr_no is '��ǰ��ȣ';

SELECT deal_no, d_state, d_way, d_check, d_date, mem_no, pr_no
FROM deal;

 DEAL_NO D_STATE D_WAY D_CHECK D_DATE                MEM_NO PR_NO
 ------- ------- ----- ------- --------------------- ------ -----
       3 �ŷ�������   �ù�ŷ�  N       2018-07-01 16:38:35.0      4     3
       1 �ŷ���     �ù�ŷ�  N       2018-07-03 16:38:33.0      3     1
       2 �ŷ���     ���ŷ�   N       2018-07-02 16:38:34.0      2     2

SELECT p.pr_no, p.pr_title, p.pr_price, p.mem_no as seller_no,
      (SELECT distinct m.mem_name FROM member m, product p WHERE p.mem_no = m.mem_no) as seller,
      d.deal_no, d.d_state, d.d_way, d.d_check,  d.mem_no as buyer_no,
      (SELECT distinct m.mem_name FROM member m, deal p WHERE d.mem_no = m.mem_no) as buyer
FROM product p, deal d
where p.pr_no = d.pr_no
ORDER BY d.deal_no;

 PR_NO PR_TITLE                    PR_PRICE SELLER_NO SELLER DEAL_NO D_STATE    D_WAY    D_CHECK BUYER_NO BUYER
 ----- --------------------------- -------- --------- ------ ------- ---------- -------- ------- -------- -----
     1 [�Ｚ����]PEN NT930QAA-K28A 800              1 SCH          1 �ŷ���     �ù�ŷ� N              3 NNN
     2 [LG] 2018 �׷� 14��ġ       800              1 SCH          2 �ŷ���     ���ŷ�   N              2 YYY
     3 [DELL] XPS 13               800              1 SCH          3 �ŷ������� �ù�ŷ� N              4 BUY

select * from product;

 PR_NO GORY_NO MEM_NO PR_TITLE                PR_CONTENTS PR_THUMBS PR_FILES PR_SIZES PR_CNT PR_RDATE              PR_BUYYEAR            PR_STATE PR_TRANSACTION PR_LOCAL PR_BUYPRICE PR_PRICE PR_VISIBLE PR_PAYMENT
 ----- ------- ------ ----------------------- ----------- --------- -------- -------- ------ --------------------- --------------------- -------- -------------- -------- ----------- -------- ---------- ----------
     3       1      1 [DELL] XPS 13           ũ���������� ������  NULL      NULL     NULL          0 2018-07-04 16:35:39.0 2017-01-01 00:00:00.0 �߰�       ���ŷ�            ����/����           1000      800 Y          N
     4       1      1 [MS] ���ǽ���ž2             ũ���������� ������  NULL      NULL     NULL          0 2018-07-04 16:35:55.0 2017-01-01 00:00:00.0 �߰�       ���ŷ�            ����/����           1000      800 Y          N
     1       1      1 [�Ｚ����]PEN NT930QAA-K28A ũ���������� ������  NULL      NULL     NULL          0 2018-07-04 16:34:52.0 2017-01-01 00:00:00.0 �߰�       ���ŷ�            ����/����           1000      800 Y          N
     2       1      1 [LG] 2018 �׷� 14��ġ       ũ���������� ������  NULL      NULL     NULL          0 2018-07-04 16:35:15.0 2017-01-01 00:00:00.0 �߰�       ���ŷ�            ����/����           1000      800 Y          N


DELETE FROM deal;

1) �ŷ� �� �� ���� ���


INSERT INTO deal(deal_no, d_state, d_way, d_date, mem_no, pr_no)
VALUES ((SELECT nvl(MAX(deal_no), 0) + 1 as deal_no FROM deal), '�ŷ���', '�ù�ŷ�', SYSDATE-1, 3, 1);

INSERT INTO deal(deal_no, d_state, d_way, d_date, mem_no, pr_no)
VALUES ((SELECT nvl(MAX(deal_no), 0) + 1 as deal_no FROM deal), '�ŷ���', '�ù�ŷ�', SYSDATE-2, 2, 2);

INSERT INTO deal(deal_no, d_state, d_way, d_date, mem_no, pr_no)
VALUES ((SELECT nvl(MAX(deal_no), 0) + 1 as deal_no FROM deal), '�ŷ���', '�ù�ŷ�', SYSDATE-3, 4, 3);

INSERT INTO deal(deal_no, d_state, d_way, d_date, mem_no, pr_no)
VALUES ((SELECT nvl(MAX(deal_no), 0) + 1 as deal_no FROM deal), '�ŷ���', '�ù�ŷ�', SYSDATE-3, 4, 4);

----------------------------------------------------------------------------------------

2) ��ȸ
select DEAL_NO, D_STATE, D_WAY, D_CHECK, D_DATE, mem_no, PR_NO from deal;

 DEAL_NO D_STATE  D_WAY    D_CHECK D_DATE                mem_no PR_NO
 ------- -------- -------- ------- --------------------- ------ -----
       1 �ŷ���   �ù�ŷ� N       2018-06-22 19:12:53.0      1     1
       2 �ŷ���   �ù�ŷ� N       2018-06-25 17:10:55.0      1     1
       3 �ŷ���   �ù�ŷ� N       2018-06-25 17:41:49.0      1     1
      12 �ŷ��Ϸ� ���ŷ�   N       2018-06-26 15:56:10.0      1     1
      13 �ŷ���   ���ŷ�   N       2018-06-26 15:56:19.0      1     1
       
-- �ù�ŷ� ��ȸ
select DEAL_NO, D_STATE, D_WAY, D_CHECK, D_DATE, mem_no, PR_NO 
from deal
WHERE D_WAY = '�ù�ŷ�';

 DEAL_NO D_STATE D_WAY    D_CHECK D_DATE                mem_no PR_NO
 ------- ------- -------- ------- --------------------- ------ -----
       1 �ŷ���  �ù�ŷ� N       2018-06-22 19:12:53.0      1     1
       2 �ŷ���  �ù�ŷ� N       2018-06-25 17:10:55.0      1     1
       3 �ŷ���  �ù�ŷ� N       2018-06-25 17:41:49.0      1     1

-- ���ŷ� ��ȸ
select DEAL_NO, D_STATE, D_WAY, D_CHECK, D_DATE, mem_no, PR_NO 
from deal
WHERE D_WAY = '���ŷ�';
     
 DEAL_NO D_STATE  D_WAY  D_CHECK D_DATE                mem_no PR_NO
 ------- -------- ------ ------- --------------------- ------ -----
      12 �ŷ��Ϸ� ���ŷ� N       2018-06-26 15:56:10.0      1     1
      13 �ŷ���   ���ŷ� N       2018-06-26 15:56:19.0      1     1

---------------------------------------------------------------------------------------

3) ����      
-- �ŷ� ����      
UPDATE deal
SET d_state='�ŷ��Ϸ�', d_way='�ù�ŷ�', d_check='Y'
WHERE deal_no = 12
     
4) ����
-- �� ���� �ŷ� ����       
DELETE FROM deal
WHERE deal_no = 3;

---------------------------------------------------------------------------------------

5) �˻�

-- '�ù�' �˻�
SELECT DEAL_NO, D_STATE, D_WAY, D_CHECK, D_DATE, mem_no, PR_NO 
FROM deal
WHERE d_way LIKE '%�ù�%'
ORDER BY DEAL_NO DESC
;

 DEAL_NO D_STATE    D_WAY    D_CHECK D_DATE                mem_no PR_NO
 ------- ---------- -------- ------- --------------------- ------ -----
       6 �ŷ��Ϸ�   �ù�ŷ� N       2018-06-29 19:05:19.0      1     1
       5 ����Ȯ���� �ù�ŷ� N       2018-06-29 19:05:15.0      1     1
       4 �����     �ù�ŷ� N       2018-06-29 19:05:12.0      1     1
       3 �ŷ������� �ù�ŷ� N       2018-06-29 19:05:08.0      1     1
       2 ������     �ù�ŷ� N       2018-06-29 19:05:00.0      1     1
       1 �ŷ���     �ù�ŷ� N       2018-06-28 17:45:40.0      1     1

-- '����' �˻�
SELECT DEAL_NO, D_STATE, D_WAY, D_CHECK, D_DATE, mem_no, PR_NO 
FROM deal
WHERE d_state LIKE '%����%'
ORDER BY DEAL_NO DESC
;

 DEAL_NO D_STATE D_WAY    D_CHECK D_DATE                mem_no PR_NO
 ------- ------- -------- ------- --------------------- ------ -----
       7 ������  �ù�ŷ� N       2018-06-29 19:06:40.0      1     1
       2 ������  �ù�ŷ� N       2018-06-29 19:05:00.0      1     1


-- '�Ϸ�' �˻�
SELECT DEAL_NO, D_STATE, D_WAY, D_CHECK, D_DATE, mem_no, PR_NO 
FROM deal
WHERE d_state LIKE '%�Ϸ�%' 
ORDER BY DEAL_NO DESC
;

 DEAL_NO D_STATE  D_WAY    D_CHECK D_DATE                mem_no PR_NO
 ------- -------- -------- ------- --------------------- ------ -----
       8 �ŷ��Ϸ� �ù�ŷ� N       2018-06-29 19:07:08.0      1     1
       6 �ŷ��Ϸ� �ù�ŷ� N       2018-06-29 19:05:19.0      1     1

-- �ŷ� ��¥ '6�� 28��' �˻�
SELECT DEAL_NO, D_STATE, D_WAY, D_CHECK, D_DATE, mem_no, PR_NO 
FROM deal
WHERE TO_CHAR(d_date, 'MMDD') = '0628'
ORDER BY DEAL_NO DESC
;       

-- �ŷ� ��¥ '6�� 28��' �˻�
SELECT DEAL_NO, D_STATE, D_WAY, D_CHECK, D_DATE, mem_no, PR_NO 
FROM deal
WHERE TO_CHAR(d_date, 'MMDD') = '0628'
ORDER BY DEAL_NO DESC
;

-- TO_CHAR(d_date, 'MMDD')
-- YYYYMMDDHH24MISS
-- YYYYMMDDHH12MISS

-- 2���� Ư����¥ ������ ������
-- YYYYMMDD�� �ϸ� �� �κ�(�ú���)�� 0���� ����
-- M_TIME  between to_date('20031112', 'YYYYMMDD') and to_date('20031114', 'YYYYMMDD') + 1
-- �� �ϸ� 12��, 13�� 14�� ��ΰ� ����

SELECT DEAL_NO, D_STATE, D_WAY, D_CHECK, D_DATE, mem_no, PR_NO 
FROM deal
WHERE d_date between to_date('180628', 'YYMMDD') and to_date('180629', 'YYMMDD') -- (180628 00:00:00 ~ 180629 00:00:00) => 180628
ORDER BY DEAL_NO DESC
;

 DEAL_NO D_STATE D_WAY D_CHECK D_DATE                mem_no PR_NO
 ------- ------- ----- ------- --------------------- ------ -----
       1 �ŷ���  �ù�ŷ�  N   2018-06-28 17:45:40.0      1     1

-- 180628 ~ 180629 �ŷ� �˻�
       
SELECT DEAL_NO, D_STATE, D_WAY, D_CHECK, D_DATE, mem_no, PR_NO
FROM deal
WHERE d_date between to_date('180629', 'YYMMDD') and to_date('180629', 'YYMMDD') + 1
ORDER BY DEAL_NO DESC
;

 DEAL_NO D_STATE D_WAY  D_CHECK D_DATE                MEM_NO PR_NO
 ------- ------- ------ ------- --------------------- ------ -----
       5 �ŷ���  ���ŷ� N       2018-06-29 15:37:52.0      2     1
       4 �ŷ���  ���ŷ� N       2018-06-29 15:37:51.0      2     1

       
6) ��¥ �˻� �� ��ü ���ڵ� ����
-- �˻����� �ʴ� ��� ��ü ���ڵ� ����
SELECT COUNT(*) as cnt
FROM deal
WHERE 1= 1

 CNT
 ---
   8
   
-- '180628~180628' �˻� ���ڵ� ����
SELECT COUNT(*) as cnt
FROM deal
WHERE d_date between to_date('180628', 'YYMMDD') and to_date('180628', 'YYMMDD') + 1
       
 CNT
 ---
   1
   
---------------------------------------------------------------------------------------

7) ����¡

       