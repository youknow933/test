DROP TABLE receive CASCADE CONSTRAINTS;
DROP TABLE delivery CASCADE CONSTRAINTS;
DROP TABLE payment CASCADE CONSTRAINTS;
DROP TABLE deal CASCADE CONSTRAINTS;
DROP TABLE product CASCADE CONSTRAINTS;
DROP TABLE charge CASCADE CONSTRAINTS;
DROP TABLE mlieage CASCADE CONSTRAINTS;
DROP TABLE member CASCADE CONSTRAINTS;

INSERT INTO auth(auth_no, auth_info) VALUES(1, '������');
INSERT INTO member(mem_no, auth_no, mem_id, mem_pass, mem_name, mem_tel, mem_mail, mem_job, mem_acc, mem_confirm, mem_date) VALUES((SELECT nvl(MAX(mem_no), 0) + 1 as mem_no FROM member), 1, 'schyyy', '123', 'SCH', '01022220000', 'schyyy@naver.com', '�л�', 0, 'Y', SYSDATE);
INSERT INTO member(mem_no, auth_no, mem_id, mem_pass, mem_name, mem_tel, mem_mail, mem_job, mem_acc, mem_confirm, mem_date) VALUES((SELECT nvl(MAX(mem_no), 0) + 1 as mem_no FROM member), 1, 'buyer', '123', 'BYU', '01033330000', 'buyer@naver.com', '�л�', 0, 'Y', SYSDATE);
INSERT INTO categrp(grp_no, grp_classification, grp_title, grp_seqno, grp_visible, grp_rdate) VALUES((SELECT NVL(MAX(grp_no), 0)+1 as grp_no FROM categrp), 1, 'SAMSUNG�ÿ�����9', 1, 'Y', sysdate);
INSERT INTO category(gory_no, grp_no, mem_no, gory_title, gory_seqno, gory_visible, gory_ids, gory_cnt, gory_rdate) VALUES((SELECT NVL(MAX(gory_no), 0)+1 as gory_no FROM category), 1, 1, '�Ｚ', 0, 'Y', 'ad', 1, sysdate);
INSERT INTO product(pr_no, pr_maker, pr_title, pr_contents, pr_cnt, pr_rdate, pr_price, pr_visible, pr_payment) VALUES((SELECT nvl(MAX(pr_no), 0) + 1 as pr_no FROM product), 'LG', '�׷��˴ϴ�', '2018�� �õ��̱׷� �Ǹ�', 0, SYSDATE, 1000000, 'Y', 'Y');

/**********************************/
/* Table Name: ��ǰ �ŷ� */
/**********************************/
CREATE TABLE DEAL(
    deal_no      NUMBER(10)                            NOT NULL    PRIMARY KEY,
    d_state      VARCHAR2(20)     DEFAULT '�ŷ���'     NOT NULL,
    d_way        VARCHAR2(20)     DEFAULT '�ù�ŷ�'   NOT NULL,
    d_date       DATE                                  NOT NULL,
    d_check      CHAR(1)          DEFAULT 'N'          NOT NULL,
    d_memo       VARCHAR2(100)    DEFAULT '�޸�'       NULL ,
    mem_no       NUMBER(6)                             NOT NULL,
    pr_no        NUMBER(10)                            NOT NULL,
  FOREIGN KEY (mem_no) REFERENCES MEMBER (MEM_NO),
  FOREIGN KEY (pr_no) REFERENCES PRODUCT (PR_NO)
);

COMMENT ON TABLE DEAL is '��ǰ �ŷ�';
COMMENT ON COLUMN DEAL.deal_no is '�ŷ���ȣ';
COMMENT ON COLUMN DEAL.d_state is '�ŷ�����';
COMMENT ON COLUMN DEAL.d_way is '�ŷ����';
COMMENT ON COLUMN DEAL.d_date is '�ŷ������';
COMMENT ON COLUMN DEAL.d_check is '�ŷ�Ȯ��';
COMMENT ON COLUMN DEAL.d_memo is '�ŷ��޸�';
COMMENT ON COLUMN DEAL.mem_no is 'ȸ����ȣ';
COMMENT ON COLUMN DEAL.pr_no is '��ǰ��ȣ';

SELECT deal_no, d_state, d_way, d_check, d_date, d_check, mem_no, pr_no
FROM deal;

DELETE FROM deal;

----------------------------------------------------------------------------------------
1) �ŷ� �� �� ���� ���
----------------------------------------------------------------------------------------
INSERT INTO deal(deal_no, d_state, d_way, d_date, mem_no, pr_no)
VALUES ((SELECT nvl(MAX(deal_no), 0) + 1 as deal_no FROM deal), '�ŷ���', '�ù�ŷ�', SYSDATE-1, 2, 1);

INSERT INTO deal(deal_no, d_state, d_way, d_date, mem_no, pr_no)
VALUES ((SELECT nvl(MAX(deal_no), 0) + 1 as deal_no FROM deal), '�ŷ���', '�ù�ŷ�', SYSDATE-1, 2, 1);

INSERT INTO deal(deal_no, d_state, d_way, d_date, mem_no, pr_no)
VALUES ((SELECT nvl(MAX(deal_no), 0) + 1 as deal_no FROM deal), '�ŷ���', '���ŷ�', SYSDATE-2, 2, 1);

INSERT INTO deal(deal_no, d_state, d_way, d_date, mem_no, pr_no)
VALUES ((SELECT nvl(MAX(deal_no), 0) + 1 as deal_no FROM deal), '�ŷ���', '���ŷ�', SYSDATE-3, 2, 1);

INSERT INTO deal(deal_no, d_state, d_way, d_date, mem_no, pr_no)
VALUES ((SELECT nvl(MAX(deal_no), 0) + 1 as deal_no FROM deal), '�ŷ���', '���ŷ�', SYSDATE-3, 2, 1);

----------------------------------------------------------------------------------------
2) ���
----------------------------------------------------------------------------------------
select DEAL_NO, D_STATE, D_WAY, D_CHECK, D_DATE, d_check, d_memo, mem_no, PR_NO 
from deal;

 DEAL_NO D_STATE D_WAY    D_CHECK D_DATE                D_CHECK D_MEMO MEM_NO PR_NO
 ------- ------- -------- ------- --------------------- ------- ------ ------ -----
       1 �ŷ���  �ù�ŷ� N       2018-07-01 15:37:48.0 N       �޸�        2     1
       2 �ŷ���  �ù�ŷ� N       2018-07-01 15:37:49.0 N       �޸�        2     1
       3 �ŷ���  ���ŷ�   N       2018-06-30 15:37:50.0 N       �޸�        2     1
       4 �ŷ���  ���ŷ�   N       2018-06-29 15:37:51.0 N       �޸�        2     1
       5 �ŷ���  ���ŷ�   N       2018-06-29 15:37:52.0 N       �޸�        2     1
       
-- �ù�ŷ� ��ȸ
select DEAL_NO, D_STATE, D_WAY, D_CHECK, D_DATE, d_check, d_memo, mem_no, PR_NO
from deal
WHERE D_WAY = '�ù�ŷ�';

 DEAL_NO D_STATE D_WAY    D_CHECK D_DATE                D_CHECK D_MEMO MEM_NO PR_NO
 ------- ------- -------- ------- --------------------- ------- ------ ------ -----
       1 �ŷ���  �ù�ŷ� N       2018-07-01 15:37:48.0 N       �޸�        2     1
       2 �ŷ���  �ù�ŷ� N       2018-07-01 15:37:49.0 N       �޸�        2     1

-- ���ŷ� ��ȸ
select DEAL_NO, D_STATE, D_WAY, D_CHECK, D_DATE, d_check, d_memo, mem_no, PR_NO
from deal
WHERE D_WAY = '���ŷ�';
     
 DEAL_NO D_STATE D_WAY  D_CHECK D_DATE                D_CHECK D_MEMO MEM_NO PR_NO
 ------- ------- ------ ------- --------------------- ------- ------ ------ -----
       3 �ŷ���  ���ŷ� N       2018-06-30 15:37:50.0 N       �޸�        2     1
       4 �ŷ���  ���ŷ� N       2018-06-29 15:37:51.0 N       �޸�        2     1
       5 �ŷ���  ���ŷ� N       2018-06-29 15:37:52.0 N       �޸�        2     1


---------------------------------------------------------------------------------------
3) ����      
---------------------------------------------------------------------------------------
-- �ŷ� �Ϸ�� ����      
UPDATE deal
SET d_state='�ŷ��Ϸ�', d_way='�ù�ŷ�', d_check='Y'
WHERE deal_no = 12
     
---------------------------------------------------------------------------------------
4) ����
---------------------------------------------------------------------------------------
-- �� ���� �ŷ� ����       
DELETE FROM deal
WHERE deal_no = 3;


---------------------------------------------------------------------------------------
5) �˻�
---------------------------------------------------------------------------------------
-- '�ù�' �˻�
SELECT DEAL_NO, D_STATE, D_WAY, D_CHECK, D_DATE, d_check, d_memo, mem_no, PR_NO
FROM deal
WHERE d_way LIKE '%�ù�%'
ORDER BY DEAL_NO DESC
;

 DEAL_NO D_STATE D_WAY    D_CHECK D_DATE                D_CHECK D_MEMO MEM_NO PR_NO
 ------- ------- -------- ------- --------------------- ------- ------ ------ -----
       2 �ŷ���  �ù�ŷ� N       2018-07-01 15:37:49.0 N       �޸�        2     1
       1 �ŷ���  �ù�ŷ� N       2018-07-01 15:37:48.0 N       �޸�        2     1

-- '����' �˻�
SELECT DEAL_NO, D_STATE, D_WAY, D_CHECK, D_DATE, d_check, d_memo, mem_no, PR_NO
FROM deal
WHERE d_state LIKE '%����%'
ORDER BY DEAL_NO DESC
;

 DEAL_NO D_STATE D_WAY    D_CHECK D_DATE                BUY_NO PR_NO
 ------- ------- -------- ------- --------------------- ------ -----
       7 ������  �ù�ŷ� N       2018-06-29 19:06:40.0      1     1
       2 ������  �ù�ŷ� N       2018-06-29 19:05:00.0      1     1


-- '�Ϸ�' �˻�
SELECT DEAL_NO, D_STATE, D_WAY, D_CHECK, D_DATE, d_check, d_memo, mem_no, PR_NO
FROM deal
WHERE d_state LIKE '%�Ϸ�%' 
ORDER BY DEAL_NO DESC
;

 DEAL_NO D_STATE  D_WAY    D_CHECK D_DATE                BUY_NO PR_NO
 ------- -------- -------- ------- --------------------- ------ -----
       8 �ŷ��Ϸ� �ù�ŷ� N       2018-06-29 19:07:08.0      1     1
       6 �ŷ��Ϸ� �ù�ŷ� N       2018-06-29 19:05:19.0      1     1

-- �ŷ� ��¥ '6�� 28��' �˻�
SELECT DEAL_NO, D_STATE, D_WAY, D_CHECK, D_DATE, d_check, d_memo, mem_no, PR_NO
FROM deal
WHERE TO_CHAR(d_date, 'MMDD') = '0628'
ORDER BY DEAL_NO DESC
;       

-- �ŷ� ��¥ '6�� 28��' �˻�
SELECT DEAL_NO, D_STATE, D_WAY, D_CHECK, D_DATE, d_check, d_memo, mem_no, PR_NO
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

SELECT DEAL_NO, D_STATE, D_WAY, D_CHECK, D_DATE, d_check, d_memo, mem_no, PR_NO
FROM deal
WHERE d_date between to_date('180628', 'YYMMDD') and to_date('180629', 'YYMMDD') -- (180628 00:00:00 ~ 180629 00:00:00) => 180628
ORDER BY DEAL_NO DESC
;

 DEAL_NO D_STATE D_WAY D_CHECK D_DATE                BUY_NO PR_NO
 ------- ------- ----- ------- --------------------- ------ -----
       1 �ŷ���  �ù�ŷ�  N   2018-06-28 17:45:40.0      1     1

-- 180628 ~ 180629 �ŷ� �˻�
       
SELECT DEAL_NO, D_STATE, D_WAY, D_CHECK, D_DATE, d_check, d_memo, mem_no, PR_NO
FROM deal
WHERE d_date between to_date('180628', 'YYMMDD') and to_date('180629', 'YYMMDD') + 1
ORDER BY DEAL_NO DESC
;

 DEAL_NO D_STATE D_WAY  D_CHECK D_DATE                D_CHECK D_MEMO MEM_NO PR_NO
 ------- ------- ------ ------- --------------------- ------- ------ ------ -----
       5 �ŷ���  ���ŷ� N       2018-06-29 15:37:52.0 N       �޸�        2     1
       4 �ŷ���  ���ŷ� N       2018-06-29 15:37:51.0 N       �޸�        2     1

       
---------------------------------------------------------------------------------------
6) ��¥ �˻� �� ��ü ���ڵ� ����
---------------------------------------------------------------------------------------
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
   
--  �Ǹ���, ������ �̸� ���
                m.mem_id, m.mem_name, m.mem_tel, m.mem_mail,

SELECT distinct p.pr_no, p.pr_title, p.pr_price, p.pr_rdate, p.mem_no as seller_no, (SELECT distinct m.mem_name as seller FROM member m, product p WHERE p.mem_no = m.mem_no) as seller, 
                d.deal_no, d.d_state, d.d_way, d.d_check, d.d_date, d.mem_no as buyer_no, (SELECT distinct m.mem_name as buyer FROM member m, deal d WHERE d.mem_no = m.mem_no) as buyer 
FROM product p, deal d
WHERE d.d_date between to_date(180630, 'YYMMDD') and to_date(180630, 'YYMMDD') + 1
ORDER BY d.deal_no DESC;
   
 PR_NO PR_TITLE PR_PRICE PR_RDATE              SELLER_NO SELLER DEAL_NO D_STATE D_WAY  D_CHECK D_DATE                BUYER_NO BUYER
 ----- -------- -------- --------------------- --------- ------ ------- ------- ------ ------- --------------------- -------- -----
     1 ����         1000 2018-07-01 23:54:41.0         1 SCH          3 �ŷ���  ���ŷ� N       2018-06-30 15:37:50.0        2 BYU


 PR_NO PR_TITLE PR_PRICE PR_RDATE              SELLER_NO MEM_ID MEM_NAME MEM_TEL     MEM_MAIL         DEAL_NO D_STATE D_WAY  D_CHECK D_DATE                BUYER_NO (SELECTDISTINCTM.MEM_NAMEASSELLERFROMMEMBERM,PRODUCTPWHEREP.MEM_NO=M.MEM_NO) (SELECTDISTINCTM.MEM_NAMEASBUYERFROMMEMBERM,DEALDWHERED.MEM_NO=M.MEM_NO)
 ----- -------- -------- --------------------- --------- ------ -------- ----------- ---------------- ------- ------- ------ ------- --------------------- -------- ---------------------------------------------------------------------------- ------------------------------------------------------------------------
     1 ����         1000 2018-07-01 23:54:41.0         1 buyer  BYU      01033330000 buyer@naver.com        3 �ŷ���  ���ŷ� N       2018-06-30 15:37:50.0        2 SCH                                                                          BYU
     1 ����         1000 2018-07-01 23:54:41.0         1 schyyy SCH      01022220000 schyyy@naver.com       3 �ŷ���  ���ŷ� N       2018-06-30 15:37:50.0        2 SCH                                                                          BYU

 PR_NO PR_TITLE PR_PRICE PR_RDATE              SELLER_NO MEM_ID MEM_NAME MEM_TEL     MEM_MAIL         DEAL_NO D_STATE D_WAY  D_CHECK D_DATE                BUYER_NO SELLER BUYER
 ----- -------- -------- --------------------- --------- ------ -------- ----------- ---------------- ------- ------- ------ ------- --------------------- -------- ------ -----
     1 ����         1000 2018-07-01 23:54:41.0         1 buyer  BYU      01033330000 buyer@naver.com        3 �ŷ���  ���ŷ� N       2018-06-30 15:37:50.0        2 SCH    BYU
     1 ����         1000 2018-07-01 23:54:41.0         1 schyyy SCH      01022220000 schyyy@naver.com       3 �ŷ���  ���ŷ� N       2018-06-30 15:37:50.0        2 SCH    BYU
     


---------------------------------------------------------------------------------------
7) ����¡
---------------------------------------------------------------------------------------
SELECT distinct d.deal_no, d.d_state, d.d_way, d.d_check, d.d_date, 
                p.mem_no as seller_no, (SELECT distinct m.mem_name FROM member m, product p WHERE p.mem_no = m.mem_no) as seller, 
                p.pr_title, p.pr_price, 
                d.mem_no as buyer_no, (SELECT distinct m.mem_name FROM member m, deal d WHERE d.mem_no = m.mem_no) as buyer 
FROM product p, deal d
ORDER BY d.deal_no DESC;

 DEAL_NO D_STATE D_WAY    D_CHECK D_DATE                SELLER_NO SELLER PR_TITLE PR_PRICE BUYER_NO BUYER
 ------- ------- -------- ------- --------------------- --------- ------ -------- -------- -------- -----
      10 �ŷ���  ���ŷ�   N       2018-06-30 19:44:26.0         1 SCH    ����        1000         2 BYU
       9 �ŷ���  ���ŷ�   N       2018-06-30 19:44:25.0         1 SCH    ����        1000         2 BYU
       8 �ŷ���  ���ŷ�   N       2018-07-01 19:44:24.0         1 SCH    ����        1000         2 BYU
       7 �ŷ���  �ù�ŷ� N       2018-07-02 19:44:23.0         1 SCH    ����        1000         2 BYU
       6 �ŷ���  �ù�ŷ� N       2018-07-02 19:44:22.0         1 SCH    ����        1000         2 BYU
       5 �ŷ���  ���ŷ�   N       2018-06-29 15:37:52.0         1 SCH    ����        1000         2 BYU
       4 �ŷ���  ���ŷ�   N       2018-06-29 15:37:51.0         1 SCH    ����        1000         2 BYU
       3 �ŷ���  ���ŷ�   N       2018-06-30 15:37:50.0         1 SCH    ����        1000         2 BYU
       2 �ŷ���  �ù�ŷ� N       2018-07-01 15:37:49.0         1 SCH    ����        1000         2 BYU
       1 �ŷ���  �ù�ŷ� N       2018-07-01 15:37:48.0         1 SCH    ����        1000         2 BYU

    SELECT p.pr_no, p.pr_title, p.pr_price, p.pr_rdate, p.mem_no as seller_no,
          (SELECT distinct m.mem_name FROM member m, product p WHERE p.mem_no = m.mem_no) as seller,
          d.deal_no, d.d_state, d.d_way, d.d_check, d.d_date, d.mem_no as buyer_no,
          (SELECT distinct m.mem_name FROM member m, deal d WHERE d.mem_no = m.mem_no) as buyer, r
    FROM(
          SELECT p.pr_no, p.pr_title, p.pr_price, p.pr_rdate, p.mem_no as seller_no,
                (SELECT distinct m.mem_name FROM member m, product p WHERE p.mem_no = m.mem_no) as seller,
                d.deal_no, d.d_state, d.d_way, d.d_check, d.d_date, d.mem_no as buyer_no,
                (SELECT distinct m.mem_name FROM member m, deal d WHERE d.mem_no = m.mem_no) as buyer, rownum as r
          FROM (
                SELECT p.pr_no, p.pr_title, p.pr_price, p.pr_rdate, p.mem_no as seller_no,
                      (SELECT distinct m.mem_name FROM member m, product p WHERE p.mem_no = m.mem_no) as seller,
                      d.deal_no, d.d_state, d.d_way, d.d_check, d.d_date, d.mem_no as buyer_no,
                      (SELECT distinct m.mem_name FROM member m, deal d WHERE d.mem_no = m.mem_no) as buyer
                FROM product p, deal d
                ORDER BY d.deal_no
          )
    )
    WHERE r >= 1 AND r <= 3;

SELECT p.pr_no, p.pr_title, p.pr_price, p.pr_rdate, p.mem_no as seller_no,
      (SELECT distinct m.mem_name FROM member m, product p WHERE p.mem_no = m.mem_no) as seller,
      d.deal_no, d.d_state, d.d_way, d.d_check, d.d_date, d.mem_no as buyer_no,
      (SELECT distinct m.mem_name FROM member m, deal d WHERE d.mem_no = m.mem_no) as buyer, rownum as r
FROM (
      SELECT p.pr_no, p.pr_title, p.pr_price, p.pr_rdate, p.mem_no as seller_no,
            (SELECT distinct m.mem_name FROM member m WHERE p.mem_no = m.mem_no) as seller,
            d.deal_no, d.d_state, d.d_way, d.d_check, d.d_date, d.mem_no as buyer_no,
            (SELECT distinct m.mem_name FROM member m WHERE d.mem_no = m.mem_no) as buyer
      FROM product p, deal d
      ORDER BY d.deal_no
) 


SELECT distinct d.deal_no, d.d_state, d.d_way, d.d_check, d.d_date, 
                p.mem_no as seller_no, (SELECT distinct m.mem_name FROM member m, product p WHERE p.mem_no = m.mem_no) as seller, 
                p.pr_title, p.pr_price, 
                d.mem_no as buyer_no, (SELECT distinct m.mem_name FROM member m, deal d WHERE d.mem_no = m.mem_no) as buyer 
FROM (
      SELECT distinct d.deal_no, d.d_state, d.d_way, d.d_check, d.d_date, 
                      p.mem_no as seller_no, (SELECT distinct m.mem_name FROM member m, product p WHERE p.mem_no = m.mem_no) as seller, 
                      p.pr_title, p.pr_price, 
                      d.mem_no as buyer_no, (SELECT distinct m.mem_name FROM member m, deal d WHERE d.mem_no = m.mem_no) as buyer 
      FROM (
            SELECT distinct d.deal_no, d.d_state, d.d_way, d.d_check, d.d_date, 
                            p.mem_no as seller_no, (SELECT distinct m.mem_name FROM member m, product p WHERE p.mem_no = m.mem_no) as seller, 
                            p.pr_title, p.pr_price, 
                            d.mem_no as buyer_no, (SELECT distinct m.mem_name FROM member m, deal d WHERE d.mem_no = m.mem_no) as buyer 
            FROM product p, deal d
      )
)
ORDER BY d.deal_no DESC;

                <choose>
                  <when test="startDate == null or startDate == ''">
                    WHERE p.pr_no = d.pr_no
                  </when>
                  <otherwise>
                    WHERE p.pr_no = d.pr_no and d.d_date between to_date(180629, 'YYMMDD') and to_date(180630, 'YYMMDD') + 1
                  </otherwise>
                </choose>

                
                
SELECT b.*
FROM (
      SELECT a.*, rownum as r
      FROM (
            SELECT distinct d.deal_no, d.d_state, d.d_way, d.d_check, d.d_date,
                            p.mem_no as seller_no, (SELECT distinct m.mem_name FROM member m, product p WHERE p.mem_no = m.mem_no) as seller,
                            p.pr_title, p.pr_price,
                            d.mem_no as buyer_no, (SELECT distinct m.mem_name FROM member m, deal d WHERE d.mem_no = m.mem_no) as buyer
            FROM product p, deal d
            ORDER BY d.deal_no
      ) a
) b
WHERE r >= 1 AND r <= 3;


--------------------------------------------------------------------------------------------------------


SELECT B.*, r
    FROM(
        SELECT A.*, rownum as r
        FROM (
            SELECT p.pr_no, p.pr_title, p.pr_price, p.pr_rdate, p.mem_no as seller_no,
                (SELECT distinct m.mem_name FROM member m, product p WHERE p.mem_no = m.mem_no) as seller,
                d.deal_no, d.d_state, d.d_way, d.d_check, d.d_date, d.mem_no as buyer_no,
                (SELECT distinct m.mem_name FROM member m, product p WHERE d.mem_no = m.mem_no) as buyer
            FROM product p, deal d
              --<!-- ��¥ �˻� �� -->
              --<!-- startDate ~ endDate -->
              --<if test="startDate != null or startDate != '' and endDate != null or endDate != ''">
                WHERE p.pr_no = d.pr_no and d.d_date < '180716'
              --</if>
              --<!--           ~ endDate -->
              --<if test="startDate == null or startDate == '' and endDate != null or endDate != ''">
                --WHERE p.pr_no = d.pr_no and d.d_date between to_date(#{startDate}, 'YYMMDD') and to_date(#{endDate}, 'YYMMDD') + 1
              --</if>
              --<!-- startDate ~         -->
              --<if test="startDate != null or startDate != '' and endDate == null or endDate == ''">
                --WHERE p.pr_no = d.pr_no and d.d_date between to_date(#{startDate}, 'YYMMDD') and to_date(#{endDate}, 'YYMMDD') + 1
              --</if>
            ORDER BY d.deal_no
            ) A
        ) B
    WHERE r >= 1 AND r <= 5


    SELECT B.*, r
    FROM(
        SELECT A.*, rownum as r
        FROM (
            SELECT p.pr_no, p.pr_title, p.pr_price, p.pr_rdate, p.mem_no as seller_no,
                (SELECT distinct m.mem_name FROM member m, product p WHERE p.mem_no = m.mem_no) AS seller,
                d.deal_no, d.d_state, d.d_way, d.d_check, d.d_date, d.mem_no as buyer_no,
                (SELECT distinct m.mem_name FROM member m, product p WHERE d.mem_no = m.mem_no) AS buyer
            FROM product p, deal d
            WHERE p.pr_no = d.pr_no AND d.d_date BETWEEN (SELECT d_date FROM (SELECT d_date, rownum FROM deal ORDER BY d_date ) WHERE rownum=1) AND '180716'
            ORDER BY d.deal_no
            ) A
        ) B
    WHERE r >= 1 AND r <= 5

    
    
    SELECT d_date FROM (SELECT d_date, rownum FROM deal ORDER BY d_date DESC) WHERE rownum=1
    
-- (180716 ~ ) �˻�
SELECT B.*, r
FROM(
    SELECT A.*, rownum as r
    FROM (
        SELECT p.pr_no, p.pr_title, p.pr_price, p.pr_rdate, p.mem_no as seller_no,
            (SELECT distinct m.mem_name FROM member m, product p WHERE p.mem_no = m.mem_no) AS seller,
            d.deal_no, d.d_state, d.d_way, d.d_check, d.d_date, d.mem_no as buyer_no,
            (SELECT distinct m.mem_name FROM member m, product p WHERE d.mem_no = m.mem_no) AS buyer
        FROM product p, deal d
				  WHERE p.pr_no = d.pr_no   
				  AND d.d_date BETWEEN '180716' AND (SELECT d_date FROM (SELECT d_date, rownum FROM deal ORDER BY d_date DESC) WHERE rownum=1)
        ORDER BY d.deal_no
        ) A
    ) B
    
    
-- ( ~ 180716) �˻�
SELECT B.*, r
FROM(
    SELECT A.*, rownum as r
    FROM (
        SELECT p.pr_no, p.pr_title, p.pr_price, p.pr_rdate, p.mem_no as seller_no,
            (SELECT distinct m.mem_name FROM member m, product p WHERE p.mem_no = m.mem_no) AS seller,
            d.deal_no, d.d_state, d.d_way, d.d_check, d.d_date, d.mem_no as buyer_no,
            (SELECT distinct m.mem_name FROM member m, product p WHERE d.mem_no = m.mem_no) AS buyer
        FROM product p, deal d
        WHERE p.pr_no = d.pr_no AND d.d_date BETWEEN (SELECT d_date FROM (SELECT d_date, rownum FROM deal ORDER BY d_date ) WHERE rownum=1) AND to_date('180716', 'YYMMDD') + 1
        ORDER BY d.deal_no
        ) A
    ) B
    
-- ( ~ 180716) �˻�
with product_deal as (SELECT p.pr_no, p.pr_title, p.pr_price, p.pr_rdate, p.mem_no as seller_no,
            (SELECT distinct m.mem_name FROM member m, product p WHERE p.mem_no = m.mem_no) AS seller,
            d.deal_no, d.d_state, d.d_way, d.d_check, d.d_date, d.mem_no as buyer_no,
            (SELECT distinct m.mem_name FROM member m, product p WHERE d.mem_no = m.mem_no) AS buyer
        FROM product p, deal d)
SELECT B.*, r
FROM(
    SELECT A.*, rownum as r
    FROM (
        SELECT p.pr_no, p.pr_title, p.pr_price, p.pr_rdate, p.mem_no as seller_no,
            (SELECT distinct m.mem_name FROM member m, product p WHERE p.mem_no = m.mem_no) AS seller,
            d.deal_no, d.d_state, d.d_way, d.d_check, d.d_date, d.mem_no as buyer_no,
            (SELECT distinct m.mem_name FROM member m, product p WHERE d.mem_no = m.mem_no) AS buyer
        FROM product p, deal d
        WHERE p.pr_no = d.pr_no AND d.d_date <= to_date('180716', 'YYMMDD') + 1 and seller = '�մ���'
        ORDER BY d.deal_no
        ) A
    ) B
    
    
SELECT X.*, JUMSU
FROM (
    SELECT ID, NAME, ADDRESS, ((GRADE * 10)-4) AS JUMSU
    FROM SAMPLETBL 
) AS X
WHERE JUMSU > 5    
    
SELECT B.*, r
FROM(
    SELECT A.*, rownum as r
    FROM (
        SELECT p.pr_no, p.pr_title, p.pr_price, p.pr_rdate, p.mem_no as seller_no,
            (SELECT distinct m.mem_name FROM member m, product p WHERE p.mem_no = m.mem_no) AS seller,
            d.deal_no, d.d_state, d.d_way, d.d_check, d.d_date, d.mem_no as buyer_no,
            (SELECT distinct m.mem_name FROM member m, product p WHERE d.mem_no = m.mem_no) AS buyer
        FROM product p, deal d
        WHERE p.pr_no = d.pr_no AND d.d_date <= to_date('180716', 'YYMMDD') + 1 
        ORDER BY d.deal_no
        )  A
    )  B
    where seller = '�մ���'
    
    
WITH pdjoin AS (SELECT p.pr_no, p.pr_title, p.pr_price, p.pr_rdate, p.mem_no as seller_no,
            (SELECT distinct m.mem_name FROM member m, product p WHERE p.mem_no = m.mem_no) AS seller,
            d.deal_no, d.d_state, d.d_way, d.d_check, d.d_date, d.mem_no as buyer_no,
            (SELECT distinct m.mem_name FROM member m, product p WHERE d.mem_no = m.mem_no) AS buyer
        FROM product p, deal d)
SELECT seller, buyer FROM pdjoin;



            SELECT p.pr_no, p.pr_title, p.pr_price, p.pr_rdate, p.mem_no as seller_no, s.seller,
                   d.deal_no, d.d_state, d.d_way, d.d_check, d.d_date, d.mem_no as buyer_no, b.buyer
            FROM product p, deal d, member m
                (SELECT distinct m.mem_name as seller FROM member m, product p WHERE p.mem_no = m.mem_no) s, 
                (SELECT distinct m.mem_name as buyer FROM member m, deal d WHERE d.mem_no = 2) b
            WHERE p.pr_no = d.pr_no
            
            select m.mem_no, m.mem_name, d.deal_no, d.mem_no from member m, deal d where d.mem_no = m.mem_no and m.mem_no = 2
            SELECT d_date FROM (SELECT d_date, rownum FROM deal ORDER BY d_date ) WHERE rownum=1
            
select deal_no, mem_no, pr_no from deal -- mem_no = 2, 6
            
 DEAL_NO MEM_NO PR_NO
 ------- ------ -----
       1      2     1
       2      2     1
       3      2     1
       4      2     1
       5      2     1
       6      6     3
       7      6     3
       
SELECT d.deal_no, d.d_date, d.mem_no as buyer_no,
      (SELECT distinct m.mem_name as buyer FROM member m, deal d WHERE d.mem_no = 2 AND m.mem_no = 2) as buyer,
       p.pr_no, p.mem_no as seller_no, 
      (SELECT distinct m.mem_name as seller FROM member m, product p WHERE p.mem_no = m.mem_no) as seller
FROM product p, deal d, member m
WHERE p.pr_no = d.pr_no 
and m.mem_no = 2

select * from deal

SELECT m.mem_no, m.mem_name as buyer, d.deal_no, d.mem_no, d.pr_no
FROM member m, deal d 
WHERE d.mem_no = m.mem_no AND m.mem_no = 6

       
            
select * from product  -- mem_no = 1
            
 PR_NO GORY_NO MEM_NO PR_TITLE                PR_CONTENTS PR_THUMBS PR_FILES PR_SIZES PR_CNT PR_RDATE              PR_BUYYEAR            PR_STATE PR_TRANSACTION PR_LOCAL PR_BUYPRICE PR_PRICE PR_VISIBLE PR_PAYMENT
 ----- ------- ------ ----------------------- ----------- --------- -------- -------- ------ --------------------- --------------------- -------- -------------- -------- ----------- -------- ---------- ----------
     1       1      1 [�Ｚ����]PEN NT930QAA-K28A ũ���������� ������  NULL      NULL     NULL          0 2018-07-17 16:13:37.0 2017-01-01 00:00:00.0 �߰�       ���ŷ�            ����/����           1000      800 Y          N
     2       1      1 �׷�                      ũ���������� ������  NULL      NULL     NULL          0 2018-07-17 18:31:39.0 2017-01-01 00:00:00.0 �߰�       ���ŷ�            ����/����           1000    80000 Y          N
     3       1      1 [�Ｚ����]PEN NT930QAA-K28A ũ���������� ������  NULL      NULL     NULL          0 2018-07-20 17:21:24.0 2017-01-01 00:00:00.0 �߰�       ���ŷ�            ����/����           1000      800 Y          N

     
select mem_no from member -- mem_no = 1 ~ 6
select ship_no, mem_no from shipping -- mem_no = 2    
select pay_no, mem_no from payment -- mem_no = 2
            
            
SELECT B.*
FROM(
    SELECT rownum as r, A.* 
    FROM (
        SELECT p.pr_no, p.pr_title, p.pr_price, p.pr_rdate, p.mem_no as seller_no, 
              (SELECT distinct m.mem_name as seller FROM member m, product p WHERE p.mem_no = m.mem_no) as seller,
              d.deal_no, d.d_state, d.d_way, d.d_check, d.d_date, d.mem_no as buyer_no,
              (SELECT distinct m.mem_name as buyer FROM member m, deal d WHERE d.mem_no = m.mem_no AND m.mem_no = 2) as buyer
        FROM product p, deal d
        --WHERE p.pr_no = d.pr_no
          WHERE p.pr_no = d.pr_no AND d.d_date BETWEEN (SELECT d_date FROM (SELECT d_date, rownum FROM deal ORDER BY d_date ) WHERE rownum=1) AND to_date('180717', 'YYMMDD') + 1
        --WHERE p.pr_no = d.pr_no AND d.d_date BETWEEN to_date('180716', 'YYMMDD') AND to_date('180717', 'YYMMDD') + 1
        --WHERE p.pr_no = d.pr_no AND d.d_date BETWEEN to_date('180717', 'YYMMDD') AND SYSDATE
	            AND (d.d_state LIKE '%��%' 
	            OR d.d_way LIKE '%��%' 
	            OR d.d_check LIKE '%��%' 
	            OR p.pr_title LIKE '%��%' 
	            OR p.pr_price LIKE '%��%' 
	            OR (SELECT distinct m.mem_name FROM member m, deal d WHERE d.mem_no = m.mem_no AND m.mem_no = 2) LIKE '%��%' 
	            OR (SELECT distinct m.mem_name FROM member m, product p WHERE p.mem_no = m.mem_no) LIKE '%��%') 
        ORDER BY d.deal_no
        ) A
    ) B

    
SELECT p.pr_no, p.pr_title, p.pr_price, p.pr_rdate, p.mem_no as seller_no,
                (SELECT distinct m.mem_name FROM member m, product p WHERE p.mem_no = m.mem_no) AS seller,
                d.deal_no, d.d_state, d.d_way, d.d_check, d.d_date, d.mem_no as buyer_no,
                (SELECT distinct m.mem_name FROM member m, deal d WHERE d.mem_no = m.mem_no and m.mem_no = 3) AS buyer
            FROM product p, deal d
            WHERE p.pr_no = d.pr_no    
    
    