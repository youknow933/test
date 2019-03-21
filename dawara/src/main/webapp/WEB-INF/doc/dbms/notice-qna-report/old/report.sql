
3. 사기 신고 게시판

DROP TABLE report; 

CREATE TABLE report ( 
  rpt_no      NUMBER(10)           NOT NULL,
  mem_no      NUMBER(10)    NOT NULL ,
  rpt_write      VARCHAR(20)   NOT NULL ,
  rpt_email      VARCHAR(100)      NULL ,  
  rpt_title        VARCHAR(200)  NOT NULL , 
  rpt_content    VARCHAR(4000) NOT NULL , 
  rpt_passwd     VARCHAR(15)   NOT NULL , 
  rpt_cnt        NUMBER(10)           DEFAULT 0 NOT NULL , 
  rpt_rdate      DATE      NOT NULL , 
  rpt_web        VARCHAR(100)      NULL ,
  rpt_file1      VARCHAR(100)      NULL ,
  rpt_fstor1     VARCHAR(100)      NULL ,
  rpt_size1      NUMBER(10)        DEFAULT 0 NOT NULL ,
  rpt_visible    CHAR(1)       DEFAULT 'Y' NOT NULL ,  
  rpt_grpno    NUMBER(10)        NOT NULL ,
  rpt_indent   NUMBER(5)        DEFAULT 0       NOT NULL,
  rpt_ansnum   NUMBER(5)        DEFAULT 0       NOT NULL ,
  PRIMARY KEY (rpt_no),
  FOREIGN KEY (mem_no) REFERENCES member(mem_no)
)

drop table report;

COMMENT ON COLUMN report.rpt_no IS  '글 일련 번호';
COMMENT ON COLUMN report.mem_no IS '회원 번호';  -- 레코드를 구분하는 컬럼
COMMENT ON COLUMN report.rpt_write IS '글쓴이';
COMMENT ON COLUMN report.rpt_email IS '이메일';  
COMMENT ON COLUMN report.rpt_title IS '제목';
COMMENT ON COLUMN report.rpt_content IS '글 내용'; 
COMMENT ON COLUMN report.rpt_passwd IS '글 일련 번호'; 
COMMENT ON COLUMN report.rpt_cnt IS '조회수';
COMMENT ON COLUMN report.rpt_rdate IS '등록 날짜'; 
COMMENT ON COLUMN report.rpt_web IS 'URL';
COMMENT ON COLUMN report.rpt_file1 IS '파일명';
COMMENT ON COLUMN report.rpt_fstor1 IS '실제 저장 파일명';
COMMENT ON COLUMN report.rpt_size1 IS '파일 크기 1';
COMMENT ON COLUMN report.rpt_visible IS '숨기기';
COMMENT ON COLUMN report.rpt_grpno IS '그룹 번호';
COMMENT ON COLUMN report.rpt_indent IS '답변 차수';
COMMENT ON COLUMN report.rpt_ansnum IS '답변 순서';

2. 글 추가(C: Create) 
-- 새로운 글 등록
-- rpt_grpno: 최대값 + 1
-- rpt_indent: 0, 답변이 아니고 들여쓰기 필요 없음.
-- rpt_ansnum: 0, 답변이 아니고 가장 먼저 출력
INSERT INTO report(rpt_no, mem_no, rpt_write, rpt_email, rpt_title, rpt_content, rpt_passwd,
                  rpt_cnt, rpt_rdate, rpt_web, rpt_file1, rpt_fstor1, rpt_size1, rpt_visible,
                  rpt_grpno, rpt_indent, rpt_ansnum)
VALUES(1, 1, '왕눈이', 'mail1', '하얀 동그라미 재판', '코카서스의 백묵원', '123',
           0, sysdate, 'http://art.incheon.go.kr', '참고 파일1.jpg', '참고 파일01.jpg',  1000, 'Y',
           1, 0, 0);
           -- 2.와 마찬가지로 rpt_grpno를 IFNULL을 이용해서 증가시켰던 방법을 생각해봐야 함.
           
            
            
3. 전체 글 목록(S:Total Select List), 최신글 먼저 출력 
   - ASC: 오름 차순, DESC: 내림 차순 
   - substr(컬럼명, 시작위치, 길이), 시작위치 1부터 시작: 문자열 일부만 선택
   - 함수 사용시 컬럼명이 매우 길어짐으로 
     'SUBSTR(rpt_rdate, 1, 10)' 문장을 as 키워드로 'rpt_rdate' 변환합니다. 

-- 신고 게시 번호로 목록 검색
SELECT rpt_no, mem_no, rpt_write, rpt_email, rpt_title, rpt_cnt, 
          SUBSTR(rpt_rdate, 1, 10) as rpt_rdate, rpt_web, rpt_file1, rpt_fstor1, rpt_size1, rpt_visible, 
          rpt_grpno, rpt_indent, rpt_ansnum
FROM report
WHERE rpt_no = 1
ORDER BY rpt_grpno DESC, rpt_ansnum ASC;

 rpt_no  mem_no  rpt_write   rpt_email      rpt_title        rpt_cnt   rpt_rdate                  rpt_web                      rpt_file1           rpt_fstor1      rpt_size1   rpt_visible     rpt_grpno    rpt_indent   rpt_ansnum
 ----- ------  ------- --------- -------------- --- ----------- ---------------------------------- ------------ ---------------- ------ ---------- ----------  ------- -------- 
     1       1     왕눈이   mail1   신고합니다!!   0   2018-04-17 http://localhost.팝니다.판매1.jsp  참고파일1.jpg  참고파일01.jps   1000       Y           1       0         0
 

4. report 조회

1) 조회수 증가 
UPDATE report
SET rpt_cnt = rpt_cnt + 1
WHERE rpt_no=34;

2) 1건의 글 보기(R:Read, PK 사용) 
SELECT mem_no, rpt_write, rpt_email, rpt_title, rpt_cnt, 
        SUBSTR(rpt_rdate, 1, 10) as rpt_rdate, rpt_web, rpt_file1, rpt_fstor1, rpt_size1, rpt_visible, 
        rpt_grpno, rpt_indent, rpt_ansnum
FROM report
WHERE rpt_no=30;

 rpt_no  mem_no  rpt_write   rpt_email      rpt_title        rpt_cnt   rpt_rdate                  rpt_web                      rpt_file1           rpt_fstor1      rpt_size1   rpt_visible     rpt_grpno    rpt_indent   rpt_ansnum
 ----- ------  ------- --------- -------------- --- ----------- ---------------------------------- ------------ ---------------- ------ ---------- ----------  ------- -------- 
    30       1     왕눈이   mail1   신고합니다!!   0   2018-04-17 http://localhost.팝니다.판매1.jsp  참고파일1.jpg  참고파일01.jps   1000       Y           1       0         0
 


5. 패스워드 검사
   - no_rpt_cnt(): 발생한 레코드의 수를 계산, 레코드가 없으면 0 출력
   
SELECT no_rpt_cnt(*) as rpt_cnt 
FROM report
WHERE rpt_no=1 AND rpt_passwd='123';

 rpt_cnt
 ---
   0

   
6. 글 수정(U:Update), PK는 레코드를 구분하는 고유 기능을 가지고 있음으로 
   수정하는 것은 권장하지 않음. 
    
1) 글만 수정 
UPDATE report
SET rpt_write='투투', rpt_email='mail1@mail.com', rpt_title='제목변경',
      rpt_content='내용 변경', rpt_web='http://localhost.팝니다.팝니다02.jpg'
WHERE rpt_no=1;
  
2) rpt_visible 수정
UPDATE report
SET rpt_visible = 'Y'
WHERE rpt_no=1;

3) 파일 삭제
UPDATE report
SET rpt_file1='', rpt_size1=0
WHERE rpt_no=1;

4) 새로운 파일 등록
UPDATE report
SET rpt_file1='test.jpg', rpt_fstor1='test.jpg', rpt_size1=123
WHERE rpt_no=1;
 
5) 파일 교체
UPDATE report
SET rpt_file1='new.jpg', rpt_fstor1='new.jpg', rpt_size1=123
WHERE rpt_no=1;


7. 글 삭제(D:Delete) 
DELETE FROM report
WHERE rpt_no = 49;

DELETE FROM report
WHERE rpt_no <= 4;

DELETE FROM report
WHERE rpt_no >= 11;


8. 검색 글 목록(S:Search List) 
    - 목록은 제작시 검색을 기반으로 제작하며 전체 내용은
      전체 검색과도 같습니다.
    - rpt_write, rpt_title, rpt_content 컬럼 대상

1) 선언: 
    - WHERE rpt_write LIKE '왕눈이'
       rpt_write 컬럼의 값이 '왕눈이'인 레코드 전부 출력

    - WHERE rpt_write LIKE '%왕눈이%'
      rpt_write 컬럼의 값중 '왕눈이'가 들어간 레코드 전부 출력

    - WHERE rpt_write LIKE '왕눈이%'
      rpt_write 컬럼의 값중 '왕눈이'로 시작하는 레코드 전부 출력

    - WHERE rpt_write LIKE '%왕눈이'
      rpt_write 컬럼의 값중 '왕눈이'로 종료하는 레코드 전부 출력
   

2) 검색을 하지 않는 경우 모든 레코드 출력 
SELECT rpt_write, rpt_email, rpt_title, rpt_cnt, 
        SUBSTRING(rpt_rdate, 1, 10) as rpt_rdate, rpt_web, rpt_file1, rpt_fstor1, rpt_size1, rpt_visible, 
        rpt_grpno, rpt_indent, rpt_ansnum
FROM report
ORDER BY rpt_no DESC;

3) 이름 검색
SELECT mem_no, rpt_write, rpt_email, rpt_title, rpt_cnt, 
        SUBSTRING(rpt_rdate, 1, 10) as rpt_rdate, rpt_web, rpt_file1, rpt_fstor1, rpt_size1, rpt_visible, 
        rpt_grpno, rpt_indent, rpt_ansnum
FROM report
WHERE rpt_write LIKE '%아로미%'
ORDER BY rpt_no DESC;
     
4) 제목으로 검색   
SELECT mem_no, rpt_write, rpt_email, rpt_title, rpt_cnt, 
        SUBSTRING(rpt_rdate, 1, 10) as rpt_rdate, rpt_web, rpt_file1, rpt_fstor1, rpt_size1, rpt_visible, 
        rpt_grpno, rpt_indent, rpt_ansnum
FROM report
WHERE rpt_title LIKE '%패신저스%'
ORDER BY rpt_no DESC;
    
5) 내용으로 검색
SELECT mem_no, rpt_write, rpt_email, rpt_title, rpt_cnt, 
        SUBSTRING(rpt_rdate, 1, 10) as rpt_rdate, rpt_web, rpt_file1, rpt_fstor1, rpt_size1, rpt_visible, 
        rpt_grpno, rpt_indent, rpt_ansnum
FROM report
WHERE rpt_content LIKE '%우주%'
ORDER BY rpt_no DESC;

6) 제목, 내용으로 검색
SELECT mem_no, rpt_write, rpt_email, rpt_title, rpt_cnt, 
        SUBSTRING(rpt_rdate, 1, 10) as rpt_rdate, rpt_web, rpt_file1, rpt_fstor1, rpt_size1, rpt_visible, 
        rpt_grpno, rpt_indent, rpt_ansnum
FROM report
WHERE rpt_title LIKE '%우주%' OR rpt_content LIKE '%우주%'
ORDER BY rpt_no DESC;


9 페이징
   - 목록은 페이징 구현을 필수로 합니다.
   
1) 검색된 전체 레코드 수
SELECT no_rpt_cnt(rpt_no) as rpt_cnt 
FROM report
WHERE rpt_write LIKE '%왕눈이%';

 rpt_cnt
 ---
   1
   
2) 페이징
SELECT mem_no, rpt_write, rpt_email, rpt_title, rpt_cnt, 
        SUBSTRING(rpt_rdate, 1, 10) as rpt_rdate, rpt_web, rpt_file1, rpt_fstor1, rpt_size1, rpt_visible, 
        rpt_grpno, rpt_indent, rpt_ansnum
FROM report
WHERE rpt_no= 1 AND rpt_write LIKE '%왕눈이%'
ORDER BY rpt_grpno DESC, rpt_ansnum ASC
LIMIT 0, 5;

     
* 컬럼의 추가
ALTER TABLE report 
ADD COLUMN 추가할 컬럼명 VARCHAR(100) AFTER rpt_visible;
 

10. 답변

1) 기존에 등록된 답변의 seqno 증가 처리
UPDATE report
SET rpt_ansnum = rpt_ansnum + 1
WHERE rpt_no= 1 AND rpt_grpno = 1 AND rpt_ansnum > 부모의 rpt_ansnum 컬럼의 값;

UPDATE report
SET rpt_ansnum = rpt_ansnum + 1
WHERE rpt_no= 1 AND rpt_grpno = 1 AND rpt_ansnum > 0;

2) 답변 등록
-- rpt_grpno: 최대값 + 1
-- rpt_indent: 0, 답변이 아니고 들여쓰기 필요 없음.
-- rpt_ansnum: 0, 답변이 아니고 가장 먼저 출력
INSERT INTO report(mem_no, rpt_write, rpt_email, rpt_title, rpt_cnt, 
                SUBSTRING(rpt_rdate, 1, 10) as rpt_rdate, rpt_web, rpt_file1, rpt_fstor1, rpt_size1, rpt_visible, 
                rpt_grpno, rpt_indent, rpt_ansnum)
VALUES(9999, '관리자', 'mail1', '답변입니다.', 0,
        sysdate, 'http://질문 링크', '참고 파일1.jpg', '참고 파일01.jpg'  1000, 'Y',
           1, 1, 1);
