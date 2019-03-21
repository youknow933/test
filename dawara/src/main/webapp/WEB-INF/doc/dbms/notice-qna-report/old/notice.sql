1. 공지사항 notice 테이블 구조 
-----------------------------------------------------------------------------------
1. notice 테이블 생성

CREATE TABLE notice(
  no_no     NUMBER(10)                                NOT NULL,
  mem_no     NUMBER(10)                                NOT NULL,
  no_title        VARCHAR(100)                                NOT NULL,
  no_write      VARCHAR(15)                                 NOT NULL,
  no_rdate       DATE                                           NOT NULL,
  no_qna_cnt        NUMBER(10)        DEFAULT 0           NOT NULL,
  no_qna_contents    VARCHAR(4000)                             NOT NULL,
  no_visible     CHAR(1)               DEFAULT 'Y'          NOT NULL,
  PRIMARY KEY(no_no),
  FOREIGN KEY(mem_no) REFERENCES member(mem_no)
);
COMMENT ON COLUMN notice.no_no IS '번호';
COMMENT ON COLUMN notice.mem_no IS '관리자 번호';
COMMENT ON COLUMN notice.no_title IS '제목';
COMMENT ON COLUMN notice.no_write IS '글쓴이';
COMMENT ON COLUMN notice.no_rdate IS '등록일';
COMMENT ON COLUMN notice.no_qna_cnt IS '조회수';
COMMENT ON COLUMN notice.no_qna_contents IS '내용';
COMMENT ON COLUMN notice.no_visible IS '공개 여부';


2. 테이블 삭제
DROP TABLE notice;

3. 등록
- PK 컬럼은 생략함.
INSERT INTO notice(no_no, mem_no, no_title, no_write, no_rdate, no_qna_cnt, no_qna_contents, no_visible)
VALUES(1, '111', '공지사항1', '관리자1', sysdate, 0, '첨부 파일', 'Y');

INSERT INTO notice(no_no, mem_no, no_title, no_write, no_rdate, no_qna_cnt, no_qna_contents, no_visible)
VALUES(2, '111','공지사항2', '관리자1', sysdate, 0, '첨부 파일', 'Y');

INSERT INTO notice(no_no, mem_no, no_title, no_write, no_rdate, no_qna_cnt, no_qna_contents, no_visible)
VALUES(3, '111', '공지사항3', '관리자2', sysdate, 0, '첨부 파일', 'Y');



4. 목록
SELECT no_no, mem_no, no_title, no_write, no_rdate, no_qna_cnt, no_qna_contents, no_visible
FROM notice
ORDER BY no_no ASC;

 no_no  mem_no   no_title     no_write         no_rdate                   no_qna_cnt      no_qna_contents    no_visible
 --------  -------- --------- ----- ---------------------------  ------------- ---------- ----------
        1   111     공지사항1 관리자1   2017-08-21 12:14:50.0         0           내용      Y
        2   111     공지사항2 관리자1   2017-08-21 12:15:28.0         0           내용      Y
        3   112     공지사항3 관리자2   2017-08-21 12:15:45.0         0           내용      Y


-- 하나의 컬럼이 아니라 레코드 전체의 순서가 이동됨.        
SELECT no_no, mem_no, no_title, no_write, no_rdate, no_qna_cnt, no_qna_contents no_visible
FROM notice
ORDER BY no_no DESC; 

 no_no  mem_no   no_title     no_write         no_rdate                   no_qna_cnt      no_qna_contents    no_visible
 --------  -------- --------- ----- ---------------------------  ------------- ---------- ----------
        3   112     공지사항3 관리자2   2017-08-21 12:15:45.0         0           내용      Y
        2   111     공지사항2 관리자1   2017-08-21 12:15:28.0         0           내용      Y
        1   111     공지사항1 관리자1   2017-08-21 12:14:50.0         0           내용      Y

 
5. 조회
SELECT no_no, mem_no, no_title, no_write, no_rdate, no_qna_cnt, no_qna_contents, no_visible
FROM notice
WHERE no_no = 1;

 no_no  mem_no   no_title     no_write         no_rdate                   no_qna_cnt      no_qna_contents    no_visible
 --------  -------- --------- ----- ---------------------------  ------------- ---------- ----------
        1   111     공지사항1 관리자1   2017-08-21 12:14:50.0         0           내용      Y

6. 수정
1) 모든 레코드 수정(주의)
UPDATE notice
SET no_title='공지사항1', no_write = '관리자1';

 no_no  mem_no   no_title     no_write         no_rdate                   no_qna_cnt      no_qna_contents    no_visible
 --------  -------- --------- ----- ---------------------------  ------------- ---------- ----------
        1   111     공지사항1 관리자1   2017-08-21 12:14:50.0         0           내용      Y
        1   111     공지사항1 관리자1   2017-08-21 12:14:50.0         0           내용      Y
        1   111     공지사항1 관리자1   2017-08-21 12:14:50.0         0           내용      Y

2) 1번 레코드만 수정(권장)
UPDATE notice
SET no_title='공지 변경1'
WHERE no_no = 1;

SELECT no_no, mem_no, no_title, no_write, no_rdate, no_qna_cnt, no_qna_contents, no_visible
FROM notice
WHERE no_no = 1;

 no_no  mem_no   no_title     no_write         no_rdate                   no_qna_cnt      no_qna_contents    no_visible
 --------  -------- ---------  ----- ---------------------------  ------------- ---------- ----------
        1   111     공지 변경1  관리자1   2017-08-21 12:14:50.0         0           내용      Y        
7. 삭제
1) 하나의 레코드만 삭제(권장)
DELETE FROM notice
WHERE no_no = 1;

SELECT no_no, mem_no, no_title, no_write, no_rdate, no_qna_cnt, no_qna_contents, no_visible
FROM notice
ORDER BY no_no ASC;

 no_no  mem_no   no_title     no_write         no_rdate                   no_qna_cnt      no_qna_contents    no_visible
 --------  -------- ---------  ----- ---------------------------  ------------- ---------- ----------
        3   112     공지사항3 관리자2   2017-08-21 12:15:45.0         0           내용      Y
        2   111     공지사항2 관리자1   2017-08-21 12:15:28.0         0           내용      Y

2) 모든 레코드 삭제(주의)        
DELETE FROM notice;

3) 레코드 갯수
SELECT no_qna_cnt(*) as qna_cnt
FROM notice;

 qna_cnt
 ---
   0
 
 
 
 
========================================================
========================================================

