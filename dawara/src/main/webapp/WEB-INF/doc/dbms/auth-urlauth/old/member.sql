1) ȸ�� ���̺� ����
CREATE TABLE member (
  mem_no       NUMBER(6) NOT NULL     PRIMARY KEY, -- ȸ�� ��ȣ, ���ڵ带 �����ϴ� �÷� 
  auth_no                            NUMBER(10)     NOT NULL, --���� ��ȣ
  mem_id           VARCHAR(20)   NOT NULL UNIQUE, -- ���̵�, �ߺ� �ȵ�, ���ڵ带 ���� 
  mem_pic       VARCHAR(100)    NULL,     -- ȸ������
  mem_pass    VARCHAR(60)   NOT NULL, -- �н�����, ������ ����
  mem_name    VARCHAR(20)   NOT NULL, -- ����, �ѱ� 10�� ���� ����
  mem_tel          VARCHAR(14)   NOT NULL, -- ��ȭ��ȣ
  mem_mail      VARCHAR(20)     NOT NULL, -- �̸���
  mem_job         VARCHAR(20)     NOT NULL, -- ȸ������
  mem_zipcode   VARCHAR(5)        NULL, -- �����ȣ, 12345
  mem_addr1  VARCHAR(80)       NULL, -- �ּ� 1
  mem_addr2  VARCHAR(50)       NULL, -- �ּ� 2    
  mem_acc   NUMBER(6)   DEFAULT 0 NOT NULL,   -- ȸ���� �Ű����Ƚ��
  mem_mile   NUMBER(9)   DEFAULT 0 NOT NULL,   -- ȸ�� ���ϸ���(���ſ�)
  mem_confirm    VARCHAR(1)         DEFAULT 'N' NOT NULL, -- �̸��� ��ũ Ŭ�� ����, Y:Ŭ��, N:Ŭ������
  mem_act   NUMBER(6) DEFAULT 3 NOT NULL, -- ȸ�� ���� ��ȣ
  mem_date     DATE             NOT NULL, -- ������    
    FOREIGN KEY (auth_no) REFERENCES AUTH (auth_no)
);

ALTER TABLE MEMBER ADD mem_mile NUMBER(9); --mem_mile �÷� �߰�
ALTER TABLE MEMBER RENAME COLUMN mem_rdate TO mem_date;
ALTER TABLE MEMBER RENAME COLUMN authno TO auth_no;

drop table member;

COMMENT ON TABLE member is 'ȸ��'; 
COMMENT ON COLUMN member.MEM_NO is 'ȸ�� ��ȣ';
COMMENT ON COLUMN member.auth_no is '���� ��ȣ';
COMMENT ON COLUMN member.MEM_ID is '���̵�';
COMMENT ON COLUMN member.MEM_PIC is 'ȸ������';
COMMENT ON COLUMN member.MEM_PASS is '�н�����';
COMMENT ON COLUMN member.MEM_NAME is '����';
COMMENT ON COLUMN member.MEM_TEL is '��ȭ��ȣ';
COMMENT ON COLUMN member.MEM_MAIL is '�̸����ּ�';
COMMENT ON COLUMN member.MEM_JOB is 'ȸ������';
COMMENT ON COLUMN member.mem_zipcode is '�����ȣ';
COMMENT ON COLUMN member.MEM_ADDR1 is '�ּ�1';
COMMENT ON COLUMN member.MEM_ADDR2 is '�ּ�2';
COMMENT ON COLUMN member.MEM_ACC is '�Ű�Ƚ��';
COMMENT ON COLUMN member.MEM_mile is 'ȸ�� ���ϸ���';
COMMENT ON COLUMN member.MEM_CONFIRM is '����Ȯ�ο���';
COMMENT ON COLUMN member.MEM_ACT is 'ȸ�����ѹ�ȣ'; -- 1: ������, 2: �ΰ�����, 3: �Ϲ�ȸ��, 4: ���ȸ��, 5:������Ʈ
COMMENT ON COLUMN member.mem_date is '������';

