
2. QnA 게시판 테이블 구조

DROP TABLE qna; 

CREATE TABLE qna ( 
  qna_no      NUMBER(10)           NOT NULL , 
  mem_no       NUMBER(10)    NOT NULL ,
  qna_wirte     VARCHAR(20)   NOT NULL ,
  qna_email      VARCHAR(100)      NULL ,  
  no_title      VARCHAR(200)  NOT NULL , 
  qna_content    VARCHAR(4000) NOT NULL , 
  qna_passwd     VARCHAR(15)   NOT NULL , 
  qna_cnt        NUMBER(10)           DEFAULT 0 NOT NULL , 
  qna_rdate      DATE      NOT NULL , 
  qna_web        VARCHAR(100)      NULL ,
  qna_file1      VARCHAR(100)      NULL ,
  qna_fstor1     VARCHAR(100)      NULL ,
  qna_size1      NUMBER(10)        DEFAULT 0 NOT NULL ,
  qna_visible    CHAR(1)       DEFAULT 'Y' NOT NULL ,  
  qna_grpno    NUMBER(10)        NOT NULL ,
  qna_indent   NUMBER(5)        DEFAULT 0       NOT NULL,
  qna_ansnum   NUMBER(5)        DEFAULT 0       NOT NULL ,
  PRIMARY KEY (qna_no),
  FOREIGN KEY (mem_no) REFERENCES member(mem_no)
) 

drop table qna;

COMMENT ON COLUMN qna.qna_no IS  '글 일련 번호';
COMMENT ON COLUMN qna.mem_no IS '회원 번호';  -- 레코드를 구분하는 컬럼
COMMENT ON COLUMN qna.qna_wirte IS '글쓴이';
COMMENT ON COLUMN qna.qna_email IS '이메일';  
COMMENT ON COLUMN qna.no_title IS '제목';
COMMENT ON COLUMN qna.qna_content IS '글 내용'; 
COMMENT ON COLUMN qna.qna_passwd IS '글 일련 번호'; 
COMMENT ON COLUMN qna.qna_cnt IS '조회수';
COMMENT ON COLUMN qna.qna_rdate IS '등록 날짜'; 
COMMENT ON COLUMN qna.qna_web IS 'URL';
COMMENT ON COLUMN qna.qna_file1 IS '파일명';
COMMENT ON COLUMN qna.qna_fstor1 IS '실제 저장 파일명';
COMMENT ON COLUMN qna.qna_size1 IS '파일 크기 1';
COMMENT ON COLUMN qna.qna_visible IS '숨기기';
COMMENT ON COLUMN qna.qna_grpno IS '그룹 번호';
COMMENT ON COLUMN qna.qna_indent IS '답변 차수';
COMMENT ON COLUMN qna.qna_ansnum IS '답변 순서';




2. 글 추가(C: Create) 
-- 새로운 글 등록
-- qna_grpno: 최대값 + 1
-- qna_indent: 0, 답변이 아니고 들여쓰기 필요 없음.
-- qna_ansnum: 0, 답변이 아니고 가장 먼저 출력
INSERT INTO qna(qna_no, mem_no, qna_wirte, qna_email, no_title, qna_content, qna_passwd,
                  qna_cnt, qna_rdate, qna_web, qna_file1, qna_fstor1, qna_size1, qna_visible,
                  qna_grpno, qna_indent, qna_ansnum)
                  --(SELECT NVL((qna_grpno), 0) + 1 FROM qna as qna_grpno), qna_indent, qna_ansnum)
                  -- 그룹 번호가 없을 경우 추가하기 위해선..?
VALUES(2, 1, '왕눈이', 'mail1', '하얀 동그라미 재판', '코카서스의 백묵원', '123',
           0, sysdate, 'http://art.incheon.go.kr', '참고 파일1.jpg', '참고 파일01.jpg',  1000, 'Y',
           1, 0, 0);
            
            
3. 전체 글 목록(S:Total Select List), 최신글 먼저 출력 
   - ASC: 오름 차순, DESC: 내림 차순 
   - substring(컬럼명, 시작위치, 길이), 시작위치 1부터 시작: 문자열 일부만 선택
   - 함수 사용시 컬럼명이 매우 길어짐으로 
     'SUBSTR(qna_rdate, 1, 10)' 문장을 as 키워드로 'qna_rdate' 변환합니다. 

-- 멤버 번호 검색으로 질문 내역 확인
SELECT qna_no, mem_no, qna_wirte, qna_email, no_title, qna_cnt, 
          SUBSTR(qna_rdate, 1, 10) as qna_rdate, qna_web, qna_file1, qna_fstor1, qna_size1, qna_visible, 
          qna_grpno, qna_indent, qna_ansnum
FROM qna
WHERE mem_no = 1
ORDER BY qna_grpno DESC, qna_ansnum ASC;

 qna_no  mem_no  qna_wirte   qna_email      no_title        qna_cnt   qna_rdate                  qna_web                      qna_file1           qna_fstor1      qna_size1   qna_visible     qna_grpno    qna_indent   qna_ansnum
 ----- ------  ------- --------- -------------- --- ----------- ---------------------------------- ------------ ---------------- ------ ---------- ----------  ------- -------- 
     1       1     왕눈이   mail1   질문입니다!!   0   18/06/12 http://localhost.팝니다.판매1.jsp  참고파일1.jpg  참고파일01.jps   1000       Y           1       0         0
 

4. qna 조회

1) 조회수 증가 
UPDATE qna
SET qna_cnt = qna_cnt + 1
WHERE qna_no=34;

2) 1건의 글 보기(R:Read, PK 사용) 
SELECT mem_no, qna_wirte, qna_email, no_title, qna_cnt, 
        SUBSTR(qna_rdate, 1, 10) as qna_rdate, qna_web, qna_file1, qna_fstor1, qna_size1, qna_visible, 
        qna_grpno, qna_indent, qna_ansnum
FROM qna
WHERE qna_no=30;

 qna_no  mem_no  qna_wirte   qna_email      no_title        qna_cnt   qna_rdate                  qna_web                      qna_file1           qna_fstor1      qna_size1   qna_visible     qna_grpno    qna_indent   qna_ansnum
 ----- ------  ------- --------- -------------- --- ----------- ---------------------------------- ------------ ---------------- ------ ---------- ----------  ------- -------- 
    30       1     왕눈이   mail1   질문입니다!!   0   2018-04-17 http://localhost.팝니다.판매1.jsp  참고파일1.jpg  참고파일01.jps   1000       Y           1       0         0
 


5. 패스워드 검사
   - no_qna_cnt(): 발생한 레코드의 수를 계산, 레코드가 없으면 0 출력
   
SELECT no_qna_cnt(*) as qna_cnt 
FROM qna
WHERE qna_no=1 AND qna_passwd='123';

 qna_cnt
 ---
   0

   
6. 글 수정(U:Update), PK는 레코드를 구분하는 고유 기능을 가지고 있음으로 
   수정하는 것은 권장하지 않음. 
    
1) 글만 수정 
UPDATE qna
SET qna_wirte='투투', qna_email='mail1@mail.com', no_title='제목변경',
      qna_content='내용 변경', qna_web='http://localhost.팝니다.팝니다02.jpg'
WHERE qna_no=1;
  
2) qna_visible 수정
UPDATE qna
SET qna_visible = 'Y'
WHERE qna_no=1;

3) 파일 삭제
UPDATE qna
SET qna_file1='', qna_size1=0
WHERE qna_no=1;

4) 새로운 파일 등록
UPDATE qna
SET qna_file1='test.jpg', qna_fstor1='test.jpg', qna_size1=123
WHERE qna_no=1;
 
5) 파일 교체
UPDATE qna
SET qna_file1='new.jpg', qna_fstor1='new.jpg', qna_size1=123
WHERE qna_no=1;


7. 글 삭제(D:Delete) 
DELETE FROM qna
WHERE qna_no = 49;

DELETE FROM qna
WHERE qna_no <= 4;

DELETE FROM qna
WHERE qna_no >= 11;


8. 검색 글 목록(S:Search List) 
    - 목록은 제작시 검색을 기반으로 제작하며 전체 내용은
      전체 검색과도 같습니다.
    - qna_wirte, no_title, qna_content 컬럼 대상

1) 선언: 
    - WHERE qna_wirte LIKE '왕눈이'
       qna_wirte 컬럼의 값이 '왕눈이'인 레코드 전부 출력

    - WHERE qna_wirte LIKE '%왕눈이%'
      qna_wirte 컬럼의 값중 '왕눈이'가 들어간 레코드 전부 출력

    - WHERE qna_wirte LIKE '왕눈이%'
      qna_wirte 컬럼의 값중 '왕눈이'로 시작하는 레코드 전부 출력

    - WHERE qna_wirte LIKE '%왕눈이'
      qna_wirte 컬럼의 값중 '왕눈이'로 종료하는 레코드 전부 출력
   

2) 검색을 하지 않는 경우 모든 레코드 출력 
SELECT qna_wirte, qna_email, no_title, qna_cnt, 
        SUBSTR(qna_rdate, 1, 10) as qna_rdate, qna_web, qna_file1, qna_fstor1, qna_size1, qna_visible, 
        qna_grpno, qna_indent, qna_ansnum
FROM qna
ORDER BY qna_no DESC;

3) 이름 검색
SELECT mem_no, qna_wirte, qna_email, no_title, qna_cnt, 
        SUBSTR(qna_rdate, 1, 10) as qna_rdate, qna_web, qna_file1, qna_fstor1, qna_size1, qna_visible, 
        qna_grpno, qna_indent, qna_ansnum
FROM qna
WHERE qna_wirte LIKE '%아로미%'
ORDER BY qna_no DESC;
     
4) 제목으로 검색   
SELECT mem_no, qna_wirte, qna_email, no_title, qna_cnt, 
        SUBSTR(qna_rdate, 1, 10) as qna_rdate, qna_web, qna_file1, qna_fstor1, qna_size1, qna_visible, 
        qna_grpno, qna_indent, qna_ansnum
FROM qna
WHERE no_title LIKE '%패신저스%'
ORDER BY qna_no DESC;
    
5) 내용으로 검색
SELECT mem_no, qna_wirte, qna_email, no_title, qna_cnt, 
        SUBSTR(qna_rdate, 1, 10) as qna_rdate, qna_web, qna_file1, qna_fstor1, qna_size1, qna_visible, 
        qna_grpno, qna_indent, qna_ansnum
FROM qna
WHERE qna_content LIKE '%우주%'
ORDER BY qna_no DESC;

6) 제목, 내용으로 검색
SELECT mem_no, qna_wirte, qna_email, no_title, qna_cnt, 
        SUBSTR(qna_rdate, 1, 10) as qna_rdate, qna_web, qna_file1, qna_fstor1, qna_size1, qna_visible, 
        qna_grpno, qna_indent, qna_ansnum
FROM qna
WHERE no_title LIKE '%우주%' OR qna_content LIKE '%우주%'
ORDER BY qna_no DESC;


9 페이징
   - 목록은 페이징 구현을 필수로 합니다.
   
1) 검색된 전체 레코드 수
SELECT no_qna_cnt(qna_no) as qna_cnt 
FROM qna
WHERE qna_wirte LIKE '%왕눈이%';

 qna_cnt
 ---
   1
   
2) 페이징
SELECT mem_no, qna_wirte, qna_email, no_title, qna_cnt, 
        SUBSTR(qna_rdate, 1, 10) as qna_rdate, qna_web, qna_file1, qna_fstor1, qna_size1, qna_visible, 
        qna_grpno, qna_indent, qna_ansnum
FROM qna
WHERE qna_no= 1 AND qna_wirte LIKE '%왕눈이%'
ORDER BY qna_grpno DESC, qna_ansnum ASC
LIMIT 0, 5;

     
* 컬럼의 추가
ALTER TABLE qna 
ADD COLUMN 추가할 컬럼명 VARCHAR(100) AFTER qna_visible;
 

10. 답변

1) 기존에 등록된 답변의 seqno 증가 처리
UPDATE qna
SET qna_ansnum = qna_ansnum + 1
WHERE qna_no= 1 AND qna_grpno = 1 AND qna_ansnum > 부모의 qna_ansnum 컬럼의 값;

UPDATE qna
SET qna_ansnum = qna_ansnum + 1
WHERE qna_no= 1 AND qna_grpno = 1 AND qna_ansnum > 0;

2) 답변 등록
-- qna_grpno: 최대값 + 1
-- qna_indent: 0, 답변이 아니고 들여쓰기 필요 없음.
-- qna_ansnum: 0, 답변이 아니고 가장 먼저 출력
INSERT INTO qna(mem_no, qna_wirte, qna_email, no_title, qna_cnt, 
                SUBSTR(qna_rdate, 1, 10) as qna_rdate, qna_web, qna_file1, qna_fstor1, qna_size1, qna_visible, 
                qna_grpno, qna_indent, qna_ansnum)
VALUES(9999, '관리자', 'mail1', '답변입니다.', 0,
        sysdate, 'http://질문 링크', '참고 파일1.jpg', '참고 파일01.jpg'  1000, 'Y',
           1, 1, 1);

-----------------------------------------------------------------------------------

 
 
 
 
========================================================
========================================================
