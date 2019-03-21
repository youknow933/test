/**********************************/ 
/* Table Name: 권한 */
/**********************************/

1. 테이블
- 권한 테이블
- 가입자별 권한 부여
CREATE TABLE AUTH(
    AUTH_NO                            NUMBER(10)    NOT NULL    PRIMARY KEY,
    AUTH_INFO                          VARCHAR2(100)    NOT NULL
);

COMMENT ON TABLE AUTH is '권한';
COMMENT ON COLUMN AUTH.AUTH_NO is '권한 번호';
COMMENT ON COLUMN AUTH.AUTH_INFO is '권한 정보';



2. 등록
- 권한 등록
  INSERT INTO auth(AUTH_NO, AUTH_INFO)   
  VALUES((select nvl(max(auth_no), 0) + 1 as auth_no from auth), '관리자');
  
  INSERT INTO auth(AUTH_NO, AUTH_INFO)   
  VALUES((select nvl(max(auth_no), 0) + 1 as auth_no from auth), '보조 관리자');
  
  INSERT INTO auth(AUTH_NO, AUTH_INFO)    
  VALUES((select nvl(max(auth_no), 0) + 1 as auth_no from auth), '일반 회원');
  
  INSERT INTO auth(AUTH_NO, AUTH_INFO)    
  VALUES((select nvl(max(auth_no), 0) + 1 as auth_no from auth), '우수 회원');
  
  INSERT INTO auth(AUTH_NO, AUTH_INFO)    
  VALUES((select nvl(max(auth_no), 0) + 1 as auth_no from auth), '블랙 리스트');
  
  INSERT INTO auth(AUTH_NO, AUTH_INFO)    
  VALUES((select nvl(max(auth_no), 0) + 1 as auth_no from auth), '탈퇴 회원');
  

3. 목록 
- 권한 목록
  SELECT AUTH_NO, AUTH_INFO
  FROM auth
  ORDER BY AUTH_NO;     

 AUTH_NO AUTH_INFO
 ------- ---------
       1 관리자
       2 보조 관리자
       3 일반 회원
       4 우수 회원
       5 블랙 리스트
       6 탈퇴 회원
       
       
      
4. 조회
- 권한 번호가 '3'인 권한의 권한 정보 조회
  SELECT AUTH_NO, AUTH_INFO
  FROM auth
  WHERE AUTH_NO = '3';

 AUTH_NO AUTH_INFO
 ------- ---------
       3 일반 회원
      
       
  
5. 수정
- 권한 번호가 '5'인 권한의 권한 정보를 '관심 회원' 으로 변경
  UPDATE auth
  SET auth_info = '관심 회원'
  WHERE auth_no = '5';
  
  SELECT auth_no, auth_info
  FROM auth
  WHERE auth_no = '5';
  
 AUTH_NO AUTH_INFO
 ------- ---------
       5 관심 회원
  
       
  
6. 삭제
- 권한 번호가 '5'인 권한을 삭제
  DELETE FROM auth
  WHERE auth_no = '5';
  
  SELECT auth_no, auth_info
  FROM auth
  WHERE auth_no = '5';

 AUTH_NO AUTH_INFO
 ------- ---------
 
  
   
/**********************************/
/* Table Name: 권한별 접근 URL */
/**********************************/
1. 테이블
- 권한별 접근 URL 테이블
- 부여된 권한별로 접근 가능한 URL 주소 정보 저장
CREATE TABLE urlauth(
    urlauth_no                         NUMBER(10)     NOT NULL    PRIMARY KEY,
    urlauth_address                        VARCHAR2(200)    NOT NULL,
    auth_no                            NUMBER(10)     NOT NULL,
  FOREIGN KEY (auth_no) REFERENCES AUTH (auth_no)
);

COMMENT ON TABLE urlauth is '권한별 접근 URL';
COMMENT ON COLUMN urlauth.urlauth_no is '권한별 접근 URL 번호';
COMMENT ON COLUMN urlauth.urlauth_address is '권한별 접근 URL 주소';
COMMENT ON COLUMN urlauth.auth_no is '권한 번호';



2. 등록
- 권한별 접근 URL 등록
  INSERT INTO urlauth(urlauth_no, urlauth_address, auth_no)   
  VALUES((select nvl(max(urlauth_no), 0) + 1 as urlauth_no from urlauth), '메인페이지', '1');
  
  INSERT INTO urlauth(urlauth_no, urlauth_address, auth_no)   
  VALUES((select nvl(max(urlauth_no), 0) + 1 as urlauth_no from urlauth), '카테고리', '1');
  

  
3. 목록 
- 권한별 접근 URL 목록
  SELECT urlauth_no, urlauth_address, auth_no
  FROM urlauth
  ORDER BY urlauth_no;     

 URLAUTH_NO URLAUTH_ADDRESS AUTH_NO
 ---------- --------------- -------
          1 메인페이지                 1
          2 카테고리                  1
  
  
      
4. 조회
- 권한별 접근 URL 번호가 '2'인 권한별 접근 URL 권한별 접근 URL 정보 조회
  SELECT urlauth_no, urlauth_address, auth_no
  FROM urlauth
  WHERE urlauth_no = '2';

 URLAUTH_NO URLAUTH_ADDRESS AUTH_NO
 ---------- --------------- -------
          2 카테고리                  1
  
  
  
5. 수정
- 권한별 접근 URL 번호가 '2'인 권한별 접근 URL의 주소를 '공지사항' 으로 변경
  UPDATE urlauth
  SET urlauth_address = '공지사항'
  WHERE urlauth_no = '2';
  
  SELECT urlauth_no, urlauth_address, auth_no
  FROM urlauth
  WHERE urlauth_no = '2';

 URLAUTH_NO URLAUTH_ADDRESS AUTH_NO
 ---------- --------------- -------
          2 공지사항                  1
  
  
  
6. 삭제
- 권한별 접근 URL 번호가 '2'인 권한별 접근 URL 삭제
  DELETE FROM urlauth
  WHERE urlauth_no = '2';
  
  SELECT urlauth_no, urlauth_address, auth_no
  FROM urlauth
  WHERE urlauth_no = '2';

 URLAUTH_NO URLAUTH_ADDRESS AUTH_NO
 ---------- --------------- -------

 
 
 
 
/**********************************/
/* Table Name: 접속 주소 */
/**********************************/
1. 테이블
- 접속 주소
CREATE TABLE url(
    url_no                         NUMBER(10)        NOT NULL    PRIMARY KEY,
    url_address                  VARCHAR2(200)    NOT NULL,
    urlauth_no                   NUMBER(10)         NOT NULL,
  FOREIGN KEY (urlauth_no) REFERENCES URLAUTH (urlauth_no)
);

COMMENT ON TABLE urlauth is '접속 주소';
COMMENT ON COLUMN url.url_no is '접속 주소 번호';
COMMENT ON COLUMN url.url_address is '접속 주소 정보';
COMMENT ON COLUMN url.auth_no is '권한 번호';



2. 등록
- 권한별 접근 URL 등록
  INSERT INTO url(url_no, url_address, auth_no)   
  VALUES((select nvl(max(url_no), 0) + 1 as url_no from url), 'index.jsp', '1');
  
  

  
3. 목록 
- 권한별 접근 URL 목록
  SELECT urlauth_no, urlauth_address, auth_no
  FROM urlauth
  ORDER BY urlauth_no;     

 URLAUTH_NO URLAUTH_ADDRESS AUTH_NO
 ---------- --------------- -------
          1 메인페이지                 1
          2 카테고리                  1
  
  
      
4. 조회
- 권한별 접근 URL 번호가 '2'인 권한별 접근 URL 권한별 접근 URL 정보 조회
  SELECT urlauth_no, urlauth_address, auth_no
  FROM urlauth
  WHERE urlauth_no = '2';

 URLAUTH_NO URLAUTH_ADDRESS AUTH_NO
 ---------- --------------- -------
          2 카테고리                  1
  
  
  
5. 수정
- 권한별 접근 URL 번호가 '2'인 권한별 접근 URL의 주소를 '공지사항' 으로 변경
  UPDATE urlauth
  SET urlauth_address = '공지사항'
  WHERE urlauth_no = '2';
  
  SELECT urlauth_no, urlauth_address, auth_no
  FROM urlauth
  WHERE urlauth_no = '2';

 URLAUTH_NO URLAUTH_ADDRESS AUTH_NO
 ---------- --------------- -------
          2 공지사항                  1
  
  
  
6. 삭제
- 권한별 접근 URL 번호가 '2'인 권한별 접근 URL 삭제
  DELETE FROM url
  WHERE url_no = '2';
  
  SELECT url_no, url_address, auth_no
  FROM url
  WHERE url_no = '2';

 URLAUTH_NO URLAUTH_ADDRESS AUTH_NO
 ---------- --------------- -------

 
 
 
