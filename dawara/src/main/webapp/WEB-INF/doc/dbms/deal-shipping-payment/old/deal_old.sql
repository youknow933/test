DROP TABLE receive CASCADE CONSTRAINTS;
DROP TABLE delivery CASCADE CONSTRAINTS;
DROP TABLE payment CASCADE CONSTRAINTS;
DROP TABLE deal CASCADE CONSTRAINTS;
DROP TABLE buy CASCADE CONSTRAINTS;
DROP TABLE product CASCADE CONSTRAINTS;
DROP TABLE charge CASCADE CONSTRAINTS;
DROP TABLE mlieage CASCADE CONSTRAINTS;
DROP TABLE member CASCADE CONSTRAINTS;

INSERT INTO auth(auth_no, auth_info) VALUES(1, '관리자');
INSERT INTO member(mem_no, auth_no, mem_id, mem_pass, mem_name, mem_tel, mem_mail, mem_job, mem_acc, mem_confirm, mem_date) VALUES((SELECT nvl(MAX(mem_no), 0) + 1 as mem_no FROM member), 1, 'schyyy', '123', 'sch', '01022220000', 'schyyy@naver.com', '학생', 0, 'Y', SYSDATE);
INSERT INTO categrp(grp_no, grp_classification, grp_title, grp_seqno, grp_visible, grp_rdate) VALUES((SELECT NVL(MAX(grp_no), 0)+1 as grp_no FROM categrp), 1, 'SAMSUNG올웨이즈9', 1, 'Y', sysdate);
INSERT INTO category(gory_no, grp_no, mem_no, gory_title, gory_seqno, gory_visible, gory_ids, gory_cnt, gory_rdate) VALUES((SELECT NVL(MAX(gory_no), 0)+1 as gory_no FROM category), 1, 1, '삼성', 0, 'Y', 'ad', 1, sysdate);
INSERT INTO product(pr_no, pr_maker, pr_title, pr_contents, pr_cnt, pr_rdate, pr_price, pr_visible, pr_payment) VALUES((SELECT nvl(MAX(pr_no), 0) + 1 as pr_no FROM product), 'LG', '그램팝니다', '2018년 올데이그램 판매', 0, SYSDATE, 1000000, 'Y', 'Y');
INSERT INTO buy(buy_no, pr_no, mem_no, buy_rdate) VALUES((SELECT nvl(MAX(buy_no), 0) + 1 as buy_no FROM buy), 1, 1, SYSDATE);
INSERT INTO dealstate(dstate_no, dstate, dstate_date) VALUES (1, '진행 중', SYSDATE);
INSERT INTO dealway(dway_no, dway) VALUES (1, '직거래');

/**********************************/
/* Table Name: 상품 거래 */
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

COMMENT ON TABLE deal is '상품 거래';
COMMENT ON COLUMN deal.deal_no is '거래번호';
COMMENT ON COLUMN deal.d_state is '거래상태';
COMMENT ON COLUMN deal.d_way is '거래방법';
COMMENT ON COLUMN deal.d_check is '거래확인';
COMMENT ON COLUMN deal.d_date is '거래등록일';
COMMENT ON COLUMN deal.buy_no is '구매번호';
COMMENT ON COLUMN deal.pr_no is '상품번호';

SELECT deal_no, usemileage, ddate, dmemo, mem_no, pr_no, buy_no, dway_no, dstate_no
FROM deal;

 DEAL_NO USEMILEAGE DDATE                 DMEMO MEM_NO PR_NO BUY_NO DWAY_NO DSTATE_NO
 ------- ---------- --------------------- ----- ------ ----- ------ ------- ---------
       1     100000 2018-06-19 19:19:50.0 메모       1     1      1       1         1

DELETE FROM deal;

1) 거래 한 건 등록

INSERT INTO deal(deal_no, usemileage, ddate, dmemo, mem_no, pr_no, buy_no, dway_no, dstate_no)
VALUES ((SELECT nvl(MAX(deal_no), 0) + 1 as deal_no FROM deal), 100000, SYSDATE, '메모', 1, 1, 1, 1, 1);

select * from deal;

