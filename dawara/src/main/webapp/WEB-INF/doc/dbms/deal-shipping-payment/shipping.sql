
DROP TABLE shipping;
    
/**********************************/
/* Table Name: ��ǰ �ù�ŷ� */
/**********************************/
CREATE TABLE shipping(
    ship_no           NUMBER(10)                NOT NULL PRIMARY KEY,
    ship_zipcode      VARCHAR2(5)               NOT NULL,
    ship_addr1        VARCHAR2(80)              NOT NULL,
    ship_addr2        VARCHAR2(50)              NOT NULL,
    ship_rname        VARCHAR2(20)              NOT NULL,
    ship_rtel         VARCHAR2(14)              NOT NULL,
    ship_memo         VARCHAR2(100)             NULL,
    ship_date         DATE                      NOT NULL,
    ship_check        CHAR(1)       DEFAULT 'N' NOT NULL,
    PR_NO             NUMBER(7)                 NOT NULL,
    MEM_NO            NUMBER(6)                 NULL,
  FOREIGN KEY (PR_NO) REFERENCES product (PR_NO),
  FOREIGN KEY (MEM_NO) REFERENCES member (MEM_NO)
);

-- ALTER TABLE shipping ADD CONSTRAINT ship_no PRIMARY KEY (ship_no);

COMMENT ON TABLE shipping is '��ǰ �ù�ŷ�';
COMMENT ON COLUMN shipping.ship_no is '��۹�ȣ';
COMMENT ON COLUMN shipping.ship_zipcode is '�����ȣ';
COMMENT ON COLUMN shipping.ship_addr1 is '�����1';
COMMENT ON COLUMN shipping.ship_addr2 is '�����2';
COMMENT ON COLUMN shipping.ship_rname is '�޴� ���';
COMMENT ON COLUMN shipping.ship_rtel is '�޴� ��� ����ó';
COMMENT ON COLUMN shipping.ship_memo is '��۽� ��û����';
COMMENT ON COLUMN shipping.ship_date is '�ù�ŷ������';
COMMENT ON COLUMN shipping.ship_check is '�߼�Ȯ��';
COMMENT ON COLUMN shipping.PR_NO is '��ǰ ��ȣ';
COMMENT ON COLUMN shipping.MEM_NO is 'ȸ�� ��ȣ';

SELECT ship_no, ship_zipcode, ship_addr1, ship_addr2, ship_rname, ship_rtel, ship_memo, ship_date, ship_check, pr_no, mem_no
FROM shipping;

DELETE FROM shipping;

------------------------------------------------------------------------------------------------------------------------------------------------------
1) �ŷ� �� �� ���� ���
------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO shipping(SHIP_NO, 
                     SHIP_ZIPCODE, SHIP_ADDR1, SHIP_ADDR2, SHIP_RNAME, SHIP_RTEL, SHIP_MEMO, SHIP_DATE, PR_NO, MEM_NO)
VALUES ((SELECT nvl(MAX(SHIP_NO), 0) + 1 as SHIP_NO FROM shipping),
                      '00001', '���� ���α� ...', '�ھƺ��� 20-3', '�޴»��1', '010-0101-0101', '��� �� �����ּ���1', SYSDATE, 1, 2);

INSERT INTO shipping(SHIP_NO, 
                     SHIP_ZIPCODE, SHIP_ADDR1, SHIP_ADDR2, SHIP_RNAME, SHIP_RTEL, SHIP_MEMO, SHIP_DATE, PR_NO, MEM_NO)
VALUES ((SELECT nvl(MAX(SHIP_NO), 0) + 1 as SHIP_NO FROM shipping),
                      '00002', '���� ���빮�� ...', '�Ͼ��� 20-3', '�޴»��2', '010-0202-0202', '��� �� �����ּ���2', SYSDATE, 2, 2);

INSERT INTO shipping(SHIP_NO, 
                     SHIP_ZIPCODE, SHIP_ADDR1, SHIP_ADDR2, SHIP_RNAME, SHIP_RTEL, SHIP_MEMO, SHIP_DATE, PR_NO, MEM_NO)
VALUES ((SELECT nvl(MAX(SHIP_NO), 0) + 1 as SHIP_NO FROM shipping),
                      '00003', '���� ���Ǳ� ...', '���ǻ� 20-3', '�޴»��3', '010-0000-0003', '��� �� �����ּ���3', SYSDATE, 1, 2);

INSERT INTO shipping(SHIP_NO, 
                     SHIP_ZIPCODE, SHIP_ADDR1, SHIP_ADDR2, SHIP_RNAME, SHIP_RTEL, SHIP_MEMO, SHIP_DATE, PR_NO, MEM_NO)
VALUES ((SELECT nvl(MAX(SHIP_NO), 0) + 1 as SHIP_NO FROM shipping),
                      '00004', '���� ��걸 ...', '��� 20-3', '�޴»��4', '010-0000-0004', '��� �� �����ּ���4', SYSDATE, 2, 2);


--------------------------------------------------------------------------------------------------------------------------------------------------------
2) ���
--------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT * FROM shipping;

-- 1�� ��ǰ �Ǹ����� ��ǰ�� �Ǹ��� ����
-- Product_MemberVO ����
SELECT p.pr_no, p.pr_title, p.pr_buyyear, p.pr_state, p.pr_buyprice, p.pr_price,
	      m.mem_no as "pr_mem_no", m.mem_name as "pr_mem_name", m.mem_tel as	"pr_mem_tel",
				m.mem_zipcode as "pr_mem_zipcode", m.mem_addr1 as "pr_mem_addr1", m.mem_addr2 as "pr_mem_addr2"
FROM product p, member m
WHERE p.pr_no = 1 and p.mem_no = m.mem_no

SELECT p.pr_no,
       m.mem_no as pr_mem_no, 
       m.mem_name as pr_mem_name, 
       m.mem_tel as pr_mem_tel, 
       m.mem_mail as pr_mem_mail,
       m.mem_zipcode as pr_mem_zipcode, 
       m.mem_addr1 as pr_mem_addr1, 
       m.mem_addr2 as pr_mem_addr2
FROM product p, member m
WHERE p.mem_no = m.mem_no and p.pr_no = 1

select * from member;
select * from product;

 PR_NO PR_TITLE PR_BUYYEAR            PR_STATE PR_BUYPRICE PR_PRICE pr_mem_no pr_mem_name pr_mem_tel  pr_mem_zipcode pr_mem_addr1 pr_mem_addr2
 ----- -------- --------------------- -------- ----------- -------- --------- ----------- ----------- -------------- ------------ ------------
     1 ����     2017-01-01 00:00:00.0 �߰�            1000     1000         1 SCH         01022220000 00001          ���� ���α� ...   �ھƺ��� 20-3
     
-- ��ü ���
SELECT SHIP_NO, SHIP_ZIPCODE, SHIP_ADDR1, SHIP_ADDR2, SHIP_RNAME, SHIP_RTEL, SHIP_MEMO, SHIP_DATE, SHIP_CHECK, PR_NO, MEM_NO
FROM shipping;

 SHIP_NO SHIP_ZIPCODE SHIP_ADDR1  SHIP_ADDR2 SHIP_RNAME SHIP_RTEL     SHIP_MEMO   SHIP_DATE             SHIP_CHECK PR_NO MEM_NO
 ------- ------------ ----------- ---------- ---------- ------------- ----------- --------------------- ---------- ----- ------
       1 00001        ���� ���α� ...  �ھƺ��� 20-3  �޴»��1      010-0101-0101 ��� �� �����ּ���1 2018-07-10 16:30:54.0 N              1      2
       2 00002        ���� ���빮�� ... �Ͼ��� 20-3   �޴»��2      010-0202-0202 ��� �� �����ּ���2 2018-07-10 16:30:55.0 N              2      2
       3 00003        ���� ���Ǳ� ...  ���ǻ� 20-3   �޴»��3      010-0000-0003 ��� �� �����ּ���3 2018-07-10 16:30:56.0 N              3      2

       
SELECT SHIP_NO, SHIP_ZIPCODE, SHIP_DATE      
FROM shipping
WHERE ship_date = 
ORDER BY ship_date desc;
       
       
---------------------------------------------------------------------------------------------------
3) ����
---------------------------------------------------------------------------------------------------
UPDATE shipping
SET ship_zipcode = #{ship_zipcode}, ship_addr1 = #{ship_addr1}, ship_addr2 = #{ship_addr2}, 
    ship_rtel = #{ship_rtel}, ship_memo = #{ship_memo}, ship_check = #{ship_memo}
WHERE ship_no = 2

-- �޴»�� ����ó ����
UPDATE shipping
SET ship_rtel = '010-2222-2222'
WHERE ship_no = 2

---------------------------------------------------------------------------------------------------
4) ����
---------------------------------------------------------------------------------------------------
-- �ù�ŷ� �Ѱ� ����
DELETE FROM shipping
WHERE ship_no = 1

---------------------------------------------------------------------------------------------------
5) �˻�
---------------------------------------------------------------------------------------------------
-- ����
	-- 2�� ȸ���� ���￡ ��۵� �ù�ŷ� ����
	SELECT concat('(' || ship_zipcode || ') ', concat(ship_addr1 || ' ', ship_addr2)) ship_address
	FROM shipping
	WHERE mem_no = 2 and concat('(' || ship_zipcode || ') ', concat(ship_addr1 || ' ', ship_addr2)) LIKE '%����%'
	
-- ����ó �˻�
	-- ��ü ��ȣ �˻�
	SELECT ship_rtel
	FROM shipping
	WHERE ship_rtel = '010-3333-0000'
	
	 SHIP_RTEL
	 -------------
	 010-3333-0000
	 
	-- ����ó ���ڸ� 4�ڸ��� 0000�� �ù�ŷ� ���
	SELECT ship_rtel
	FROM shipping
	WHERE substr(ship_rtel, 10, 5) = '0000' 
	
	 SHIP_RTEL
	 -------------
	 010-3333-0000

-- ����� �˻�
	-- 7���޿� ����� �ù�ŷ� ���
	SELECT ship_date 
	from shipping
	where substr(ship_date, 4, 2) = 07;
	
	 SHIP_DATE
	 ---------------------
	 2018-07-13 10:21:12.0

	-- 2018�⿡ ����� �ù�ŷ� ���
	SELECT ship_date 
	from shipping
	where substr(ship_date, 1, 2) = 18;
	
	 SHIP_DATE
	 ---------------------
	 2018-07-13 10:21:12.0

-- �߼ۿ���
-- �޴»��

    SELECT ship_no, ship_zipcode, ship_addr1, ship_addr2, ship_rname, ship_rtel, 
           ship_memo, ship_date, ship_check, pr_no, mem_no
    FROM shipping
        WHERE mem_no=2 AND ship_check LIKE '%N%' 
        
SELECT ship_no, ship_zipcode, ship_addr1, ship_addr2, ship_rname, ship_rtel, 
       ship_memo, substr(ship_date,0,8), ship_check, pr_no, mem_no
FROM shipping
WHERE mem_no=2 AND substr(ship_date,0,8) LIKE '%07%' 

    SELECT ship_no, ship_zipcode, ship_addr1, ship_addr2, ship_rname, ship_rtel, 
           ship_memo, ship_date, ship_check, pr_no, mem_no
    FROM shipping
    WHERE mem_no=2 AND concat(ship_zipcode, concat(ship_addr1, ship_addr2)) LIKE '%�Ͼ���%' 
    
    SELECT COUNT(*) as cnt
    FROM shipping
    WHERE mem_no=2 AND concat(ship_zipcode, concat(ship_addr1, ship_addr2)) LIKE '%�Ͼ���%' 

    
    SELECT ship_no, ship_zipcode, ship_addr1, ship_addr2, ship_rname, ship_rtel, 
           ship_memo, ship_date, ship_check, pr_no, mem_no
    FROM shipping
    WHERE mem_no=2 AND concat(ship_zipcode, concat(ship_addr1, ship_addr2)) LIKE '%��%'
    
    
    SELECT ship_no, ship_zipcode, ship_addr1, ship_addr2, ship_rname, ship_rtel, 
           ship_memo, ship_date, ship_check, pr_no, mem_no
    FROM shipping
    WHERE mem_no=2
    AND concat(ship_zipcode, concat(ship_addr1, ship_addr2)) LIKE '%��%' 
    OR ship_rname LIKE '%��%' 
    OR ship_rtel LIKE '%��%' 
    OR ship_date LIKE '%��%' 
    OR ship_check LIKE '%��%' 
    
    
    

---------------------------------------------------------------------------------------------------
6) �˻��� ��ü ���ڵ� ����
---------------------------------------------------------------------------------------------------

SELECT COUNT(*) as cnt
FROM shipping
WHERE mem_no = 2 AND concat('(' || ship_zipcode || ') ', concat(ship_addr1 || ' ', ship_addr2)) LIKE '%����%' <!-- �ּҸ� �˻��ϴ� ��� --> 

 CNT
 ---
   1   
   
SELECT COUNT(*) as cnt
FROM deal
WHERE mem_no=2 AND concat(ship_zipcode, concat(ship_addr1, ship_addr2)) LIKE '%����%';
---------------------------------------------------------------------------------------------------
7) ����¡
---------------------------------------------------------------------------------------------------

SELECT B.*, r
FROM(
    SELECT A.*, rownum as r
    FROM (
        SELECT ship_no, ship_zipcode, ship_addr1, ship_addr2, ship_rname, ship_rtel, 
              ship_memo, ship_date, ship_check, pr_no, mem_no
        FROM shipping
            WHERE mem_no = 2 
            AND concat(ship_zipcode, concat(ship_addr1, ship_addr2)) LIKE '%��%' 
					    OR ship_rname LIKE '%��%' 
					    OR ship_rtel LIKE '%��%' 
					    OR ship_date LIKE '%��%' 
					    OR ship_check LIKE '%��%' 
        ORDER BY ship_no
        ) A
    ) B
WHERE r >= 1 AND r <= 5
    
 SHIP_NO SHIP_ZIPCODE SHIP_ADDR1                SHIP_ADDR2 SHIP_RNAME SHIP_RTEL     SHIP_MEMO   SHIP_DATE             SHIP_CHECK PR_NO MEM_NO R R
 ------- ------------ ------------------------- ---------- ---------- ------------- ----------- --------------------- ---------- ----- ------ - -
       1 00001        ���� ���α� ...                �ھƺ��� 20-3  �޴»��1      010-0101-0101 ��� �� �����ּ���1 2018-07-16 06:35:12.0 N              1      2 1 1
       2 63275        ����Ư����ġ�� ���ֽ� ���ɰ�� 1 (�ϵ�2��) ��ö��        �Ʒι�        000-0000-0000 ��� �� �����ּ���2 2018-07-16 06:35:13.0 N              2      2 2 2
       4 44648        ��� ���� �Ÿ��� 5 (����)          ��ö��        �Ʒι�        000-0000-0000 ��� �� �����ּ���3 2018-07-16 06:35:37.0 N              1      2 3 3

SELECT B.*, r
FROM(
    SELECT A.*, rownum as r
    FROM (
        SELECT ship_no, ship_zipcode, ship_addr1, ship_addr2, ship_rname, ship_rtel, 
              ship_memo, ship_date, ship_check, pr_no, mem_no
        FROM shipping
            WHERE mem_no = 2 
            AND concat(ship_zipcode, concat(ship_addr1, ship_addr2)) LIKE '%��%' 
              OR ship_rname LIKE '%��%' 
              OR ship_rtel LIKE '%��%' 
              OR ship_date LIKE '%��%' 
              OR ship_check LIKE '%��%' 
        ORDER BY ship_no
        ) A
    ) B
WHERE r >= 1 AND r <= 5    

 SHIP_NO SHIP_ZIPCODE SHIP_ADDR1                     SHIP_ADDR2 SHIP_RNAME SHIP_RTEL     SHIP_MEMO   SHIP_DATE             SHIP_CHECK PR_NO MEM_NO R R
 ------- ------------ ------------------------------ ---------- ---------- ------------- ----------- --------------------- ---------- ----- ------ - -
       1 00001        ���� ���α� ...                     �ھƺ��� 20-3  �޴»��1      010-0101-0101 ��� �� �����ּ���1 2018-07-16 06:35:12.0 N              1      2 1 1
       2 63275        ����Ư����ġ�� ���ֽ� ���ɰ�� 1 (�ϵ�2��)      ��ö��        �Ʒι�        000-0000-0000 ��� �� �����ּ���2 2018-07-16 06:35:13.0 N              2      2 2 2
       4 44648        ��� ���� �Ÿ��� 5 (����)               ��ö��        �Ʒι�        000-0000-0000 ��� �� �����ּ���3 2018-07-16 06:35:37.0 N              1      2 3 3
       5 48060        �λ� �ؿ�뱸 APEC�� 17 (�쵿, ���Ҹ�������ũ) ��ö��        �Ʒι�        000-0000-0000 NULL        2018-07-16 09:40:30.0 N              2      2 4 4
       6 12345        ����� ���α�                        ��ö��        �Ʒι�        000-0000-0000 NULL        2018-07-17 14:07:04.0 N              2      2 5 5

---------------------------------------------------------------------------------------------------




