drop table buysell;
drop table card;
drop table MYMLIEAGE;
drop table CHARGEMILEAGE;
drop table CHARGEWAY;

drop table dealstate;
drop table dealway;
drop table notice;
drop table report;
drop table payway;
drop table qna;
drop table savecash;
drop table savepoint;


drop table deal;     
drop table shipping;

drop table buy;      
drop table cart;     
drop table reply;    
drop table product;

drop table category; 
drop table categrp; 
drop table surf;    

drop table notice;
drop table qna;
drop table report;

drop table login;
drop table member;
drop table mem_auth;
drop table URL;
drop table ACCESS_URL;
drop table urlauth;
drop table auth;
----------------------------------------
delete from deal;
delete from shipping;

delete from buy;
delete from product;
delete from cart;
delete from reply;

delete from category;
delete from categrp;
delete from surf;

delete from login;
delete from member;

delete from urlauth;
delete from auth;

/**********************************/ 
/* Table Name: ���� */
/**********************************/

1. ���̺�
- ���� ���̺�
- �����ں� ���� �ο�
CREATE TABLE AUTH(
    AUTH_NO                            NUMBER(10)    NOT NULL    PRIMARY KEY,
    AUTH_INFO                          VARCHAR2(100)    NOT NULL
);

COMMENT ON TABLE AUTH is '����';
COMMENT ON COLUMN AUTH.AUTH_NO is '���� ��ȣ';
COMMENT ON COLUMN AUTH.AUTH_INFO is '���� ����';

select * from auth


2. ���
- ���� ���
  INSERT INTO auth(AUTH_NO, AUTH_INFO)   
  VALUES((select nvl(max(auth_no), 0) + 1 as auth_no from auth), '������');
  
--  INSERT INTO auth(AUTH_NO, AUTH_INFO)   
--  VALUES((select nvl(max(auth_no), 0) + 1 as auth_no from auth), '���� ������');
  
  INSERT INTO auth(AUTH_NO, AUTH_INFO)    
  VALUES((select nvl(max(auth_no), 0) + 1 as auth_no from auth), '�Ϲ� ȸ��');
  
--  INSERT INTO auth(AUTH_NO, AUTH_INFO)    
--  VALUES((select nvl(max(auth_no), 0) + 1 as auth_no from auth), '��� ȸ��');
  
  INSERT INTO auth(AUTH_NO, AUTH_INFO)    
  VALUES((select nvl(max(auth_no), 0) + 1 as auth_no from auth), '�� ����Ʈ');
  
--  INSERT INTO auth(AUTH_NO, AUTH_INFO)    
--  VALUES((select nvl(max(auth_no), 0) + 1 as auth_no from auth), 'Ż�� ȸ��');



3. ��� 
- ���� ���
  SELECT AUTH_NO, AUTH_INFO
  FROM auth
  ORDER BY AUTH_NO;     

 AUTH_NO AUTH_INFO
 ------- ---------
       1 ������
       2 ���� ������
       3 �Ϲ� ȸ��
       4 ��� ȸ��
       5 �� ����Ʈ
       6 Ż�� ȸ��

      

4. ��ȸ
- ���� ��ȣ�� '3'�� ������ ���� ���� ��ȸ
  SELECT AUTH_NO, AUTH_INFO
  FROM auth
  WHERE AUTH_NO = '3';

 AUTH_NO AUTH_INFO
 ------- ---------
       3 �Ϲ� ȸ��
      
  

5. ����
- ���� ��ȣ�� '5'�� ������ ���� ������ '���� ȸ��' ���� ����
  UPDATE auth
  SET auth_info = '���� ȸ��'
  WHERE auth_no = '5';
  
  SELECT auth_no, auth_info
  FROM auth
  WHERE auth_no = '5';
  
 AUTH_NO AUTH_INFO
 ------- ---------
       5 ���� ȸ��
  
  

6. ����
- ���� ��ȣ�� '5'�� ������ ����
  DELETE FROM auth
  WHERE auth_no = '5';
  
  SELECT auth_no, auth_info
  FROM auth
  WHERE auth_no = '5';

 AUTH_NO AUTH_INFO
 ------- ---------
 


/**********************************/
/* Table Name: ȸ�� */
/**********************************/

CREATE TABLE MEMBER(
    MEM_NO                            NUMBER(6)    NOT NULL    PRIMARY KEY,
    AUTH_NO                            NUMBER(10)     NOT NULL,
    CREDITNO                          NUMBER(10)     NOT NULL,
    MEM_ID                            VARCHAR2(20)     NOT NULL,
    MEM_PIC                           VARCHAR2(100)    NULL ,
    MEM_PASS                          VARCHAR2(60)     NOT NULL,
    MEM_NAME                          VARCHAR2(20)     NOT NULL,
    MEM_TEL                           VARCHAR2(14)     NOT NULL,
    MEM_MAIL                          VARCHAR2(20)     NOT NULL,
    MEM_JOB                           VARCHAR2(20)     NOT NULL,
    MEM_ZIPCODE                       VARCHAR2(5)    NULL ,
    MEM_ADDR1                         VARCHAR2(80)     NULL ,
    MEM_ADDR2                         VARCHAR2(50)     NULL ,
    MEM_ACC                           NUMBER(6)    NOT NULL,
    MEM_CONFIRM                       VARCHAR2(1)    NOT NULL,
    MEM_DATE                          DATE     NOT NULL,
  FOREIGN KEY (AUTH_NO) REFERENCES AUTH (AUTH_NO),
  FOREIGN KEY (CREDITNO) REFERENCES CREDIT (CREDITNO),
  CONSTRAINT SYS_C007461 UNIQUE (MEM_ID)
);
 
COMMENT ON TABLE MEMBER is 'ȸ��';
COMMENT ON COLUMN MEMBER.MEM_NO is 'ȸ�� ��ȣ';
COMMENT ON COLUMN MEMBER.AUTH_NO is '���� ��ȣ';
COMMENT ON COLUMN MEMBER.CREDITNO is '�ſ��� ��ȣ';
COMMENT ON COLUMN MEMBER.MEM_ID is '���̵�';
COMMENT ON COLUMN MEMBER.MEM_PIC is 'ȸ������';
COMMENT ON COLUMN MEMBER.MEM_PASS is '�н�����';
COMMENT ON COLUMN MEMBER.MEM_NAME is '����';
COMMENT ON COLUMN MEMBER.MEM_TEL is '��ȭ��ȣ';
COMMENT ON COLUMN MEMBER.MEM_MAIL is '�̸����ּ�';
COMMENT ON COLUMN MEMBER.MEM_JOB is 'ȸ������';
COMMENT ON COLUMN MEMBER.MEM_ZIPCODE is '�����ȣ';
COMMENT ON COLUMN MEMBER.MEM_ADDR1 is '�ּ�1';
COMMENT ON COLUMN MEMBER.MEM_ADDR2 is '�ּ�2';
COMMENT ON COLUMN MEMBER.MEM_ACC is '�Ű�Ƚ��';
COMMENT ON COLUMN MEMBER.MEM_CONFIRM is '����Ȯ�ο���';
COMMENT ON COLUMN MEMBER.MEM_DATE is '������';


SELECT auth_no, auth_info
FROM auth
WHERE auth_info LIKE '%ȣ��%'
order by auth_no ASC
 

SELECT auth_no, auth_info, r
FROM(
         SELECT auth_no, auth_info, rownum as r
         FROM (
                   SELECT auth_no, auth_info 
                   FROM auth
                   ORDER BY auth_no ASC
         )  
)
WHERE r>=1 AND r <=3;



