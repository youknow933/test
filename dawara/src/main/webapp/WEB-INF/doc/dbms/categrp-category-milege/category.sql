0. 테이블 삭제
DROP TABLE categrp;

부모테이블 강제삭제
DROP TABLE categrp CASCADE CONSTRAINTS; 
DROP TABLE category CASCADE CONSTRAINTS; 
DROP TABLE member CASCADE CONSTRAINTS; 
DROP TABLE surf CASCADE CONSTRAINTS; 

DROP TABLE category;
 
1. 테이블 생성
CREATE TABLE category(
  gory_no        NUMBER(7)                   NOT NULL PRIMARY KEY,
  grp_no         NUMBER(10)                  NOT NULL ,
  gory_title     VARCHAR2(50)                NOT NULL,
  gory_seqno     NUMBER(3)      DEFAULT 1    NOT NULL,
  gory_visible   CHAR(1)        DEFAULT 'Y'  NOT NULL,
  gory_ids       VARCHAR2(100)               NULL,
  gory_rdate     DATE                        NOT NULL,
	mem_no                NUMBER(6)                  NULL,
	FOREIGN KEY (mem_no)  REFERENCES MEMBER (mem_no),
  FOREIGN KEY (grp_no) REFERENCES categrp (grp_no)
);

COMMENT ON TABLE category is '카테고리';
COMMENT ON COLUMN category.gory_no is '카테고리 번호';
COMMENT ON COLUMN category.grp_no is '카테고리 그룹 번호';
COMMENT ON COLUMN category.gory_title is '게시판 이름';
COMMENT ON COLUMN category.gory_seqno is '출력 순서';          
COMMENT ON COLUMN category.gory_visible is '출력 모드';
COMMENT ON COLUMN category.gory_ids is '접근 계정';
COMMENT ON COLUMN category.gory_rdate is '등록일';
COMMENT ON COLUMN category.mem_no is '회원 번호';


alter table category rename column gory_gory_rdate to gory_rdate;

임시 parent key

INSERT INTO member(mem_no) VALUES(1);
INSERT INTO member(mem_no) VALUES(2);
INSERT INTO member(mem_no) VALUES(3);

INSERT INTO categrp(grp_no) VALUES(1);
INSERT INTO categrp(grp_no) VALUES(2);
INSERT INTO categrp(grp_no) VALUES(3);

2. 등록(INSERT)
INSERT INTO category(gory_no, grp_no, gory_title, gory_seqno, gory_visible, gory_ids, gory_rdate)
VALUES((SELECT NVL(MAX(gory_no), 0)+1 as gory_no FROM category), 1,  '삼성', 1, 'Y', 
      (SELECT mem_id from member where mem_no = 1), sysdate);

INSERT INTO category(gory_no, grp_no, gory_title, gory_seqno, gory_visible, gory_ids, gory_rdate)
VALUES((SELECT NVL(MAX(gory_no), 0)+1 as gory_no FROM category), 1,  'LG', 1, 'Y', 'ad', sysdate);

INSERT INTO category(gory_no, grp_no, gory_title, gory_seqno, gory_visible, gory_ids, gory_rdate)
VALUES((SELECT NVL(MAX(gory_no), 0)+1 as gory_no FROM category), 1,  'APPLE', 1, 'Y', 'ad', sysdate);

INSERT INTO category(gory_no, grp_no, gory_title, gory_seqno, gory_ids, gory_rdate)
VALUES((SELECT NVL(MAX(gory_no), 0)+1 as gory_no FROM category),
            1, '삼성', 1, (select mem_id from member where mem_no = 2), sysdate)

3. 목록(SELECT)
SELECT gory_no, grp_no, gory_title, gory_seqno, gory_visible, gory_ids, gory_rdate
FROM category  
ORDER BY grp_no ASC, gory_seqno ASC;

4. 조회
SELECT gory_no, grp_no, gory_title, gory_seqno, gory_visible, gory_ids
FROM category 
WHERE gory_no=1;

5. 수정(UPDATE)
UPDATE category
SET gory_title='변경', gory_seqno=1, gory_visible='N', gory_ids='admin1/user1/user2'
WHERE gory_no=1;
   
6. 카테고리번호별 삭제(DELETE)
DELETE FROM category
WHERE grp_no = 7;

