0. 테이블 삭제
DROP TABLE categrp;

부모테이블 강제삭제
DROP TABLE categrp CASCADE CONSTRAINTS; 
DROP TABLE category CASCADE CONSTRAINTS; 
DROP TABLE member CASCADE CONSTRAINTS; 
DROP TABLE surf CASCADE CONSTRAINTS; 

CREATE TABLE member (
  mem_no       NUMBER(6) NOT NULL, -- 회원 번호, 레코드를 구분하는 컬럼 
  PRIMARY KEY (mem_no)                  -- 한번 등록된 값은 중복 안됨
);  

CREATE TABLE categrp (
  categrpno       NUMBER(6) NOT NULL, -- 회원 번호, 레코드를 구분하는 컬럼 
  PRIMARY KEY (categrpno)                  -- 한번 등록된 값은 중복 안됨
);

DROP TABLE categrp;
DROP TABLE member;

SELECT * FROM member;
SELECT * FROM categrp;

DELETE FROM categrp
where categrpno =4;

1. 테이블 생성
CREATE TABLE category(
  categoryno        NUMBER(7)                                NOT NULL,
  categrpno         NUMBER(10)                               NOT NULL ,
  ntitle          VARCHAR2(50)                            NOT NULL,
  nseqno               NUMBER(3)        DEFAULT 1         NOT NULL,
  nvisible               CHAR(1)            DEFAULT 'Y'        NOT NULL,
  nids                    VARCHAR2(100)                          NULL,
  rdate                  DATE                                          NOT NULL,
  PRIMARY KEY(categoryno),
  FOREIGN KEY (categrpno) REFERENCES categrp (categrpno)
);

DROP TABLE category;
DROP TABLE buysell;
DROP TABLE reply;

COMMENT ON TABLE category is '카테고리';
COMMENT ON COLUMN category.categoryno is '카테고리 번호';
COMMENT ON COLUMN category.categrpno is '카테고리 그룹 번호';
COMMENT ON COLUMN category.ntitle is '게시판 이름';
COMMENT ON COLUMN category.nseqno is '출력 순서';
COMMENT ON COLUMN category.nvisible is '출력 모드';
COMMENT ON COLUMN category.nids is '접근 계정';
COMMENT ON COLUMN category.cnt is '등록된 글 수';
COMMENT ON COLUMN category.rdate is '등록일';

임시 parent key

INSERT INTO member(mem_no) VALUES(1);
INSERT INTO member(mem_no) VALUES(2);
INSERT INTO member(mem_no) VALUES(3);

INSERT INTO categrp(categrpno) VALUES(1);
INSERT INTO categrp(categrpno) VALUES(2);
INSERT INTO categrp(categrpno) VALUES(3);

2. 등록(INSERT)
INSERT INTO category(categoryno, categrpno, mem_no, ntitle, nseqno, nvisible, nids, rdate)
VALUES((SELECT NVL(MAX(categoryno), 0)+1 as categoryno FROM category), 1, 1, '삼성', 1, 'Y', 'ad', sysdate);

INSERT INTO category(categoryno, categrpno, mem_no, ntitle, nseqno, nvisible, nids, rdate)
VALUES((SELECT NVL(MAX(categoryno), 0)+1 as categoryno FROM category), 2, 2, '현대', 1, 'Y', 'ad', sysdate);

INSERT INTO category(categoryno, categrpno, mem_no, ntitle, nseqno, nvisible, nids, rdate)
VALUES((SELECT NVL(MAX(categoryno), 0)+1 as categoryno FROM category), 3, 3, 'LG', 1, 'Y', 'ad', sysdate);

3. 목록(SELECT)
SELECT categoryno, categrpno, ntitle, nseqno, nvisible, nids, rdate
FROM category  
ORDER BY categrpno ASC, nseqno ASC;

4. 조회
SELECT categoryno, categrpno, ntitle, nseqno, nvisible, nids
FROM category 
WHERE categoryno=1;

5. 수정(UPDATE)
UPDATE category
SET ntitle='변경', nseqno=1, nvisible='N', nids='admin1/user1/user2'
WHERE categoryno=1;
   
6. 카테고리번호별 삭제(DELETE)
DELETE FROM category
WHERE categrpno = 7;

