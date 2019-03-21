
2. QnA 게시판 테이블 구조

SELECT * FROM qna

DROP TABLE qna; 

CREATE TABLE qna ( 
  qna_no       NUMBER(10)           NOT NULL , 
  mem_no       NUMBER(10)    NOT NULL ,
  qna_title      VARCHAR(100)  NOT NULL , 
  qna_write     VARCHAR(20)   NOT NULL ,
  qna_passwd     VARCHAR(15)   NOT NULL , 
  qna_rdate      DATE      NOT NULL , 
  qna_grpno                 NUMBER(7)  NOT NULL,
  qna_cnt        NUMBER(10)           DEFAULT 0 NOT NULL , 
  qna_contents    VARCHAR(4000) NOT NULL , 
  qna_web        VARCHAR(100)      NULL ,
  qna_files      VARCHAR(1000)      NULL ,
  qna_sizes      VARCHAR(1000)        DEFAULT 0  NULL ,
  qna_thumbs        VARCHAR(1000)     NULL ,
  qna_visible    CHAR(1)       DEFAULT 'N' NOT NULL ,  
  qna_indent   NUMBER(5)        DEFAULT 0       NOT NULL,
  qna_ansnum   NUMBER(5)        DEFAULT 0       NOT NULL ,
 -- word        VARCHAR2(100) NULL,
  PRIMARY KEY (qna_no),
  FOREIGN KEY (mem_no) REFERENCES member(mem_no)
) 

COMMENT ON COLUMN qna.qna_no IS  '글 일련 번호';
COMMENT ON COLUMN qna.mem_no IS '회원 번호';  
COMMENT ON COLUMN qna.qna_title IS '제목';
COMMENT ON COLUMN qna.qna_write IS '글쓴이';
COMMENT ON COLUMN qna.qna_passwd IS '글 일련 번호'; 
COMMENT ON COLUMN qna.qna_rdate IS '등록 날짜'; 
COMMENT ON COLUMN qna.qna_grpno is '그룹번호';
COMMENT ON COLUMN qna.qna_cnt IS '조회수';
COMMENT ON COLUMN qna.qna_contents IS '글 내용'; 
COMMENT ON COLUMN qna.qna_web IS 'URL';
COMMENT ON COLUMN qna.qna_files IS '파일명';
COMMENT ON COLUMN qna.qna_sizes IS '파일 크기';
COMMENT ON COLUMN qna.qna_thumbs IS '썸네일';
COMMENT ON COLUMN qna.qna_visible IS '숨기기';
COMMENT ON COLUMN qna.qna_indent IS '답변 차수';
COMMENT ON COLUMN qna.qna_ansnum IS '답변 순서';

--COMMENT ON COLUMN qna.word IS '검색어';


2. 글 추가(C: Create) 
-- 새로운 글 등록
-- qna_grpno: 최대값 + 1
-- qna_indent: 0, 답변이 아니고 들여쓰기 필요 없음.
-- qna_ansnum: 0, 답변이 아니고 가장 먼저 출력
INSERT INTO qna(qna_no, mem_no, qna_title, qna_write, qna_passwd, qna_rdate, qna_grpno, qna_cnt,  
                 qna_contents, qna_web, qna_files, qna_sizes, qna_thumbs, qna_visible,
                 qna_indent, qna_ansnum)
VALUES((SELECT NVL(MAX(qna_no), 0)+1 AS qna_no FROM qna), 1, '질문 제목', '관리자1', 123, sysdate, (SELECT NVL(MAX(qna_grpno), 0) + 1 as qna_grpno FROM qna), '0',
        '내용', 'http://art.incheon.go.kr', '참고 파일1.jpg', '파일 크기',  '썸네일', 'N',
          1, 0);
            
            
3. 전체 글 목록(S:Total Select List), 최신글 먼저 출력 
   - ASC: 오름 차순, DESC: 내림 차순 
   - substring(컬럼명, 시작위치, 길이), 시작위치 1부터 시작: 문자열 일부만 선택
   - 함수 사용시 컬럼명이 매우 길어짐으로 
     'SUBSTR(qna_rdate, 1, 10)' 문장을 as 키워드로 'qna_rdate' 변환합니다. 
     
     
-- 멤버 번호 검색으로 질문 내역 확인
SELECT qna_no, mem_no, qna_title, qna_write, qna_passwd, SUBSTR(qna_rdate, 1, 10) as qna_rdate, qna_grpno, qna_cnt,  
        qna_contents, qna_web, qna_files, qna_sizes, qna_thumbs, qna_visible,
        qna_indent, qna_ansnum
FROM qna
WHERE mem_no = 1
ORDER BY qna_no DESC, qna_ansnum ASC;

 qna_no  mem_no  qna_wirte   qna_email      no_title        qna_cnt   qna_rdate                  qna_web                      qna_file1           qna_fstor1      qna_size1   qna_visible     qna_grpno    qna_indent   qna_ansnum
 ----- ------  ------- --------- -------------- --- ----------- ---------------------------------- ------------ ---------------- ------ ---------- ----------  ------- -------- 
     1       1     왕눈이   mail1   질문입니다!!   0   18/06/12 http://localhost.팝니다.판매1.jsp  참고파일1.jpg  참고파일01.jps   1000       Y           1       0         0
 

4. qna 조회

1) 조회수 증가 
UPDATE qna
SET qna_cnt = qna_cnt + 1
WHERE qna_no=34;

2) 1건의 글 보기(R:Read, PK 사용) 
SELECT qna_no, mem_no, qna_title, qna_write, qna_passwd, SUBSTR(qna_rdate, 1, 10) as qna_rdate, qna_grpno, qna_cnt,  
        qna_contents, qna_web, qna_files, qna_sizes, qna_thumbs, qna_visible,
        qna_indent, qna_ansnum
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
      qna_contents='내용 변경', qna_web='http://localhost.팝니다.팝니다02.jpg'
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
    - qna_wirte, no_title, qna_contents 컬럼 대상

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
WHERE qna_contents LIKE '%우주%'
ORDER BY qna_no DESC;

6) 제목, 내용으로 검색
SELECT mem_no, qna_wirte, qna_email, no_title, qna_cnt, 
        SUBSTR(qna_rdate, 1, 10) as qna_rdate, qna_web, qna_file1, qna_fstor1, qna_size1, qna_visible, 
        qna_grpno, qna_indent, qna_ansnum
FROM qna
WHERE no_title LIKE '%우주%' OR qna_contents LIKE '%우주%'
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
-- 답변 수업 내용
15) 답변
[답변 쓰기]
-- 1번글 기준 답변 등록예: grpno: 1, indent: 1, ansnum: 1
SELECT * FROM member;
SELECT * FROM categrp;
SELECT * FROM category;
 
① 새로운 답변을 최신으로 등록하기위해 기존 답변을 뒤로 미룹니다.
-- 모든 글의 우선 순위가 1씩 증가됨, 1등 -> 2등
UPDATE contents
SET ansnum = ansnum + 1
WHERE categoryno=1 AND grpno = 1 AND ansnum > 0;
 
-- 2등부터 우선 순위가 1씩 증가됨, 2등 -> 3등
UPDATE contents
SET ansnum = ansnum + 1
WHERE categoryno=1 AND grpno = 1 AND ansnum > 1;
 
-- 3등부터 우선 순위가 1씩 증가됨, 3등 -> 4등
UPDATE contents
SET ansnum = ansnum + 1
WHERE categoryno=1 AND grpno = 1 AND ansnum > 2;
 
-- 6등부터 우선 순위가 1씩 증가됨, 6등 -> 7등
UPDATE contents
SET ansnum = ansnum + 1
WHERE categoryno=1 AND grpno = 1 AND ansnum > 5;
 
 
② 답변 등록
- categoryno: FK, mno: FK
 
INSERT INTO contents(contentsno,
                          categoryno, mno, title, content, good, thumbs, files, sizes, cnt, replycnt, rdate, 
                          grpno, indent, ansnum, word)  
VALUES((SELECT NVL(MAX(contentsno), 0) + 1 as contentsno FROM contents),
            1, 1, '제목', '내용',0, 'summer_m.jpg', 'summer.jpg', 0, 0, 0, sysdate,
            1, 1, 1,'');
 
 
③ 답변에 따른 정렬 순서 변경    
SELECT contentsno, categoryno, title, content, good, thumbs, files, sizes, cnt,
          replycnt, rdate, word, grpno, indent, ansnum, r
FROM(
         SELECT contentsno, categoryno, title, content, good, thumbs, files, sizes, cnt,
                   replycnt, rdate, word, grpno, indent, ansnum, rownum as r
         FROM(
                  SELECT contentsno, categoryno, title, content, good, thumbs, files, sizes, cnt,
                            replycnt, rdate, word, grpno, indent, ansnum
                  FROM contents
                  WHERE categoryno=6 AND word LIKE '%swiss%'
                  ORDER BY grpno DESC, ansnum ASC
         )
)
WHERE r >=1 AND r <= 3;
 
 
 
========================================================
========================================================
SELECT * FROM qna

-- qna 게시물의 번호와 비밀번호 확인
SELECT COUNT(qna_passwd) as cnt
FROM qna
WHERE qna_passwd=123 AND qna_no=10 
