1. 공지사항 notice 테이블 구조 
-----------------------------------------------------------------------------------
1. notice 테이블 생성

CREATE TABLE notice(
  no_no     NUMBER(10)                                NOT NULL,
  mem_no     NUMBER(10)                                NOT NULL,
  no_title        VARCHAR(100)                                NOT NULL,
  no_write      VARCHAR(15)                                 NOT NULL,
  no_rdate       DATE                                           NOT NULL,
  no_cnt        NUMBER(10)        DEFAULT 0           NOT NULL,
  no_contents    VARCHAR(4000)                             NOT NULL,
  no_visible     CHAR(1)          DEFAULT 'Y'          NOT NULL,
  no_seqno        NUMBER(10)       DEFAULT 0 NOT NULL,
  no_files        VARCHAR(1000)                            NULL ,
  no_sizes        VARCHAR(1000)                            NULL ,
  no_thumbs        VARCHAR(1000)                            NULL ,
  --indent        NUMBER(2)       DEFAULT 0           NOT NULL,
  --ansnum        NUMBER(5)     DEFAULT 0           NOT NULL ,
  word        VARCHAR2(100) NULL,
  PRIMARY KEY(no_no),
  FOREIGN KEY(mem_no) REFERENCES member(mem_no)
);
COMMENT ON COLUMN notice.no_no IS '공지 글 번호';
COMMENT ON COLUMN notice.mem_no IS '관리자 번호';
COMMENT ON COLUMN notice.no_title IS '제목';
COMMENT ON COLUMN notice.no_write IS '글쓴이';
COMMENT ON COLUMN notice.no_rdate IS '등록일';
COMMENT ON COLUMN notice.no_cnt IS '조회수';
COMMENT ON COLUMN notice.no_contents IS '내용';
COMMENT ON COLUMN notice.no_visible IS '공개 여부';
COMMENT ON COLUMN notice.no_files IS '파일';
COMMENT ON COLUMN notice.no_sizes IS '파일크기';
COMMENT ON COLUMN notice.no_thumbs IS '썸네일파일';
--COMMENT ON COLUMN notice.indent IS '인덴트';
--COMMENT ON COLUMN notice.ansnum IS '답변 번호';
COMMENT ON COLUMN notice.word IS '검색어';

ALTER TABLE notice add(no_files VARCHAR(1000));
ALTER TABLE notice add(no_sizes VARCHAR(1000));
ALTER TABLE notice add(no_thumbs VARCHAR(1000));
--ALTER TABLE notice add(indent NUMBER(2) DEFAULT 0 NOT NULL);
--ALTER TABLE notice add(ansnum NUMBER(5) DEFAULT 0 NOT NULL);
ALTER TABLE notice add(word VARCHAR2(100) NULL);

SELECT * FROM notice;
   
SELECT no_no, mem_no, no_title, no_write, no_rdate, no_cnt, no_contents, no_visible, no_seqno, no_files, no_sizes, no_thumbs, word
FROM notice 
WHERE mem_no=1

2. 테이블 삭제
DROP TABLE notice;


3. 등록
-- 공지사항 글 번호, 출력 순서는 자동 증가
-- mem_no 멤버 번호

-- 답변 등록 x 
INSERT INTO notice(no_no, mem_no, no_title, no_contents, no_write, no_rdate,  no_files, no_sizes, no_thumbs, word)
VALUES((SELECT NVL(MAX(no_no), 0)+1 AS no_no FROM notice), 1, '로그인 가정 제목555', '로그인 가정 내용111', '관리자1', sysdate, '파일', '파일 크기', '썸네일', '검색어');



-- 답변 등록 구현 시 사용
INSERT INTO notice(no_no, mem_no, no_title, no_contents, no_write, no_rdate,  no_files, no_sizes, no_thumbs, indent, ansnum, word)
VALUES((SELECT NVL(MAX(no_no), 0)+1 AS no_no FROM notice), 1, '로그인 가정 제목555', '로그인 가정 내용111', '관리자1', sysdate, '파일', '파일 크기', '썸네일', 0, 0, '검색어');



INSERT INTO notice(no_no, mem_no, no_title, no_contents, no_write, no_rdate)
VALUES((SELECT NVL(MAX(no_no), 0)+1 AS no_no FROM notice), 1, '로그인 가정 제목555', '로그인 가정 내용111', '관리자1', sysdate);

INSERT INTO notice(no_no, mem_no, no_title, no_write, no_rdate, no_cnt, no_contents, no_visible, no_seqno)
VALUES((SELECT NVL(MAX(no_no), 0)+1 AS no_no FROM notice), 1, '공지사항1', '관리자1', sysdate, 0, '첨부 파일', 'Y', (SELECT NVL(MAX(no_seqno), 0)+1 AS no_seqno FROM notice));

INSERT INTO notice(no_no, mem_no, no_title, no_write, no_rdate, no_cnt, no_contents, no_visible, no_seqno)
VALUES((SELECT NVL(MAX(no_no), 0)+1 AS no_no FROM notice), 1, '공지사항2', '관리자1', sysdate, 0, '첨부 파일', 'Y', (SELECT NVL(MAX(no_seqno), 0)+1 AS no_seqno FROM notice));

INSERT INTO notice(no_no, mem_no, no_title, no_write, no_rdate, no_cnt, no_contents, no_visible, no_seqno)
VALUES((SELECT NVL(MAX(no_no), 0)+1 AS no_no FROM notice), 2, '공지사항3', '관리자2', sysdate, 0, '첨부 파일', 'Y', (SELECT NVL(MAX(no_seqno), 0)+1 AS no_seqno FROM notice));




4. 목록
SELECT no_no, mem_no, no_title, no_write, no_rdate, no_cnt, no_contents, no_visible, no_seqno, no_files, no_sizes, no_thumbs, word
FROM notice
ORDER BY no_no ASC;

 no_no  mem_no   no_title     no_write         no_rdate                   no_cnt      no_contents    no_visible    no_seqno
 --------  -------- --------- ----- ---------------------------  ------------- ---------- ----------
        1   1     공지사항1 관리자1   2017-08-21 12:14:50.0         0           내용      Y      1
        2   1     공지사항2 관리자1   2017-08-21 12:15:28.0         0           내용      Y      2
        3   2     공지사항3 관리자2   2017-08-21 12:15:45.0         0           내용      Y      3


-- 하나의 컬럼이 아니라 레코드 전체의 순서가 이동됨.        
SELECT no_no, mem_no, no_title, no_write, no_rdate, no_cnt, no_contents no_visible, no_seqno, no_files, no_sizes, no_thumbs, word
FROM notice
ORDER BY no_no DESC; 

 no_no  mem_no   no_title     no_write         no_rdate                   no_cnt      no_contents    no_visible    no_seqno
 --------  -------- --------- ----- ---------------------------  ------------- ---------- ----------
        3   2     공지사항3 관리자2   2017-08-21 12:15:45.0         0           내용      Y      3
        2   1     공지사항2 관리자1   2017-08-21 12:15:28.0         0           내용      Y      2
        1   1     공지사항1 관리자1   2017-08-21 12:14:50.0         0           내용      Y      1

 
5. 조회
SELECT no_no, mem_no, no_title, no_write, no_rdate, no_cnt, no_contents, no_visible, no_seqno, no_files, no_sizes, no_thumbs, word
FROM notice
WHERE no_no = 1;

 no_no  mem_no   no_title     no_write         no_rdate                   no_cnt      no_contents    no_visible       no_seqno
 --------  -------- --------- ----- ---------------------------  ------------- ---------- ----------
        1   1     공지사항1 관리자1   2017-08-21 12:14:50.0         0           내용      Y            1

6. 수정
1) 모든 레코드 수정(주의)
UPDATE notice
SET no_title='공지사항1', no_write = '관리자1';

 no_no  mem_no   no_title     no_write         no_rdate                   no_cnt      no_contents    no_visible      no_seqno
 --------  -------- --------- ----- ---------------------------  ------------- ---------- ----------
        1   1     공지사항1 관리자1   2017-08-21 12:14:50.0         0           내용      Y        1
        1   1     공지사항1 관리자1   2017-08-21 12:14:50.0         0           내용      Y        2
        1   1     공지사항1 관리자1   2017-08-21 12:14:50.0         0           내용      Y        3

2) 1번 레코드만 수정(권장)
UPDATE notice
SET no_title='공지 변경123', no_contents='내용 변경1', no_visible='N'
WHERE no_no = 1;

SELECT no_no, mem_no, no_title, no_write, no_rdate, no_cnt, no_contents, no_visible, no_seqno, no_files, no_sizes, no_thumbs, word
FROM notice
WHERE no_no = 1;

 no_no  mem_no   no_title     no_write         no_rdate                   no_cnt      no_contents    no_visible       no_seqno
 --------  -------- ---------  ----- ---------------------------  ------------- ---------- ----------
        1   1     공지 변경123  관리자1   2017-08-21 12:14:50.0         0           내용      Y           1        
7. 삭제
-- 전체 삭제
DELETE FROM notice;



SELECT * FROM notice

-- 이미지 하나 삭제 (삭제한 파일을 제외하고, 다시 읽어들여서 업데이트 해야 해 18.07.06.)
    UPDATE notice
    SET no_files=NULL, no_sizes=NULL, no_thumbs=NULL
    WHERE no_no=4 AND no_files='0_coffee01.jpg' AND no_sizes='11325' AND no_thumbs='0_coffee01_t.jpg'

    
-- '삭제'버튼 클릭 시 첨부한 것 지우기..
    UPDATE notice
    SET no_files=NULL, no_sizes=NULL, no_thumbs=NULL
    WHERE no_no=4
    

1) 하나의 레코드만 삭제(권장)
DELETE FROM notice
WHERE no_no = 1;

SELECT no_no, mem_no, no_title, no_write, no_rdate, no_cnt, no_contents, no_visible, no_seqno, no_files, no_sizes, no_thumbs, word
FROM notice
ORDER BY no_no ASC;

 no_no  mem_no   no_title     no_write         no_rdate                   no_cnt      no_contents    no_visible
 --------  -------- ---------  ----- ---------------------------  ------------- ---------- ----------
        3   2     공지사항3 관리자2   2017-08-21 12:15:45.0         0           내용      Y
        2   1     공지사항2 관리자1   2017-08-21 12:15:28.0         0           내용      Y

2) 모든 레코드 삭제(주의)        
DELETE FROM notice;

3) 레코드 갯수
SELECT no_cnt(*) as qna_cnt
FROM notice;

 qna_cnt
 ---
   0
 
