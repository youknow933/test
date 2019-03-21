DROP TABLE receive CASCADE CONSTRAINTS;
DROP TABLE delivery CASCADE CONSTRAINTS;
DROP TABLE payment CASCADE CONSTRAINTS;
DROP TABLE deal CASCADE CONSTRAINTS;
DROP TABLE buy CASCADE CONSTRAINTS;
DROP TABLE product CASCADE CONSTRAINTS;
DROP TABLE charge CASCADE CONSTRAINTS;
DROP TABLE mlieage CASCADE CONSTRAINTS;
DROP TABLE member CASCADE CONSTRAINTS;

INSERT INTO auth(auth_no, auth_info) VALUES(1, '������');
INSERT INTO member(mem_no, auth_no, mem_id, mem_pass, mem_name, mem_tel, mem_mail, mem_job, mem_acc, mem_confirm, mem_date) VALUES((SELECT nvl(MAX(mem_no), 0) + 1 as mem_no FROM member), 1, 'schyyy', '123', 'sch', '01022220000', 'schyyy@naver.com', '�л�', 0, 'Y', SYSDATE);
INSERT INTO categrp(grp_no, grp_classification, grp_title, grp_seqno, grp_visible, grp_rdate) VALUES((SELECT NVL(MAX(grp_no), 0)+1 as grp_no FROM categrp), 1, 'SAMSUNG�ÿ�����9', 1, 'Y', sysdate);
INSERT INTO category(gory_no, grp_no, mem_no, gory_title, gory_seqno, gory_visible, gory_ids, gory_cnt, gory_rdate) VALUES((SELECT NVL(MAX(gory_no), 0)+1 as gory_no FROM category), 1, 1, '�Ｚ', 0, 'Y', 'ad', 1, sysdate);
INSERT INTO product(pr_no, pr_maker, pr_title, pr_contents, pr_cnt, pr_rdate, pr_price, pr_visible, pr_payment) VALUES((SELECT nvl(MAX(pr_no), 0) + 1 as pr_no FROM product), 'LG', '�׷��˴ϴ�', '2018�� �õ��̱׷� �Ǹ�', 0, SYSDATE, 1000000, 'Y', 'Y');
INSERT INTO buy(buy_no, pr_no, mem_no, buy_rdate) VALUES((SELECT nvl(MAX(buy_no), 0) + 1 as buy_no FROM buy), 1, 1, SYSDATE);
INSERT INTO dealstate(dstate_no, dstate, dstate_date) VALUES (1, '���� ��', SYSDATE);
INSERT INTO dealway(dway_no, dway) VALUES (1, '���ŷ�');

/**********************************/
/* Table Name: ��ǰ �ŷ� */
/**********************************/
CREATE TABLE deal(
    deal_no                           NUMBER(10)     NOT NULL,
    d_state                           VARCHAR2(20)     NOT NULL,
    d_way                             VARCHAR2(20)     NOT NULL,
    d_check                           CHAR(1)    DEFAULT 'N'     NULL ,
    d_date                            DATE     NOT NULL,
    buy_no                            NUMBER(10)     NULL ,
    pr_no                             NUMBER(10)     NULL ,
  FOREIGN KEY (buy_no) REFERENCES buy (buy_no),
  FOREIGN KEY (pr_no) REFERENCES product (pr_no)
);

COMMENT ON TABLE deal is '��ǰ �ŷ�';
COMMENT ON COLUMN deal.deal_no is '�ŷ���ȣ';
COMMENT ON COLUMN deal.d_state is '�ŷ�����';
COMMENT ON COLUMN deal.d_way is '�ŷ����';
COMMENT ON COLUMN deal.d_check is '�ŷ�Ȯ��';
COMMENT ON COLUMN deal.d_date is '�ŷ������';
COMMENT ON COLUMN deal.buy_no is '���Ź�ȣ';
COMMENT ON COLUMN deal.pr_no is '��ǰ��ȣ';

SELECT deal_no, usemileage, ddate, dmemo, mem_no, pr_no, buy_no, dway_no, dstate_no
FROM deal;

 DEAL_NO USEMILEAGE DDATE                 DMEMO MEM_NO PR_NO BUY_NO DWAY_NO DSTATE_NO
 ------- ---------- --------------------- ----- ------ ----- ------ ------- ---------
       1     100000 2018-06-19 19:19:50.0 �޸�       1     1      1       1         1

DELETE FROM deal;

1) �ŷ� �� �� ���

INSERT INTO deal(deal_no, usemileage, ddate, dmemo, mem_no, pr_no, buy_no, dway_no, dstate_no)
VALUES ((SELECT nvl(MAX(deal_no), 0) + 1 as deal_no FROM deal), 100000, SYSDATE, '�޸�', 1, 1, 1, 1, 1);

select * from deal;

