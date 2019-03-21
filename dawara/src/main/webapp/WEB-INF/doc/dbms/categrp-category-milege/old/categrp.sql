
0. 테이블 삭제
DROP TABLE categrp;
 
1. 테이블 생성
CREATE TABLE categrp( 
    categrpno                       NUMBER(10)     NOT NULL    PRIMARY KEY,
    nclassification                     NUMBER(1)    DEFAULT 1     NOT NULL,
    categrptitle                                  VARCHAR2(50)     NOT NULL,
    nseqno                               NUMBER(7)    DEFAULT 0     NOT NULL,
    nvisible                              CHAR(1)    DEFAULT 'Y'     NOT NULL,
    rdate                                DATE     NOT NULL,
    mem_no                 NUMBER(6)                                 NULL,
    FOREIGN KEY (mem_no) REFERENCES MEMBER (mem_no)
); 

COMMENT ON TABLE categrp is '카테고리 그룹';
COMMENT ON COLUMN categrp.categrpno is '카테고리 그룹 번호';
COMMENT ON COLUMN categrp.nclassification is '카테고리 그룹 분류';
COMMENT ON COLUMN categrp.categrptitle is '그룹 이름';
COMMENT ON COLUMN categrp.nseqno is '출력 순서';
COMMENT ON COLUMN categrp.nvisible is '출력 모드';
COMMENT ON COLUMN categrp.rdate is '그룹 생성일';
COMMENT ON COLUMN categrp.mem_no is '회원 번호';
  
2. 등록(INSERT)
- nclassification: 1-SAMSUNG, 2-LG, 3-APPLE, 4-HP
- nvisible: Y, N

INSERT INTO categrp(categrpno, nclassification, categrptitle, nseqno, nvisible, rdate)
VALUES(1, 1, 'SAMSUNG올웨이즈9', 1, 'Y', sysdate);

3. 삭제(DELETE)
DELETE FROM categrp;

4. 그룹번호의 자동 생성
INSERT INTO categrp(categrpno, nclassification, categrptitle, nseqno, nvisible, rdate, mem_no)
VALUES((SELECT NVL(MAX(categrpno), 0) + 1 as categrpno FROM categrp), 1, '삼성올웨이즈9', 1, 'Y', sysdate, '1');

INSERT INTO categrp(categrpno, nclassification, categrptitle, nseqno, nvisible, rdate)
VALUES((SELECT NVL(MAX(categrpno), 0) + 1 as categrpno FROM categrp), 2, '삼성올웨이즈9', 1, 'Y', sysdate);

INSERT INTO categrp(categrpno, nclassification, categrptitle, nseqno, nvisible, rdate)
VALUES((SELECT NVL(MAX(categrpno), 0) + 1 as categrpno FROM categrp), 3, '삼성올웨이즈9', 1, 'Y', sysdate);

5. 목록(SELECT)
SELECT categrpno, nclassification, categrptitle, nseqno, nvisible, rdate 
FROM categrp
ORDER BY categrpno ASC; 

6. 조회
SELECT categrpno, nclassification, categrptitle, nseqno, nvisible, rdate 
FROM categrp
WHERE categrpno = 1;
  
7. 수정(UPDATE)
UPDATE categrp
SET nclassification=1, categrptitle='삼성올웨이즈9', nseqno = 1, nvisible='Y'
WHERE categrpno = 1;

8. 그룹번호별 삭제(CATEGRPNO DELETE)
DELETE FROM categrp
WHERE categrpno = 1;

9. 검색(%: 없거나 하나 이상의 모든 문자)
-- word LIKE '스프링' → word = '스프링'
   ^스프링$
-- word LIKE '%스프링' → word = '잊지 못할 스프링'
   .*스프링$
-- word LIKE '스프링%' → word = '스프링에서~'
   ^스프링.*
-- word LIKE '%스프링%' → word = '유럽 여행은 스프링 꼭 방문해야~'
   .*스프링.*
   
SELECT categrpno, nclassification, categrptitle, nseqno, nvisible, rdate 
FROM categrp=1 AND word LIKE '%삼성%'
ORDER BY categrpno ASC;
         
10. 페이징
SELECT categrpno, nclassification, categrptitle, nseqno, nvisible, rdate 
FROM(
         SELECT categrpno, nclassification, categrptitle, nseqno, nvisible, rdate as r
         FROM(
                  SELECT categrpno, nclassification, categrptitle, nseqno, nvisible, rdate 
                  FROM categrp
                  WHERE categrp=1
                  ORDER BY categrpno DESC
         )
)
WHERE r >=1 AND r <= 3;

-- 검색        
SELECT sellno, ncategoryno, title, content, thumbs, files, sizes, cnt,
          replycnt, rdate, word, r
FROM(
         SELECT sellno, ncategoryno, title, content,  thumbs, files, sizes, cnt,
                   replycnt, rdate, word, rownum as r
         FROM(
                  SELECT sellno, ncategoryno, title, content, thumbs, files, sizes, cnt,
                            replycnt, rdate, word
                  FROM sell
                  WHERE ncategoryno=1 AND word LIKE '%스프링%'
                  ORDER BY sellno DESC
         )
)
WHERE r >=1 AND r <= 3;

 SELLNO NCATEGORYNO TITLE CONTENT THUMBS       FILES       SIZES CNT REPLYCNT RDATE                 WORD                     R
 ------ ----------- ----- ------- ------------ ----------- ----- --- -------- --------------------- ------------------------ -
      3           1 제목    내용      summber.jpg  summber.jpg 0       0        0 2018-06-08 16:21:23.0 스프링,spring,봄,春,계절,냉이,개나리 1
      2           1 제목    내용      spring_m.jpg spring.jpg  0       0        0 2018-06-08 16:21:22.0 스프링,spring,봄,春,계절,냉이,개나리 2


