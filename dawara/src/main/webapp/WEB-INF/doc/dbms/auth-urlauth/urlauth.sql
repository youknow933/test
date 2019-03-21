drop table urlauth;
delete from urlauth;


/**********************************/
/* Table Name: ���Ѻ� ���� URL */
/**********************************/
1. ���̺�
- ���Ѻ� ���� URL ���̺�
- �ο��� ���Ѻ��� ���� ������ URL �ּ� ���� ����

CREATE TABLE urlauth(
    urlauth_no                         NUMBER(10)     NOT NULL    PRIMARY KEY,
    urlauth_address                        VARCHAR2(200)    NOT NULL,`
    auth_no                            NUMBER(10)     NOT NULL,
  FOREIGN KEY (auth_no) REFERENCES AUTH (auth_no)
);


COMMENT ON TABLE urlauth is '���Ѻ� ���� URL';
COMMENT ON COLUMN urlauth.urlauth_no is '���Ѻ� ���� URL ��ȣ';
COMMENT ON COLUMN urlauth.urlauth_address is '���Ѻ� ���� URL �ּ�';
COMMENT ON COLUMN urlauth.auth_no is '���� ��ȣ';



2. ���
delete from urlauth;

- ���Ѻ� ���� URL ���
  INSERT INTO urlauth(urlauth_no, urlauth_address, auth_no)   
  VALUES((select nvl(max(urlauth_no), 0) + 1 as urlauth_no from urlauth), '/member/list_by_member.do', '1');
  
  INSERT INTO urlauth(urlauth_no, urlauth_address, auth_no)   
  VALUES((select nvl(max(urlauth_no), 0) + 1 as urlauth_no from urlauth), '/auth/list_search_paging.do', '1');
  
  INSERT INTO urlauth(urlauth_no, urlauth_address, auth_no)   
  VALUES((select nvl(max(urlauth_no), 0) + 1 as urlauth_no from urlauth), '/urlauth/list_search_paging.do', '1');
  
  INSERT INTO urlauth(urlauth_no, urlauth_address, auth_no)   
  VALUES((select nvl(max(urlauth_no), 0) + 1 as urlauth_no from urlauth), '/member/list_by_login.do', '2');
  
  INSERT INTO urlauth(urlauth_no, urlauth_address, auth_no)   
  VALUES((select nvl(max(urlauth_no), 0) + 1 as urlauth_no from urlauth), '/categrp/list.do', '2');
  
  INSERT INTO urlauth(urlauth_no, urlauth_address, auth_no)   
  VALUES((select nvl(max(urlauth_no), 0) + 1 as urlauth_no from urlauth), '/category/list.do', '2');
  
  INSERT INTO urlauth(urlauth_no, urlauth_address, auth_no)   
  VALUES((select nvl(max(urlauth_no), 0) + 1 as urlauth_no from urlauth), '/product/list_mem_no.do', '3');
  
  INSERT INTO urlauth(urlauth_no, urlauth_address, auth_no)   
  VALUES((select nvl(max(urlauth_no), 0) + 1 as urlauth_no from urlauth), '/product/list_sell_mem_no.do', '3');
  
  INSERT INTO urlauth(urlauth_no, urlauth_address, auth_no)   
  VALUES((select nvl(max(urlauth_no), 0) + 1 as urlauth_no from urlauth), '/product/cart_list.do', '3');
  
  INSERT INTO urlauth(urlauth_no, urlauth_address, auth_no)   
  VALUES((select nvl(max(urlauth_no), 0) + 1 as urlauth_no from urlauth), '/product/buy_list.do', '3');
  
  INSERT INTO urlauth(urlauth_no, urlauth_address, auth_no)   
  VALUES((select nvl(max(urlauth_no), 0) + 1 as urlauth_no from urlauth), '/deal/searchList_paging.do', '4');
  
  INSERT INTO urlauth(urlauth_no, urlauth_address, auth_no)   
  VALUES((select nvl(max(urlauth_no), 0) + 1 as urlauth_no from urlauth), '/shipping/searchList_by_mem_no_paging.do', '4');
  
  INSERT INTO urlauth(urlauth_no, urlauth_address, auth_no)   
  VALUES((select nvl(max(urlauth_no), 0) + 1 as urlauth_no from urlauth), '/payment/searchList_by_mem_no_paging.do', '4');
  
  INSERT INTO urlauth(urlauth_no, urlauth_address, auth_no)   
  VALUES((select nvl(max(urlauth_no), 0) + 1 as urlauth_no from urlauth), '/mileage/list_by_mileage.do', '4');
  

  
3. ��� 
- ���Ѻ� ���� URL ���
  SELECT urlauth_no, urlauth_address, auth_no
  FROM urlauth
  ORDER BY urlauth_no;     

 URLAUTH_NO URLAUTH_ADDRESS AUTH_NO
 ---------- --------------- -------
          1 main.jsp              1
          2 category.jsp          1
  
  
      
4. ��ȸ
- ���Ѻ� ���� URL ��ȣ�� '2'�� ���Ѻ� ���� URL ���Ѻ� ���� URL ���� ��ȸ
  SELECT urlauth_no, urlauth_address, auth_no
  FROM urlauth
  WHERE urlauth_no = '2';

 URLAUTH_NO URLAUTH_ADDRESS AUTH_NO
 ---------- --------------- -------
          2 category.jsp          1
  
  
  
5. ����
- ���Ѻ� ���� URL ��ȣ�� '2'�� ���Ѻ� ���� URL�� �ּҸ� 'login.jsp' �� ����
  UPDATE urlauth
  SET urlauth_address = 'login.jsp'
  WHERE urlauth_no = '2';
  
  SELECT urlauth_no, urlauth_address, auth_no
  FROM urlauth
  WHERE urlauth_no = '2';

 URLAUTH_NO URLAUTH_ADDRESS AUTH_NO
 ---------- --------------- -------
          2 login.jsp             1
  
  
  
6. ����
- ���Ѻ� ���� URL ��ȣ�� '2'�� ���Ѻ� ���� URL ����
  DELETE FROM urlauth
  WHERE urlauth_no = '2';
  
  SELECT urlauth_no, urlauth_address, auth_no
  FROM urlauth
  WHERE urlauth_no = '2';

 URLAUTH_NO URLAUTH_ADDRESS AUTH_NO
 ---------- --------------- -------

 
 