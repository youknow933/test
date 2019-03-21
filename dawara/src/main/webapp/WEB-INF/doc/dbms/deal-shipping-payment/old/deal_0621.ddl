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
/* Table Name: ȸ�� */
/**********************************/
CREATE TABLE member(
		mem_no                        		NUMBER(6)		 NOT NULL		 PRIMARY KEY
);

COMMENT ON TABLE member is 'ȸ��';
COMMENT ON COLUMN member.mem_no is 'ȸ����ȣ';


/**********************************/
/* Table Name: ���ϸ��� */
/**********************************/
CREATE TABLE mlieage(
		mileage_no                    		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		mile_amount                   		NUMBER(10)		 DEFAULT 0		 NOT NULL,
		mem_no                        		NUMBER(6)		 NOT NULL,
  FOREIGN KEY (mem_no) REFERENCES member (mem_no)
);

COMMENT ON TABLE mlieage is '���ϸ���';
COMMENT ON COLUMN mlieage.mileage_no is '���ϸ�����ȣ';
COMMENT ON COLUMN mlieage.mile_amount is '���ϸ���';
COMMENT ON COLUMN mlieage.mem_no is 'ȸ����ȣ';


/**********************************/
/* Table Name: ���ϸ��� ���� */
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

COMMENT ON TABLE charge is '���ϸ��� ����';
COMMENT ON COLUMN charge.charge_no is '������ȣ';
COMMENT ON COLUMN charge.ch_mileage is '�������ϸ���';
COMMENT ON COLUMN charge.ch_date is '������¥';
COMMENT ON COLUMN charge.ch_way is '��������';
COMMENT ON COLUMN charge.mem_no is 'ȸ����ȣ';
COMMENT ON COLUMN charge.mileage_no is '���ϸ�����ȣ';


/**********************************/
/* Table Name: ��ǰ */
/**********************************/
CREATE TABLE product(
		pr_no                         		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		mem_no                        		NUMBER(6)		 NULL ,
  FOREIGN KEY (mem_no) REFERENCES member (mem_no)
);

COMMENT ON TABLE product is '��ǰ';
COMMENT ON COLUMN product.pr_no is '��ǰ��ȣ';
COMMENT ON COLUMN product.mem_no is 'ȸ����ȣ';


/**********************************/
/* Table Name: ��ǰ ���� */
/**********************************/
CREATE TABLE buy(
		buy_no                        		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		pr_no                         		NUMBER(10)		 NOT NULL,
		mem_no                        		NUMBER(6)		 NOT NULL,
		buy_rdate                     		DATE		 NOT NULL,
  FOREIGN KEY (pr_no) REFERENCES product (pr_no),
  FOREIGN KEY (mem_no) REFERENCES member (mem_no)
);

COMMENT ON TABLE buy is '��ǰ ����';
COMMENT ON COLUMN buy.buy_no is '���Ź�ȣ';
COMMENT ON COLUMN buy.pr_no is '��ǰ��ȣ';
COMMENT ON COLUMN buy.mem_no is 'ȸ����ȣ';
COMMENT ON COLUMN buy.buy_rdate is '���ŵ����';


/**********************************/
/* Table Name: ��ǰ �ŷ� */
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

COMMENT ON TABLE deal is '��ǰ �ŷ�';
COMMENT ON COLUMN deal.deal_no is '�ŷ���ȣ';
COMMENT ON COLUMN deal.d_state is '�ŷ�����';
COMMENT ON COLUMN deal.d_way is '�ŷ����';
COMMENT ON COLUMN deal.d_check is '�ŷ�Ȯ��';
COMMENT ON COLUMN deal.d_date is '�ŷ������';
COMMENT ON COLUMN deal.buy_no is '���Ź�ȣ';
COMMENT ON COLUMN deal.pr_no is '��ǰ��ȣ';


/**********************************/
/* Table Name: ���Ż�ǰ ���� */
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

COMMENT ON TABLE payment is '���Ż�ǰ ����';
COMMENT ON COLUMN payment.payment_no is '������ȣ';
COMMENT ON COLUMN payment.pay_way is '��������';
COMMENT ON COLUMN payment.pay_amount is '�����ݾ�';
COMMENT ON COLUMN payment.pay_check is '����Ȯ��';
COMMENT ON COLUMN payment.pay_date is '������¥';
COMMENT ON COLUMN payment.mileage_no is '���ϸ�����ȣ';


/**********************************/
/* Table Name: ������ǰ ��� */
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

COMMENT ON TABLE delivery is '������ǰ ���';
COMMENT ON COLUMN delivery.delivery_no is '��۹�ȣ';
COMMENT ON COLUMN delivery.del_addr is '�����';
COMMENT ON COLUMN delivery.del_receiver is '��۹޴� ��';
COMMENT ON COLUMN delivery.r_mobile is '�޴»�� �޴���';
COMMENT ON COLUMN delivery.del_memo is '��۽� ��û����';
COMMENT ON COLUMN delivery.del_check is '�߼�Ȯ��';
COMMENT ON COLUMN delivery.del_date is '�߼۳�¥';
COMMENT ON COLUMN delivery.buy_no is '���Ź�ȣ';
COMMENT ON COLUMN delivery.payment_no is '������ȣ';


/**********************************/
/* Table Name: ��ۻ�ǰ ����Ȯ�� */
/**********************************/
CREATE TABLE receive(
		receive_no                    		NUMBER(10)		 DEFAULT 'N'		 NOT NULL		 PRIMARY KEY,
		r_check                       		CHAR(1)		 DEFAULT 'N'		 NOT NULL,
		r_cdate                       		DATE		 NOT NULL,
		delivery_no                   		NUMBER(10)		 NULL ,
  FOREIGN KEY (delivery_no) REFERENCES delivery (delivery_no)
);

COMMENT ON TABLE receive is '��ۻ�ǰ ����Ȯ��';
COMMENT ON COLUMN receive.receive_no is '�����ȣ';
COMMENT ON COLUMN receive.r_check is '����Ȯ��';
COMMENT ON COLUMN receive.r_cdate is '����Ȯ�γ�¥';
COMMENT ON COLUMN receive.delivery_no is '��۹�ȣ';


