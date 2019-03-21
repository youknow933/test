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



2. ���
- ���� ���
  INSERT INTO auth(AUTH_NO, AUTH_INFO)   
  VALUES((select nvl(max(auth_no), 0) + 1 as auth_no from auth), '������');
  
  INSERT INTO auth(AUTH_NO, AUTH_INFO)   
  VALUES((select nvl(max(auth_no), 0) + 1 as auth_no from auth), '���� ������');
  
  INSERT INTO auth(AUTH_NO, AUTH_INFO)    
  VALUES((select nvl(max(auth_no), 0) + 1 as auth_no from auth), '�Ϲ� ȸ��');
  
  INSERT INTO auth(AUTH_NO, AUTH_INFO)    
  VALUES((select nvl(max(auth_no), 0) + 1 as auth_no from auth), '��� ȸ��');
  
  INSERT INTO auth(AUTH_NO, AUTH_INFO)    
  VALUES((select nvl(max(auth_no), 0) + 1 as auth_no from auth), '�� ����Ʈ');
  
  INSERT INTO auth(AUTH_NO, AUTH_INFO)    
  VALUES((select nvl(max(auth_no), 0) + 1 as auth_no from auth), 'Ż�� ȸ��');
  

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
/* Table Name: ���Ѻ� ���� URL */
/**********************************/
1. ���̺�
- ���Ѻ� ���� URL ���̺�
- �ο��� ���Ѻ��� ���� ������ URL �ּ� ���� ����
CREATE TABLE urlauth(
    urlauth_no                         NUMBER(10)     NOT NULL    PRIMARY KEY,
    urlauth_address                        VARCHAR2(200)    NOT NULL,
    auth_no                            NUMBER(10)     NOT NULL,
  FOREIGN KEY (auth_no) REFERENCES AUTH (auth_no)
);

COMMENT ON TABLE urlauth is '���Ѻ� ���� URL';
COMMENT ON COLUMN urlauth.urlauth_no is '���Ѻ� ���� URL ��ȣ';
COMMENT ON COLUMN urlauth.urlauth_address is '���Ѻ� ���� URL �ּ�';
COMMENT ON COLUMN urlauth.auth_no is '���� ��ȣ';



2. ���
- ���Ѻ� ���� URL ���
  INSERT INTO urlauth(urlauth_no, urlauth_address, auth_no)   
  VALUES((select nvl(max(urlauth_no), 0) + 1 as urlauth_no from urlauth), '����������', '1');
  
  INSERT INTO urlauth(urlauth_no, urlauth_address, auth_no)   
  VALUES((select nvl(max(urlauth_no), 0) + 1 as urlauth_no from urlauth), 'ī�װ�', '1');
  

  
3. ��� 
- ���Ѻ� ���� URL ���
  SELECT urlauth_no, urlauth_address, auth_no
  FROM urlauth
  ORDER BY urlauth_no;     

 URLAUTH_NO URLAUTH_ADDRESS AUTH_NO
 ---------- --------------- -------
          1 ����������                 1
          2 ī�װ�                  1
  
  
      
4. ��ȸ
- ���Ѻ� ���� URL ��ȣ�� '2'�� ���Ѻ� ���� URL ���Ѻ� ���� URL ���� ��ȸ
  SELECT urlauth_no, urlauth_address, auth_no
  FROM urlauth
  WHERE urlauth_no = '2';

 URLAUTH_NO URLAUTH_ADDRESS AUTH_NO
 ---------- --------------- -------
          2 ī�װ�                  1
  
  
  
5. ����
- ���Ѻ� ���� URL ��ȣ�� '2'�� ���Ѻ� ���� URL�� �ּҸ� '��������' ���� ����
  UPDATE urlauth
  SET urlauth_address = '��������'
  WHERE urlauth_no = '2';
  
  SELECT urlauth_no, urlauth_address, auth_no
  FROM urlauth
  WHERE urlauth_no = '2';

 URLAUTH_NO URLAUTH_ADDRESS AUTH_NO
 ---------- --------------- -------
          2 ��������                  1
  
  
  
6. ����
- ���Ѻ� ���� URL ��ȣ�� '2'�� ���Ѻ� ���� URL ����
  DELETE FROM urlauth
  WHERE urlauth_no = '2';
  
  SELECT urlauth_no, urlauth_address, auth_no
  FROM urlauth
  WHERE urlauth_no = '2';

 URLAUTH_NO URLAUTH_ADDRESS AUTH_NO
 ---------- --------------- -------

 
 
 
 
/**********************************/
/* Table Name: ���� �ּ� */
/**********************************/
1. ���̺�
- ���� �ּ�
CREATE TABLE url(
    url_no                         NUMBER(10)        NOT NULL    PRIMARY KEY,
    url_address                  VARCHAR2(200)    NOT NULL,
    urlauth_no                   NUMBER(10)         NOT NULL,
  FOREIGN KEY (urlauth_no) REFERENCES URLAUTH (urlauth_no)
);

COMMENT ON TABLE urlauth is '���� �ּ�';
COMMENT ON COLUMN url.url_no is '���� �ּ� ��ȣ';
COMMENT ON COLUMN url.url_address is '���� �ּ� ����';
COMMENT ON COLUMN url.auth_no is '���� ��ȣ';



2. ���
- ���Ѻ� ���� URL ���
  INSERT INTO url(url_no, url_address, auth_no)   
  VALUES((select nvl(max(url_no), 0) + 1 as url_no from url), 'index.jsp', '1');
  
  

  
3. ��� 
- ���Ѻ� ���� URL ���
  SELECT urlauth_no, urlauth_address, auth_no
  FROM urlauth
  ORDER BY urlauth_no;     

 URLAUTH_NO URLAUTH_ADDRESS AUTH_NO
 ---------- --------------- -------
          1 ����������                 1
          2 ī�װ�                  1
  
  
      
4. ��ȸ
- ���Ѻ� ���� URL ��ȣ�� '2'�� ���Ѻ� ���� URL ���Ѻ� ���� URL ���� ��ȸ
  SELECT urlauth_no, urlauth_address, auth_no
  FROM urlauth
  WHERE urlauth_no = '2';

 URLAUTH_NO URLAUTH_ADDRESS AUTH_NO
 ---------- --------------- -------
          2 ī�װ�                  1
  
  
  
5. ����
- ���Ѻ� ���� URL ��ȣ�� '2'�� ���Ѻ� ���� URL�� �ּҸ� '��������' ���� ����
  UPDATE urlauth
  SET urlauth_address = '��������'
  WHERE urlauth_no = '2';
  
  SELECT urlauth_no, urlauth_address, auth_no
  FROM urlauth
  WHERE urlauth_no = '2';

 URLAUTH_NO URLAUTH_ADDRESS AUTH_NO
 ---------- --------------- -------
          2 ��������                  1
  
  
  
6. ����
- ���Ѻ� ���� URL ��ȣ�� '2'�� ���Ѻ� ���� URL ����
  DELETE FROM url
  WHERE url_no = '2';
  
  SELECT url_no, url_address, auth_no
  FROM url
  WHERE url_no = '2';

 URLAUTH_NO URLAUTH_ADDRESS AUTH_NO
 ---------- --------------- -------

 
 
 
