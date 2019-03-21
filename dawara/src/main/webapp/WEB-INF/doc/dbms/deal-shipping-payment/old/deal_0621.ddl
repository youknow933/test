DROP TABLE receive CASCADE CONSTRAINTS;
DROP TABLE delivery CASCADE CONSTRAINTS;
DROP TABLE payment CASCADE CONSTRAINTS;
DROP TABLE deal CASCADE CONSTRAINTS;
DROP TABLE buy CASCADE CONSTRAINTS;
DROP TABLE product CASCADE CONSTRAINTS;
DROP TABLE charge CASCADE CONSTRAINTS;
DROP TABLE mlieage CASCADE CONSTRAINTS;
DROP TABLE member CASCADE CONSTRAINTS;

/**********************************/
/* Table Name: 회원 */
/**********************************/
CREATE TABLE member(
		mem_no                        		NUMBER(6)		 NOT NULL		 PRIMARY KEY
);

COMMENT ON TABLE member is '회원';
COMMENT ON COLUMN member.mem_no is '회원번호';


/**********************************/
/* Table Name: 마일리지 */
/**********************************/
CREATE TABLE mlieage(
		mileage_no                    		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		mile_amount                   		NUMBER(10)		 DEFAULT 0		 NOT NULL,
		mem_no                        		NUMBER(6)		 NOT NULL,
  FOREIGN KEY (mem_no) REFERENCES member (mem_no)
);

COMMENT ON TABLE mlieage is '마일리지';
COMMENT ON COLUMN mlieage.mileage_no is '마일리지번호';
COMMENT ON COLUMN mlieage.mile_amount is '마일리지';
COMMENT ON COLUMN mlieage.mem_no is '회원번호';


/**********************************/
/* Table Name: 마일리지 충전 */
/**********************************/
CREATE TABLE charge(
		charge_no                     		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		ch_mileage                    		NUMBER(10)		 NOT NULL,
		ch_date                       		DATE		 NOT NULL,
		ch_way                        		VARCHAR2(20)		 NOT NULL,
		mem_no                        		NUMBER(6)		 NOT NULL,
		mileage_no                    		NUMBER(10)		 NOT NULL,
  FOREIGN KEY (mem_no) REFERENCES member (mem_no),
  FOREIGN KEY (mileage_no) REFERENCES mlieage (mileage_no)
);

COMMENT ON TABLE charge is '마일리지 충전';
COMMENT ON COLUMN charge.charge_no is '충전번호';
COMMENT ON COLUMN charge.ch_mileage is '충전마일리지';
COMMENT ON COLUMN charge.ch_date is '충전날짜';
COMMENT ON COLUMN charge.ch_way is '충전수단';
COMMENT ON COLUMN charge.mem_no is '회원번호';
COMMENT ON COLUMN charge.mileage_no is '마일리지번호';


/**********************************/
/* Table Name: 상품 */
/**********************************/
CREATE TABLE product(
		pr_no                         		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		mem_no                        		NUMBER(6)		 NULL ,
  FOREIGN KEY (mem_no) REFERENCES member (mem_no)
);

COMMENT ON TABLE product is '상품';
COMMENT ON COLUMN product.pr_no is '상품번호';
COMMENT ON COLUMN product.mem_no is '회원번호';


/**********************************/
/* Table Name: 상품 구매 */
/**********************************/
CREATE TABLE buy(
		buy_no                        		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		pr_no                         		NUMBER(10)		 NOT NULL,
		mem_no                        		NUMBER(6)		 NOT NULL,
		buy_rdate                     		DATE		 NOT NULL,
  FOREIGN KEY (pr_no) REFERENCES product (pr_no),
  FOREIGN KEY (mem_no) REFERENCES member (mem_no)
);

COMMENT ON TABLE buy is '상품 구매';
COMMENT ON COLUMN buy.buy_no is '구매번호';
COMMENT ON COLUMN buy.pr_no is '상품번호';
COMMENT ON COLUMN buy.mem_no is '회원번호';
COMMENT ON COLUMN buy.buy_rdate is '구매등록일';


/**********************************/
/* Table Name: 상품 거래 */
/**********************************/
CREATE TABLE deal(
		deal_no                       		NUMBER(10)		 NOT NULL,
		d_state                       		VARCHAR2(20)		 NOT NULL,
		d_way                         		VARCHAR2(20)		 NOT NULL,
		d_check                       		CHAR(1)		 DEFAULT 'N'		 NULL ,
		d_date                        		DATE		 NOT NULL,
		buy_no                        		NUMBER(10)		 NULL ,
		pr_no                         		NUMBER(10)		 NULL ,
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


/**********************************/
/* Table Name: 구매상품 결제 */
/**********************************/
CREATE TABLE payment(
		payment_no                    		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		pay_way                       		VARCHAR2(20)		 NOT NULL,
		pay_amount                    		NUMBER(10)		 NOT NULL,
		pay_check                     		CHAR(1)		 DEFAULT 'N'		 NOT NULL,
		pay_date                      		DATE		 NOT NULL,
		mileage_no                    		NUMBER(10)		 NULL ,
  FOREIGN KEY (mileage_no) REFERENCES mlieage (mileage_no),
  FOREIGN KEY () REFERENCES deal ()
);

COMMENT ON TABLE payment is '구매상품 결제';
COMMENT ON COLUMN payment.payment_no is '결제번호';
COMMENT ON COLUMN payment.pay_way is '결제수단';
COMMENT ON COLUMN payment.pay_amount is '결제금액';
COMMENT ON COLUMN payment.pay_check is '결제확인';
COMMENT ON COLUMN payment.pay_date is '결제날짜';
COMMENT ON COLUMN payment.mileage_no is '마일리지번호';


/**********************************/
/* Table Name: 결제상품 배송 */
/**********************************/
CREATE TABLE delivery(
		delivery_no                   		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		del_addr                      		VARCHAR2(300)		 NOT NULL,
		del_receiver                  		VARCHAR2(20)		 NOT NULL,
		r_mobile                      		NUMBER(11)		 NOT NULL,
		del_memo                      		VARCHAR2(100)		 NULL ,
		del_check                     		CHAR(1)		 DEFAULT 'N'		 NOT NULL,
		del_date                      		DATE		 NOT NULL,
		buy_no                        		NUMBER(10)		 NOT NULL,
		payment_no                    		NUMBER(10)		 NULL ,
  FOREIGN KEY (buy_no) REFERENCES buy (buy_no),
  FOREIGN KEY (payment_no) REFERENCES payment (payment_no)
);

COMMENT ON TABLE delivery is '결제상품 배송';
COMMENT ON COLUMN delivery.delivery_no is '배송번호';
COMMENT ON COLUMN delivery.del_addr is '배송지';
COMMENT ON COLUMN delivery.del_receiver is '배송받는 분';
COMMENT ON COLUMN delivery.r_mobile is '받는사람 휴대폰';
COMMENT ON COLUMN delivery.del_memo is '배송시 요청사항';
COMMENT ON COLUMN delivery.del_check is '발송확인';
COMMENT ON COLUMN delivery.del_date is '발송날짜';
COMMENT ON COLUMN delivery.buy_no is '구매번호';
COMMENT ON COLUMN delivery.payment_no is '결제번호';


/**********************************/
/* Table Name: 배송상품 수취확인 */
/**********************************/
CREATE TABLE receive(
		receive_no                    		NUMBER(10)		 DEFAULT 'N'		 NOT NULL		 PRIMARY KEY,
		r_check                       		CHAR(1)		 DEFAULT 'N'		 NOT NULL,
		r_cdate                       		DATE		 NOT NULL,
		delivery_no                   		NUMBER(10)		 NULL ,
  FOREIGN KEY (delivery_no) REFERENCES delivery (delivery_no)
);

COMMENT ON TABLE receive is '배송상품 수취확인';
COMMENT ON COLUMN receive.receive_no is '수취번호';
COMMENT ON COLUMN receive.r_check is '수취확인';
COMMENT ON COLUMN receive.r_cdate is '수취확인날짜';
COMMENT ON COLUMN receive.delivery_no is '배송번호';


