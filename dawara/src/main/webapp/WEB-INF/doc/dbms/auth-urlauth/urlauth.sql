drop table urlauth;
delete from urlauth;


/**********************************/
/* Table Name: 권한별 접근 URL */
/**********************************/
1. 테이블
- 권한별 접근 URL 테이블
- 부여된 권한별로 접근 가능한 URL 주소 정보 저장

CREATE TABLE urlauth(
    urlauth_no                         NUMBER(10)     NOT NULL    PRIMARY KEY,
    urlauth_address                        VARCHAR2(200)    NOT NULL,`
    auth_no                            NUMBER(10)     NOT NULL,
  FOREIGN KEY (auth_no) REFERENCES AUTH (auth_no)
);


COMMENT ON TABLE urlauth is '권한별 접근 URL';
COMMENT ON COLUMN urlauth.urlauth_no is '권한별 접근 URL 번호';
COMMENT ON COLUMN urlauth.urlauth_address is '권한별 접근 URL 주소';
COMMENT ON COLUMN urlauth.auth_no is '권한 번호';



2. 등록
delete from urlauth;

- 권한별 접근 URL 등록
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
  

  
3. 목록 
- 권한별 접근 URL 목록
  SELECT urlauth_no, urlauth_address, auth_no
  FROM urlauth
  ORDER BY urlauth_no;     

 URLAUTH_NO URLAUTH_ADDRESS AUTH_NO
 ---------- --------------- -------
          1 main.jsp              1
          2 category.jsp          1
  
  
      
4. 조회
- 권한별 접근 URL 번호가 '2'인 권한별 접근 URL 권한별 접근 URL 정보 조회
  SELECT urlauth_no, urlauth_address, auth_no
  FROM urlauth
  WHERE urlauth_no = '2';

 URLAUTH_NO URLAUTH_ADDRESS AUTH_NO
 ---------- --------------- -------
          2 category.jsp          1
  
  
  
5. 수정
- 권한별 접근 URL 번호가 '2'인 권한별 접근 URL의 주소를 'login.jsp' 로 변경
  UPDATE urlauth
  SET urlauth_address = 'login.jsp'
  WHERE urlauth_no = '2';
  
  SELECT urlauth_no, urlauth_address, auth_no
  FROM urlauth
  WHERE urlauth_no = '2';

 URLAUTH_NO URLAUTH_ADDRESS AUTH_NO
 ---------- --------------- -------
          2 login.jsp             1
  
  
  
6. 삭제
- 권한별 접근 URL 번호가 '2'인 권한별 접근 URL 삭제
  DELETE FROM urlauth
  WHERE urlauth_no = '2';
  
  SELECT urlauth_no, urlauth_address, auth_no
  FROM urlauth
  WHERE urlauth_no = '2';

 URLAUTH_NO URLAUTH_ADDRESS AUTH_NO
 ---------- --------------- -------

 
 