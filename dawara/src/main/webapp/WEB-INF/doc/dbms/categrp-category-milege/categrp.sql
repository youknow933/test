
0. 테이블 삭제
DROP TABLE categrp;
 
1. 테이블 생성
CREATE TABLE categrp( 
    grp_no                NUMBER(10)    NOT NULL     PRIMARY KEY,
    grp_classification    NUMBER(1)     DEFAULT 1    NOT NULL,
    grp_title             VARCHAR2(50)  NOT NULL,
    grp_seqno             NUMBER(7)     DEFAULT 0    NOT NULL,
    grp_visible           CHAR(1)       DEFAULT 'Y'  NOT NULL,
    grp_rdate             DATE                       NOT NULL,
    mem_no                NUMBER(6)                  NULL,
    FOREIGN KEY (mem_no)  REFERENCES MEMBER (mem_no)
); 

COMMENT ON TABLE categrp is '카테고리 그룹';
COMMENT ON COLUMN categrp.grp_no is '카테고리 그룹 번호';
COMMENT ON COLUMN categrp.grp_classification is '카테고리 그룹 분류';
COMMENT ON COLUMN categrp.grp_title is '그룹 이름';
COMMENT ON COLUMN categrp.grp_seqno   is '출력 순서';
COMMENT ON COLUMN categrp.grp_visible is '출력 모드';
COMMENT ON COLUMN categrp.grp_rdate is '그룹 생성일';
COMMENT ON COLUMN categrp.mem_no is '회원 번호';
  
2. 등록(INSERT)
- grp_classification: 1-SAMSUNG, 2-LG, 3-APPLE, 4-HP
- grp_visible: Y, N

INSERT INTO categrp(grp_no, grp_classification, grp_title, grp_seqno, grp_visible, grp_rdate)
VALUES(1, 1, 'SAMSUNG올웨이즈9', 1, 'Y', sysdate);

3. 삭제(DELETE)
DELETE FROM categrp;

4. 그룹번호의 자동 생성
INSERT INTO categrp(grp_no, grp_classification, grp_title, grp_seqno, grp_visible, grp_rdate)
VALUES((SELECT NVL(MAX(grp_no), 0) + 1 as grp_no FROM categrp), 1, '노트북', 1, 'Y', sysdate);

INSERT INTO categrp(grp_no, grp_classification, grp_title, grp_seqno, grp_visible, grp_rdate)
VALUES((SELECT NVL(MAX(grp_no), 0) + 1 as grp_no FROM categrp), 2, 'LG', 1, 'Y', sysdate);

INSERT INTO categrp(grp_no, grp_classification, grp_title, grp_seqno, grp_visible, grp_rdate)
VALUES((SELECT NVL(MAX(grp_no), 0) + 1 as grp_no FROM categrp), 3, 'APPLE', 1, 'Y', sysdate);

5. 목록(SELECT)
SELECT grp_no, grp_classification, grp_title, grp_seqno, grp_visible, grp_rdate 
FROM categrp
ORDER BY grp_no ASC; 

6. 조회
SELECT grp_no, grp_classification, grp_title, grp_seqno, grp_visible, grp_rdate 
FROM categrp
WHERE grp_no = 1;
  
7. 수정(UPDATE)
UPDATE categrp
SET grp_classification=1, grp_title='삼성올웨이즈9', grp_seqno = 1, grp_visible='Y'
WHERE grp_no = 1;

8. 그룹번호별 삭제(grp_no DELETE)
DELETE FROM categrp
WHERE grp_no = 1;

9. 검색(%: 없거나 하나 이상의 모든 문자)
-- word LIKE '스프링' → word = '스프링'
   ^스프링$
-- word LIKE '%스프링' → word = '잊지 못할 스프링'
   .*스프링$
-- word LIKE '스프링%' → word = '스프링에서~'
   ^스프링.*
-- word LIKE '%스프링%' → word = '유럽 여행은 스프링 꼭 방문해야~'
   .*스프링.*
   
SELECT grp_no, grp_classification, grp_title, grp_seqno, grp_visible, grp_rdate 
FROM grp_no=1 AND word LIKE '%삼성%'
ORDER BY grp_no ASC;
         
10. 페이징
SELECT grp_no, grp_classification, grp_title, grp_seqno, grp_visible, grp_rdate 
FROM(
         SELECT grp_no, grp_classification, grp_title, grp_seqno, grp_visible, grp_rdate as r
         FROM(
                  SELECT grp_no, grp_classification, grp_title, grp_seqno, grp_visible, grp_rdate 
                  FROM categrp
                  WHERE grp_no=1
                  ORDER BY grp_no DESC
         )
)
WHERE r >=1 AND r <= 3;

-- 검색        
SELECT sellno, ncategoryno, title, content, thumbs, files, sizes, cnt,
          replycnt, grp_rdate, word, r
FROM(
         SELECT sellno, ncategoryno, title, content,  thumbs, files, sizes, cnt,
                   replycnt, grp_rdate, word, rownum as r
         FROM(
                  SELECT sellno, ncategoryno, title, content, thumbs, files, sizes, cnt,
                            replycnt, grp_rdate, word
                  FROM sell
                  WHERE ncategoryno=1 AND word LIKE '%스프링%'
                  ORDER BY sellno DESC
         )
)
WHERE r >=1 AND r <= 3;

 SELLNO NCATEGORYNO TITLE CONTENT THUMBS       FILES       SIZES CNT REPLYCNT grp_rdate                 WORD                     R
 ------ ----------- ----- ------- ------------ ----------- ----- --- -------- --------------------- ------------------------ -
      3           1 제목    내용      summber.jpg  summber.jpg 0       0        0 2018-06-08 16:21:23.0 스프링,spring,봄,春,계절,냉이,개나리 1
      2           1 제목    내용      spring_m.jpg spring.jpg  0       0        0 2018-06-08 16:21:22.0 스프링,spring,봄,春,계절,냉이,개나리 2


